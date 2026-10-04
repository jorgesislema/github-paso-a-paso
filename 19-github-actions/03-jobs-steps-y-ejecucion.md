# Jobs, steps y ejecución

## Introducción

Un workflow no es una línea: es un grafo. Jobs que corren en paralelo, dependencias con `needs`, matrices que prueban varias combinaciones y artefactos que llevan resultados de una máquina a otra. Dominar esta anatomía es la diferencia entre un script que corre y una tubería profesional.

Este capítulo detalla cómo se organiza la ejecución: paralelismo y dependencias, matrices, artefactos, cachés y entornos — con ejemplos completos.

---

## Mapa conceptual de este capítulo

```text
Jobs, steps y ejecución
       │
       ├── 1. Jobs: paralelismo y dependencias
       ├── 2. Steps dentro de un job
       ├── 3. Matrices (matrix)
       ├── 4. Artefactos, cachés y entornos
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Jobs: paralelismo y dependencias

```yaml
jobs:
  lint:                       # arranca solo
    runs-on: ubuntu-latest
    steps: [...]

  test:
    needs: lint               # espera a lint
    runs-on: ubuntu-latest
    steps: [...]

  build:
    needs: test
    runs-on: ubuntu-latest
    steps: [...]

  notificar:
    needs: [build]
    if: failure()             # o always()
    runs-on: ubuntu-latest
    steps: [...]
```

```text
REGLAS:
   │
   ├── sin `needs`: jobs en PARALELO (más rápido)
   │
   ├── con `needs`: dependencia; si el previo falla,
   │   el dependiente NO corre (salvo si/failure())
   │
   ├── cada job = su propia máquina (clean room):
   │   el filesystem NO se comparte → usa
   │   artefactos (punto 4)
   │
   └── `runs-on` por job: puedes mezclar windows/
       linux en el mismo workflow
```

```text
GRAFO COMÚN DE CI:
   │
   ├── paralelo: lint ∥ unit-tests ∥ build
   └── luego: e2e (needs: build) → informe (needs:
       todos, if: always())
```

---

## 2. Steps dentro de un job

```text
CARACTERÍSTICAS:
   │
   ├── los steps corren EN ORDEN en la misma máquina
   │   (comparten filesystem y env)
   │
   ├── step fallido → job fallido → se saltan los
   │   siguientes (salvo if: always() / failure())
   │
   └── outputs entre steps del mismo job: env o
       $GITHUB_OUTPUT (mención de sintaxis)
```

```yaml
steps:
  - uses: actions/checkout@v4
  - id: build
    run: echo "version=1.2.3" >> "$GITHUB_OUTPUT"
  - run: echo "la versión es ${{ steps.build.outputs.version }}"
  - name: Limpieza siempre
    if: always()
    run: echo "esto corre aunque falle"
```

```text
BUENAS PRÁCTICAS (repaso + nuevas):
   │
   ├── un step = una fase con `name:` (cap. 01)
   ├── `id:` cuando otro step necesita su output
   ├── acciones de terceros: versiones fijadas
   │   (cap. 05)
   └── comandos multi-línea con `run: |` y set -euo
       pipefail donde aplique (shell estricto)
```

---

## 3. Matrices (matrix)

```yaml
jobs:
  test:
    strategy:
      fail-fast: false          # no abortar el resto
      matrix:
        python: ['3.11', '3.12']
        so: [ubuntu-latest, windows-latest]
    runs-on: ${{ matrix.so }}
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: ${{ matrix.python }}
      - run: python -m pytest
```

```text
QUÉ PRODUCE:
   │
   ├── una ejecución POR COMBINACIÓN (4 aquí)
   │
   ├── `fail-fast: false` → ver todas las fallas
   │   (útil en compatibilidad)
   │
   └── `include`/`exclude` (mención): añadir o
       quitar combinaciones
```

```text
CUÁNDO USARLA:
   │
   ├── versiones de lenguaje/soportes oficiales
   ├── variantes de build reales
   │
   └── NO: multiplicar sin criterio (coste ×
       combinaciones — vigila el presupuesto)
```

```text
   │
   └── matriz + `fail-fast: false` es la respuesta a
       «¿en qué versiones funciona?» en vez de una
       sola que miente por promedio
