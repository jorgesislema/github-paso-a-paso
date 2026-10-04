# Decisiones técnicas

## Introducción

Todo el curso converge aquí: la pregunta senior no es «¿qué comando?» sino **«¿qué estrategia resuelve mejor este problema para este equipo y este proyecto?»** — y esa pregunta se responde con un método. Este capítulo cierra la sección de nivel senior con el oficio de decidir en terreno técnico complejo: marco de decisión, comunicación, ejecución y reversibilidad, integrando el ADR de la sección 25 cap. 06 a todo lo demás que has estudiado: flujos, releases, seguridad, escalas y recuperación.

---

## Mapa conceptual de este capítulo

```text
Decisiones técnicas
       │
       ├── 1. Qué hace «técnica» a una decisión
       ├── 2. El método completo (seis pasos)
       │   ├── 3. Comunicar la decisión (quién y cómo)
       │   └── 4. Ejecutar y revertir (la decisión vive
       │       después)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué hace «técnica» a una decisión

```text
DECISIÓN TÉCNICA = elegir entre opciones con
CONSECUENCIAS técnicas verificables
   │
   ├── no es opinión: las opciones se pueden PROBAR
   │   (piloto, benchmark, spike — Error 1 si «decidir»
   │   es solo discutir)
   │
   ├── no es irreversible por defecto: se valora el
   │   coste de cambio (Error 2 si se trata igual lo
   │   reversible que lo irreversible — Error 5
   │   sección 25 cap. 06)
   │
   └── no es individual cuando cruza límites: dueños
       afectados opinan y deciden con proceso (Error 4 sección 03 cap. 25)
```

```text
DOMINIOS DE ESTA SECCIÓN (dónde decide un senior):
   │
   ├── flujo: workflows y ramas (cap. 01)
   ├── calidad: revisión y releases (cap. 02)
   ├── gobierno: seguridad y automatización (cap. 03)
   ├── resiliencia: incidentes y desastres (cap. 04)
   └── evolución: mantenimiento y escala (cap. 05)
```

```text
   │
   └── la decisión técnica madura RESUELVE TENSIÓN:
       siempre hay un trade-off (velocidad vs. control,
       estricto vs. simple, ahora vs. después) — el
       senior no elimina la tensión, la ELIGE con
       conocimiento (Error 3 si se busca la opción sin
       pago)
```

---

## 2. El método completo (seis pasos)

```text
LOS SEIS PASOS (síntesis del curso):
   │
   ├── 1. DEFINIR: qué problema, para quién, desde
   │      cuándo duele (Error 1 sección 25 cap. 06)
   ├── 2. CONTEXTO: factores reales — equipo, riesgo,
   │      escala, automatización (cap. 01 punto 1)
   ├── 3. OPCIONES: 2–4 reales + «no hacer nada»
   ├── 4. CONSECUENCIAS: tabla de ganamos/pagamos en
   │      términos propios (Error 3 prevención)
   ├── 5. REVERSIBILIDAD: ¿cuánto cuesta deshacer? →
   │      rigor proporcional (Error 2 prevención)
   └── 6. REGISTRO: ADR con «reevaluar si» (sección 25
          cap. 06 punto 3)
```

```text
DÓNDE ENTRA CADA HERRAMIENTA DEL CURSO:
   │
   ├── spike/piloto → probar opciones (Error 1)
   ├── benchmark → consecuencias en números (CI,
   │   rendimiento)
   ├── checklist de puertas → consecuencias de
   │   seguridad (sección 24)
   └── métricas → línea base ANTES de decidir (Error 3 — sección 24 cap. 06)
```

```text
   │
   └── seis pasos en una tarde para lo normal; semanas
       con RFC y varios dueños para lo irreversible —
       el MÉTODO es el mismo, el RITMO cambia (Error 2
       prevención)
```

---

## 3. Comunicar la decisión (quién y cómo)

```text
A QUIÉN (los círculos):
   │
   ├── ejecutores (a quien tocará hacerlo): PR del ADR,
   │   explicación de cambios
   ├── directamente afectados (otros equipos): aviso
   │   con plazo y migración
   └── ecosistema (todos): registro público en el repo
       (Error 4 si se decide en un canal privado)
```

```text
CÓMO (formato senior):
   │
   ├── una página: contexto → opciones → decisión →
   │   pagos → reevaluación
   │
   ├── honestidad con los PAGOS (Error 5 si solo se
   │   comunican ventajas: quien ejecuta descubre el
   │   precio solo)
   │
   └── plazo y dueño de la transición (no «ya»: cuándo
       y quién)
