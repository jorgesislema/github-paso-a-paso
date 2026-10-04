# Qué no debe entrar al repositorio

## Introducción

Este es el capítulo de las prohibiciones con motivo. El historial de Git es público para quien tenga acceso — y permanente para siempre: nada de lo que entró se borra de verdad sin reescribir historia. Aquí juntamos, en una sola lista operativa, todo lo que jamás debe entrar: credenciales, datos personales, archivos locales, salidas generadas y trabajo temporal — con el procedimiento para cuando ya entró.

---

## Mapa conceptual de este capítulo

```text
Qué no debe entrar al repositorio
       │
       ├── 1. La regla que lo explica todo
       ├── 2. Lista negra comentada
       │   ├── 3. La excepción: qué sí lleva un dato
       │   │       sensible (de verdad)
       │   ├── 4. Respuesta cuando ya entró
       │   └── 5. Prevención en el flujo de trabajo
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. La regla que lo explica todo

```text
EL HISTORIAL ES PERMANENTE:
   │
   ├── `git rm` quita del DIRECTORIO actual; el commit
   │   viejo sigue ahí (sección 13 cap. 04)
   │
   ├── quien clone después lleva todo lo que hubo
   │   (forks, cachés, copias…)
   │
   └── la plataforma y los rastreadores escanean
       historial (sección 20 cap. 02)
```

```text
LA PREGUNTA ANTES DE COMMITAR:
   │
   └── «si esto es público mañana para todo el que
       tenga (o robe) acceso, ¿es aceptable?»
       si la respuesta no es sí clara → no entra
```

```text
   │
   └── no es paranoia: es el mismo criterio con el que
       no pegas la contraseña del banco en un correo
       «para acordármela»
```

---

## 2. Lista negra comentada

```text
CREDENCIALES Y CLAVES (nunca):
   │
   ├── contraseñas, PATs, API keys, tokens de CI
   ├── claves privadas (SSH/GPG), certificados
   ├── .env con valores reales (solo .env.example)
   └── configs de nube con claves (access keys)
```

```text
DATOS SENSIBLES (nunca):
   │
   ├── datos personales de usuarios/clientes
   │   (correos, teléfonos, IDs…) — incluso «de
   │   prueba» si parecen reales
   │
   ├── información confidencial de negocio o legal
   ├── credenciales de terceros (bases, SAAS)
   └── prompts/registros con datos reales (sección 21
       cap. 04)
```

```text
ARCHIVOS LOCALES Y GENERADOS (nunca):
   │
   ├── node_modules/ · .venv/ · __pycache__/
   ├── builds (dist/, build/, .next/)
   ├── IDEs (ajustes personales; solo lo acordado)
   ├── logs, caches, coberturas
   └── datasets/pesos (cap. 05 — con excepciones
       decididas, no improvisadas)
```

```text
   │
   └── «nunca» tiene dos matices: credenciales y
       datos personales no admiten excepción; lo demás
       admite EXCEPCIÓN DECIDIDA (p. ej. assets fijos
       del curso) — pero nunca improvisada
```

---

## 3. La excepción: qué sí lleva un dato sensible (de verdad)

```text
CUANDO EL PROYECTO NECESITA «DATOS» EN EL REPO:
   │
   ├── fixtures: datos sintéticos inventados que
   │   imitan la forma del real (mismos campos, cero
   │   personas reales)
   │
   ├── ejemplos públicos: datasets ya publicados con
   │   licencia y sin datos personales
   │
   └── todo lo demás: referencia (cap. 05) con
       permisos de acceso
```

```text
TEST DE LOS DATOS DE EJEMPLO:
   │
   ├── ¿podría alguien identificar a una persona con
   │   esto? → si hay duda, anonimiza o inventa
   │
   └── ¿el «dato de prueba» viene de producción copiada?
        → si sí, no es «de prueba»: es un incidente en
          potencia
```

```text
   │
   └── regla de equipo: en repos y documentación de
       ejemplo, se usan NOMBRES Y CORREOS INVENTADOS
       (patrón: ana@ejemplo.com — nunca dominios
       reales de terceros)
```

---

## 4. Respuesta cuando ya entró

```text
SEGÚN LO QUE ENTRÓ:
──────────────────────────────────────────────────────
CREDENCIAL    1) ROTAR ya (sección 20 cap. 01)
              2) limpiar historial si procede
              3) verificar + post-mortem
