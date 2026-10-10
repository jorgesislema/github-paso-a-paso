# GitHub Projects

## Introducción

Las issues cuentan el trabajo uno a uno; **Projects** lo muestra en bloque: tableros, tablas y vistas que responden «¿qué estamos haciendo esta semana?» y «¿dónde está atascado?».

GitHub Projects (la versión actual, a veces llamada Projects v2) es una herramienta de planificación ligada a las issues y PRs del repositorio. Este capítulo enseña a elegir vista, configurar campos y automatizar lo poco que aporta — sin transformar la herramienta en segundo trabajo.

---

## Mapa conceptual de este capítulo

```text
GitHub Projects
       │
       ├── 1. Qué aporta (y qué no)
       ├── 2. Vistas: board, table, roadmap
       ├── 3. Campos: estado, área, prioridad, fechas
       ├── 4. Automatizaciones y filtros
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué aporta (y qué no)

```text
APORTA:
   │
   ├── visión de conjunto: «qué está en curso, qué
   │   viene, qué está bloqueado»
   │
   ├── cruces útiles: issues + PRs en la misma fila
   │
   ├── vistas distintas para distintos lectores
   │   (equipo: board; planificación: tabla;
   │   dirección: roadmap)
   │
   └── métricas de proceso: distribución por estado/
       área, edad en columna (sección 15 cap. 06)
```

```text
NO APORTA (y no debe intentarlo):
   │
   ├── el trabajo ya está en issues + PRs; el board
   │   es una VISTA, no una segunda base de datos
   │
   ├── no sustituye criterios de aceptación ni
   │   revisiones
   │
   └── no hace la planificación: la reunión y las
       decisiones siguen siendo humanas
```

```text
   │
   └── regla: si la ficha del board no coincide con
       la issue/PR, miente el board — la fuente son
       las issues y los PRs
```

---

## 2. Vistas: board, table, roadmap

```text
BOARD (kanban)
   │
   ├── columnas por estado del flujo:
   │   Backlog · To do · In progress · Review · Done
   │
   └── mejor para: operar el día a día del equipo

TABLE (tabla)
   │
   ├── filas = issues, columnas = campos
   │   (área, prioridad, milestone, fecha)
   │
   └── mejor para: filtrar, ordenar, hacer cambios
       masivos de campo

ROADMAP (timeline)
   │
   ├── barras por milestone/fecha en línea temporal
   │
   └── mejor para: planificación a varias semanas
       (si usas fechas)
```

```mermaid
flowchart TD
    A[¿Quién lo lee?] --> B[1-2 vistas por audiencia]
    A --> C[Vistas GUARDADAS con filtro (ej. solo P0/P1, solo milestone actual)]
    C --> D[No necesitas todas las vistas]
    D --> E[Necesitas claridad]
```

---

## 3. Campos: estado, área, prioridad, fechas

```text
CAMPOS (custom fields)
   │
   ├── Estado    → Status (To do/In progress/Done…)
   ├── Área      → opción (backend/frontend…)
   ├── Prioridad → opción (P0/P1/P2)
   ├── Fecha     → date (para roadmap)
   └── milestone → dato nativo de la issue
```

```text
RELACIÓN CON ETIQUETAS (¡ojo con duplicar!):
   │
   ├── etiqueta = vive en la issue (funciona en
   │   cualquier vista y en el filtro de issues)
   │
   ├── campo del proyecto = vive en el proyecto
   │
   └── decisión: o usas campos O etiquetas para el
       mismo eje — NO ambos (evita desincronizar;
       si necesitas ambos, sincroniza con
       automatización y dueño)
```

```text
   │
   └── el ESTADO del board (columna) es distinto del
       estado de la issue (abierta/cerrada): «En
       review» con issue abierta es normal; el PR es
       quien avanza
```

---

## 4. Automatizaciones y filtros

```text
AUTOMATIZACIONES (las que suelen valer la pena):
   │
   ├── issue/PR abre → item entra al proyecto (y a
   │   columna por defecto)
   ├── PR mergeado → item a Done
   ├── etiqueta/estado cambia → columna cambia
   └── actualización automática de estado cuando el
       PR pasa a review
```

```text
FILTROS (guardados):
   │
   ├── @me · milestone actual · P0 · área mía
   ├── «cosas sin dueño > 7 días» (higiene)
   └── «PRs en review > 2 días» (atascos)
```

```text
   │
   ├── automatiza el TRASLADO mecánico; nunca la
   │   decisión (nadie mueve «a Done» sin merge)
   │
   └── cada automatización es una pieza con dueño:
       si rompe, alguien la arregla
