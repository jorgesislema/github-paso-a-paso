# Automatización y pipelines a escala

## Introducción

Con varios repositorios — o un monorepo grande — aparece la pregunta operativa de la arquitectura: **¿cómo mantengo el CI/CD, los estándares y las puertas consistentes sin duplicar el mismo workflow en cien sitios?** Este capítulo trata la automatización como infraestructura compartida: plantillas reutilizables, workflows parametrizados, detección de impacto y la disciplina de actualizar el estándar una vez y propagarlo — sin que nadie se quede atrás ni se rompa en silencio.

---

## Mapa conceptual de este capítulo

```text
Automatización y pipelines a escala
       │
       ├── 1. El problema de la duplicación
       ├── 2. Mecanismos de reutilización en GitHub
       │   ├── 3. Detección de impacto y CI acotado
       │   ├── 4. Cómo se propaga un cambio de estándar
       │   └── 5. Lo que NO se estandariza
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El problema de la duplicación

```text
SIN ESCALA (crece mal):
   │
   ├── 40 repos × workflow copiado = 40 lugares donde
   │   arreglar el mismo bug de CI
   │
   ├── «el repo 17 tiene el check viejo y nadie lo
   │   sabe» (Error 1)
   │
   └── una mejora del estándar llega cuando alguien
       se acuerda de cada repo (Error 2)
```

```text
CON ESCALA (el objetivo):
   │
   ├── la lógica de CI vive en UN sitio (workflow
   │   reutilizable o plantilla)
   │
   ├── cada repo la INVOCA con parámetros mínimos
   │
   └── el cambio de estándar se propaga al actualizar
       UNA versión (Error 3 si nadie la actualiza)
```

```text
   │
   └── escala = cambiar el estándar una vez y que
       todos lo hereden (Error 4 si se hace por
       anuncio en chat)
```

---

## 2. Mecanismos de reutilización en GitHub

```text
FAMILIA DE OPCIONES (mención técnica honesta —
verifica la syntax actual en docs):
   │
   ├── workflow reutilizable (workflow_call): un YAML
   │   central invocado con `uses:` + `with:`
   │   (sección 19)
   │
   ├── plantillas de repo: repositorio-plantilla con
   │   la estructura + checks base (sección 18)
   │
   ├── acciones propias de la org: la lógica empaquetada
   │   como acción versionada (sección 19 cap. 06)
   │
   └── matrices y plantillas de config: parámetros por
       repo (lenguaje, comandos) en un archivo de
       config que el workflow lee
```

```text
ELECCIÓN (guía):
   │
   ├── mismo proceso, distinto parámetro → workflow
   │   reutilizable + config por repo
   ├── arranque desde cero → plantilla de repo
   └── lógica compleja compartida → acción propia
       versionada
```

```text
   │
   └── la versión IMPORTA: el workflow reutilizable
       invocado por tag/rama = control de cambios del
       estándar (Error 3 — siempre fija versión o rama
       controlada, no `main` flotante sin querer)
```

---

## 3. Detección de impacto y CI acotado

```text
POR QUÉ (ya vista — sección 04 / sección 25 cap. 01):
   │
   ├── monorepo: probar TODO en cada PR es inviable
   │
   └── multirepo: cada repo ya acota, pero el workflow
       base sigue pudiendo ser más inteligente
```

```text
MECANISMOS:
   │
   ├── paths/paths-ignore en `on:` (sección 19 cap.
   │   02): «docs/ no lanza build»
   │
   ├── detección de paquetes afectados (categoría:
   │   comparar contra la rama base y ejecutar solo lo
   │   tocado)
   │
   ├── jobs condicionales según tipo de cambio
   │
   └── caché de dependencias y artefactos entre jobs
       (sección 22 cap. 02)
```

```text
   │
   └── presupuesto: define cuánto dura el CI de un PR
       TÍPICO (Error 5 si nadie mira el reloj — el
       Error 3 de sección 25 cap. 01 nace de aquí)
```

---

## 4. Cómo se propaga un cambio de estándar

```text
CICLO (el verdadero «a escala»):
   │
   ├── 1. cambiar la fuente (workflow central o
   │   plantilla) con PR y revisión (sección 15)
   ├── 2. probar en un repo piloto (Error 6 si se
   │   despliega a 40 a la vez)
   ├── 3. versionar el cambio (tag — sección 17 cap.
   │   05)
   ├── 4. actualizar los consumidores: bump de versión
   │   o PR de migración por lotes
   └── 5. verificar: reporte de «repos con versión
       X+» (Error 1 prevención — inventario, sección
       03)
