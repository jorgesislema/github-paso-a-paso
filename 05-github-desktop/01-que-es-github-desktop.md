# Qué es GitHub Desktop

## Introducción

Hasta ahora has aprendido qué son Git y GitHub, cómo se crea una cuenta y cómo se gestionan repositorios desde la web.

Si has llegado hasta aquí, probablemente te hayas dado cuenta de que todo lo hecho hasta el momento ocurre dentro de un navegador: haces clic en botones, completas formularios y esperas a que carguen las páginas.

Existe otra forma de trabajar con Git: instalar un programa en tu computadora que te muestre los repositorios y los cambios en una interfaz de botones y paneles.

Ese programa es **GitHub Desktop**.

En este capítulo aprenderás:

* qué es GitHub Desktop;
* quién lo desarrolla y para qué sirve;
* a qué personas les resulta más útil;
* en qué se diferencia de la web de GitHub;
* en qué se diferencia de Git por línea de comandos;
* qué incluye en su interior, incluida una copia de Git;
* cómo se ve su ventana principal y qué botones contiene;
* qué comando de Git ejecuta por detrás cada botón principal.

En este capítulo no necesitas instalar nada todavía: solo vamos a comprender qué es y qué ofrece.

---

## 1. Una primera explicación

GitHub Desktop es un programa gratuito que se instala en tu computadora, igual que un procesador de textos o un navegador.

Cuando lo instalas, lo abres, inicias sesión con tu cuenta de GitHub y ves todos tus repositorios en pantalla.

Desde esa ventana puedes clonar repositorios, modificar archivos, registrar cambios como commits y enviarlos a GitHub.

Todo se hace con botones, listas y paneles, sin escribir un solo comando.

```text
Tu computadora
     │
     ├── Navegador ───► github.com (la web)
     ├── Terminal ────► Git (línea de comandos)
     └── Programa ───► GitHub Desktop (interfaz gráfica)
```

La idea central es sencilla: los tres caminos logran el mismo objetivo, pero utilizan interfaces diferentes.

Ninguno de los tres es mejor de forma absoluta. Cada uno tiene un momento en el que resulta más cómodo.

---

## 2. Qué es GitHub Desktop

En términos técnicos, GitHub Desktop es una **aplicación de escritorio desarrollada por GitHub** para facilitar el trabajo con Git y con la plataforma.

Es una herramienta oficial: la crea la misma empresa que opera github.com.

Estas son sus características principales:

* Es gratuita: puedes descargarla y usarla sin pagar.
* Es de escritorio: funciona en Windows y en macOS.
* Trabaja con tu cuenta de GitHub: al iniciar sesión, muestra tus repositorios.
* Incluye Git en su interior: en Windows no necesitas instalar Git por separado.
* No exige conocer comandos: las operaciones se realizan con botones.

Conviene hacer una distinción importante desde el principio:

```text
GitHub           → servicio web (github.com)
GitHub Desktop   → programa que se instala en tu computadora
```

El servicio web guarda los repositorios en Internet y ofrece las herramientas de colaboración.

El programa te permite trabajar sobre copias locales de esos repositorios desde tu propia máquina.

También conviene separarlo de otra cosa que a veces se confunde: GitHub Desktop **no es un servicio de almacenamiento en la nube**. No sincroniza tus carpetas como lo harían OneDrive o Dropbox: gestiona el historial de un repositorio.

---

## 3. ¿Para quién sirve?

GitHub Desktop está pensado para personas que quieren utilizar Git sin pasar por la terminal.

Algunos ejemplos:

* Estudiantes que empiezan a programar y prefieren practicar sin memorizar comandos;
* Personas que ya usan la web y quieren tener las operaciones a un clic de distancia;
* Personas que guardan en GitHub documentos, apuntes o proyectos personales y prefieren una interfaz visual;
* Desarrolladores que quieren realizar las operaciones básicas (commit, push, pull, ramas) de forma rápida.

Para otros perfiles no es la mejor opción:

* Las operaciones avanzadas que requieren control preciso sobre Git;
* Equipos de trabajo que automatizan procesos desde la terminal;
* Entornos donde no se permite instalar programas;
* Trabajo en teléfono o tableta, porque no existe versión móvil.

Para mucha gente, GitHub Desktop es el puente ideal entre la web y la terminal.

Primero se trabaja con botones y, después, cuando ya se entiende el proceso, se pasa a los comandos.

Ese es precisamente el orden de este curso.

---

## 4. La alternativa visual a la terminal

Git también funciona desde la terminal, escribiendo comandos. Ambas formas son equivalentes en cuanto a lo que permiten hacer.

