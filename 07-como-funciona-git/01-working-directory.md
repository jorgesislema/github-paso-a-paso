# Working Directory (directorio de trabajo)

## Introducción

En la sección anterior aprendiste a usar Git desde fuera: creaste un repositorio, registraste cambios y observaste el historial con `git log`.

Ahora es el momento de mirar por dentro: vamos a estudiar qué manipula realmente Git cuando ejecutas cada comando.

La primera parada es el **directorio de trabajo** (*working directory*), una de las tres áreas fundamentales de Git.

La buena noticia es que ya lo conoces bien: es la carpeta de tu proyecto, el lugar donde viven tus archivos.

En este capítulo aprenderás:

* qué es el directorio de trabajo y dónde vive;
* la diferencia entre un archivo que Git no rastrea y uno que sí rastrea;
* las operaciones que realizas en esta área (crear, editar, borrar, mover);
* la relación entre esta carpeta y la carpeta `.git`;
* cómo refleja `git status` el estado del directorio de trabajo;
* dónde encaja esta área en el modelo de tres áreas de Git.

No necesitas conocimientos nuevos: solo lo que ya sabes de la sección 06.

---

## 1. Una primera explicación

Tu proyecto vive en una carpeta.

Dentro de esa carpeta tienes archivos: texto, código, imágenes o lo que tu proyecto necesite.

```text
mi-proyecto/
├── README.md
├── programa.py
└── notas.txt
```

Cuando abres un editor y modificas uno de esos archivos, estás trabajando en el directorio de trabajo.

Cuando creas un archivo nuevo en esa carpeta, también estás trabajando en el directorio de trabajo.

Dicho de otra forma: el directorio de trabajo es el lugar donde tu proyecto existe y cambia, momento a momento.

```text
Tú (editor, IDE, explorador de archivos)
                │
                ▼
   Directorio de trabajo (carpeta de tu proyecto)
```

Todo lo que haces con herramientas normales ocurre aquí: no necesitas Git para modificar un archivo.

El trabajo de Git comienza cuando le pides que preste atención a esos cambios.

---

## 2. Definición técnica

El **directorio de trabajo** es la copia completa de los archivos del proyecto que vive en tu computadora.

Es donde lees y escribes los archivos en su estado actual.

Un repositorio tiene tres áreas principales:

```text
Directorio de trabajo      Área de preparación      Repositorio local
(working directory)        (staging area)           (repository)
lo que editas              lo que vas a registrar   lo ya registrado
```

El directorio de trabajo es la primera de las tres.

Es el único lugar donde puedes modificar archivos directamente.

Las otras dos áreas son internas de Git y se manipulan con comandos.

### Dónde vive

El directorio de trabajo es la carpeta que contiene la carpeta `.git`.

```text
C:\proyectos\mi-proyecto\      ← directorio de trabajo
├── .git\                      ← historial y datos internos
├── README.md
└── programa.py
```

Si ejecutas un comando de Git desde una subcarpeta, Git busca hacia arriba hasta encontrar `.git`.

Esa carpeta donde está `.git` es la raíz de tu directorio de trabajo.

Los comandos de Git solo funcionan dentro de un repositorio, es decir, dentro de esta estructura.

---

## 3. Los estados de los archivos

Git puede describir cada archivo del directorio de trabajo con uno de tres estados.

```text
Estados posibles de un archivo
├── No rastreado: Git nunca lo ha registrado
├── Sin cambios: coincide con la versión registrada
└── Modificado: difiere de la versión registrada
```

### No rastreado

Un archivo es **no rastreado** cuando existe en la carpeta pero nunca ha entrado en ningún commit.

```text
mi-proyecto/
├── README.md      (rastreado)
└── borrador.txt   (no rastreado)
```

Para Git, `borrador.txt` es un archivo de cuyo existencia está al tanto, pero del cual no guarda ninguna versión.

### Sin cambios

Un archivo está **sin cambios** cuando su contenido actual es idéntico al de la versión registrada.

```text
Archivo en disco  =  versión del último commit
```

En este estado, `git status` no menciona al archivo.

### Modificado

Un archivo está **modificado** cuando su contenido cambió respecto a la versión registrada.

```text
Archivo en disco  ≠  versión del último commit
```

Estos tres estados son exactamente los que describe `git status`.

---

## 4. Las operaciones que haces aquí

Todas las operaciones del directorio de trabajo se hacen con herramientas normales: editor de texto, IDE o explorador de archivos.

### Crear

Generas un archivo nuevo en la carpeta del proyecto.

Para Git, ese archivo aparece como no rastreado.

