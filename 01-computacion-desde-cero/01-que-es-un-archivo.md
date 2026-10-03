# ¿Qué es un archivo?

## Introducción

Antes de aprender Git y GitHub, necesitamos comprender qué elementos vamos a organizar, modificar y guardar.

Uno de esos elementos es el **archivo**.

Todos los días utilizamos archivos, aunque no siempre pensemos en ellos de esa manera. Una fotografía, una carta, una canción, una hoja de cálculo y un programa pueden estar almacenados como archivos.

En este capítulo aprenderás:

* qué es un archivo;
* qué información permite identificarlo;
* qué diferencia existe entre el nombre, el contenido y el tipo de un archivo;
* qué operaciones básicas pueden realizarse sobre él;
* por qué guardar no es lo mismo que registrar una versión con Git;
* cómo reconocer archivos relevantes dentro de un proyecto.

No necesitas saber programar ni utilizar la terminal.

---

## 1. Una primera explicación

Un archivo es una unidad de información guardada en un dispositivo o sistema de almacenamiento.

Puede contener, por ejemplo:

* texto;
* una imagen;
* sonido;
* video;
* datos organizados;
* instrucciones de un programa;
* información de configuración.

Algunos ejemplos cotidianos son:

```text
carta.docx
presupuesto.xlsx
fotografia.jpg
cancion.mp3
presentacion.pdf
notas.txt
```

Cada uno de estos archivos almacena información, pero no todos contienen la misma clase de información ni se utilizan de la misma manera.

---

## 2. Una analogía útil

Puedes imaginar un archivo digital como un documento guardado en un archivador físico.

Un documento de papel puede tener:

* un título;
* contenido;
* una ubicación dentro del archivador;
* una fecha de creación;
* una fecha de modificación.

Un archivo digital también posee características que permiten reconocerlo y localizarlo.

```text
Documento físico              Archivo digital
────────────────              ───────────────
Título                        Nombre
Texto o imagen                Contenido
Tipo de documento             Formato o tipo
Lugar en el archivador        Ubicación
Fecha de revisión             Fecha de modificación
```

La analogía ayuda a comenzar, pero no explica todo. Un archivo digital no es una hoja de papel: es información representada y almacenada mediante datos que la computadora puede leer y procesar.

---

## 3. Definición técnica

Un **archivo** es una colección de datos almacenada bajo un nombre dentro de un sistema de archivos.

El **sistema de archivos** es el mecanismo que utiliza un sistema operativo para organizar, nombrar, almacenar y localizar archivos y carpetas en un dispositivo.

Por ahora, basta con comprender este modelo:

```text
Dispositivo de almacenamiento
            │
            ▼
Sistema de archivos
            │
            ├── carpetas
            └── archivos
```

Más adelante estudiaremos las carpetas y las rutas. Esos conceptos nos permitirán describir con precisión dónde se encuentra un archivo.

---

## 4. Nombre, contenido, tipo y ubicación

Para comprender un archivo conviene separar cuatro ideas.

### 4.1. Nombre

El nombre nos ayuda a identificar el archivo.

Ejemplos:

```text
informe
presupuesto
fotografia-vacaciones
lista-de-tareas
README
```

Un nombre descriptivo permite reconocer el propósito del archivo sin necesidad de abrirlo.

Compara:

```text
documento1
```

con:

```text
informe-ventas-septiembre
```

El segundo nombre comunica mejor qué contiene el archivo.

### 4.2. Contenido

El contenido es la información almacenada dentro del archivo.

Por ejemplo, un archivo llamado `lista-de-tareas.txt` podría contener:

```text
Comprar materiales
Revisar el informe
Enviar el documento
```

El nombre y el contenido están relacionados, pero no son lo mismo. Cambiar el nombre no modifica necesariamente el contenido.

### 4.3. Tipo o formato

El tipo indica cómo está organizada o representada la información y qué programas pueden interpretarla.

Por ejemplo:

```text
notas.txt
fotografia.png
informe.pdf
datos.csv
```

La parte final, como `.txt`, `.png`, `.pdf` o `.csv`, suele llamarse **extensión**. La estudiaremos con más detalle en un capítulo posterior.

Por ahora, recuerda una idea importante:

> Cambiar manualmente la extensión no convierte de forma fiable un archivo en otro tipo.

Renombrar `fotografia.jpg` como `fotografia.pdf` no transforma la imagen en un documento PDF. Solo modifica el nombre con el que se presenta el archivo.

