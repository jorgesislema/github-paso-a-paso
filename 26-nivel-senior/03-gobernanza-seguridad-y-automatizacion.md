# Gobernanza, seguridad y automatización

## Introducción

A nivel senior, las tres palabras que más pesan son **sostener**: gobernanza que sobrevive a las personas, seguridad que no depende de la memoria y automatización que evita el trabajo repetido. Los controles ya existen en capítulos anteriores (secciones 18, 20, 23, 24, 25); aquí se ensamblan en la mirada de alguien responsable del conjunto: cómo se reparte la responsabilidad, cómo se mantiene la confianza cuando nadie mira y cómo se decide qué automatizar y qué no.

---

## Mapa conceptual de este capítulo

```text
Gobernanza, seguridad y automatización
       │
       ├── 1. Gobernanza que no depende de héroes
       ├── 2. Seguridad como estado, no como acto
       │   ├── 3. Automatizar el trabajo repetido (y
       │   │   qué NO automatizar)
       │   └── 4. Las tres juntas: el ciclo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Gobernanza que no depende de héroes

```text
LO QUE YA VISTE (y aquí se sintetiza):
   │
   ├── dueños por repo y por estándar (sección 16 cap.
   │   06 / 25 cap. 03)
   ├── matriz de permisos revisada (sección 25 cap. 03
   │   punto 2)
   ├── política escrita + aplicación automática
   │   (sección 24/25)
   └── excepciones con caducidad y métrica (sección 25
       cap. 03 punto 5)
```

```text
LA PREGUNTA SENIOR:
   │
   └── «si X se va mañana, qué sigue funcionando?»
       — si la respuesta es «nada», el gobierno está en
       una cabeza (Error 1 — Error 4 sección 03 cap.
       03)
```

```text
SOSTÉN (los tres mecanismos del gobierno invisible):
   │
   ├── memoria externa: todo en el repo (decisiones,
   │   políticas, flujos — sección 25 cap. 06)
   │
   ├── roles con suplente: nadie único (Error 2 si el
   │   dueño no tiene suplente)
   │
   └── rutina: lo que se repite está en calendario con
       checklist (sección 25 cap. 05 punto 2)
```

```text
   │
   └── gobernar bien es aburrir al hacedor de travesuras
       — el sistema evita el mal día, no depende del
       buen día (Error 3 si se premia al «apaga
       incendios»)
```

---

## 2. Seguridad como estado, no como acto

```text
ACTO (insostenible): una auditoría al año, un
«barrido» cuando asusta la noticia
   │
   └── Error 4 si la seguridad solo aparece en
       calendario de crisis
```

```text
ESTADO (lo senior): controles dentro del flujo —
   │
   ├── en el editor: secretos locales (sección 20
   │   cap. 01)
   ├── en el PR: SAST, secretos, deps (sección 20/24)
   ├── en el build: imágenes, artefactos firmados
   │   (sección 24 cap. 03/05)
   ├── en staging: DAST + humo (sección 24 cap. 03)
   └── en operación: alertas, respaldo, simulacros
       (sección 23/24)
```

```text
LO QUE MANTIENE EL ESTADO:
   │
   ├── inventario vivo: dependencias, accesos,
   │   integraciones (sección 20 cap. 03/05)
   ├── métricas: hallazgos por edad, excepciones
   │   abiertas (sección 24 cap. 06)
   └── post-mortem → control nuevo (el ciclo que nunca
       se cierra sin que algo cambie — sección 24 cap.
       06)
```

```text
   │
   └── la pregunta senior no es «¿estamos seguros?»
       (nadie lo está) sino «¿cuánto TARDAMOS en
       detectar y CONTENER?» — y eso se mide (Error 5
       si la respuesta es una impresión)
```

---

## 3. Automatizar el trabajo repetido (y qué NO automatizar)

```text
SÍ (el criterio: repetido + predecible + aburrido):
   │
   ├── checks de CI, puertas por riesgo (sección 19/24)
   ├── renovación de dependencias (Dependabot — sección
   │   20 cap. 03)
   ├── publicación de releases y artefactos (sección 22
   │   cap. 05)
   ├── limpieza: ramas huérfanas, artefactos vencidos
   │   (sección 25 cap. 05)
   └── reportes: conformidad, métricas, inventario
```

```text
NO (el criterio: excepcional + consecuencias + juicio):
   │
   ├── decisiones que cambian contratos (Error 6 si
   │   «el bot decide»)
   ├── accesos y permisos sensibles (Error 6 —
   │   revisión humana, sección 20 cap. 05)
   └── despliegues de alto riesgo sin humo/observación
       (sección 22/23)