DATOS         1) acotar: ¿acceso público? ¿tiempo?
PERSONALES    2) retirar del historial (purga
                  coordinada — cap. 05 punto 5)
              3) evaluar notificación (datos
                  personales pueden tener obligaciones
                  legales — mención: buscar asesoría;
                  esto no es asesoría)
LO GENERADO   1) git rm --cached + .gitignore
              2) opcional: purga si el peso molesta
```

```text
   │
   └── el orden importa: para secretos, ROTAR PRIMERO
       (limpiar el historial no desactiva la clave);
       para datos personales, primero acotar el acceso
```

```text
ESCALADO:
   │
   ├── público + datos sensibles → urgente y con
   │   aviso (equipo/seguridad — sección 16)
   │
   └── privado + detectado pronto → proceso normal
```

---

## 5. Prevención en el flujo de trabajo

```text
CONTROLES EN CAPAS (ya vistos, aquí el checklist):
   │
   ├── .gitignore completo de la plantilla (sección 13)
   ├── .env.example con placeholders — el real ignorado
   ├── secret scanning + push protection (sección 20
   │   cap. 02)
   ├── hook local de detección (sección 06/13)
   ├── revisión de PR: alguien más mira los archivos
   │   añadidos (sección 15) — «git add .» a ciegas
   │   es el modo en que entra lo malo
   └── formación: la regla de la pregunta (punto 1)
```

```text
HÁBITO DEL COMMIT:
   │
   ├── mirar SIEMPRE el `git status` y los diffs del
   │   staging antes de commitar
   │
   ├── añadir por ruta, no por «todo» (sección 04)
   │
   └── ante la duda: no staged → pregunta al equipo
```

```text
   │
   └── revisión de PR = segunda red humana; la
       automatización ve patrones, las personas ven
       «esto no debía estar aquí» (Error 6)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: `git add .` ciego

**Qué ocurrió:** el commit incluyó .env, notas personales y un csv de datos.

**Por qué:** se añadió todo sin mirar el status.

**Cómo comprobarlo:** `git show --stat` del commit.

**Opciones:** sacar lo malo del commit si no se ha push (amend/sección 07 — con cuidado); si se pushó: procedimiento del punto 4.

**Riesgos:** el «todo» es el vehículo clásico de la lista negra.

**Solución:** add por ruta + mirar diffs (punto 5).

**Cómo se evita:** hábito y revisión (punto 5).

---

### Error 2: .env.example con el valor real

**Qué ocurrió:** el «ejemplo» llevaba el token «para que funcione a todos».

**Por qué:** se copió el archivo real y se renombró.

**Cómo comprobarlo:** leer .env.example en el repo.

**Opciones:** limpiar + rotar si tenía valor real (punto 4).

**Riesgos:** secreto disfrazado de documentación (el peor de los mundos: parece seguro y no lo es).

**Solución:** placeholders obligatorios (punto 3).

**Cómo se evita:** checklist de plantilla.

---

### Error 3: datos de producción «anonimizados» a medias

**Qué ocurrió:** se quitó el nombre pero quedaron teléfono y correo reales.

**Por qué:** anonimización manual apresurada.

**Cómo comprobarlo:** revisión del archivo: ¿quedan identificadores?

**Opciones:** salir del historial (punto 4) + rehacer con datos inventados (punto 3).

**Riesgos:** falsa sensación de anonimato + obligaciones legales.

**Solución:** fixtures sintéticos (punto 3).

**Cómo se evita:** norma de datos de ejemplo (punto 3).

---

### Error 4: limpiar solo el árbol actual

**Qué ocurrió:** se borró el archivo con el editor y se dio por cerrado; el historial lo conservaba.

**Por qué:** se confundió directorio con historial (punto 1).

**Cómo comprobarlo:** `git log --all -- <archivo>`.

**Opciones:** procedimiento del punto 4 (rotación primero si es credencial).

**Riesgos:** incidente «resuelto» que sigue abierto.

**Solución:** entender la permanencia (punto 1).

**Cómo se evita:** formación desde la sección 02.

---

### Error 5: secretos en commits de PRs que se «cierran sin merge»

**Qué ocurrió:** se cerró el PR sin mergear y alguien dio por cerrado el problema — la rama y su historial ya estaban en el repositorio.

**Por qué:** se pensó que «sin merge = sin historia».

**Cómo comprobarlo:** el commit existe en el repo (ramas viven en el servidor).