### 4.4. Ubicación

La ubicación indica dónde se encuentra el archivo dentro del sistema.

Dos archivos pueden tener el mismo nombre si están guardados en carpetas diferentes.

```text
proyecto-a/
└── notas.txt

proyecto-b/
└── notas.txt
```

Aunque ambos se llamen `notas.txt`, no son el mismo archivo.

En los próximos capítulos estudiaremos las carpetas y las rutas, que permiten expresar esta ubicación con precisión.

---

## 5. ¿Dónde se guardan los archivos?

Los archivos pueden almacenarse en distintos lugares, entre ellos:

* el almacenamiento interno de una computadora;
* una memoria USB;
* un disco externo;
* un teléfono;
* un servidor;
* un servicio de almacenamiento en la nube.

Ejemplos de servicios en la nube son OneDrive, Google Drive, Dropbox e iCloud.

Sin embargo, que un archivo aparezca en una carpeta sincronizada con la nube no significa que sea un repositorio Git ni que se encuentre en GitHub.

Estas ideas deben mantenerse separadas:

```text
Guardar un archivo
        ≠
Sincronizarlo con la nube
        ≠
Registrarlo con Git
        ≠
Publicarlo en GitHub
```

Cada operación resuelve un problema diferente.

---

## 6. Crear, abrir, modificar y guardar

Estas son algunas de las operaciones más habituales con archivos.

### Crear

Crear un archivo significa generar una nueva unidad de información.

Por ejemplo, al abrir un editor de texto y crear un documento nuevo, el contenido puede existir temporalmente en el programa. Normalmente deberás guardarlo para conservarlo después de cerrar la aplicación.

### Abrir

Abrir un archivo significa pedir a un programa que lea e interprete su contenido.

El programa adecuado depende del tipo de archivo. Un editor de texto puede abrir archivos de texto, mientras que un reproductor multimedia está diseñado para audio o video.

### Modificar

Modificar un archivo significa cambiar su contenido.

Por ejemplo:

```text
Antes:
Reunión a las 10:00

Después:
Reunión a las 11:00
```

### Guardar

Guardar significa escribir en el almacenamiento los cambios realizados en el archivo.

En muchos programas se utiliza la opción **Guardar** o el atajo correspondiente del sistema operativo.

Es importante distinguir entre:

```text
Modificar el contenido
          │
          ▼
Guardar el archivo
```

Si modificas un documento y cierras el programa sin guardar, algunos cambios podrían perderse. Ciertas aplicaciones ofrecen recuperación automática, pero no debe asumirse que siempre estará disponible.

### Guardar como

La opción **Guardar como** suele permitir crear otro archivo con un nombre, ubicación o formato diferente.

Ejemplo:

```text
informe.txt
     │
     │ Guardar como
     ▼
informe-revisado.txt
```

El resultado puede ser un segundo archivo. A partir de ese momento, ambos pueden modificarse de manera independiente.

---

## 7. Guardar no significa conservar todas las versiones

Supongamos que un archivo contiene:

```text
Versión inicial del informe.
```

Después reemplazas su contenido por:

```text
Versión corregida del informe.
```

Cuando guardas, el archivo refleja el contenido nuevo. Dependiendo del programa o del servicio utilizado, quizá exista un historial automático, pero un archivo común no garantiza por sí solo que todas sus versiones anteriores permanezcan disponibles.

Por eso muchas personas crean copias manuales:

```text
informe-v1.txt
informe-v2.txt
informe-final.txt
informe-final-corregido.txt
informe-final-definitivo.txt
```

Este método puede servir en situaciones sencillas, pero se vuelve difícil de administrar cuando:

* existen muchas versiones;
* varias personas trabajan en el mismo proyecto;
* no sabemos qué cambió entre dos copias;
* necesitamos recuperar un estado anterior;
* queremos conocer quién realizó un cambio y por qué.

Más adelante aprenderás cómo Git ayuda a gestionar este problema mediante un historial estructurado.

---

## 8. Guardar un archivo no crea un commit

Esta distinción será fundamental durante todo el curso.

Cuando guardas un archivo, el sistema conserva su contenido actual en el almacenamiento.

Cuando creas un **commit** con Git, registras un punto del historial del proyecto a partir de cambios seleccionados.

