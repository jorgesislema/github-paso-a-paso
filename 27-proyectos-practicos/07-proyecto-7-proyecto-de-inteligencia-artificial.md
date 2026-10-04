# Proyecto 7: proyecto de inteligencia artificial

## Introducción

El Proyecto 7 aplica el flujo completo a un dominio que genera tentaciones constantes: **inteligencia artificial**. Modelos, datasets, tokens de API y ejecuciones caras son la receta perfecta para romper todas las reglas aprendidas — y por eso es el mejor laboratorio. Aquí se practican las secciones 21 cap. 04 (git para IA), 20 (secretos), 22/23 (pipeline y ejecución) y 24 (riesgo): un proyecto donde el código es lo único que Git guarda bien, y todo lo demás se diseña con criterio.

---

## Mapa conceptual de este capítulo

```text
Proyecto 7: proyecto de IA
       │
       ├── 1. Qué construyes y qué conceptos incorpora
       ├── 2. Qué entra al repo (y qué NO, siempre)
       │   ├── 3. Secretos y credenciales de modelos
       │   └── 4. Pipeline: entrenar/evaluar sin
       │       romper el flujo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes y qué conceptos incorpora

```text
EL PROYECTO (elegible según tu interés):
   │
   ├── una herramienta que consume un MODELO/API (CLI
   │   o servicio pequeño: clasificador, generador,
   │   resumidor) — la vía accesible
   │
   └── o un pipeline de entrenamiento/evaluación
       pequeño con datos públicos — la vía pesada
       (con los límites del punto 2)
```

```text
CONCEPTOS NUEVOS (secciones 20/21/22):
   │
   ├── API keys en secrets de la plataforma (sección 20
   │   cap. 01) — Error 1 si «solo para probar» en el
   │   código
   ├── modelos y datasets como ARTEFACTOS, no como Git
   │   (sección 21 cap. 04/05)
   ├── evaluación como aserción del CI (sección 22 cap.
   │   03 — métricas con umbral)
   └── coste de ejecución: pipeline que no gasta sin
       control (Error 2 si cada CI entrena desde cero)
```

```text
   │
   └── el salto: en IA, Git versiona la RECETA y el
       CÓDIGO; el modelo es consecuencia reproducible
       (Error 3 si confundes modelo con repositorio)
```

---

## 2. Qué entra al repo (y qué NO, siempre)

```text
ENTRA:
   │
   ├── código: carga de datos, preproceso, entrenamiento
   │   o llamada al modelo, evaluación
   ├── configuración: hiperparámetros, prompts
   │   versionados (los prompts son código — Error 4 si
   │   viven en un chat)
   ├── datos: MUESTRA pequeña + script/descarga de la
   │   fuente completa (sección 21 cap. 05)
   ├── métricas de referencia: «la v0.1 obtiene X en el
   │   set de validación» (contrato de calidad)
   └── documentación: qué modelo/base se usa, con qué
       licencia, qué limitaciones conoce (sección 21
       cap. 04)
```

```text
NO ENTRA (jamás — Error 5 si entra):
   │
   ├── checkpoints/epochs, pesos entrenados pesados →
   │   artefacto/almacén con versión (sección 21 cap.
   │   04)
   ├── datasets completos → fuera (referencia + descarga)
   ├── datos de entrenamiento con problemas de licencia
   │   o privacidad (sección 21 cap. 06)
   └── API keys, tokens, URLs con credenciales →
       secrets (punto 3)
```

```text
   │
   └── el test: «¿otro puede reproducir el resultado
       con solo el repo + lo que baja según README?» —
       mismo criterio que el Proyecto 6, con el modelo
       como artefacto más (punto 4 — Error 6 si el
       «resultado final» solo existe en tu disco)
```

---

## 3. Secretos y credenciales de modelos

```text
REGLAS (sección 20 cap. 01 — aplicadas a IA):
   │
   ├── la API key NUNCA en código, notebook ni historial
   │   (Error 1 — y si entró: incidente, no vergüenza:
   │   rotar YA + limpiar historial si procede)
   │
   ├── en local: variables de entorno / archivo no
   │   versionado (gitignore) (Error 7 si el .env
   │   «temporal» entra en el primer commit)
   │
   ├── en CI: secrets del repositorio (sección 19 cap.
   │   04/05) — expuestos SOLO a los jobs que los usan
   │   (mínimo privilegio — sección 20 cap. 05)
   │
   └── rotación: si el proyecto vive mucho, programa la
       rotación (Error 8 si la key es de «siempre»)
```

```text
   │
   └── secret scanning + push protection (sección 20
       cap. 02) es tu red de seguridad: actívalo y
       PRUEBA que bloquea (Error 1 prevención — Error 5
       sección 03 de esta sección: los controles se
       prueban rompiéndolos)
