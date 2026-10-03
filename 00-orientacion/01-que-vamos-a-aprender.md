# ¿Qué vamos a aprender?

## De utilizar Git y GitHub a comprenderlos y trabajar con ellos profesionalmente

Este repositorio está diseñado como un recorrido progresivo.

No vamos a comenzar suponiendo que ya sabes programar, utilizar Git o trabajar con GitHub.

Comenzaremos con los conceptos más sencillos y construiremos conocimiento sobre ellos hasta llegar a temas utilizados en equipos profesionales de desarrollo de software.

La idea fundamental es:

> **No aprender únicamente qué comando ejecutar, sino comprender qué problema resuelve, qué ocurre cuando lo ejecutamos y cuándo debemos utilizarlo.**

---

# 1. El recorrido completo

El aprendizaje está organizado en varias etapas:

```text
Computación básica
       ↓
GitHub desde cero
       ↓
Cuenta y seguridad
       ↓
GitHub desde la web
       ↓
GitHub Desktop
       ↓
Git desde cero
       ↓
Funcionamiento interno de Git
       ↓
Ramas
       ↓
Repositorios remotos
       ↓
Conflictos
       ↓
Recuperación
       ↓
Git avanzado
       ↓
Documentación
       ↓
Pull Requests
       ↓
Trabajo en equipo
       ↓
Estrategias de Git
       ↓
GitHub profesional
       ↓
GitHub Actions
       ↓
Seguridad
       ↓
Git para programación, datos e IA
       ↓
CI/CD
       ↓
DevOps
       ↓
DevSecOps
       ↓
Arquitectura y gobernanza
       ↓
Nivel senior
       ↓
Proyectos
       ↓
Proyecto final
```

No necesitas aprender todo de una vez.

Cada etapa prepara los conocimientos necesarios para la siguiente.

---

# 2. Etapa 1 — Comprender la computadora

Antes de utilizar Git, algunas personas necesitan aprender conceptos básicos de informática.

Estudiaremos:

* qué es un archivo;
* qué es una carpeta;
* qué es una ruta;
* qué es una extensión;
* cómo se organizan los archivos;
* cómo copiar archivos;
* cómo mover archivos;
* cómo eliminar archivos;
* qué es un programa;
* qué es una terminal;
* qué es un comando.

Por ejemplo:

```text
proyecto/
├── documentos/
├── imagenes/
├── datos/
└── codigo/
```

La intención no es convertir esta sección en un curso completo de informática.

Su objetivo es proporcionar los conocimientos necesarios para que nadie se quede atrás cuando aparezcan Git y GitHub.

---

# 3. Etapa 2 — Comprender GitHub

Después aprenderemos qué es GitHub.

Estudiaremos:

* qué es GitHub;
* qué es un repositorio;
* qué es un repositorio público;
* qué es un repositorio privado;
* qué es el control de versiones;
* para qué sirve GitHub;
* qué problemas resuelve;
* qué significa colaborar mediante GitHub.

También aprenderemos una diferencia fundamental:

```text
Git
│
└── Sistema de control de versiones

GitHub
│
└── Plataforma para alojar repositorios
    y colaborar utilizando Git
```

Esta distinción será fundamental durante todo el curso.

---

# 4. Etapa 3 — Crear y configurar nuestra cuenta

Aprenderemos a trabajar con nuestra cuenta de GitHub.

Estudiaremos:

* creación de la cuenta;
* perfil;
* configuración;
* repositorios;
* configuración de seguridad;
* autenticación;
* autenticación multifactor;
* organizaciones;
* permisos.

También aprenderemos una idea importante:

> Una cuenta de GitHub no es solamente un lugar para guardar código.

Puede convertirse en una parte de nuestra identidad profesional y de nuestro historial de proyectos.

---

# 5. Etapa 4 — Utilizar GitHub desde el navegador

Antes de entrar de lleno en la terminal, aprenderemos a realizar operaciones básicas desde la interfaz web.

Aprenderemos a:

* crear un repositorio;
* crear archivos;
* modificar archivos;
* eliminar archivos;
* crear carpetas mediante archivos;
* subir archivos;
* visualizar cambios;
* crear commits;
* consultar el historial;
* restaurar versiones cuando corresponda.

