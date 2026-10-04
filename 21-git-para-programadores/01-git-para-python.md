# Git para Python

## Introducción

Python es el lenguaje con el que mucha gente da sus primeros pasos de programación — y con el que aparecen los primeros problemas de organización en Git: `__pycache__`, `.env`, entornos virtuales gigantes y un `requirements.txt` que nadie actualiza. Este capítulo adapta todo lo aprendido a un proyecto Python real: estructura recomendada, dependencias con lockfiles, tests versionados y la configuración de `.gitignore` que evita el caos.

---

## Mapa conceptual de este capítulo

```text
Git para Python
       │
       ├── 1. Estructura de un proyecto
       │   ├── 2. Dependencias: lo que sí se versiona
       │   ├── 3. Tests y calidad en el historial
       │   ├── 4. .gitignore del Pythonista
       │   └── 5. Entornos virtuales fuera del repo
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Estructura de un proyecto

```text
proyecto-python/
├── src/
│   └── mi_paquete/
│       ├── __init__.py
│       └── ...
├── tests/
│   └── test_...
├── requirements.txt          # o pyproject.toml
├── .gitignore
├── README.md
└── LICENSE
```

```text
DECISIONES QUE GIT DEBE REFLEJAR:
   │
   ├── `src/` layout: el código del paquete separado
   │   de la raíz → imports limpios y menos confusiones
   │
   ├── `tests/` en el repo: los tests SON el proyecto
   │   (sección 09)
   │
   └── raíz mínima: config, docs y nada temporal
```

```text
   │
   └── el repo cuenta la historia: quien vea la
       estructura entiende qué es código, qué es test
       y qué es configuración (sección 18 cap. 01)
```

---

## 2. Dependencias: lo que sí se versiona

```text
DOS NIVELES:
   │
   ├── declarar: qué paquetes necesitas y con qué
   │   rango (pyproject.toml / requirements.txt)
   │
   └── fijar: qué versión exacta instalaste (lockfile)
```

```text
REALIDAD DEL ECOSISTEMA:
   │
   ├── pyproject.toml: manifest moderno (metadatos +
   │   dependencias)
   │
   ├── lock: herramientas como poetry/uv/pipenv
   │   generan su lock (p. ej. poetry.lock) — VERSIONA
   │   el lock igual que npm versiona package-lock
   │   (sección 20 cap. 03)
   │
   └── sin lock: «en mi máquina funciona» — Error 2
```

```text
SEPARACIÓN:
   │
   ├── runtime: dependencias de tu librería/app
   ├── dev: pytest, linters → grupo/requirements
   │   aparte
   └── cada una renovable por Dependabot (sección 20
       cap. 03)
```

```bash
# revisión rápida:
git ls-files | grep -E "(requirements|lock|pyproject)"
```

---

## 3. Tests y calidad en el historial

```text
LO QUE SE VERSIONA:
   │
   ├── tests/ completos
   ├── configuración de pytest (pytest.ini /
   │   pyproject)
   └── linters/formatters (ruff, black — config en el
       repo, sección 06)
```

```text
CI CONECTADO (sección 19/22):
   │
   ├── en PR: install (con cache del lock) → lint →
   │   pytest
   │
   └── el check verde es la puerta a main (sección 15)
```

```text
   │
   └── regla: si añades funcionalidad sin test, el
       commit lo refleja — el historial es evidencia de
       disciplina (sección 14 cap. 03)
```

```yaml
# esquema de CI python (ilustrativo):
# - uses: actions/setup-python@v4 (o versión actual)
#   with: { python-version: '3.x', cache: 'pip' }
# - run: pip install -r requirements-dev.txt
# - run: ruff check . && pytest
```

---

## 4. .gitignore del Pythonista

```gitignore
# entornos y caché (nunca subir):
__pycache__/
*.pyc
.venv/
venv/

# secretos y local:
.env

# empaquetado/publicación:
dist/
build/
*.egg-info/

