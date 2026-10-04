# Tu primer workflow

## Introducción

GitHub Actions es el motor de automatización de GitHub: un evento (push, PR, tag, calendario) dispara un workflow que se ejecuta en una máquina virtual (*runner*) y hace lo que le pidas — instalar, testear, construir, publicar.

La pieza de configuración es un archivo YAML en `.github/workflows/`. Este capítulo construye tu primer workflow explicando su anatomía completa: eventos, trabajos, pasos y runners.

---

## Mapa conceptual de este capítulo

```text
Tu primer workflow
       │
       ├── 1. Cómo funciona Actions (el modelo)
       ├── 2. Anatomía de un archivo workflow
       ├── 3. Primer workflow: CI que verifica
       ├── 4. Leer la ejecución (logs, checks)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Cómo funciona Actions (el modelo)

```text
EVENTO → WORKFLOW → JOB → STEP → RESULTADO
──────────────────────────────────────────────────────
push a main
   └── workflow ci.yml (on: push)
         └── job "test" (runner: ubuntu-latest)
               ├── step: checkout del código
               ├── step: instalar dependencias
               ├── step: ejecutar tests
               └── step: subir reporte (si falla)
         → check verde/rojo en el commit/PR
```

```text
PIEZAS:
   │
   ├── workflow  → archivo YAML (qué pasa y cuándo)
   ├── evento    → trigger: push, pull_request,
   │   schedule, workflow_dispatch, release…
   ├── job       → conjunto de steps en una máquina;
   │   los jobs corren en PARALELO salvo `needs`
   ├── step     → comando o action (accion oficial o
   │   de terceros)
   ├── runner   → la máquina: ubuntu/windows/macos
   │   (o la tuya/self-hosted)
   └── artifact  → archivos que pasan entre jobs o se
       guardan (cap. 03)
```

```text
   │
   ├── cada ejecución deja registro: logs por step,
   │   duración y estado — ahí vive el diagnóstico
   │
   └── Actions usa un presupuesto mensual gratuito
       por repo/org (mención: planes — cuida la
       duración)
```

---

## 2. Anatomía de un archivo workflow

```yaml
# .github/workflows/ci.yml
name: CI                      # nombre visible

on:                           # eventos (cap. 02)
  push:
    branches: [main]
  pull_request:

permissions:                  # mínimo privilegio
  contents: read              # (cap. 04/05)

env:                          # variables de entorno
  NODE_ENV: test

jobs:                         # trabajos
  test:
    runs-on: ubuntu-latest    # runner
    steps:
      - uses: actions/checkout@v4      # paso: traer
      - name: Instalar dependencias    # código
        run: npm ci
      - name: Ejecutar tests
        run: npm test
```

```text
CLAVES QUE SIEMPRE ESTÁN:
   │
   ├── name · on · jobs · runs-on · steps
   ├── run: (shell)  vs  uses: (acción reutilizable)
   ├── name: (por step: legibilidad en logs)
   └── permissions: (implícito amplio si no lo pones
       — cap. 05)
```

```bash
# validar en local (si tienes gh + act u otra
# herramienta, mención) o simplemente: push de rama
# y mirar la pestaña Actions
```

---

## 3. Primer workflow: CI que verifica

```yaml
# .github/workflows/ci.yml
name: CI

on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: read

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Archivo de humo
        run: |
          echo "El workflow funciona"
          ls -la

      - name: Comprueba README
        run: test -f README.md

      - name: Falla si no hay LICENSE
        run: test -f LICENSE || (echo "Falta LICENSE" && exit 1)
```

```text
QUÉ DEMUESTRA:
   │
   ├── checkout: sin esto, el runner está vacío
   │   (el código vive en tu repo, no en la máquina)
   │
   ├── run: ejecuta comandos; cualquier exit != 0
   │   rompe el step → el job → la check
   │
   └── la check aparece en el PR: verde si todo pasó
