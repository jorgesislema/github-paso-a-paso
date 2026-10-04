# Observabilidad

## Introducción

Si DevOps es un bucle (cap. 01), la observabilidad es su sensor: métricas, logs y trazas que responden «¿está bien?» y «¿por qué está mal?». Sin ella, los despliegues son fe y los incidentes se descubren por los usuarios. Este capítulo cubre las tres patas clásicas, las alertas que despiertan (y las que molestan), el concepto de SLI/SLO como acuerdo de «bien», y cómo la observabilidad alimenta decisiones — el otro extremo del bucle.

---

## Mapa conceptual de este capítulo

```text
Observabilidad
       │
       ├── 1. Las tres patas: métricas, logs, trazas
       ├── 2. Alertas: que despierten solo cuando toca
       │   ├── 3. SLI y SLO: qué significa «bien»
       │   ├── 4. De la señal a la decisión
       │   └── 5. Dashboards que se usan (y los que no)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Las tres patas: métricas, logs, trazas

```text
MÉTRICAS — «¿cómo va?» (agregadas, baratas, rápidas)
   │
   ├── latencia, errores, tráfico, saturación
   │   (las cuatro señales de oro — mención: SEÑALES
   │   útiles para servicios)
   └── para gráficas y alertas
```

```text
LOGS — «qué pasó» (eventos concretos, con contexto)
   │
   ├── mensajes estructurados (nivel, timestamp,
   │   request-id, versión)
   │
   └── para investigar UN caso concreto
```

```text
TRAZAS — «por dónde pasó» (el viaje de una petición)
   │
   ├── seguimiento de una solicitud a través de varios
   │   servicios
   │
   └── para encontrar EL cuello de botella o la
       falla en cadena (mención: distribuidos)
```

```text
EN GITHUB (dónde se ve lo tuyo pequeño):
   │
   ├── Actions: métricas de CI (duración, fallos —
   │   sección 19 cap. 06)
   │
   ├── aplicaciones: tus propios logs y métricas
   │   (aquí se enseña el concepto; la herramienta
   │   depende del proyecto)
   │
   └── el principio es lo mismo en cualquier stack
```

```text
   │
   └── las tres responden preguntas distintas: sin
       métricas no sabes que algo va mal; sin logs no
       sabes qué es; sin trazas no sabes dónde (Error
       1 si solo tienes una)
```

---

## 2. Alertas: que despierten solo cuando toca

```text
TIPOS DE ALERTA:
   │
   ├── basadas en SLO/incumplimiento de objetivo →
   │   acciones claras (cap. 03)
   │
   └── basadas en síntomas de usuario (errores,
       latencia) — NO en causas internas («CPU alta»
       con usuarios felices no es incidente)
```

```text
SIEMPRE (para cada alerta):
   │
   ├── severidad clara
   ├── mensaje: qué ocurre + posible causa + enlace al
   │   runbook (sección 22 cap. 06)
   └── destinatario: canal/turno con DUEÑO (sección 16
       / 22 cap. 01 Error 2)
```

```text
   │
   └── alerta sin acción posible = ruido = la gente
       deja de mirar (Error 2) — como los tests flaky
       de la sección 03: la alarma que no se cree es
       peor que no tenerla
```

```text
BUENA HIGIENE:
   │
   ├── «no alertar por alertas despierten»: rotación,
   │   deduplicación, horarios
   │
   └── revisión periódica: ¿esta alerta ha sido útil?
       si no, se retira o se cambia (Error 3)
```

---

## 3. SLI y SLO: qué significa «bien»

```text
CONCEPTOS:
   │
   ├── SLI (indicador): la medición — p. ej. % de
   │   respuestas correctas < 500 ms
   │
   └── SLO (objetivo): la promesa interna — p. ej.
       «99,5% correctas en 30 días»
```

```text`
POR QUÉ IMPORTA:
   │
   ├── define «incidente»: si vas por debajo del SLO,
   │   hay que actuar (umbral objetivo, no gustos —
   │   sección 22 cap. 06 Error 1)
   │
   ├── da margen: un error sube pero no rompe el SLO
   │   → se puede observar en frío
   │
   └── convierte la observabilidad en DECISIÓN
       (punto 4)
```

```text
   │
   └── sin SLO, cada caída se debate «¿está malo?» en
       caliente — con SLO, la respuesta ya existía
       (Error 4)
```

---

## 4. De la señal a la decisión