```

---

## 4. Artefactos, cachés y entornos

```text
ARTEFACTOS (entre jobs y para descarga)
──────────────────────────────────────────────────────
  - uses: actions/upload-artifact@v4
    with:
      name: reporte-test
      path: reporte.xml

  # en otro job:
  - uses: actions/download-artifact@v4
    with:
      name: reporte-test
```

```text
CACHÉ (dependencias — velocidad)
──────────────────────────────────────────────────────
  - uses: actions/cache@v4
    with:
      path: ~/.npm
      key: npm-${{ hashFiles('package-lock.json') }}
      restore-keys: npm-
# muchos setups (setup-node/python) traen cache:
# true integrado (preferirlo)
```

```text
ENTORNOS (environments: staging, produccion)
──────────────────────────────────────────────────────
jobs:
  deploy-prod:
    environment: produccion
    runs-on: ubuntu-latest
    steps: [...]
```

```text
   │
   ├── environment permite: SECRETOS POR ENTORNO,
   │   reviewers (aprobación humana antes del deploy)
   │   y protección de ramas — la capa natural del
   │   «¿quién pulsa produccion?» (cap. 04)
   │
   └── artefactos para COMPARTIR; caché para
       ACELERAR; environments para CONTROLAR
```

```bash
# patrón típico: test genera informe → job de
# resumen lo descarga y lo sube como artifact:
#   test: produce coverage.xml
#   informe: needs: test, download-artifact,
#            upload-artifact / step summary
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: asumir que los jobs comparten archivos

**Qué ocurrió:** el job `test` generó `build/` y `deploy` dice «no existe».

**Por qué:** cada job = máquina nueva.

**Cómo comprobarlo:** estructura de steps y `needs`.

**Opciones:** upload-artifact en el primero + download en el segundo; o un solo job si no hace falta separar.

**Riesgos:** tiempo perdido con «funciona en mi cabeza».

**Solución:** filesystem por job + artefactos (punto 4).

**Cómo se evita:** revisar el grafo antes de repartir jobs.

---

### Error 2: `needs` que serializa lo que puede paralelizar

**Qué ocurrió:** CI de 12 minutos donde 9 son esperas innecesarias (lint espera a test, build espera a lint…).

**Por qué:** se encadenó por costumbre («un workflow, una línea»).

**Cómo comprobarlo:** duración de la ejecución vs. suma de steps.

**Opciones:** paralelizar (lint ∥ unit ∥ build) y encadenar solo lo que realmente depende.

**Riesgos:** PRs lentos (sección 19 cap. 01).

**Solución:** dependencias reales, no lineales (punto 1).

**Cómo se evita:** dibujar el grafo al diseñar el workflow.

---

### Error 3: `fail-fast` en matriz sin querer

**Qué ocurrió:** probando 3.11/3.12, falla 3.12 y se aborta 3.11 → no ves el alcance.

**Por qué:** fail-fast es true por defecto.

**Cómo comprobarlo:** ejecución: jobs cancelados.

**Opciones:** `strategy.fail-fast: false` para diagnóstico de compatibilidad.

**Riesgos:** perder información de fallos.

**Solución:** desactivar fail-fast cuando la matriz busca cobertura (punto 3).

**Cómo se evita:** valor explícito siempre (no dejar al default).

---

### Error 4: artefactos gigantes o con basura

**Qué ocurció:** uploads de cientos de MB (node_modules, .git) en cada ejecución.

**Por qué:** `path: .` por pereza.

**Cómo comprobarlo:** tamaño del artifact; duración del upload.

**Opciones:** subir SOLO lo que otro job necesita (informe, binario); .gitignore extendido si hace falta.

**Riesgos:** presupuesto y lentitud.

**Solución:** artefacto = producto del job (punto 4).

**Cómo se evita:** revisar `path` en la revisión del workflow.

---

### Error 5: caché que envejece mal (key pobre)

**Qué ocurrió:** la caché nunca se invalida (key fija) → dependencias viejas, fallos fantasma.

**Por qué:** key constante.

**Cómo comprobarlo:** ver hits/misses; comparar lockfile.

**Opciones:** key por `hashFiles('…lock')` + restore-keys; o `cache: true` de las setup-actions.