```text
Editar un archivo
        │
        ▼
Guardar el archivo
        │
        ▼
El contenido cambia en la carpeta de trabajo
        │
        ▼
Git puede detectar el cambio
        │
        ▼
El usuario decide si desea prepararlo y registrarlo
```

Por lo tanto:

```text
Guardar
   ≠
Crear un commit
```

Y también:

```text
Crear un commit local
   ≠
Enviar ese commit a GitHub
```

Todavía no necesitas ejecutar ningún comando. Esta explicación solo prepara el modelo mental que desarrollaremos más adelante.

---

## 9. Archivos de texto y archivos binarios

Para trabajar con Git resulta útil conocer una distinción general.

### Archivos de texto

Un archivo de texto contiene información representada como caracteres que pueden interpretarse como texto.

Ejemplos habituales:

```text
notas.txt
README.md
pagina.html
estilos.css
datos.csv
config.json
programa.py
```

Aunque algunos requieran conocimientos técnicos para comprenderlos, su contenido puede examinarse con un editor de texto adecuado.

### Archivos binarios

Un archivo binario almacena datos en un formato que normalmente debe interpretar un programa específico.

Ejemplos habituales:

```text
fotografia.jpg
documento.pdf
cancion.mp3
video.mp4
programa.exe
```

Todos los archivos se almacenan digitalmente, pero la expresión **archivo binario** se utiliza aquí para distinguir formatos que no se trabajan como texto legible y editable línea por línea.

### ¿Por qué importa esta diferencia para Git?

Git puede almacenar tanto archivos de texto como binarios, pero suele mostrar y comparar con mayor claridad los cambios realizados línea por línea en archivos de texto.

Por ejemplo, Git puede mostrar fácilmente que esta línea:

```text
La reunión será el lunes.
```

cambió por esta otra:

```text
La reunión será el martes.
```

En una fotografía o un video, la comparación normalmente no resulta tan comprensible para una persona.

Esto no significa que los archivos binarios estén prohibidos en Git. Significa que sus características, tamaño y forma de comparación requieren decisiones diferentes.

---

## 10. Los archivos dentro de un proyecto

Un proyecto puede contener archivos con funciones distintas.

Ejemplo:

```text
mi-proyecto/
├── README.md
├── LICENSE
├── notas.txt
├── datos.csv
├── imagen.png
└── programa.py
```

Cada archivo cumple un propósito:

| Archivo | Propósito posible |
|---|---|
| `README.md` | Presentar y explicar el proyecto |
| `LICENSE` | Indicar las condiciones legales de uso |
| `notas.txt` | Guardar anotaciones de trabajo |
| `datos.csv` | Almacenar datos tabulares |
| `imagen.png` | Incluir un recurso visual |
| `programa.py` | Contener instrucciones escritas en Python |

No necesitas comprender todavía todos estos formatos. Lo importante es reconocer que un proyecto no consiste necesariamente en un único archivo y que cada elemento puede desempeñar una función concreta.

---

## 11. Metadatos de un archivo

Además de su contenido, el sistema puede conservar información acerca del archivo. Esta información se denomina **metadatos**.

Según el sistema operativo y el sistema de archivos, los metadatos pueden incluir:

* nombre;
* tamaño;
* ubicación;
* fecha de creación;
* fecha de modificación;
* propietario;
* permisos;
* atributos adicionales.

Puedes imaginar los metadatos como información **sobre** el archivo, no necesariamente como parte de su contenido principal.

```text
Archivo
├── contenido
└── metadatos
    ├── nombre
    ├── tamaño
    ├── fechas
    └── permisos
```

Los metadatos disponibles y su significado exacto pueden variar entre sistemas. Por ejemplo, la fecha de creación no se gestiona de forma idéntica en todos los sistemas de archivos.

---

## 12. Archivos visibles y archivos ocultos

Algunos sistemas pueden ocultar determinados archivos en la vista habitual para evitar ruido visual o proteger elementos de configuración frente a modificaciones accidentales.

Que un archivo esté oculto no significa que haya desaparecido ni que sea necesariamente peligroso.

En proyectos de software encontrarás nombres como:

```text
.gitignore
.gitattributes
.env
```

En sistemas tipo Unix, los nombres que comienzan con punto suelen tratarse como ocultos en muchas herramientas. En Windows, la visibilidad puede depender de atributos y de la configuración del explorador.

No modifiques o elimines un archivo oculto solo porque no reconoces su función.

> **Regla de seguridad:** antes de modificar o eliminar un archivo desconocido, investiga para qué sirve y confirma que cuentas con una copia o un método de recuperación.

