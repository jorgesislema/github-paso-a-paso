# Rúbrica del proyecto final

## Introducción

Esta es la **rúbrica pública** del Proyecto final: las seis dimensiones por las que se evalúa el entregable, con niveles explícitos y ejemplos de evidencia. No es un formulario al final del camino: se escribe de forma temprana (capítulo 01, punto 4), se usa como checklist en cada capítulo y se autoevalúa con enlaces en el capítulo 06. Un evaluador —o tú mismo— puede puntuar tu proyecto solo con esta rúbrica y los enlaces de tu repositorio.

---

## Mapa conceptual de este capítulo

```text
Rúbrica del proyecto final
       │
       ├── 1. Cómo se usa (temporalidad)
       ├── 2. Las seis dimensiones y sus niveles
       │   ├── 3. Evidencias que cuentan (y las que no)
       │   └── 4. Criterio mínimo de aprobación
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Cómo se usa (temporalidad)

```text
TRES MOMENTOS (Error 1 si solo existe en el último):
   │
   ├── 1. TEMPRANA (capítulo 01): copias esta rúbrica a
   │   `docs/rubrica.md` de tu proyecto, la personalizas
   │   (¿qué significa cada nivel para TU alcance?) y la
   │   commiteas ANTES de la primera línea de código
   │
   ├── 2. CONTINUA (capítulos 02–05): cada checklist de
   │   capítulo cita sus dimensiones — la rúbrica es el
   │   hilo, no un anexo
   │
   └── 3. AUTOEVALUADA (capítulo 06): puntúas con
       ENLACES — sin enlace, sin punto (Error 2)
```

```text
   │
   └── NIVELES: 1 insuficiente · 2 parcial · 3 completo ·
       4 exemplary — cada nivel tiene ejemplo concreto,
       no adjetivos
```

---

## 2. Las seis dimensiones y sus niveles

### 2.1. Flujo

```text
DIMENSIÓN: el proyecto se construyó mediante el flujo
completo — ramas, PRs, integración.
   │
   ├── 1. insuficiente: commits directos en main; sin PRs
   ├── 2. parcial: 1–2 PRs, el resto en main
   ├── 3. completo: ≥ 6 PRs con revisión real; historial
   │   de ramas visible en `git log --all --oneline`
   └── 4. exemplary: el flujo es auditable — cada feature
       tiene su rama, su PR, su merge y su issue cerrado;
       un revisor reconstruye el «por qué» del orden de
       los merges
```

### 2.2. Disciplina

```text
DIMENSIÓN: el historial cuenta la historia — commits
atómicos, mensajes legibles, issues cerrados.
   │
   ├── 1. insuficiente: commits «update», «cambios», sin
   │   issues
   ├── 2. parcial: mensajes aceptables pero commits
   │   grandes (múltiples temas por commit)
   ├── 3. completo: commits atómicos con asunto claro;
   │   issues cerrados con enlace al PR
   └── 4. exemplary: el historial se lee como documento —
       `git log --oneline` de cualquier feature explica su
       progreso; los mensajes incluyen el porqué, no solo
       el qué
```

### 2.3. Calidad

```text
DIMENSIÓN: las pruebas son puerta, no decorado.
   │
   ├── 1. insuficiente: sin pruebas, o pruebas que no
   │   corren en CI
   ├── 2. parcial: pruebas en CI pero no bloqueantes
   ├── 3. completo: suite bloqueante en PR (check
   │   requerido) + prueba negativa guardada (un PR rojo
   │   que se bloqueó de verdad)
   └── 4. exemplary: la suite detecta un error deliberado
       (mutación) y el PR que lo contiene queda bloqueado;
       la evidencia del rojo está enlazada
```

### 2.4. Seguridad

```text
DIMENSIÓN: las credenciales y los controles viven donde
deben.
   │
   ├── 1. insuficiente: secretos en el código o
   │   historial; sin scans
   ├── 2. parcial: scans activos pero sin ejercicio
   │   («configurado» sin «ejercido»)
   ├── 3. completo: secret scanning + push protection
   │   probados (un secreto de prueba quedó bloqueado y la
   │   evidencia existe); Dependabot activo; permisos de
   │   workflows mínimos
   └── 4. exemplary: los tres anteriores + una alerta
       resuelta de principio a fin (o documento de cómo se
       resolvería) + revisión de permisos de cada workflow
       escrita en el README