```

---

## 4. Pipeline: entrenar/evaluar sin romper el flujo

```text
TRES MODOS (elige con honestidad de coste — Error 2):
   │
   ├── A. CI solo EVALÚA (recomendado): el modelo o la
   │   llamada se versionan/referencian; el CI corre la
   │   evaluación sobre muestra → aserciones de métrica
   │
   ├── B. CI REENTRENA solo en triggers especiales (no
   │   en cada PR): coste y tiempo controlados
   │
   └── C. entrenamiento completo FUERA del CI (local/
       job dedicado) → sube el artefacto versionado →
       el CI solo verifica reproducción/evaluación
```

```text
EL CHECK DE IA (contrato de calidad):
   │
   ├── la evaluación corre con datos de muestra
   ├── aserciones: métrica ≥ umbral de referencia
   │   (Error 8 si «la métrica se mira a mano»: el
   │   contrato no existe)
   └── el artefacto del modelo: nombre + versión + de
       qué datos/pro código viene (sección 22 cap. 05)
```

```text
   │
   └── «¿qué modelo produce mi última respuesta?» debe
       tener respuesta exacta — como «¿qué versión está
       en producción?» en el Proyecto 5
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: API key en el código

**Qué ocurrió:** la clave quedó en un notebook «de pruebas»; el historial la conservó.

**Por qué:** atajo (punto 3).

**Cómo comprobarlo:** secret scanning + búsqueda en historial (sección 20 cap. 02).

**Opciones:** rotar la clave HOY, migrar a secrets, limpiar historial si procede, activar push protection.

**Riesgos:** abuso y factura (Error 8 sección 20 cap. 01).

**Solución:** secrets siempre (punto 3).

**Cómo se evita:** pre-commit y «¿hay token en el diff?».

---

### Error 2: CI que entrena desde cero en cada PR

**Qué ocurrió:** cada PR tardaba 90 minutos y costaba dinero; el equipo empezó a saltarse los PRs.

**Por qué:** modo de pipeline sin criterio de coste (punto 4).

**Cómo comprobarlo:** duración y costo de los runs de CI.

**Opciones:** modo A o C (punto 4): evaluar en CI, entrenar fuera o en triggers.

**Riesgos:** presupuesto de CI destruido (Error 5 sección 04 cap. 25).

**Solución:** coste controlado (punto 4).

**Cómo se evita:** presupuesto de CI antes de diseñar (sección 26 cap. 01).

---

### Error 3: el modelo como si fuera código

**Qué ocurrió:** checkpoints de 2 GB subidos al repo; el clon tardaba horas.

**Por qué:** sin distinción artefacto/código (Error 3 punto 1).

**Cómo comprobarlo:** tamaño del repo y peso de los blobs.

**Opciones:** sacar pesos a almacén de artefactos con versión; referenciar en README.

**Riesgos:** Git inutilizable (Error 4 sección 21 cap. 05).

**Solución:** modelo es artefacto (punto 2).

**Cómo se evita:** la regla escrita en el README (punto 2).

---

### Error 4: prompts que viven en un chat

**Qué ocurrió:** el prompt que «funcionaba» estaba perdido en un hilo; nadie sabía cuál producía el resultado demo.

**Por qué:** prompts no versionados (punto 2).

**Cómo comprobarlo:** ¿dónde está el prompt de la última demo? URL o archivo.

**Opciones:** prompts en el repo con historial y nota de versión del modelo con el que funcionó.

**Riesgos:** irreproducibilidad de la mejora.

**Solución:** el prompt es código (punto 2).

**Cómo se evita:** plantilla de experimento: prompt + modelo + datos + métrica.

---

### Error 5: datasets o sensibles entrando al repo

**Qué ocurrió:** el dataset completo (y un ejemplo con datos problemáticos) quedó en el historial.

**Por qué:** sin regla (Error 5 punto 2 — Error 1 Proyecto 6).

**Cómo comprobarlo:** inventario del historial + revisión de licencia/privacidad.

**Opciones:** incidente de datos si aplica; historia limpiada; muestra pequeña y fuente documentada.

**Riesgos:** legal y reputacional.

**Solución:** la regla del punto 2.

**Cómo se evita:** checklist «qué entra» en IA (punto 2).

---

### Error 6: resultado final solo en disco

**Qué ocurrió:** nadie podía regenerar la «demo final»: dependía de un entorno y unos pesos perdidos.

**Por qué:** sin artefactos ni procedimiento (punto 2 Error 6).

**Cómo comprobarlo:** «clona en limpio, baja artefacto, ejecuta evaluación» — ¿reproduce la métrica?

**Opciones:** documentar + versionar artefacto + evaluación automatizada.

**Riesgos:** demo irrepetible.

**Solución:** receta + artefacto versionado (punto 2/4).

**Cómo se evita:** «última métrica» como check del CI (punto 4).