Esto permitirá comprender algunos conceptos de Git sin tener que aprender inmediatamente comandos.

---

# 6. Etapa 5 — GitHub Desktop

Después conoceremos GitHub Desktop.

Aprenderemos a:

* instalarlo;
* iniciar sesión;
* clonar repositorios;
* observar cambios;
* preparar cambios;
* crear commits;
* hacer push;
* hacer pull;
* trabajar con ramas;
* cambiar entre ramas.

Esta etapa sirve como puente entre:

```text
GitHub Web
     ↓
GitHub Desktop
     ↓
Git + Terminal
```

No es obligatorio utilizar GitHub Desktop para aprender Git, pero puede facilitar la transición a quienes todavía no están familiarizados con la terminal.

---

# 7. Etapa 6 — Git desde cero

Aquí comenzará el estudio directo de Git.

Aprenderemos qué es Git y cómo instalarlo.

Después trabajaremos progresivamente con comandos como:

```bash
git init
git status
git add
git commit
git log
git diff
git show
```

Pero no estudiaremos estos comandos como una lista para memorizar.

Para cada uno responderemos:

1. ¿Qué problema resuelve?
2. ¿Qué información utiliza?
3. ¿Qué modifica?
4. ¿Qué resultado produce?
5. ¿Qué ocurre internamente?
6. ¿Cuándo conviene utilizarlo?
7. ¿Qué errores pueden producirse?

---

# 8. Etapa 7 — Comprender cómo funciona Git

Esta es una de las etapas más importantes.

Aquí dejaremos de ver Git solamente como una herramienta y comenzaremos a comprender su modelo interno.

Estudiaremos:

* Working Directory;
* Staging Area;
* Local Repository;
* Remote Repository;
* commits;
* hashes;
* HEAD;
* referencias;
* historial;
* objetos de Git;
* relaciones entre commits.

El modelo fundamental será:

```text
Working Directory
       │
     git add
       ↓
Staging Area
       │
   git commit
       ↓
Local Repository
       │
    git push
       ↓
Remote Repository
```

Cuando comprendas este modelo, muchos comandos que inicialmente parecen complicados comenzarán a tener sentido.

---

# 9. Etapa 8 — Ramas

Aprenderemos por qué existen las ramas.

Estudiaremos:

* qué es una branch;
* crear ramas;
* cambiar de rama;
* eliminar ramas;
* ramas locales;
* ramas remotas;
* ramas de seguimiento;
* merge;
* fast-forward;
* historial de ramas.

Por ejemplo:

```text
main
 │
 ├── A
 │
 ├── B
 │
 └── C
      \
       D
       \
        E
```

La idea será comprender cómo diferentes líneas de desarrollo pueden coexistir.

---

# 10. Etapa 9 — Git remoto

Aquí conectaremos Git local con repositorios remotos.

Aprenderemos:

```bash
git clone
git remote
git fetch
git pull
git push
```

También estudiaremos:

* `origin`;
* `upstream`;
* repositorio local;
* repositorio remoto;
* sincronización;
* tracking branches;
* diferencias entre fetch y pull.

Un concepto fundamental será:

> **Git local y GitHub no son la misma cosa.**

Aprenderemos qué información existe en cada uno y cómo se sincronizan.

---

# 11. Etapa 10 — Conflictos

Los conflictos son una parte normal del trabajo colaborativo.

Aprenderemos:

* qué es un conflicto;
* por qué aparece;
* cómo identificarlo;
* cómo leerlo;
* cómo resolverlo;
* cómo continuar un merge;
* cómo resolver conflictos durante un rebase;
* cómo cancelar una operación cuando sea necesario.

Por ejemplo:

```text
<<<<<<< HEAD
texto de una rama
=======
texto de otra rama
>>>>>>> otra-rama
```

No aprenderemos simplemente a borrar esas marcas.

Aprenderemos **por qué aparecieron y qué decisión debemos tomar sobre el contenido**.

---

# 12. Etapa 11 — Deshacer y recuperar

Una de las áreas que más confusión genera en Git es deshacer cambios.

Aprenderemos la diferencia entre:

```text
git restore
git revert
git reset
git stash
git reflog
```

Comprenderemos que no todos significan lo mismo.

Por ejemplo:

