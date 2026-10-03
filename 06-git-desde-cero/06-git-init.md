# git init

## Introducción

En el capítulo anterior viste que `git init` crea un repositorio en una carpeta.

Ahora vas a estudiar ese comando en detalle: qué hace exactamente, qué estructura crea y qué opciones tiene.

Este es el primer comando de Git que dominarás, porque con él empieza todo.

En este capítulo aprenderás:

* qué hace exactamente `git init`;
* cuál es su sintaxis básica y sus opciones principales;
* qué estructura crea dentro de la carpeta `.git`;
* qué contiene cada una de esas piezas (`objects`, `refs`, `HEAD`, `config`);
* qué pasa si lo ejecutas en una carpeta que ya tiene archivos;
* cómo deshacerlo o modificarlo;
* qué revisar después de ejecutarlo.

Este capítulo usa la terminal. Vas a crear repositorios y examinar su estructura.

---

## 1. Qué hace este comando

`git init` **inicializa un nuevo repositorio Git** en una carpeta.

No crea archivos propios de tu proyecto.

No modifica el contenido que ya exista.

Solo añade la estructura interna que Git necesita para comenzar a registrar versiones.

Después de `git init`, la carpeta deja de ser una carpeta común y pasa a ser un repositorio Git.

---

## 2. Sintaxis básica

La forma más sencilla es:

```bash
git init
```

Esto inicializa el directorio actual.

También puedes indicar un nombre de carpeta:

```bash
git init nombre-carpeta
```

Git creará esa carpeta (si no existe) y la inicializará.

### 2.1. Opciones principales

#### Cambiar la rama inicial

Por defecto, Git crea una rama inicial llamada `main` (en versiones recientes).

Si quieres otra rama inicial, usa:

```bash
git init -b mi-rama
```

o:

```bash
git init --initial-branch=mi-rama
```

Eso es útil si en tu equipo usan `master` u otro nombre por convención.

#### Modo silencioso

Para no mostrar el mensaje de confirmación:

```bash
git init -q
```

o:

```bash
git init --quiet
```

Útil en scripts, pero para aprender es mejor ver la salida normal.

#### Repositorio sin directorio de trabajo

Existe la opción `--bare`, que crea un repositorio **sin** directorio de trabajo:

```bash
git init --bare nombre
```

Esto crea solo la estructura `.git`, sin archivos visibles.

Es un concepto avanzado que verás más adelante. Por ahora, ignóralo.

---

## 3. Ejemplo paso a paso

Vamos a crear un repositorio desde cero.

Paso 1: crea una carpeta de práctica.

```bash
mkdir repo-prueba
```

Paso 2: entra en ella.

```bash
cd repo-prueba
```

Paso 3: inicializa Git.

```bash
git init
```

Paso 4: observa la salida.

Verás algo como:

```text
Initialized empty Git repository in C:/Users/TuNombre/repo-prueba/.git/
```

Ese mensaje confirma dos cosas:

* que el repositorio se creó vacío (sin commits todavía);
* que la carpeta `.git` quedó en el directorio indicado.

### 3.1. Ejemplo con rama inicial propia

Si quieres que la rama inicial se llame `desarrollo`:

```bash
git init -b desarrollo
```

La salida será similar:

```text
Initialized empty Git repository in C:/Users/TuNombre/repo-prueba/.git/
```

Pero ahora la rama por defecto será `desarrollo` en lugar de `main`.

---

## 4. Qué crea exactamente

La parte más importante es entender qué estructura aparece.

Después de `git init`, la carpeta `.git` contiene, entre otras cosas:

```text
.git/
   ├── objects/
   ├── refs/
   ├── HEAD
   ├── config
   ├── description
   ├── info/
   └── hooks/
```

### 4.1. `objects/`

Aquí se guardan los **objetos** de Git.

Un objeto puede ser el contenido de un archivo, un commit o la estructura de un árbol de archivos.

Por ahora, esta carpeta está vacía o casi vacía, porque aún no hay commits.

Cuando hagas commits, aquí aparecerán los datos de Git.

### 4.2. `refs/`

Aquí viven las **referencias**, que son apuntes a commits concretos.

La subcarpeta más importante es `refs/heads/`, donde se guardan las ramas.

Al inicio, aún no hay ramas creadas con commits, por lo que estará vacía.

### 4.3. `HEAD`

Es un archivo que apunta a **tu posición actual** en el repositorio.

Por defecto, apunta a la rama inicial (por ejemplo `refs/heads/main`).

Es decir, `HEAD` te dice: "estás trabajando sobre la rama main".

### 4.4. `config`

Es el archivo de **configuración local** del repositorio.

Guarda ajustes que aplican solo a este repositorio.

Recuerda: la configuración local tiene prioridad sobre la global.

### 4.5. `description` y `hooks/`

`description` contiene una descripción del repositorio.

`hooks/` contiene scripts que Git puede ejecutar en ciertos momentos (como al hacer un commit).

Por ahora son irrelevantes, pero conviene saber que existen.

---

## 5. Inicializar una carpeta que ya tiene contenido

Es muy común querer versionar una carpeta que ya tiene archivos.

`git init` funciona igual en ese caso.

Por ejemplo, imagina que tienes una carpeta `mi-proyecto` con archivos:

```text
mi-proyecto/
   ├── nota.txt
   └── imagen.png
```

Puedes hacer:

```bash
cd mi-proyecto
git init
```

Git añadirá la carpeta `.git` sin tocar tus archivos.

Después podrás empezar a registrar versiones de esos archivos con los comandos que verás en los próximos capítulos.

La clave: **`git init` no modifica ni borra nada de lo que ya exista**.

Solo añade su estructura.

---