---

### Error 7: .env temporal versionado

**Qué ocurrió:** el archivo de entorno con la clave entró en el «primer commit».

**Por qué:** gitignore sin cubrir `.env` (punto 3).

**Cómo comprobarlo:** `git ls-files | grep env` + secret scanning.

**Opciones:** mismo camino que Error 1 (rotar + limpiar).

**Riesgos:** credencial en clones antiguos.

**Solución:** gitignore de entorno desde el día 1 (Proyecto 5 — persiste).

**Cómo se evita:** plantilla de repo con .env ignorado (sección 18).

---

### Error 8: métricas que «se miran» en vez de verificarse

**Qué ocurrió:** la evaluación existía como reporte manual; una regresión llegó a la demo.

**Por qué:** sin umbral en CI (punto 4).

**Cómo comprobarlo:** ¿el PR que empeoró la métrica se pudo mergear?

**Opciones:** aserción de umbral en el check; referencia de baseline versionada.

**Riesgos:** calidad sin contrato.

**Solución:** check con umbral (punto 4).

**Cómo se evita:** el mismo patrón de pruebas del Proyecto 5 aplicado a métricas.

---

## 6. Práctica guiada

### Objetivo

Entregar un proyecto de IA con secretos seguros, artefactos fuera de Git y evaluación verificada en CI.

### Paso 1: elige el modo

```text
A. evaluar en CI (recomendado) · B. reentrenar por
trigger · C. entrenar fuera + artefacto
   └── escríbelo en README con su porqué (punto 4)
```

### Paso 2: política de artefactos

1. Regla escrita: qué entra (código, prompts, muestra, métricas) y qué no (pesos, datasets, claves) — punto 2.

### Paso 3: secretos

1. Local: `.env` gitignoreado. CI: secrets del repositorio. Activa secret scanning + push protection y PRUEBA el bloqueo (punto 3).

### Paso 4: evaluación automatizada

1. Pipeline que corre evaluación con muestra y aserción `métrica >= umbral` (punto 4).

### Paso 5: prueba negativa

1. Empeora la métrica a propósito: ¿el PR se bloquea? Corrige hasta que sí.

### Paso 6: entrega

```text
Checklist:
   [ ] cero claves en código/historial (scan activo)
   [ ] artefactos y datasets fuera de Git, referenciados
   [ ] prompts versionados con su modelo
   [ ] modo de pipeline documentado con coste acotado
   [ ] evaluación bloqueante (probada en rojo)
   [ ] README: qué modelo, qué datos, qué licencia,
       qué limitaciones
```

### Resultado esperado

Proyecto de IA reproducible, seguro y con calidad verificada automáticamente en cada PR.

### Conclusión esperada

El flujo completo sobrevive al dominio más salvaje: cuando los secretos van a secretos, los modelos a artefactos y las métricas a aserciones, la IA deja de ser magia personal y se convierte en ingeniería.

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto a la vida real

```text
   │
   ├── lo practicado es la base de MLOps: registro de
   │   modelos, datos versionados, evaluación continua
   │   (las secciones 21/22 con vocabulario de IA)
   │
   ├── secretos + mínimo privilegio + push protection es
   │   exactamente la política que exigen las APIs de
   │   pago en cualquier empresa (sección 20)
   │
   ├── documentación de modelo (base, licencia,
   │   limitaciones) anticipa los temas de gobernanza de
   │   IA que crecen cada año (sección 24/25 —
   │   evidencias y dueños)
   │
   └── coste acotado de CI: la lección que separa un
       proyecto sostenible de uno abandonado
```

### 7.2. Resumen

En este capítulo aprendiste que:

* en IA, Git guarda código, configuración, prompts y muestras — nunca pesos ni datasets completos;
* secretos de modelos van a entorno local y secrets de CI, con scanning activo y rotación;
* el pipeline elige modo por coste: evaluar en CI, entrenar por trigger o entrenar fuera con artefacto;
* la evaluación con umbral es el contrato de calidad — probada en negativo como todo control;
* los errores típicos (key en código, CI costoso, modelo en Git, prompts perdidos, datasets sensibles, demo local, .env versionado, métricas miradas) se previenen con política escrita y checks;
* la progresión: este proyecto es el antecedente directo del Proyecto final con flujo completo.

La idea principal es:

> **La inteligencia artificial se vuelve ingeniería cuando todo lo que la rodea — secretos, artefactos, prompts y métricas — tiene lugar propio, versión y verificación: el modelo es solo el centro de un flujo bien diseñado.**

---

## Próximo paso

Ya dominas siete proyectos con progresión.

La cima de la sección: el proyecto colaborativo donde el flujo se ejercita con otras personas.

Continúa con:

[`08-proyecto-8-colaborativo.md`](08-proyecto-8-colaborativo.md)