```text
EL BUCLE CERRADO (sección 01 cap. 03):
──────────────────────────────────────────────────────
señal → diagnóstico → decisión → cambio (código,
config, proceso) → entrega (CI/CD) → nueva señal
```

```text
USOS CONCRETOS:
   │
   ├── post-mortem: la línea temporal sale de logs y
   │   métricas (sección 26)
   │
   ├── error budget: «cuánto error podemos cometer» →
   │   ¿innovamos o estabilizamos? (decisión de
   │   roadmap — sección 26)
   │
   └── retro: las métricas de flujo (sección 01 cap.
       05) también son observabilidad del PROCESO
```

```text
   │
   └── lo que no se mide no se gestiona; lo que se
       mide sin decidir es museo (Error 5)
```

---

## 5. Dashboards que se usan (y los que no)

```text
UN DASHBOARD ÚTIL:
   │
   ├── empieza por: ¿está sano? → ¿qué cambió? →
   │   ¿por dónde voy?
   │
   ├── versionado donde sea posible (los paneles
   │   como código — cap. 04)
   │
   └── dueño: quién responde si miente
```

```text
SEÑALES DE DASHBOARD MUERTO:
   │
   ├── nadie lo abre fuera del incidente
   ├── 30 paneles y «¿dónde miro?»
   └── nadie sabe de dónde salen los datos
```

```text
   │
   └── empezar con DOS paneles buenos (servicio y
       proceso) es mejor que 30 decorativos (Error 6)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: solo logs (o solo métricas)

**Qué ocurrió:** latencia alta sin contexto: en métricas se ve «algo subió»; sin logs/trazas no se encontraba dónde.

**Por qué:** se montó una sola pata (punto 1).

**Cómo comprobarlo:** ¿puedes responder: qué servicio, qué endpoint, qué petición?

**Opciones:** añadir la pata que falta (logs estructurados / métricas por endpoint / trazas si es distribuido).

**Riesgos:** ciegas distintas según el tipo de fallo.

**Solución:** las tres preguntas (punto 1).

**Cómo se evita:** checklist de observabilidad al crear el servicio (sección 18/26).

---

### Error 2: alertas que nadie mira

**Qué ocurrió:** canal de alertas silencioso por costumbre — «es que siempre hay 40 mensajes».

**Por qué:** ruido sin dueño ni acción (punto 2).

**Cómo comprobarlo:** cuántas alertas semanales y cuántas terminaron en acción.

**Opciones:** reducir a síntomas+SLO, runbook por alerta, canal con turno; retirar el resto.

**Riesgos:** el incidente real se pierde.

**Solución:** alerta = acción posible (punto 2).

**Cómo se evita:** revisión mensual de alertas.

---

### Error 3: alertas de causas internas

**Qué ocurrió:** CPU al 80% despertaba al turno y no había nada que hacer (la app aguantaba).

**Por qué:** alerta de causa sin síntoma (punto 2).

**Cómo comprobarlo:** ¿qué haces cuando suena? Si la respuesta es «esperar», sobra.

**Opciones:** cambiar a síntomas de usuario (errores, latencia, saturación real); mantener lo interno como panel, no como alarma.

**Riesgos:** fatiga de alertas.

**Solución:** síntomas > causas (punto 2).

**Cómo se evita:** criterio escrito en la plantilla de alertas.

---

### Error 4: «¿está malo?» sin umbral

**Qué ocurrió:** una caída del 15% se discutió 40 minutos en chat y no se actuó.

**Por qué:** no había SLO (punto 3).

**Cómo comprobarlo:** ¿existe un objetivo escrito y medible?

**Opciones:** definir SLI/SLO mínimos para servicios críticos; derivar alertas de ahí.

**Riesgos:** debate en caliente y acciones tardías.

**Solución:** «bien» definido antes (punto 3).

**Cómo se evita:** parte del diseño del servicio (sección 18/26).

---

### Error 5: métricas sin decisión

**Qué ocurrió:** gráficas perfectas, backlog intacto — nadie conectaba los puntos.

**Por qué:** señal sin proceso de decisión (punto 4).

**Cómo comprobarlo:** última decisión motivada por un panel.

**Opciones:** anclar cada métrica a una pregunta y a un foro (retro, revisión, post-mortem); error budget como decisión de roadmap.

**Riesgos:** museo de datos.

**Solución:** señal → decisión (punto 4).

**Cómo se evita:** la retro usa el panel (sección 26).

---

### Error 6: dashboard-monumento

**Qué ocurrió:** 30 paneles heredados; el equipo miraba solo 2 y no sabía cuáles eran.

**Por qué:** crecimiento sin curaduría (punto 5).

**Cómo comprobarlo:** ¿puede alguien nuevo encontrar «¿está sano?» en 30 segundos?

**Opciones:** reducir a los imprescindibles; dueño; versionar.

**Riesgos:** parálisis por información.

**Solución:** pocos y buenos (punto 5).

**Cómo se evita:** curaduría en la revisión trimestral.

---

## 7. Práctica guiada

### Objetivo

Montar el mínimo vital de observabilidad para tu proyecto y un acuerdo de «bien».

### Paso 1: tres preguntas

```text
Tu servicio/app pequeño:
   │
   ├── ¿está sano?      → health + métricas básicas
   │                        (latencia, errores)
   ├── ¿qué cambió?     → logs con versión y
   │                        request-id
   └── ¿por dónde voy?  → el mismo desde un cambio
