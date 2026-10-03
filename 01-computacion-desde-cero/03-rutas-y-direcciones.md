# Rutas y direcciones

## Introducción

En los capítulos anteriores aprendiste qué es un archivo y qué es una carpeta.

También viste que dos archivos pueden tener el mismo nombre si están en carpetas diferentes. Eso significa que el nombre, por sí solo, no basta para localizar algo dentro de una computadora.

Necesitamos una forma de expresar la **ubicación exacta** de un archivo o de una carpeta.

Esa forma de expresar la ubicación se llama **ruta**.

En este capítulo aprenderás:

* qué es una ruta;
* qué diferencia existe entre una ruta absoluta y una ruta relativa;
* qué significan los separadores de ruta;
* qué son la raíz y la carpeta personal del usuario;
* qué significan los símbolos `.`, `..` y `~`;
* por qué las rutas importan cuando trabajamos con Git y GitHub;
* qué errores son habituales al escribir o interpretar rutas.

No necesitas utilizar la terminal para comprender este capítulo, aunque algunas ideas te prepararán para ella.

---

## 1. Una primera explicación

Imagina que quieres enviar una carta a una persona.

No basta con escribir su nombre en el sobre. Necesitas indicar dónde vive:

```text
País
 └── Ciudad
      └── Calle
           └── Número
                └── Nombre del destinatario
```

Ocurre algo parecido con los archivos.

El nombre del archivo no indica por sí solo dónde está. Necesitamos describir el recorrido completo desde un punto de partida hasta el archivo.

Ese recorrido es la **ruta**.

```text
Nombre del archivo:
    notas.txt

Ruta completa:
    C:\Usuarios\Jorge\Documentos\mi-proyecto\notas.txt
```

La ruta responde a la pregunta:

> ¿Dónde está exactamente este archivo?

---

## 2. Definición técnica

Una **ruta** es una cadena de texto que describe la ubicación de un archivo o de una carpeta dentro de un sistema de archivos.

Está formada por una secuencia de nombres de carpetas y, al final, por el nombre del archivo o de la carpeta de destino.

```text
C:\Usuarios\Jorge\Documentos\mi-proyecto\notas.txt
│        │     │          │          │        │
│        │     │          │          │        └── archivo
│        │     │          │          └─────────── carpeta
│        │     │          └────────────────────── carpeta
│        │     └───────────────────────────────── carpeta
│        └─────────────────────────────────────── carpeta
└──────────────────────────────────────────────── unidad
```

Cada elemento de la ruta se encuentra dentro del anterior.

Esa relación de contención es la misma jerarquía de carpetas que estudiaste en el capítulo 02.

---

## 3. La raíz

Toda ruta comienza en un punto de partida llamado **raíz**.

La raíz es el nivel más alto de la estructura desde el cual se organiza el resto.

En Windows, la raíz suele ser una unidad identificada con una letra:

```text
C:\
D:\
E:\
```

El símbolo `\` después de la letra indica que estamos en la raíz de esa unidad.

En Linux y macOS, la raíz del sistema se representa con una barra inclinada:

```text
/
```

A partir de esa raíz se organizan todas las carpetas del sistema.

```text
Windows:
C:\
├── Usuarios\
├── Programas\
└── Windows\