```

```text
CÓMO SE ELIGE (senior = lista, no reflejo):
   │
   ├── ¿se hace más de X veces/mes? → candidato
   ├── ¿tiene criterio claro? → automatizable
   ├── ¿si falla, es barato detectarlo? → automatizable
   └── si alguna es «no» → deja humana con checklist
```

```text
   │
   └── automatizar MAL es doble trabajo: también
       mantienes el robot (Error 6 — Error 2 sección
       04 cap. 25: toda automatización tiene dueño)
```

---

## 4. Las tres juntas: el ciclo

```text
EL CICLO QUE SE AUTO SOSTIENE:
   │
   ├── gobernanza define → política y dueños
   ├── automatización APLICA → puertas y reportes
   ├── seguridad observa → métricas e incidentes
   └── post-mortem/retro → gobernanza REVISA → nueva
       política (sección 23 cap. 01 / 24 cap. 06)
```

```text
   │
   └── si un eslabón falta, el ciclo se rompe:
       política sin aplicación = papel (Error 5
       sección 03 cap. 25); aplicación sin métricas =
       robot ciego; métricas sin revisión = dashboard
       decorativo
```

```text
   │
   └── el senior ES el que cierra el ciclo: no el que
       aplica un control, sino el que asegura que el
       control que FALLÓ se convierte en regla (Error
       7 si el incidente no cambia nada — Error 4
       sección 24 cap. 06)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: gobierno en una cabeza

**Qué ocurrió:** el dueño de todo se fue y quedaron 12 repos con permisos sin revisar.

**Por qué:** sin memoria externa ni suplentes (punto 1).

**Cómo comprobarlo:** «si X no está…» — ¿quién sabe la política?

**Opciones:** escribir todo en el repo, suplentes nominales, calendario compartido.

**Riesgos:** amnesia institucional.

**Solución:** los tres mecanismos (punto 1).

**Cómo se evita:** checklist de salida de personas (sección 16).

---

### Error 2: dueño sin suplente

**Qué ocurrió:** la release trimestral dependió de una persona de baja; se atrasó un mes.

**Por qué:** riesgo de bus factor no atendido (punto 1 — sección 23 cap. 06).

**Cómo comprobarlo:** lista de dueños: ¿cuántos son único?

**Opciones:** suplente nominal por cada rol; rotación real (Error 3 — sección 25 cap. 05 — sombreros).

**Riesgos:** parálisis por ausencia.

**Solución:** nadie único (punto 1).

**Cómo se evita:** toda alta de rol incluye suplente.

---

### Error 3: premiar al apaga incendios

**Qué ocurrió:** el «héroe» de los apagones era el favorito; nadie prevenía, porque prevenir no se notaba.

**Por qué:** incentivos al acto, no al estado (punto 1).

**Cómo comprobarlo:** ¿a quién se reconoce públicamente y por qué?

**Opciones:** reconocer previsión (incendios que NO ocurrieron, métricas de tendencia); medir MTTR y tendencia de alertas.

**Riesgos:** cultura de fuegos perpetuos.

**Solución:** premiar el sistema (punto 1).

**Cómo se evita:** las métricas de la retro incluyen prevención (sección 24 cap. 06).

---

### Error 4: seguridad de crisis

**Qué ocurrió:** tras una noticia, mes intensivo de «barridos»; al año siguiente, todo otra vez oxidado.

**Por qué:** acto, no estado (punto 2).

**Cómo comprobarlo:** ¿cuándo fue el último hallazgo que NO salió de una crisis? ¿de un check del PR?

**Opciones:** poner los controles EN el flujo (punto 2) empezando por el PR.

**Riesgos:** picos de ansiedad sin cobertura real.

**Solución:** estado dentro del flujo (punto 2).

**Cómo se evita:** métricas: % hallazgos en PR vs. después (sección 24 cap. 06).

---

### Error 5: «¿estamos seguros?» como métrica

**Qué ocurrió:** reunión con dashboard verde y un hallazgo crítico escondido en backlog.

**Por qué:** sin métrica de detención/contención (punto 2).

**Cómo comprobarlo:** ¿se miden tiempos de detección y contención?

**Opciones:** adoptar las dos métricas mínimas (sección 24 cap. 06) y mostrar edad de hallazgos.

**Riesgos:** ceguera con apariencia de control.

**Solución:** medir tiempos (punto 2).

**Cómo se evita:** «verde» siempre muestra también el backlog.

---

### Error 6: automatizar con criterio humano difuso

**Qué ocurrió:** un workflow auto-mergeaba dependencias sin mirar; entró un cambio que rompió tests no cubiertos.

**Por qué:** «repetido y predecible» no se cumplía (punto 3).