```text
Operación                Terminal                 GitHub Desktop
─────────────────────    ──────────────────────   ──────────────────────────
Clonar un repositorio    git clone                File → Clone repository
Registrar un cambio      git add + git commit     botón "Commit to main"
Enviar cambios           git push                 botón "Push origin"
Recibir cambios          git pull                 botón "Pull origin"
Crear una rama           git branch + git checkout  desplegable "Current Branch"
```

Ambos caminos usan el mismo Git debajo. Lo que cambia es la interfaz.

Cuando haces clic en "Commit to main", el programa ejecuta por ti `git add` y `git commit`.

Cuando haces clic en "Push origin", ejecuta `git push`.

Esta idea es muy importante para todo el curso: **cada botón corresponde a uno o varios comandos de Git**.

A lo largo de esta sección estudiaremos cada operación y, junto con ella, el comando equivalente. Así, cuando más adelante llegues a la terminal, ya sabrás qué hay detrás de cada botón.

Ventajas de la interfaz visual:

* No necesitas memorizar la sintaxis exacta de los comandos;
* Puedes ver las diferencias entre versiones de forma gráfica, línea a línea;
* Los errores aparecen en cuadros de diálogo legibles, con la posibilidad de ver el mensaje completo;
* El historial se muestra como una lista que puedes explorar con clics.

Limitaciones de la interfaz visual:

* Algunas operaciones avanzadas no tienen botón correspondiente;
* En la terminal puedes combinar operaciones y automatizarlas;
* Conocer los comandos te ayuda a entender mejor qué hacen los botones y a interpretar los errores.

Por eso, en las secciones siguientes del curso volveremos a la terminal: no para sustituir la aplicación, sino para profundizar en lo que ya sabes hacer con botones.

---

## 5. En qué se diferencia de la web de GitHub

Hasta ahora has usado GitHub a través del navegador. GitHub Desktop no reemplaza a la web: la complementa.

Estas son las diferencias principales:

| Aspecto             | Web de GitHub      | GitHub Desktop                    |
|---------------------|--------------------|-----------------------------------|
| Dónde se ejecuta    | En un navegador    | En tu computadora                 |
| Conexión a Internet | Siempre necesaria  | Local no; push y pull sí          |
| Modificar archivos  | Desde formularios  | En tu computadora, con tu editor  |
| Historial           | Se ve y consulta   | Se ve y además se añaden commits  |
| Colaboración        | Completa (Pull Requests, Issues) | Básica (crear Pull Requests)  |
| Configuración       | Del usuario y repositorio | Del programa y de Git       |

La web es el **centro de control** de tu cuenta: allí se administran permisos, colaboradores, Issues, discusiones y ajustes de cada repositorio.

La aplicación es el **taller** donde se hace el trabajo diario: modificar, registrar y mover commits.

Un flujo típico combina ambos:

```text
1. Creas el repositorio en la web (github.com)
2. Lo clonas en GitHub Desktop
3. Modificas archivos en tu computadora
4. Haces commit y push desde la aplicación
5. En la web abres Pull Requests, Issues y discusiones
```

A lo largo de esta sección verás varias veces esta combinación en acción.

---

## 6. Cómo se ve la ventana principal

Cuando inicias sesión y abres un repositorio, la ventana principal tiene esta organización:

```text
┌────────────────────────────────────────────────────────────────┐
│  [Nombre de usuario ▼]                    [Current Branch ▼]   │
│                                        [Pull origin][Push origin]
│  ┌──────────────┐  ┌──────────────────────────────────────┐   │
│  │              │  │  [Local Changes]  [History]          │   │
│  │  Lista de    │  │                                      │   │
│  │  repositorios│  │  Resumen:  ____________________      │   │
│  │              │  │  Descripción: ____________________   │   │
│  │  ▸ mi-repo   │  │  [ Commit to main ]                 │   │
│  │  ▸ otro-repo │  │                                      │   │
│  │              │  │  ☑ notas.txt  [Open in] [descartar]  │   │
│  │              │  │                                      │   │
│  │  [Clone      │  │  Vista de diferencias (diff)        │   │
│  │  repository] │  │  + línea añadida                    │   │
│  └──────────────┘  │  - línea eliminada                   │   │
│                    └──────────────────────────────────────┘   │
└────────────────────────────────────────────────────────────────┘
```

Estos son los elementos que verás y sus nombres exactos:

* **Lista de repositorios** (panel izquierdo): muestra los repositorios de tu cuenta, con un campo de búsqueda y el botón "Clone repository" en la parte inferior;
* **Current Branch** (desplegable superior derecho): muestra la rama en la que estás y las opciones de crear o cambiar de rama;
* **Pull origin** y **Push origin**: botones para recibir y enviar commits;
* **Local Changes**: pestaña donde se ven los cambios pendientes de registrar;
* **History**: pestaña donde se ve el historial de commits;
* **Resumen y Descripción**: cajas donde escribes el mensaje del commit;
* **Commit to [rama]**: botón que registra los cambios seleccionados;
* **Vista de diferencias**: panel derecho que muestra qué cambió en cada archivo.

