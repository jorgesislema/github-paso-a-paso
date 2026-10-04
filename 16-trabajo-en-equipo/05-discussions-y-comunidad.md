# Discussions y comunidad

## Introducción

No todo el intercambio de un proyecto es un trabajo con entrega. Hay preguntas que no son bugs, propuestas que necesitan debate y conocimiento que merece quedarse buscable. **Discussions** es el espacio de GitHub para eso: hilos conversacionales con categorías, respuestas aceptadas y anclaje — entre un issue y un foro.

Este capítulo enseña cuándo usar Discussions frente a issues, cómo estructurar categorías y cómo alimentar una comunidad que pregunta, responde y documenta.

---

## Mapa conceptual de este capítulo

```text
Discussions y comunidad
       │
       ├── 1. Discussions vs. issues vs. chats
       ├── 2. Categorías y estructura
       ├── 3. Buenas preguntas y respuestas aceptadas
       ├── 4. Ciclo de comunidad: preguntar, responder,
       │       documentar
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Discussions vs. issues vs. chats

```text
DÓNDE VA CADA COSA
──────────────────────────────────────────────────────
Bug / feature con criterios      → issue (sección 03)
Trabajo con entregable + PR      → issue + PR
Pregunta de uso («¿cómo…?»)      → Discussions
Propuesta a debatir (RFC)        → Discussions
Decisiones que hay que recordar  → ADR (sección 14)
                                     + hilo que enlaza
Conversación efímera (standup)   → chat externo
```

```text
   │
   ├── Discussions se INDEXA y busca: el conocimiento
   │   queda (más que en un chat)
   │
   ├── una discusión que acaba en «hay que hacer X»
   │   → se convierte en ISSUE (con enlace de ida y
   │     vuelta)
   │
   └── Discussions ≠ anuncios: Announcements (si está
       habilitado) es de un solo sentido
```

```text
VENTAJAS FRENTE A ISSUES:
   │
   ├── categorías con formulario de pregunta
   ├── «respuesta aceptada» (el buscador agradece)
   ├── upvotes/respuestas como señal de utilidad
   └── no contamina el tracker de trabajo
```

---

## 2. Categorías y estructura

```text
CATEGORÍAS EJEMPLO (pocas y claras)
   │
   ├── Preguntas          → ayuda de uso
   ├── Ideas              → propuestas abiertas
   ├── Anuncios           → del equipo (si procede)
   └── Ayuda / Troubleshooting → soporte entre
       usuarios
```

```text
REGLAS:
   │
   ├── nombre que el usuario entienda sin contexto
   ├── descripción de «qué va aquí» en cada una
   ├── poca variedad: si todo cae en «General», te
   │   sobra la categoría
   └── plantilla de pregunta (si la plataforma lo
       permite en tu plan) o en el README de la
       discusión: pasos, entorno, qué probaste
```

```text
ESTRUCTURA DE UNA PREGUNTA BUENA:
   │
   ├── qué intentas hacer
   ├── qué pasa (errores, logs)
   ├── qué probaste (versiones, pasos)
   └── entorno (SO, versión de la herramienta)
```

```text
   │
   └── plantilla visible = menos idas y vueltas; es
       lo mismo que el issue template (sección 14)
       aplicado a conversación
```

---

## 3. Buenas preguntas y respuestas aceptadas

```text
COMO QUIEN PREGUNTA:
   │
   ├── busca antes (issues + discussions + docs)
   ├── contexto mínimo ejecutable
   ├── no pongas datos sensibles (sección 20)
   └── cierra el círculo: «solución: …» y marca
       respuesta aceptada
```

```text
COMO QUIEN RESPONDE:
   │
   ├── responde al problema, no a la persona
   ├── pasos concretos o enlace a doc/issue
   ├── si es bug → issue con enlace; la discusión
   │   queda como contexto
   └── pide la marca de «aceptada» cuando resuelva
