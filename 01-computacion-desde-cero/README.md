# 00 — Orientación

## Bienvenido a GitHub Paso a Paso

Bienvenido a **GitHub Paso a Paso — De cero a nivel profesional**.

Este repositorio está diseñado para acompañarte desde los primeros conceptos de informática hasta el uso profesional de **Git, GitHub, control de versiones, colaboración, automatización, CI/CD, seguridad, DevOps y DevSecOps**.

No necesitas ser programador para comenzar.

No necesitas conocer Git.

No necesitas conocer GitHub.

No necesitas saber utilizar la terminal.

Y tampoco necesitas memorizar cientos de comandos.

Lo importante es avanzar paso a paso y comprender **qué estás haciendo, por qué lo haces y qué ocurre detrás de cada acción**.

---

# 1. ¿Para quién está pensado este repositorio?

Este material está dirigido a personas con diferentes niveles de experiencia.

Puede utilizarlo una persona que:

* nunca ha programado;
* está comenzando a estudiar informática;
* ha escuchado hablar de GitHub pero nunca lo ha utilizado;
* ya tiene una cuenta de GitHub pero no sabe qué hacer con ella;
* utiliza GitHub desde el navegador;
* utiliza GitHub Desktop;
* conoce algunos comandos de Git pero no comprende cómo funciona;
* programa en Python, JavaScript, Java, C#, C++, etc.;
* trabaja con datos o inteligencia artificial;
* necesita aprender colaboración mediante Pull Requests;
* quiere comprender CI/CD;
* quiere aprender GitHub Actions;
* quiere trabajar con DevOps o DevSecOps;
* quiere alcanzar un nivel profesional o senior.

El recorrido está diseñado para que cada persona pueda comenzar desde el punto que corresponda a sus conocimientos actuales.

---

# 2. No necesitas saber programar

Uno de los errores más comunes al aprender Git y GitHub es pensar:

> "Primero tengo que aprender a programar."

No necesariamente.

Git puede utilizarse para controlar versiones de:

* documentos;
* apuntes;
* páginas web;
* archivos de configuración;
* proyectos de programación;
* scripts;
* datos;
* documentación;
* proyectos de inteligencia artificial;
* archivos de investigación;
* material educativo.

Por ejemplo, puedes utilizar Git para mantener diferentes versiones de un documento:

```text
Informe_v1.docx
Informe_v2.docx
Informe_v3_FINAL.docx
Informe_v3_FINAL_ahora_si.docx
Informe_v3_FINAL_definitivo.docx
```

Git permite abordar este problema de una manera mucho más estructurada.

---

# 3. El problema que vamos a resolver

Imagina que estás trabajando en un proyecto.

Hoy tienes:

```text
proyecto/
└── informe.txt
```

Haces algunos cambios.

Después vuelves a modificarlo.

Luego descubres que el cambio anterior era incorrecto.

Y aparece la pregunta:

> ¿Cómo vuelvo exactamente a la versión anterior?

Ahora imagina que cinco personas trabajan simultáneamente en el mismo proyecto.

Una persona modifica un archivo.

Otra modifica otro.

Una tercera realiza una corrección.

Después todos necesitan combinar sus cambios.

Aquí es donde aparece el **control de versiones**.

Y aquí comienza la importancia de Git.

---

# 4. ¿Qué aprenderás?

Este repositorio no pretende enseñarte únicamente comandos.

Su objetivo es ayudarte a comprender un sistema completo.

Aprenderás progresivamente:

```text
Informática básica
       ↓
GitHub
       ↓
Git
       ↓
Control de versiones
       ↓
Repositorios
       ↓
Commits
       ↓
Ramas
       ↓
Repositorios remotos
       ↓
Merge / Rebase
       ↓
Conflictos
       ↓
Pull Requests
       ↓
Trabajo en equipo
       ↓
GitHub profesional
       ↓
GitHub Actions
       ↓
CI/CD
       ↓
Seguridad
       ↓
DevOps
       ↓
DevSecOps
       ↓
Arquitectura y gobierno
       ↓
Nivel profesional / senior
```

