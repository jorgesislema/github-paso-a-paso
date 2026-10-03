# Instalar Git

## Introducción

Ya sabes qué es Git, para qué sirve y por qué existe.

Ahora es el momento de tenerlo en tu equipo.

En este capítulo vas a instalar Git en los sistemas operativos más comunes y a verificar que todo funciona correctamente.

En este capítulo aprenderás:

* cómo instalar Git en Windows;
* qué opciones te ofrecerá el instalador oficial y cómo tomarlas;
* qué alternativas existen en Windows (WSL y MSYS2);
* cómo instalar Git en macOS;
* cómo instalar Git en Linux;
* cómo verificar la instalación con `git --version`;
* dónde abrir la terminal para usar Git.

Este capítulo sí usa la terminal, pero solo para verificar que la instalación fue exitosa.

---

## 1. Antes de empezar

Antes de instalar, aclaremos dos cosas.

### 1.1. ¿Qué vas a instalar?

Vas a instalar el **programa Git**, es decir, la herramienta que ejecuta los comandos como `git init` o `git commit`.

No vas a instalar GitHub.

Recuerda: Git es el programa local; GitHub es la plataforma web.

Puedes tener Git sin GitHub y viceversa, aunque para este curso los usarás juntos.

### 1.2. ¿Qué versión conviene?

Conviene instalar la versión más reciente disponible para tu sistema operativo.

No necesitas fijarte en un número exacto.

Basta con asegurarte de que descargas la versión actual, disponible en el sitio oficial.

El sitio oficial de Git es:

```text
https://git-scm.com
```

---

## 2. Instalar en Windows

En Windows tienes varias opciones. La más sencilla para principiar es el instalador oficial.

### 2.1. El instalador oficial

Desde el sitio oficial, descarga el instalador para Windows.

El archivo suele tener un nombre parecido a `Git-2.xx.x-64-bit.exe`.

Ejecútalo y sigue los pasos. El instalador es una serie de pantallas con opciones.

Las opciones que más importan:

* **Ruta de instalación**: la puedes dejar por defecto.
* **Herramientas del shell**: elige la terminal que prefieras usar (Git Bash, PowerShell o Símbolo del sistema).
* **Comportamiento de los finales de línea (line endings)**: por defecto el instalador convierte los finales de línea al estilo de Windows. Para empezar, déjalo en la opción recomendada.
* **Herramienta de control de versiones**: déjala en la opción por defecto.

Si no estás seguro de alguna opción, déjala en el valor por defecto.

Puedes cambiar la mayoría de estas configuraciones más adelante.

### 2.2. Qué deja el instalador

Al terminar, el instalador:

* coloca el programa Git en una carpeta del sistema;
* lo añade a la lista de programas disponibles desde la terminal;
* instala una terminal propia llamada **Git Bash**, que ya trae un entorno de tipo Unix.

Eso significa que desde tu terminal podrás escribir `git` y el sistema sabrá qué hacer.

### 2.3. Alternativas en Windows

Además del instalador, hay otras formas de tener Git en Windows:

#### WSL (Windows Subsystem for Linux)

WSL permite ejecutar una distribución de Linux dentro de Windows.

Si usas WSL, instalas Git dentro de esa distribución de Linux, como si estuvieras en un equipo Linux real.

Es una opción muy buena si también quieres trabajar con herramientas de Linux.

#### MSYS2

MSYS2 es un entorno similar a Unix para Windows.

Permite instalar Git y muchas otras herramientas de desarrollo.

Es una opción más avanzada y menos habitual para empezar.

Para este curso, el instalador oficial es suficiente.

---

## 3. Instalar en macOS

En macOS tienes dos rutas principales.

### 3.1. Con los selectores de Xcode

La forma más directa es usar los **Xcode Command Line Tools**.

Abre la terminal y escribe:

```bash
xcode-select --install
```

El sistema mostrará una ventana que te pedirá instalar las herramientas de línea de comandos.

Al aceptar, macOS descarga e instala las herramientas necesarias, incluido Git.