```

```text
RESPUESTA ACEPTADA:
   │
   ├── la pregunta original cierra el hilo con la
   │   solución que funcionó
   │
   └── valor futuro: quien llegue con el mismo
       problema encuentra ya la respuesta
```

```bash
# buscar en el historial del proyecto:
gh search issues "csv acentos" --repo owner/repo
# (incluye issues y discussions según configuración)
```

---

## 4. Ciclo de comunidad: preguntar, responder, documentar

```text
BUCLE SANO
──────────────────────────────────────────────────────
1. pregunta (discussions)
2. respuesta (comunidad/equipo)
3. si se repite → RESPUESTA en docs/ (FAQ, guía)
4. si es defecto → issue (con contexto del hilo)
5. si es decisión → ADR + enlace
6. la doc nueva se enlaza desde la siguiente
   respuesta → el conocimiento se acumula
```

```text
NORMAS DE CONVIVENCIA:
   │
   ├── código de conducta (sección 14, cap. 05)
   ├── moderación: avisar, editar etiquetas, cerrar
   │   spam — con reglas escritas
   ├── agradecer lo que aporta (refuerza el ciclo)
   └── expectativas de tiempo: «respondemos en X» es
       mejor que silencio
```

```text
   │
   └── la comunidad se alimenta de BUQUES: si el
       equipo nunca responde, nadie responde después
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: preguntas como issues (y al revés)

**Qué ocurrió:** el tracker lleno de «¿cómo instalo?» mientras los bugs reales se pierden en chats.

**Por qué posibles:**
* no saben que existen Discussions;
* falta plantilla/aviso en «New issue».

**Cómo comprobarlo:** revisar issues recientes: ¿cuántas son trabajo real?

**Opciones:** habilitar Discussions y enlazarlo en el formulario de issue; mover preguntas existentes.

**Riesgos:** ruido en el tracker → los bugs se ignoran.

**Solución:** separación clara en la plantilla («esto es una pregunta → Discussions»).

**Cómo se evita:** enlace en README: «¿dudas? → Discussions».

---

### Error 2: hilo que muere sin respuesta

**Qué ocurrió:** pregunta sin respuesta durante semanas.

**Por qué posibles:**
* sin dueño de respuesta;
* canal que nadie mira.

**Cómo comprobarlo:** edad de preguntas abiertas.

**Opciones:** rotar «guardia de preguntas»; etiqueta de urgencia; SLA informal (sección 15 cap. 06).

**Riesgos:** la comunidad aprende que aquí no contestan.

**Solución:** dueño rotativo + revisión en el standup.

**Cómo se evita:** panel de «preguntas sin respuesta > 7 días».

---

### Error 3: responder solo enlaces

**Qué ocurrió:** «lee la doc» sin decir cuál ni por qué.

**Por qué:** respuesta rápida sin contexto.

**Cómo comprobarlo:** leer la respuesta: ¿avanza al preguntador?

**Opciones:** añadir enlace + párrafo de por dónde empezar.

**Riesgos:** frustración; el conocimiento no se cierra.

**Solución:** enlace + contexto + pasos mínimos.

**Cómo se evita:** norma de respuesta amable en CONTRIBUTING.

---

### Error 4: soluciones que solo viven en el hilo

**Qué ocurrió:** la respuesta genial se repite en el foro cada mes.

**Por qué:** no se elevó a docs.

**Cómo comprobarlo:** preguntas repetidas (búsqueda).

**Opciones:** redactar FAQ/guía y enlazarla después.

**Riesgos:** costo de responder lo mismo eternamente.

**Solución:** bucle del punto 4: respuesta repetida → doc.

**Cómo se evita:** checklist «¿esto se repetirá?» al responder.

---

### Error 5: datos sensibles en preguntas públicas

**Qué ocurrió:** logs con tokens, URLs con credenciales, datos de cliente pegados en el hilo.

**Por qué:** prisa por contexto.

**Cómo comprobarlo:** revisar antes de publicar (y escaneo si ya se publicó — cap. 05 sección 13).