Linux o macOS:
/
├── home/
├── usr/
└── etc/
```

No necesitas memorizar la estructura interna de ningún sistema operativo.

Lo importante es comprender que toda ruta parte de una raíz.

---

## 4. Separadores de ruta

Los sistemas operativos no utilizan el mismo símbolo para separar los elementos de una ruta.

### Windows

Utiliza la barra invertida, también llamada contrabarra:

```text
\
```

Ejemplo:

```text
C:\Usuarios\Jorge\Documentos\notas.txt
```

### Linux y macOS

Utilizan la barra inclinada:

```text
/
```

Ejemplo:

```text
/home/jorge/Documentos/notas.txt
```

### Comparación

```text
Windows:  C:\Usuarios\Jorge\Documentos\notas.txt
Linux:    /home/jorge/Documentos/notas.txt
macOS:    /Users/jorge/Documentos/notas.txt
```

### Una observación importante para Git

Git fue creado originalmente para sistemas tipo Unix, donde el separador es `/`.

Por ese motivo, en muchos contextos técnicos —incluida la documentación, los archivos de configuración y las rutas internas de Git— se utiliza la barra inclinada `/`, incluso en Windows.

Además, en la mayoría de las herramientas modernas, Windows acepta la barra inclinada `/` en muchos contextos, aunque su forma tradicional sea `\`.

Esta diferencia parece menor, pero explica por qué encontrarás rutas escritas de ambas maneras. No es un error: depende del contexto y de la herramienta.

---

## 5. Ruta absoluta

Una **ruta absoluta** describe la ubicación completa desde la raíz del sistema.

No depende de dónde te encuentres en ese momento.

Ejemplos en Windows:

```text
C:\Usuarios\Jorge\Documentos\mi-proyecto\notas.txt
D:\proyectos\practica\datos.csv
```

Ejemplos en Linux o macOS:

```text
/home/jorge/documentos/mi-proyecto/notas.txt
/Users/jorge/proyectos/practica/datos.csv
```

Característica principal:

> Una ruta absoluta siempre comienza en la raíz.

Ventaja: no hay ambigüedad. Describe un único lugar del sistema.

Desventaja: suele ser larga y, en muchos casos, solamente es válida en el equipo donde fue escrita. En otra computadora, las carpetas pueden tener otra estructura y otros nombres de usuario.

---

## 6. Ruta relativa

Una **ruta relativa** describe la ubicación de un archivo o carpeta tomando como punto de partida la ubicación actual.

No comienza en la raíz.

Ejemplo:

Si te encuentras en:

```text
C:\Usuarios\Jorge\Documentos\mi-proyecto
```

y el archivo `notas.txt` está dentro de esa carpeta, la ruta relativa es simplemente:

```text
notas.txt
```

Si el archivo está dentro de una subcarpeta llamada `documentos`, la ruta relativa es:

```text
documentos\notas.txt
```

### Comparación

```text
Ruta absoluta:
C:\Usuarios\Jorge\Documentos\mi-proyecto\documentos\notas.txt