No necesitas memorizar este esquema ahora. Lo iremos recorriendo capítulo a capítulo.

---

## 7. El ciclo de trabajo diario en la aplicación

Con GitHub Desktop, el trabajo habitual sigue siempre el mismo ciclo.

```text
Clonar el repositorio
        │
        ▼
Modificar archivos
        │
        ▼
Ver los cambios en "Local Changes"
        │
        ▼
Escribir el resumen y hacer commit
        │
        ▼
Hacer push a GitHub
        │
        ▼
Hacer pull antes de seguir trabajando
        │
        └──────────────────────────────► (se repite el ciclo)
```

Cada paso corresponde a un capítulo de esta sección:

* Clonar: capítulo 04;
* Modificar archivos: capítulo 05;
* Ver los cambios: capítulo 06;
* Hacer un commit: capítulo 07;
* Hacer push: capítulo 08;
* Hacer pull: capítulo 09;
* Trabajar con ramas: capítulo 10.

Cuando internalices este ciclo, podrás reconocer en cualquier momento en qué punto del proceso estás y qué botón debes pulsar.

---

## 8. Qué incluye GitHub Desktop

Aunque parece un programa sencillo, por dentro contiene varios componentes.

```text
GitHub Desktop
     │
     ├── Interfaz gráfica (paneles, botones y listas)
     ├── Copia de Git integrada (el motor que realiza el trabajo)
     ├── Autenticación con tu cuenta de GitHub
     └── Ajustes de configuración (editor, comportamiento de Git, etc.)
```

El detalle más importante es la **copia de Git integrada**.

En Windows, GitHub Desktop incluye una copia de Git (un Git portátil). Eso significa que, al instalar la aplicación, ya puedes clonar, hacer commits y enviar cambios sin instalar Git por separado.

En macOS, utiliza el Git del sistema.

Lo que esa copia de Git hace por ti:

* Guarda el historial de cada proyecto en una carpeta oculta llamada `.git`;
* Compara la versión actual de los archivos con la última versión registrada;
* Envía y recibe commits hacia y desde el repositorio remoto.

No tienes que tocar nada de esto: la aplicación lo gestiona.

Pero es bueno saber que existe, porque más adelante, cuando estudies Git en la terminal, te darás cuenta de que estás usando exactamente el mismo motor.

El resto de componentes también importan:

* La autenticación guarda de forma segura cómo accedes a tu cuenta de GitHub;
* Los ajustes te permiten, por ejemplo, elegir el editor externo con el que se abren los archivos y cambiar el comportamiento de las operaciones de pull.

---

## 9. Botones, comandos y resultados

Para cerrar el recorrido conceptual, repasemos la correspondencia entre los botones principales y los comandos de Git.

| Botón o panel              | Qué hace                        | Comando equivalente            |
|----------------------------|---------------------------------|--------------------------------|
| File → Clone repository    | Descarga una copia local        | `git clone`                    |
| "Commit to [rama]"         | Registra los cambios locales    | `git add` + `git commit`       |
| "Push origin"              | Envía commits a GitHub          | `git push`                     |
| "Pull origin"              | Recibe y combina cambios remotos| `git fetch` + `git merge`      |
| Desplegable "Current Branch" | Crea y cambia de rama         | `git checkout` / `git switch`  |

El patrón se repite siempre:

```text
Botón (visual)   →   Comando (Git)   →   Resultado (el repositorio cambia)
```

No se trata de memorizar la tabla, sino de habituarse a la idea de que **la interfaz es solo la capa de encima** y que debajo hay un Git real realizando operaciones reales.

Esa visión te permitirá entender los mensajes de error, interpretar el historial y, cuando llegues a la terminal, avanzar sin sensación de estar empezando de cero.

---

## 10. Limitaciones: qué no es GitHub Desktop

Para terminar, conviene dejar claras algunas cosas que la aplicación **no** hace.

* No edita los archivos por ti: para modificar el contenido necesitas un editor de texto;
* No es un servicio de archivos en la nube: no sincroniza carpetas al azar, solo el repositorio abierto;
* No ejecuta el código de tu proyecto: no tiene un entorno de desarrollo integrado;
* No gestiona los detalles de tu cuenta (contraseñas, organizaciones, configuraciones avanzadas): eso se hace en la web;
* No sustituye a Git en las operaciones avanzadas: algunas tareas siguen pidiendo terminal.

Es una herramienta de trabajo diario, no una caja de todo.

Saber qué no hace evita malentendidos, sobre todo al principio.

---