Una vez terminada la instalación, `git` estará disponible en tu terminal.

### 3.2. Con Homebrew

**Homebrew** es un gestor de paquetes para macOS.

Si ya lo tienes instalado, puedes instalar Git con:

```bash
brew install git
```

Esta ruta es popular entre desarrolladores porque mantiene Git actualizado con facilidad.

Si no usas Homebrew todavía, la opción de `xcode-select` es la más sencilla para empezar.

---

## 4. Instalar en Linux

En Linux, Git se instala con el **gestor de paquetes** de tu distribución.

### 4.1. En distribuciones basadas en Debian (Ubuntu, Debian)

Escribe en la terminal:

```bash
sudo apt update
sudo apt install git
```

El primer comando actualiza la lista de paquetes disponibles.

El segundo instala Git.

El sistema puede pedirte tu contraseña para continuar.

### 4.2. En distribuciones basadas en RPM (Fedora, RHEL, CentOS)

Escribe:

```bash
sudo dnf install git
```

En algunas distribuciones el comando equivalente es:

```bash
sudo yum install git
```

### 4.3. Nota sobre permisos

En Linux, instalar software suele requerir permisos de administrador, por eso el `sudo`.

No vas a necesitar `sudo` cuando uses Git para trabajar en tus proyectos, solo para instalarlo.

---

## 5. Verificar la instalación

Una vez instalado, lo primero es comprobar que el sistema reconoce el comando `git`.

### 5.1. Sintaxis básica

El comando para conocer la versión instalada es:

```bash
git --version
```

No recibe argumentos: solo pide que Git muestre su versión.

### 5.2. Ejemplo paso a paso

Abre tu terminal y escribe el comando:

```bash
git --version
```

Presiona `Enter`.

El resultado será algo parecido a:

```text
git version 2.43.0.windows.1
```

En macOS podrías ver:

```text
git version 2.39.3 (Apple Git-146)
```

En Linux:

```text
git version 2.34.1
```

El número exacto variará según tu sistema, pero siempre verás el texto `git version` seguido de un número.

### 5.3. Qué ocurre al ejecutarlo

`git --version` es un comando de consulta.

No modifica ningún archivo ni cambia ningún estado.

Git simplemente lee su propia información y la muestra en pantalla.

Por eso es el comando ideal para verificar una instalación: es seguro y rápido.

### 5.4. Qué revisar después de ejecutarlo

Después de ejecutar `git --version`, revisa:

* que el comando no devuelva un error;
* que aparezca el texto `git version`;
* que el número de versión sea reciente (no muy antiguo).

Si ves un error, significa que Git no está instalado o que la terminal no lo reconoce.

---

## 6. Dónde abrir la terminal

Para usar Git necesitas una terminal.

Dependiendo de tu sistema, puedes usar:

* **Windows**: PowerShell, Símbolo del sistema o Git Bash;
* **macOS**: Terminal;
* **Linux**: la terminal de tu entorno de escritorio.

Para este curso, cualquier una de ellas sirve.

Un consejo: usa la misma terminal siempre para evitar confusiones.

En Windows, **Git Bash** es muy cómoda porque imita el comportamiento de Linux y viene incluida con Git.

Para entrar en la carpeta de tu proyecto, usa el comando `cd`:

```bash
cd ruta/a/tu/proyecto
```

Verás que el indicador cambia a la nueva carpeta.

A partir de ahí, todos los comandos de Git actuarán sobre esa carpeta.

---

## 7. Errores típicos al instalar

Para que no te pares, te adelanto los problemas más frecuentes.

### 7.1. El comando `git` no se reconoce

Esto suele deberse a:

* que la instalación no se completó;
* que la terminal se abrió antes de instalar;
* que la ruta de Git no está en el `PATH` del sistema.

Solución: reinicia la terminal e intenta de nuevo. Si persiste, revisa la instalación.

### 7.2. Instalé una versión muy antigua

Si el número de versión es antiguo, actualiza Git.

En Windows, vuelve a ejecutar el instalador.

