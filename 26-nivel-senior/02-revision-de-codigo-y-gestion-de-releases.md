# Revisión de código y gestión de releases

## Introducción

Dos pilares sostienen la confianza en cualquier flujo: **la revisión de código** (que lo que entra está pensado) y **la gestión de releases** (que lo que sale es predecible). Este capítulo no repite la mecánica de los Pull Requests (sección 15) ni el versionado (sección 17): los eleva a práctica senior — qué buscar al revisar, cómo se lleva una revisión que no traiga, y cómo se conduce una release como un proceso maduro con responsables, comunicaciones y salida atrás.

---

## Mapa conceptual de este capítulo

```text
Revisión de código y gestión de releases
       │
       ├── 1. La revisión como sistema, no como trámite
       ├── 2. Qué mira una revisión senior (capas)
       │   ├── 3. La persona que revisa: ritmo y trato
       │   └── 4. Releases: del «está listo» al proceso
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. La revisión como sistema, no como trámite

```text
SISTEMA (la revisión ESCALA cuando es sistema):
   │
   ├── antes: alguien «echa un ojo» cuando puede
   │   (Error 1 si no hay dueño ni SLA — sección 15
   │   cap. 06)
   │
   ├── sistema: PR claro (sección 15 cap. 04) →
   │   revisor asignado → plazo → checklist → gates
   │   automáticos (sección 19/24) → decisión registrada
   │
   └── la revisión MANUAL mira lo que la máquina NO
       mira: diseño, contexto, riesgo (Error 2 si se
       usan humanos para lo que un linter hace mejor)
```

```text
   │
   └── la revisión es EL ÚLTIMO control humano del
       flujo: si falla, lo demás es automatismo sin
       criterio (Error 3 si es decorativa — «approbo
       para que no frene»)
```

---

## 2. Qué mira una revisión senior (capas)

```text
CAPAS (de arriba abajo — cada una con foco):
   │
   ├── 1. ¿Es lo que se pedía? (issue ↔ PR: ¿cierra
   │   el problema real — Error 4 si se revisa solo
   │   «estilo» y nadie mira si resuelve)
   ├── 2. ¿Es correcto? (casos límite, errores,
   │   seguridad — sección 20/24: secretos, inyección,
   │   permisos)
   ├── 3. ¿Es mantenible? (naming, estructura, límites
   │   — sección 25 cap. 02: ¿toca lo que no debe?)
   ├── 4. ¿Es observable y reversible? (logs, tests,
   │   rollback — sección 23/24)
   └── 5. ¿Está probado? (tests que fallan sin el
       cambio — sección 22 cap. 03)
```

```text
   │
   └── el orden importa: primero SI resuelve, luego
       CÓMO está hecho (Error 4 — discutir comas en
       un PR que no pide lo correcto es revisión
       al revés)
```

```text
MENSAJE DE REVISIÓN (qué aporta valor):
   │
   ├── «¿y si…?» y preguntas («¿qué pasa cuando X?»)
   │   > imposiciones de estilo (el linter decide eso)
   │
   └── bloqueante vs. sugerencia DISTINTOS (Error 5
       si todo es bloqueante: el PR no avanza; si nada
       es bloqueante: no hay control)
```

---

## 3. La persona que revisa: ritmo y trato

```text
RITMO (sección 15 cap. 06 — el equipo lo siente):
   │
   ├── SLA de primera revisión (horas/días — según
   │   flujo) (Error 6 si «cuando pueda»: los PRs se
   │   enfrían y divergen)
   │
   ├── limitar PRs abiertos simultáneos (pull: revisar
   │   antes de abrir otro — sección 17 cap. 04)
   │
   └── el autor reduce la carga: PR pequeños, PR
       template completo, contexto en la descripción
```

```text
TRATO (la revisión es entre personas):
   │
   ├── comentar el CÓDIGO, no a la persona (Error 7
   │   si es «esto está mal» sin alternativa)
   │
   ├── explicar el porqué: la revisión enseña y
   │   forma (sección 16/23 — la revisión es onboarding
   │   continuo)
   │
   └── el autor: responde con cambios o argumentos, no
       con molestia (sección 00 — cultura)
```

```text
   │
   └── rotar revisores: el conocimiento no se
       concentra (Error 7 — factor de bus factor,
       sección 23 cap. 06)
