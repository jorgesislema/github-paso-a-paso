# ¿Qué es un programa?

## Introducción

En los capítulos anteriores estudiamos archivos, carpetas, rutas y extensiones.

Aprendiste que un archivo puede contener texto, datos, imágenes o documentos.

Pero existe una categoría de archivos que merece un capítulo aparte: los **programas**.

Comprender qué es un programa es importante para este curso porque:

* Git fue creado para gestionar proyectos de software;
* los repositorios suelen contener código;
* GitHub es utilizado principalmente por personas que desarrollan programas;
* aunque no necesitas programar para aprender Git, conviene comprender el contexto en el que se utiliza.

En este capítulo aprenderás:

* qué es un programa;
* qué diferencia existe entre un programa y los datos;
* qué es un lenguaje de programación;
* qué diferencia existe entre código fuente y programa ejecutable;
* qué es un intérprete y qué es un compilador;
* qué papel cumplen las herramientas de desarrollo;
* qué relación tienen los programas con Git y GitHub.

No necesitas aprender a programar en este capítulo. El objetivo es comprender los conceptos.

---

## 1. Una primera explicación

Imagina una receta de cocina.

Una receta contiene instrucciones ordenadas:

```text
1. Calentar agua.
2. Agregar los ingredientes.
3. Cocinar durante veinte minutos.
4. Servir.
```

La receta no cocina por sí sola. Alguien debe seguir los pasos.

Un programa funciona de manera similar: es un conjunto de instrucciones que una computadora ejecuta para realizar una tarea.

```text
Receta                    Programa
──────                    ────────
Instrucciones             Instrucciones
Paso 1, paso 2, paso 3    Orden, operación, condición
Las sigue una persona     Las ejecuta la computadora
```

La analogía es útil como punto de partida, pero la definición técnica es más precisa.

---

## 2. Definición técnica

Un **programa** es un conjunto de instrucciones que indica a una computadora qué operaciones debe realizar.

Estas instrucciones pueden:

* recibir datos;
* realizar cálculos;
* tomar decisiones;
* repetir acciones;
* almacenar información;
* mostrar resultados;
* comunicarse con otros programas.

Ejemplos de programas:

* un navegador web;
* un editor de texto;
* un reproductor de música;
* una hoja de cálculo;
* un videojuego;
* una aplicación de mensajería;
* una herramienta como Git.

Todos ellos son programas que ejecutan instrucciones para cumplir una función.

---

## 3. Programa y datos

Conviene distinguir dos conceptos que suelen aparecer juntos:

```text
Programa  →  las instrucciones
Datos     →  la información que el programa procesa
```

### Ejemplo: una calculadora

```text
Programa:
    Las instrucciones que permiten sumar.

Datos:
    Los números que el usuario introduce.

Resultado:
    La suma obtenida.
```

### Ejemplo: un reproductor de música

```text
Programa:
    La aplicación que reproduce audio.

Datos:
    El archivo de música.

Resultado:
    El audio reproducido.
```

### Ejemplo: Git

```text
Programa:
    Git.

Datos:
    Los archivos del proyecto y la información del repositorio.

Resultado:
    El historial y las operaciones realizadas.
```

### Relación

```text
Datos
   │
   ▼
Programa
   │
   ▼
Resultado
```

Esta distinción será importante cuando estudiemos repositorios, porque un proyecto puede contener tanto programas como datos.

---

## 4. ¿Qué es un lenguaje de programación?

Las computadoras no comprenden el lenguaje humano.

Necesitamos una forma de expresar instrucciones que pueda traducirse a operaciones que la máquina pueda ejecutar.

Un **lenguaje de programación** es un sistema de símbolos y reglas que permite escribir instrucciones de forma comprensible para las personas y traducible para la computadora.

Ejemplos de lenguajes:

```text
Python
JavaScript
Java
C
C++
C#
Go
Rust
Ruby
PHP
```

Cada uno tiene sus propias reglas, fortalezas y contextos de uso.

### Ejemplo de instrucción en Python

```python
print("Hola, mundo")
```

Esta instrucción indica al programa que muestre el texto `Hola, mundo`.

### Ejemplo de instrucción en JavaScript

```javascript
console.log("Hola, mundo");
```

Esta instrucción cumple una función equivalente en JavaScript.

No necesitas comprender estos ejemplos. Solo observar que la sintaxis cambia según el lenguaje.

---

## 5. Código fuente

El texto escrito por una persona en un lenguaje de programación se llama **código fuente**.

```text
programa.py
├── instrucción 1
├── instrucción 2
└── instrucción 3
```

El código fuente:

* está escrito por personas;
* puede leerse y modificarse;
* se guarda en archivos de texto;
* suele tener una extensión según el lenguaje;
* se registra en repositorios Git.