**Riesgos:** «anda en CI pero con lo viejo».

**Solución:** key derivada del lockfile (punto 4).

**Cómo se evita:** plantilla con patrón correcto.

---

### Error 6: deploy sin environment (secretos mezclados)

**Qué ocurrió:** un workflow con un único secreto `DEPLOY_TOKEN` desplegó a prod y a staging con lo mismo; cualquier PR con acceso al secreto podría.

**Por qué:** no se usaron environments.

**Cómo comprobarlo:** jobs: ¿`environment:`? ¿secretos globales?

**Opciones:** crear environments con secretos propios y reviewers en prod.

**Riesgos:** blast radius amplio (sección 20).

**Solución:** separación por environment (punto 4).

**Cómo se evita:** checklist de workflow de deploy.

---

## 6. Práctica guiada

### Objetivo

Construir un workflow en grafo: lint y test en paralelo, build dependiente, informe con artefacto.

### Paso 1: grafo

```text
lint ─┐
      ├─► build ─► informe
test ─┘
```

### Paso 2: workflow

```yaml
name: ci
on: [pull_request]
permissions:
  contents: read

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "lint ok" > lint.txt

  test:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        version: ['3.11', '3.12']
    steps:
      - uses: actions/checkout@v4
      - run: echo "test ${{ matrix.version }}" > test-${{ matrix.version }}.txt
      - uses: actions/upload-artifact@v4
        with:
          name: test-${{ matrix.version }}
          path: test-${{ matrix.version }}.txt

  build:
    needs: [lint, test]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: echo "build ok" > build.txt

  informe:
    needs: [build]
    if: always()
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
      - uses: actions/upload-artifact@v4
        with:
          name: informe
          path: .
```

### Paso 3: observa

1. Ejecución: lint y test (2 matrix) en paralelo → build → informe.
2. Descarga `informe` y comprueba los ficheros.

### Paso 4: rompe y observa

1. Pon `exit 1` en lint: `test` sigue (paralelo), `build` NO corre, `informe` sí (always()).

### Paso 5: mide

1. Anota duración total vs. suma de jobs: ¿cuánto ahorró el paralelismo?

### Resultado esperado

Grafo funcionando con dependencias, matriz, artefactos y `if: always()` en el informe.

### Conclusión esperada

El workflow es un grafo que se diseña: paralelo donde no depende, encadenado donde importa, artefactos para cruzar máquinas.

---

## 7. Nivel profesional + resumen

### 7.1. Patrones de ejecución avanzados

```text
   │
   ├── grafo mínimo: paralelizar lo barato,
   │   encadenar lo que depende, informe con
   │   always()
   │
   ├── matriz con fail-fast explícito y presupuesto
   │   (nº combinaciones × duración)
   │
   ├── artefactos por job con nombres versionados y
   │   TTL de retención (configuración del repo)
   │
   ├── caches por lockfile (o cache: true de las
   │   setup-actions)
   │
   ├── environments con reviewers para prod y
   │   secretos por entorno
   │
   └── reusable workflows (workflow_call) cuando el
       mismo grafo se repite en varios repos
       (mención — sección 22/25)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* los jobs corren en paralelo salvo `needs`; cada uno es una máquina limpia — los archivos se pasan con artefactos;
* los steps son ordenados dentro del job, con outputs (`GITHUB_OUTPUT`) e `if: always()/failure()`;
* las matrices multiplican combinaciones con `fail-fast` explícito;
* artefactos = compartir, caché = acelerar (key por lockfile), environments = controlar (secretos y aprobaciones por entorno);
* los errores típicos (filesystem asumido, cadena serial, fail-fast implícito, artifacts gigantes, caché vieja, deploy sin environment) se previenen con diseño del grafo;
* a nivel profesional: reusable workflows y presupuesto de matriz.

La idea principal es:

> **Diseña el grafo antes que el YAML: paralelo donde no hay dependencia, `needs` donde la hay, artefactos para cruzar máquinas y environments para no mezclar lo que no debe mezclarse.**

---

## Próximo paso

Ya sabes organizar la ejecución.

La siguiente pieza: datos y credenciales — variables, secretos y el token con el que corre todo.

Continúa con:

[`04-variables-y-secretos.md`](04-variables-y-secretos.md)