**Cómo comprobarlo:** ¿qué decisiones hace el robot sin revisión? ¿cuántas son de juicio?

**Opciones:** acotar la automatización a lo verificable; humo y revisión para el resto (punto 3).

**Riesgos:** robot que rompe en silencio.

**Solución:** criterio sí/no (punto 3).

**Cómo se evita:** revisión anual de lo que los bots deciden.

---

### Error 7: incidente que no cambió nada

**Qué ocurrió:** el mismo tipo de fallo se repitió tres veces en un semestre.

**Por qué:** sin post-mortem que cierre en control (punto 4).

**Cómo comprobarlo:** ¿las acciones de los post-mortems están cerradas con dueño?

**Opciones:** tracker de acciones; no cerrar incidente sin control nuevo o riesgo aceptado escrito.

**Riesgos:** reincidencia y desprecio del proceso.

**Solución:** ciclo completo (punto 4).

**Cómo se evita:** métrica «reincidencias» en la retro (sección 24 cap. 06).

---

## 6. Práctica guiada

### Objetivo

Auditar las tres patas — gobernanza, seguridad, automatización — y cerrar el ciclo en un punto.

### Paso 1: «si X se va mañana»

```text
Dueños hoy: ______
¿Todos con suplente? ______
¿Política/decisiones en el repo? ______
```

1. Elige el hueco mayor y ciérralo esta semana (escribir, nombrar suplente o calendario).

### Paso 2: estado vs. acto de seguridad

1. Lista los controles del punto 2 que YA viven en tu flujo vs. los que solo existen «de vez en cuando».

### Paso 3: métrica de estado

1. Activa la métrica «hallazgos en PR vs. después» (aunque sea manual al principio).

### Paso 4: lista de automatización

```text
Repetido ≥ veces/mes · criterio claro · fallo barato
→ sí | no
```

1. Revisa tu CI: ¿algún botón toma decisiones de juicio (Error 6)? Retírale autonomía.

### Paso 5: cierra un ciclo

1. Toma un problema reciente y escríbelo como ciclo completo (punto 4): política → aplicación → métrica → fecha de revisión.

### Paso 6: publica

1. Un solo documento: `docs/gobierno.md` con dueños, política-resumen, métricas y calendario — enlazado desde README.

### Resultado esperado

Hueco de sucesión cerrado, controles clasificados acto/estado, una métrica activa y un ciclo completo escrito.

### Conclusión esperada

A nivel senior, la ventaja no está en saber más controles: está en que los controles se apliquen solos, se midan y se corrijan — un sistema que mejora mientras el equipo duerme.

---

## 7. Nivel profesional + resumen

### 7.1. El sistema completo

```text
   │
   ├── gobierno: dueños + suplentes + políticas
   │   citables + excepciones con caducidad (sección
   │   03 cap. 25)
   │
   ├── seguridad: controles en CADA puerta del flujo +
   │   inventario vivo + post-mortem → control (sección
   │   24)
   │
   ├── automatización: piso obligatorio por plantilla +
   │   bots acotados a lo verificable + dueños de todo lo
   │   que corre (sección 04 cap. 25)
   │
   ├── ciclo: retro con métricas → política nueva →
   │   aplicación (sección 23 cap. 01)
   │
   └── métricas de sistema: tiempo de detección y
       contención, excepciones abiertas, reincidencias,
       % repos conformes
```

### 7.2. Resumen

En este capítulo aprendiste que:

* gobernanza sostenible = memoria externa, suplentes y rutina en calendario — no héroes;
* seguridad como estado: controles dentro de cada puerta, inventario vivo y métricas de tiempos, no impresiones;
* automatizar lo repetido, predecible y barato de detectar; dejar lo excepcional y de juicio en manos humanas con checklist;
* las tres patas forman un ciclo: política → aplicación → observación → revisión;
* los errores típicos (gobierno en una cabeza, dueño sin suplente, incentivos al incendio, seguridad de crisis, «¿estamos seguros?», bots con juicio difuso, reincidencia) se previenen con memoria, métricas y ciclo cerrado;
* a nivel profesional: el sistema que mejora solo y métricas de sistema.

La idea principal es:

> **La madurez no se mide por cuántos controles existen, sino por cuántos se aplican sin recordárselos a nadie y cuántos incidentes se convierten en reglas antes de repetirse.**

---

## Próximo paso

Ya gobiernas, aseguras y automatizas el conjunto.

Ahora el peor día: cómo se recupera un incidente y un desastre.

Continúa con:

[`04-recuperacion-ante-incidentes-y-desastres.md`](04-recuperacion-ante-incidentes-y-desastres.md)