```

```text
   │
   └── la comunicación es PARTE de la decisión: una
       decisión correcta mal comunicada se ejecuta mal
       (Error 4)
```

---

## 4. Ejecutar y revertir (la decisión vive después)

```text
EJECUCIÓN:
   │
   ├── la decisión se convierte en trabajo: ADR →
   │   tareas con dueño y fecha (Error 6 si el ADR
   │   «cumplió» al publicarse)
   ├── piloto primero en lo que se pueda (Error 1)
   └── verificar: ¿la decisión produce lo esperado?
       (línea base vs. después — métricas)
```

```text
REVERSIÓN (Error 2 prevención):
   │
   ├── para lo irreversible: plan de vuelta escrito
   │   ANTES (rollback — Error 1 sección 26 cap.
   │   04)
   │
   ├── para lo reversible: ejecutar con más confianza
   │   (el coste de probar es bajo)
   │
   └── y la condición «reevaluar si»: el ADR nuevo que
       SUPERSEDE al viejo — nunca se borra la historia
       (Error 7 si la decisión se deshace «de facto»
       sin registro)
```

```text
   │
   └── cierre: cada decisión se revisa con su
       condición; quien ejecuta reporta de vuelta si la
       realidad contradice el ADR — esa es la señal de
       un equipo maduro (Error 7)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: discutir sin probar

**Qué ocurrió:** semanas de debate sobre herramientas sin un piloto de una tarde.

**Por qué:** se decidió sin evidencia (punto 2 paso 3).

**Cómo comprobarlo:** ¿alguna opción se ejecutó siquiera en sandbox?

**Opciones:** spike acotado (horas/días) con criterio de éxito escrito.

**Riesgos:** opinión vs. opinión, eternamente.

**Solución:** probar antes de decidir (punto 1/2).

**Cómo se evita:** «¿qué hemos probado?» es la primera pregunta de la revisión.

---

### Error 2: rigor uniforme para todo

**Qué ocurrió:** un rename de carpeta pasó por RFC de dos semanas; una migración irreversible se hizo «en un rato».

**Por qué:** no se valoró reversibilidad (punto 2 paso 5).

**Cómo comprobarlo:** ¿el proceso corresponde al coste de deshacer?

**Opciones:** matriz: reversible = rápido + registro breve; irreversible = RFC + respaldo + segunda aprobación.

**Riesgos:** ceremonia donde no importa; ligereza donde destruye.

**Solución:** rigor proporcional (Error 2 sección 25 cap. 06).

**Cómo se evita:** la pregunta «¿es reversible?» obligatoria (punto 2).

---

### Error 3: decidir sin pagos

**Qué ocurrió:** «usaremos X» sin columna de consecuencias; los pagos aparecieron en producción.

**Por qué:** se buscó la opción sin precio (punto 1/2 paso 4).

**Cómo comprobarlo:** ¿existe la tabla ganamos/pagamos?

**Opciones:** completar la tabla o reabrir la decisión.

**Riesgos:** factura oculta (Error 4 sección 25 cap. 06).

**Solución:** dos columnas siempre (punto 2).

**Cómo se evita:** quien aprueba pregunta primero «¿qué se paga?».

---

### Error 4: decisión en el canal equivocado

**Qué ocurrió:** se acordó en un hilo privado; un equipo entero ejecutó lo contrario.

**Por qué:** círculos de comunicación saltados (punto 3).

**Cómo comprobarlo:** ¿los ejecutores lo supieron antes de empezar?

**Opciones:** comunicar por círculos con plazo; registro público en el repo.

**Riesgos:** retrabajo y desconfianza.

**Solución:** comunicar a quien ejecuta, con plazo (punto 3).

**Cómo se evita:** plantilla de comunicación en el proceso (punto 3).

---

### Error 5: solo ventajas en la comunicación

**Qué ocurrió:** la adopción vendió «todo mejora»; al llegar los pagos, nadie los anticipó y hubo rechazo.

**Por qué:** pagos ocultos (punto 3).

**Cómo comprobarlo:** lee el anuncio: ¿menciona costes?

**Opciones:** reescribir honestamente: «gana X, paga Y hasta Z».

**Riesgos:** credibilidad de las próximas decisiones.

**Solución:** honestidad con los pagos (punto 3).

**Cómo se evita:** el ADR exige la tabla (punto 2).

---

### Error 6: ADR que nunca se ejecuta

**Qué ocurrió:** decisión publicada y sin tarea, dueño ni fecha; al año, sin cambios.