```

1. Apunta qué te falta de cada pata.

### Paso 2: logs estructurados

1. Asegura en los logs: timestamp, nivel, identificador de petición, versión del servicio.
2. Regla: sin secretos ni datos personales en logs (sección 20/21 cap. 04 Error 3).

### Paso 3: primer SLO

```text
Ejemplo:
   │
   ├── SLI: respuestas correctas (no-5xx) y latencia
   │   p95 < 500 ms
   └── SLO: 99% correctas / 30 días (y latencia
       cumplida el 99% del tiempo)
```

1. Escríbelo en `docs/slo.md` — aunque sea simple.

### Paso 4: alerta con acción

```text
Primera alerta:
   │
   ├── síntoma (errores > X% durante Y min)
   ├── acción: «abrir runbook /rollback» (paso 1)
   └── destinatario: canal con dueño
```

1. Verifica que la alerta manda a un lugar con nombre (no al vacío).

### Paso 5: dashboard mínimo

1. Un panel: latencia, errores, tráfico, y la versión desplegada superpuesta (punto 4: «¿qué cambió?»).

### Paso 6: cerrar el bucle

1. Toma una señal cualquiera de hoy y escribe la mini-cadena: señal → diagnóstico → decisión → qué cambiaría (punto 4).

### Resultado esperado

Tres patas mínimas, SLO escrito, alerta con acción y panel de dos tiempos (sano / cambió).

### Conclusión esperada

La observabilidad no es coleccionar datos: es tener las respuestas correctas a tiempo — y un acuerdo escrito de cuándo esas respuestas importan.

---

## 8. Nivel profesional + resumen

### 8.1. Observabilidad a escala

```text
   │
   ├── SLOs por servicio con error budgets y revisión
   │   de roadmap (punto 4 — sección 26)
   │
   ├── alertas como código con revisiones (cap. 04)
   │
   ├── trazas distribuidas cuando hay varios
   │   servicios (mención: herramientas de la
   │   categoría)
   │
   ├── logs centralizados con retención y permisos
   │   (datos sensibles — sección 20)
   │
   ├── post-mortems alimentados por la línea temporal
   │   real (sección 26/24)
   │
   └── métrica: MTTR (tiempo de restauración — sección
       01 cap. 05), % alertas con acción, dashboards
       con dueño
```

### 8.2. Resumen

En este capítulo aprendiste que:

* tres patas: métricas (¿cómo va?), logs (¿qué pasó?), trazas (¿por dónde?) — para tres preguntas;
* alertas de síntomas con acción, dueño y runbook — el ruido mata la alarma;
* SLI/SLO: «bien» definido antes del incidente; umbral objetivo, no debate;
* señal → decisión: post-mortems, error budgets y retiros que conectan datos con cambios;
* dashboards: pocos, dueños, versionados — la curaduría es parte del trabajo;
* los errores típicos (una pata sola, alertas ciegas, alertas de causas, sin umbral, datos sin decisión, monumentos) se previenen con diseño y revisión;
* a nivel profesional: SLOs con error budgets y métricas de restauración.

La idea principal es:

> **Observar no es mirar: es tener preguntas escritas — «¿está bien?», «¿qué cambió?», «¿por dónde voy?» — con señales, umbrales y dueños que las convierten en decisiones antes de que las contesten los usuarios.**

---

## Próximo paso

Has completado la sección de DevOps.

Continúa con el cierre:

[`README.md`](README.md)