En macOS, usa Homebrew.

En Linux, usa el gestor de paquetes.

### 7.3. Confundir instalar Git con crear una cuenta de GitHub

Son dos cosas distintas.

Instalar Git te da el programa local.

Crear una cuenta de GitHub es algo que ya viste en la sección 03.

---

## 8. Una comprobación final

Antes de avanzar, haz esta comprobación final.

Abre la terminal, entra a cualquier carpeta y escribe:

```bash
git --version
```

Si ves el número de versión, todo está listo para continuar.

Si no, revisa la sección de tu sistema operativo y vuelve a intentarlo.

---

## Práctica guiada

En esta práctica vas a instalar Git y verificarlo.

### Paso 1: identifica tu sistema operativo

Anota en qué sistema vas a trabajar:

* Windows;
* macOS;
* Linux.

### Paso 2: instala Git

Según tu sistema, sigue la sección correspondiente:

* Windows: sección 2;
* macOS: sección 3;
* Linux: sección 4.

### Paso 3: abre la terminal

Abre tu terminal preferida.

Si usas Windows, prueba Git Bash.

### Paso 4: verifica la versión

Escribe:

```bash
git --version
```

Anota el número de versión que ves.

### Paso 5: entra a una carpeta

Elige una carpeta cualquiera y entra a ella con `cd`.

Confirma que el indicador muestra esa carpeta.

### Resultado esperado

Deberías poder:

* instalar Git en tu sistema;
* abrir una terminal y reconocer su indicador;
* verificar la versión instalada;
* moverte dentro de carpetas usando `cd`.

---

## Errores comunes

### Error 1: abrir la terminal antes de instalar Git

La terminal no puede reconocer un programa que aún no existe. Abre la terminal después de instalar.

### Error 2: no reiniciar la terminal tras instalar

A veces el entorno tarda en reflejar el nuevo programa. Reiniciar la terminal suele resolverlo.

### Error 3: confundir Git con GitHub

Instalar Git no crea una cuenta de GitHub ni conecta con la web. Son cosas separadas.

### Error 4: usar una versión muy antigua

Una versión desactualizada puede tener problemas. Instala siempre la versión reciente.

### Error 5: no saber en qué carpeta estás

Antes de ejecutar comandos de Git, confirma con el indicador que estás en la carpeta correcta.

---

## Buenas prácticas

* Descarga Git solo del sitio oficial o de tu gestor de paquetes.
* Instala la versión más reciente disponible.
* Verifica la instalación con `git --version` antes de avanzar.
* Usa una terminal consistente para todo el curso.
* Confirma siempre la carpeta actual antes de ejecutar comandos.
* En Windows, considera Git Bash si prefieres un entorno de tipo Unix.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué vas a instalar exactamente y por qué;
* cómo se instala Git en Windows, macOS y Linux;
* qué opciones importantes ofrece el instalador de Windows;
* qué alternativas existen en Windows (WSL y MSYS2);
* cómo verificar la instalación con `git --version`;
* dónde abrir la terminal y cómo moverte entre carpetas;
* qué hacer si el comando `git` no se reconoce.

Si alguna respuesta no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* Git es el programa local que vas a instalar, no es lo mismo que GitHub;
* en Windows se instala desde el sitio oficial con un instalador gráfico;
* en macOS se instala con `xcode-select --install` o con Homebrew;
* en Linux se instala con el gestor de paquetes (`apt` o `dnf`);
* la versión instalada se verifica con `git --version`;
* los comandos de Git se ejecutan desde la terminal, en la carpeta del proyecto;
* antes de trabajar conviene confirmar carpeta y versión.

La idea principal es:

> **Instalar Git te da el programa local; verificarlo con `git --version` y trabajar desde la terminal en la carpeta correcta es la base de todo lo que sigue.**

---

## Próximo paso

Ya tienes Git instalado y verificado.

El siguiente paso es decirle a Git quién eres, para que pueda registrar quién realiza cada commit.

Continúa con:

[`04-configurar-git.md`](04-configurar-git.md)
