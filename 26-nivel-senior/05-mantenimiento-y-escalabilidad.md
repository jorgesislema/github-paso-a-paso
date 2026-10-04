# Mantenimiento y escalabilidad

## Introducción

Un sistema que funciona hoy tiene dos deudas pendientes con el futuro: **mantenerlo** (que no se oxide) y **escalarlo** (que aguante el crecimiento sin rediseño de pánico). Los dos problemas se parecen: ambos se pagan con anticipación y se pierden por la prisa. Este capítulo aplica la mirada senior al largo plazo — desde el mantenimiento de la sección 25 cap. 05 hasta las señales de que algo crece: gente, carga o complejidad, cada una con su remedio distinto.

---

## Mapa conceptual de este capítulo

```text
Mantenimiento y escalabilidad
       │
       ├── 1. Mantenimiento como presupuesto (no heroísmo)
       ├── 2. Las tres escalas (gente, sistema,
       │   complejidad)
       │   ├── 3. Señales: cuándo actuar (deuda visible)
       │   └── 4. Refactorizar a escala (sin rediseños
       │       de pánico)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Mantenimiento como presupuesto (no heroísmo)

```text
LO QUE YA SABES (sección 25 cap. 05 — aquí el giro):
   │
   ├── calendario con dueños (dependencias, accesos,
   │   limpiezas)
   ├── deuda visible y pagada con % de capacidad
   └── etapas declaradas por repo
```

```text`
EL GIRO SENIOR:
   │
   ├── el mantenimiento es PRESUPUESTO: tiene % en el
   │   plan y se defiende en la planificación (Error
   │   1 si vive del «excedente» — nunca hay
   │   excedente)
   │
   ├── el mantenimiento es RIESGO: se prioriza por
   │   impacto (CVE crítico > carpeta fea > renombre)
   │   (Error 2 si se paga por orden de comodidad)
   │
   └── el mantenimiento es VISIBLE: la retro muestra
       pagado vs. acumulado (sección 24 cap. 06 —
       Error 3 si nadie lo mira)
```

```text
   │
   └── quién NO presupuesta mantenimiento termina
       pagando con incendios: el presupuesto existe
       igual, solo que en forma de crisis (Error 1)
```

---

## 2. Las tres escalas (gente, sistema, complejidad)

```text
ESCALA DE GENTE (más personas):
   │
   ├── síntoma: reuniones para entender cambios,
   │   conflictos de estilo, PRs que nadie conoce
   │   enteros
   │
   └── remedio: límites y dueños (sección 25 cap. 02),
       CODEOWNERS, onboarding (sección 16), estándares
       que evitan discusión (sección 25 cap. 03)
```

```text
ESCALA DE SISTEMA (más carga/datos/uso):
   │
   ├── síntoma: CI más lento, builds largos, tiempos de
   │   respuesta que empeoran linealmente
   │
   └── remedio: presupuesto de CI (sección 25 cap. 04),
       cachés, impacto acotado, medición (sección 23
       cap. 06), rendimiento como métrica
```

```text
ESCALA DE COMPLEJIDAD (más piezas entrelazadas):
   │
   ├── síntoma: cambios que tocan N componentes, miedo
   │   a tocar nada, onboarding de meses
   │
   └── remedio: desacoplar por interfaces (sección 25
       cap. 02), decisión de arquitectura registrada
       (sección 25 cap. 06), retirar lo muerto (sección
       25 cap. 05)
```

```text
   │
   └── el error senior es aplicar el remedio de una
       escala a otra: más gente no arregla complejidad;
       rediseñar arquitectura no arregla mala
       comunicación (Error 4 — Error 1 sección 25 cap. 06: contexto
       primero)
```

---

## 3. Señales: cuándo actuar (deuda visible)

```text
TABLERO DE SEÑALES (las que un senior mira):
   │
   ├── personas: ¿el onboarding tarda más? ¿los PRs
   │   esperan más revisión?
   │
   ├── CI/pipeline: ¿duración creciente? ¿flaky
   │   subiendo? (Error 5 si se normaliza el rojo)
   │
   ├── incidentes: ¿frecuencia y MTTR empeoran? ¿se
   │   repiten? (sección 26 cap. 04 punto 4)
   │
   ├── deuda: ¿backlog > 90 días crece? (sección 25
   │   cap. 05)
   │
   └── dependencias: ¿versiones vencidas acumulándose?
       (sección 20 cap. 03)
```

```text
   │
   └── actuar ANTES de que la señal sea crisis: la
       deuda cuesta más tarde (Error 5 — Error 3
       sección 25 cap. 05)
```

