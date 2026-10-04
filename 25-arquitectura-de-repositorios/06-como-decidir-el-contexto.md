# Cómo decidir: contexto y consecuencias

## Introducción

La sección entera ha evitado dar «la respuesta» de arquitectura — a propósito. Este capítulo cierra el ciclo enseñando el oficio detrás de cada decisión de la sección: **cómo analizar un contexto, sopesar consecuencias y dejar una decisión que otro pueda revisar**. No se trata de elegir bien para siempre, sino de elegir conscientemente y saber qué la invalidaría. Es la misma técnica que usarás en el resto de la carrera (sección 26 — decisiones técnicas), aplicada primero aquí, donde el error es recuperable.

---

## Mapa conceptual de este capítulo

```text
Cómo decidir: contexto y consecuencias
       │
       ├── 1. El marco en cinco preguntas
       ├── 2. Consecuencias: las dos columnas
       ├── 3. El registro: ADR ligero
       │   ├── 4. Caso de estudio completo
       │   └── 5. Revisar: cuándo una decisión caduca
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El marco en cinco preguntas

```text
TODA DECISIÓN DE ARQUITECTURA (sección 25) RESPONDE:
   │
   ├── 1. ¿QUÉ problema resuelve, para QUIÉN y desde
   │      cuándo duele? (si no duele, no decide — Error
   │      1)
   │
   ├── 2. ¿CUÁLES son las opciones REALES en nuestro
   │      contexto? (no las de los blogs: las que
   │      podemos operar)
   │
   ├── 3. ¿QUÉ paga cada opción? (la columna de
   │      consecuencias — punto 2)
   │
   ├── 4. ¿QUÉ nos ata a la decisión? (coste de
   │      cambio: ¿es reversible?)
   │
   └── 5. ¿QUÉ haría que cambie de opinión? (la
       condición de reevaluación — Error 2 si no
       existe)
```

```text
   │
   └── el orden importa: contexto ANTES que opciones;
       consecuencias ANTES que preferencias (Error 3
       si se empieza por «me gusta X»)
```

---

## 2. Consecuencias: las dos columnas

```text
TABLA DE DECISIÓN (sencilla y suficiente):
──────────────────────────────────────────────────────
        GANAMOS                    PAGAMOS
──────────────────────────────────────────────────────
opt. A   ...                        ...
opt. B   ...                        ...
opt. C   (incluye «no hacer nada»
         — también es opción)
```

```text
REGLAS DE LA TABLA:
   │
   ├── consecuencias en TÉRMINOS NUESTROS («CI de 8
   │   min» no «mejores prácticas»)
   │
   ├── cada «ganamos» busca su «pagamos» (Error 4 si
   │   una columna está vacía: o es magia o no se
   │   pensó)
   │
   └── se elige la opción cuyo PAGO puedes permitirte
       — no la que más promete (sección 25 cap. 01
       punto 1)
```

```text
   │
   └── coste de cambio (pregunta 4): si la opción es
       reversible (migrar después es barato), puedes
       decidir con menos ceremonia; si es CARO deshacer
       (borrar, historia fusionada, contrato público),
       el proceso merece más rigor (Error 5 si se
       trata igual lo reversible que lo irreversible)
```

---

## 3. El registro: ADR ligero

```text
ADR (Architecture Decision Record — registro de
decisión) — plantilla de una página:
   │
   ├── Título: qué se decidió
   ├── Fecha + quién decide
   ├── Contexto: las preguntas 1–2 (por qué ahora)
   ├── Decisión: la opción elegida
   ├── Consecuencias: la tabla (punto 2)
   ├── Reevaluar si: la pregunta 5
   └── Estado: propuesta → aceptada → (superseded por
       otra fecha — sección 04/25 cap. 01 Error 2)
```

```text
   │
   └── dónde vive: `docs/decisiones/NNN-*.md` en el
       repo — con el código que decide (Error 6 si
       vive en el wiki que nadie abre: el registro
       debe estar donde se trabaja)
```

```text
   │
   └── un ADR se escribe en MINUTOS; su valor es
       años (Error 6 — el Error 2 de la sección 03
       cap. 03 tiene esta solución exacta)
```

---

## 4. Caso de estudio completo

```text
CONTEXTO (inventado pero realista):
   │
   ├── equipo de 4, dos servicios + una librería
   │   compartida que cambia con ellos
   ├── CI ya ralentizándose (Error 3, sección 01)
   └── sin dueños de librería (Error 5, sección 01)
```

```text
LAS TRES COLUMNAS:
──────────────────────────────────────────────────────
              GANAMOS             PAGAMOS