---

# 5. La diferencia fundamental: Git y GitHub

Esta diferencia debe quedar clara desde el principio.

## Git

**Git** es un sistema distribuido de control de versiones.

Permite registrar cambios en archivos y proyectos.

Puedes utilizar Git localmente en tu computadora sin necesidad de estar conectado a Internet.

## GitHub

**GitHub** es una plataforma que utiliza Git y proporciona servicios adicionales para alojar repositorios y colaborar con otras personas.

GitHub añade herramientas como:

* repositorios remotos;
* Pull Requests;
* Issues;
* Projects;
* Discussions;
* Actions;
* herramientas de seguridad;
* revisiones de código;
* releases;
* colaboración entre equipos.

Una forma sencilla de recordarlo:

> **Git controla versiones. GitHub facilita alojarlas, compartirlas y trabajar con otras personas.**

---

# 6. La idea que debes comprender primero

Durante todo este curso utilizaremos un modelo mental fundamental:

```text
┌──────────────────────┐
│  Carpeta de trabajo  │
│  Working Directory   │
└──────────┬───────────┘
           │
        git add
           ↓
┌──────────────────────┐
│   Staging Area       │
│   Área de preparación│
└──────────┬───────────┘
           │
       git commit
           ↓
┌──────────────────────┐
│   Repositorio local  │
│        Git           │
└──────────┬───────────┘
           │
        git push
           ↓
┌──────────────────────┐
│ Repositorio remoto   │
│      GitHub          │
└──────────────────────┘
```

Este esquema aparecerá muchas veces durante el recorrido.

No lo memorices todavía.

Primero aprende qué problema resuelve cada etapa.

---

# 7. ¿Qué es un repositorio?

Un **repositorio** es el espacio donde Git mantiene la información necesaria para controlar las versiones de un proyecto.

Puede contener:

```text
mi-proyecto/
├── README.md
├── programa.py
├── datos/
├── documentos/
└── .git/
```

La carpeta `.git` contiene información interna utilizada por Git para administrar el historial del repositorio.

Por eso es importante comprender una diferencia:

```text
Carpeta normal
      ≠
Repositorio Git
```

Una carpeta se convierte en un repositorio Git mediante:

```bash
git init
```

---

# 8. ¿Qué es un commit?

Un **commit** representa un punto registrado en la historia del proyecto.

Puedes imaginarlo como una fotografía lógica del estado de los archivos controlados por Git en un determinado momento.

Por ejemplo:

```text
A
│
├── Crear proyecto
│
B
│
├── Agregar README
│
C
│
├── Agregar programa
│
D
│
└── Corregir error
```

Cada commit forma parte del historial.

Esto permite comprender cómo evolucionó el proyecto.

---

# 9. ¿Por qué no debes tener miedo de Git?

Muchos estudiantes tienen miedo de utilizar Git porque ven comandos como:

```bash
git reset --hard
git rebase
git push --force
git clean
```

y piensan:

> "Si ejecuto algo mal, voy a destruir todo."

Es cierto que existen operaciones peligrosas.

Pero precisamente por eso este repositorio las explicará **antes de pedirte que las utilices**.

No queremos que memorices:

```bash
git reset --hard
```

Queremos que entiendas:

* qué hace;
* qué modifica;
* qué puede eliminar;
* cuándo puede utilizarse;
* cuándo no debería utilizarse;
* cómo comprobar qué va a ocurrir;
* cómo recuperar información cuando sea posible.

### Regla fundamental

> **Nunca ejecutes un comando destructivo que no comprendas.**

Esta regla será válida desde el primer día hasta el nivel profesional.

---

# 10. Aprenderás haciendo

Este repositorio está pensado para aprender mediante práctica.

No queremos que solamente leas:

```text
git status
```

Queremos que puedas hacer:

```bash
git status
```

y comprender:

> "Git me está mostrando el estado actual de mi proyecto."

Después:

```bash
git add archivo.txt
```

y comprender:

> "Estoy colocando este cambio en el área de preparación."

Después:

```bash
git commit -m "Agregar archivo de prueba"
```

y comprender:

> "Estoy registrando este cambio en el historial."

Finalmente:

```bash
git push
```

y comprender:

> "Estoy enviando mis commits al repositorio remoto."

---

# 11. El método de aprendizaje

Cada tema importante seguirá una estructura similar.

## 1. ¿Qué es?

Primero conocerás el concepto.

## 2. ¿Para qué sirve?

Después veremos qué problema resuelve.

## 3. ¿Cómo funciona?

Explicaremos qué ocurre internamente cuando sea necesario.

## 4. Ejemplo sencillo

Utilizaremos situaciones fáciles de visualizar.

## 5. Ejemplo práctico

Trabajaremos con Git o GitHub.

## 6. Errores comunes

Veremos qué suele salir mal.

## 7. Buenas prácticas

Aprenderemos cómo trabajar correctamente.

## 8. Ejercicio

Practicarás el concepto.

## 9. Resumen

Consolidaremos las ideas principales.

## 10. Siguiente paso

Conectaremos el concepto con el siguiente tema.

---

# 12. No intentes aprender todo de una vez

Git tiene muchas funcionalidades.

No necesitas aprenderlas todas el primer día.

Al principio basta con comprender:

```text
git status
git add
git commit
git log
```

Después:

```text
git branch
git switch
git merge
```

Más adelante:

```text
git fetch
git pull
git push
```

Después:

```text
git restore
git revert
git reset
git stash
```

Y posteriormente:

```text
git rebase
git cherry-pick
git bisect
git worktree
git reflog
```

Finalmente podrás estudiar conceptos profesionales como:

```text
Pull Requests
Code Review
GitHub Actions
CI/CD
Seguridad
DevOps
DevSecOps
Gobernanza
Arquitectura de repositorios
```

La progresión importa.

---

# 13. No memorices comandos: comprende problemas

Una de las metas principales de este repositorio es cambiar la forma tradicional de aprender Git.

En lugar de:

> "Tengo que memorizar 50 comandos."

Queremos llegar a:

> "Tengo un problema. ¿Qué herramienta de Git resuelve este problema?"

Por ejemplo:

### Problema

Quiero saber qué cambios tengo.

```bash
git status
```

### Problema

Quiero ver exactamente qué cambió.

```bash
git diff
```

### Problema

Quiero guardar un punto en la historia.

```bash
git commit
```

### Problema

Quiero crear una línea de trabajo independiente.

```bash
git branch
```

### Problema

Quiero recuperar una versión anterior de un archivo sin modificar todo el historial.

```bash
git restore
```

La comprensión del problema es más importante que memorizar el comando.

---

# 14. El terminal no es un enemigo

Durante el recorrido aparecerá la terminal.

Al principio puede parecer extraña.

Puedes encontrarte con algo como:

```text
C:\Users\Jorge\proyecto>
```

o:

```text
user@computer:~/proyecto$
```

No necesitas convertirte inmediatamente en experto en terminal.

Aprenderemos progresivamente:

* qué es una terminal;
* qué es un comando;
* dónde estás;
* cómo cambiar de carpeta;
* cómo listar archivos;
* cómo crear archivos;
* cómo ejecutar Git;
* cómo interpretar los mensajes que aparecen.

La terminal será una herramienta, no un obstáculo.

---

# 15. También puedes empezar desde GitHub

Si eres completamente principiante, no necesariamente tienes que comenzar escribiendo comandos.

El recorrido está diseñado para que primero puedas familiarizarte con GitHub desde la web.

Después puedes utilizar:

**GitHub Desktop**

y posteriormente:

**Git desde la terminal.**

La progresión recomendada es:

```text
GitHub Web
     ↓
GitHub Desktop
     ↓
Git + Terminal
     ↓
Git avanzado
     ↓
GitHub profesional
```

Esto permite que la complejidad aumente gradualmente.

---

# 16. ¿Qué ocurre si cometo un error?

Los errores son parte del aprendizaje.

Puedes:

* crear un repositorio incorrectamente;
* escribir mal un comando;
* crear una rama equivocada;
* hacer un commit que no querías;
* modificar un archivo incorrectamente;
* provocar un conflicto;
* olvidar hacer `git pull`;
* intentar hacer `push` y recibir un error.

Eso no significa que hayas fracasado.

Significa que tienes una oportunidad para aprender cómo funciona Git.

En este repositorio aprenderás también a **diagnosticar y recuperar errores**.

---

# 17. Git no es una copia de seguridad

Esta distinción es extremadamente importante.

Git registra versiones.

Pero eso no significa automáticamente que tengas una copia de seguridad externa.

Por ejemplo:

```text
Git local
    ↓
historial local
```

no es exactamente lo mismo que:

```text
Git local
    ↓
GitHub
    ↓
repositorio remoto
```

Más adelante aprenderás cómo Git, GitHub y las estrategias de respaldo pueden combinarse correctamente.

---

# 18. La seguridad comienza desde el primer día

Nunca publiques información secreta en un repositorio.

Por ejemplo:

```text
contraseñas
API keys
tokens
claves privadas
credenciales
secretos de producción
```

No hagas esto:

```python
API_KEY = "mi-clave-real"
```

Aunque el repositorio sea privado, debes desarrollar buenos hábitos desde el principio.

Más adelante estudiaremos:

* `.gitignore`;
* SSH;
* tokens;
* secret scanning;
* Dependabot;
* Code Scanning;
* seguridad de la cadena de suministro;
* GitHub Actions y secretos;
* DevSecOps.

---

# 19. Git y la inteligencia artificial

La inteligencia artificial puede ayudarte a aprender Git.

Puedes preguntarle:

> ¿Qué significa este error de Git?

> ¿Por qué mi `git push` fue rechazado?

> Explícame este conflicto.

> ¿Qué diferencia existe entre `git revert` y `git reset`?

Pero existe una regla importante:

> **No ejecutes ciegamente un comando generado por una IA.**

Especialmente si aparece:

```bash
git reset --hard
```

o:

```bash
git push --force
```

La IA puede ayudarte a comprender el problema.

La decisión de ejecutar una operación potencialmente destructiva debe realizarse después de comprender sus consecuencias.

---

# 20. Tu ruta de aprendizaje

El repositorio completo está organizado progresivamente.

## Etapa 00 — Orientación

Estás aquí.

Aprenderás:

* cómo estudiar;
* cómo utilizar el repositorio;
* cómo avanzar;
* cómo pedir ayuda;
* cómo practicar;
* cómo pensar sobre Git.

---

## Etapa 01 — Computación desde cero

Aprenderás conceptos básicos:

* archivos;
* carpetas;
* rutas;
* extensiones;
* programas;
* terminal.

---

## Etapa 02 — GitHub desde cero

Aprenderás:

* qué es GitHub;
* qué es un repositorio;
* Git frente a GitHub;
* repositorios públicos y privados;
* control de versiones.

---

## Etapa 03 — Tu cuenta de GitHub

Aprenderás:

* crear y configurar tu cuenta;
* perfil;
* seguridad;
* autenticación;
* organizaciones.

---

## Etapa 04 — GitHub desde la web

Aprenderás a utilizar GitHub sin comenzar necesariamente desde la terminal.

---

## Etapa 05 — GitHub Desktop

Aprenderás el flujo visual de Git.

---

## Etapa 06 — Git desde cero

Comenzarás con Git y la terminal.

---

## Etapa 07 — Cómo funciona Git

Profundizarás en:

* working directory;
* staging area;
* repositorio;
* commits;
* HEAD;
* hashes;
* historial;
* objetos internos.