```text
RESTORE
→ recuperar archivos/cambios

REVERT
→ crear un nuevo commit que deshace otro

RESET
→ mover referencias y modificar el estado del historial

STASH
→ guardar temporalmente cambios

REFLOG
→ consultar movimientos de referencias para recuperar estados
```

También aprenderemos qué operaciones pueden ser peligrosas.

---

# 13. Etapa 12 — Git avanzado

Cuando los fundamentos estén consolidados, estudiaremos herramientas avanzadas.

Entre ellas:

```bash
git rebase
git rebase -i
git cherry-pick
git tag
git bisect
git blame
git worktree
git submodule
```

También estudiaremos:

* reescritura del historial;
* commits;
* referencias;
* tags;
* versionado;
* diagnóstico de errores;
* hooks;
* escenarios avanzados.

Aquí comenzaremos a trabajar con situaciones más cercanas a las que aparecen en proyectos profesionales.

---

# 14. Etapa 13 — `.gitignore` y configuración

Aprenderemos a controlar qué archivos debe ignorar Git.

Por ejemplo:

```text
.env
__pycache__/
node_modules/
*.log
```

Estudiaremos:

* `.gitignore`;
* `.gitconfig`;
* `.gitattributes`;
* configuración global;
* configuración local;
* finales de línea;
* normalización de archivos.

También comprenderemos por qué un `.gitignore` **no es un mecanismo de seguridad para secretos que ya fueron publicados**.

---

# 15. Etapa 14 — Git y documentación

Un repositorio profesional no contiene únicamente código.

Aprenderemos a utilizar:

* Markdown;
* README;
* CHANGELOG;
* LICENSE;
* CONTRIBUTING;
* documentación técnica;
* plantillas.

Aprenderemos también a organizar la información para que otra persona pueda comprender el proyecto sin tener que preguntarnos todo.

---

# 16. Etapa 15 — Pull Requests

Aquí entraremos en uno de los mecanismos fundamentales de colaboración en GitHub.

Aprenderemos el flujo:

```text
Issue
  ↓
Branch
  ↓
Cambios
  ↓
Commit
  ↓
Push
  ↓
Pull Request
  ↓
Code Review
  ↓
Pruebas
  ↓
Aprobación
  ↓
Merge
```

Estudiaremos:

* qué es un Pull Request;
* cómo crearlo;
* cómo describirlo;
* revisión de código;
* comentarios;
* cambios solicitados;
* aprobación;
* merge;
* cierre de Pull Requests.

---

# 17. Etapa 16 — Trabajo en equipo

Después aprenderemos a utilizar GitHub como herramienta de colaboración.

Estudiaremos:

* colaboradores;
* permisos;
* organizaciones;
* Issues;
* etiquetas;
* milestones;
* GitHub Projects;
* Discussions;
* CODEOWNERS;
* revisores;
* responsabilidades.

La pregunta dejará de ser:

> "¿Cómo uso Git yo solo?"

y pasará a ser:

> "¿Cómo puede trabajar un equipo utilizando Git y GitHub?"

---

# 18. Etapa 17 — Estrategias de Git

No existe una única forma de organizar un flujo de trabajo.

Estudiaremos diferentes estrategias:

### GitHub Flow

```text
main
 │
 ├── feature
 │
 └── Pull Request
        ↓
      merge
```

### Git Flow

Estudiaremos su modelo de ramas y su contexto histórico.

### Trunk-Based Development

Analizaremos el trabajo alrededor de una rama principal y los mecanismos utilizados para integrar cambios frecuentemente.

También estudiaremos:

* Feature Branching;
* estrategias de integración;
* versionado semántico;
* cuándo utilizar cada enfoque;
* ventajas y limitaciones.

No se trata de memorizar una estrategia.

Se trata de comprender **por qué un equipo puede elegir una determinada estrategia**.

---

# 19. Etapa 18 — GitHub profesional

Aquí comenzaremos a construir repositorios con características propias de proyectos profesionales.

Estudiaremos:

* estructura del repositorio;
* README profesional;
* plantillas;
* Issues;
* Pull Requests;
* CODEOWNERS;
* releases;
* proyectos;
* permisos;
* organizaciones;
* convenciones;
* gobernanza.