Más adelante estudiaremos archivos de configuración importantes y explicaremos por qué ciertos archivos sensibles, como `.env`, no deben publicarse en un repositorio.

---

## 13. Nombres de archivo recomendables

Un buen nombre facilita la organización y la colaboración.

### Nombres poco informativos

```text
nuevo.txt
documento2.txt
cosas.txt
final-final.txt
```

### Nombres más claros

```text
lista-de-materiales.txt
acta-reunion-2026-10-01.md
presupuesto-proyecto.csv
guia-instalacion.md
```

### Recomendaciones generales

* Utiliza nombres descriptivos.
* Mantén un criterio coherente en todo el proyecto.
* Evita nombres ambiguos como `nuevo`, `cosas` o `varios`.
* No dependas únicamente de palabras como `final` o `definitivo` para distinguir versiones.
* Evita caracteres que puedan causar problemas entre sistemas o herramientas.
* Considera utilizar guiones para separar palabras cuando el proyecto lo requiera.

No existe una única convención válida para todos los equipos. Lo importante es elegir reglas adecuadas al contexto y aplicarlas de manera consistente.

---

## 14. Mayúsculas y minúsculas

Los sistemas operativos y sistemas de archivos no siempre tratan de la misma forma las mayúsculas y las minúsculas.

Estos nombres podrían considerarse diferentes en algunos entornos:

```text
README.md
readme.md
Readme.md
```

En otros entornos podrían producir confusión o ser tratados como equivalentes en determinadas operaciones.

Esto importa cuando un proyecto se comparte entre personas que utilizan Windows, macOS o Linux.

### Buena práctica

Elige una convención y respétala. Si el archivo se llama `README.md`, utiliza exactamente ese nombre al mencionarlo o enlazarlo.

---

## 15. Un archivo puede cambiar aunque conserve su nombre

El nombre no describe el estado completo de un archivo.

Considera este caso:

```text
lunes:   notas.txt contiene una lista inicial
martes:  notas.txt contiene una lista corregida
viernes: notas.txt contiene una lista ampliada
```

El archivo continúa llamándose `notas.txt`, pero su contenido cambia con el tiempo.

Esta idea es fundamental para comprender el control de versiones:

```text
Mismo nombre
     │
     ├── contenido en un momento anterior
     ├── contenido actual
     └── posibles contenidos futuros
```

Git permite registrar estados del proyecto y relacionarlos dentro de un historial. Aprenderemos este proceso gradualmente en módulos posteriores.

---

## 16. Errores comunes

### Error 1: pensar que el nombre es el contenido

Renombrar un archivo no equivale a modificar la información que contiene.

### Error 2: creer que cambiar la extensión convierte el formato

Cambiar `.jpg` por `.pdf` en el nombre no realiza una conversión real.

### Error 3: guardar sin comprobar la ubicación

Puedes crear correctamente un archivo y después no encontrarlo porque fue guardado en una carpeta diferente de la esperada.

### Error 4: confundir guardar con crear una copia

La opción **Guardar** suele actualizar el archivo actual. **Guardar como** puede crear otro archivo, según el programa y las opciones seleccionadas.

### Error 5: pensar que guardar crea una versión en Git

Guardar permite que Git detecte el cambio, pero no crea automáticamente un commit.

### Error 6: eliminar un archivo sin revisar su función

Un archivo con un nombre desconocido podría ser necesario para el sistema o el proyecto. Investiga antes de eliminarlo.

### Error 7: confiar únicamente en la papelera

No todas las eliminaciones pasan por una papelera y no todos los entornos permiten recuperar un archivo fácilmente. Las copias de seguridad y el control de versiones resuelven problemas relacionados, pero no idénticos.

---

## 17. Seguridad básica

Un archivo puede contener información sensible.

Ejemplos:

```text
contraseñas
tokens de acceso
claves API
claves privadas
datos personales
información financiera
configuración confidencial
```

No publiques un archivo sin revisar su contenido.

En los ejemplos de este curso utilizaremos valores ficticios como:

```text
API_KEY=TU_API_KEY_AQUI
TOKEN=[REDACTADO]
```

Nunca utilizaremos credenciales reales.

También debes recordar que cambiar el nombre de un archivo sensible o hacerlo oculto no protege su contenido. La seguridad requiere controles adecuados, como permisos, cifrado, gestión de secretos y exclusión del repositorio cuando corresponda.