```

```bash
# comprobar estado del trabajo sin abrir el navegador:
gh issue list --state open --limit 20
gh pr list --review-requested @me
# (el board y la CLI leen la misma verdad)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: board que nadie actualiza

**Qué ocurrió:** todo en «To do» o «In progress» desde hace un mes; el equipo planifica en otra parte.

**Por qué posibles:**
* movimiento manual sin rutina;
* no es la vista real de trabajo (doble trabajo).

**Cómo comprobarlo:** comparar board vs. PRs/issues reales.

**Opciones:** automatizar traslados (punto 4); reducir columnas; si no aporta, eliminar el board y quedarte con la tabla.

**Riesgos:** decisión basada en datos viejos.

**Solución:** automatizar lo mecánico y una revisión corta semanal.

**Cómo se evita:** dueño del board (rotativo) y columnas coherentes con el flujo real (sección 15).

---

### Error 2: campos y etiquetas duplicados desincronizados

**Qué ocurrió:** issue «P0» en etiqueta y «P1» en campo del proyecto.

**Por qué:** se crearon los dos sistemas.

**Cómo comprobarlo:** cruzar muestra: ¿coinciden?

**Opciones:** eliminar un eje (recomendado: etiquetas para tipo/área; campos para estado/fechas del proyecto — o según el equipo), o script de sincronización con dueño.

**Riesgos:** dos verdades → ninguna.

**Solución:** una fuente por eje (punto 3).

**Cómo se evita:** regla escrita al crear el proyecto.

---

### Error 3: demasiadas columnas/campos (tablero de control)

**Qué ocurrió:** 9 columnas y 12 campos; nadie mueve nada.

**Por qué:** se modeló el proceso perfecto.

**Cómo comprobarlo:** llenado por columna y uso de campos.

**Opciones:** a 4-5 columnas (To do · In progress · Review · Done + backlog si hace falta); campos: área, prioridad, fecha.

**Riesgos:** fricción → abandono.

**Solución:** modelo mínimo y revisión trimestral de uso.

**Cómo se evita:** solo se añade campo/columna si responde a una pregunta repetida.

---

### Error 4: planificar en el board sin criterios

**Qué ocurrió:** se mueven tarjetas a «esta semana» y al final nadie sabe por qué esa orden.

**Por qué:** falta prioridad con dueño (sección 03).

**Cómo comprobarlo:** ¿hay P0/P1 con definición? ¿quién decide?

**Opciones:** aplicar el triage de la sección 03 antes de meter al sprint; fecha solo donde hay compromiso real.

**Riesgos:** planificación cosmética.

**Solución:** board = reflejo; la decisión está en el triage.

**Cómo se evita:** ordenar planificación semanal con datos (edades, bloqueos).

---

### Error 5: roadmap con fechas fantasma

**Qué ocurrió:** timeline lleno de fechas que nadie cree; actualizado cada trimestre (o nunca).

**Por qué posibles:**
* fechas puestas «para que quede bien»;
* sin revisión.

**Cómo comprobarlo:** comparar fechas vs. entregas reales.

**Opciones:** usar ventana (semana/mes) en vez de día exacto; revisar en cada retro; ocultar fechas si el equipo no trabaja con ellas.

**Riesgos:** pérdida de confianza en la vista.

**Solución:** fechas solo con dueño y compromiso (punto 2).

**Cómo se evita:** regla: «si no se revisa semanalmente, no se pone fecha».

---

### Error 6: proyecto como base de datos paralela

**Qué ocurrió:** cosas que SOLO viven en el board (sin issue/PR) — cuando se pierde el proyecto, se pierde el trabajo.

**Por qué:** atajo en la pizarra virtual.

**Cómo comprobarlo:** ítems sin enlace a issue/PR real.

**Opciones:** crear la issue/PR y enlazar; regla «todo ítem enlaza».

**Riesgos:** fuente de verdad fragmentada.

**Solución:** las issues y PRs son la verdad; el proyecto es vista.

**Cómo se evita:** plantilla: ítem huérfano → crear issue.

---

## 6. Práctica guiada

### Objetivo

Crear un proyecto con board, campos mínimos y una automatización.

### Paso 1: crea el proyecto

1. En la org/repo: Projects → New → **Board** con «Feature planning» o vacío.
2. Columnas: Backlog · To do · In progress · Review · Done.

### Paso 2: campos

```text
Añade:
   │
   ├── Prioridad: P0 · P1 · P2
   ├── Área: backend · frontend · infra
   └── Fecha: (date, si usarás roadmap)
```