```

```text
   │
   └── «propagado» se demuestra con un REPORTE, no con
       la buena voluntad (Error 2: la brecha entre
       plantilla y repos es deuda silenciosa)
```

---

## 5. Lo que NO se estandariza

```text
NO TODO ENCAJA EN LA PLANTILLA:
   │
   ├── los comandos específicos de cada proyecto (su
   │   build, su test — parámetros, no lógica)
   │
   ├── las puertas que dependen del riesgo del
   │   componente (sección 24 cap. 06 — tabla por
   │   riesgo: no todo repo necesita DAST)
   │
   └── decisiones legítimamente locales (Error 7 si
       la plantilla pretende ser la dictadura del
       detalle)
```

```text
   │
   └── el estándar define el PISO (mínimo obligatorio:
       checks de seguridad, estructura, naming) y deja
       crecer por encima (Error 4 — la estandarización
       mata la innovación local solo si no hay margen)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: copias divergentes del workflow

**Qué ocurrió:** 12 arreglos de CI distintos en 12 copias; nadie sabía cuál era el bueno.

**Por qué:** duplicación sin fuente única (punto 1).

**Cómo comprobarlo:** diff entre workflows de varios repos.

**Opciones:** consolidar en workflow reutilizable + invocaciones paramétricas (punto 2).

**Riesgos:** la consolidación es obra (migración — sección 25 cap. 01 punto 5).

**Solución:** fuente única (punto 1).

**Cómo se evita:** plantilla de repo desde el día 1 (sección 18).

---

### Error 2: plantilla abandonada

**Qué ocurrió:** la plantilla tenía checks de 2024; los repos nuevos salían con CI viejo.

**Por qué:** nadie es dueño de la plantilla (sección 03 cap. 03 Error 5).

**Cómo comprobarlo:** edad de los últimos commits de la plantilla vs. repos.

**Opciones:** dueño nominal + revisión en calendario + reporte de versiones (punto 4).

**Riesgos:** estándar falso: parece aplicado y no lo está.

**Solución:** ciclo de propagación (punto 4).

**Cómo se evita:** la plantilla es producto: tiene dueño y métrica.

---

### Error 3: invocación flotante sin versión

**Qué ocurrió:** el workflow central cambió y 40 repos se rompieron el mismo lunes.

**Por qué:** `uses:` apuntando a rama mutable sin control (punto 2).

**Cómo comprobarlo:** revisar referencias de `uses:`: ¿tag/SHA o rama flotante?

**Opciones:** fijar versión; cambios en el central se adoptan por PR de migración (punto 4).

**Riesgos:** rotura en cadena (sección 16 cap. 05).

**Solución:** versionar y adoptar (punto 4).

**Cómo se evita:** política: referencias siempre a tag (política + aplicación — sección 03).

---

### Error 4: estandarización total

**Qué ocurrió:** la plantilla prohibía lo que no preveía; los equipos forkeaban y se alejaban.

**Por qué:** piso y techo confundidos (punto 5).

**Cómo comprobarlo:** forks de la plantilla y divergencias.

**Opciones:** separar piso obligatorio vs. extensiones opcionales; abrir la propuesta de mejora al estándar.

**Riesgos:** la rebelión silenciosa.

**Solución:** piso común, margen local (punto 5).

**Cómo se evita:** comité ligero recoge mejoras locales (sección 03 cap. 03).

---

### Error 5: nadie mira el reloj del CI

**Qué ocurrió:** el CI pasó de 6 a 35 minutos y todos «se acostumbraron».

**Por qué:** sin presupuesto ni métrica (punto 3).

**Cómo comprobarlo:** duración media por PR (medición disponible en la plataforma).

**Opciones:** acotar por paths, caché, jobs paralelos (punto 3); presupuesto escrito.

**Riesgos:** lentitud crónica = gente que evita los PRs.

**Solución:** presupuesto de CI (punto 3).

**Cómo se evita:** duración como métrica de la retro (sección 24 cap. 06).

---

### Error 6: big-bang de la plantilla

**Qué ocurrió:** se actualizó el estándar y se abrieron 40 PRs un día; 15 quedaron olvidados.

