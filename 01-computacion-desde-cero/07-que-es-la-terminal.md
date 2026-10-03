# ¿Qué es la terminal?

## Introducción

En los capítulos anteriores aprendiste qué es un archivo, una carpeta, una ruta, una extensión y un programa.

También mencionamos que Git es un programa y que la terminal es uno de los medios para comunicarse con él.

Este capítulo está dedicado a comprender qué es la terminal, cómo se utiliza y por qué aparece constantemente en la documentación técnica.

A muchas personas la terminal les resulta intimidante al principio. Es normal.

Este capítulo tiene un objetivo claro:

> **Que dejes de ver la terminal como un obstáculo y comiences a verla como una herramienta.**

En este capítulo aprenderás:

* qué es la terminal;
* qué diferencia existe entre terminal, consola y línea de comandos;
* qué es un comando;
* cómo se estructura un comando;
* qué es el indicador de la terminal;
* cómo saber en qué carpeta te encuentras;
* qué significa ejecutar un comando;
* por qué la terminal es útil;
* qué relación tiene con Git.

No necesitas memorizar comandos en este capítulo. El objetivo es comprender el entorno.

---

## 1. Una primera explicación

Cuando utilizas una computadora, normalmente interactúas mediante una **interfaz gráfica**:

* ventanas;
* íconos;
* menús;
* botones;
* arrastrar y soltar.

Esta forma de interacción es cómoda y visual.

La terminal ofrece otra forma de interactuar:

```text
Interfaz gráfica          Terminal
────────────────          ────────
Hacer clic                Escribir
Seleccionar un menú       Escribir un comando
Arrastrar un archivo      Escribir una instrucción
```

Ambas permiten realizar muchas de las mismas operaciones.

La diferencia principal está en cómo se comunican las instrucciones.

### Analogía

Puedes imaginar la interfaz gráfica como hablar con una persona mostrando dibujos, y la terminal como escribirle una nota con instrucciones precisas.

Ambas formas funcionan. La terminal suele ser más rápida y precisa para determinadas tareas, pero requiere conocer las instrucciones.

---

## 2. Definición técnica

La **terminal** es una interfaz que permite interactuar con el sistema operativo mediante texto.

En lugar de hacer clic en botones, se escriben instrucciones llamadas **comandos**.

```text
Usuario
   │
   │ escribe un comando
   ▼
Terminal
   │
   │ envía la instrucción
   ▼
Sistema operativo
   │
   │ ejecuta
   ▼
Resultado
   │
   │ se muestra
   ▼
Usuario
```

La terminal no ejecuta los comandos por sí misma.

Actúa como intermediaria entre la persona y el sistema.

---

## 3. Terminal, consola y línea de comandos

Estos términos se utilizan con frecuencia como sinónimos, aunque técnicamente tienen matices diferentes.

| Término | Significado general |
|---|---|
| Terminal | Programa o interfaz que permite interactuar mediante texto |
| Consola | Concepto similar, asociado históricamente a la administración de sistemas |
| Línea de comandos | El entorno donde se escriben y ejecutan comandos |
| Shell | El programa que interpreta los comandos escritos |

### Relación general

```text
Terminal
   │
   │ permite escribir
   ▼
Línea de comandos
   │
   │ interpretada por
   ▼
Shell
   │
   │ ejecuta
   ▼
Comandos
```

### Ejemplos de shells

* **Bash**: común en Linux y disponible en otros sistemas.
* **Zsh**: común en macOS.
* **PowerShell**: común en Windows.
* **Símbolo del sistema**: shell tradicional de Windows.

### Ejemplos de terminales

* Windows Terminal
* Terminal de macOS
* Terminal de GNOME en Linux
* Git Bash, que incluye un entorno similar a Bash en Windows

> **Para este curso:** no necesitas dominar todos estos entornos. Utilizaremos ejemplos que funcionan en los más comunes y señalaremos las diferencias cuando sea necesario.

---

