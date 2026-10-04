# Proyecto 6: proyecto de datos

## Introducción

El Proyecto 6 enfrenta la limitación que Git nunca tuvo pensada: **los datos**. Un proyecto de datos — análisis con notebooks o pipeline de transformación — obliga a decidir qué va al repositorio, qué no, cómo se versiona lo que sí entra y cómo se prueban resultados que dependen de archivos externos. Aquí se practican las secciones 21 cap. 05 y 06 (datos, artefactos, archivos grandes) y 22 (pipelines con artefactos), con un entregable que produce resultados reproducibles.

---

## Mapa conceptual de este capítulo

```text
Proyecto 6: proyecto de datos
       │
       ├── 1. Qué construyes y qué conceptos incorpora
       ├── 2. La regla de oro: qué entra y qué no
       │   ├── 3. Código de datos: notebooks y scripts
       │   └── 4. Pipeline y artefactos de resultados
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes y qué conceptos incorpora

```text
EL PROYECTO:
   │
   ├── un análisis real con datos públicos o generados:
   │   notebook(s) o scripts que cargan → limpian →
   │   analizan → producen un reporte (tabla/figura)
   │
   └── entregable: el RESULTADO se regenera con un
       comando (Error 1 si el resultado solo existe en
       el notebook «ejecutado con suerte»)
```

```text
CONCEPTOS NUEVOS (secciones 21/22):
   │
   ├── qué datos son código y qué no (sección 21 cap.
   │   05/06)
   ├── .gitignore inteligente para datos y salidas
   ├── datasets pequeños versionados vs. grandes
   │   referenciados (categoría: Git LFS / descargas —
   │   sección 21 cap. 05)
   ├── reproducibilidad: fuentes, semillas, versiones
   └── artefactos de análisis en CI (sección 22 cap.
       05)
```

```text
   │
   └── el salto: Git guarda TEXTO bien; tu trabajo es
       diseñar qué parte de un proyecto no-textual
       merece historial (Error 2 si «entra todo» o
       «no entra nada»: ambas extremidades fallan)
```

---

## 2. La regla de oro: qué entra y qué no

```text
ENTRA (versionado — reproducibilidad):
   │
   ├── scripts/notebooks que producen los resultados
   ├── datos PEQUEÑOS de muestra (si son parte del
   │   contrato: pocos KB–MB)
   ├── lista de fuentes + cómo descargar/regenerar
   │   (URL, fecha de descarga, checksum si aplica)
   ├── esquemas/configuración de columnas esperadas
   └── requirements/entorno fijado (sección 04 cap. 04)
```

```text
NO ENTRA (Error 3 si entra):
   │
   ├── datasets pesados → descarga o almacén externo
   │   referenciado (sección 21 cap. 05)
   ├── salidas regenerables (figuras intermedias,
   │   cache) → gitignore
   ├── datos personales/sensibles (sección 21 cap. 06
   │   Error 1 — jamás: es un incidente, no una
   │   decisión de peso)
   └── modelos entrenados pesados → artefacto/almacén
       (sección 21 cap. 04 — el modelo no vive en Git)
```

```text
   │
   └── el test de la decisión: «¿puede otro regenerar
       esto desde cero con solo el repo?» — si sí, tu
       línea está bien (punto Error 4 si la respuesta
       es no y no documentaste fuentes)
```

---

## 3. Código de datos: notebooks y scripts

```text
NOTEBOOKS CON DISCIPLINA (sección 21 cap. 03):
   │
   ├── «Restart & Run All» limpio = verde antes de
   │   mergear (Error 5 sección 03 cap. 21 —
   │   celda desordenada que solo corre en tu orden)
   │
   ├── outputs: decisión explícita (limpiar antes de
   │   commit si ensucian el diff — convención
   │   documentada)
   │
   └── lógica NO viva solo en notebooks: la parte
       crítica se extrae a módulos con pruebas (Error
       4 si «el análisis» es una caja negra de 40
       celdas)
```

```text
PIPELINE DEL ANÁLISIS (reproducible):
   │
   ├── 1 comando: cargar (datos de `data/` o
   │   descargados) → transformar → resultado en
   │   `resultados/` (gitignore salvo el reporte final
   │   que quieras conservar)
   │
   └── semillas fijadas (random) — resultados
       comparables entre máquinas