**Por qué:** despliegue masivo sin piloto ni lotes (punto 4).

**Cómo comprobarlo:** repos desactualizados tras semanas.

**Opciones:** piloto → lotes por equipo → reporte de pendientes con fecha.

**Riesgos:** brecha permanente (Error 1/2).

**Solución:** adopción por lotes (punto 4).

**Cómo se evita:** la métrica «versión del estándar» obliga a mirar.

---

### Error 7: plantilla que decide de más

**Qué ocurrió:** el proyecto X necesitaba paso extra y lo hizo «fuera» del CI, a mano.

**Por qué:** el estándar no contemplaba parámetros (punto 5).

**Cómo comprobarlo:** pasos manuales recurrentes fuera del pipeline.

**Opciones:** añadir punto de extensión (job/step opcional por config).

**Riesgos:** CI que no refleja la verdad.

**Solución:** piso + extensiones (punto 5).

**Cómo se evita:** el proceso de mejora del estándar escucha los «fuera».

---

## 7. Práctica guiada

### Objetivo

Poner la base de CI a escala en tu contexto: fuente única, impacto y adopción.

### Paso 1: inventario de duplicación

```text
Tus repos / áreas:
   │
   ├── ¿workflows copiados? ¿cuántos difieren?
   ├── ¿plantilla? ¿última actualización?
   └── ¿referencias de `uses:`: ¿versionadas?
```

1. Anota la brecha actual (esto es tu Error 1 medido).

### Paso 2: fuente única

1. Elige el mecanismo (punto 2): workflow reutilizable con `with:` paramétrico (lenguaje, comandos, si corre DAST…).

### Paso 3: impacto

1. Añade `paths` de docs y detección de paquetes afectados donde aplique (punto 3).

### Paso 4: presupuesto

```text
CI de un PR típico: ____ min (hoy)
Presupuesto: ____ min
Métrica en la retro: sí / no
```

### Paso 5: propagación

1. Escribe el ciclo (punto 4) para TU caso: piloto → lotes → reporte de versiones. ¿Quién es dueño?

### Paso 6: piso y margen

1. Lista lo obligatorio (piso) y lo opcional (extensiones) de tu estándar (punto 5).

### Resultado esperado

Brecha medida, fuente única diseñada con parámetros, presupuesto y ciclo de adopción con dueño.

### Conclusión esperada

La automatización a escala no es más YAML: es una única fuente versionada, invocada con parámetros, adoptada con reporte — y un CI cuyo reloj alguien mira.

---

## 8. Nivel profesional + resumen

### 8.1. A escala real

```text
   │
   ├── «golden path»: plantilla oficial + workflows
   │   centrales versionados + acciones de la org
   │   (sección 18/19)
   │
   ├── reporte de conformidad: repos vs. versión del
   │   estándar (inventario — sección 20/24)
   │
   ├── presupuesto de CI por tipo de repo, con alerta
   │   de regresión
   │
   ├── adopción como proyecto: dueño, lotes, fecha,
   │   cierre verificado (sección 22/23)
   │
   └── métricas: % repos actualizados, duración de CI,
       nº de pasos manuales fuera del pipeline
```

### 8.2. Resumen

En este capítulo aprendiste que:

* escala = fuente única de CI/estándar, invocada con parámetros y versionada;
* mecanismos: workflow reutilizable, plantilla de repo, acciones propias, config por repo;
* detección de impacto y presupuesto mantienen el CI ágil (paths, paquetes afectados, caché);
* propagar un estándar es un ciclo: PR → piloto → versión → lotes → reporte;
* el estándar es piso obligatorio con margen para lo local;
* los errores típicos (copias divergentes, plantilla abandonada, referencias flotantes, estandarización total, CI sin reloj, big-bang, plantilla invasiva) se previenen con dueños, versiones y métricas;
* a nivel profesional: golden path, conformidad medida y adopción como proyecto.

La idea principal es:

> **Escalar automatización no es repetir pipelines: es que el estándar tenga una sola fuente versionada y que «está actualizado» sea un reporte, no una suposición.**

---

## Próximo paso

Ya automatizas sin duplicar.

La última pieza de la arquitectura: cómo vive, evoluciona y termina un repositorio.

Continúa con:

[`05-mantenimiento-y-vida-del-repositorio.md`](05-mantenimiento-y-vida-del-repositorio.md)