```

```text
EVOLUCIÓN NATURAL (lo verás crecer):
   │
   ├── setup de lenguaje (setup-python@…, setup-
   │   node@…) — cap. 03
   ├── caché de dependencias (cap. 06)
   ├── matriz de versiones (cap. 03)
   └── artefactos y cobertura (cap. 03)
```

---

## 4. Leer la ejecución (logs, checks)

```text
DÓNDE MIRAR:
   │
   ├── pestaña Actions → lista de ejecuciones
   ├── ejecución → jobs → steps (expandir cada uno)
   └── en el PR: la check (verde/roja) abre el log
```

```text
LECTURA ÚTIL:
   │
   ├── step rojo: el log del step (el último
   │   comando y su salida)
   ├── duración por step: ¿qué es lento? (cap. 06)
   ├── «Re-run failed jobs»: reintentar sin repetir
   │   todo
   └── artefactos y summary del job (si el workflow
       los produce — cap. 03)
```

```text
DIAGNÓSTICO RÁPIDO:
   │
   ├── ¿falló en checkout? → permisos/rama borrada
   ├── ¿falló al instalar? → dependencias/versión
   ├── ¿falló test? → lee el test, no el runner
   └── ¿no aparece la check? → ¿el trigger cubre tu
       evento? (cap. 02)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: el workflow no se dispara

**Qué ocurrió:** push hecho, no aparece ejecución.

**Por qué posibles:**
* `on:` no cubre tu evento (p. ej. solo `push: branches: [dev]`);
* archivo mal ubicado (no es `.github/workflows/*.yml`);
* workflow con error de sintaxis (la pestaña Actions lo indica);
* repo con Actions deshabilitados.

**Cómo comprobarlo:** pestaña Actions (¿aparece el workflow?), rama y evento vs. `on:`.

**Opciones:** ampliar triggers (cap. 02); corregir ruta/YAML; habilitar Actions.

**Riesgos:** «el CI nunca corre» y todo pasa de largo.

**Solución:** trigger mínimo cubierto desde el primer día.

**Cómo se evita:** PR de prueba que debe mostrar check.

---

### Error 2: YAML que la plataforma rechaza

**Qué ocurrió:** error de sintaxis; el workflow ni se registra.

**Por qué posibles:**
* indentación mezclada (YAML es sensible);
* `:` sin espacio en valores; comillas mal cerradas.

**Cómo comprobarlo:** pestaña Actions muestra el error de parseo; o editor con linter YAML.

**Opciones:** corregir indentación (2 espacios, consistente); validar con linter local.

**Riesgos:** silencio total de la automatización.

**Solución:** YAML mínimo y linter.

**Cómo se evita:** plantilla de workflow probada (sección 18 cap. 02).

---

### Error 3: olvidar `actions/checkout`

**Qué ocurrió:** «no such file» en el primer `run` — el directorio está vacío.

**Por qué:** se asume que el runner tiene el código.

**Cómo comprobarlo:** log: `ls` vacío.

**Opciones:** añadir checkout como primer step.

**Riesgos:** confusión total con el primer workflow.

**Solución:** checkout siempre primero (punto 3).

**Cómo se evita:** plantilla.

---

### Error 4: CI roja que nadie interpreta (mensaje ilegible)

**Qué ocurrió:** el step falla con un stack gigante y nadie sabe qué paso.

**Por qué:** steps sin `name:` y comandos opacos.

**Cómo comprobarlo:** leer el log como si fueras nuevo.

**Opciones:** names claros; comandos pequeños; `::error::` para mensajes propios (mención de sintaxis de comandos del runner).

**Riesgos:** la CI se ignora → pierde protección (sección 18 cap. 03).

**Solución:** logs pensados para el que llega (punto 4).

**Cómo se evita:** revisar legibilidad al crear workflows.

---

### Error 5: ejecutar todo en un step gigante

**Qué ocurrió:** un solo `run: |` con 40 líneas: al fallar, no sabes dónde.

**Por qué:** ahorro de líneas.

**Cómo comprobarlo:** longitud del step; tiempo hasta el fallo.

**Opciones:** partir en steps con `name:` (instalar / test / lint).

**Riesgos:** diagnóstico lento.