## 6. Borrar o modificar el `init`

A veces quieres deshacer la inicialización.

### 6.1. Borrar el repositorio

Para deshacer `git init`, basta con **borrar la carpeta `.git`**.

Al hacer eso, la carpeta deja de ser un repositorio Git.

Tus archivos propios se conservan.

En Windows:

```bash
rmdir /s /q .git
```

o borra la carpeta desde el explorador.

En entornos de tipo Unix:

```bash
rm -rf .git
```

Ten mucho cuidado: borrar `.git` elimina todo el historial del repositorio.

### 6.2. Cambiar la rama inicial

Si ya inicializaste y quieres cambiar la rama inicial, puedes usar:

```bash
git branch -m main desarrollo
```

Eso renombra la rama actual de `main` a `desarrollo`.

O simplemente usar `git init -b nombre` desde el principio.

### 6.3. Una advertencia

No uses `rm -rf .git` en un repositorio donde ya hay commits importantes.

Borrar `.git` es irreversible: pierdes el historial completo.

Si tienes dudas, mejor no lo hagas.

---

## 7. Qué revisar después de ejecutarlo

Después de `git init`, revisa siempre:

* que la salida dice "Initialized empty Git repository";
* que la carpeta `.git` existe en el directorio;
* que la rama inicial es la que esperabas;
* que `git status` reconoce el directorio como repositorio;
* que tus archivos originales siguen intactos.

Un comando útil para ver la rama actual es:

```bash
git branch
```

Si ya hay una rama, la verás marcada con un `*`.

---

## 8. Errores típicos de `git init`

### 8.1. Ejecutarlo en el lugar equivocado

Si no estás en la carpeta que crees, inicializarás Git en otra parte.

Confirma siempre el indicador antes de ejecutar.

### 8.2. Creer que `git init` sube a internet

No. `git init` es 100% local. No contacta con ningún servidor.

### 8.3. Confundir `git init` con `git clone`

`git init` crea un repositorio vacío. `git clone` copia uno existente con su historial.

### 8.4. Borrar `.git` sin querer

Borrar `.git` elimina el historial. Si haces commits importantes, no borres esa carpeta.

---

## Práctica guiada

En esta práctica vas a crear un repositorio y examinar su estructura.

### Paso 1: crea una carpeta

```bash
mkdir repo-estudio
cd repo-estudio
```

### Paso 2: inicializa Git

```bash
git init
```

Anota la salida.

### Paso 3: mira la estructura `.git`

Lista el contenido de `.git`:

```bash
ls .git
```

o, en Windows:

```bash
dir .git
```

Deberías ver `objects`, `refs`, `HEAD`, `config`, entre otros.

### Paso 4: confirma el estado

```bash
git status
```

Confirma que Git reconoce el repositorio.

### Paso 5: repite con una rama inicial propia

Crea otra carpeta y usa:

```bash
git init -b desarrollo
```

Confirma que la rama inicial es `desarrollo`.

### Resultado esperado

Deberías poder:

* inicializar un repositorio;
* identificar las piezas de `.git`;
* crear una rama inicial personalizada;
* saber cómo deshacer la inicialización.

---

## Errores comunes

### Error 1: no saber en qué carpeta estás

`git init` inicializa el directorio actual. Si el indicador no muestra la carpeta correcta, el repositorio se crea en el lugar equivocado.

### Error 2: pensar que `git init` requiere internet

No. Es una operación completamente local.

### Error 3: borrar `.git` para "reiniciar"

Borrar `.git` elimina el historial. Si quieres empezar de cero, es mejor crear una carpeta nueva y hacer `git init` allí.

### Error 4: no ver `.git` y creer que no se creó

Las carpetas ocultas no se ven por defecto en Windows. Activa la opción de mostrarlas.

### Error 5: usar `--bare` sin entenderlo

`--bare` crea un repositorio sin directorio de trabajo. Es un concepto avanzado; úsalo solo cuando lo comprendas.

---

## Buenas prácticas

* Confirma el directorio actual antes de ejecutar `git init`.
* Usa `-b` para fijar la rama inicial si tu equipo usa otro nombre que `main`.
* Examina la estructura `.git` una vez para entender qué hay dentro.
* No edites ni borres `.git` a menos que sepas exactamente lo que haces.
* Recuerda que `git init` no toca tus archivos: solo añade la estructura.
* Revisa siempre `git status` después de inicializar.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué hace exactamente `git init`;
* cuál es su sintaxis y sus opciones (`-b`, `-q`, `--bare`);
* qué estructura crea dentro de `.git`;
* qué son `objects`, `refs`, `HEAD` y `config`;
* qué pasa si inicializas una carpeta con archivos;
* cómo deshacer la inicialización y sus riesgos;
* qué revisar después de ejecutar el comando.

Si alguna respuesta no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* `git init` crea un repositorio Git en una carpeta;
* no modifica ni borra los archivos existentes;
* crea una carpeta `.git` con `objects`, `refs`, `HEAD` y `config`;
* `objects` guardará los datos de Git, `refs` las ramas, `HEAD` tu posición actual y `config` la configuración local;
* puedes fijar la rama inicial con `-b`;
* inicializar una carpeta con contenido es seguro y muy común;
* borrar `.git` deshace el `init` pero elimina el historial.

La idea principal es:

> **`git init` convierte una carpeta en un repositorio Git añadiendo la estructura `.git`; no toca tus archivos y es el punto de partida de todo proyecto local.**

---

## Próximo paso

Ya sabes qué crea `git init`.

El siguiente paso es aprender a ver el estado del repositorio con `git status`, el comando que usarás una y otra vez.

Continúa con:

[`07-git-status.md`](07-git-status.md)