multirepo     permisos, releases  cambios cruzados,
              por servicio        dispersión
              (sección 01)        de estándares
híbrido       lo mejor de ambos   dos formas de
              según zona          trabajar + frontera
                                  que mantener
monorepo      atomicidad, CI      impacto obligatorio,
              una vez (sección    gobernanza estricta
              04)                 (Error 3 si falla)
──────────────────────────────────────────────────────
```

```text
DECISIÓN (ejemplo de registro):
   │
   ├── elegida: híbrido — servicios en repos
   │   separados (permisos/ releases), librería +
   │   plantillas en repo común
   ├── razón: los servicios cambian por equipos
   │   distintos; la librería cambia CON los dos
   ├── paga: frontera y sincronización entre zonas
   ├── reversible?: parcialmente (fusionar después es
   │   obra)
   └── reevaluar si: la librería crece más que los
       servicios (entonces monorepo de libs)
```

```text
   │
   └── fíjate: no se demostró que la opción era
       «correcta» — se demostró que se entendía su
       precio y su caducidad (Error 1 — Error 2 de
       sección 06 Error 1)
```

---

## 5. Revisar: cuándo una decisión caduca

```text
DISPARADORES DE REVISIÓN (Error 7 si nunca se mira):
   │
   ├── la condición escrita: «reevaluar si Z» (los
   │   ADRs lo llevan)
   │
   ├── un incidente que la contradice (post-mortem →
   │   decisión — sección 24 cap. 06)
   │
   ├── cambios de contexto: nuevos equipos, regulación,
   │   escala ×10 (pregunta 1 — el problema cambió)
   │
   └── dolor repetido: el mismo «pagamos» aparece en
       tres retros seguidas
```

```text
   │
   └── revisar NO es rehacer: es confirmar que sigue
       vigente (10 minutos) o abrir un ADR nuevo que
       SUPERSEDE al viejo (se queda — nunca se borra:
       sección 25 cap. 05 Error 8)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: decidir algo que no duele

**Qué ocurrió:** semanas de ADRs para un repo de 5 archivos.

**Por qué:** sin la pregunta 1 (punto 1).

**Cómo comprobarlo:** ¿el problema existe medido o imaginado?

**Opciones:** decidir «no decidir todavía»: registro igual, en 3 líneas.

**Riesgos:** burocracia prematura (Error 4 de sección 15 — procesos de gigante).

**Solución:** rigor proporcional al dolor (punto 1/5).

**Cómo se evita:** la pregunta 1 es obligatoria en toda propuesta.

---

### Error 2: decisión sin «reevaluar si»

**Qué ocurrió:** la opción se mantuvo 2 años tras cambiar las condiciones que la motivaron.

**Por qué:** no se escribió la condición (punto 1 pregunta 5).

**Cómo comprobarlo:** ¿el registro dice cuándo revisarla?

**Opciones:** añadir la condición hoy; si nadie la sabe, es señal de que no se entendió bien.

**Riesgos:** decisiones zombis.

**Solución:** condición escrita (punto 1/5).

**Cómo se evita:** plantilla ADR con el campo obligatorio.

---

### Error 3: decidir por preferencia

**Qué ocurrió:** «nos gusta monorepo» sin tocar los factores del contexto.

**Por qué:** se empezó por la opción (punto 1).

**Cómo comprobarlo:** ¿existe la tabla de opciones (punto 2) antes del «elegimos»?

**Opciones:** rehacer el análisis con el marco; si la preferencia sobrevive, bienvenido.

**Riesgos:** dogma (Error 1 sección 25 cap. 01).

**Solución:** contexto primero (punto 1).

**Cómo se evita:** revisor de decisiones pregunta «¿dónde está el contexto?».

---

### Error 4: tabla con una sola columna

**Qué ocurrió:** «ganamos velocidad, pagamos 0» — y a los meses aparecieron los pagos sorpresa.

**Por qué:** no se completó la columna de pagos (punto 2).

**Cómo comprobarlo:** ¿alguna opción tiene «pagamos» vacío?

**Opciones:** completar con los Error 1..7 de la sección 01 como lista de pagos típicos.

**Riesgos:** decisiones con factura oculta.

**Solución:** ambas columnas (punto 2).

**Cómo se evita:** quien aprueba busca primero «¿qué se paga?».

---

### Error 5: tratar lo irreversible como reversible

**Qué ocurrió:** se borró un repo «porque luego se recrea» — el historial no se recreó.

**Por qué:** no se valoró el coste de cambio (punto 2).

**Cómo comprobarlo:** ¿la decisión tiene campo de reversibilidad?