```

```text
   │
   └── «números que cambian al re-ejecutar» es la
       forma más sutil de no-reproducibilidad (Error 5:
       lo no verificable no se puede confiar)
```

---

## 4. Pipeline y artefactos de resultados

```text
CI PARA DATOS (sección 22 — versión acotada):
   │
   ├── job «análisis»: entorno fijado → datos de
   │   muestra → ejecutar pipeline → verificar
   │   resultados esperados (aserciones: nº filas,
   │   esquema, totales de control)
   │
   ├── el reporte final como ARTEFACTO del run (sección
   │   22 cap. 05 — Error 6 si solo existe en tu disco:
   │   nadie más lo tiene)
   │
   └── si los datos pesados viven fuera: el CI los
       descarga con credencial/URL referenciada (sección
       20 cap. 01 si hay token — secrets de la
       plataforma)
```

```text
QUÉ VERIFICA EL CHECK:
   │
   ├── el pipeline corre de punta a punta (humo)
   ├── aserciones de resultados con datos de muestra
   └── (si aplica) calidad básica: esquema, nulos,
       duplicados (sección 21 cap. 03 mención)
```

```text
   │
   └── el entregable del Proyecto 6: «un PR rompió el
       análisis y el check lo DETECTÓ» — pruébalo (Error
       6 prevención — Error 5 sección 03 de esta
       sección)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: resultados no regenerables

**Qué ocurrió:** el reporte final no se pudo reproducir; nadie sabía con qué datos ni versión de librerías se hizo.

**Por qué:** sin pipeline ni fuentes documentadas (punto 1).

**Cómo comprobarlo:** «clona en limpio y ejecuta» — ¿sale el mismo resultado?

**Opciones:** fijar entorno, documentar fuentes+fechas, un comando de ejecución.

**Riesgos:** el análisis es una foto, no un proceso.

**Solución:** reproducibilidad como requisito (punto 3).

**Cómo se evita:** «restart & run all» en limpio como done.

---

### Error 2: extremos (todo o nada en el repo)

**Qué ocurrió:** un intento subió un dataset de 800 MB (Git muerto); otro intentó trabajar sin ningún dato ni muestra.

**Por qué:** sin regla (punto 2).

**Cómo comprobarlo:** tamaño del repo + ¿hay muestra versionada?

**Opciones:** línea escrita: qué entra (muestra+fuentes) y qué no (pesados).

**Riesgos:** historial inservible o análisis imposible.

**Solución:** la regla de oro (punto 2).

**Cómo se evita:** checklist «qué entra» en el README.

---

### Error 3: datos sensibles en el historial

**Qué ocurrió:** un CSV con datos personales entró en un commit; luego se «borró» en otro.

**Por qué:** borró el archivo, no el historial (Error 1 sección 21 cap. 06).

**Cómo comprobarlo:** buscar en el historial completo; secret scanning si aplica.

**Opciones:** tratar como incidente (sección 20 cap. 01): rotar, limpiar historia si procede, comunicar.

**Riesgos:** exposición permanente mientras el historial lo contiene.

**Solución:** jamás entran (punto 2).

**Cómo se evita:** pre-commit/ghidra de datos personales y cultura (sección 21 cap. 06).

---

### Error 4: lógica crítica solo en el notebook

**Qué ocurrió:** un cambio en la limpieza no se detectó: la caja negra no tenía pruebas.

**Por qué:** todo en celdas (punto 3).

**Cómo comprobarlo:** ¿qué parte del análisis tiene aserciones fuera del notebook?

**Opciones:** extraer funciones a módulos con pruebas; el notebook llama.

**Riesgos:** regresiones invisibles.

**Solución:** módulos con pruebas (punto 3).

**Cómo se evita:** regla: la lógica repetida o crítica vive en código con tests.

---

### Error 5: resultados que cambian al re-ejecutar

**Qué ocurrió:** mismos datos, distintos totales entre máquinas (ordenación y aleatoriedad sin semilla).

**Por qué:** semillas y orden no fijados (punto 3).

**Cómo comprobarlo:** ejecutar dos veces y comparar checksums de resultados.

**Opciones:** fijar semillas, orden determinista, fijar versiones de librerías.

**Riesgos:** discusiones sobre «qué número es el correcto».

**Solución:** determinismo (punto 3).

