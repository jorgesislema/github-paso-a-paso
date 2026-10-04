# Debugging y buenas prácticas

## Introducción

Un workflow que funciona una vez puede atrofiarse: tarda mucho, falla de formas misteriosas o nadie se atreve a tocarlo. Este capítulo cierra la sección con el oficio de mantener Actions sano: leer logs como un profesional, depurar sin adivinar, acelerar con caché y paralelismo, y aplicar las buenas prácticas que hacen que la automatización dure.

---

## Mapa conceptual de este capítulo

```text
Debugging y buenas prácticas
       │
       ├── 1. Depurar sin adivinar
       ├── 2. Rendimiento: caché, paralelo, filtros
       ├── 3. Concurrency, cancelación y reintentos
       ├── 4. Mantenimiento del workflow
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Depurar sin adivinar

```text
HERRAMIENTAS EN ORDEN:
   │
   ├── 1. log del step fallido (la salida completa)
   ├── 2. logs de steps previos (¿qué contexto
   │   recibió?)
   ├── 3. re-run con debug habilitado (debug logging
   │   de la plataforma — ver docs actuales; en
   │   muchos casos: re-run con «Enable debug
   │   logging» o la variable de entorno de debug)
   ├── 4. workflow temporal de diagnóstico (paso a
   │   paso: imprimir versión, rutas, quién es el
   │   usuario)
   └── 5. reproducción local: mismo comando en tu
       máquina (el runner es Ubuntu genérico)
```

```yaml
# paso de diagnóstico temporal (bórralo después):
- name: Diagnóstico
  run: |
    uname -a
    pwd && ls -la
    echo "ref=${{ github.ref }}"
    echo "evento=${{ github.event_name }}"
    command -v python || true
    python --version || true
```

```text
CHECKLIST DE FALLO:
   │
   ├── ¿falla SIEMPRE o solo a veces? (flaky → cap. 5)
   ├── ¿falla en mi máquina? → diferencias de SO/
   │   versiones
   ├── ¿falla solo en PR/fork? → triggers y secretos
   │   (cap. 02/04/05)
   └── ¿falló tras cambiar X? → diff del workflow
       (git log .github/workflows/)
```

```text
   │
   └── regla: cada «fallo misterioso» termina en una
       línea añadida al log o en un test — si no se
       puede diagnosticar, se instrumenta
```

---

## 2. Rendimiento: caché, paralelo, filtros

```text
DÓNDE SE VA EL TIEMPO (mira los durations):
──────────────────────────────────────────────────────
instalar dependencias  → caché (cap. 03 sección 19)
esperas entre jobs     → grafo (paralelizar)
tests innecesarios     → paths (cap. 02)
descargas grandes      → artefactos mínimos
```

```yaml
# instalación con caché (setup-actions suelen traer
# cache: true — preferir eso):
- uses: actions/setup-node@v4
  with:
    node-version: 20
    cache: 'npm'
```

```text
REGLAS DE VELOCIDAD:
   │
   ├── PRs: camino rápido (lint + unit); lo pesado en
   │   main/schedule
   ├── paths en repos grandes
   ├── jobs paralelos (sección 03)
   └── presupuesto: si tu PR supera ~10 min, es una
       señal (revisar en retro — sección 26)
```

```text
   │
   └── la CI lenta NO es «normalidad»: es deuda que
       paga cada revisión (sección 15 cap. 06)
```

---

## 3. Concurrency, cancelación y reintentos

```yaml
concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true
```

```text
QUÉ HACE:
   │
   ├── agrupa ejecuciones por contexto (rama) y
   │   cancela la anterior si llega una nueva
   │
   └── perfecto para PR: push tras push → solo corre
       la última (ahorro inmediato)
```

```text
PRECAUCIÓN:
   │
   ├── NO uses cancel-in-progress en flujos de
   │   RELEASE o DEPLOY (no quiero que mi deploy se
   │   cancele a medias — usa otro grupo o false)
   │
   └── el grupo debe distinguir entornos si hay
       varios