Aprenderemos que un repositorio profesional es mucho más que:

```text
código + commits
```

También incluye:

```text
código
+ documentación
+ colaboración
+ pruebas
+ automatización
+ seguridad
+ gobierno
```

---

# 20. Etapa 19 — GitHub Actions

Entraremos en automatización.

Aprenderemos:

* qué es GitHub Actions;
* workflows;
* eventos;
* triggers;
* jobs;
* steps;
* runners;
* artifacts;
* variables;
* secrets;
* matrices;
* permisos.

Por ejemplo:

```text
Push
 ↓
GitHub Actions
 ↓
Instalar dependencias
 ↓
Ejecutar pruebas
 ↓
Analizar código
 ↓
Construir aplicación
 ↓
Generar artefactos
```

Aprenderemos a interpretar un archivo como:

```text
.github/
└── workflows/
    └── ci.yml
```

---

# 21. Etapa 20 — Seguridad

La seguridad estará integrada progresivamente en todo el recorrido.

Estudiaremos:

* contraseñas;
* tokens;
* SSH;
* API keys;
* secretos;
* `.gitignore`;
* secret scanning;
* Dependabot;
* Code Scanning;
* dependencias;
* vulnerabilidades;
* seguridad de la cadena de suministro;
* permisos;
* protección de ramas;
* seguridad de GitHub Actions.

Una regla fundamental será:

> **Un repositorio no debe convertirse accidentalmente en un lugar donde se publiquen secretos.**

---

# 22. Etapa 21 — Git para programadores, datos e inteligencia artificial

Aplicaremos Git a diferentes disciplinas.

Trabajaremos con ejemplos relacionados con:

### Python

```text
proyecto-python/
├── src/
├── tests/
├── requirements.txt
└── README.md
```

### JavaScript

```text
proyecto-web/
├── src/
├── tests/
├── package.json
└── README.md
```

### Ciencia de datos

Aprenderemos consideraciones relacionadas con:

* notebooks;
* datos;
* scripts;
* entornos;
* experimentos;
* reproducibilidad.

### Inteligencia artificial

Analizaremos:

* código;
* prompts;
* configuraciones;
* notebooks;
* pipelines;
* documentación;
* experimentos;
* modelos y artefactos;
* reproducibilidad.

También estudiaremos qué información **no debería almacenarse directamente en un repositorio**, especialmente secretos y datos sensibles.

---

# 23. Etapa 22 — CI/CD

Aquí conectaremos Git con los procesos de entrega de software.

Aprenderemos:

* integración continua;
* entrega continua;
* despliegue continuo;
* pipelines;
* builds;
* pruebas automatizadas;
* artefactos;
* despliegues;
* rollback.

Un flujo simplificado será:

```text
Developer
    ↓
Git commit
    ↓
Push
    ↓
CI
    ↓
Tests
    ↓
Build
    ↓
Security checks
    ↓
Deploy
```

---

# 24. Etapa 23 — DevOps

Conectaremos Git con una visión más amplia del ciclo de vida del software.

Estudiaremos:

* cultura DevOps;
* automatización;
* CI/CD;
* contenedores;
* Docker;
* infraestructura como código;
* configuración;
* despliegue;
* observabilidad.

La idea será comprender que Git puede actuar como una pieza central de muchos procesos de ingeniería.

---

# 25. Etapa 24 — DevSecOps

Después incorporaremos seguridad al ciclo de desarrollo.

Estudiaremos:

* DevSecOps;
* Shift Left;
* análisis de código;
* dependencias;
* secretos;
* SAST;
* DAST;
* seguridad de pipelines;
* seguridad de la cadena de suministro.

El objetivo será comprender:

```text
Desarrollo
    +
Operaciones
    +
Seguridad
```

como partes integradas del mismo proceso.

---

# 26. Etapa 25 — Arquitectura de repositorios

En proyectos grandes aparecen nuevas preguntas.

Por ejemplo:

> ¿Debemos tener un solo repositorio o varios?

Estudiaremos:

### Monorepo

Un repositorio que contiene múltiples componentes o proyectos relacionados.

### Multirepo

Varios repositorios independientes.

También estudiaremos:

* estructura de proyectos;
* límites entre componentes;
* permisos;
* gobernanza;
* políticas;
* estándares;
* automatización;
* mantenimiento.