```

---

## 4. Releases: del «está listo» al proceso

```text
RELEASE MADURA = ANTES · DURANTE · DESPUÉS:
   │
   ├── ANTES:
   │     · checklist: tests verdes, dependencias,
   │       seguridad, changelog (Error 8 si «está
   │       listo» es una impresión)
   │     · etiqueta/versionado (sección 17 cap. 05)
   │     · notas para quien consume (sección 14)
   │
   ├── DURANTE:
   │     · tag + release en la plataforma (sección 17
   │       cap. 06)
   │     · artefacto reproducible (sección 22 cap. 05)
   │     · despliegue por etapas (staging → prod —
   │       sección 22/23)
   │
   └── DESPUÉS:
         · humo + observabilidad (sección 23 cap. 06)
         · rollback en marcha si hace falta (Error 8
           prevención — sección 22 cap. 06)
         · comunicado: qué cambió y cómo se usa
```

```text
CÓMO SE DECIDE «ESTÁ LISTO» (criterio, no corazonada):
   │
   ├── definition of done escrito (¿qué incluye?
   │   código + tests + docs + seguridad — sección 15
   │   cap. 04/14)
   │
   └── quién APRUEBA la release (dueño nominal —
       Error 8 si «la hace quien esté cerca»)
```

```text
   │
   └── la release es un PRODUCTO: fecha, dueño,
       comunicado, y su marcha atrás probada (Error
       8 — Error 7 de la sección anterior)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: revisión sin dueño ni plazo

**Qué ocurrió:** PRs esperando «que alguien los mire» durante días.

**Por qué:** el sistema no tiene asignación (punto 1).

**Cómo comprobarlo:** antigüedad de PRs abiertos.

**Opciones:** revisor automático/asignado + SLA + límite de abiertos (punto 1/3).

**Riesgos:** flujo estancado (Error 6 sección 25 cap. 05).

**Solución:** sistema con plazos (punto 1).

**Cómo se evita:** métrica en la retro.

---

### Error 2: humanos revisando lo que revisa la máquina

**Qué ocurrió:** los revisores discutían formato/imports mientras el linter ya lo hacía.

**Por qué:** capas confundidas (punto 1).

**Cómo comprobarlo:** ¿qué % de comentarios son de estilo ya automatizable?

**Opciones:** formateo/lint en CI (pre-commit y check — sección 19); los humanos suben de capa.

**Riesgos:** agotamiento y lo importante sin mirar.

**Solución:** máquina = estilo, humano = diseño (punto 1).

**Cómo se evita:** checklist de gates antes de pedir revisión humana.

---

### Error 3: revisión decorativa

**Qué ocurrió:** «approved» en 30 segundos, sin leer; un error de diseño pasó a producción.

**Por qué:** presión de velocidad o desmotivación (punto 1).

**Cómo comprobarlo:** tiempo entre abrir PR y aprobar; comentarios por PR.

**Opciones:** PRs más pequeños, exigir comentario sustantivo mínimo, revisores rotativos (punto 3).

**Riesgos:** falsa sensación de control.

**Solución:** revisión con criterio y capas (punto 2).

**Cómo se evita:** muestreo: ¿qué capas se cubrieron? (Error 4).

---

### Error 4: revisar al revés (estilo antes que corrección)

**Qué ocurrió:** 15 comentarios de naming en un PR que pedía lo incorrecto.

**Por qué:** sin orden de capas (punto 2).

**Cómo comprobarlo:** primer comentario del historial: ¿estilo o «¿resuelve?».

**Opciones:** ordenar los comentarios por capa; checklist que empieza por «¿es lo pedido?».

**Riesgos:** lo correcto decide tarde o nunca.

**Solución:** capas en orden (punto 2).

**Cómo se evita:** plantilla de revisión con las capas.

---

### Error 5: todo bloqueante o nada bloqueante

**Qué ocurrió:** o el PR no avanzaba por nits, o se aprobaba todo sin condición.

**Por qué:** sin distinción severidad (punto 2).

**Cómo comprobarlo:** etiquetas/bloqueos: ¿se distingue «debe» de «sugiero»?

**Opciones:** convención: bloqueante = defecto/riesgo; sugerencia = estilo/mejora.

**Riesgos:** o parálisis o control nulo.

**Solución:** dos categorías claras (punto 2).

**Cómo se evita:** acordar categorías en el equipo y escribirlas.

---

### Error 6: revisión «cuando haya tiempo»

**Qué ocurrió:** PRs fríos: conflictos y redescubrimiento de contexto.

**Por qué:** sin ritmo (punto 3).

**Cómo comprobarlo:** mediana «PR abierto → primera revisión».

**Opciones:** SLA + pull de revisión antes de abrir más (punto 3).

**Riesgos:** lead time gigante (sección 01 de esta sección).

**Solución:** plazo explícito (punto 3).

**Cómo se evita:** la métrica vive en la retro (sección 24 cap. 06).

---

### Error 7: revisión como duelo personal

**Qué ocurrió:** comentarios hostiles; el autor dejó de abrir PRs con calma.

