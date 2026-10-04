# Permisos y gobernanza

## Introducción

Con el repositorio decidido y sus límites dibujados, llega la capa que gobierna el conjunto: **quién puede qué, y con qué reglas se toman las decisiones que afectan a todos**. Los permisos (sección 08 y 16) resuelven el «quién»; la gobernanza resuelve el «cómo se decide y se aplica»: políticas, estándares, excepciones y dueños a escala. Este capítulo aplica ambos a arquitectura de repositorios: no se trata solo de roles en GitHub, sino de quién gobierna la estructura, los estándares y las excepciones de todo el ecosistema.

---

## Mapa conceptual de este capítulo

```text
Permisos y gobernanza
       │
       ├── 1. Del rol al gobierno (la capa completa)
       ├── 2. Matriz de permisos por ámbito
       ├── 3. Políticas y estándares: escribir, aplicar,
       │   revisar
       │   ├── 4. Dueños y estructura de decisión
       │   └── 5. Excepciones: el camino legítimo
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Del rol al gobierno (la capa completa)

```text
SECUENCIA LÓGICA (sección 00 → 25):
   │
   ├── permisos básicos: admin/triagem/lectura
   │   (sección 08) → el control operativo
   │
   ├── ramas protegidas + rulesets (sección 20 cap.
   │   06) → el control del historial
   │
   ├── CODEOWNERS (sección 16 cap. 06) → el control
   │   del conocimiento
   │
   └── gobernanza (aquí) → el control de las REGLAS:
       quién las escribe, quién las aplica, cómo se
       exceptúan y cuándo se revisan
```

```text
   │
   └── gobernanza mínima = dueños + política escrita +
       camino de excepción + revisión periódica (Error
       1 si falta cualquiera: hay roles pero nadie
       gobierna — «todos administradores» de la sección
       08)
```

---

## 2. Matriz de permisos por ámbito

```text
MATRIZ (ejemplo adaptable — la tuya documenta):
──────────────────────────────────────────────────────
ÁMBITO        LECTURA   ESCRITURA   ADMIN
repo dev      el equipo equipo      1-2 dueños
repo ops/     todo el   dueños      solo dueño
infra         equipo    (sección
              + audit   16/23)
repo libs     consumi-  dueños de   dueño de la
compartidas   dores     la lib       lib
org base      todos     equipo      admin org
              (issues)  CI        (sección 08)
```

```text
REGLAS DE ORO:
   │
   ├── mínimo privilegio (sección 20 cap. 05): nadie
   │   tiene más de lo que su rol ejerce
   │
   ├── separación: quien escribe código no administra
   │   la protección de sus propias ramas (Error 2 si
   │   el dueño puede saltarse su propia puerta)
   │
   └── revisión semestral de la matriz (quién tiene
       qué — Error 3 si nadie revisa tras moverse gente)
```

```text
   │
   └── la matriz está en un documento, no en la
       memoria de un administrador (Error 4)
```

---

## 3. Políticas y estándares: escribir, aplicar, revisar

```text
POLÍTICA vs. ESTÁNDAR:
   │
   ├── política: la REGLA («nadie hace force-push en
   │   main» — sección 07)
   │
   └── estándar: el CÓMO (plantilla de repo, estructura
       de carpetas — cap. 01/02 de esta sección)
```

```text
CICLO DE VIDA (sección 23 cap. 01 — todo se
automatiza y se revisa):
   │
   ├── 1. escribir: un documento corto y citable (la
   │   tabla de la sección 24 cap. 06 es modelo)
   ├── 2. aplicar: la política se CONVIERTE en
   │   automatización (checks, rulesets, plantillas)
   ├── 3. comunicar: onboarding y README (sección 14)
   └── 4. revisar: cuando un incidente la contradice o
       cambia el contexto (post-mortem → política nueva
       — sección 24 cap. 06)
```

```text
   │
   └── política sin automatización es solo papel; política
       sin revisión es reliquia (Error 5 si pasa una de
       las dos)
```

---

## 4. Dueños y estructura de decisión

```text
NIVELES DE DUEÑO (multi-repo — cap. 01):
   │
   ├── dueño de repo (CODEOWNERS — sección 16 cap. 06)
   ├── dueño de área/estándar (estructura, CI base,
   │   seguridad — sección 19/20/24)
   └── dueño de ecosistema: quién decide los estándares
       compartidos (el «arquitecto rotativo» o comité
       ligero)
