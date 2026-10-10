# Git para ciencia de datos

## Introducción

Un proyecto de datos no es solo código: hay notebooks, datasets, entornos, scripts de proceso y resultados de experimentos. Tratarlo como «cualquier repo de código» produce historiales ilegibles (notebooks con diffs enormes) o, peor, datasets subidos que nadie puede clonar. Este capítulo enseña qué va en Git, qué se gestiona fuera y cómo documentar experimentos para que sean reproducibles.

---

## Mapa conceptual de este capítulo

```text
Git para ciencia de datos
       │
       ├── 1. Estructura: código, notebooks y datos
       │   ├── 2. Notebooks sin caos
       │   ├── 3. Entornos y dependencias
       │   ├── 4. Experimentos: registrar, no improvisar
       │   └── 5. Reproducibilidad del resultado
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Estructura: código, notebooks y datos

```text
proyecto-datos/
├── src/ o scripts/        # código «de verdad»
├── notebooks/             # exploración
├── data/
│   ├── raw/               # generalmente NO versionado
│   └── processed/
├── config/                # parámetros (YAML/JSON)
├── tests/
├── requirements.txt + lock
├── README.md
└── .gitignore
```

```text
PRINCIPIO DE SEPARACIÓN:
   │
   ├── el CÓDIGO y la CONFIGURACIÓN son el proyecto →
   │   en Git
   │
   ├── los DATOS son entrada pesada → referenciados
   │   (descarga, almacén externo, DVC — punto 5)
   │
   └── los RESULTADOS se regeneran → se documenta
       cómo, no se acumulan binarios
```

```text
   │
   └── un lector del repo debe poder entender el
       flujo: data → proceso → resultado, solo
       leyendo la estructura (sección 25)
```

---

## 2. Notebooks sin caos

```text
EL PROBLEMA:
   │
   └── un notebook ejecutado deja salidas (imágenes,
       tablas, outputs) → cada save = diff gigante,
       incomprensible y conflictivo
```

```text
TÁCTICAS:
   │
   ├── limpiar outputs antes de commitear (o
   │   configurar la herramienta para no guardarlos)
   │
   ├── formateo del notebook para diff legible (no
   │   reordenar celdas al guardar sin motivo)
   │
   ├── notebooks = EXPLORACIÓN; el proceso definitivo
   │   se exporta a script (src/) y se versiona
   │   como código normal
   │
   └── convención de nombres:
       notebooks/01-exploracion.ipynb (numerados)
```

```text
REGLA DE EQUIPO:
   │
   ├── el PR revisable vive en scripts/ (diffs
   │   legibles)
   │
   └── los notebooks acompañan como evidencia de
       exploración — si el diff es inmanejable, es
       señal de que toca extraer lógica
```

---

## 3. Entornos y dependencias

```text
LO DE SIEMPRE (sección 21 cap. 01), con énfasis:
   │
   ├── manifest + lock versionados (la receta del
   │   entorno es parte del experimento)
   │
   ├── versión de Python declarada
   │
   └── librerías pesadas (torch, etc.): el manifest
       declara; la descarga vive en install/CI (no en
       el repo)
```

```text
DATOS DE ENTRADA TAMBIÉN SON DEPENDENCIA:
   │
   ├── versionar DESCRIPCIÓN del dataset: origen,
   │   fecha de descarga, checksum/digest si aplica
   │
   └── así «misma receta + mismo dato → mismo
       resultado» es comprobable (punto 5)
```

---

## 4. Experimentos: registrar, no improvisar

```text
QUÉ REGISTRAR POR EXPERIMIENTO (mínimo):
   │
   ├── qué ejecutaste (script/commit)
   ├── con qué parámetros (config/semilla)
   ├── con qué datos (versión/fecha)
   ├── qué métrica resultó
   └── dónde quedó el resultado (artefacto/almacén)
```

```text
FORMAS SIMPLES DE EMPEZAR:
   │
   ├── fichero de experimentos (CSV/Markdown) en el
   │   repo
   │
   ├── config por corrida (YAML con nombre único)
   │
   └── herramientas de tracking (MLflow y similares —
       mención de categoría): registro automático, útil
       cuando hay decenas de corridas
```

```text
   │
   └── el commit que cambia parámetros o métrica debe
       decirlo (sección 14 — mensajes honestos)
```

---

## 5. Reproducibilidad del resultado

```text
CADENA DE REPRODUCCIÓN:
──────────────────────────────────────────────────────
commit del código
+ manifest/lock del entorno
+ referencia al dataset (origen+versión)
+ parámetros (config/semilla)
    → resultado regenerable (o explicado)
