# Instalar GitHub Desktop

## Introducción

En el capítulo anterior aprendiste qué es GitHub Desktop y por qué es una buena puerta de entrada al trabajo con Git.

Ahora es el momento de tenerla en tu computadora.

La instalación es una operación sencilla: consiste en descargar un instalador desde la página oficial y ejecutarlo.

Aun así, conviene hacerlo con cuidado: es importante descargar el archivo desde el sitio correcto y comprobar al final que la aplicación funciona.

En este capítulo aprenderás:

* dónde se descarga GitHub Desktop de forma oficial;
* qué versiones existen para Windows y para macOS;
* qué requisitos pide el sistema;
* paso a paso cómo se instala en cada sistema;
* qué aparece en la primera pantalla;
* qué debes comprobar al terminar para estar seguro de que la instalación quedó lista.

Al terminar este capítulo tendrás la aplicación instalada y lista para iniciar sesión en el siguiente capítulo.

---

## 1. De dónde se descarga

GitHub Desktop se descarga únicamente desde la página oficial:

```text
https://desktop.github.com
```

Esa página es mantenida por el propio equipo de GitHub y ofrece siempre la versión más reciente de la aplicación.

Regla importante:

> **No descargues el instalador desde otras páginas.**

Existen sitios de terceros que ofrecen "descargas directas" o "versiones más rápidas". No los utilices: pueden distribuir archivos modificados.

Si necesitas llegar a esa página desde otra parte, el camino oficial es:

```text
github.com  →  enlaces a la sección de aplicaciones  →  desktop.github.com
```

o escribir la dirección directamente en el navegador.

La página es sencilla: muestra una descripción de la aplicación, capturas de pantalla y botones de descarga.

---

## 2. Versiones y requisitos

La aplicación se ofrece para dos sistemas operativos:

* **Windows**: versión de 64 bits para Windows 10 y posteriores;
* **macOS**: versión para las versiones recientes de macOS.

Si tu equipo no cumple los requisitos mínimos, la aplicación podría no instalarse o no funcionar correctamente.

Estas son las comprobaciones previas que conviene hacer:

* Que tu sistema operativo sea una versión reciente (Windows 10 o posterior, o una versión actual de macOS);
* Que tengas cuenta de GitHub, porque para usar la aplicación en su mayoría de funciones necesitas iniciar sesión;
* Que exista espacio libre suficiente en disco (la aplicación ocupa poco, menos de un gigabyte);
* Que tengas permisos de administrador para instalar programas.

Si en tu trabajo usas una computadora corporativa, es posible que el equipo no permita instalar software nuevo. En ese caso, consulta primero con la persona responsable de la tecnología.

La versión que se descarga varía ligeramente según el sistema:

```text
Sistema operativo   Archivo que se descarga
──────────────────  ─────────────────────────────
Windows             Archivo .exe (instalador de Windows)
macOS               Archivo .dmg (imagen de disco)
```

Ambos archivos proceden de la misma página oficial.

---

## 3. Antes de instalar: decisiones previas

Antes de pulsar el botón de descarga, toma dos decisiones sencillas.

### Dónde instalarla

En la mayoría de los casos, la ubicación por defecto es suficiente:

* En Windows, suele ser una carpeta dentro de "Archivos de programas";
* En macOS, se coloca en la carpeta "Aplicaciones".

No hace falta cambiar esa ubicación a menos que tengas un motivo concreto.

### Cómo organizarás tus proyectos

Mientras no estemos metiéndolo en Git, una buena idea es crear una carpeta base donde guardarás todos los proyectos que vayas a clonar.

```text
Ejemplo (Windows):
H:\Documentos\mis-proyectos

Ejemplo (macOS):
~/Documents/mis-proyectos
```

En este capítulo solo la creamos. En el capítulo 04 decidirás en qué subcarpeta clonar cada repositorio.

Crear esa carpeta ahora evita improvisar más adelante.

---

## 4. Instalación paso a paso en Windows

Estos son los pasos habituales en Windows.

### Paso 1: descarga el instalador

En `desktop.github.com`, haz clic en el botón "Download for Windows".

Se descargará un archivo `.exe`. Dependiendo de tu navegador, verás una barra de descarga o un cuadro de diálogo para elegir dónde guardar el archivo.

Guárdalo en un lugar fácil de localizar, por ejemplo la carpeta "Descargas".

### Paso 2: ejecuta el instalador

Haz doble clic en el archivo `.exe` descargado.

Windows podría mostrar una advertencia de Control de cuentas de usuario (UAC) preguntando si permites que esta aplicación realice cambios en tu equipo. Responde que sí.

### Paso 3: sigue el asistente

El instalador es un asistente corto. En general:

* Se muestra una pantalla de bienvenida;
* Se aceptan los términos de la licencia;
* Elige la carpeta de instalación (la por defecto está bien);
* Se muestra una barra de progreso durante la instalación;
* Al terminar, aparece una pantalla final con la opción de ejecutar la aplicación.