**Opciones:** para lo irreversible: respaldo, segunda aprobación, espera (sección 25 cap. 05 punto 5).

**Riesgos:** pérdida total.

**Solución:** rigor proporcional a lo irreversible (punto 2).

**Cómo se evita:** checklist: ¿es reversible? define el proceso.

---

### Error 6: el ADR en el lugar equivocado

**Qué ocurrió:** la decisión quedó en una reunión/nota personal; el nuevo miembro la desconocía y la deshizo.

**Por qué:** registro sin dónde ni visibilidad (punto 3).

**Cómo comprobarlo:** ¿URL pública en el repo?

**Opciones:** mover a `docs/decisiones/` y enlazar desde README/architecture.

**Riesgos:** decisiones que se repiten y se contradicen.

**Solución:** con el código (punto 3).

**Cómo se evita:** plantilla en la raíz del repo (sección 18).

---

### Error 7: jamás se revisan las decisiones

**Qué ocurrió:** la cartera entera tenía ADRs de hace 4 años; nadie sabía cuáles seguían vigentes.

**Por qué:** sin disparadores de revisión (punto 5).

**Cómo comprobarlo:** ¿hay fecha de última revisión de cartera?

**Opciones:** revisión anual: vigente / superseded (punto 5).

**Riesgos:** el registro miente.

**Solución:** revisión con calendario (punto 5).

**Cómo se evita:** la revisión anual es parte del mantenimiento (sección 05 cap. 02).

---

## 7. Práctica guiada

### Objetivo

Tomar UNA decisión real de tu proyecto con el marco completo y registrarla.

### Paso 1: pregunta 1

```text
Problema: _______________
Para quién: _______________
Duele desde (evidencia): _______________
```

1. Si no puedes evidenciar el dolor: escribe el ADR «decidir después» con disparador.

### Paso 2: opciones reales

1. Lista 2–4 opciones operables en TU contexto + «no hacer nada».

### Paso 3: tabla de consecuencias

1. Rellena las dos columnas para cada opción en términos tuyos (punto 2).

### Paso 4: reversibilidad

1. Para la opción preferente: ¿cuánto cuesta deshacer? Ajusta el rigor si es irreversible (Error 5).

### Paso 5: el ADR

1. Crea `docs/decisiones/001-*.md` con la plantilla del punto 3 — incluido «reevaluar si».

### Paso 6: superceder (si aplica)

1. Si ya existía una decisión previa: márcala `superseded` apuntando al nuevo ADR (nunca la borres).

### Resultado esperado

Un ADR completo: contexto, tabla, decisión, pagos, reversibilidad y condición de revisión — más su disparador en el calendario.

### Conclusión esperada

Decidir bien no es acertar siempre: es entender el precio, firmarlo por escrito y saber desde el primer día qué haría cambiar de parecer.

---

## 8. Nivel profesional + resumen

### 8.1. Decisiones a escala

```text
   │
   ├── ADRs como práctica de equipo: carpeta viva con
   │   índice y estados (propuesta/aceptada/superseded)
   │
   ├── umbrales de rigor: lo reversible se decide
   │   rápido con registro breve; lo irreversible
   │   (contratos, borrados, migraciones de historia)
   │   exige RFC + segunda mirada (Error 5)
   │
   ├── decisiones que cruzan equipos: proceso ligero
   │   de la sección 03 cap. 03 (proposición →
   │   dueños → registro)
   │
   ├── revisión anual de cartera: qué sigue vigente
   │   (Error 7)
   │
   └── métricas: ADRs abiertos sin decisión, supersedidos
       por año, decisiones revertidas (¿sorpresa? Error
       4 de reversibilidad)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* el marco: problema-para-quién, opciones reales, costes, reversibilidad y condición de reevaluación;
* la tabla de dos columnas exige pagos en términos propios — columna vacía es señal de análisis incompleto;
* el ADR ligero (una página, con estado y «reevaluar si») vive en el repo, con el código;
* rigor proporcional: reversible decide rápido, irreversible decide con calma;
* el caso de estudio muestra que el valor no es la «respuesta», sino precio y caducidad escritos;
* los errores típicos (decidir lo que no duele, sin condición, por preferencia, tabla incompleta, irreversible a la ligera, ADR mal ubicado, revisión ausente) se previenen con la plantilla y el calendario;
* a nivel profesional: umbrales de rigor y cartera revisada.

La idea principal es:

> **La decisión madura no es la que se acuerda con más entusiasmo, sino la que deja escrito qué se pagó, quién lo firmó y qué la haría caducar.**

---

## Próximo paso

Has completado la sección de arquitectura de repositorios.

Continúa con el cierre:

[`README.md`](README.md)
