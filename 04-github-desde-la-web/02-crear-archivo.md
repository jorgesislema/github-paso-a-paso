# Crear un archivo

## Introducción

En el capítulo anterior creaste tu primer repositorio y ya viste su página con el archivo `README.md`.

Ahora vas a aprender a **añadir un archivo nuevo** a ese repositorio, completamente desde el navegador.

Esto significa que no necesitas instalar nada: escribes el contenido, le pones un nombre y lo guardas con un commit.

En este capítulo aprenderás:

* dónde está el botón «Add file» dentro de un repositorio;
* cómo se abre la opción «Create new file»;
* qué es el editor web de GitHub y cómo se usa;
* cómo se escribe el nombre del archivo y su extensión;
* qué es el mensaje de commit y para qué sirve;
* qué significa «Commit changes» y qué ocurre por detrás;
* cómo elegir entre guardar directamente en `main` o crear una rama nueva;
* cómo se ve el archivo nuevo en el repositorio después de guardarlo.

Si recuerdas lo que es un commit (un registro de un estado del proyecto), este capítulo te resultará muy natural.

## 1. El botón «Add file»

Entra en tu repositorio y asegúrate de estar en la pestaña **«Code»**.

En la parte superior de la lista de archivos verás una fila de botones.

```text
Fila de botones de la pestaña Code
    │
    ├── [ main ▾ ]            ← Selector de rama
    ├── [ Clone ▾ ]           ← Copiar la dirección del repositorio
    ├── [ Add file ▾ ]        ← El botón que nos interesa
    └── [ Web IDE ]           ← Editor más grande para varios cambios
```

El botón **«Add file»** es un desplegable con dos opciones:

```text
Menú «Add file»
    │
    ├── Create new file   ← Escribir un archivo desde cero
    └── Upload files      ← Subir archivos que ya tienes en tu computadora
```

En este capítulo usaremos **«Create new file»**.

## 2. La página «Create new file»

Al elegir «Create new file», GitHub abre una página de edición.

La parte superior muestra el nombre del repositorio, la rama (`main`) y un campo para el **nombre del archivo**.

```text
Página de creación de archivo
    │
    ├── Campo de nombre del archivo (arriba, a lo ancho)
    ├── Editor de texto (la zona grande del centro)
    ├── Opciones de commit (abajo a la izquierda)
    │   ├── Mensaje de commit
    │   ├── «Commit directly to the main branch.»
    │   └── «Create a new branch for this commit.»
    └── Botón [ Commit changes ]
```

El **editor de texto** es una zona grande con números de línea a la izquierda.

No hace falta saber programar para usarlo: funciona como un bloc de notas cualquiera.

Escribe en el primer campo el nombre del archivo, por ejemplo: `notas.md`.

## 3. El nombre del archivo y la extensión

El nombre del archivo se escribe en el campo de arriba del editor.

Recuerda lo que estudiaste sobre extensiones:

* `notas.md` es un archivo de texto en formato Markdown, que GitHub renderiza con formato;
* `notas.txt` es un archivo de texto plano;
* `leccion-01.md` o `receta-sopa.md` son ejemplos de nombres descriptivos.

Algunas reglas para el nombre:

* no uses espacios: mejor `leccion-01.md` que `leccion 01.md`;
* evita acentos y eñes para que el archivo sea fácil de referenciar más adelante;
* la extensión va después de un punto, sin espacios.

> **Nota:** si el archivo que creas lleva la extensión `.md`, GitHub lo mostrará renderizado: la primera línea `# Título` aparecerá como un encabezado grande, los asteriscos como viñetas, y así.

## 4. Escribir el contenido

Una vez que el nombre está bien, escribe el contenido dentro del editor.

Para practicar, crea un archivo llamado `saludo.md` con este contenido:

```text
# Mi primer archivo

Este es mi primer archivo creado en GitHub.

Lo escribí desde el navegador, sin instalar nada.
```

El editor tiene números de línea a la izquierda para que localices dónde estás.

Puedes escribir cuantas líneas necesites; el editor crece solo.

Si te equivocas, borra con retroceso o selecciona el texto y corrígelo, igual que en cualquier procesador de textos.

## 5. El mensaje de commit

Abajo del editor verás el bloque de **commit**.

El primer elemento es el **cuadro de mensaje de commit**, un campo de texto grande.

