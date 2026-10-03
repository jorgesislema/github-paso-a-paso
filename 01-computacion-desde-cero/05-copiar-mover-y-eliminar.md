# Copiar, mover y eliminar

## Introducción

Hasta ahora hemos estudiado qué son los archivos, qué son las carpetas, cómo se expresa su ubicación y cómo se identifican por su extensión.

Ahora llega un tema muy importante: **modificar la estructura del proyecto**.

Copiar, mover, renombrar y eliminar son operaciones cotidianas. Parecen sencillas, y en gran medida lo son. Sin embargo, algunas de ellas pueden destruir información, y cuando trabajamos con Git o con proyectos compartidos tienen consecuencias adicionales que conviene comprender desde el principio.

En este capítulo aprenderás:

* qué significa copiar, mover, renombrar y eliminar;
* qué diferencia existe entre copiar y mover;
* qué ocurre con el contenido de una carpeta al copiarla o moverla;
* por qué renombrar un archivo es, en cierto sentido, moverlo;
* qué es la papelera y qué limitaciones tiene;
* por qué una operación destructiva debe realizarse con precaución;
* qué relación tienen estas operaciones con Git;
* qué errores son habituales y cómo evitarlos.

---

## 1. Una primera explicación

Imagina que tienes una carpeta con documentos importantes.

```text
documentos/
├── informe.docx
├── carta.docx
└── notas.txt
```

Ahora quieres:

* guardar una segunda versión del informe sin perder la original;
* cambiar una carta de lugar;
* darle un nombre más claro a las notas;
* deshacerte de un archivo que ya no necesitas.

Cada una de esas intenciones corresponde a una operación diferente:

```text
Guardar una segunda versión sin perder la original  →  copiar
Cambiar algo de lugar                               →  mover
Darle otro nombre                                   →  renombrar
Deshacerse de algo                                  →  eliminar
```

Parecen operaciones triviales, y en la vida cotidiana lo son.

Pero cuando trabajamos con información importante, la diferencia entre copiar y mover, o entre eliminar de forma recuperable y eliminar de forma permanente, puede ser decisiva.

---

## 2. Copiar

**Copiar** significa crear un duplicado de un archivo o de una carpeta.

El original permanece donde estaba.

### Copiar un archivo

```text
Antes:
documentos/
└── informe.docx

Después de copiarlo como informe-copia.docx:
documentos/
├── informe.docx
└── informe-copia.docx
```

Ahora existen dos archivos independientes.

### Copiar una carpeta

Al copiar una carpeta, se copia todo su contenido.

```text
Antes:
proyecto/
└── documentos/
    ├── informe.docx
    └── carta.docx

Después de copiar documentos/ como documentos-copia/:
proyecto/
├── documentos/
│   ├── informe.docx
│   └── carta.docx
└── documentos-copia/
    ├── informe.docx
    └── carta.docx
```

La copia contiene los mismos elementos, pero ya no está vinculada al original.

### ¿Qué significa que sean independientes?

Significa que modificar la copia no modifica el original, y viceversa.

```text
informe.docx          informe-copia.docx
     │                       │
     └── contenido A         └── contenido A

Modificas la copia:

informe.docx          informe-copia.docx
     │                       │
     └── contenido A         └── contenido B
```

Esta independencia es útil, pero también implica que deberás administrar ambos archivos por separado.

### Copiar en el explorador de archivos

El procedimiento general es similar en todos los sistemas:

1. Selecciona el archivo o la carpeta.
2. Elige la opción **Copiar**.
3. Abre la ubicación de destino.
4. Elige la opción **Pegar**.

También suelen existir atajos de teclado para estas operaciones. Los atajos concretos varían según el sistema.

---

## 3. Mover

**Mover** significa cambiar la ubicación de un archivo o de una carpeta.

El elemento deja de estar en el lugar original y pasa a estar en otro.

### Mover un archivo