```

```text
DECISIONES QUE TOCAN A TODOS (aquí sí hay proceso):
   │
   ├── cambiar la estructura base / plantillas
   ├── añadir/quitar puertas de CI globales
   └── reglas de rama y permisos de la org
```

```text
PROCESO LIGERO (adaptable):
   │
   ├── propuesta como documento/PR (RFC mínimo: qué,
   │   por qué, consecuencias — sección 26 cap. 04
   │   menciona decisiones técnicas)
   ├── revisión de los dueños afectados
   ├── decisión con fecha y registro (Error 6 si se
   │   decide «en la reunión» sin quedar)
   └── aplicación en el siguiente ciclo de plantillas
```

```text
   │
   └── en equipos pequeños: dueño ÚNICO + checklist.
       La estructura DECIDE una persona, pero siempre
       por escrito (Error 6)
```

---

## 5. Excepciones: el camino legítimo

```text
POR QUÉ EXISTE (Error 1 de la sección 24 cap. 02/04):
   │
   ├── la regla que no tiene excepción CONTROLADA
   │   tiene BYPASS SECRETO
   │
   └── además, hay casos reales: emergencias, legacy,
       experimentos
```

```text
EXCEPCIÓN VÁLIDA (todos los campos o no es válida):
   │
   ├── qué regla se salta
   ├── por qué (caso concreto)
   ├── quién aprueba (dueño del estándar)
   ├── hasta cuándo (fecha de caducidad)
   ├── riesgo aceptado (escrito — sección 22 cap. 04
   │   errores con riesgos)
   └── cómo se retira (automático o recordatorio)
```

```text
   │
   └── las excepciones abiertas son MÉTRICA (sección
       24 cap. 06): si crecen, la regla está mal —
       no el mundo (Error 5)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: roles sin gobierno

**Qué ocurrió:** todo el mundo era admin en 10 repos; nadie sabía quién decidía estructura ni estándares.

**Por qué:** se configuraron permisos sin diseñar gobernanza (punto 1).

**Cómo comprobarlo:** para cada decisión «que toca a todos»: ¿tiene dueño y proceso?

**Opciones:** definir dueños + el proceso ligero del punto 4.

**Riesgos:** caos por unanimidad o por imposición.

**Solución:** la capa completa (punto 1).

**Cómo se evita:** la gobernanza es parte de la checklist de nuevo repo.

---

### Error 2: el dueño se salta su propia puerta

**Qué ocurrió:** quien definía las protecciones podía desactivarlas; un mal día lo hizo y nadie lo vio.

**Por qué:** sin separación entre quien administra y quien escribe (punto 2).

**Cómo comprobarlo:** registros: ¿el dueño ha tocado sus propias protecciones? ¿requiere segunda persona?

**Opciones:** segunda aprobación para cambios de reglas; registro visible (sección 20 cap. 05).

**Riesgos:** rotura del control más importante.

**Solución:** separación de poderes (punto 2).

**Cómo se evita:** la regla vive en el proceso, no en la buena voluntad.

---

### Error 3: nadie revisa quién tiene qué

**Qué ocurrió:** un colaborador que se fue mantuvo permisos de escritura seis meses.

**Por qué:** sin revisión semestral (punto 2).

**Cómo comprobarlo:** listar colaboradores y PAT/token con permiso de escritura (sección 08/20).

**Opciones:** revocar todo lo que no tenga dueño claro; calendario de revisión.

**Riesgos:** acceso huérfano (Error de sección 20 cap. 05).

**Solución:** revisión con calendario (punto 2).

**Cómo se evita:** alta/baja de personas = checklist de permisos (sección 16).

---

### Error 4: la matriz en la cabeza de un admin

**Qué ocurrió:** el único admin de la org estaba de vacaciones y nadie sabía quién podía aprobar cambios.

**Por qué:** sin documento (punto 2).

**Cómo comprobarlo:** si la persona no está, ¿quién sabe la matriz?

**Opciones:** escribirla hoy en `docs/gobernanza.md`; nominal: dueños y suplentes.

**Riesgos:** parálisis y accesos mal otorgados.

**Solución:** documento con dueños y suplentes (punto 2/4).

**Cómo se evita:** toda decisión de permisos queda en un log.

---

### Error 5: política sin aplicación o sin revisión

**Qué ocurrió:** «las dependencias se actualizan mensualmente» — nunca se ejecutó, ni nadie lo notó.

**Por qué:** política escrita sin automatizar ni revisar (punto 3).

