# Issues, etiquetas y milestones

## Introducción

La issue es la unidad de trabajo de GitHub: un reporte, una petición, una decisión pendiente — algo que alguien debe recordar y cerrar. Sin disciplina, el tracker se convierte en un cementerio de «todo el día»; con buenas etiquetas y milestones, se convierte en el tablero que sostiene la planificación.

Este capítulo enseña a redactar issues que se pueden ejecutar, a diseñar etiquetas que ayudan a decidir (no a decorar) y a agrupar trabajo en milestones con objetivo.

---

## Mapa conceptual de este capítulo

```text
Issues, etiquetas y milestones
       │
       ├── 1. Anatomía de una issue ejecutable
       ├── 2. Diseño de etiquetas
       ├── 3. Milestones con objetivo
       ├── 4. Ciclo de vida y rutinas
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Anatomía de una issue ejecutable

```text
TÍTULO (qué + ámbito)
   «Export: falla el CSV con acentos en Windows»

CUERPO
   │
   ├── Contexto / problema (por qué existe)
   ├── Pasos para reproducir (si es bug)
   ├── Resultado esperado vs. obtenido
   ├── Alternativas consideradas (si es feature)
   └── Criterios de aceptación (¿cuándo está hecho?)

METADATOS
   │
   ├── etiquetas (tipo, área, prioridad)
   ├── asignada a (una persona/ún dueño)
   └── milestone (a qué entrega pertenece)
```

```text
PLANTILLA (issue templates — sección 14):
   │
   ├── bug: pasos, esperado/obtenido, entorno
   ├── feature: problema, propuesta, no-propuesta
   └── el formulario guía al reportante y ahorra
       idas y vueltas