```text
Antes:
proyecto/
├── documentos/
│   └── informe.docx
└── archivo/

Después de mover informe.docx a archivo/:
proyecto/
├── documentos/
└── archivo/
    └── informe.docx
```

El archivo ya no está en `documentos`. Ahora está en `archivo`.

Sigue existiendo un solo archivo, pero en otra ubicación.

### Mover una carpeta

Al mover una carpeta, se mueve todo su contenido.

```text
Antes:
proyecto/
├── documentos/
│   ├── informe.docx
│   └── carta.docx
└── archivo/

Después de mover documentos/ a archivo/:
proyecto/
└── archivo/
    └── documentos/
        ├── informe.docx
        └── carta.docx
```

Los archivos internos no se quedaron atrás. Se trasladaron junto con la carpeta.

### Diferencia clave entre copiar y mover

```text
Copiar  →  el original permanece
Mover   →  el original cambia de lugar
```

Esta diferencia parece simple, pero tiene consecuencias importantes.

### Mover en el explorador de archivos

El procedimiento general es:

1. Selecciona el archivo o la carpeta.
2. Elige la opción **Cortar**.
3. Abre la ubicación de destino.
4. Elige la opción **Pegar**.

Muchos sistemas también permiten arrastrar y soltar el elemento hasta su nueva ubicación.

> **Precaución:** al arrastrar y soltar, algunos sistemas copian y otros mueven, según la ubicación de origen y de destino y según las teclas que se mantengan pulsadas. Antes de confirmar, comprueba qué operación está realizando el sistema.

---

## 4. Renombrar

**Renombrar** significa cambiar el nombre de un archivo o de una carpeta.

```text
Antes:
notas.txt

Después:
notas-proyecto.txt
```

El contenido no cambia. Solo cambia el nombre.

### Renombrar es una forma de mover

Técnicamente, cambiar el nombre de un archivo puede considerarse un cambio de ubicación dentro del mismo sistema de archivos: el contenido permanece, pero la referencia con la que se identifica cambia.

Esta idea se comprenderá mejor cuando estudiemos Git, porque Git registra tanto el contenido como la estructura del proyecto.

### Consecuencias de renombrar

Renombrar un archivo puede afectar a:

* enlaces que apuntan a ese archivo;
* programas que esperan encontrar un nombre concreto;
* documentación que menciona el nombre anterior;
* referencias dentro de otros archivos;
* el historial del proyecto, si se está utilizando control de versiones.

### El caso especial de renombrar la carpeta de un proyecto

Si renombras la carpeta principal de un proyecto, puedes romper referencias externas o configuraciones que apuntan a la ruta anterior.

```text
Antes:
C:\proyectos\mi-proyecto

Después:
C:\proyectos\mi-proyecto-nuevo
```

Los archivos internos siguen intactos, pero cualquier ruta absoluta que apuntara a la ubicación anterior dejará de funcionar.

---

## 5. Eliminar

**Eliminar** significa quitar un archivo o una carpeta del sistema.

### Eliminar un archivo

```text
Antes:
proyecto/
├── informe.docx
└── notas.txt

Después de eliminar notas.txt:
proyecto/
└── informe.docx
```

### Eliminar una carpeta

Al eliminar una carpeta, se elimina también todo su contenido.

```text
Antes:
proyecto/
└── documentos/
    ├── informe.docx
    └── carta.docx

Después de eliminar documentos/:
proyecto/
└── (vacío)
```

Los archivos internos se eliminan junto con la carpeta.

> **Advertencia importante:** eliminar una carpeta es una operación que afecta a todo su contenido. Antes de hacerlo, revisa qué hay dentro.

### Papelera y eliminación permanente

En muchos sistemas, al eliminar un archivo este pasa a una **papelera de reciclaje**, desde donde puede restaurarse durante un tiempo.