Los nombres exactos de los botones pueden variar según la versión ("Siguiente", "Instalar", "Terminar").

### Paso 4: finaliza y ejecuta

En la pantalla final, activa la opción que lance GitHub Desktop al terminar y haz clic en "Terminar" o el botón equivalente.

La aplicación se abrirá por primera vez.

### Posible advertencia adicional

En algunas versiones de Windows, si el archivo se descargó desde Internet, el sistema podría mostrar un aviso de protección (SmartScreen) pidiendo confirmación antes de ejecutar el instalador. En ese caso, selecciona la opción para más información y luego "Ejecutar de todas formas".

Solo hazlo si el archivo proviene de `desktop.github.com`.

---

## 5. Instalación paso a paso en macOS

El proceso en macOS también es corto.

### Paso 1: descarga la imagen

En `desktop.github.com`, haz clic en el botón "Download for macOS".

Se descargará un archivo `.dmg`.

### Paso 2: abre la imagen

Haz doble clic en el archivo `.dmg`. Se montará una ventana que contiene el icono de GitHub Desktop y la carpeta "Aplicaciones".

### Paso 3: arrastra la aplicación

Arrastra el icono de GitHub Desktop dentro de la carpeta "Aplicaciones" que aparece en esa ventana.

### Paso 4: expulsa la imagen

La imagen puede expulsarse desde la barra o desde el Finder.

### Paso 5: ejecuta la aplicación

Abre "Aplicaciones" y haz doble clic en GitHub Desktop.

Si macOS muestra un aviso de seguridad en la primera ejecución (suele no ocurrir, porque la aplicación está firmada), ábrelo desde "Configuración del sistema → Privacidad y seguridad" y permite la apertura.

---

## 6. La primera pantalla: "Welcome to GitHub Desktop"

Al abrir la aplicación por primera vez verás una pantalla de bienvenida.

Dependiendo de la versión, muestra un mensaje de bienvenida y uno o dos botones principales.

Los botones habituales son:

* **"Sign in to GitHub.com"**: para iniciar sesión con tu cuenta de GitHub;
* **"Clone a repository"** o similar: para clonar un repositorio sin iniciar sesión todavía.

Esta pantalla es el punto de partida del capítulo 03.

Todavía no hace falta hacer clic en nada: solo toma nota de lo que ves.

```text
Pantalla de bienvenida
     │
     ├── Botón "Sign in to GitHub.com"
     │        └── Abre el navegador para iniciar sesión
     │
     └── Opción de clonar un repositorio
              └── Abre el diálogo "Clone repository"
```

A partir de aquí, toda la configuración pendiente (cuenta, repositorios) se resuelve dentro de la propia aplicación.

---

## 7. Qué comprobar al terminar

Antes de pasar al siguiente capítulo, verifica estos puntos.

### La aplicación se abre sin errores

Ábrela y comprueba que aparece la pantalla de bienvenida o, si ya iniciaste sesión, la lista de repositorios.

### Aparece en el lugar esperado

* En Windows: busca el acceso directo en el menú Inicio o en el escritorio;
* En macOS: busca el icono en la carpeta "Aplicaciones".

Si no la encuentras, vuelve al asistente de instalación y revisa la carpeta elegida.

### La versión es la más reciente

Dentro de la aplicación puedes ver la versión actual desde el menú de ayuda (en Windows: "Help → About"; en macOS, desde el menú de la aplicación). Compara el número con la página oficial para asegurarte de que no te descargaste una versión muy antigua.

### Ya tienes creada la carpeta base de proyectos

Comprueba que la carpeta que decidiste usar (por ejemplo `mis-proyectos`) existe y está vacía o lista para recibir clonados.

### Tienes a mano tu cuenta de GitHub

Iniciar sesión en el capítulo 03 requiere tu cuenta de GitHub. Asegúrate de recordar el usuario y la contraseña (o la configuración de verificación en dos pasos, si la usas).

Si cumples todos estos puntos, estás listo para el siguiente capítulo.

---

## 8. Actualizar y desinstalar

Dos operaciones útiles de mantenimiento.

### Actualizar

La aplicación se actualiza por sí sola en muchas versiones. Si tienes que hacerlo manualmente:

* En Windows, abre el menú "Help" y selecciona "Check for updates";
* En macOS, desde el menú de la aplicación busca la opción de comprobar actualizaciones.

Es buena práctica actualizar después de cada periodo de estudio, para tener siempre la interfaz y el motor de Git actualizados.

### Desinstalar

Si necesitas empezar de cero (por ejemplo, porque la instalación se corrompió):

* En Windows, desinstálala desde "Configuración → Aplicaciones" o desde "Panel de control → Programas";
* En macOS, arrastra el icono de la aplicación a la papelera.

Desinstalar **no** borra los repositorios que ya clonaste: esas carpetas con su historia Git siguen en disco.

---

## 9. Errores durante la instalación