# cobertura/otros:
.coverage
.pytest_cache/
```

```text
   │
   ├── el guion por defecto de la plataforma ya trae
   │   la plantilla de Python — úsala como base
   │
   └── si algo entró por error: cap. 04 de la
       sección 13 (archivos ya rastreados)
```

---

## 5. Entornos virtuales fuera del repo

```text
EL ENTORNO:
   │
   ├── carpeta local (.venv) con paquetes instalados
   │
   └── la especificación vive en el repo (manifest +
       lock); la instalación vive en TU máquina
```

```text
   │
   └── así se explica la jerarquía: repo = contrato;
       .venv = ejecución local (Error 1 si se sube)
```

```text
REGLAS:
   │
   ├── .venv SIEMPRE en .gitignore (viene con la
   │   plantilla)
   │
   ├── instalar desde el lock en cada máquina/CI
   │   (`pip install -r` / `uv sync` / poetry)
   │
   └── versiones de Python: declaradas (pyproject/.python-version)
       → todos prueban lo mismo (Error 3)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: entorno virtual subido al repo

**Qué ocurrió:** miles de archivos de `.venv/` en el historial; clones lentísimos.

**Por qué:** se creó el venv antes que el .gitignore (o dentro del repo sin ignorarlo).

**Cómo comprobarlo:** `git ls-files | grep venv`; tamaño del repo.

**Opciones:** quitar del índice (`git rm -r --cached`) + commit; si el historial queda pesado, purgar (sección 13 cap. 02 — decisión consciente por reescritura).

**Riesgos:** ruido en cada diff y en auditorías.

**Solución:** manifest + lock, entorno local (punto 5).

**Cómo se evita:** plantilla .gitignore desde el init (sección 02).

---

### Error 2: sin lockfile («en mi máquina funciona»)

**Qué ocurrió:** CI instaló versiones nuevas y los tests fallaron sin que nadie tocase código.

**Por qué:** solo ranges en requirements, sin fijado.

**Cómo comprobarlo:** ¿hay lock versionado? ¿el CI instala desde él?

**Opciones:** añadir lock (herramienta de gestión); regenerar y versionar; renovar con Dependabot.

**Riesgos:** CI no reproducible.

**Solución:** declarar + fijar (punto 2).

**Cómo se evita:** checklist de init (sección 02).

---

### Error 3: .env y claves en el repo

**Qué ocurrió:** un archivo `.env` con credenciales entró al historial.

**Por qué:** secretos copiados «para que corra» + sin reglas de secretos.

**Cómo comprobarlo:** secret scanning (sección 20 cap. 02) + `git log` del archivo.

**Opciones:** respuesta de incidente: rotar → limpiar → verificar (sección 20 cap. 01 punto 5).

**Riesgos:** exposición permanente.

**Solución:** `.env` ignorado + `.env.example` con placeholders.

**Cómo se evita:** push protection + formación (sección 20).

---

### Error 4: entorno de Python no declarado

**Qué ocurrió:** equipo con Python 3.9, 3.10 y 3.12; el comportamiento variaba (y un paquete exigía 3.11+).

**Por qué:** no se declaró la versión requerida.

**Cómo comprobarlo:** ¿pyproject `requires-python`? ¿versión fija en CI?

**Opciones:** declarar rango y fijar en CI; avisar al equipo.

**Riesgos:** bugs fantasma por versión.

**Solución:** contrato de versión (punto 5).

**Cómo se evita:** plantilla de repo (sección 18).

---

### Error 5: archivos locales de IDE/Python en commits

**Qué ocurrito:** `.idea/`, `.vscode/` con ajustes personales (o sin ajustes) en cada commit.

**Por qué:** .gitignore incompleto.

**Cómo comprobarlo:** `git ls-files | grep -E "(idea|vscode)"`.

**Opciones:** añadir a .gitignore + `git rm --cached`; si el equipo quiere compartir settings de editor, solo lo acordado (commit explícito y mínimo).