```text
Archivo
   │
   │ eliminar
   ▼
Papelera
   │
   ├── restaurar  →  el archivo vuelve
   └── vaciar     →  el archivo se elimina de forma permanente
```

### Limitaciones de la papelera

La papelera no garantiza la recuperación en todos los casos:

* puede vaciarse automáticamente después de cierto tiempo;
* algunos sistemas no utilizan papelera para determinadas ubicaciones;
* las unidades de red y las memorias externas pueden comportarse de forma diferente;
* los comandos de la terminal suelen eliminar de forma permanente, sin pasar por la papelera;
* eliminar dentro de una carpeta sincronizada con la nube puede replicar la eliminación en otros dispositivos.

> **Conclusión práctica:** no confíes únicamente en la papelera como mecanismo de recuperación.

### Eliminación permanente

En algunos contextos, el archivo no pasa por una papelera y se elimina directamente.

Recuperarlo puede requerir herramientas especializadas y no siempre es posible.

---

## 6. La importancia de la copia de seguridad

Las operaciones de este capítulo modifican la estructura del proyecto.

Copiar no destruye información. Mover y renombrar pueden romper referencias. Eliminar puede destruir contenido.

Por eso conviene recordar:

```text
Antes de una operación destructiva:
    1. Comprender qué hace.
    2. Comprobar sobre qué elemento actúa.
    3. Confirmar que existe una copia o un método de recuperación.
```

Una copia de seguridad permite recuperar información si algo sale mal.

### Git como forma de recuperación

El control de versiones permite recuperar estados anteriores del proyecto, siempre que esos estados hayan sido registrados.

Esto significa que Git puede ayudarte a recuperar:

* un archivo eliminado que ya formaba parte del historial;
* una versión anterior de un archivo modificado;
* un estado completo del proyecto.

Pero Git no es un sistema de copia de seguridad externa por sí solo. Este tema se estudiará con detalle en módulos posteriores.

> **Idea clave:** Git puede recuperar lo que fue registrado. No puede recuperar lo que nunca se guardó en el historial.

---

## 7. Cómo se relacionan estas operaciones con Git

Cuando comiences a trabajar con Git, estas operaciones adquirirán una dimensión adicional.

Git no solo registra el contenido de los archivos. También registra la **estructura del proyecto**: qué archivos existen y dónde están ubicados.

Por eso, cuando en un repositorio:

* creas un archivo;
* mueves un archivo;
* renombras un archivo;
* eliminas un archivo;

Git puede detectar el cambio y mostrarlo en el estado del proyecto.

### Ejemplo conceptual

```text
Antes:
proyecto/
├── notas.txt
└── informe.txt

Después de renombrar notas.txt como apuntes.txt:
proyecto/
├── apuntes.txt
└── informe.txt
```

Git podría interpretar este cambio como:

* eliminación de `notas.txt`;
* creación de `apuntes.txt`;

o bien, si el contenido es suficientemente similar, reconocerlo como un **renombrado**.

Esta distinción se estudiará más adelante, cuando trabajemos con el historial.

### Lo importante por ahora

Estas operaciones no son solo acciones del sistema de archivos. Cuando se realizan dentro de un repositorio Git, forman parte de los cambios que Git puede registrar.

---

## 8. Operaciones destructivas

Algunas operaciones pueden provocar pérdida de información.

### Eliminar sin copia de seguridad

```text
Eliminar un archivo sin respaldo
```

Si el archivo no está en la papelera, en una copia de seguridad ni en el historial de Git, puede perderse definitivamente.

### Vaciar la papelera

```text
Vaciar la papelera
```

Elimina de forma permanente todos los elementos que contiene.

### Sobrescribir un archivo al copiar

Si copias un archivo sobre otro con el mismo nombre en el destino, podrías reemplazar el contenido original.

```text
Destino:
informe.docx

Acción:
Copiar otro archivo con el mismo nombre

Resultado posible:
El archivo de destino se reemplaza
```