```text
Antes:            Después:
mi-proyecto/      mi-proyecto/
└── README.md     ├── README.md
                  └── idea.txt   (no rastreado)
```

### Editar

Abres un archivo y cambias su contenido.

Al guardar, el archivo en disco se actualiza.

Git puede detectar que el contenido difiere de la versión registrada: el archivo pasa a estado modificado.

```text
versión registrada (dentro de .git)
        ≠
versión en disco (directorio de trabajo)
```

### Borrar

Eliminas un archivo de la carpeta.

Si el archivo era rastreado, Git lo marca como borrado.

Si era no rastreado, simplemente deja de existir y no queda registro de él.

### Mover o renombrar

Mueves un archivo a otra subcarpeta o cambias su nombre.

Git lo interpreta como una combinación de borrado y creación.

Si el contenido es suficientemente parecido, Git lo detecta como un renombrado.

```text
notas.txt
    │
    ▼
documentos/notas.txt
```

En todos los casos vale la misma idea:

```text
Tú trabajas con herramientas normales
        │
        ▼
Git puede detectar qué cambió
        │
        ▼
Tú decides qué hacer con esos cambios
```

---

## 5. La relación con la carpeta .git

El directorio de trabajo y la carpeta `.git` viven uno junto al otro.

```text
mi-proyecto/
├── .git/
│   ├── HEAD
│   ├── config
│   ├── index
│   ├── objects/
│   └── refs/
├── README.md
└── programa.py
```

Los archivos visibles son tu trabajo: lo que lees y escribes cada día.

La carpeta `.git` guarda el historial: lo que ya se registró.

Juntas, ambas forman el repositorio local.

Una es el «presente» y la otra es la «memoria» del proyecto.

En Windows la carpeta `.git` suele aparecer como oculta, y en los demás sistemas su nombre empieza con punto, lo que también la oculta de muchas herramientas.

Por eso la carpeta que la contiene se reconoce como un repositorio.

En el capítulo 03 de esta sección estudiaremos el contenido de `.git` con detalle.

---

## 6. git status: el espejo del directorio de trabajo

El primer comando que debes ejecutar cuando no sabes qué está pasando es:

```bash
git status
```

Compara el directorio de trabajo con el área de preparación y con el último commit.

El resultado describe en qué estado está cada archivo.

### Ejemplo de salida

```text
On branch main
Changes not staged for commit:
  modified:   programa.py

Untracked files:
  idea.txt

nothing added to commit (use "git add"…)
```

La primera sección lista los cambios ya preparados en el área de preparación.

La segunda lista los cambios que existen en el directorio de trabajo pero aún no están preparados.

La tercera lista los archivos que Git no está rastreando todavía.

Cuando todo está sincronizado verás algo como:

```text
nothing to commit, working tree clean
```

Si sabes leer `git status`, sabes leer el estado del directorio de trabajo.

---

## 7. Archivos no rastreados: fuera del control de versiones

Los archivos no rastreados no tienen historial.

Si los borras del disco, no queda ningún registro de ellos.

```text
borrador.txt (no rastreado)
        │
        ▼
lo borras del disco
        │
        ▼
desaparece, sin dejar rastro
```

Esto es lo opuesto a un archivo rastreado, que siempre conserva su historial en el repositorio.

Casos habituales de archivos no rastreados:

* borradores sobre los que aún no decides;
* archivos generados por tus herramientas;
* notas personales que no quieres registrar;
* archivos que eventualmente formarán parte del proyecto.

En algún momento tomarás una decisión: registrarlos (con `git add` y un commit) o dejarlos fuera.

En la sección 13 estudiaremos los archivos que se excluyen de forma intencional con `.gitignore`, pero por ahora basta con saber que un archivo no rastreado es un archivo del que Git está al tanto pero que no ha registrado todavía.

---

## 8. Archivos modificados

Cuando modificas un archivo rastreado, Git compara dos versiones.

```text
versión del último commit (dentro de .git)
        contra
versión en disco (directorio de trabajo)
```

Si difieren, el archivo está modificado.

```text
Último commit:  «La reunión será el lunes.»
En disco:       «La reunión será el martes.»
        ⇒ modificado
```

Puedes modificar el archivo las veces que quieras.

El directorio de trabajo siempre refleja el estado más reciente, y Git compara ese estado contra el registrado.

Cuando registras un commit, el nuevo contenido pasa a ser la versión de referencia.

Para ver la diferencia en detalle, Git ofrece:

```bash
git diff
```

En este capítulo lo usamos solo como apoyo para comprobar qué cambió antes de registrar.