```

### 2.5. Entrega

```text
DIMENSIÓN: el proyecto se publica y se puede deshacer.
   │
   ├── 1. insuficiente: sin versión ni release
   ├── 2. parcial: tag sin notas ni artefacto
   ├── 3. completo: release versionada (semver) con notas,
   │   artefacto del pipeline y verificación en un clon
   │   limpio; rollback documentado y ensayado
   └── 4. exemplary: lo anterior + el rollback ejecutado
       de verdad (no solo documentado) con su evidencia;
       «¿qué versión tengo?» responde en un comando
```

### 2.6. Lectura

```text
DIMENSIÓN: un recién llegado entiende el proyecto sin ti.
   │
   ├── 1. insuficiente: README ausente o «hola mundo»
   ├── 2. parcial: README básico; instalar no funciona la
   │   primera vez
   ├── 3. completo: README probado (otro clona, instala y
   │   ejecuta en < 5 min sin tu ayuda); docs/ ordenado
   │   con decisiones (ADR) y flujo
   └── 4. exemplary: el tour de 15 minutos del capítulo 06
       se ejecuta desde el README — cada paso tiene su
       enlace; un desconocido llega al release en < 15 min
```

---

## 3. Evidencias que cuentan (y las que no)

```text
CUENTA:
   │
   ├── URL de PR, run, release, tag, issue
   ├── salida de comando (`git log --oneline -10`)
   ├── captura del check bloqueando (rojo visto)
   └── enlace a docs/ con la decisión escrita

NO CUENTA:
   │
   ├── «está configurado» sin_run ni enlace
   ├── captura del editor con código
   └── afirmaciones de memoria («yo lo hice en su momento»)
```

```text
   │
   └── regla del capítulo 06: SIN ENLACE, SIN PUNTO — la
       rúbrica mide evidencia, no intención (Error 2)
```

---

## 4. Criterio mínimo de aprobación

```text
MÍNIMO PARA CONSIDERAR EL PROYECTO ENTREGADO:
   │
   ├── nivel 3 (completo) en las 6 dimensiones
   │   (si el alcance recortado está escrito en el diseño —
   │   cap. 01 — se sustituye esa dimensión por su
   │   equivalente recortado, no por un «aproximado»)
   │
   ├── nivel 4 en la dimensión que el proyecto elija como
   │   bandera (el «hago esto mejor que el resto»)
   │
   └── cero nivel 1 en cualquier dimensión — un 1 es
       tarea del backlog con fecha, no entrega
```

```text
   │
   └── autoevaluación: se puntúa 48 h antes de entregar y
       la diferencia entre la rúbrica temprana y la final
       es la mejora visible del proyecto (Error 3)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: rúbrica tardía

**Qué ocurrió:** la rúbrica se «escribió» el día de la entrega, a la vista del proyecto — cada nivel se ajustó a lo que ya existía.

**Por qué:** sin rúbrica temprana (punto 1 momento 1).

**Cómo comprobarlo:** ¿existe `docs/rubrica.md` commiteada antes del primer commit de código?

**Opciones:** en proyectos en curso: anotar fecha y aceptar que la rúbrica ya no gobierna; en futuros: copiarla al día 1 (cap. 01).

**Riesgos:** autoevaluación inflada por construcción (Error 5 sección 06).

**Solución:** rúbrica temprana (punto 1).

**Cómo se evita:** paso 5 del capítulo 01: la rúbrica está en la checklist del diseño.

---

### Error 2: puntuar por memoria

**Qué ocurrió:** «todo 4» y, al pedir los enlaces, tres dimensiones sin evidencia.

**Por qué:** sin enlaces (punto 3).

**Cómo comprobarlo:** cada 4 con URL; si no hay URL, el nivel cae.

**Opciones:** re-evaluar hoy con la regla «sin enlace, sin punto».

**Riesgos:** el proyecto «aprobado» no demuestra lo que dice.

**Solución:** rúbrica con enlaces (punto 3, cap. 06).