**Por qué:** trato (punto 3).

**Cómo comprobarlo:** tono de los hilos; si se comentan personas o solo código.

**Opciones:** acuerdos de equipo («comenta el código, explica el porqué»), rotar revisores.

**Riesgos:** miedo a compartir = menos revisión y más producción en caliente.

**Solución:** trato + rotación (punto 3).

**Cómo se evita:** cultura de sección 00/16 recordada en onboarding.

---

### Error 8: release por impresión

**Qué ocurrió:** «está listo» dicho en una reunión; salió sin changelog ni dueño; un fallo no se revirtió a tiempo.

**Por qué:** sin checklist ni proceso (punto 4).

**Cómo comprobarlo:** ¿última release: checklist, etiqueta, notas, humo? ¿quién aprobó?

**Opciones:** definition of done + dueño de release + proceso antes/después (punto 4).

**Riesgos:** releases heroicos y fallos sin dueño.

**Solución:** proceso completo (punto 4).

**Cómo se evita:** plantilla de release en el repo.

---

## 6. Práctica guiada

### Objetivo

Convertir tu revisión y tu release en sistemas con capas, plazos y proceso.

### Paso 1: diagnóstico de revisión

```text
Últimos 10 PRs:
   │
   ├── mediana a primera revisión: ____
   ├── comentarios por PR: ____ (¿estilo o capas?)
   └── ¿revisor asignado siempre? sí/no
```

### Paso 2: checklist de capas

1. Escribe tu checklist de revisión con las 5 capas (punto 2) y dónde vive (PR template).

### Paso 3: reglas del trato

1. Acuerda: bloqueante vs. sugerencia, tono, rotación (punto 2/3). Añádelo al template en 3 líneas.

### Paso 4: definition of done

1. Escribe la «hecho» de tu proyecto: código + tests + docs + seguridad + ¿comunicado? (punto 4).

### Paso 5: proceso de release

```text
ANTES: checklist + quién aprueba
DURANTE: tag + artefacto + staging
DESPUÉS: humo + observabilidad + rollback en marcha
```

1. Prueba el «DESPUÉS» en papel con el último release: ¿habrías detectado un fallo?

### Paso 6: publica

1. `docs/flujo.md` (de la sección anterior) + PR template + release checklist, enlazados.

### Resultado esperado

Métricas de revisión, checklist de capas, definition of done y proceso de release con dueño y vuelta atrás.

### Conclusión esperada

Revisar y liberar son el mismo oficio en dos momentos: asegurar que lo que entra es pensado y que lo que sale es predecible — ambos con capas, plazos y responsables, no con prisas ni corazonadas.

---

## 7. Nivel profesional + resumen

### 7.1. A escala

```text
   │
   ├── revisión como métrica de equipo (no de
   │   personas): tiempo de PR, capas cubiertas,
   │   incidentes post-aprobación (Error 3
   │   prevención)
   │
   ├── release train: calendario compartido de
   │   releases cuando hay muchos componentes
   │   (sección 25 cap. 04)
   │
   ├── release como rol rotativo (el «dueño de
   │   release» de la semana — Error 8 prevención)
   │
   ├── comunicados y notas versionadas como hábito
   │   (sección 14/17)
   │
   └── métricas: frecuencia y fallo de release, MTTR
       de rollback, sugerencias por PR (calidad de la
       revisión)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* la revisión es sistema: PR claro, revisor, plazo, checklist, gates y decisión;
* las 5 capas (¿resuelve? ¿correcto? ¿mantenible? ¿observable/reversible? ¿probado?) ordenan la mirada — lo correcto antes que lo estético;
* máquina para estilo, humanos para diseño; bloqueante y sugerencia son categorías distintas;
* el trato y la rotación sostienen el conocimiento y la motivación;
* la release madura tiene ANTES/DURANTE/DESPUÉS, definition of done, dueño y vuelta atrás probada;
* los errores típicos (sin dueño, revisión de máquina a mano, decorativa, al revés, categorías confusas, «cuando haya tiempo», duelo, release por impresión) se previenen con sistema y métricas;
* a nivel profesional: métricas de equipo, release train y rol rotativo.

La idea principal es:

> **La calidad no se añade después: se asegura en la entrada con revisión que mira lo importante y se demuestra en la salida con releases que alguien puede repetir, comunicar y revertir.**

---

## Próximo paso

Ya revisas con capas y liberas con proceso.

Ahora la capa de gobierno: cómo se sostienen estándares, seguridad y automatización cuando el equipo crece.

Continúa con:

[`03-gobernanza-seguridad-y-automatizacion.md`](03-gobernanza-seguridad-y-automatizacion.md)