El estudio en detalle de `git diff` se hace en la sección 06.

---

## 9. Archivos borrados

Cuando borras un archivo rastreado del directorio de trabajo, Git lo marca como borrado.

```bash
git status
```

```text
Changes not staged for commit:
  deleted:    archivo.txt
```

El archivo ya no está en disco, pero su historial sigue en el repositorio.

Por eso puedes recuperarlo:

```bash
git restore archivo.txt
```

Este comando copia la versión registrada de vuelta al directorio de trabajo.

```text
directorio de trabajo (archivo ausente)
        ▲
        │
        │ git restore
        │
repositorio local (la versión registrada)
```

La diferencia con los archivos no rastreados es clara: para un archivo rastreado siempre existe una versión a la que volver.

Borrar un archivo rastreado no borra su pasado.

---

## 10. El primero de tres áreas

Para situar el directorio de trabajo en el panorama completo, conviene ver las tres áreas.

```text
Directorio de trabajo       Área de preparación     Repositorio local
mi-proyecto/                .git/index              .git/objects
 (tus archivos)            (el index)              (historial y objetos)
      │                          │                       │
      │  git add                 │  git commit           │
      └─────────────────────────►└──────────────────────►│
```

Cada área responde a una pregunta diferente:

```text
Directorio de trabajo:  ¿en qué estoy trabajando ahora?
Área de preparación:    ¿qué estoy a punto de registrar?
Repositorio local:      ¿qué ya quedó registrado?
```

Los comandos que ya conoces mueven elementos entre áreas:

```text
git add       mueve cambios seleccionados del directorio de trabajo al index
git commit    convierte el index completo en un commit
git restore   devuelve archivos del directorio de trabajo a su versión registrada
```

En este capítulo nos concentramos en la primera área.

Las otras dos tendrán sus propios capítulos: el 02 para el index y el 03 para el repositorio local.

---

## 11. Qué no pasa con tu directorio de trabajo al hacer commit

Una confusión frecuente es pensar que, al ejecutar `git commit`, los archivos «se meten» dentro de `.git`.

Eso no ocurre.

El directorio de trabajo sigue intacto, exactamente donde estaba.

```text
Antes del commit:
mi-proyecto/
├── .git/
└── README.md

Después del commit:
mi-proyecto/
├── .git/       ← se registró una versión de README.md
└── README.md   ← el mismo archivo, disponible para seguir editando
```

Lo que queda registrado es el contenido de ese momento.

A partir de entonces, el directorio de trabajo y el historial son dos cosas que evolucionan por separado.

Si modificas el archivo de nuevo, volverá a diferir de la versión registrada.

El directorio de trabajo siempre está disponible para trabajar; el historial solo sirve como referencia.

---

## 12. Dos personas, dos directorios de trabajo

Cada persona que trabaja en el proyecto tiene su propio directorio de trabajo.

```text
Computadora de Ana                    Computadora de Luis
┌─────────────────────────────┐        ┌─────────────────────────────┐
│ C:\proyectos\mi-proyecto    │        │ /home/luis/mi-proyecto      │
│ ├── .git/                   │        │ ├── .git/                   │
│ └── programa.py             │        │ └── programa.py             │
└─────────────────────────────┘        └─────────────────────────────┘
```

El directorio de trabajo de Ana solo existe en la computadora de Ana.

El de Luis, solo en la de Luis: cada quien tiene sus archivos y su propia carpeta `.git`.

Por eso un repositorio local, por sí solo, no alcanza para trabajar en equipo.

En los próximos capítulos veremos cómo se sincronizan copias a través de un repositorio remoto.

Por ahora, basta con entender que el directorio de trabajo es personal, local y el punto donde comienza el trabajo.

---

## Práctica guiada

En esta práctica vas a observar los estados del directorio de trabajo sin salir de él.

Todas las operaciones se hacen dentro de una carpeta de práctica.

### Objetivo

Reconocer los tres estados de un archivo: no rastreado, modificado y sincronizado.

### Paso 1: crea la carpeta y el repositorio

Crea una carpeta llamada `practica-working` e inicializa un repositorio:

```bash
mkdir practica-working
cd practica-working
git init -b main
```

### Paso 2: observa el estado vacío

```bash
git status
```

Git te indica que aún no hay commits y que puedes empezar a crear archivos.

### Paso 3: crea tu primer archivo

Dentro de la carpeta, crea un archivo llamado `notas.txt` con este contenido:

```text
Mi primera nota de trabajo.
```

Ejecuta `git status` de nuevo.