**Opciones:** redactar (editar el hilo), rotar credenciales si se filtró, volver al canal privado.

**Riesgos:** incidente de seguridad.

**Solución:** placeholders («TU_API_KEY_AQUI») siempre.

**Cómo se evita:** aviso en la plantilla: «no pegues credenciales».

---

### Error 6: comunidad sin moderación (spam/toxicidad)

**Qué ocurrió:** hilos tóxicos o spam que se quedan arriba.

**Por qué:** nadie tiene el rol ni las reglas.

**Cómo comprobarlo:** recorrer la pestaña de Discussions.

**Opciones:** aplicar COC, moderar, restringir creación de hilos si hace falta.

**Riesgos:** gente sana se va.

**Solución:** moderación con reglas escritas (punto 4).

**Cómo se evita:** responsables de comunidad nombrados (sección 18).

---

## 6. Práctica guiada

### Objetivo

Habilitar Discussions y recorrer el ciclo completo: pregunta → respuesta → doc.

### Paso 1: habilita y categoriza

```text
Settings → Features → Discussions:
   │
   ├── categorías: Preguntas · Ideas · Anuncios
   └── en New issue: añadir enlace «¿Es una duda? →
       Discussions» (en la plantilla)
```

### Paso 2: pregunta modelo

1. Abre una discusión en «Preguntas» con la estructura del punto 2 (qué, error, qué probaste, entorno).

### Paso 3: respuesta con enlace + contexto

1. Responde con pasos concretos y marca «aceptada».
2. Observa cómo queda buscable.

### Paso 4: elevar a docs

1. Añade la solución a `docs/guias/troubleshooting.md` (sección 14, cap. 06) y comenta en el hilo: «ya está en la guía: …».

### Paso 5: convertir a issue

1. Simula otro caso: la conversación revela un bug → abre issue con enlace a la discusión.

### Paso 6: reglas de la comunidad

1. Escribe en CONTRIBUTING: dónde preguntar, SLA informal de respuesta y norma de no incluir credenciales.

### Resultado esperado

Discussions con categorías, una respuesta aceptada y el conocimiento elevado a docs/issue.

### Conclusión esperada

El ciclo pregunta → respuesta → doc/issue es lo que convierte un canal en comunidad.

---

## 7. Nivel profesional + resumen

### 7.1. Comunidad como producto

```text
   │
   ├── soporte en capas: docs/FAQ (autoayuda) →
   │   Discussions (comunidad) → issues (defectos) →
   │   canal privado (sensibles)
   │
   ├── métricas con cuidado: tiempo a respuesta,
   │   % de preguntas con respuesta aceptada (no
   │   volumen como ranking)
   │
   ├── responsables rotativos de «guardia» y de
   │   moderación; COC visible
   │
   └── bucle de mejora: lo que se pregunta mucho →
       doc; lo que se repite como bug → roadmap
```

### 7.2. Resumen

En este capítulo aprendiste que:

* Discussions sirve para preguntas, propuestas y conocimiento — issues para trabajo con criterios, chat para lo efímero;
* categorías pocas y claras, plantilla de pregunta y respuesta aceptada;
* el ciclo sano: pregunta → respuesta → elevar a docs (FAQ/guía) o convertir en issue/ADR;
* normas de convivencia con COC, moderación y expectativas de respuesta;
* los errores típicos (preguntas en el tracker, hilos muertos, solo-enlaces, soluciones no documentadas, datos sensibles, sin moderación) se previenen con enlaces, guardias y bucle de documentación;
* a nivel profesional: soporte en capas con métricas de proceso.

La idea principal es:

> **La comunidad se construye cerrando el círculo: cada buena respuesta termina en docs o en una issue — así el conocimiento deja de depender de quien estaba online.**

---

## Próximo paso

Ya convives con la comunidad.

Falta la pieza que reparte responsabilidades con precisión: CODEOWNERS.

Continúa con:

[`06-codeowners-y-responsabilidades.md`](06-codeowners-y-responsabilidades.md)