No aprenderemos que existe una única arquitectura correcta.

Aprenderemos a analizar el contexto y sus consecuencias.

---

# 27. Etapa 26 — Pensamiento de nivel senior

El nivel senior no consiste simplemente en conocer más comandos.

Implica tomar mejores decisiones técnicas basadas en contexto.

Estudiaremos:

* diseño de workflows;
* estrategias de ramas;
* revisión de código;
* gestión de releases;
* gobernanza;
* seguridad;
* automatización;
* recuperación ante incidentes;
* recuperación ante desastres;
* mantenimiento;
* escalabilidad;
* decisiones técnicas.

La pregunta cambia de:

> "¿Qué comando uso?"

a:

> "¿Qué estrategia resuelve mejor este problema para este equipo y este proyecto?"

---

# 28. Etapa 27 — Proyectos prácticos

La teoría debe convertirse en práctica.

Realizaremos proyectos progresivos.

Por ejemplo:

```text
Proyecto 1
Primer repositorio
```

Después:

```text
Proyecto 2
Diario digital
```

Después:

```text
Proyecto 3
Página web
```

Después:

```text
Proyecto 4
Proyecto Python
```

Después:

```text
Proyecto 5
Proyecto de datos
```

Después:

```text
Proyecto 6
Proyecto de inteligencia artificial
```

Y finalmente:

```text
Proyecto colaborativo
```

Cada proyecto incorporará nuevos conceptos.

---

# 29. Etapa 28 — Proyecto final

El proyecto final reunirá los conocimientos adquiridos.

La idea será construir un proyecto que incluya, según corresponda:

```text
Código
Documentación
Git
GitHub
Ramas
Commits
Pull Requests
Pruebas
GitHub Actions
Seguridad
CI/CD
Release
```

El objetivo no será solamente terminar un proyecto.

Será demostrar que comprendes el flujo completo.

---

# 30. Etapa 29 — Errores comunes

Finalmente tendremos una sección de consulta rápida.

Aquí encontraremos situaciones como:

* olvidé mi contraseña;
* hice un commit equivocado;
* eliminé un archivo;
* hice push al repositorio incorrecto;
* Git rechazó mi push;
* tengo un conflicto;
* eliminé una rama;
* perdí un commit;
* hice un reset incorrecto;
* no puedo hacer pull;
* no puedo hacer push;
* no sé qué significa un mensaje de Git.

Esta sección funcionará como una especie de **manual de diagnóstico**.

---

# 31. Qué sabrás hacer al terminar el nivel inicial

Después de las primeras etapas deberías poder:

* crear un repositorio;
* comprender qué es Git;
* comprender qué es GitHub;
* crear commits;
* consultar el historial;
* identificar cambios;
* trabajar con ramas;
* sincronizar un repositorio;
* comprender `push`, `pull` y `fetch`;
* utilizar GitHub desde la web;
* utilizar GitHub Desktop;
* utilizar Git desde la terminal.

---

# 32. Qué sabrás hacer al alcanzar un nivel avanzado

Podrás:

* trabajar con ramas complejas;
* resolver conflictos;
* utilizar rebase;
* recuperar información;
* utilizar reflog;
* utilizar cherry-pick;
* analizar historiales;
* utilizar tags;
* utilizar worktrees;
* configurar `.gitignore`;
* trabajar con Pull Requests;
* realizar code reviews;
* colaborar en equipos;
* diseñar estrategias de ramas.

---

# 33. Qué sabrás hacer a nivel profesional

Podrás comprender y participar en flujos como:

```text
Issue
  ↓
Branch
  ↓
Development
  ↓
Commit
  ↓
Push
  ↓
Pull Request
  ↓
Review
  ↓
Automated Tests
  ↓
Security Checks
  ↓
Merge
  ↓
Build
  ↓
Release
  ↓
Deploy
  ↓
Monitor
```

Y entenderás qué función cumple Git y GitHub en cada etapa.

---

# 34. Qué significa realmente "nivel senior"

Llegar al nivel senior no significa memorizar todos los comandos de Git.

Un profesional senior debe ser capaz de razonar sobre:

