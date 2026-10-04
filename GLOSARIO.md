# Glosario de Git y GitHub

## GitHub Paso a Paso

Este glosario reúne los conceptos y términos más importantes utilizados en este repositorio.

Está diseñado para acompañar al estudiante desde sus primeros pasos con Git y GitHub hasta conceptos utilizados en entornos profesionales de desarrollo de software, automatización, CI/CD, DevOps y DevSecOps.

No es necesario memorizar estas definiciones.

Cada entrada sigue el mismo orden:

* **definición**: qué es, en una o dos oraciones;
* **ejemplo**: comando, salida o diagrama que lo fija;
* **notas** (cuando las hay): matices, nombres alternos o avisos.

Además, las entradas de los términos nucleares del curso (commit, HEAD, ramas, merge, pull/push/fetch, pull request, reset, stash, tag, release...) incluyen un bloque **Relacionados** con enlaces a las entradas que complementan cada término.

Si vas a añadir términos nuevos, consulta [`CONTRIBUTING.md`](CONTRIBUTING.md) y respeta este orden: definición primero, ejemplo después y relacionados al final.


La finalidad es que puedas volver aquí cada vez que encuentres un término que no conozcas.

---

# 1. Conceptos básicos de computación

## Archivo

Un archivo es una unidad de información almacenada en un dispositivo.

Ejemplos:

```text
programa.py
README.md
datos.csv
imagen.png
config.json
```

### Ejemplo sencillo

Un documento de Word, una fotografía o un programa de Python son archivos.

En Git, los archivos son los elementos cuyo estado puede ser registrado y versionado.

---

## Carpeta

Una carpeta es un contenedor utilizado para organizar archivos y otras carpetas.

Ejemplo:

```text
mi-proyecto/
├── README.md
├── programa.py
└── datos/
    └── datos.csv
```

---

## Ruta

Una ruta indica dónde se encuentra un archivo o carpeta.

Ejemplo:

```text
C:\Usuarios\Jorge\proyectos\mi-proyecto
```

En Linux o macOS:

```text
/home/jorge/proyectos/mi-proyecto
```

---

## Extensión

La extensión normalmente aparece al final del nombre de un archivo y suele indicar su tipo.

Ejemplos:

```text
.py
.md
.txt
.json
.csv
.html
.css
.js
```

---

## Terminal

La terminal es una interfaz que permite interactuar con el sistema operativo mediante comandos escritos.

Ejemplo:

```bash
git status
```

La terminal no es Git.

Git es una herramienta que puede utilizarse desde la terminal.

---

## Línea de comandos

Es una interfaz en la que el usuario escribe instrucciones para ejecutar programas y operaciones.

En Windows puede utilizarse:

* PowerShell
* Windows Terminal
* Símbolo del sistema

En Linux y macOS se utilizan diferentes shells y terminales.

---

# 2. Git y control de versiones

## Git

Git es un sistema de control de versiones distribuido.

Permite registrar cambios realizados en archivos a lo largo del tiempo.

Con Git puedes:

* guardar versiones;
* comparar cambios;
* crear ramas;
* recuperar versiones anteriores;
* trabajar en equipo;
* combinar cambios;
* investigar cuándo se modificó algo;
* mantener un historial del proyecto.

Git puede funcionar sin conexión a Internet.

---

## Control de versiones

Es un sistema que permite registrar y administrar diferentes versiones de un conjunto de archivos.

Ejemplo:

```text
Proyecto v1
    ↓
Proyecto v2
    ↓
Proyecto v3
    ↓
Proyecto v4
```

Git permite mantener ese historial de forma estructurada.

---

## Repositorio

Un repositorio es el espacio donde Git almacena y administra el historial de un proyecto.

Puede existir como:

* repositorio local;
* repositorio remoto.

Ejemplo:

```text
mi-proyecto/
```

puede ser un repositorio Git si contiene su estructura `.git`.

---

## Repositorio local

Es el repositorio Git almacenado en tu computadora.

Ejemplo:

```text
C:\proyectos\mi-proyecto
```

Aquí puedes crear commits, ramas y consultar el historial sin necesidad de conectarte a Internet.

---

## Repositorio remoto

Es una copia del repositorio almacenada en otro sistema.

GitHub es uno de los servicios que puede alojar repositorios Git.

Ejemplo conceptual:

```text
Computadora
    │
    │ push
    ▼
GitHub
```

---

## `.git`

`.git` es la carpeta interna que Git utiliza para almacenar información del repositorio.

Contiene, entre otras cosas:

* historial;
* referencias;
* objetos;
* configuración;
* información de ramas.