## 4. El indicador de la terminal

Cuando abres una terminal, normalmente aparece un texto similar a este:

```text
C:\Users\Jorge\proyecto>
```

o:

```text
usuario@equipo:~/proyecto$
```

Ese texto se llama **indicador** o **prompt**.

Contiene información útil, como:

* el nombre del usuario;
* el nombre del equipo;
* la carpeta actual;
* el símbolo desde el cual se escriben los comandos.

### Ejemplo en Windows

```text
C:\Users\Jorge\proyecto>
│        │      │       │
│        │      │       └── espera un comando
│        │      └── carpeta actual
│        └── usuario
└── unidad
```

### Ejemplo en Linux o macOS

```text
jorge@equipo:~/proyecto$
│     │      │         │
│     │      │         └── espera un comando
│     │      └── carpeta actual
│     └── equipo
└── usuario
```

### ¿Por qué es importante?

Porque la mayoría de los comandos actúan sobre la **carpeta actual**.

Si no sabes dónde te encuentras, podrías ejecutar una operación en el lugar equivocado.

> **Regla práctica:** antes de ejecutar un comando que modifica archivos, comprueba en qué carpeta estás.

---

## 5. ¿Qué es un comando?

Un **comando** es una instrucción que se escribe para que el sistema realice una acción.

Ejemplos generales:

```text
mostrar el contenido de una carpeta
crear una carpeta
cambiar de carpeta
mostrar la ubicación actual
```

Cada sistema operativo tiene sus propios comandos.

### Ejemplo conceptual en Windows

```text
dir
```

Muestra el contenido de la carpeta actual.

### Ejemplo conceptual en Linux o macOS

```text
ls
```

Cumple una función equivalente.

### Ejemplo de Git

```bash
git status
```

Solicita a Git que muestre el estado del repositorio.

> **Observación:** no necesitas memorizar estos comandos ahora. Los estudiaremos cuando corresponda.

---

## 6. Estructura de un comando

Muchos comandos siguen esta estructura:

```text
comando [opciones] [argumentos]
```

### Partes

| Parte | Función |
|---|---|
| Comando | La acción que se desea realizar |
| Opciones | Modifican el comportamiento del comando |
| Argumentos | Indican sobre qué se actúa |

### Ejemplo

```bash
git commit -m "Agregar documentación"
```

Desglose:

```text
git          →  comando principal
commit       →  subcomando
-m           →  opción
"Agregar documentación"  →  argumento
```

### Observación

La sintaxis exacta depende del comando y de la herramienta. Por eso cada comando que estudiemos se explicará con detalle antes de pedirte que lo utilices.

---

## 7. Ejecutar un comando

Escribir un comando y presionar la tecla de confirmación —normalmente `Enter`— indica al sistema que lo ejecute.

```text
Escribes el comando
        │
        ▼
Presionas Enter
        │
        ▼
El sistema lo interpreta
        │
        ▼
Se produce un resultado
```

El resultado puede ser:

* texto en pantalla;
* un cambio en el sistema;
* un mensaje de error;
* ninguna salida visible.

### ¿Y si el comando está mal escrito?

El sistema mostrará un mensaje de error.

```text
comando no reconocido
```

Esto no significa que hayas dañado algo. Significa que el sistema no comprendió la instrucción.

Los errores son parte normal del aprendizaje.

---

## 8. Comandos que solo muestran información y comandos que modifican

Conviene distinguir dos categorías.

### Comandos de consulta

Muestran información sin modificar el sistema.

Ejemplos conceptuales:

```text
mostrar la carpeta actual
mostrar el contenido
mostrar la versión de un programa
```

Son seguros de ejecutar.

### Comandos que modifican

Crean, cambian, mueven o eliminan elementos.

Ejemplos conceptuales:

```text
crear una carpeta
eliminar un archivo
cambiar de ubicación
```

Requieren más atención, porque producen cambios reales.