* riesgos;
* consecuencias;
* colaboración;
* mantenibilidad;
* seguridad;
* automatización;
* escalabilidad;
* recuperación;
* gobernanza;
* productividad del equipo.

Por ejemplo, ante una situación como:

> "Tenemos 40 desarrolladores trabajando en un mismo producto. Los conflictos son frecuentes y los despliegues fallan."

La respuesta profesional no consiste necesariamente en ejecutar un comando.

Primero hay que analizar:

```text
¿Cómo trabajan actualmente?
¿Qué estrategia de ramas utilizan?
¿Cómo integran cambios?
¿Cómo revisan código?
¿Qué pruebas ejecutan?
¿Cómo se despliega?
¿Qué automatización existe?
¿Qué problemas de coordinación existen?
```

Después se decide qué cambios realizar.

---

# 35. Las cuatro dimensiones del aprendizaje

Durante todo el repositorio trabajaremos cuatro dimensiones.

## 1. Concepto

Comprender qué es.

## 2. Práctica

Saber utilizarlo.

## 3. Internos

Comprender qué ocurre detrás.

## 4. Decisión

Saber cuándo utilizarlo y cuándo no.

Podemos representarlo así:

```text
                 COMPRENDER
                     │
                     ↓
                 PRACTICAR
                     │
                     ↓
                PROFUNDIZAR
                     │
                     ↓
                  DECIDIR
```

Un estudiante que solamente memoriza comandos se queda en la primera capa práctica.

Un profesional aprende a razonar sobre las cuatro.

---

# 36. Lo que no queremos enseñarte

No queremos que termines el curso diciendo:

> "Sé copiar comandos de Git de Internet."

Tampoco:

> "Cuando Git da un error, necesito que alguien me diga qué comando pegar."

Queremos que puedas leer:

```text
error: failed to push some refs
```

y comenzar a preguntarte:

> ¿Por qué mi repositorio local y el remoto tienen historias diferentes?

Ese cambio de mentalidad es mucho más importante que memorizar una solución.

---

# 37. El objetivo final

El objetivo de este repositorio puede resumirse así:

```text
NO

memorizar comandos
        ↓
copiarlos
        ↓
esperar que funcionen


SÍ

comprender el problema
        ↓
comprender Git
        ↓
elegir la herramienta adecuada
        ↓
ejecutarla conscientemente
        ↓
verificar el resultado
        ↓
aprender de lo ocurrido
```

---

# 38. La competencia que buscamos desarrollar

Al finalizar el recorrido, la meta es que puedas responder preguntas como:

> ¿Qué es Git?

> ¿Qué es GitHub?

> ¿Qué diferencia existe entre ambos?

> ¿Qué es un commit?

> ¿Qué es una rama?

> ¿Qué ocurre cuando hago `git add`?

> ¿Qué ocurre cuando hago `git commit`?

> ¿Qué diferencia existe entre `push`, `pull` y `fetch`?

> ¿Qué es un conflicto?

> ¿Cuándo utilizar `merge`?

> ¿Cuándo considerar `rebase`?

> ¿Cómo recupero un commit perdido?

> ¿Cómo trabajo mediante Pull Requests?

> ¿Cómo protejo un repositorio?

> ¿Cómo automatizo pruebas?

> ¿Cómo integro CI/CD?

> ¿Cómo incorporo seguridad?

> ¿Cómo diseño un flujo Git para un equipo?

Si puedes responder estas preguntas **explicando el porqué y no solamente repitiendo definiciones**, estarás construyendo una comprensión sólida.

---

# 39. El recorrido comienza aquí

No necesitas conocer todas estas palabras ahora.

Si algunas te resultan desconocidas, es completamente normal.

Durante el recorrido iremos construyendo el vocabulario progresivamente.

Por ahora recuerda solamente estas cinco ideas:

```text
1. Git controla versiones.

2. GitHub permite alojar repositorios y colaborar.

3. Un commit registra un estado del proyecto.

4. Las ramas permiten trabajar en diferentes líneas de desarrollo.

5. Git se aprende practicando y comprendiendo, no memorizando.
```

A partir de aquí comienza el recorrido.

**Siguiente paso:**

`02-computacion-desde-cero/`

o, si ya tienes conocimientos suficientes de informática:

`02-github-desde-cero/`