No debes modificar manualmente su contenido salvo que sepas exactamente lo que estás haciendo.

---

## Working Directory / Working Tree

Es el estado de los archivos con los que estás trabajando actualmente.

Ejemplo:

```text
README.md
programa.py
datos.csv
```

Si modificas `programa.py`, ese cambio aparece inicialmente en tu directorio de trabajo.

### Relacionados

* [Staging Area](#staging-area)
* [Commit](#commit)
* [Diff](#diff)


---

## Staging Area

Es el área intermedia donde seleccionas los cambios que quieres incluir en el próximo commit.

Ejemplo:

```bash
git add programa.py
```

Conceptualmente:

```text
Archivo modificado
       ↓
Staging Area
       ↓
Commit
```

La staging area también recibe el nombre de **índice** en la terminología interna de Git.

### Relacionados

* [Working Directory / Working Tree](#working-directory-working-tree)
* [Commit](#commit)


---

## Commit

Un commit es un registro permanente de un conjunto de cambios dentro del historial de Git.

Ejemplo:

```bash
git commit -m "Agregar validación de usuarios"
```

Un commit normalmente contiene información como:

* cambios realizados;
* autor;
* fecha;
* mensaje;
* referencia a otros objetos del historial.

### Relacionados

* [Mensaje de commit](#mensaje-de-commit)
* [Hash](#hash)
* [HEAD](#head)
* [Historial](#historial)


---

## Mensaje de commit

Es el texto que describe qué cambio se registró.

Ejemplo:

```text
Agregar validación del formulario de registro
```

Un buen mensaje ayuda a comprender el historial del proyecto.

---

## Hash

Un hash es una representación hexadecimal generada a partir de información.

Git utiliza identificadores basados en funciones hash para identificar objetos.

Ejemplo:

```text
a81bc3f...
```

En Git moderno pueden encontrarse repositorios configurados para utilizar SHA-1 o SHA-256, según su configuración y formato.

---

## HEAD

`HEAD` es una referencia especial de Git que indica la posición actual desde la que estás trabajando.

En términos sencillos:

> `HEAD` representa dónde estás situado dentro del historial de Git.

Ejemplo:

```text
A ← B ← C ← HEAD
```

Si cambias de rama, `HEAD` normalmente pasa a apuntar a la rama correspondiente.

### Relacionados

* [Historial](#historial)
* [Branch / Rama](#branch-rama)


---

## Historial

Es el conjunto de commits registrados en un repositorio.

Puedes consultarlo con:

```bash
git log
```

---

## Diff

Un diff muestra las diferencias entre versiones o estados de archivos.

Ejemplo:

```bash
git diff
```

Permite observar qué líneas fueron agregadas, modificadas o eliminadas.

---

# 3. GitHub

## GitHub

GitHub es una plataforma que permite alojar repositorios Git y proporciona herramientas para colaborar y desarrollar software.

Git y GitHub no son lo mismo.

```text
Git
↓
Sistema de control de versiones

GitHub
↓
Plataforma que utiliza Git
+ colaboración
+ revisión
+ automatización
+ seguridad
+ gestión de proyectos
```

---

## GitHub Repository

Es un repositorio Git alojado en GitHub.

Puede contener:

* código;
* documentación;
* archivos;
* historial;
* issues;
* pull requests;
* configuraciones;
* automatizaciones.

---

## Perfil de GitHub

Es el espacio asociado a una cuenta de GitHub donde pueden aparecer:

* repositorios;
* contribuciones;
* proyectos;
* información profesional.

Puede formar parte de un portafolio técnico.

---

## Organización

Una organización de GitHub permite agrupar repositorios y administrar recursos para un equipo, empresa o comunidad.

Ejemplo conceptual:

```text
Empresa
└── Organización GitHub
    ├── proyecto-web
    ├── API
    └── infraestructura
```

---

## Colaborador

Un colaborador es una persona que tiene permisos para trabajar en un repositorio.

Sus permisos dependen de la configuración del repositorio u organización.

---

## Fork

Un fork es una copia de un repositorio dentro de otra cuenta o espacio de GitHub.

Es especialmente utilizado para contribuir a proyectos en los que no tienes permisos directos de escritura.

Flujo típico:

```text
Repositorio original
        ↓
      Fork
        ↓
Tus cambios
        ↓
Pull Request
```

### Relacionados

* [Clone](#clone)
* [Pull Request](#pull-request)


---

## Clone

Clonar un repositorio significa crear una copia local de un repositorio Git.

Ejemplo:

```bash
git clone https://github.com/usuario/proyecto.git
```

Después del clon:

```text
GitHub
   │
   │ clone
   ▼
Computadora
```

### Relacionados

* [Fork](#fork)
* [Remote](#remote)


---

# 4. Ramas

## Branch / Rama

Una rama es una referencia que permite desarrollar una línea de trabajo independiente dentro del historial.

Ejemplo:

```text
main
 │
 ├── feature-login
 │
 └── feature-reportes
```

Las ramas permiten trabajar en diferentes cambios sin modificar directamente la línea principal.

---

## `main`

`main` es el nombre utilizado habitualmente para la rama principal de un repositorio.

Históricamente también se utilizó mucho el nombre `master`.

El nombre de la rama principal es configurable.

---

## Feature branch

Una feature branch es una rama creada para desarrollar una funcionalidad concreta.

Ejemplo:

```bash
git switch -c feature-login
```

---

## Merge

`merge` combina historias de diferentes ramas.

Ejemplo:

```text
main
  \
   feature
```

Después del merge:

```text
main ────────●
             \
feature ─────●
              \
               ●
```

Dependiendo de la situación, Git puede realizar un **fast-forward** o crear un **merge commit**.

### Relacionados

* [Rebase](#rebase)
* [Fast-forward](#fast-forward)
* [Branch / Rama](#branch-rama)


---

## Rebase

`rebase` permite trasladar una serie de commits para que partan desde otra base.

Ejemplo conceptual:

```text
Antes:

A──B──C
    \
     D──E
```

Después de un rebase:

```text
A──B──C──D'──E'
```

Los commits trasladados reciben nuevos identificadores porque su historial cambia.

### Relacionados

* [Merge](#merge)
* [Fast-forward](#fast-forward)


---

## Fast-forward

Un fast-forward ocurre cuando Git puede mover una referencia hacia adelante sin crear un nuevo commit de merge.

Ejemplo:

```text
A──B──C
       ↑
      main
```

Si `main` todavía estaba en `B`, puede avanzar directamente hacia `C`.

---

## Branch tracking

Una rama local puede estar asociada con una rama remota.

Esto permite que Git sepa qué rama remota utilizar como referencia para operaciones como `pull` y `push`.

---

# 5. Repositorios remotos

## Remote

Un remote es una referencia a otro repositorio Git.

Ejemplo:

```bash
git remote -v
```

---

## `origin`

`origin` es el nombre que Git asigna habitualmente al repositorio remoto desde el que se clonó un repositorio.

No es una palabra reservada.

Puede cambiarse.

---

## `upstream`

`upstream` suele utilizarse para identificar el repositorio original del que deriva un fork.

Ejemplo:

```text
upstream
   ↓
Repositorio original

origin
   ↓
Tu fork
```

---

## Push

`push` envía commits desde el repositorio local hacia un repositorio remoto.

Ejemplo:

```bash
git push
```

Conceptualmente:

```text
Local
  │
  │ push
  ▼
Remote
```

### Relacionados

* [Pull](#pull)
* [Fetch](#fetch)
* [Remote](#remote)


---

## Pull

`pull` obtiene cambios del repositorio remoto y los integra en la rama local.

Conceptualmente:

```text
Remote
  │
  │ pull
  ▼
Local
```

En términos generales, `git pull` combina operaciones equivalentes a obtener cambios y posteriormente integrarlos, aunque el comportamiento exacto depende de la configuración.

### Relacionados

* [Fetch](#fetch)
* [Push](#push)


---

## Fetch

`fetch` obtiene información y cambios del repositorio remoto sin integrar automáticamente esos cambios en tu rama de trabajo.

Ejemplo:

```bash
git fetch
```

Esto permite revisar primero qué ocurrió en el remoto.

### Relacionados

* [Pull](#pull)
* [Push](#push)


---

# 6. Pull Requests y colaboración

## Pull Request

Un Pull Request, o PR, es una solicitud para incorporar cambios de una rama a otra en plataformas como GitHub.

Ejemplo:

```text
feature-login
      │
      │ Pull Request
      ▼
    main
```

Un PR puede incluir:

* descripción;
* cambios;
* revisiones;
* comentarios;
* pruebas;
* verificaciones automáticas.

### Relacionados

* [Code Review](#code-review)
* [Fork](#fork)
* [Branch / Rama](#branch-rama)


---

## Code Review

Code review es el proceso de revisar cambios realizados por otros desarrolladores antes de integrarlos.

Puede buscar:

* errores;
* problemas de diseño;
* vulnerabilidades;
* problemas de rendimiento;
* falta de pruebas;
* problemas de mantenimiento.

---

## Reviewer

Es una persona encargada de revisar un Pull Request.

---

## Approve

Una aprobación indica que un revisor considera que los cambios cumplen los criterios establecidos para esa revisión.

Las reglas exactas dependen de la configuración del repositorio.

---

## Issue

Un Issue es un elemento utilizado para registrar y gestionar temas de trabajo.

Puede representar:

* un error;
* una tarea;
* una mejora;
* una pregunta;
* una propuesta.

---

## Label

Una etiqueta permite clasificar issues y otros elementos.

Ejemplos:

```text
bug
documentation
enhancement
security
help wanted
```

---

## Milestone

Un milestone agrupa trabajo relacionado con un objetivo o versión.

Ejemplo:

```text
Milestone: Versión 2.0
├── Issue 1
├── Issue 2
└── Issue 3
```

---

## GitHub Projects

GitHub Projects proporciona herramientas para organizar y visualizar trabajo.

Puede utilizarse para gestionar tareas mediante vistas como:

* tabla;
* tablero;
* roadmap.

---

## CODEOWNERS

`CODEOWNERS` permite definir responsables de determinadas partes del repositorio.

Ejemplo conceptual:

```text
/docs/       @equipo-documentacion
/security/   @equipo-seguridad
```

Puede utilizarse para solicitar revisiones automáticamente según los archivos modificados.

---

# 7. Deshacer y recuperar cambios

## `git restore`

Permite restaurar archivos desde otro estado administrado por Git.

Ejemplo:

```bash
git restore archivo.py
```

Debe utilizarse con cuidado porque puede descartar cambios locales.

---

## `git revert`

Crea un nuevo commit que invierte los cambios introducidos por otro commit.

Ejemplo:

```bash
git revert <commit>
```

Es especialmente útil cuando un commit ya fue compartido con otras personas.

---

## `git reset`

Mueve referencias y puede modificar el estado del índice y del directorio de trabajo.

Sus modos principales incluyen:

```bash
git reset --soft
git reset --mixed
git reset --hard
```

`--hard` debe utilizarse con especial cuidado porque puede descartar cambios locales.

### Relacionados

* [git revert](#git-revert)
* [git restore](#git-restore)
* [Reflog](#reflog)


---

## `git stash`

Permite guardar temporalmente cambios que todavía no quieres convertir en commit.

Ejemplo:

```bash
git stash
```

Después puedes recuperarlos.

```bash
git stash pop
```

### Relacionados

* [Reflog](#reflog)
* [git restore](#git-restore)


---

## Reflog

El reflog registra movimientos de referencias locales de Git.

Puede ayudar a recuperar commits que aparentemente desaparecieron después de operaciones como:

* reset;
* rebase;
* cambio de rama.

Ejemplo:

```bash
git reflog
```

---

## Cherry-pick

Permite aplicar un commit específico de una rama sobre otra.

Ejemplo:

```bash
git cherry-pick <commit>
```

Es útil cuando necesitas un cambio concreto sin incorporar necesariamente toda la rama.

---

## Bisect

`git bisect` utiliza búsqueda binaria para localizar el commit que introdujo un problema.

Conceptualmente:

```text
100 commits
     ↓
50
     ↓
25
     ↓
12
     ↓
...
     ↓
commit problemático
```

Es una herramienta especialmente útil para depuración.

---

## Blame

`git blame` muestra qué commit modificó determinadas líneas de un archivo.

Ejemplo:

```bash
git blame archivo.py
```

No significa que Git esté culpando moralmente a una persona.

Sirve para investigar el historial de una línea.

---

# 8. Etiquetas y versiones

## Tag

Un tag es una referencia que permite marcar un punto concreto del historial.

Ejemplo:

```text
v1.0.0
v1.1.0
v2.0.0
```

### Relacionados

* [Release](#release)
* [Semantic Versioning](#semantic-versioning)


---

## Release

Una release representa una versión publicada de un proyecto en GitHub.

Puede incluir:

* versión;
* notas;
* archivos;
* changelog;
* información para usuarios.

### Relacionados

* [Tag](#tag)
* [Semantic Versioning](#semantic-versioning)


---

## Semantic Versioning

Semantic Versioning, o SemVer, es un esquema de versionado basado normalmente en:

```text
MAJOR.MINOR.PATCH
```

Ejemplo:

```text
2.4.1
```

De forma general:

* **MAJOR**: cambios incompatibles;
* **MINOR**: nuevas funcionalidades compatibles;
* **PATCH**: correcciones compatibles.

Las reglas concretas deben interpretarse según la especificación y las necesidades del proyecto.

---

# 9. Configuración de Git

## Git Config

Es el sistema de configuración de Git.

Ejemplo:

```bash
git config --global user.name "Nombre"
git config --global user.email "correo@example.com"
```

La configuración puede existir a diferentes niveles, incluyendo:

* sistema;
* usuario;
* repositorio.

---

## `.gitignore`

`.gitignore` especifica archivos y rutas que Git debe ignorar al detectar cambios no rastreados.

Ejemplo:

```text
.env
__pycache__/
*.log
.venv/
```

Es fundamental para evitar subir archivos que no deberían formar parte del repositorio.

---

## `.gitattributes`

`.gitattributes` permite definir atributos específicos para rutas y archivos.

Puede utilizarse para controlar aspectos como:

* tratamiento de archivos;
* normalización de finales de línea;
* filtros;
* comportamiento de determinadas herramientas de Git.

---

## Git Hook

Un hook es un mecanismo que permite ejecutar scripts automáticamente en determinados eventos de Git.

Ejemplos:

```text
pre-commit
commit-msg
pre-push
post-merge
```

---

## Worktree

`git worktree` permite trabajar con varias ramas del mismo repositorio utilizando diferentes directorios de trabajo.

Ejemplo conceptual:

```text
proyecto/
proyecto-feature/
proyecto-hotfix/
```

Esto puede ser útil cuando necesitas trabajar simultáneamente en varias ramas.

---

## Submodule

Un submodule permite incluir otro repositorio Git dentro de un repositorio principal.

Ejemplo:

```text
proyecto-principal/
├── aplicación/
└── dependencia-externa/
```

Los submodules requieren comprender bien la relación entre ambos repositorios.

---

# 10. Documentación

## Markdown

Markdown es un lenguaje de marcado ligero utilizado para crear documentación con texto estructurado.

Ejemplo:

```markdown
# Título

## Subtítulo

- Elemento 1
- Elemento 2
```

GitHub renderiza Markdown automáticamente en muchos archivos.

---

## README

`README.md` es normalmente el documento inicial de un repositorio.

Puede explicar:

* qué hace el proyecto;
* cómo instalarlo;
* cómo utilizarlo;
* cómo contribuir;
* requisitos;
* ejemplos.

---

## CHANGELOG

Un `CHANGELOG` registra cambios relevantes entre versiones.

Ejemplo:

```text
## [2.0.0]

### Añadido
- Sistema de autenticación.

### Corregido
- Error en la validación.
```

---

## LICENSE

Una licencia define las condiciones bajo las cuales otras personas pueden utilizar, modificar o distribuir un proyecto.

No debe elegirse una licencia únicamente copiando un archivo de otro proyecto.

Es importante comprender sus condiciones.

---

# 11. Seguridad

## SSH

SSH es un protocolo utilizado para establecer conexiones seguras.

Git puede utilizar SSH para autenticarse con servicios remotos.

Conceptualmente:

```text
Computadora
    │
    │ conexión SSH
    ▼
GitHub
```

---

## Token

Un token es una cadena utilizada como credencial para autenticar o autorizar determinadas operaciones.

Los tokens deben protegerse como información sensible.

---

## API Key

Una API key es una credencial utilizada normalmente para identificar o autorizar aplicaciones frente a una API.

Nunca debe publicarse accidentalmente en un repositorio.

---

## Secret

Un secret es información sensible utilizada por una aplicación o proceso.

Ejemplos:

```text
API_KEY
DATABASE_PASSWORD
ACCESS_TOKEN
PRIVATE_KEY
```

---

## Secret Scanning

Es una funcionalidad de seguridad que busca credenciales y secretos expuestos en repositorios.

---

## Dependencia

Una dependencia es un componente externo que un proyecto utiliza.

Ejemplo:

```text
Aplicación
   ↓
Biblioteca externa
   ↓
Otra biblioteca
```

Las dependencias deben mantenerse actualizadas y controladas.

---

## Supply Chain Security

La seguridad de la cadena de suministro de software busca proteger todo el conjunto de componentes y procesos utilizados para construir y distribuir software.

Incluye aspectos como:

* dependencias;
* paquetes;
* repositorios;
* procesos de compilación;
* credenciales;
* artefactos;
* pipelines.

---

## SAST

SAST significa **Static Application Security Testing**.

Analiza código o artefactos sin ejecutar la aplicación para buscar posibles vulnerabilidades.

---

## DAST

DAST significa **Dynamic Application Security Testing**.

Analiza una aplicación mientras está ejecutándose para identificar determinados problemas de seguridad.

---

# 12. GitHub Actions y automatización

## GitHub Actions

GitHub Actions es un sistema de automatización integrado en GitHub.

Puede utilizarse para:

* ejecutar pruebas;
* analizar código;
* construir aplicaciones;
* publicar paquetes;
* desplegar aplicaciones;
* automatizar tareas.

---

## Workflow

Un workflow es un flujo automatizado definido normalmente mediante un archivo YAML.

Ejemplo:

```text
.github/
└── workflows/
    └── tests.yml
```

---

## Event / Evento

Es la acción que desencadena un workflow.

Ejemplos:

```text
push
pull_request
workflow_dispatch
schedule
```

---

## Job

Un job es una unidad de trabajo dentro de un workflow.

Ejemplo:

```text
Workflow
├── test
├── security
└── build
```

---

## Step

Un step es una acción individual dentro de un job.

Ejemplo conceptual:

```text
Job
├── Descargar código
├── Instalar dependencias
├── Ejecutar pruebas
└── Generar resultado
```

---

## Runner

Un runner es el entorno donde se ejecuta un job de GitHub Actions.

Puede ser:

* administrado por GitHub;
* autoalojado.

---

## Artifact

Un artifact es un archivo o conjunto de archivos producido por un proceso automatizado y almacenado para su posterior utilización.

Ejemplos:

```text
programa compilado
reporte de pruebas
archivo ZIP
paquete
```

---

## Matrix

Una estrategia de matrix permite ejecutar un job utilizando diferentes combinaciones de parámetros.

Ejemplo:

```text
Python 3.11
Python 3.12
Python 3.13
```

También puede combinar sistemas operativos u otras variables.

---

# 13. CI/CD

## CI

CI significa **Continuous Integration**, o Integración Continua.

Consiste en integrar cambios frecuentemente y ejecutar procesos automatizados para detectar problemas.

Ejemplo:

```text
Push
 ↓
Tests
 ↓
Análisis
 ↓
Resultado
```

---

## CD

CD puede significar:

* **Continuous Delivery**: entrega continua;
* **Continuous Deployment**: despliegue continuo.

Los dos conceptos están relacionados, pero no son exactamente lo mismo.

---

## Pipeline

Un pipeline es una secuencia automatizada de procesos.

Ejemplo:

```text
Código
  ↓
Pruebas
  ↓
Análisis
  ↓
Build
  ↓
Deploy
```

---

## Build

Es el proceso de construir un producto o artefacto a partir del código fuente.

---

## Deploy / Deployment

Es el proceso de poner una aplicación, servicio o versión en un entorno donde pueda ejecutarse.

Ejemplo:

```text
Desarrollo
    ↓
Pruebas
    ↓
Producción
```

---

## Rollback

Rollback significa regresar a una versión anterior después de un problema.

Ejemplo:

```text
v2.0 → problema
       ↓
rollback
       ↓
v1.9
```

---

# 14. DevOps

## DevOps

DevOps es un conjunto de prácticas, principios y enfoques orientados a mejorar la colaboración entre desarrollo y operaciones mediante automatización, integración, entrega continua y observabilidad.

Git desempeña un papel fundamental en muchos flujos DevOps.

---

## Infraestructura como código

Infrastructure as Code, o IaC, consiste en definir infraestructura mediante archivos que pueden versionarse y automatizarse.

Ejemplos de tecnologías:

* Terraform;
* Ansible;
* CloudFormation;
* herramientas equivalentes.

---

## Observabilidad

La observabilidad permite comprender el estado interno de un sistema mediante señales como:

* logs;
* métricas;
* trazas;
* eventos.

---

# 15. DevSecOps

## DevSecOps

DevSecOps integra prácticas de seguridad dentro del ciclo de desarrollo y operaciones.

Conceptualmente:

```text
Desarrollo
    +
Seguridad
    +
Operaciones
```

La seguridad deja de ser una actividad exclusivamente posterior al desarrollo.

---

## Shift Left

Shift Left significa incorporar determinadas verificaciones de calidad y seguridad lo más temprano posible dentro del ciclo de desarrollo.

Ejemplo:

```text
Código
 ↓
Análisis de seguridad
 ↓
Tests
 ↓
Build
 ↓
Deploy
```

---

# 16. Arquitectura de repositorios

## Monorepo

Un monorepo almacena múltiples componentes o proyectos relacionados dentro de un mismo repositorio.

Ejemplo:

```text
empresa/
├── frontend/
├── backend/
├── móvil/
└── herramientas/
```

---

## Multirepo

En un enfoque multirepo, diferentes proyectos o componentes se mantienen en repositorios separados.

Ejemplo:

```text
frontend
backend
mobile
infraestructura
```

Cada uno puede tener su propio repositorio.

---

## Gobernanza

La gobernanza de repositorios comprende las reglas, procesos y controles utilizados para administrar proyectos y equipos.

Puede incluir:

* permisos;
* políticas;
* revisiones;
* estándares;
* seguridad;
* protección de ramas;
* procesos de publicación.

---

## Branch Protection / Reglas de ramas

Son reglas utilizadas para controlar qué operaciones pueden realizarse sobre determinadas ramas.

Por ejemplo, una organización puede exigir:

```text
Pull Request
      ↓
2 revisiones
      ↓
Tests exitosos
      ↓
Merge
```

---

# 17. Trabajo profesional

## Workflow

Un workflow es el conjunto de pasos que sigue una persona o equipo para realizar un trabajo.

En desarrollo:

```text
Issue
 ↓
Branch
 ↓
Código
 ↓
Commit
 ↓
Push
 ↓
Pull Request
 ↓
Review
 ↓
Tests
 ↓
Merge
```

---

## Branch Strategy

Una estrategia de ramas define cómo un equipo organiza y utiliza las ramas.

Ejemplos:

* GitHub Flow;
* Git Flow;
* Trunk-Based Development;
* estrategias personalizadas.

No existe una estrategia universalmente correcta para todos los proyectos.

---

## GitHub Flow

Es un modelo de trabajo basado generalmente en una rama principal y ramas de trabajo de corta duración que se integran mediante Pull Requests.

---

## Git Flow

Es una estrategia de trabajo que utiliza diferentes tipos de ramas para organizar determinadas etapas del desarrollo y publicación.

Es importante entender que Git Flow es una estrategia posible, no una característica obligatoria de Git.

---

## Trunk-Based Development

Es un enfoque en el que los desarrolladores integran cambios frecuentemente sobre una línea principal de desarrollo, normalmente utilizando ramas de corta duración.

---

# 18. Conceptos avanzados

## Objeto de Git

Internamente, Git almacena diferentes tipos de objetos.

Entre ellos:

* blobs;
* trees;
* commits;
* tags.

Estos objetos forman parte del modelo interno de almacenamiento de Git.

---

## Blob

Un blob es un objeto utilizado por Git para almacenar contenido de archivos.

---

## Tree

Un tree representa estructuras de directorios y referencias a otros objetos.

Puede entenderse conceptualmente como una fotografía estructurada del contenido de un directorio en un momento determinado.

---

## Commit Object

Un objeto commit contiene información que describe una determinada versión del historial.

Entre otros datos puede incluir:

* referencia al árbol;
* commit padre;
* autor;
* persona que realizó el commit;
* fecha;
* mensaje.

---

## Detached HEAD

Se produce cuando `HEAD` apunta directamente a un commit en lugar de estar asociado normalmente a una rama.

Ejemplo conceptual:

```text
A──B──C──D
      ↑
     HEAD
```

Puede ser útil para inspeccionar estados históricos, pero los commits creados en esta situación requieren atención para no perder referencias a ellos.

---

# 19. Términos relacionados con proyectos

## Código fuente

Es el código escrito por los desarrolladores que constituye la base de un programa.

Ejemplo:

```python
def saludar(nombre):
    return f"Hola {nombre}"
```

---

## Dependencia externa

Es una biblioteca, paquete o componente desarrollado fuera del proyecto que este utiliza.

---

## Entorno de desarrollo

Es el conjunto de herramientas utilizadas para desarrollar software.

Puede incluir:

* editor;
* terminal;
* Git;
* intérprete;
* compilador;
* dependencias;
* herramientas de pruebas.

---

## Producción

Es el entorno donde el software se encuentra disponible para sus usuarios o consumidores reales.

---

## Desarrollo

Es el entorno utilizado para construir y modificar el software.

---

## Testing / Pruebas

Es el proceso de comprobar que un sistema funciona de acuerdo con determinados requisitos.

Puede incluir:

* pruebas unitarias;
* pruebas de integración;
* pruebas funcionales;
* pruebas de seguridad;
* pruebas de rendimiento.

---

# 20. Términos que debes distinguir

## Git ≠ GitHub

```text
Git
→ Control de versiones

GitHub
→ Plataforma basada en Git
```

---

## GitHub ≠ GitHub Desktop

GitHub es una plataforma.

GitHub Desktop es una aplicación gráfica que facilita determinadas operaciones con Git y GitHub.

---

## Commit ≠ Push

```text
commit
→ registra cambios en el repositorio local

push
→ envía commits al repositorio remoto
```

Puedes realizar commits sin hacer push.

---

## Pull ≠ Fetch

```text
fetch
→ obtiene cambios del remoto

pull
→ obtiene cambios y los integra según la configuración
```

---

## Merge ≠ Rebase

Ambos pueden utilizarse para integrar historias, pero producen historiales diferentes y tienen implicaciones distintas.

---

## Revert ≠ Reset

```text
revert
→ crea un nuevo commit que invierte cambios

reset
→ mueve referencias y puede modificar el estado local
```

---

## Fork ≠ Clone

```text
Fork
→ copia un repositorio dentro de GitHub

Clone
→ copia un repositorio hacia tu computadora
```

---

## Git ≠ copia de seguridad

Git conserva historial, pero un repositorio Git no debe considerarse automáticamente una estrategia completa de backup.

Una estrategia profesional de recuperación debe considerar:

* copias;
* redundancia;
* almacenamiento remoto;
* recuperación ante desastres;
* pruebas de restauración.

---

# 21. El modelo mental fundamental

Una de las ideas más importantes de todo este repositorio es comprender el flujo:

```text
                 GIT

┌──────────────────────┐
│ Directorio de trabajo│
│                      │
│ archivos modificados │
└──────────┬───────────┘
           │
        git add
           │
           ▼
┌──────────────────────┐
│    Staging Area      │
│                      │
│ cambios seleccionados│
└──────────┬───────────┘
           │
       git commit
           │
           ▼
┌──────────────────────┐
│   Repositorio local  │
│                      │
│ historial de commits │
└──────────┬───────────┘
           │
        git push
           │
           ▼
┌──────────────────────┐
│ Repositorio remoto   │
│      GitHub          │
└──────────────────────┘
```

Comprender este modelo es más importante que memorizar decenas de comandos.

---

# 22. Flujo profesional completo

Un flujo de desarrollo moderno puede tener una estructura similar a:

```text
Issue
  ↓
Crear rama
  ↓
Modificar código
  ↓
Probar localmente
  ↓
git add
  ↓
git commit
  ↓
git push
  ↓
Pull Request
  ↓
Code Review
  ↓
CI
  ↓
Pruebas
  ↓
Análisis de seguridad
  ↓
Merge
  ↓
Build
  ↓
Release
  ↓
Deploy
  ↓
Monitorización
```

Este flujo conecta Git y GitHub con prácticas de:

* desarrollo de software;
* colaboración;
* CI/CD;
* DevOps;
* DevSecOps;
* seguridad;
* automatización.

---

# 23. Regla de oro

Cuando encuentres un término desconocido, no intentes memorizarlo inmediatamente.

Pregúntate:

1. ¿Qué es?
2. ¿Qué problema resuelve?
3. ¿Dónde se utiliza?
4. ¿Qué ocurre internamente?
5. ¿Cuál es un ejemplo sencillo?
6. ¿Qué riesgos tiene?
7. ¿Cuándo debería utilizarlo?
8. ¿Cuándo no debería utilizarlo?

Ese método permite pasar de memorizar comandos a comprender realmente Git y GitHub.

---

# 24. Resumen de los términos fundamentales

Si estás comenzando, concentra primero tu atención en estos conceptos:

```text
Git
GitHub
Repositorio
Commit
Working Directory
Staging Area
Branch
Merge
Remote
Origin
Clone
Push
Pull
Fetch
HEAD
Pull Request
Issue
Code Review
.gitignore
```

Después puedes avanzar hacia:

```text
Rebase
Reset
Revert
Stash
Reflog
Cherry-pick
Tag
Release
Hooks
Worktree
Submodules
CODEOWNERS
GitHub Actions
CI/CD
Security
DevOps
DevSecOps
Monorepo
Gobernanza
```

No necesitas dominar todos estos conceptos antes de comenzar a practicar.

El objetivo de este repositorio es que los conceptos aparezcan progresivamente cuando realmente los necesites.

---

# 25. Idea central del repositorio

Git no debe aprenderse como una lista de comandos.

Debe entenderse como un sistema para responder preguntas importantes:

> ¿Qué cambió?

> ¿Cuándo cambió?

> ¿Quién lo cambió?

> ¿Por qué se cambió?

> ¿Qué versión funcionaba antes?

> ¿Podemos recuperar una versión anterior?

> ¿Cómo trabajamos varias personas sobre el mismo proyecto?

> ¿Cómo automatizamos las pruebas?

> ¿Cómo protegemos el código?

> ¿Cómo llevamos los cambios desde el desarrollo hasta producción?

Cuando entiendes esas preguntas, los comandos dejan de parecer instrucciones aisladas y comienzan a formar parte de un sistema coherente.

Ese es el objetivo de **GitHub Paso a Paso**.