```text
CÓMO SE DECIDE EL ORDEN (priorización senior):
   │
   ├── 1. riesgo (seguridad, pérdida de datos)
   ├── 2. frecuencia de dolor (cuánta gente sufre)
   └── 3. costo de postergar (interés compuesto de la
       deuda)
```

---

## 4. Refactorizar a escala (sin rediseños de pánico)

```text
REGLAS DEL GRAN CAMBIO (Error 6 si se rompen):
   │
   ├── con tests primero (sección 22 cap. 03): lo que
   │   no está probado no se mueve
   │
   ├── por partes, con el sistema VERDE al final de
   │   cada PR (sección 08 — operaciones delicadas)
   │
   ├── expand/contract: cambiar compatible primero,
   │   limpiar después (sección 22 cap. 06)
   │
   ├── desgate: rama corta, integrar a menudo (Error
   │   6 — Error 5 sección 25 cap. 05: ramas eternas)
   │
   └── decisión escrita antes (ADR — sección 25 cap.
       06 Error 6): «qué cambiamos y por qué»
```

```text
   │
   └── el rediseño de pánico («borremos y empecemos»)
       es el Error 1
       de la sección 25 cap. 05 punto 5: migra solo si
       el dolor lo justifica (Error 7)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: mantenimiento sin presupuesto

**Qué ocurrió:** «mantenimiento cuando acabe» — tres años de «acabar».

**Por qué:** no tiene % en el plan (punto 1).

**Cómo comprobarlo:** ¿algún ciclo dedicó horas etiquetadas a mantenimiento?

**Opciones:** fijar % (10–20) y defenderlo en planificación; métrica «pagado vs. acumulado».

**Riesgos:** crisis como forma de pago.

**Solución:** presupuesto (punto 1).

**Cómo se evita:** la retro lo pregunta.

---

### Error 2: pagar deuda por orden de comodidad

**Qué ocurrió:** se arreglaron carpetas bonitas mientras un CVE alto esperaba semanas.

**Por qué:** sin prioridad por riesgo/impacto (punto 1/3).

**Cómo comprobarlo:** orden del backlog vs. orden de la tabla del punto 3.

**Opciones:** priorizar con la tabla; dueño de la cola.

**Riesgos:** peaje caro donde no duele.

**Solución:** riesgo → frecuencia → costo (punto 3).

**Cómo se evita:** el backlog se revisa con dueños (sección 25 cap. 05).

---

### Error 3: nadie mira las señales

**Qué ocurrió:** CI pasó de 8 a 25 minutos durante un trimestre; se enteraron por una queja.

**Por qué:** sin tablero (punto 3).

**Cómo comprobarlo:** ¿dónde están las señales hoy? ¿URL?

**Opciones:** tablero mínimo con 4–5 métricas (punto 3) — empieza con CI y MTTR.

**Riesgos:** crisis evitables.

**Solución:** tablero de señales (punto 3).

**Cómo se evita:** señales en la retro (sección 24 cap. 06).

---

### Error 4: remedio de la escala equivocada

**Qué ocurrió:** con más gente llegaron más conflictos y la respuesta fue «más estándares»; el problema era acoplamiento técnico.

**Por qué:** escala diagnosticada mal (punto 2).

**Cómo comprobarlo:** ¿qué crece: gente, carga o piezas? ¿el remedio apunta ahí?

**Opciones:** rediagnosticar con las tres escalas; aplicar el remedio correspondiente.

**Riesgos:** esfuerzo inútil y frustración.

**Solución:** las tres escalas (punto 2).

**Cómo se evita:** la pregunta «¿qué es lo que está creciendo?» en la retro.

---

### Error 5: normalizar el CI rojo/flaky

**Qué ocurrió:** «ese test falla a veces» — dejaron de mirarlo; un fallo real se escondió en el ruido.

**Por qué:** se aceptó la señal como clima (punto 3).

**Cómo comprobarlo:** % de runs rojos y su tendencia.

**Opciones:** cuarentena del flaky con fecha de arreglo; cero tolerancia al rojo normal.

**Riesgos:** ceguera de calidad.

**Solución:** endurecer donde rompe (sección 01 de esta sección punto 4).

**Cómo se evita:** métrica de estabilidad en la retro.

---

### Error 6: rama eterna de refactor

**Qué ocurrió:** el «cambio grande» llevó 3 meses en rama; al mergear, 60 conflictos.

**Por qué:** se rompieron las reglas del gran cambio (punto 4).

**Cómo comprobarlo:** edad de la rama y tamaño del diff.

**Opciones:** partir en PRs verdes; expand/contract; integrar a menudo.

**Riesgos:** el gran merge apocalíptico.

**Solución:** partes con verde continuo (punto 4).

**Cómo se evita:** regla: ninguna rama vive > días acordados (sección 25 cap. 05).

---

### Error 7: rediseño de pánico

**Qué ocurrió:** «esto ya no sirve, empecemos de cero» — se perdió historial, aprendizaje y meses.

**Por qué:** dolor sin análisis de reversibilidad (Error 1 sección 25 cap. 06 punto 2).

**Cómo comprobarlo:** ¿hay ADR? ¿tabla de consecuencias? ¿plan de migración?

**Opciones:** evolucionar por partes (punto 4) o decidir migración con proceso completo (sección 25 cap. 01 punto 5).

**Riesgos:** empezar dos veces el mismo infierno.

**Solución:** proceso de decisión (sección 25 cap. 06).

**Cómo se evita:** rigor proporcional a lo irreversible (Error 5 sección 25 cap. 06).

---

## 6. Práctica guiada

### Objetivo

Poner en orden el largo plazo: presupuesto, señales y un gran cambio controlado.

### Paso 1: presupuesto

```text
Mantenimiento este ciclo: ____ % (hoy: ____)
Dueño de la cola: ____
```

1. Incluye la partida en la próxima planificación — aunque sea pequeña.

### Paso 2: tablero de señales

1. Elige 4: CI duration, % rojo/flaky, MTTR/reincidencias, deuda > 90 días. ¿Dónde vive? (una página).

### Paso 3: diagnostica tu escala

```text
¿Qué crece? gente / sistema / complejidad
Remedio correspondiente (punto 2): ____
```

### Paso 4: prioriza la cola

1. Ordena tu backlog con la tabla del punto 3 (riesgo → frecuencia → costo). Reordena si estaba por comodidad.

### Paso 5: practica el gran cambio

1. Toma un refactor pendiente y escríbelo con las reglas del punto 4: ADR, fases expand/contract, «verde al final de cada PR», rama corta.

### Paso 6: publica

1. Presupuesto + señales + reglas de gran cambio en `docs/mantenimiento.md`, enlazado en la retro y en el flujo.

### Resultado esperado

Partida en el plan, tablero con 4 señales, escala diagnosticada y un refactor planificado por fases.

### Conclusión esperada

El largo plazo no se improvisa: se presupuesta, se mide y se divide en trozos verdes — quien hace eso rara vez necesita el rediseño heroico.

---

## 7. Nivel profesional + resumen

### 7.1. A escala

```text
   │
   ├── mantenimiento como SERVICIO compartido: cola
   │   única con dueños y SLA por tipo de tarea (Error
   │   Error 1 prevención)
   │
   ├── señales consolidadas: tablero del ecosistema
   │   (no solo un repo) con alertas de tendencia
   │
   ├── escalas diagnosticadas por revisión semestral:
   │   ¿qué está creciendo y qué remediaremos? (sección
   │   05 cap. 25 — revisión de cartera)
   │
   ├── gran cambio como proyecto: ADR, fases, riesgos,
   │   fecha, revisión (sección 25 cap. 06 — rigor
   │   proporcional)
   │
   └── métricas: % capacidad de mantenimiento usada,
       señales en tendencia, edad de mayor deuda, duración
       de grandes cambios
```

### 7.2. Resumen

En este capítulo aprendiste que:

* mantenimiento = presupuesto con dueño, priorizado por riesgo y visible en la retro;
* tres escalas con remediación distinta: gente (límites/dueños), sistema (presupuesto/medición), complejidad (interfaces/desacoplar);
* señales tempranas (CI, flaky, incidentes, deuda, dependencias) deciden cuándo actuar;
* refactorizar a escala: tests, partes verdes, expand/contract, rama corta y ADR antes;
* los errores típicos (sin presupuesto, cola por comodidad, señales ignoradas, remedio equivocado, flaky normalizado, rama eterna, rediseño de pánico) se previenen con disciplina de proceso;
* a nivel profesional: cola de mantenimiento con SLA y revisión semestral de escala.

La idea principal es:

> **El largo plazo se gana en pequeñas decisiones repetidas — presupuesto, señales y trozos verdes — porque el rediseño heroico es siempre la versión más cara de lo que pudo hacerse en partes.**

---

## Próximo paso

Ya sostienes el presente y preparas el crecimiento.

La pieza final del nivel: cómo se toman las decisiones técnicas.

Continúa con:

[`06-decisiones-tecnicas.md`](06-decisiones-tecnicas.md)