**Por qué:** no se convirtió en trabajo (punto 4).

**Cómo comprobarlo:** ¿qué tareas/PRs derivaron del ADR?

**Opciones:** al aceptar ADR: tareas, dueño y fecha; revisar en la retro.

**Riesgos:** documentación decorativa.

**Solución:** decisión → plan de ejecución (punto 4).

**Cómo se evita:** campo «implementar en / responsable» en la plantilla.

---

### Error 7: deshacer decisiones sin registro

**Qué ocurrió:** alguien «olvidó» la decisión y volvió al enfoque anterior en un PR; ahora hay dos realidades.

**Por qué:** sin revisión ni superseded (punto 4).

**Cómo comprobarlo:** ¿el código refleja un ADR vigente?

**Opciones:** elegir: aplicar el ADR o abrir ADR nuevo que lo reemplace; alinear código.

**Riesgos:** deriva y contradicción.

**Solución:** historial de decisiones vivo (Error 4 sección 25 cap. 06 punto 5).

**Cómo se evita:** revisión anual de cartera (Error 7 sección 25 cap. 06).

---

## 6. Práctica guiada

### Objetivo

Tomar una decisión técnica real con los seis pasos y llevarla a ejecución.

### Paso 1: elige la decisión

```text
Problema real pendiente (últimos meses):
____
Duele desde / evidencia: ____
```

1. Si no duele: aplica Error 1 sección 25 cap. 06 — decide «decidir después» con disparador.

### Paso 2: contexto y opciones

1. Factores (equipo, riesgo, escala, automatización) + 2–4 opciones reales + «no hacer nada».

### Paso 3: tabla

1. Consecuencias en tus términos. ¿Algún «pagamos» vacío? (Error 3).

### Paso 4: reversibilidad

1. ¿Cuánto cuesta deshacer? Ajusta el rigor (Error 2).

### Paso 5: ADR

1. `docs/decisiones/NNN-*.md`: contexto, tabla, decisión, pagos, «reevaluar si», implementar-en/responsable (paso 6 + Error 6 prevención).

### Paso 6: comunicar y ejecutar

1. Aviso a los círculos con plazo (punto 3).
2. Tareas con dueño; piloto si se puede; línea base para verificar (punto 4).

### Resultado esperado

ADR completo y aceptado, comunicación enviada, tareas creadas con responsable y métrica de verificación.

### Conclusión esperada

Decidir en nivel senior es un ciclo corto y serio: contexto, opciones con pagos, registro, comunicación y ejecución reversible — repetido muchas veces, es exactamente lo que se llama juicio técnico.

---

## 7. Nivel profesional + resumen

### 7.1. Decisiones a escala

```text
   │
   ├── umbrales: rápido (reversible, un dueño) ·
   │   normal (ADR + afectados) · alto (RFC, piloto,
   │   segunda mirada)
   │
   ├── cartera de decisiones: índice de ADRs con
   │   estados y fechas de revisión (sección 25 cap.
   │   06 Error 7)
   │
   ├── decisiones entre equipos: proceso ligero (proposición
   │   → dueños → registro) (Error 4 sección 03
   │   cap. 25)
   │
   ├── aprendizaje: decisiones revertidas se cuentan
   │   como aprendizaje, no como fracaso (Error 7 —
   │   la reversibilidad está para eso)
   │
   └── métricas: decisiones sin ejecutar, edad de
       supersedidas, tiempo decisión→implementación
```

### 7.2. Resumen

En este capítulo aprendiste que:

* una decisión técnica se prueba, valora su pago y mide su reversibilidad — no se discute indefinidamente;
* el método de seis pasos: definir, contexto, opciones, consecuencias, reversibilidad, registro;
* comunicar por círculos con pagos honestos y plazos: la decisión incluye su transición;
* ejecutar convierte el ADR en tareas con dueño y verificación; deshacer pasa por superseded, nunca por olvido;
* los errores típicos (sin probar, rigor uniforme, sin pagos, canal privado, solo ventajas, ADR sin ejecución, olvido del registro) se previenen con método;
* a nivel profesional: umbrales de rigor, cartera viva y decisiones revertidas como aprendizaje.

La idea principal es:

> **El juicio técnico no es intuición misteriosa: es método aplicado muchas veces — contexto, pagos, registro y ejecución — hasta que la pregunta «¿qué estrategia resuelve esto aquí?» se responde con calma.**

---

## Próximo paso

Has completado la sección de nivel senior.

Continúa con el cierre:

[`README.md`](README.md)