## Práctica guiada

En esta práctica vas a explorar GitHub Desktop desde la web, sin instalarlo todavía.

### Objetivo

Reconocer la aplicación oficial y su interfaz antes de instalarla, para que en los siguientes capítulos sepas qué esperar.

### Paso 1: visita la página oficial

Abre tu navegador y ve a:

```text
https://desktop.github.com
```

Fíjate en que el dominio es `desktop.github.com`, un subdominio de GitHub. Eso confirma que es la página oficial.

### Paso 2: observa las capturas de la interfaz

La página muestra imágenes de la aplicación en funcionamiento. Localiza en esas imágenes:

* La lista de repositorios en el panel izquierdo;
* El panel "Local Changes" con la caja de resumen y el botón "Commit to ...";
* Los botones "Pull origin" y "Push origin" en la parte superior derecha;
* El desplegable "Current Branch" con el nombre de la rama.

### Paso 3: revisa las opciones de descarga

Verás botones para descargar la versión para Windows y la versión para macOS. Comprueba cuál corresponde a tu sistema, pero todavía no descargues nada.

### Paso 4: identifica el tipo de programa

Comprueba que se trata de un programa de escritorio (archivo instalador), no de una extensión de navegador ni de una página web.

### Resultado esperado

Deberías poder señalar en la página oficial:

* dónde se descarga la aplicación;
* qué versiones existen;
* qué botones y paneles se distinguen en las capturas.

---

## Errores comunes

### Error 1: pensar que GitHub Desktop es lo mismo que la web

La aplicación y la web son complementos, no sustitutos. La web administra la cuenta y la colaboración; la aplicación gestiona el trabajo local. Necesitarás ambas.

### Error 2: descargar la aplicación desde páginas no oficiales

Solo descárguela desde `desktop.github.com` o desde el enlace oficial en `github.com`. Otras páginas pueden ofrecer versiones modificadas o maliciosas.

### Error 3: creer que al instalar la aplicación ya se aprendió Git

La aplicación incluye Git, pero no enseña Git. En las secciones 06 y 07 estudiarás el motor por dentro y comprenderás qué hace cada comando.

### Error 4: confundir la aplicación con un sincronizador de archivos

GitHub Desktop no sincroniza carpetas como OneDrive o Dropbox. Gestiona el historial de un repositorio Git, que es una operación muy diferente.

### Error 5: no saber qué comando realiza cada botón

Si no conoces la equivalencia entre botón y comando, los mensajes de error resultan incomprensibles. Por eso en cada capítulo de esta sección se muestra el comando correspondiente.

### Error 6: esperar que la aplicación corrijan los errores del historial

Si un commit está mal, la aplicación no lo deshace sola. Más adelante, en la sección 11, estudiarás las formas correctas de corregir el historial.

---

## Buenas prácticas

* Descarga siempre la aplicación desde la página oficial, `desktop.github.com`;
* Mantén la aplicación actualizada a la versión más reciente;
* Usa la aplicación para el trabajo diario y la web para la colaboración y la configuración;
* Cada vez que veas un botón, pregúntate qué comando de Git está ejecutando;
* Estudia esta sección en orden: cada capítulo prepara al siguiente;
* No intentes combinar la aplicación con la terminal hasta que termines la sección 09.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es GitHub Desktop y quién lo desarrolla;
* para qué perfiles de usuario resulta útil y para cuáles no;
* en qué se diferencia de la web de GitHub;
* en qué se diferencia de Git por línea de comandos;
* qué significa que incluya una copia de Git en su interior;
* qué botones principales tiene y qué comando ejecuta cada uno;
* por qué la aplicación y la web se complementan.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* GitHub Desktop es una aplicación de escritorio gratuita desarrollada por GitHub;
* es una herramienta oficial, disponible para Windows y macOS;
* sirve como alternativa visual a la terminal, pero utiliza el mismo Git por debajo;
* incluye una copia de Git integrada, por lo que en Windows no hace falta instalarla por separado;
* se diferencia de la web: la web administra la cuenta y la colaboración, la aplicación gestiona el trabajo local;
* su ventana principal contiene la lista de repositorios, "Local Changes", "History", "Current Branch" y los botones "Pull origin" y "Push origin";
* cada botón corresponde a uno o varios comandos de Git: `git clone`, `git add`, `git commit`, `git push`, `git pull`, `git checkout`.

La idea principal es:

> **GitHub Desktop es la capa visual que te permite clonar, modificar, registrar y mover commits sin escribir comandos.**

---

## Próximo paso

Ya sabes qué es GitHub Desktop y qué rol juega entre la web y la terminal. El siguiente paso es instalarla en tu computadora.

Continúa con:

[`02-instalar-github-desktop.md`](02-instalar-github-desktop.md)