**Cómo comprobarlo:** ¿el paso tiene check/dependabot/calendario? ¿Se ha revisado con un incidente?

**Opciones:** automatizar (Dependabot — sección 20 cap. 03) o retirar la política con honestidad.

**Riesgos:** credibilidad perdida del resto de políticas.

**Solución:** ciclo de vida completo (punto 3).

**Cómo se evita:** toda política nueva nace con su mecanismo de aplicación.

---

### Error 6: decisión que no queda escrita

**Qué ocurrió:** «quedó que la estructura sería X» — en el acta que nadie escribió; al mes cada quien recordaba algo distinto.

**Por qué:** decisión verbal sin registro (punto 4).

**Cómo comprobarlo:** ¿dónde está la decisión? Si no hay URL, no existe.

**Opciones:** escribirla con fecha, razones y dueño; enlazarla desde la política.

**Riesgos:** retrabajo y conflictos de memoria.

**Solución:** registro citable (punto 4).

**Cómo se evita:** plantilla de decisión: qué/por qué/cuándo/quién/dónde.

---

## 7. Práctica guiada

### Objetivo

Montar la gobernanza mínima de tu ecosistema de repositorios.

### Paso 1: matriz

1. Dibuja la matriz del punto 2 con tus ámbitos reales.
2. Revisa el mínimo privilegio: quita lo que nadie usa (Error 3).

### Paso 2: dueños

```text
Por cada ámbito:
   │
   ├── dueño principal
   ├── suplente
   └── decisiones que le corresponden (estándar,
       puertas, permisos)
```

### Paso 3: política + aplicación

1. Elige UNA política (ej.: «las dependencias tienen dueño y renovación»).
2. Aplícala: automatización o checklist con fecha (punto 3).

### Paso 4: excepción

1. Define el formulario de excepción (punto 5) — 6 campos, una página.
2. Déjalo donde se pida: `docs/gobernanza.md`.

### Paso 5: decisión registrada

1. Si cambiaste algo hoy (estructura, política): escríbelo con el registro del punto 4 y enlázalo.

### Paso 6: calendario

1. Agenda: revisión semestral de matriz (Error 3) y revisión anual de políticas (Error 5).

### Resultado esperado

Matriz con dueños y suplentes, una política aplicada, formulario de excepción y calendario de revisión.

### Conclusión esperada

Gobernar no es controlar: es que cada decisión que toca a todos tenga dueño, registro y forma legítima de excepcionarse — todo lo demás son permisos esperando un mal día.

---

## 8. Nivel profesional + resumen

### 8.1. Gobernanza a escala

```text
   │
   ├── modelo por defecto de la org: plantilla de repo
   │   con estructura, checks y protección ya puestos
   │   (Error prevención por diseño — sección 18)
   │
   ├── comité ligero (mensual, 30 min) de dueños:
   │   excepciones abiertas, métricas, propuestas
   │
   ├── auditoría automática: reporte de repos sin
   │   dueño, sin protección, con permisos extraños
   │   (sección 20 cap. 04/05 — inventario)
   │
   ├── cumplimiento (mención): marcos externos piden
   │   exactamente la matriz, el registro y las
   │   evidencias (sección 24 cap. 06)
   │
   └── métricas: excepciones abiertas, políticas con
       aplicación, tiempo propuesta→decisión
```

### 8.2. Resumen

En este capítulo aprendiste que:

* gobernanza = dueños + política escrita + aplicación + excepción controlada + revisión;
* la matriz de permisos por ámbito documenta quién puede qué, revisada y con mínimo privilegio;
* política y estándar tienen ciclo de vida: escribir, aplicar, comunicar, revisar;
* las decisiones que tocan a todos usan proceso ligero con registro citable;
* las excepciones son el camino legítimo: 6 campos, caducidad y métrica;
* los errores típicos (roles sin gobierno, dueño sin separación, accesos huérfanos, matriz en una cabeza, política decorativa, decisión oral) se previenen con estructura;
* a nivel profesional: modelo por defecto, comité ligero y auditoría automática.

La idea principal es:

> **Los permisos impiden lo que no debe pasar; la gobernanza asegura que lo que debe decidirse se decida bien — son dos controles distintos y un repositorio maduro necesita ambos.**

---

## Próximo paso

Gobierno: quién decide y cómo queda.

Ahora escala: cómo automatizar y estandarizar sin ahogar a los equipos.

Continúa con:

[`04-automatizacion-y-pipelines-a-escala.md`](04-automatizacion-y-pipelines-a-escala.md)