**Opciones:** mismo procedimiento: rotar si era credencial; limpiar rama/historial si procede.

**Riesgos:** falso cierre.

**Solución:** en el servidor, todo lo push es historia (punto 1).

**Cómo se evita:** checklist de cierre de incidentes (punto 4).

---

### Error 6: nadie revisa archivos añadidos en los PRs

**Qué ocurrió:** cambios de código bien revisados, pero la lista de archivos se ignoró; entró un csv con datos.

**Por qué:** la revisión se centra en el «cómo» y no en el «qué» (sección 15 cap. 03).

**Cómo comprobarlo:** revisar PRs históricos: ¿se miraba la pestaña de archivos?

**Opciones:** norma: revisar también los archivos AÑADIDOS en cada PR; secret scanning como red (no como excusa).

**Riesgos:** la red humana desactivada.

**Solución:** checklist de revisión con «archivos nuevos» (punto 5).

**Cómo se evita:** plantilla de revisión (sección 15).

---

## 7. Práctica guiada

### Objetivo

Ejercitar la pregunta, la revisión y la respuesta — en un repo de práctica.

### Paso 1: lista negra propia

1. Copia la lista del punto 2 a `docs/reglas-del-repo.md` y añade un caso específico de tu proyecto (p. ej. «salidas de scraping»).

### Paso 2: la pregunta

```text
Simula tres archivos en staging:
   │
   ├── config.yaml (con un placeholder)
   ├── notas.md (con una contraseña inventada)
   └── datos/clientes.csv (con nombres inventados pero
       con pinta real)
¿Entran? Decide y justifica por escrito.
(Respuesta: 1 sí; 2 y 3 no — inventa/fixtures o fuera)
```

### Paso 3: revisión de archivos en un PR

1. Abre un PR que añada tres archivos (uno legítimo, uno de la lista negra simulado).
2. Practica la revisión: ¿dónde se ve qué se AÑADIÓ? Corrige el criterio.

### Paso 4: respuesta simulada

```text
Simula que un token entró en un commit ya pusheado:
   │
   ├── escribe el plan paso a paso (rotar → acotar →
   │   limpiar → verificar → post-mortem)
   └── compáralo con el punto 4 y con sección 20
       cap. 01 punto 5
```

### Paso 5: .env.example real

1. Asegúrate de que tu proyecto tiene `.env.example` con placeholders y `.env` ignorado.
2. Busca en el historial: `git log --all -- .env` (debe estar vacío o ser conocido).

### Paso 6: publica las reglas

1. `docs/reglas-del-repo.md` en el README (sección 14 cap. 02) — que sea fácil de encontrar.

### Resultado esperado

Reglas publicadas, revisión con criterio de «archivos añadidos» y plan de respuesta practicado.

### Conclusión esperada

Lo que no entra no se limpia: la prevención es un hábito de staging, una revisión que mira archivos y una regla que cualquiera puede citar.

---

## 8. Nivel profesional + resumen

### 8.1. Prevención a escala

```text
   │
   ├── reglas del repo en plantillas y en el onboarding
   │   (sección 00/16)
   │
   ├── secret scanning + push protection obligatorios
   │   (sección 20)
   │
   ├── revisión con checklist que incluye «archivos
   │   nuevos» (sección 15)
   │
   ├── datos personales: política de fixtures
   │   sintéticos + revisión legal cuando proceda
   │
   ├── respuesta: runbook con tiempos (rotación < 1 h)
   │
   └── métrica: incidentes de entradas indebidas/año
       (ideal: tienden a cero tras formación)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* la permanencia del historial lo decide todo: la pregunta previa al commit es la defensa primera;
* lista negra: credenciales, datos personales, locales y generados — con excepciones decididas, nunca improvisadas;
* datos de ejemplo: sintéticos y verificables; si parecen reales, son un incidente;
* respuesta: credenciales → rotar primero; datos personales → acotar y evaluar; generados → índice + ignorar;
* prevención en capas: gitignore, ejemplo limpio, escaneo, hooks, revisión de archivos en PR y hábito del add por ruta;
* a nivel profesional: reglas en plantillas, runbook y métrica.

La idea principal es:

> **El repo recuerda todo: lo que no puede ser público mañana no debe tener un lugar en el staging hoy — y si lo tuvo, se empieza por desactivarlo, no por limpiarlo.**

---

## Próximo paso

Has completado la sección de Git para disciplinas.

Continúa con el cierre:

[`README.md`](README.md)