---

## Etapa 08 — Ramas

Aprenderás:

* branches;
* switch;
* merge;
* ramas remotas;
* tracking.

---

## Etapa 09 — Git remoto

Aprenderás:

* clone;
* remote;
* fetch;
* pull;
* push;
* origin;
* upstream.

---

## Etapa 10 — Conflictos

Aprenderás a comprender y resolver conflictos.

---

## Etapa 11 — Deshacer y recuperar

Aprenderás:

* restore;
* revert;
* reset;
* stash;
* reflog;
* recuperación.

---

## Etapa 12 — Git avanzado

Entrarás en:

* rebase;
* interactive rebase;
* cherry-pick;
* tags;
* bisect;
* blame;
* worktree;
* submodules;
* hooks.

---

## Etapa 13 — Configuración e ignorados

Aprenderás:

* `.gitignore`;
* `.gitattributes`;
* `.gitconfig`;
* finales de línea;
* configuración global.

---

## Etapa 14 — Git y documentación

Aprenderás:

* Markdown;
* README;
* CHANGELOG;
* LICENSE;
* CONTRIBUTING;
* documentación profesional.

---

## Etapa 15 — Pull Requests

Aprenderás el flujo profesional:

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
CI / pruebas
  ↓
Merge
```

---

## Etapa 16 — Trabajo en equipo

Aprenderás:

* colaboradores;
* permisos;
* Issues;
* etiquetas;
* Projects;
* Discussions;
* CODEOWNERS;
* flujos de equipo.

---

## Etapa 17 — Estrategias de Git

Estudiarás:

* GitHub Flow;
* Git Flow;
* Feature Branching;
* Trunk-Based Development;
* versionado semántico.

---

## Etapa 18 — GitHub profesional

Aprenderás a construir repositorios preparados para proyectos reales.

---

## Etapa 19 — GitHub Actions

Aprenderás automatización y workflows.

---

## Etapa 20 — Seguridad

Estudiarás seguridad de repositorios y cadena de suministro.

---

## Etapa 21 — Git para programadores

Aplicarás Git a:

* Python;
* JavaScript;
* desarrollo web;
* bases de datos;
* ciencia de datos;
* machine learning;
* inteligencia artificial.

---

## Etapa 22 — CI/CD

Aprenderás integración continua y entrega/despliegue continuo.

---

## Etapa 23 — DevOps

Conectarás Git con:

* automatización;
* contenedores;
* Docker;
* infraestructura como código;
* observabilidad.

---

## Etapa 24 — DevSecOps

Integrarás seguridad dentro del ciclo de desarrollo.

---

## Etapa 25 — Arquitectura de repositorios

Estudiarás:

* monorepos;
* multirepos;
* estructura;
* gobernanza;
* permisos;
* políticas;
* estándares.

---

## Etapa 26 — Nivel senior

El objetivo será pasar de:

> "Sé utilizar Git."

a:

> "Sé diseñar y gestionar un flujo profesional basado en Git."

---

## Etapa 27 — Proyectos prácticos

Aplicarás los conocimientos mediante proyectos.

---

## Etapa 28 — Proyecto final

Construirás un proyecto completo aplicando el conocimiento acumulado.

---

## Etapa 29 — Errores comunes

Tendrás una sección de consulta rápida para problemas frecuentes.

---

# 21. Cómo estudiar cada capítulo

Te recomendamos seguir este proceso:

### Paso 1

Lee la explicación completa.

### Paso 2

No ejecutes todavía los comandos si no entiendes qué hacen.

### Paso 3

Realiza el ejemplo.

### Paso 4

Modifica el ejemplo.

### Paso 5

Provoca pequeños errores controlados.

### Paso 6

Observa los mensajes de Git.

### Paso 7

Intenta solucionar el problema.

### Paso 8

Consulta la explicación.

### Paso 9

Repite el ejercicio sin mirar las instrucciones.

### Paso 10

Explícale el concepto a otra persona.

Si puedes explicar algo con tus propias palabras, probablemente estás comenzando a comprenderlo.

---

# 22. Una primera práctica

Cuando llegues a la parte correspondiente de Git, trabajarás con algo parecido a esto:

```bash
git status
```

Después:

```bash
git add hola.txt
```

Luego:

```bash
git status
```

Después:

```bash
git commit -m "Agregar archivo de prueba"
```

Y finalmente, cuando el repositorio remoto esté configurado:

```bash
git push
```

No queremos que memorices esta secuencia.

Queremos que comprendas:

```text
ver estado
   ↓