**Cómo se evita:** aserción de totales de control en CI (punto 4).

---

### Error 6: artefacto solo en el disco del autor

**Qué ocurrió:** el reporte final existía en una carpeta local; al compartir el repo, no estaba.

**Por qué:** salidas no gestionadas (Error 6 punto 4).

**Cómo comprobarlo:** ¿el último reporte es descargable desde un run del CI o está solo en un disco?

**Opciones:** publicar el reporte como artefacto del run; versionar solo el final si aporta.

**Riesgos:** trabajo no comunicable.

**Solución:** artefactos del pipeline (punto 4).

**Cómo se evita:** «¿de dónde saco el último resultado?» debe tener URL.

---

## 6. Práctica guiada

### Objetivo

Entregar un análisis reproducible: regenerable con un comando, protegido en CI y con política de datos escrita.

### Paso 1: política de datos

1. Escribe en README la regla del punto 2: qué entra, qué no, cómo se obtienen los pesados.

### Paso 2: estructura

```text
data/muestra/     (versionada, pequeña)
data/README       (fuentes + descarga)
notebooks/ o src/ (código del análisis)
resultados/       (gitignore salvo el final)
```

### Paso 3: pipeline de análisis

1. Un comando que va de punta a punta con semillas fijadas (punto 3).

### Paso 4: extrae y prueba

1. Saca a módulos la lógica crítica + pruebas con aserciones de resultados (punto 3/4).

### Paso 5: CI con aserciones

1. Workflow: entorno → muestra → ejecutar → verificar totales/esquema → publicar reporte como artefacto (punto 4).

### Paso 6: prueba negativa

1. Rompe la lógica a propósito: ¿el check falla? Corrige hasta que sí.

### Paso 7: entrega

```text
Checklist:
   [ ] política de datos escrita y cumplida
   [ ] repo ligero (sin pesados ni sensibles)
   [ ] análisis regenerable con 1 comando
   [ ] pruebas de resultados en CI (probadas en rojo)
   [ ] reporte como artefacto del run
```

### Resultado esperado

Análisis que cualquier persona puede regenerar desde el repo, con resultados verificados automáticamente.

### Conclusión esperada

Trabajar con datos en Git no es una trampa: es un ejercicio de diseño — quién puede regenerar qué, desde qué fuentes y con qué garantía — y el que lo diseña bien hace ciencia replicable, no magia personal.

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto a la vida real

```text
   │
   ├── datasets versionados vs. referenciados es la
   │   decisión de arquitectura de datos más común en
   │   equipos reales (sección 25 — contexto y
   │   consecuencias)
   │
   ├── sensibilidad de datos = gobernanza (sección 21
   │   cap. 06 / 24): en empresa hay clasificación y
   │   dueños — tú ya practicaste la línea base
   │
   ├── artefactos y aserciones de resultados = la
   │   semilla de MLOps del Proyecto 7 (modelos como
   │   artefacto, métricas como contrato)
   │
   └── reproducibilidad es la misma exigencia que
       release en el Proyecto 5: «¿qué tengo y cómo lo
       regenero?»
```

### 7.2. Resumen

En este capítulo aprendiste que:

* la regla de oro decide qué entra: muestra+fuentes+entorno versionados; pesados y sensibles jamás;
* los notebooks se disciplinan (run all limpio, lógica crítica extraída a módulos probados);
* determinismo: semillas, orden y versiones fijas — resultados comparables;
* el CI ejecuta el análisis con aserciones y publica el reporte como artefacto;
* los errores típicos (resultados irreproducibles, extremos de tamaño, datos sensibles en historial, lógica en caja negra, números variables, artefacto local) se previenen con política y pipeline;
* la progresión lleva los artefactos y contratos al Proyecto 7 de inteligencia artificial.

La idea principal es:

> **En un proyecto de datos, Git no guarda los datos: guarda la RECETA — y la receta vale exactamente tanto como la garantía de que otro puede seguirla y obtener lo mismo.**

---

## Próximo paso

Tu análisis se regenera solo y verifica sus resultados.

Ahora el Proyecto 7: inteligencia artificial — modelos, datasets y secretos con criterio.

Continúa con:

[`07-proyecto-7-proyecto-de-inteligencia-artificial.md`](07-proyecto-7-proyecto-de-inteligencia-artificial.md)