El mensaje de commit es la descripción de qué cambias y por qué.

GitHub te ofrece un mensaje sugerido entre paréntesis, por ejemplo: `(Create saludo.md)`.

Conviene reemplazarlo por algo descriptivo, como: `Añado el archivo de saludo inicial`.

Las pautas para buenos mensajes de commit las repasaremos con detalle en el capítulo 07.

Por ahora, ten presente dos ideas:

* el mensaje debería decir qué se está añadiendo o cambiando;
* un commit sin mensaje descriptivo es una oportunidad perdida para entender tu propio historial.

## 6. Dónde se guarda: main o rama nueva

Debajo del mensaje verás dos opciones de radio:

* **«Commit directly to the main branch.»**: guarda el commit directamente en la rama principal `main`.
* **«Create a new branch for this commit.»**: crea una rama nueva con el nombre que tú indiques y guarda el commit en esa rama.

Para los capítulos de esta sección, guarda **directamente en `main`**.

Las ramas se estudian en las secciones de Git y en el capítulo de GitHub Desktop.

## 7. Pulsar «Commit changes» y qué ocurre por detrás

Cuando el nombre, el contenido y el mensaje están listos, pulsa el botón **«Commit changes»**.

```text
Pulsas «Commit changes»
    │
    ▼
1. El navegador envía el contenido del archivo a los servidores de GitHub
    │
    ▼
2. GitHub guarda el contenido completo del archivo (un objeto nuevo)
    │
    ▼
3. Se crea un commit que contiene:
   - el archivo nuevo con su contenido
   - tu nombre de usuario y tu correo como autor
   - la fecha y hora
   - el mensaje de commit que escribiste
   - la referencia al commit anterior (tu README inicial)
    │
    ▼
4. La rama main avanza un paso: ahora apunta a este commit nuevo
    │
    ▼
5. GitHub te lleva de vuelta a la página del repositorio
```

De vuelta en el repositorio, verás el archivo nuevo en la lista de archivos, junto al `README.md`.

El archivo aparece con su nombre, el mensaje del último commit que lo tocó y la fecha.

## 8. Cómo se ve el archivo en el repositorio

Haz clic en el nombre del archivo dentro de la lista para abrirlo.

La página del archivo muestra:

* el nombre del archivo en la parte superior;
* botones de acción: **«Edit»** (icono de lápiz), **«Blame»**, **«History»** (icono de reloj) y opciones de copiar la URL;
* el contenido del archivo.

Si el archivo es `.md`, verás el contenido **renderizado**: con encabezados, listas y negritas.

Si prefieres ver el texto sin formato, haz clic en el enlace «Raw» o usa el botón «View raw file».

También puedes comprobar el historial del archivo pulsando el botón **«History»**: verás el commit que lo creó.

## 9. Nombres y ubicaciones que conviene recordar

Cuando crees archivos, piensa en su ubicación dentro del repositorio.

Por ahora todos tus archivos estarán en la raíz, es decir, directamente en la carpeta principal.

Más adelante verás cómo agruparlos en carpetas (por ejemplo, `images/` para imágenes o `docs/` para documentos).

Mientras tanto, una convención útil:

* los archivos de texto que quieres ver con formato llevan la extensión `.md`;
* los archivos de texto plano llevan la extensión `.txt`;
* los nombres son cortos, descriptivos y en minúsculas.

## Práctica guiada

En esta práctica vas a crear dos archivos nuevos en tu repositorio de práctica.

### Paso 1: crea el primer archivo

* entra en tu repositorio de práctica, pestaña «Code»;
* pulsa «Add file» y luego «Create new file»;
* en el campo de nombre escribe `saludo.md`;
* en el editor escribe tres líneas de texto, empezando por `# Mi primer archivo`;
* en el mensaje de commit escribe `Añado el archivo de saludo`;
* deja marcada «Commit directly to the main branch.»;
* pulsa «Commit changes».

### Paso 2: crea el segundo archivo

* vuelve a «Add file» → «Create new file»;
* en el campo de nombre escribe `nota.txt`;
* escribe una nota breve de una o dos líneas;
* escribe el mensaje `Añado una nota de texto plano`;
* pulsa «Commit changes».

### Paso 3: verifica el resultado