Ruta relativa (desde mi-proyecto):
documentos\notas.txt
```

Ambas rutas pueden apuntar al mismo archivo. La diferencia es el punto de partida.

### ¿Cuándo se utiliza cada una?

| Situación | Ruta recomendada |
|---|---|
| Indicar la ubicación exacta de un archivo en tu equipo | Absoluta |
| Referirse a un archivo dentro del proyecto | Relativa |
| Compartir un proyecto con otras personas | Relativa |
| Configurar una herramienta en tu sistema | Puede ser absoluta o relativa |

En proyectos de software y en repositorios Git se prefieren las rutas relativas, porque funcionan independientemente de dónde se encuentre el proyecto en cada computadora.

> **Idea clave:** una ruta relativa se interpreta siempre a partir de la ubicación actual.

---

## 7. La carpeta actual y el símbolo «.»

La **carpeta actual** es la carpeta en la que te encuentras trabajando en este momento.

En muchos contextos técnicos se representa con un punto:

```text
.
```

Este símbolo significa:

> La carpeta actual.

Ejemplo:

```text
.
└── notas.txt
```

significa que `notas.txt` está directamente en la carpeta actual.

La expresión:

```text
.\notas.txt
```

equivale a decir:

> El archivo `notas.txt` que está en la carpeta actual.

En sistemas tipo Unix, el mismo concepto se expresa así:

```text
./notas.txt
```

Esta notación aparecerá más adelante en la terminal y en comandos de Git.

---

## 8. La carpeta superior y el símbolo «..»

El símbolo:

```text
..
```

significa:

> La carpeta superior, es decir, la carpeta que contiene a la carpeta actual.

Ejemplo de estructura:

```text
mi-proyecto/
├── documentos/
│   └── notas.txt
└── datos/
```

Si te encuentras dentro de `documentos`, la carpeta superior es `mi-proyecto`.

La expresión:

```text
..\datos
```

indica que, desde la carpeta actual, primero subes un nivel y luego entras en `datos`.

### Varios niveles hacia arriba

Puedes subir más de un nivel repitiendo el símbolo.

```text
..
```

sube un nivel.

```text
..\..
```

sube dos niveles.

En sistemas tipo Unix:

```text
../..
```

cumple la misma función.

### Resumen de símbolos

```text
.      →  carpeta actual
..     →  carpeta superior
```

Estos símbolos se utilizan tanto en la terminal como en la configuración de herramientas, scripts y proyectos.

---

## 9. La carpeta personal del usuario y el símbolo «~»

Cada persona que utiliza una computadora suele tener una carpeta personal donde se guardan sus documentos, descargas y configuraciones.

Ejemplos:

```text
Windows:   C:\Usuarios\Jorge
Linux:     /home/jorge
macOS:     /Users/jorge
```

En sistemas tipo Unix se utiliza el símbolo:

```text
~
```

para representar la carpeta personal del usuario actual.

Ejemplos:

```text
~/documentos
```

significa:

```text
/home/jorge/documentos
```

En Windows, el símbolo `~` no se utiliza de la misma forma en el explorador de archivos, aunque puede aparecer en algunas herramientas, como la terminal de Git.

> Recuerda: `~` representa la carpeta personal del usuario que está trabajando en ese momento. Si cambia el usuario, la ruta real también cambia.

---

## 10. Cómo leer una ruta paso a paso

Leer una ruta correctamente es una habilidad que se desarrolla con la práctica.

Considera esta ruta:

```text
C:\Usuarios\Jorge\Documentos\mi-proyecto\documentos\notas.txt
```

Léela de izquierda a derecha:

```text
C:\                        →  raíz de la unidad C
Usuarios\                  →  carpeta que contiene las cuentas de usuario
Jorge\                     →  carpeta personal del usuario
Documentos\                →  carpeta de documentos
mi-proyecto\               →  carpeta del proyecto
documentos\                →  subcarpeta dentro del proyecto
notas.txt                  →  archivo final
```

Cada segmento es un nivel de la jerarquía.

### Preguntas útiles al leer una ruta

1. ¿Dónde comienza?
2. ¿Cuántos niveles contiene?
3. ¿Cuál es el archivo o carpeta final?
4. ¿Qué carpeta contiene a cuál?

Responder estas preguntas te ayudará cuando trabajes con la terminal, donde una ruta mal interpretada puede provocar que un comando actúe sobre el lugar equivocado.

---

## 11. Rutas con espacios

Los nombres de archivos y carpetas pueden contener espacios.

```text
C:\Usuarios\Jorge\Mis Documentos\mi proyecto\notas.txt
```

Sin embargo, los espacios pueden complicar el trabajo en la terminal, porque normalmente se utilizan para separar argumentos.

Cuando una ruta contiene espacios, suele ser necesario escribirla entre comillas:

```text
"C:\Usuarios\Jorge\Mis Documentos\mi proyecto\notas.txt"
```

o escapar los espacios con un carácter especial, según la terminal utilizada.

### Recomendación para proyectos técnicos

En proyectos que se trabajarán con herramientas de desarrollo, se recomienda evitar espacios en nombres de carpetas y archivos.

Compara:

```text
mi proyecto/
```

con:

```text
mi-proyecto/
```

La segunda forma suele ser más cómoda en la terminal, en scripts y en configuraciones.

Este tema se comprenderá mejor cuando estudiemos la línea de comandos.

---

## 12. Rutas largas

Algunos sistemas operativos y herramientas imponen límites a la longitud de las rutas.

Esto significa que una estructura con demasiados niveles o con nombres muy extensos podría causar problemas en determinados contextos.

No necesitas memorizar los límites actuales de cada sistema, porque varían y han cambiado con el tiempo.

La recomendación práctica es:

* mantener nombres razonables;
* evitar niveles innecesarios;
* colocar los proyectos en ubicaciones accesibles, no excesivamente profundas.

Si alguna vez encuentras un error relacionado con la longitud de la ruta, ya sabrás que este puede ser el motivo.

---

## 13. Por qué las rutas importan en Git

Cuando comiences a utilizar Git, las rutas aparecerán constantemente.

### Ejemplo 1: la carpeta del proyecto

Git trabaja dentro de una carpeta específica: la raíz del repositorio.

Todo el proyecto se organiza a partir de esa ubicación.

```text
C:\proyectos\mi-proyecto\
│
├── README.md
├── documentos\
└── codigo\
```

### Ejemplo 2: rutas relativas dentro del repositorio

Dentro de un repositorio, las rutas se expresan normalmente de forma relativa a la raíz del proyecto:

```text
documentos/notas.txt
codigo/programa.py
```

Esto permite que el proyecto funcione igual en cualquier computadora, sin importar en qué carpeta esté guardado.

### Ejemplo 3: nombres en la terminal

Cuando ejecutes comandos de Git, como `git add`, deberás indicar qué archivos quieres incluir. Para hacerlo, utilizarás rutas relativas:

```bash
git add documentos/notas.txt
```

Comprender cómo se interpreta esa ruta será esencial para no agregar archivos equivocados.

### Ejemplo 4: archivos de configuración

Herramientas como Git utilizan archivos de configuración que se localizan mediante rutas:

* una configuración global, asociada al usuario;
* una configuración local, asociada al repositorio.

Estudiaremos estos archivos más adelante.

---

## 14. Errores comunes

### Error 1: confundir el nombre del archivo con su ubicación

Saber que un archivo se llama `notas.txt` no indica dónde está. Puede existir más de uno en el sistema.

### Error 2: olvidar la ubicación actual

Una ruta relativa depende de dónde te encuentres. La misma expresión puede apuntar a lugares diferentes según la carpeta actual.

### Error 3: mezclar separadores sin comprender el contexto

```text
C:\proyectos/mi-proyecto\notas.txt
```

Aunque algunas herramientas modernas aceptan esta mezcla, no es una práctica recomendable. Utiliza el separador adecuado según el sistema y el contexto, o la barra inclinada `/` cuando la herramienta lo permita.

### Error 4: usar rutas absolutas al compartir proyectos

Una ruta como:

```text
C:\Usuarios\Jorge\Documentos\mi-proyecto
```

no funcionará en la computadora de otra persona, porque su nombre de usuario y su estructura de carpetas serán diferentes.

### Error 5: ignorar los espacios en los nombres

Una ruta con espacios sin comillas puede interpretarse de forma incorrecta en la terminal.

### Error 6: confundir `..` con la carpeta actual

```text
.    →  carpeta actual
..   →  carpeta superior
```

Son símbolos diferentes. Confundirlos puede hacer que un comando actúe sobre un lugar equivocado.

### Error 7: suponer que todos los sistemas son iguales

Windows, Linux y macOS utilizan convenciones diferentes. Un proyecto destinado a funcionar en varios sistemas debe tener esto en cuenta.

---

## 15. Buenas prácticas

* Utiliza rutas relativas dentro de los proyectos.
* Evita espacios en nombres de carpetas y archivos técnicos.
* Mantén nombres claros y consistentes.
* No coloques proyectos en rutas excesivamente profundas.
* Comprende siempre cuál es tu carpeta actual antes de ejecutar un comando.
* Al compartir instrucciones con otras personas, evita depender de tu estructura personal de carpetas.
* Cuando una ruta no funcione, revísala paso a paso antes de asumir que el archivo no existe.

---

## 16. Práctica guiada

En esta práctica observarás rutas mediante una aplicación gráfica. No necesitas utilizar comandos.

### Objetivo

Identificar la ruta de un archivo y comprender su estructura.

### Paso 1: abre el explorador de archivos

Navega hasta la carpeta `practica-carpetas` que creaste en el capítulo anterior.

Si no la tienes, créala con esta estructura:

```text
practica-carpetas/
├── documentos/
│   └── notas.txt
├── imagenes/
└── datos/
```

### Paso 2: observa la ruta de la carpeta

La mayoría de los exploradores de archivos muestran la ubicación actual en una barra superior o en un campo de dirección.

Anota la ruta completa de `practica-carpetas`.

Ejemplo:

```text
C:\Usuarios\TuNombre\Documentos\practica-carpetas
```

### Paso 3: identifica los niveles

Separa la ruta en sus componentes:

```text
C:\                    →  raíz
Usuarios\              →  carpeta de usuarios
TuNombre\              →  carpeta personal
Documentos\            →  documentos
practica-carpetas\     →  carpeta de práctica
```

### Paso 4: obtén la ruta de un archivo

Entra en `documentos` y localiza `notas.txt`.

La ruta completa debería ser similar a:

```text
C:\Usuarios\TuNombre\Documentos\practica-carpetas\documentos\notas.txt
```

### Paso 5: escribe una ruta relativa

Suponiendo que te encuentras dentro de `practica-carpetas`, ¿cómo se expresaría la ubicación de `notas.txt` de forma relativa?

```text
documentos\notas.txt
```

### Resultado esperado

Deberías poder explicar:

* cuál es la ruta absoluta de `notas.txt`;
* cuál es su ruta relativa desde `practica-carpetas`;
* qué representan la raíz y cada nivel intermedio.

---

## 17. Experimento controlado

Este experimento te permitirá comprobar cómo cambia una ruta relativa según tu ubicación.

### Pasos

1. Dentro de `practica-carpetas`, crea una carpeta llamada `pruebas`.
2. Dentro de `pruebas`, crea un archivo llamado `resultado.txt`.
3. Escribe la ruta relativa de `resultado.txt` suponiendo que estás en `practica-carpetas`.
4. Escribe la ruta relativa de `resultado.txt` suponiendo que estás dentro de `pruebas`.
5. Escribe la ruta relativa para llegar desde `pruebas` hasta `documentos/notas.txt`.

### Resultado esperado

Algunas respuestas posibles:

```text
Desde practica-carpetas:
pruebas\resultado.txt