### Paso 3: añade trabajo real

1. Añade 3-5 issues abiertas y un PR en revisión.
2. Comprueba que cada ítem enlaza a su issue/PR.

### Paso 4: filtro guardado

```text
Guarda vistas:
   │
   ├── «Semana»: milestone actual, ordenado por
   │   prioridad
   ├── «Mi trabajo»: asignadas a mí
   └── «Atasco»: en Review > 2 días (si el filtro lo
       permite por fecha)
```

### Paso 5: automatización

```text
Workflow: cuando un PR se mergea → mover item a
Done. (o: issue etiquetada «blocked» → columna
Blocked)
```

1. Activa una sola automatización y compruébala con un PR.

### Paso 6: rutina

1. Añade a CONTRIBUTING: «lunes 10 min: revisar board con el equipo; mover solo lo que cambió de verdad».

### Resultado esperado

Board con columnas reales, campos mínimos, filtro guardado y una automatización funcionando.

### Conclusión esperada

El board vale lo que refleja: fuente = issues/PRs, campos no duplicados con etiquetas, automatizar traslados y revisar en equipo.

---

## Ejercicio de transferencia

En un proyecto de práctica, crea un board con columnas To do, In progress, Review, Done; añade campos de prioridad (P0/P1/P2) y área (backend/frontend); crea tres issues de diferentes áreas y prioridades, asígnalas al proyecto, y verifica que aparecen en las columnas correctas según su estado. Luego, crea una automatización que mueva items a Done al mergear un PR y pruébala. Entrega capturas del board, campos, automatización y el resultado.

## 7. Nivel profesional + resumen

### 7.1. Projects a escala de equipo

```text
   │
   ├── una vista por audiencia (equipo, planificación,
   │   dirección) — evita «el tablero que nadie entiende»
   │
   ├── métricas de proceso desde la vista de tabla:
   │   distribución, edad en estado, bloqueos
   │
   ├── integración con milestones y releases
   │   (sección 14) para cerrar el círculo
   │
   └── dueño del proyecto (rotativo) + revisión
       trimestral de columnas/campos
```

### 7.2. Resumen

En este capítulo aprendiste que:

* Projects es vista, no base de datos: las issues y PRs son la verdad;
* vistas por audiencia: board para operar, tabla para filtrar y planificar, roadmap para ventanas;
* campos mínimos (estado, prioridad, área, fechas) — sin duplicar etiquetas: un eje, una fuente;
* se automatizan traslados mecánicos (merge → Done) con dueño; los filtros guardados exponen higiene y atascos;
* los errores típicos (board muerto, duplicados desincronizados, tablero de control, planificación sin criterios, fechas fantasma, ítems huérfanos) se previenen con diseño mínimo y rutina;
* a nivel profesional: vistas por audiencia y métricas de proceso.

La idea principal es:

> **El tablero es un espejo: si refleja issues y PRs reales con pocos campos, decide; si se convierte en base de datos paralela, engaña.**

---


## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Por qué es importante que GitHub Projects sea solo una vista de las issues y PRs y no una base de datos paralela, y qué riesgos surgen al duplicar información?
2. ¿Cómo decidirías entre usar un board, una tabla o un roadmap según el tipo de audiencia y la información que necesita cada uno?
3. ¿De qué manera los campos personalizados (estado, área, prioridad, fechas) evitan la duplicación con etiquetas y cuándo deberías elegir uno u otro para un mismo eje?
4. ¿Qué automatizaciones mecánicas (como mover items a Done al mergear un PR) son seguras de automatizar y por qué nunca se debe automatizar la decisión de movimiento?
5. ¿Cómo utilizarías filtros guardados para monitorizar la higiene del proyecto (por ejemplo, items sin dueño o atascos en revisión) y qué acciones tomarías basándote en esos filtros?
6. ¿Qué pasos seguirías para escalar el uso de Projects a nivel de equipo, asegurando que haya una vista adecuada para cada audiencia y una revisión trimestral de columnas y campos?
7. ¿Cómo integrarías GitHub Projects con milestones y releases para cerrar el círculo de planificación y ejecución?
8. ¿De qué forma la métrica de edad en columna y la distribución por estado/área pueden ayudar a detectar bloqueos y mejorar el flujo de trabajo?

---

## Próximo paso

Ya ves el trabajo en bloque.

El siguiente tema: la conversación del equipo donde las ideas no caben en issues — Discussions.

Continúa con:

[`05-discussions-y-comunidad.md`](05-discussions-y-comunidad.md)