* en la lista de archivos, verifica que ves `README.md`, `saludo.md` y `nota.txt`;
* abre `saludo.md` y observa el contenido renderizado;
* pulsa el botón «History» del archivo y verifica que hay un commit con tu mensaje.

### Resultado esperado

Tu repositorio debería mostrar tres archivos y, al abrir cualquiera de ellos, ver su contenido con su historial disponible.

### Conclusión esperada

Al terminar deberías saber crear archivos desde la web, escribir contenido en el editor, redactar un mensaje de commit y verificar el resultado en la lista de archivos.

## Errores comunes

### Error 1: olvidar el nombre del archivo

Si pulsas «Commit changes» sin haber escrito el nombre, GitHub te mostrará un error pidiendo que lo completés.

Solución: escribe el nombre en el campo de arriba del editor y vuelve a pulsar «Commit changes».

### Error 2: repetir el nombre de un archivo existente

Si intentas crear `saludo.md` cuando ya existe, GitHub te avisará al pulsar «Commit changes» que el archivo ya existe.

Solución: elige un nombre distinto o borra el archivo anterior si de verdad quieres reemplazarlo.

### Error 3: usar espacios o acentos en el nombre

Un archivo llamado `Mi nota.txt` complica su referencia futura en enlaces y en el README.

Solución: usa guiones y solo letras en minúscula, por ejemplo `mi-nota.txt`.

### Error 4: dejar el mensaje de commit vacío

GitHub no permite guardar un commit sin mensaje: el botón quedará deshabilitado o se pedirá un mensaje.

Solución: escribe siempre al menos una frase que describa el cambio.

### Error 5: confundir «Commit changes» con cerrar la página

El botón «Commit changes» no es cerrar: es **guardar el cambio definitivamente** en el historial del repositorio.

Solución: antes de pulsarlo, revisa el nombre, el contenido y el mensaje.

### Error 6: escribir el contenido en el cuadro de mensaje

El cuadro de mensaje es para el mensaje de commit, no para el contenido del archivo.

Solución: el contenido va en el editor grande; el mensaje va abajo.

## Buenas prácticas

* Escribe siempre el nombre del archivo antes que el contenido;
* usa nombres cortos, descriptivos y sin espacios ni acentos;
* elige la extensión según el tipo de contenido: `.md` para ver con formato, `.txt` para texto plano;
* redacta un mensaje de commit que indique qué se añade, no solo el nombre del archivo;
* guarda en `main` mientras practicas en esta sección;
* después de cada commit, verifica el archivo en la lista y ábrelo para confirmar el contenido;
* revisa el mensaje en el historial («History») para asegurarte de que quedó claro.

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* dónde está el botón «Add file» y qué opciones contiene;
* qué partes tiene la página «Create new file»;
* cómo se escribe el nombre del archivo y qué reglas se aplican;
* cuál es la diferencia entre un archivo `.md` y un `.txt`;
* para qué sirve el mensaje de commit;
* qué significa «Commit directly to the main branch.»;
* qué ocurre por detrás cuando pulsas «Commit changes»;
* cómo se ve un archivo creado en la lista del repositorio;
* cómo se abre un archivo y qué botones tiene su página;
* cómo se diferencia el contenido renderizado del contenido sin formato.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

## Resumen

En este capítulo aprendiste que:

* el botón «Add file» de la pestaña «Code» tiene las opciones «Create new file» y «Upload files»;
* la página de creación tiene un campo de nombre, un editor y un bloque de commit;
* el nombre del archivo incluye su extensión y debe seguir ciertas reglas;
* el editor web es un espacio simple donde se escribe el contenido;
* el mensaje de commit describe qué se está añadiendo;
* «Commit changes» guarda el archivo, crea un commit y avanza la rama `main`;
* el archivo nuevo aparece en la lista y puede abrirse, editarse y tener su historial consultado;
* los archivos `.md` se ven renderizados y los `.txt` en texto plano.

La idea principal es:

> **Crear un archivo en GitHub desde la web consiste en ponerle nombre, escribir su contenido, describir el cambio con un mensaje y confirmar con «Commit changes».**

## Próximo paso

Ya sabes crear archivos nuevos en tu repositorio y entender qué ocurre con cada commit.

El siguiente paso es modificar un archivo existente: usarás el botón del lápiz, editar el contenido en el editor y ver cómo crece el historial del archivo.

Continúa con:

[`03-editar-archivo.md`](03-editar-archivo.md)