Desde pruebas:
resultado.txt

Desde pruebas hacia notas.txt:
..\documentos\notas.txt
```

### Preguntas

* ¿Por qué la misma ubicación se expresa de formas diferentes?
* ¿Qué papel cumple `..` en la tercera respuesta?
* ¿Qué ocurriría si olvidaras la ubicación desde la cual escribes la ruta?
---

## 18. Ejercicio de análisis

Observa estas rutas:

```text
A) C:\proyectos\mi-proyecto\documentos\notas.txt
B) documentos\notas.txt
C) /home/ana/proyectos/mi-proyecto/notas.txt
D) ..\datos\datos.csv
E) C:\Usuarios\Jorge\Mis Documentos\informe final.docx
```

Responde:

1. ¿Cuáles son rutas absolutas?
2. ¿Cuáles son rutas relativas?
3. ¿Qué sistemas operativos parecen estar representados?
4. ¿Qué ruta podría causar problemas en la terminal y por qué?
5. ¿Qué símbolo indica subir un nivel?
6. ¿Qué ruta no funcionaría en otro equipo y por qué?

---

## 19. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es una ruta;
* qué es la raíz;
* qué diferencia existe entre una ruta absoluta y una relativa;
* por qué se prefieren las rutas relativas dentro de un proyecto;
* qué significan `.`, `..` y `~`;
* qué diferencia existe entre los separadores de Windows y de Linux o macOS;
* por qué los espacios en las rutas pueden causar problemas;
* por qué las rutas importan en Git.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## 20. Resumen

En este capítulo aprendiste que:

* una ruta describe la ubicación de un archivo o carpeta dentro del sistema;
* toda ruta parte de una raíz;
* una ruta absoluta comienza en la raíz y describe una ubicación completa;
* una ruta relativa se interpreta desde la carpeta actual;
* `.` representa la carpeta actual y `..` la carpeta superior;
* `~` representa la carpeta personal del usuario en sistemas tipo Unix;
* Windows y los sistemas tipo Unix utilizan separadores diferentes;
* los espacios en las rutas pueden complicar su uso en la terminal;
* dentro de un proyecto se prefieren rutas relativas;
* Git utiliza rutas para identificar los archivos que controla.

La idea principal es:

> **Una ruta es la forma de expresar dónde vive un archivo o una carpeta, y comprenderla es indispensable para trabajar con Git sin equivocarse de lugar.**

---

## Próximo paso

Ya sabes qué es un archivo, qué es una carpeta y cómo se expresa su ubicación.

El siguiente paso es comprender qué información aporta el nombre de un archivo y cómo se identifican los distintos tipos de contenido.

Continúa con:

[`04-archivos-y-extensiones.md`](04-archivos-y-extensiones.md)