> **Regla de oro:** comprende qué hace un comando antes de ejecutarlo, especialmente si modifica o elimina información.

Esta regla se aplicará también, y con especial énfasis, a los comandos de Git que estudiaremos más adelante.

---

## 9. Errores frecuentes al comenzar

### Error 1: creer que la terminal puede dañar la computadora con solo abrirla

Abrir la terminal no modifica nada. Los cambios ocurren cuando se ejecutan comandos.

### Error 2: ejecutar comandos sin comprenderlos

Copiar y pegar un comando de Internet sin comprenderlo puede producir consecuencias no deseadas.

### Error 3: no saber en qué carpeta estás

Ejecutar un comando en la ubicación equivocada puede afectar archivos incorrectos.

### Error 4: confundir terminal con Git

La terminal es el entorno. Git es un programa que puede ejecutarse desde ella.

### Error 5: pensar que la terminal es solo para expertos

Es una herramienta que se aprende progresivamente, como cualquier otra.

### Error 6: rendirse ante un mensaje de error

Los errores de la terminal suelen indicar qué ocurrió. Aprender a leerlos es parte del proceso.

### Error 7: asumir que los comandos son iguales en todos los sistemas

Los comandos y su sintaxis varían entre Windows, Linux y macOS.

---

## 10. ¿Por qué la terminal es útil?

Aunque la interfaz gráfica es suficiente para muchas tareas, la terminal ofrece ventajas en determinados contextos.

### Precisión

Permite expresar operaciones con exactitud.

### Velocidad

Para tareas repetitivas, suele ser más rápida que una secuencia de clics.

### Automatización

Los comandos pueden guardarse en archivos y ejecutarse automáticamente.

### Documentación

Es fácil compartir un comando con otra persona.

### Herramientas profesionales

Muchas herramientas de desarrollo, incluida Git, se utilizan principalmente desde la terminal.

### Control

Permite operaciones que no siempre están disponibles en la interfaz gráfica.

---

## 11. Relación con Git

Git puede utilizarse desde la terminal y también desde interfaces gráficas.

| Medio | Ejemplo |
|---|---|
| Terminal | Escribir comandos de Git |
| Aplicación de escritorio | GitHub Desktop |
| Editor de código | Integración con Git |
| Interfaz web | Operaciones desde GitHub |

Este curso utiliza progresivamente:

```text
GitHub Web
     ↓
GitHub Desktop
     ↓
Git + Terminal
```

La terminal aparecerá con mayor frecuencia a medida que avancemos, porque es el medio estándar para trabajar con Git en entornos profesionales.

### Git no es la terminal

Esta distinción es fundamental:

```text
Terminal
   └── entorno donde se escriben comandos

Git
   └── programa que ejecuta operaciones de control de versiones
```

Cuando escribes:

```bash
git status
```

la terminal recibe la instrucción y ejecuta el programa Git con el subcomando `status`.

---

## 12. Buenas prácticas

* Comprende cada comando antes de ejecutarlo.
* Verifica la carpeta actual antes de operar.
* Lee los mensajes que aparecen en pantalla.
* No copies comandos de fuentes desconocidas sin comprenderlos.
* Practica en carpetas de prueba antes de trabajar con proyectos reales.
* Mantén copias de seguridad de la información importante.
* No ejecutes comandos destructivos sin entender sus consecuencias.
* Recuerda que la terminal es una herramienta, no un examen.

---

## 13. Práctica guiada

En esta práctica abrirás una terminal y observarás su funcionamiento. No ejecutarás comandos que modifiquen archivos.

### Objetivo

Familiarizarse con la apariencia y el comportamiento de la terminal.

### Paso 1: abre una terminal

Según tu sistema, puedes utilizar:

* Windows Terminal;
* PowerShell;
* Símbolo del sistema;
* Terminal de macOS;
* Terminal de tu distribución de Linux.

### Paso 2: observa el indicador

Escribe lo que ves. Por ejemplo:

```text
C:\Users\TuNombre>
```

o:

```text
usuario@equipo:~$
```

Identifica:

1. El nombre del usuario.
2. La carpeta actual.
3. El símbolo que espera un comando.

### Paso 3: escribe un comando de consulta

En Windows, prueba:

```text
dir
```

En Linux o macOS, prueba:

```text
ls
```

### Paso 4: observa el resultado

El sistema mostrará el contenido de la carpeta actual.

### Paso 5: cierra la terminal

No se habrá modificado nada, porque solo se ejecutó un comando de consulta.

### Resultado esperado

Deberías poder identificar:

* qué es el indicador;
* qué información contiene;
* qué ocurre al ejecutar un comando de consulta;
* que la terminal responde a lo que escribes.

---

## 14. Experimento controlado

Este experimento te permitirá observar cómo responde la terminal ante un comando que no existe.

> **Advertencia:** utiliza únicamente comandos de consulta. No ejecutes comandos que modifiquen archivos.

### Pasos

1. Abre la terminal.
2. Escribe una palabra que no sea un comando válido. Por ejemplo:

```text
holamundo
```

3. Presiona `Enter`.
4. Observa el mensaje.

### Preguntas

* ¿Qué ocurrió?
* ¿Se modificó algún archivo?
* ¿Qué te indica el mensaje recibido?
* ¿Por qué es útil comprender los mensajes de error?

### Conclusión esperada

La terminal informa que no reconoce la instrucción. No se produjo ningún cambio en el sistema. Los errores son informativos y forman parte del aprendizaje.

---

## 15. Ejercicio de análisis

Observa estas situaciones y responde:

```text
Situación A:
El indicador muestra C:\Users\Ana\Documentos>
y se ejecuta un comando que afecta a la carpeta actual.

Situación B:
El indicador muestra /home/ana/proyectos$
y se ejecuta el mismo tipo de comando.

Situación C:
El indicador muestra C:\Users\Ana>
y se ejecuta un comando que elimina archivos.
```

Responde:

1. ¿Sobre qué carpeta actúa el comando en cada situación?
2. ¿Por qué es importante conocer la carpeta actual?
3. ¿Qué diferencia existe entre una situación de consulta y una que modifica archivos?
4. ¿Qué debería hacer la persona antes de ejecutar un comando destructivo?

---

## 16. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es la terminal;
* qué diferencia existe entre terminal, shell y línea de comandos;
* qué es el indicador y qué información muestra;
* qué es un comando;
* qué diferencia existe entre un comando de consulta y uno que modifica;
* por qué es importante conocer la carpeta actual;
* por qué la terminal no es lo mismo que Git;
* por qué los errores de la terminal no son necesariamente peligrosos;
* por qué la terminal es útil en el trabajo profesional.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## 17. Resumen

En este capítulo aprendiste que:

* la terminal es una interfaz que permite interactuar con el sistema mediante comandos;
* terminal, consola, línea de comandos y shell son términos relacionados, aunque con matices diferentes;
* el indicador muestra información como el usuario y la carpeta actual;
* un comando es una instrucción que el sistema interpreta y ejecuta;
* los comandos pueden ser de consulta o modificar el sistema;
* los errores de la terminal suelen ser informativos, no destructivos;
* la terminal no es Git: es el entorno desde el cual Git puede ejecutarse;
* comprender la terminal es importante porque muchas herramientas profesionales se utilizan desde ella.

La idea principal es:

> **La terminal es un medio para dar instrucciones precisas al sistema; no es un obstáculo, sino una herramienta que se aprende paso a paso.**

---

## Próximo paso

Has completado la sección de computación desde cero.

Ya comprendes qué es un archivo, una carpeta, una ruta, una extensión, un programa y la terminal.

El siguiente paso es conocer GitHub, la plataforma que utilizarás durante el resto del recorrido.

Continúa con:

[`../02-github-desde-cero/README.md`](../02-github-desde-cero/README.md)