**Cómo se evita:** la autoevaluación del cap. 06 se hace en un clon limpio, no en la carpeta «de memoria».

---

### Error 3: rúbrica congelada

**Qué ocurrió:** el diseño cambió en el capítulo 03 y la rúbrica siguió exigiendo lo original; el equipo la ignoró.

**Por qué:** sin revisión de la rúbrica ante cambios de alcance (punto 1 momento 2).

**Cómo comprobarlo:** ¿los cambios de alcance tienen su ADR y la rúbrica actualizada?

**Opciones:** actualizar la rúbrica con el ADR (mismo PR); o mantener la original y ejecutar el recorte.

**Riesgos:** rúbrica que miente en ambas direcciones (exige lo que no será o deja de exigir lo que sí será).

**Solución:** rúbrica viva y versionada como el resto (punto 1).

**Cómo se evita:** «cambio de alcance = PR que toca rúbrica + ADR».

---

## 6. Práctica guiada

### Objetivo

Dejar la rúbrica operando en tu proyecto final: temprana, viva y autoevaluable.

### Paso 1: copia temprana

1. Copia este capítulo a `docs/rubrica.md` en tu proyecto (o enlázalo) y personaliza los ejemplos a TU alcance. Commitea antes de codificar.

### Paso 2: niveles base

1. Puntúate HOY (día 1) en las 6 dimensiones: será casi todo 1. Anótalo — es tu línea de partida.

### Paso 3: seguimiento por capítulo

1. Al terminar cada capítulo 02–05: repuntúa con enlaces. Lo que suba, se gana; lo que baje, se diagnostica.

### Paso 4: autoevaluación final

1. Con la rúbrica y los enlaces del cap. 06: puntúa las 6 dimensiones; cada 3+ con URL. Registra los 1–2 con fecha en backlog.

### Paso 5: entrega

```text
Checklist:
   [ ] docs/rubrica.md commiteada antes del código
   [ ] puntuación día 1 vs. final (diferencia visible)
   [ ] cada nivel 3+ con enlace de evidencia
   [ ] el recorte de alcance (si aplica) con ADR
```

### Resultado esperado

Una rúbrica que gobernó el proyecto desde el diseño y que, al final, se puntúa con enlaces en 10 minutos.

### Conclusión esperada

Cuando la rúbrica existe antes que el código, «terminado» deja de ser una sensación: es un nivel en cada dimensión, cada uno con su evidencia.

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto al trabajo real

```text
   │
   ├── esta rúbrica es la versión doméstica de la
   │   definición de done de un equipo (sección 28 cap.
   │   01 — y del mundo real: los equipos serios puntúan
   │   entregas contra criterios escritos)
   │
   ├── el criterio «sin enlace, sin punto» es la misma
   │   mecánica de la auditoría: afirmación + evidencia
   │   (sección 26 cap. 06)
   │
   └── la rúbrica temprana + viva es gobernanza en
       miniatura: los criterios se discuten antes y se
       cambian con ADR (sección 25 cap. 03)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* la rúbrica tiene seis dimensiones (flujo, disciplina, calidad, seguridad, entrega, lectura) y cuatro niveles por dimensión;
* se usa en tres momentos: temprana, continua y autoevaluada — no al final;
* la evidencia es enlace o comando: «configurado» sin «ejercido» no puntúa;
* el criterio mínimo es 3 en todas las dimensiones (con recortes escritos si hay ADR) y 4 en la dimensión bandera;
* los errores típicos (rúbrica tardía, puntuar por memoria, rúbrica congelada) se previenen con la temporalidad del punto 1;
* la autoevaluación 48 h antes de entregar convierte la rúbrica en plan de mejora.

La idea principal es:

> **Una rúbrica escrita antes del código convierte «¿está terminado?» en seis preguntas con niveles y evidencias — y un proyecto que se puntúa solo es un proyecto que se puede demostrar.**

---

## Próximo paso

La rúbrica está lista para gobernar tu proyecto.

Vuelve al capítulo 01 y escríbela en `docs/rubrica.md` antes de la primera línea de código:

[`01-diseno-del-proyecto-final.md`](01-diseno-del-proyecto-final.md)