---

## 18. Práctica guiada

En esta práctica crearás y modificarás un archivo de texto mediante una aplicación gráfica. No necesitas utilizar comandos.

### Objetivo

Observar la diferencia entre:

* crear un archivo;
* asignarle un nombre;
* guardar contenido;
* modificarlo;
* crear una segunda copia.

### Paso 1: abre un editor de texto

Puedes utilizar un editor sencillo disponible en tu sistema.

No utilices información privada para esta práctica.

### Paso 2: escribe el contenido inicial

```text
Mi primer archivo de práctica.
```

### Paso 3: guarda el archivo

Utiliza este nombre:

```text
mi-primer-archivo.txt
```

Antes de confirmar, observa en qué carpeta se guardará.

### Paso 4: cierra y vuelve a abrir el archivo

Comprueba que el contenido continúa disponible.

### Paso 5: modifica el contenido

Déjalo así:

```text
Mi primer archivo de práctica.
Ahora contiene una segunda línea.
```

Guarda los cambios.

### Paso 6: utiliza «Guardar como»

Crea otro archivo llamado:

```text
mi-primer-archivo-copia.txt
```

### Resultado esperado

Deberías tener dos archivos:

```text
mi-primer-archivo.txt
mi-primer-archivo-copia.txt
```

Ábrelos y comprueba su contenido. Dependiendo del momento en que utilizaste **Guardar como**, ambos podrían comenzar con el mismo contenido, pero ahora son archivos independientes.

---

## 19. Experimento controlado

Realiza este ejercicio únicamente con los archivos de práctica que acabas de crear.

1. Cambia el contenido de `mi-primer-archivo-copia.txt`.
2. Guarda el cambio.
3. Abre `mi-primer-archivo.txt`.
4. Comprueba si también cambió.

### Preguntas

* ¿Los dos archivos tienen el mismo nombre?
* ¿Se encuentran en la misma ubicación?
* ¿Modificar uno modifica automáticamente el otro?
* ¿Qué información te permite distinguirlos?

El propósito es comprobar que una copia deja de depender del archivo original: cada archivo puede evolucionar por separado.

---

## 20. Ejercicio de análisis

Observa estos nombres:

```text
documento.txt
documento-copia.txt
documento-final.txt
documento-final-2.txt
documento-final-definitivo.txt
```

Responde:

1. ¿Cuál parece ser la versión más reciente?
2. ¿Puedes saberlo con absoluta certeza observando únicamente los nombres?
3. ¿Puedes saber qué cambió entre dos archivos sin abrirlos o compararlos?
4. ¿Qué ocurriría si dos personas crearan su propia versión «final»?
5. ¿Qué problema podría resolver un sistema de control de versiones?

No busques una respuesta memorizada. El objetivo es reconocer las limitaciones de administrar versiones exclusivamente mediante copias y nombres.

---

## 21. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es un archivo;
* qué diferencia existe entre nombre y contenido;
* por qué la ubicación es importante;
* qué sucede cuando guardas una modificación;
* por qué cambiar la extensión no convierte necesariamente el formato;
* qué diferencia general existe entre un archivo de texto y uno binario;
* por qué guardar un archivo no crea un commit;
* por qué un nombre como `final-definitivo` no sustituye un historial de versiones.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## 22. Resumen

En este capítulo aprendiste que:

* un archivo es una unidad de información almacenada bajo un nombre;
* el nombre, el contenido, el tipo y la ubicación son conceptos diferentes;
* los metadatos describen características del archivo;
* crear, abrir, modificar, guardar, copiar y renombrar son operaciones distintas;
* un archivo puede cambiar sin cambiar de nombre;
* los archivos de texto y binarios presentan diferencias relevantes para el control de versiones;
* guardar un archivo no crea automáticamente un commit;
* un commit local tampoco equivale a publicar información en GitHub;
* los archivos pueden contener datos sensibles que nunca deben publicarse sin revisión;
* los nombres descriptivos y consistentes facilitan el trabajo individual y en equipo.

La idea principal es:

> **Un archivo no es solamente un nombre visible: es información almacenada, ubicada dentro de un sistema y capaz de cambiar con el tiempo.**

---

## Próximo paso

Ya sabes qué es un archivo. El siguiente paso es comprender cómo se agrupan y organizan varios archivos.

Continúa con:

[`02-que-es-una-carpeta.md`](02-que-es-una-carpeta.md)