**Riesgos:** diffs ensuciados en cada PR.

**Solución:** guion completo (punto 4).

**Cómo se evita:** plantilla revisada por el equipo.

---

### Error 6: scripts de build publicados como código «temporal»

**Qué ocurrió:** `dist/` o `build/` versionados; los diffs mostraban binarios.

**Por qué:** se ejecutó build dentro del repo sin ignorar la salida.

**Cómo comprobarlo:** `git ls-files | grep -E "(dist|build)"`.

**Opciones:** quitar del índice; ignorar; si hay que publicar artefactos → CI/registries (sección 18 cap. 04).

**Riesgos:** repos inmanejables.

**Solución:** salida de build nunca en git (punto 4).

**Cómo se evita:** plantilla + revisión de PRs.

---

## 7. Práctica guiada

### Objetivo

Montar un repositorio Python con todas las piezas versionadas y nada de ruido.

### Paso 1: estructura

```text
proyecto-python/
├── src/mi_paquete/
├── tests/
├── pyproject.toml (o requirements.txt + lock)
├── .gitignore (plantilla Python)
├── README.md
└── LICENSE
```

### Paso 2: dependencias

1. Declara tus dependencias (manifest) y genera el lock con tu herramienta.
2. Versiona manifest + lock; verifica que `git status` no muestra .venv.

### Paso 3: entorno local

```bash
python -m venv .venv
# activa e instala desde el lock
python -m pytest
```

1. Confirma que `.venv/` está ignorado (`git status` limpio).

### Paso 4: CI mínimo

```yaml
# esquema: setup-python con cache → install lock → lint → pytest
```

1. Abre un PR con un test pequeño y observa el check verde.

### Paso 5: revisión de ruido

```bash
git ls-files | grep -E "(__pycache__|\.venv|\.env$|dist/|build/)" | head
```

1. Si aparece algo: `git rm -r --cached <ruta>` + corregir .gitignore + commit.

### Paso 6: README

```text
Sección mínima:
   │
   ├── cómo instalar (entorno + lock)
   ├── cómo ejecutar tests
   └── requisitos (versión de Python)
```

### Resultado esperado

Repo Python limpio: estructura clara, lock versionado, entorno local ignorado y CI en PR.

### Conclusión esperada

En Python, lo que se versiona es la especificación y los tests; lo que se ignora es la ejecución local — la frontera marcada evita la mitad de los incidentes de repositorio.

---

## 8. Nivel profesional + resumen

### 8.1. Python a escala

```text
   │
   ├── monorepo con varias libs → versionado conjunto
   │   y paths de CI (sección 25)
   │
   ├── publicación: builds y uploads SOLO desde CI con
   │   secretos por environment (sección 19/20)
   │
   ├── dependencias: lock + Dependabot + SLA de alertas
   │   (sección 20)
   │
   ├── calidad: lint/format/type-check como checks
   │   obligatorios (sección 06/15)
   │
   └── métrica: cobertura de tests y tiempo de CI
       (sección 26)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* estructura `src/` + `tests/` reflejada en Git;
* dependencias: manifest declaran, lock fijan — ambos versionados y renovables;
* .gitignore de Python completo (cache, venv, dist, .env);
* el entorno es local; el contrato está en el repo;
* los errores típicos (venv subido, sin lock, .env, versión no declarada, IDEs, dist/) se previenen con plantilla y revisión;
* a nivel profesional: publicación desde CI y métricas de calidad.

La idea principal es:

> **Un buen repo de Python versiona la intención — manifest, lock y tests — y deja fuera la maquinaria local: lo que se instala en tu máquina no es historia del proyecto.**

---

## Próximo paso

Ya tienes el patrón para Python.

Ahora lo mismo con el mundo JavaScript.

Continúa con:

[`02-git-para-javascript.md`](02-git-para-javascript.md)