El archivo aparece en la sección `Untracked files`.

```text
Untracked files:
  notas.txt
```

### Paso 4: registra el archivo

```bash
git add notas.txt
git commit -m "Agregar notas.txt"
git status
```

Ahora el directorio de trabajo está limpio: el archivo existe y su contenido está registrado.

### Paso 5: modifica el archivo

Abre `notas.txt` y agrega una segunda línea:

```text
Mi primera nota de trabajo.
Esta nota tiene dos lineas.
```

Guarda y ejecuta `git status`.

El archivo aparece en la sección `Changes not staged for commit`.

### Paso 6: crea un borrador y bórralo

Crea un archivo llamado `borrador.txt` con cualquier contenido y observa `git status`: aparece como no rastreado.

Borra `borrador.txt` de la carpeta y ejecuta `git status` otra vez.

El archivo simplemente deja de figurar: como nunca se registró, no deja rastro.

### Resultado esperado

Deberías tener un archivo, `notas.txt`, con cambios registrados que aún no están en ningún commit:

```text
On branch main
Changes not staged for commit:
  modified:   notas.txt
```

### Preguntas para comprobar

* ¿Qué estado tenía `notas.txt` antes del primer commit?
* ¿Qué estado tiene después?
* ¿Por qué `borrador.txt` no deja rastro cuando se borra?

---

## Errores comunes

Error 1: confundir el directorio de trabajo con `.git`.

El directorio de trabajo es donde viven tus archivos. La carpeta `.git` es donde vive el historial. Están juntos en la misma carpeta, pero no son lo mismo.

Error 2: creer que guardar un archivo lo pone en el historial.

Guardar escribe el nuevo contenido en disco. El archivo solo entra al historial cuando ejecutas `git add` y `git commit`.

Error 3: borrar un archivo rastreado y creer que se borró su historial.

El historial está en `.git`, no en el disco. Siempre puedes recuperar una versión registrada.

Error 4: ejecutar comandos de Git en una carpeta que no es un repositorio.

Verás el error `not a git repository`. Inicia el repositorio con `git init` en la carpeta correcta o entra a donde está tu proyecto.

Error 5: confundir «no rastreado» con «ignorado».

Los archivos no rastreado sí aparecen en `git status`. Los archivos ignorados (con `.gitignore`) ni siquiera aparecen. Veremos esa diferencia en detalle en la sección 13.

Error 6: no ejecutar `git status` antes de un commit.

Sin revisar el estado puedes registrar cambios que no conocías. Hábito básico: mira el estado antes de actuar.

---

## Buenas prácticas

* Ejecuta `git status` con frecuencia, sobre todo cuando no sabes qué está pasando.
* Antes de borrar un archivo, verifica si es rastreado o no rastreado.
* Mantén tus borradores donde puedas reconocerlos, o déjalos no rastreados hasta decidir.
* Lee la salida de `git status` sección por sección; cada una dice algo distinto.
* Recuerda que el directorio de trabajo es tu espacio de trabajo: el historial solo es referencia.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es el directorio de trabajo y dónde vive;
* la diferencia entre un archivo no rastreado, uno modificado y uno sincronizado;
* qué operaciones haces en esta área y con qué herramientas;
* qué papel juega `.git` respecto a los archivos que ves;
* qué te dice `git status` sobre cada uno de los tres estados;
* por qué borrar un archivo no rastreado no deja rastro;
* por qué al hacer un commit los archivos no «se meten» dentro de `.git`.

Si alguna respuesta no te sale clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* el directorio de trabajo es la carpeta del proyecto donde viven tus archivos;
* es el único lugar donde puedes modificar archivos directamente;
* los archivos pueden estar no rastreados, sin cambios o modificados;
* las operaciones de crear, editar y borrar se hacen con herramientas normales;
* la carpeta `.git` vive dentro de esa misma carpeta y guarda el historial;
* `git status` muestra el estado del directorio de trabajo frente al último commit;
* los archivos no rastreados no tienen historial y desaparecen sin rastro si se borran;
* al hacer un commit se registra el contenido, pero el directorio de trabajo sigue intacto;
* cada persona tiene su propio directorio de trabajo en su propia máquina.

La idea principal es:

> **El directorio de trabajo es donde trabajas: tus archivos, que puedes tocar. El historial vive en .git y solo avanza cuando registras cambios.**

---

## Próximo paso

Ya conoces la primera de las tres áreas. La siguiente es el área de preparación, donde decides exactamente qué entra en el próximo commit.

Continúa con:

[`02-staging-area.md`](02-staging-area.md)