Aunque es un proceso corto, pueden aparecer problemas.

### El botón de descarga no hace nada

Comprueba que el navegador permita las descargas y revisa la carpeta "Descargas". A veces el archivo se guarda sin avisar.

### El instalador no arranca

En Windows, ejecuta el archivo como administrador (botón derecho → "Ejecutar como administrador"). En macOS, comprueba que el disco duro no esté lleno.

### La aplicación no aparece después de instalar

Revisa la carpeta de instalación elegida en el asistente y, en macOS, la carpeta "Aplicaciones".

### La versión instalada no es la más reciente

Vuelve a descargar el instalador desde `desktop.github.com` y repite el proceso.

---

## Práctica guiada

En esta práctica vas a instalar GitHub Desktop en tu equipo.

### Objetivo

Tener la aplicación instalada, funcionando y lista para iniciar sesión.

### Paso 1: visita la página oficial

Abre tu navegador y ve a:

```text
https://desktop.github.com
```

### Paso 2: identifica tu sistema

Mira el sistema operativo de tu equipo (Windows o macOS) y localiza el botón de descarga correspondiente.

### Paso 3: descarga el instalador

Haz clic en el botón de descarga y guarda el archivo en un lugar fácil de localizar.

### Paso 4: crea la carpeta base de proyectos

Crea una carpeta vacía donde guardarás los proyectos que vayas a clonar. Por ejemplo:

```text
mis-proyectos
```

Eso evitará clonar dentro de carpetas con nubes de almacenamiento o de aplicaciones.

### Paso 5: ejecuta el instalador

Según tu sistema:

* En Windows: doble clic en el `.exe` y sigue el asistente;
* En macOS: abre el `.dmg` y arrastra el icono a "Aplicaciones".

### Paso 6: abre la aplicación por primera vez

Abre GitHub Desktop y comprueba que aparece la pantalla de bienvenida.

### Resultado esperado

Deberías ver la aplicación lista, con los botones de iniciar sesión o clonar un repositorio, y con la carpeta base de proyectos creada y vacía.

---

## Errores comunes

### Error 1: descargar desde un sitio que no es el oficial

Los sitios de "descargas rápidas" o de terceros pueden ofrecer instaladores alterados. Solo usa `desktop.github.com`.

### Error 2: no tener permisos para instalar

Si el equipo es de tu trabajo o de la escuela, es posible que necesites permisos de administrador. Pide ayuda a la persona responsable antes de forzar la instalación.

### Error 3: clonar dentro de carpetas de nubes de sincronización

Clonar dentro de OneDrive, Dropbox o similares puede producir conflictos extraños. Guarda tus proyectos en carpetas locales normales.

### Error 4: usar rutas con caracteres especiales

Evita clonar en rutas con acentos, espacios o símbolos raros. Una ruta sencilla y corta evita problemas futuros.

### Error 5: no comprobar la versión instalada

Si la versión es muy antigua, es posible que la interfaz que describes en este capítulo no coincida con la que tienes. Compara el número de versión con la página oficial.

### Error 6: desinstalar y reinstalar sin borrar los proyectos

Desinstalar la aplicación no borra los repositorios clonados. Si quieres empezar de cero en un proyecto, tendrás que borrar también la carpeta del proyecto.

---

## Buenas prácticas

* Descarga siempre desde `desktop.github.com`;
* Mantén la aplicación actualizada;
* Crea una carpeta base de proyectos antes de clonar nada;
* Usa rutas cortas y sin caracteres especiales para los proyectos;
* No clones dentro de carpetas de nubes de sincronización;
* Comprobar la versión instalada antes de empezar a trabajar.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* desde qué página oficial se descarga GitHub Desktop;
* qué formato de archivo se descarga en Windows y en macOS;
* qué requisitos pide el sistema;
* los pasos de instalación en tu sistema operativo;
* qué muestra la pantalla de bienvenida;
* qué comprobaciones se realizan al terminar la instalación;
* cómo se actualiza y se desinstala la aplicación.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* GitHub Desktop se descarga desde `desktop.github.com`, la página oficial;
* hay versiones para Windows (archivo `.exe`) y para macOS (archivo `.dmg`);
* la instalación es un asistente corto: aceptar, elegir carpeta y finalizar;
* al terminar, la aplicación muestra una pantalla de bienvenida con opciones para iniciar sesión o clonar;
* conviene crear antes una carpeta base de proyectos y usar rutas sencillas;
* la aplicación puede actualizarse y desinstalarse sin perder los repositorios ya clonados;
* las descargas solo deben hacerse desde sitios oficiales.

La idea principal es:

> **Instalar GitHub Desktop es un paso corto y seguro: descarga oficial, asistente corto y comprobación final.**

---

## Próximo paso

Ya tienes la aplicación instalada. El siguiente paso es iniciar sesión con tu cuenta de GitHub para que aparezcan tus repositorios.

Continúa con:

[`03-iniciar-sesion.md`](03-iniciar-sesion.md)