```

```text
REINTENTOS:
   │
   ├── «Re-run failed jobs» para fallos transitorios
   │   (red, runner)
   │
   ├── si un step es flaky de verdad → arreglar el
   │   step, no acostumbrarse a reintentar (cap. 5)
   │
   └── `strategy.retry`/reintentos por step: con
       moderación y causa conocida (mención)
```

---

## 4. Mantenimiento del workflow

```text
HIGIENE:
   │
   ├── versiones de actions renovadas (Dependabot —
   │   sección 20)
   ├── steps de diagnóstico retirados tras usarlos
   ├── comentarios en el YAML para lo no obvio
   ├── duración vigilada (tendencia mensual)
   └── dueño del workflow (CODEOWNERS sobre
       .github/workflows — sección 16)
```

```text
ESTRUCTURA RECOMENDADA:
   │
   ├── workflows cortos y por propósito: ci.yml,
   │   release.yml, seguridad.yml
   │
   └── si un workflow pasa de ~150 líneas: ¿se puede
       partir o extraer a un workflow reutilizable
       (workflow_call)?
```

```text
DOCUMENTACIÓN VIVA:
   │
   ├── qué dispara cada workflow (tabla — sección 02
   │   de esta sección)
   └── qué hacer cuando CI roja (playbook corto en
       docs/guias)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: flaky tests «arreglados» con re-run

**Qué ocurrió:** el CI falla 1 de cada 5; el equipo ya tiene el hábito de reintentar.

**Por qué:** causa raíz sin diagnosticar (concurrencia, tiempo, red, orden de archivos).

**Cómo comprobarlo:** frecuencia de fallo; ¿siempre en el mismo step?

**Opciones:** instrumentar (log de estado), arreglar el test/servicio, reintentos SOLO con causa conocida.

**Riesgos:** CI que no protege (ruido rojo/verde = ceguera).

**Solución:** flaky = bug (punto 5).

**Cómo se evita:** métrica de reintentos en la retro.

---

### Error 2: workflow-monolito heredado

**Qué ocurrió:** 400 líneas con 8 jobs mezclando test, build, deploy y notificaciones; nadie lo toca por miedo.

**Por qué:** crecimiento sin refactor.

**Cómo comprobarlo:** longitud; número de jobs; «¿quién lo entiende?».

**Opciones:** partir por propósito (ci/release/seguridad); extraer steps comunes a workflows reutilibles.

**Riesgos:** automatización paralizada por miedo.

**Solución:** estructura por propósito (punto 4).

**Cómo se evita:** revisar tamaño en PRs que tocan workflows.

---

### Error 3: caché y artefactos sin límite

**Qué ocurció:** tiempos de subida bajando, almacenamiento creciendo, caches que nunca se purgan.

**Por qué:** defaults de retención y keys amplias.

**Cómo comprobarlo:** uso de almacenamiento del repo; tamaño de artifacts.

**Opciones:** retención corta para artefactos de CI; keys por lockfile; limpieza periódica.

**Riesgos:** coste y lentitud.

**Solución:** política de retención (punto 2/3).

**Cómo se evita:** revisión trimestral de almacenamiento.

---

### Error 4: deploy cancelado a mitad (concurrency mal puesto)

**Qué ocurrió:** un segundo push canceló el deploy de producción en curso.

**Por qué:** `cancel-in-progress: true` global o por grupo compartido.

**Cómo comprobarlo:** ejecuciones «cancelled» en deploy.

**Opciones:** grupos separados por entorno; `cancel-in-progress: false` en releases/deploys.

**Riesgos:** entorno a medias (peor que no desplegar).

**Solución:** cancelar solo CI de PR (punto 3).

**Cómo se evita:** revisar concurrency en workflows de release.

---

### Error 5: logs sin nombres ni contexto

**Qué ocurrió:** «run command1 / command2 / …» — imposible saber qué falló sin leer todo.

**Por qué:** steps sin `name:` (sección 01).

**Cómo comprobarlo:** leer la ejecución como nuevo.

**Opciones:** renombrar steps; partir comandos; mensajes propios con `echo "::error::…"` (mención).