preparar cambio
   ↓
registrar cambio
   ↓
enviar cambio
```

---

# 23. Cómo saber si realmente estás aprendiendo

No midas tu aprendizaje por la cantidad de comandos que puedes memorizar.

Hazte preguntas como:

### Nivel inicial

> ¿Sé qué es Git?

> ¿Sé qué es GitHub?

> ¿Sé qué es un repositorio?

### Nivel intermedio

> ¿Entiendo qué ocurre cuando hago `git add`?

> ¿Entiendo qué representa un commit?

> ¿Sé qué diferencia existe entre una rama local y una remota?

### Nivel avanzado

> ¿Sé cuándo utilizar merge y cuándo considerar rebase?

> ¿Sé resolver un conflicto?

> ¿Sé recuperar un commit utilizando reflog?

### Nivel profesional

> ¿Puedo diseñar un flujo de trabajo Git para un equipo?

> ¿Puedo establecer una estrategia de ramas?

> ¿Puedo diseñar un proceso de Pull Requests y revisión?

> ¿Puedo integrar pruebas, seguridad y automatización?

> ¿Puedo diagnosticar problemas de Git sin depender de copiar comandos de Internet?

Ese es el tipo de aprendizaje que buscamos.

---

# 24. Cómo pedir ayuda correctamente

Cuando tengas un problema, evita decir solamente:

> "Git no funciona."

Proporciona información.

Por ejemplo:

```text
Estoy intentando hacer git push.

Ejecuté:

git push

Obtuve este mensaje:

[pegar aquí el mensaje]

Antes de eso ejecuté:

git status

El resultado fue:

[pegar aquí el resultado]
```

Esto permite diagnosticar el problema mucho mejor.

### Regla

> **El mensaje de error es información, no una derrota.**

---

# 25. Qué hacer cuando no entiendes algo

No continúes acumulando conceptos sin comprenderlos.

Puedes:

1. volver al capítulo anterior;
2. buscar el término en `GLOSARIO.md`;
3. consultar `PREGUNTAS-FRECUENTES.md`;
4. repetir el ejemplo;
5. crear un proyecto de práctica;
6. pedir ayuda;
7. consultar la documentación oficial.

No existe ningún problema en volver atrás.

Aprender de manera progresiva es parte del proceso.

---

# 26. Tu primer objetivo

No es convertirte en experto en Git.

Tu primer objetivo es mucho más sencillo:

> **Crear tu primer repositorio, realizar tu primer cambio y comprender qué ocurrió.**

Después construiremos conocimiento sobre ese primer concepto.

```text
Primer repositorio
       ↓
Primer cambio
       ↓
Primer commit
       ↓
Primer historial
       ↓
Primera rama
       ↓
Primer repositorio remoto
       ↓
Primer Pull Request
       ↓
Primer flujo profesional
```

---

# 27. Una idea que te acompañará durante todo el recorrido

Git no debe aprenderse únicamente como una colección de comandos.

Debes aprender a pensar en:

```text
estado
   ↓
cambio
   ↓
registro
   ↓
historial
   ↓
rama
   ↓
colaboración
   ↓
automatización
   ↓
seguridad
   ↓