### Ejemplo

Archivo `saludo.py`:

```python
nombre = "Ana"
print("Hola, " + nombre)
```

Este archivo contiene código fuente en Python.

Git está diseñado para registrar cambios en este tipo de archivos, porque son texto plano y sus modificaciones pueden compararse línea por línea.

---

## 6. Programa ejecutable

Un **programa ejecutable** es un archivo que la computadora puede ejecutar directamente.

Puede obtenerse a partir del código fuente mediante un proceso de traducción.

```text
Código fuente
      │
      │ traducción
      ▼
Programa ejecutable
```

Ejemplos de archivos ejecutables:

```text
programa.exe       (Windows)
programa           (Linux o macOS)
```

### Diferencia general

| Aspecto | Código fuente | Programa ejecutable |
|---|---|---|
| Escrito por | Personas | Herramientas de traducción |
| Legible | Sí, con conocimientos del lenguaje | No directamente |
| Modificable | Sí | No en la práctica |
| Se registra en Git | Normalmente sí | Normalmente no |

### ¿Por qué los ejecutables no suelen registrarse en Git?

Porque:

* son archivos binarios;
* pueden ser grandes;
* se generan a partir del código fuente;
* cambian con cada compilación;
* no aportan información útil al historial.

En cambio, el código fuente sí se registra, porque es lo que las personas escriben y modifican.

---

## 7. Intérpretes y compiladores

Para que el código fuente se convierta en acciones, se necesita un mecanismo de traducción.

Existen dos enfoques principales.

### Intérprete

Un **intérprete** lee el código fuente y lo ejecuta instrucción por instrucción.

```text
Código fuente
      │
      ▼
Intérprete
      │
      ▼
Ejecución
```

Lenguajes como Python suelen funcionar de esta manera.

Ventajas:

* permite ejecutar el código sin generar un archivo ejecutable previo;
* facilita la experimentación.

### Compilador

Un **compilador** traduce el código fuente completo a un programa ejecutable.

```text
Código fuente
      │
      ▼
Compilador
      │
      ▼
Programa ejecutable
      │
      ▼
Ejecución
```

Lenguajes como C y C++ suelen utilizar compiladores.

Ventajas:

* el programa resultante puede ejecutarse sin el código fuente;
* suele ofrecer mayor rendimiento.

### Enfoques mixtos

Algunos lenguajes y plataformas combinan ambos enfoques o utilizan mecanismos intermedios.

No necesitas memorizar las diferencias específicas de cada lenguaje. Lo importante es comprender que:

```text
El código que escribimos
no es exactamente lo que la computadora ejecuta.
Existe un proceso de traducción.
```

---

## 8. Dónde se ejecutan los programas

Un programa puede ejecutarse en distintos contextos.

### En una computadora personal

```text
Tu equipo
├── editor de texto
├── navegador
├── reproductor
└── Git
```

### En un servidor

Un servidor es una computadora que proporciona servicios a otros equipos.

```text
Servidor
├── página web
├── base de datos
└── servicios de aplicación
```

### En la nube

Los servicios en la nube permiten ejecutar programas en infraestructura de terceros.

### En dispositivos móviles

Los teléfonos y las tabletas también ejecutan programas.

### En sistemas embebidos

Muchos dispositivos, como electrodomésticos o automóviles, contienen programas especializados.

Esta variedad explica por qué existen tantos lenguajes y herramientas diferentes.

---

## 9. Herramientas de desarrollo

Para escribir, ejecutar y gestionar programas se utilizan herramientas específicas.

| Herramienta | Función |
|---|---|
| Editor de código | Escribir y modificar código fuente |
| Terminal | Ejecutar comandos y programas |
| Intérprete o compilador | Traducir el código |
| Gestor de dependencias | Instalar y administrar bibliotecas |
| Sistema de control de versiones | Registrar cambios, como Git |
| Plataforma de colaboración | Trabajar con otras personas, como GitHub |
| Sistema de pruebas | Verificar que el programa funciona |
| Herramienta de automatización | Ejecutar tareas repetitivas |

Estas herramientas se combinan en el flujo de trabajo profesional.

```text
Editor
   │
   ▼
Código fuente
   │
   ▼
Git
   │
   ▼
GitHub
   │
   ▼
Automatización
   │
   ▼
Pruebas y despliegue
```

Este flujo aparecerá repetidamente durante el curso, con mayor detalle en los módulos de CI/CD y DevOps.

---

## 10. Bibliotecas y dependencias

Un programa real rara vez se escribe desde cero.

Los desarrolladores utilizan **bibliotecas**: conjuntos de código ya escrito que resuelven problemas comunes.

Ejemplos de tareas que suelen apoyarse en bibliotecas:

* procesar fechas;
* realizar cálculos matemáticos;
* conectarse a bases de datos;
* crear interfaces gráficas;
* procesar imágenes;
* trabajar con datos.

Cuando un proyecto utiliza una biblioteca externa, se dice que esa biblioteca es una **dependencia**.

```text
Mi programa
     │
     ├── utiliza biblioteca A
     ├── utiliza biblioteca B
     └── utiliza biblioteca C
```

### ¿Por qué importa para Git?

Porque las dependencias deben gestionarse con cuidado:

* suelen registrarse en archivos de configuración;
* no se suelen incluir directamente en el repositorio;
* pueden tener vulnerabilidades que es necesario vigilar;
* su actualización es parte del mantenimiento profesional.

Este tema se profundizará en los módulos de seguridad y DevOps.

---

## 11. Errores en los programas

Los programas pueden fallar por muchas razones.

| Tipo de problema | Descripción |
|---|---|
| Error de sintaxis | El código no cumple las reglas del lenguaje |
| Error lógico | El programa funciona, pero produce un resultado incorrecto |
| Error de ejecución | El programa falla mientras se está ejecutando |
| Error de dependencia | Falta una biblioteca o una versión no coincide |
| Error de configuración | Una opción está mal establecida |

### Ejemplo conceptual

```text
El programa espera un número,
pero recibe un texto.
```

El resultado puede ser un error o un comportamiento inesperado.

Comprender esta variedad es importante porque, más adelante, Git y las herramientas de automatización ayudarán a detectar algunos de estos problemas antes de que lleguen a producción.

---

## 12. Relación con Git y GitHub

Ahora podemos conectar este capítulo con el tema central del curso.

Git fue diseñado para gestionar cambios en proyectos, especialmente en proyectos de software.

### Qué registra Git

Git registra principalmente:

* el código fuente;
* los archivos de configuración;
* la documentación;
* los archivos de datos que se decida incluir;
* la estructura del proyecto.

### Qué suele evitarse

* programas ejecutables generados;
* archivos temporales;
* dependencias descargadas;
* archivos con credenciales;
* archivos grandes que pueden obtenerse por otros medios.

### El flujo general

```text
Escribir código fuente
        │
        ▼
Guardar los archivos
        │
        ▼
Registrar los cambios con Git
        │
        ▼
Compartir mediante GitHub
        │
        ▼
Automatizar pruebas y despliegue
```

Este flujo será el hilo conductor del resto del repositorio.

---

## 13. Git también es un programa

Es importante comprender que Git es, en sí mismo, un programa.

```text
Git
├── está instalado en tu computadora
├── ejecuta instrucciones
├── procesa archivos
├── administra un repositorio
└── muestra resultados en la terminal
```

Cuando escribes:

```bash
git status
```

estás ejecutando el programa Git con una instrucción concreta.

La terminal no es Git. Es el medio a través del cual se comunica la instrucción.

```text
Terminal
    │
    │ ejecuta
    ▼
Git
    │
    │ produce
    ▼
Resultado
```

Esta distinción aparecerá de nuevo en el próximo capítulo.

---

## 14. Errores comunes

### Error 1: pensar que un programa es un archivo cualquiera

Un programa contiene instrucciones que producen un comportamiento. Un archivo de datos contiene información que será procesada.

### Error 2: confundir código fuente con programa ejecutable

El código fuente es texto escrito por personas. El ejecutable es el resultado del proceso de traducción.

### Error 3: creer que la computadora comprende el lenguaje humano

Necesita instrucciones expresadas en un lenguaje que pueda traducirse a operaciones concretas.

### Error 4: pensar que un programa siempre funciona igual en todos los sistemas

Los programas dependen del sistema operativo, de las bibliotecas disponibles y de la configuración del entorno.

### Error 5: incluir ejecutables en un repositorio Git

Suelen ser binarios, grandes y generados automáticamente. Normalmente no deben registrarse.

### Error 6: creer que un error del programa es un error de Git

Son herramientas diferentes. Git registra cambios; el programa ejecuta instrucciones. Un fallo en el programa no significa que Git esté fallando.

### Error 7: asumir que programar es requisito para usar Git

No lo es. Git puede utilizarse para documentos, apuntes, páginas web, datos y muchos otros tipos de proyectos.

---

## 15. Buenas prácticas

* Comprende la diferencia entre programa y datos.
* Distingue el código fuente del programa ejecutable.
* No incluyas archivos generados automáticamente en el repositorio.
* Mantén el código fuente bajo control de versiones.
* Documenta las dependencias del proyecto.
* No publiques credenciales ni configuraciones sensibles.
* Comprende qué hace un programa antes de ejecutarlo.
* Recuerda que Git también es un programa y que la terminal solo es el medio para ejecutarlo.

---

## 16. Práctica guiada