```

```text
GESTIÓN PESADA (opciones — sin dogmas):
   │
   ├── datos en almacén (bucket/registry) con
   │   referencia desde el repo (URL+checksum)
   │
   ├── versionado de datos tipo DVC (mención: misma
   │   filosofía de Git para archivos grandes)
   │
   ├── artefactos en el almacén de artefactos/
   │   releases (sección 18 cap. 04)
   │
   └── Git LFS si el archivo es estable y pequeño
       (sección 21 cap. 05)
```

```text
   │
   └── sin esta cadena, el proyecto es un recuerdo
       personal; con ella, cualquiera lo repite
       (Error 6)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: dataset completo subido al repo

**Qué ocurrió:** gigabytes en `data/raw/`; nadie puede clonar en menos de media hora.

**Por qué:** se añadió el csv «para tenerlo a mano».

**Cómo comprobarlo:** tamaño del repo; `git ls-files data/`.

**Opciones:** sacarlo del índice, ignorarlo, referencia (URL+checksum); si el historial pesa, purga consciente (sección 13 cap. 02).

**Riesgos:** clon imposible, límites de plataforma.

**Solución:** datos referenciados (punto 1/5).

**Cómo se evita:** plantilla y checklist (Error 2).

---

### Error 2: .gitignore sin cubrir datos ni salidas

**Qué ocurrió:** cada corrida generaba `data/processed/` con archivos nuevos → commits inmensos.

**Por qué:** el guion no contemplaba el flujo de datos.

**Cómo comprobarlo:** `git ls-files data/ processed/ outputs/`.

**Opciones:** ignorar salidas regenerables; versionar solo lo mínimo acordado.

**Riesgos:** historial inservible.

**Solución:** frontera código/datos (punto 1).

**Cómo se evita:** revisar .gitignore al añadir etapa del proceso.

---

### Error 3: notebook con outputs gigantes en cada commit

**Qué ocurrió:** diffs de 2000 líneas con imágenes embebidas; los PRs eran inrevisables.

**Por qué:** outputs versionados por defecto.

**Cómo comprobarlo:** tamaño de los diffs del notebook en un PR.

**Opciones:** limpiar outputs (herramienta/config); extraer lógica a scripts (punto 2).

**Riesgos:** revisión imposible (sección 15 se muere).

**Solución:** exploración aparte, proceso como código (punto 2).

**Cómo se evita:** convención de equipo escrita.

---

### Error 4: entorno no declarado («funcionaba en mi kernel»)

**Qué ocurrió:** el notebook corría en Jupyter con paquetes instalados a mano durante semanas; nadie más podía ejecutarlo.

**Por qué:** sin manifest/lock del entorno (punto 3).

**Cómo comprobarlo:** ¿hay manifest? ¿el README explica el install?

**Opciones:** exportar dependencias del entorno al manifest; limpiar paquetes olvidados; versionar.

**Riesgos:** experimento irreproducible.

**Solución:** receta del entorno versionada (punto 3).

**Cómo se evita:** checklist de plantilla.

---

### Error 5: semilla y parámetros en el aire

**Qué ocurrió:** se relanzó el experimento «igual» y el resultado cambió — sin registro de semillas ni versión de datos.

**Por qué:** nada se registraba (punto 4).

**Cómo comprobarlo:** ¿existe registro de corridas? ¿config con semilla?

**Opciones:** añadir registro mínimo + semillas explícitas + referencia de dataset.

**Riesgos:** ciencia no verificable; producción sin bisagra.

**Solución:** experimento documentado (punto 4).

**Cómo se evita:** plantilla de experimento en la estructura.

---

### Error 6: resultados solo en la laptop

**Qué ocurrió:** el mejor modelo vivía en un disco local; la máquina se perdió.

**Por qué:** ni release, ni alacén, ni referencia en el repo.

**Cómo comprobarlo:** ¿dónde está el artefacto de la última versión buena?

**Opciones:** publicar artefactos a almacén/release con metadatos (commit+config+datos); documentar ubicación.

**Riesgos:** pérdida total de trabajo.

**Solución:** cadena de reproducibilidad completa (punto 5).

**Cómo se evita:** parte del proceso de cierre de experimento.

---

## 7. Práctica guiada

### Objetivo

Dejar un proyecto de datos con código, notebooks y datos bien separados.

### Paso 1: estructura