entrega
```

Cuando entiendas ese flujo, Git dejará de parecer una colección de comandos aislados.

Comenzará a convertirse en un sistema coherente.

---

# 28. Regla de oro

Durante todo el recorrido recuerda:

> **Primero comprende. Después ejecuta.**

Y una segunda regla:

> **Si un comando puede destruir información y no sabes exactamente qué hará, detente y pregunta.**

No hay ningún premio por ejecutar comandos rápidamente.

El objetivo es aprender a trabajar correctamente.

---

# 29. ¿Dónde continuar?

Si estás comenzando completamente desde cero:

**Continúa con:**

```text
01-computacion-desde-cero/
```

Si ya utilizas una computadora con soltura pero nunca has utilizado GitHub:

```text
02-github-desde-cero/
```

Si ya tienes una cuenta de GitHub:

```text
03-tu-cuenta-de-github/
```

Si ya utilizas Git y GitHub:

```text
06-git-desde-cero/
```

Si ya conoces Git y quieres comprender qué ocurre internamente:

```text
07-como-funciona-git/
```

Si ya trabajas profesionalmente con Git:

puedes saltar hacia las secciones avanzadas, pero se recomienda revisar el recorrido completo para detectar posibles lagunas conceptuales.

---

# 30. El objetivo final

El objetivo de este repositorio no es que puedas decir:

> "Me sé muchos comandos de Git."

El objetivo es que puedas decir:

> "Comprendo Git, sé utilizar GitHub, puedo trabajar con otras personas, puedo diagnosticar problemas, puedo recuperar errores, puedo automatizar procesos y puedo diseñar un flujo profesional de desarrollo."

Ese es el recorrido.

```text
                    GIT + GITHUB
                         │
          ┌──────────────┼──────────────┐
          │              │              │
       CONTROL       COLABORACIÓN   AUTOMATIZACIÓN
      DE VERSIONES        │              │
          │               │              │
       HISTORIAL      PULL REQUESTS   GITHUB ACTIONS
          │               │              │
        RAMAS         CODE REVIEW       CI/CD
          │               │              │
       MERGE          EQUIPOS          DEVOPS
          │               │              │
       REBASE         GOVERNANCE      DEVSECOPS
          │               │              │
          └──────────────┼──────────────┘
                         │
                  NIVEL PROFESIONAL
                         │
                    NIVEL SENIOR
```

---

## Bienvenido al recorrido

No importa si tienes 20, 40, 60 o 70 años.

No importa si vienes de programación, administración, educación, ciencia de datos, inteligencia artificial o si simplemente quieres aprender.

Comienza desde donde estés.

Avanza paso a paso.

Practica.

Equivócate.

Investiga.

Pregunta.

Corrige.

Y vuelve a intentarlo.

**Git no se aprende leyendo comandos.**

**Git se aprende utilizándolo y comprendiendo qué ocurre.**

Bienvenido a **GitHub Paso a Paso — De cero a nivel profesional**.


---

# Objetivos de aprendizaje de la sección

Al terminar esta parte del recorrido serás capaz de:

* identificar y operar los elementos básicos de una computadora: archivos, carpetas, rutas y extensiones;
* ejecutar operaciones de copiar, mover y eliminar y anticipar sus consecuencias;
* explicar el problema que resuelve el control de versiones en el mundo de los archivos;
* diferenciar un programa, una interfaz y la terminal;
* explicar a nivel intuitivo qué son un repositorio, un commit y Git.

---

# Referencias

* Chacon, S. y Straub, B. — *Pro Git* (cap. 1).
* Git — «Git simple» (git-scm.com/doc/git-simple.html).
* Documentación oficial de tu sistema operativo sobre archivos y carpetas (Windows: learn.microsoft.com).

---

# Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de esta sección:

1. ¿Qué diferencia hay entre un archivo y una carpeta y puede una carpeta contener carpetas?
2. Al mover un archivo de carpeta, ¿qué se puede romper y por qué?
3. ¿Qué tiene de frágil el nombre «Informe_FINAL_ahora_si.docx» y qué propone Git en su lugar?
4. ¿Qué te da un repositorio que no te da «guardar con otro nombre»?