```

```text
CRITERIOS DE ACEPTACIÓN = «definition of done»
de la issue:
   │
   ├── «CSV sale con ñ/acentos en Windows y Linux»
   ├── «test cubre el caso»
   └── así se cierra sin discusión (y el PR los
       referencia: «Closes #n» — sección 14/15)
```

```bash
# en local: trabajar con una issue
gh issue list --label bug
gh issue view 42
gh issue comment 42 --body "reproducido en main"
```

---

## 2. Diseño de etiquetas

```text
AXES ÚTILES (pocos, no uno por eje que se te ocurra)
──────────────────────────────────────────────────────
TIPO:     bug · feature · docs · refactor · chore
ÁREA:     frontend · backend · infra · datos
PRIORIDAD: P0 · P1 · P2   (usar solo si priorizas
           con ellas)
ESTADO:   needs-triage · blocked   (la plataforma ya
           tiene abierta/cerrada)
```

```text
REGLAS DE DISEÑO:
   │
   ├── colorear por TIPO (escaneo rápido)
   ├── prioridad con nombre explícito (P0 = hoy)
   ├── máx. ~10-12 etiquetas vivas; revisar y
   │   borrar obsoletas
   └── cada etiqueta con descripción corta: «cuándo
       se pone»
```

```text
TRIAGE (rutina):
   │
   ├── issue nueva → revisar: ¿bug o feature?
   │   ¿reproducida? ¿área? ¿prioridad?
   ├── etiquetar + asignar dueño de triage
   └── sin esto, el tracker se llena de duplicados y
       «sin etiqueta»
```

```text
   │
   └── la prioridad la pone alguien con visión del
       conjunto (no el que más grita en el hilo)
```

---

## 3. Milestones con objetivo

```text
MILESTONE = entrega con fecha/objetivo
   │
   ├── «v0.4 — exportación de reportes» (fecha)
   ├── «Q4 — estabilización» (tema)
   └── agrupa issues; muestra progreso (cerradas /
       total)
```

```text
BUENAS PRÁCTICAS:
   │
   ├── objetivo en una frase (¿qué cambia para el
   │   usuario al cerrarlo?)
   ├── fecha o ventana realista (nada de «cuando
   │   esté»)
   ├── issues con criterios de aceptación
   └── revisión semanal: ¿qué sale, qué entra, qué
       se mueve? (scope creep se combate aquí)
```

```text
CUÁNDO NO usar milestone:
   │
   ├── backlog a largo plazo (las etiquetas bastan)
   └── trabajo continuo sin entregas
       (un milestone «siempre abierto» no motiva ni
       informa)
```

---

## 4. Ciclo de vida y rutinas

```text
CICLO
──────┬──┬────────────────────────────────────────────
 abierta → triage (etiquetas, dueño)
    → en curso (asignada; PR vinculado)
      → revisión (PR abierto con Closes #n)
        → cerrada (merge automático o manual)
          o cerrada como «no hará» (con comentario
            del porqué — ¡importa!)
```

```text
RUTINAS DE EQUIPO:
   │
   ├── triage semanal (¿nuevas? ¿duplicadas? ¿P0?)
   ├── milestone review antes de cada entrega
   ├── issues huérfanas (sin dueño, sin milestone,
   │   >30 días) → decisión: hacer, mover o cerrar
   └── cerrar NO es fallar: un «no lo haremos»
       documentado evita reabrir debates
```

```text
VÍNCULO CON EL PR:
   │
   ├── «Closes #n» en la descripción → autocierre
   │   al merge (sección 14/15)
   └── el PR sin issue: ¿es tan pequeño que no hace
       falta? o ¿hay que crearla?
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: tracker cementerio

**Qué ocurrió:** 140 issues abiertas, nadie sabe cuáles importan.

**Por qué posibles:**
* sin triage ni dueños;
* sin cierre de lo obsoleto.

**Cómo comprobarlo:** antigüedad; % sin etiquetas; sin asignar.

**Opciones:** campaña de triage (cerrar/duplicar/mover); rutina semanal desde ahora.

**Riesgos:** nadie mira el tracker → se planifica en chats (y se pierde).

**Solución:** dueño del triage y revisión fija (punto 4).

**Cómo se evita:** «issue sin etiqueta en 7 días se revisa».

---

### Error 2: issues sin criterios de aceptación

**Qué ocurrió:** el PR cierra la issue pero «no es lo que pedí».

**Por qué:** la issue describía deseo, no resultado.

**Cómo comprobarlo:** leer la issue antes del PR: ¿cómo se comprueba que está hecho?

**Opciones:** añadir criterios antes de estimar; discutir en la issue, no en el PR.

**Riesgos:** vueltas y cierres disputados.

**Solución:** criterios de aceptación escritos (punto 1).

**Cómo se evita:** plantilla de feature con «criterios» obligatorio.

---

### Error 3: etiquetas decorativas o infinitas

**Qué ocurrió:** 40 etiquetas, la mitad sin usar; cada quien crea la suya.

**Por qué:** diseño sin regla + libertad total.

**Cómo comprobarlo:** conteo de uso por etiqueta.

**Opciones:** consolidar (merge de sinónimos), borrar obsoletas, restringir creación (permisos de label según rol).

**Riesgos:** filtro inútil; inconsistencia.

**Solución:** taxonomía de ~10-12 con descripción (punto 2).

**Cómo se evita:** revisar taxonomía en la retro.

---

### Error 4: prioridades inventadas por individuo

**Qué ocurrió:** el equipo tiene 30 P0; o cada persona tiene su «P0» particular.

**Por qué:** no hay dueño de la priorización.

**Cómo comprobarlo:** distribución de prioridades.

**Opciones:** definir qué significa P0 («bloquea a usuarios») y quién lo asigna (triage/po del área).

**Riesgos:** la prioridad deja de priorizar.

**Solución:** definición escrita por nivel + dueño único.

**Cómo se evita:** revisar P0s en la reunión de planificación.

---

### Error 5: milestone como deseo sin plan

**Qué ocurrió:** milestone con fecha y 3 issues gigantes; al llegar la fecha, 0 cerradas.

**Por qué:** scope sin estimar ni partir.

**Cómo comprobarlo:** progreso a mitad de ventana (muchas abiertas → señal).

**Opciones:** partir issues, sacar alcance a la siguiente ventana, comunicar fecha nueva (honestidad, sección 14).

**Riesgos:** fechas sin credibilidad.

**Solución:** entrar solo con issues pequeñas y criterios claros.

**Cómo se evita:** revisión de milestone a mitad de camino.

---

### Error 6: cerrar issues sin decidir (o sin comentar)

**Qué ocurrió:** issues cerradas «por limpieza» que en realidad siguen vivas; o bugs que se cierran y vuelven.

**Por qué posibles:**
* automatismos (PR mal vinculado cierra la equivocada);
* cierre sin análisis.

**Cómo comprobarlo:** historial de cierres: ¿con comentario? ¿PR correcto?

**Opciones:** reabrir con comentario; documentar «no hará» si la decisión es esa.

**Riesgos:** confianza rota en el tracker.

**Solución:** todo cierre lleva razón (automática o escrita).

**Cómo se evita:** revisar autocierros tras cada release.

---

## 6. Práctica guiada

### Objetivo

Montar un tracker usable: plantilla, taxonomía, milestone y rutina de triage.

### Paso 1: plantillas de issue

```text
.github/ISSUE_TEMPLATE/
   ├── bug.yml   (pasos, esperado, obtenido, entorno)
   └── feature.yml (problema, propuesta, criterios)
```

1. Crea ambas (sección 14, cap. 05).

### Paso 2: taxonomía

```text
TIPO: bug · feature · docs · refactor
ÁREA: backend · frontend · infra
P:    P0 · P1
ESTADO extra: needs-triage · blocked
```

1. Crea las etiquetas con descripción corta.

### Paso 3: issue modelo

```markdown
Title: Export: CSV sale con caracteres rotos en Windows

## Contexto
Los usuarios reportan «?» en lugar de acentos…

## Pasos
1. …
2. …

## Criterios de aceptación
- [ ] CSV con UTF-8 BOM legible en Excel (Windows)
- [ ] test de codificación incluido
```

1. Etiquétala (`bug`, `backend`), asígnala y métela en un milestone.

### Paso 4: milestone con objetivo

```text
Milestone «v0.4 — exportación»:
   │
   ├── objetivo: «el usuario puede exportar CSV
   │   correcto en Windows y Linux»
   └── fecha: (ventana de 2 semanas)
```

1. Añade 2-3 issues pequeñas con criterios.

### Paso 5: vincula un PR

1. Abre un PR con `Closes #n` y comprueba el autocierre en merge (o en simulación).

### Paso 6: rutina de triage

```text
Escribe en CONTRIBUTING:
   │
   ├── «Triage: lunes, 15 min: etiquetar, asignar,
   │   decidir duplicados»
   └── «Issues >30 días sin dueño → decisión
       explícita»
```

### Resultado esperado

Tracker con plantillas, taxonomía corta, milestone con objetivo y rutina de triage escrita.

### Conclusión esperada

Las issues se ejecutan cuando tienen criterios, dueño, etiqueta útil y pertenecen a un objetivo — el resto es ruido con formulario.

---

## 7. Nivel profesional + resumen

### 7.1. Tracker como sistema de planificación

```text
   │
   ├── pipeline: triage → prioridad (dueño único) →
   │   milestone → ejecución (PR) → cierre con razón
   │
   ├── métricas con cuidado: edad de issues, % con
   │   dueño, no «issues cerradas por persona» como
   │   ranking
   │
   ├── integración con proyectos (cap. 04) para
   │   verlo como tablero, y con releases (sección
   │   14) para contarlo como entrega
   │
   └── automatizaciones: autocierre, mover a columnas,
       pedir datos con formularios (con dueño de la
       automatización)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* una issue ejecutable tiene título claro, contexto, pasos (si aplica) y criterios de aceptación — más dueño y milestone;
* la taxonomía de etiquetas se diseña por ejes (tipo/área/prioridad), se mantiene corta y con descripciones;
* los milestones agrupan entregas con objetivo y fecha, revisados a mitad de camino;
* el ciclo de vida incluye triage, en curso, PR vinculado y cierre con razón;
* los errores típicos (tracker cementerio, sin criterios, etiquetas infinitas, P0 inventados, milestone-deseo, cierres sin decidir) se previenen con rutinas escritas;
* a nivel profesional: pipeline de planificación con métricas de proceso.

La idea principal es:

> **El tracker solo funciona si cada issue es ejecutable (criterios + dueño) y cada milestone es un objetivo — el resto es una lista de deseos con fecha.**

---

## Próximo paso

Ya gestionas el trabajo issue a issue.

La siguiente pieza lo mira en bloque: GitHub Projects y tableros.

Continúa con:

[`04-github-projects.md`](04-github-projects.md)