```text
Crea: src/ · notebooks/ · data/raw · data/processed ·
config/ · tests/ + manifest/lock + README
```

### Paso 2: .gitignore de datos

```gitignore
data/raw/
data/processed/
outputs/
*.pkl
*.h5
# (ajusta a tu caso; versiona solo lo pequeño acordado)
```

1. Añade `data/raw/README.md` explicando origen, fecha y checksum de lo descargable.

### Paso 3: notebooks

1. Limpia los outputs del notebook principal antes del commit.
2. Extrae al menos una celda de lógica a `src/` y llámala desde el notebook.

### Paso 4: experimento

```text
config/experimento-001.yaml:
   │
   ├── semilla
   ├── parámetros
   └── dataset: nombre, versión, checksum

results.csv (en repo): experimento · commit · métrica
```

### Paso 5: reproducibilidad

```text
En el README, la receta:
   │
   ├── instalar (manifest/lock)
   ├── obtener datos (URL + checksum)
   └── ejecutar (script con config)
```

1. Prueba la receta en un entorno limpio (o en CI).

### Paso 6: CI ligero

1. CI que solo valida: lint + un test pequeño + «el script principal corre con datos de ejemplo» (fixtures mini).

### Resultado esperado

Separación código/datos/resultados, notebook limpio, experimento registrado y receta verificable.

### Conclusión esperada

En datos, Git guarda la intención y la receta; los gigabytes viven referenciados — el proyecto deja de depender de la laptop donde nació.

---

## 8. Nivel profesional + resumen
### Ejercicio de transferencia
Aplica lo aprendido en este capítulo a un proyecto personal de tu elección. Por ejemplo, si el capítulo trata sobre ramas en Git, crea una nueva rama para una característica que hayas estado pensando y haz un commit inicial. Entregable: captura de pantalla del comando git branch mostrando tu nueva rama.
## 8. Nivel profesional + resumen

### 8.1. Data a escala

```text
   │
   ├── gobierno de datos: catálogo + permisos +
   │   versionado de datasets (quién publica, quién
   │   consume — sección 16/25)
   │
   ├── pipelines de datos como código (sección 23):
   │   proceso versionado y ejecutado en CI/CD
   │
   ├── artefactos de modelos en almacén con
   │   metadatos (cap. 04 de esta sección)
   │
   ├── DVC/registries cuando el volumen lo exija
   │
   ├── notebooks en revisión (outputs acotados);
   │   procesos en scripts revisados
   │
   └── métrica: % de experimentos reproducibles con
       la receta del README (auditoría interna)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* separar código, notebooks, datos y resultados es la decisión que gobierna todo lo demás;
* notebooks legibles: outputs acotados, exploración separada del proceso revisable;
* entorno y dataset como parte de la receta (manifest, referencia con checksum);
* experimentos registrados: script, parámetros, datos, métrica, artefacto;
* los errores típicos (dataset subido, .gitignore incompleto, outputs gigantes, entorno en el aire, sin semillas, resultados locales) se previenen con fronteras y plantilla;
* a nivel profesional: gobierno de datos y pipelines versionados.

La idea principal es:

> **Un proyecto de datos es reproducible o es anecdótico: en Git vive la receta — código, entorno, parámetros y referencia al dato — no el dato mismo.**

---

## Próximo paso
## Autopreguntas de cierre
1. ¿Cómo explicarías con tus propias palabras el concepto de Introducción?
1. ¿Cuál es la relación entre Mapa conceptual de este capítulo y 1. Estructura: código, notebooks y datos?
1. ¿Qué pasos seguirías para aplicar 1. Estructura: código, notebooks y datos en un escenario real?
1. ¿Qué errores comunes debes evitar al trabajar con 2. Notebooks sin caos?
1. ¿Cómo medirías el éxito al implementar 3. Entornos y dependencias?
1. ¿Qué herramientas o comandos mencionados en el capítulo son esenciales para 4. Experimentos: registrar, no improvisar?
1. ¿Cómo adaptarías el proceso descrito en 5. Reproducibilidad del resultado si tuvieran que trabajar en un entorno distribuido?
1. ¿Qué principio subyace detrás de la recomendación de 6. Errores comunes con diagnóstico completo?
## Próximo paso

Ya sabes versionar datos y experimentos.

Ahora el siguiente salto: cuando el proyecto produce modelos y pipelines de inteligencia artificial.

Continúa con:

[`04-git-para-inteligencia-artificial.md`](04-git-para-inteligencia-artificial.md)