**Riesgos:** diagnóstico que depende de una persona.

**Solución:** logs legibles (punto 1).

**Cómo se evita:** checklist de workflow.

---

### Error 6: diagnóstico que se deja «temporal» y se vuelve permanentes

**Qué ocurció:** pasos de impresión de todo (o `set -x`) siguen activos 6 meses; ruido y riesgo de exponer variables.

**Por qué:** nadie tiene dueño del workflow.

**Cómo comprobarlo:** steps «debug» en workflows activos.

**Opciones:** retirar; sustituir por logs mínimos útiles; dueño + revisión.

**Riesgos:** ruido y exposición accidental.

**Solución:** el diagnóstico se borra cuando se usa (punto 4).

**Cómo se evita:** CODEOWNERS de workflows.

---

## 6. Práctica guiada

### Objetivo

Diagnóstico, aceleración y endurecimiento de un workflow real.

### Paso 1: lee un fallo real

1. Rompe un test en tu repo de práctica y lee SOLO el log del step rojo.
2. Localiza la línea exacta del fallo sin abrir más pasos.

### Paso 2: instrumenta

```yaml
      - name: Contexto
        if: failure()
        run: |
          echo "evento=${{ github.event_name }}"
          echo "ref=${{ github.ref }}"
          ls -la
```

1. Ejecuta, lee, retira (o déjalo `if: failure()` — decisión consciente).

### Paso 3: acelera

```text
   │
   ├── añade cache (setup-action con cache: true)
   ├── paths en pull_request
   └── paraleliza lo que esté serial de más
Mide antes/después (duración total).
```

### Paso 4: cancela lo viejo

```yaml
concurrency:
  group: ci-${{ github.ref }}
  cancel-in-progress: true   # solo en CI de PR
```

1. Haz dos pushes seguidos: la primera ejecución se cancela.

### Paso 5: documenta

```markdown
## Automatización
| Workflow | Dispara | Duración objetivo | Dueño |
|----------|---------|-------------------|-------|
| ci.yml   | PR + push main | < 8 min | @equipo |
| release.yml | tag v* | < 15 min | @equipo |
```

1. Añade el playbook: «CI roja → primeros 3 pasos».

### Paso 6: programa mantenimiento

1. Recordatorio: renovación de actions (Dependabot) + revisión de duración y almacén (trimestral).

### Resultado esperado

Workflow diagnosticado, acelerado, con concurrency correcta y documentación operativa.

### Conclusión esperada

Mantener Actions es mantenimiento de software: logs legibles, rendimiento vigilado, dueño y calendario.

---

## 7. Nivel profesional + resumen

### 7.1. Operación de CI/CD

```text
   │
   ├── presupuestos: duración de PR, coste mensual,
   │   % de reintentos
   │
   ├── flaky = bug con dueño (no costumbre)
   │
   ├── concurrency distinto para CI vs. release
   │
   ├── workflows por propósito + reutilizables cuando
   │   se repiten (sección 22/25)
   │
   ├── renovación automática de actions (sección 20)
   │
   └── playbook de CI roja en docs (cualquiera puede
       diagnosticar)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* depurar en Actions: log del step → contexto → debug logging → repro local; instrumentar lo que no se explica;
* el rendimiento se gana con caché, paralelismo, paths y presupuesto de duración;
* `concurrency` con `cancel-in-progress` ahorra ejecuciones en PR — nunca en release/deploy;
* el mantenimiento: dueño, retención, estructura por propósito y documentación viva;
* los errores típicos (flaky con reintentos, monolito heredado, almacén sin límite, deploy cancelado, logs sin nombre, diagnóstico permanente) se previenen con higiene;
* a nivel profesional: métricas de operación de CI/CD y playbook.

La idea principal es:

> **La automatización también se mantiene: logs que cualquiera lee, tiempos que vigilas y workflows con dueño — lo que nadie entiende, nadie lo tocará cuando haga falta.**

---

## Próximo paso

Has completado la sección de GitHub Actions.

Continúa con el cierre de la sección:

[`README.md`](README.md)