**Solución:** un step = una fase (punto 2).

**Cómo se evita:** revisión de workflows como código.

---

### Error 6: workflow que tarda 20 minutos en un PR

**Qué ocurrió:** los revisores esperan la check más que la revisión.

**Por qué posibles:**
* sin caché de dependencias (cap. 06);
* trabajos que podrían paralelizarse;
* tests pesados en cada push.

**Cómo comprobarlo:** duración por step/job.

**Opciones:** caché, paralelizar jobs, filtrar por paths, correr lo pesado en main/schedule (cap. 02/06).

**Riesgos:** revisión lenta → PRs viejos (sección 15).

**Solución:** presupuesto de duración (p. ej. < 5-10 min en PR).

**Cómo se evita:** métrica de duración de CI en la retro (sección 26).

---

## 6. Práctica guiada

### Objetivo

Crear el primer CI, romperlo a propósito y leer sus logs.

### Paso 1: crea el archivo

1. En la rama principal o en una rama de práctica: `.github/workflows/ci.yml` con el contenido del punto 3.

### Paso 2: abre un PR

```bash
git switch -c chore/ci-inicial
git add .github/workflows/ci.yml
git commit -m "ci: workflow inicial de humo"
git push -u origin chore/ci-inicial
# → PR: aparece la check «test»
```

### Paso 3: lee el log

1. Abre la ejecución → job `test` → expande cada step con su `name`.

### Paso 4: rómpelo

```yaml
      - name: Falla a propósito
        run: exit 1
```

1. Push y observa: step rojo → job rojo → check roja en el PR.
2. Practica «Re-run failed jobs».

### Paso 5: arréglalo (y hazlo útil)

```yaml
      - name: Verifica estructura profesional
        run: |
          test -f README.md
          test -f CONTRIBUTING.md || echo "Aviso: falta CONTRIBUTING"
```

1. Vuelve a verde y comprueba la check exigida (sección 18 cap. 03).

### Paso 6: marca el requisito

1. En la protección de rama: exige esta check (si aún no lo está).

### Resultado esperado

CI corriendo en PR, rojo legible, verde exigido en la protección de main.

### Conclusión esperada

El primer workflow es una semilla: event → job → steps con nombre → check que protege — todo lo demás se añade encima.

---

## 7. Nivel profesional + resumen

### 7.1. CI como mínimo profesional

```text
CHECKLIST DE CI INICIAL
──────────────────────────────────────────────────────
[ ] on: pull_request + push a main
[ ] permissions: contents: read (o lo necesario)
[ ] checkout + setup del lenguaje (cap. 03)
[ ] steps con nombre y fases claras
[ ] check exigida en la protección de rama
[ ] versiones de actions fijadas (cap. 05)
[ ] duración observada y con techo
```

```text
   │
   ├── el workflow es código: se revisa en PR y se
   │   mantiene (sección 18 cap. 05)
   │
   └── lo que valida la CI es la primera línea de
       defensa de calidad (sección 15/17)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* Actions = evento → workflow → jobs → steps en runners, con artefactos para compartir entre jobs;
* el archivo vive en `.github/workflows/*.yml` y su esqueleto es `name/on/permissions/jobs/runs-on/steps`;
* el primer CI hace humo + verificaciones baratas y se convierte en check exigida;
* la lectura de logs por step es el diagnóstico; `Re-run failed jobs` para reintentar;
* los errores típicos (trigger ausente, YAML inválido, sin checkout, logs ilegibles, step-monolito, CI lenta) se previenen con plantillas y presupuesto de duración;
* a nivel profesional: checklist de CI inicial con permisos y versiones fijas.

La idea principal es:

> **El workflow es la primera línea de defensa del repo: dispara en lo que importa, cuenta en qué paso falló y no cuesta más tiempo que la atención del equipo.**

---

## Próximo paso

Ya tienes la máquina en marcha.

Ahora aprende a dispararla bien: eventos, filtros y condiciones.

Continúa con:

[`02-eventos-y-triggers.md`](02-eventos-y-triggers.md)