Muchos sistemas piden confirmación, pero no debes depender de ello.

### Mover una carpeta que contiene archivos importantes

Si mueves una carpeta por error, puedes romper la estructura de un proyecto y las referencias que dependían de ella.

### Recomendación general

> **Antes de ejecutar una operación destructiva, comprende exactamente qué va a ocurrir.**

Esta regla se aplicará también, y con mayor razón, a comandos de Git como `git reset --hard`, `git clean` y `git push --force`, que estudiaremos en su momento con las advertencias correspondientes.

---

## 9. Errores comunes

### Error 1: confundir copiar con mover

Al copiar, el original permanece. Al mover, cambia de lugar. Si esperabas conservar el original y utilizaste **Cortar**, ya no estará donde estaba.

### Error 2: pegar en la ubicación equivocada

Un archivo movido a una carpeta incorrecta puede parecer perdido. Antes de pegar, verifica la ubicación de destino.

### Error 3: sobrescribir sin leer el mensaje de confirmación

Los sistemas suelen advertir cuando un archivo será reemplazado. Lee el mensaje antes de aceptar.

### Error 4: eliminar una carpeta sin revisar su contenido

La carpeta puede contener archivos importantes que no ves en una vista superficial.

### Error 5: confiar en la papelera

La papelera puede vaciarse o no estar disponible en todos los contextos.

### Error 6: renombrar sin actualizar referencias

Otros archivos, programas o documentación pueden depender del nombre anterior.

### Error 7: asumir que una operación es reversible

No todas las operaciones pueden deshacerse fácilmente. Algunas no pueden deshacerse en absoluto.

### Error 8: trabajar sin copia de seguridad

Una copia de seguridad convierte un error grave en un inconveniente menor.

---

## 10. Buenas prácticas

* Antes de eliminar, revisa el contenido y confirma que tienes una copia.
* Utiliza nombres claros para las copias, sin depender de `copia`, `final` o `definitivo`.
* Verifica la ubicación de destino antes de mover o pegar.
* Lee los mensajes de confirmación del sistema.
* Mantén copias de seguridad de la información importante.
* Utiliza Git para registrar estados del proyecto y facilitar la recuperación.
* Documenta la estructura del proyecto cuando sea necesario.
* No realices operaciones destructivas sin comprender sus consecuencias.

---

## 11. Práctica guiada

En esta práctica trabajarás con archivos y carpetas de prueba. No necesitas utilizar comandos.

> **Advertencia:** realiza esta práctica únicamente con los archivos creados en ella. No experimentes con información importante.

### Objetivo

Comprender la diferencia entre copiar, mover, renombrar y eliminar.

### Paso 1: prepara el entorno

Crea una carpeta llamada:

```text
practica-operaciones
```

Dentro de ella, crea esta estructura:

```text
practica-operaciones/
├── origen/
│   └── archivo.txt
└── destino/
```

Contenido de `archivo.txt`:

```text
Este archivo se utilizará para practicar operaciones.
```

### Paso 2: copia el archivo

Copia `archivo.txt` desde `origen/` hacia `destino/`.

### Resultado esperado

```text
practica-operaciones/
├── origen/
│   └── archivo.txt
└── destino/
    └── archivo.txt
```

Comprueba que ahora existen dos archivos y que el original sigue en su lugar.

### Paso 3: modifica la copia

Abre `destino/archivo.txt` y agrega una línea:

```text
Este archivo se utilizará para practicar operaciones.
Esta línea se agregó únicamente en la copia.
```

Guarda el cambio.

### Paso 4: verifica la independencia

Abre `origen/archivo.txt`.

Comprueba que el original no cambió.

### Paso 5: renombra el archivo original

Renombra `origen/archivo.txt` como:

```text
origen/apuntes.txt
```

### Resultado esperado

```text
practica-operaciones/
├── origen/
│   └── apuntes.txt
└── destino/
    └── archivo.txt
```