En esta práctica observarás la diferencia entre un archivo de datos y un archivo de código, sin necesidad de programar.

### Objetivo

Reconocer las características de un archivo de texto común y de un archivo que contiene código.

### Paso 1: crea una carpeta de práctica

Crea una carpeta llamada:

```text
practica-programas
```

### Paso 2: crea un archivo de datos

Crea un archivo llamado `datos.txt` con este contenido:

```text
nombre,edad
Ana,30
Luis,25
```

### Paso 3: crea un archivo de código

Crea un archivo llamado `saludo.py` con este contenido:

```python
nombre = "Ana"
print("Hola, " + nombre)
```

> **Nota:** no es necesario ejecutarlo. El objetivo es observar la diferencia entre ambos archivos.

### Paso 4: compara los archivos

Responde:

1. ¿Ambos son archivos de texto?
2. ¿Qué diferencia existe en su extensión?
3. ¿Qué diferencia existe en su contenido?
4. ¿Cuál de ellos podría ser ejecutado por un intérprete de Python?
5. ¿Cuál de ellos describe información y cuál describe instrucciones?

### Resultado esperado

Deberías reconocer que:

* `datos.txt` contiene información;
* `saludo.py` contiene instrucciones escritas en un lenguaje de programación;
* ambos son archivos de texto plano, pero cumplen funciones diferentes.

---

## 17. Experimento controlado

Este experimento te permitirá comprobar la diferencia entre un archivo de texto y un archivo que un programa puede interpretar.

> **Advertencia:** no modifiques ni ejecutes archivos que no comprendas. Trabaja únicamente con los archivos de esta práctica.

### Pasos

1. Abre `saludo.py` con un editor de texto común.
2. Observa que su contenido es legible para una persona.
3. Renómbralo como `saludo.txt`.
4. Observa qué ocurre si intentas ejecutarlo con una herramienta de Python.

### Preguntas

* ¿El contenido del archivo cambió al renombrarlo?
* ¿Por qué la herramienta de Python ya no lo reconoce igual?
* ¿Qué relación tiene esto con lo estudiado en el capítulo de extensiones?

### Conclusión esperada

El contenido no cambió. Solo cambió el nombre. Las herramientas suelen guiarse por la extensión para decidir cómo tratar un archivo, aunque el contenido real siga siendo el mismo.

---

## 18. Ejercicio de análisis

Clasifica los siguientes elementos como **programa** o **dato**:

```text
1. Un archivo de música.
2. Un navegador web.
3. Una hoja de cálculo con ventas.
4. Git.
5. Una fotografía.
6. Un archivo de código fuente.
7. Un reproductor de video.
8. Una lista de nombres en un archivo de texto.
```

Responde:

1. ¿Cuáles son programas?
2. ¿Cuáles son datos?
3. ¿Cuál podría ser tanto programa como dato según el contexto?
4. ¿Qué elementos podrían registrarse en un repositorio Git?
5. ¿Qué elementos normalmente no deberían registrarse?

---

## 19. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es un programa;
* qué diferencia existe entre un programa y los datos;
* qué es un lenguaje de programación;
* qué es el código fuente;
* qué es un programa ejecutable;
* qué diferencia existe entre un intérprete y un compilador;
* qué es una biblioteca y qué es una dependencia;
* por qué Git registra código fuente pero normalmente no ejecutables;
* por qué Git es un programa y la terminal no es Git.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## 20. Resumen

En este capítulo aprendiste que:

* un programa es un conjunto de instrucciones que indica a una computadora qué hacer;
* los datos son la información que el programa procesa;
* un lenguaje de programación permite expresar instrucciones de forma traducible;
* el código fuente es el texto escrito por personas;
* un programa ejecutable es el resultado de un proceso de traducción;
* los intérpretes y los compiladores traducen el código de formas diferentes;
* las bibliotecas y dependencias permiten reutilizar soluciones existentes;
* los programas pueden ejecutarse en computadoras, servidores, dispositivos móviles y otros entornos;
* Git registra principalmente código fuente, documentación y configuración, no ejecutables generados;
* Git también es un programa, y la terminal solo es el medio para ejecutarlo;
* no es necesario programar para aprender Git, pero comprender el contexto ayuda a utilizarlo con criterio.

La idea principal es:

> **Un programa es un conjunto de instrucciones; un repositorio es el lugar donde se registra y colabora sobre el código fuente de esos programas, junto con su documentación y configuración.**

---

## Próximo paso

Ya sabes qué es un archivo, una carpeta, una ruta, una extensión y un programa.

El siguiente paso es conocer la herramienta que utilizaremos para comunicarnos con Git: la terminal.

Continúa con:

[`07-que-es-la-terminal.md`](07-que-es-la-terminal.md)