### Paso 6: mueve la copia

Mueve `destino/archivo.txt` a la carpeta `origen/`.

### Resultado esperado

```text
practica-operaciones/
├── origen/
│   ├── apuntes.txt
│   └── archivo.txt
└── destino/
```

Comprueba que `destino/` quedó vacía y que el archivo se encuentra ahora en `origen/`.

---

## 12. Experimento controlado

Este experimento te permitirá comprobar el comportamiento de la eliminación.

> **Advertencia:** utiliza únicamente archivos de práctica.

### Pasos

1. Dentro de `practica-operaciones/origen`, elimina `archivo.txt` utilizando el mecanismo habitual del sistema.
2. Comprueba si el archivo está en la papelera.
3. Restáuralo si es posible.
4. Si tu sistema lo permite, elimínalo de forma permanente.
5. Observa la diferencia entre ambas situaciones.

### Preguntas

* ¿En qué casos la eliminación fue recuperable?
* ¿Qué ocurrió al eliminar de forma permanente?
* ¿Qué habría pasado si el archivo fuera importante?
* ¿Qué mecanismo adicional podría haber protegido la información?

### Conclusión esperada

La eliminación puede ser recuperable o permanente según el mecanismo utilizado. Por eso conviene disponer de copias de seguridad y, cuando corresponda, de un historial de versiones.

---

## 13. Ejercicio de análisis

Imagina que tienes este proyecto:

```text
proyecto/
├── documentos/
│   ├── informe-final.docx
│   └── informe-final-2.docx
├── imagenes/
│   └── portada.png
└── datos.csv
```

Se han realizado estas operaciones:

1. Se copió `datos.csv` a `documentos/datos.csv`.
2. Se movió `imagenes/portada.png` a `documentos/`.
3. Se renombró `informe-final-2.docx` como `informe-final-corregido.docx`.
4. Se eliminó `datos.csv` de la raíz del proyecto.

Responde:

1. ¿Cuál es la estructura resultante?
2. ¿Qué archivos existen ahora?
3. ¿Qué operación fue destructiva?
4. ¿Qué operación podría romper referencias?
5. ¿Qué debería haberse hecho antes de eliminar el archivo?

---

## 14. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué diferencia existe entre copiar y mover;
* qué ocurre con el contenido de una carpeta al copiarla o moverla;
* por qué renombrar es una forma de mover;
* qué es la papelera y qué limitaciones tiene;
* por qué no toda eliminación es recuperable;
* qué relación tienen estas operaciones con Git;
* qué significa realizar una operación destructiva;
* por qué conviene tener una copia de seguridad antes de operaciones peligrosas.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## 15. Resumen

En este capítulo aprendiste que:

* copiar crea un duplicado y conserva el original;
* mover cambia la ubicación y no conserva el original en su lugar anterior;
* al copiar o mover una carpeta, se traslada todo su contenido;
* renombrar cambia el nombre y puede romper referencias;
* eliminar puede ser recuperable o permanente según el mecanismo utilizado;
* la papelera no garantiza la recuperación en todos los casos;
* las operaciones destructivas requieren comprensión previa y precaución;
* Git puede registrar estas operaciones cuando ocurren dentro de un repositorio;
* Git puede facilitar la recuperación de estados registrados, pero no sustituye una copia de seguridad;
* antes de eliminar, mover o sobrescribir, conviene verificar el contenido y la ubicación.

La idea principal es:

> **Copiar, mover y eliminar parecen operaciones simples, pero modifican la estructura del proyecto y pueden tener consecuencias difíciles de revertir si no se comprenden.**

---

## Próximo paso

Ya sabes cómo se organizan y modifican los archivos y las carpetas.

El siguiente paso es comprender qué es un programa y cómo se diferencia de los datos que hemos estudiado hasta ahora.

Continúa con:

[`06-que-es-un-programa.md`](06-que-es-un-programa.md)
