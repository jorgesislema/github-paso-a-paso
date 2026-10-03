# git revert

## Introducción

En el capítulo anterior viste cómo deshacer cambios que todavía no fueron registrados.

Ahora aparece una situación diferente: el cambio equivocado ya es un commit, y tal vez ya fue enviado a GitHub.

Aquí entra `git revert`, el comando que crea un commit nuevo que deshace los cambios de otro commit.

La clave de este comando es que no borra nada del historial: solamente añade.

En este capítulo aprenderás:

* qué es `git revert` y por qué existe;
* por qué es la opción segura para historial compartido;
* cómo revertir un commit concreto;
* cómo revertir varios commits;
* cómo revertir una fusión (merge) con sus opciones;
* qué muestra la salida típica del comando;
* qué hacer si aparece un conflicto durante el proceso.

Al terminar, podrás corregir commits compartidos sin reescribir el pasado.

---

## 1. El problema: un commit que ya está compartido

Durante la sección anterior trabajaste únicamente con operaciones locales.

Cuando el historial vive solo en tu computadora, tienes libertad: puedes mover el apuntador de la rama hacia atrás y reordenar tus propios commits.

Pero el historial compartido cambia las reglas.

Supón este escenario:

```text
Tú creas un commit equivocado
        │
        ▼
Haces git push
        │
        ▼
El commit queda en GitHub
        │
        ▼
Otras personas hacen git pull
        │
        ▼
El commit equivocado ahora está en varias computadoras
```

Si ahora borraras ese commit de tu historial y volvieras a enviarlo, las otras personas verían un pasado diferente al que ya descargaron.

El resultado sería confusión, errores de sincronización y mucho trabajo extra para el equipo.

Por eso existe una regla fundamental de trabajo en equipo:

> **El historial que ya se compartió no se reescribe: se corrige añadiendo commits nuevos.**

`git revert` es la herramienta que aplica esa regla.

---

## 2. La idea de revertir: añadir, no borrar

`git revert` crea un commit nuevo cuyo contenido es exactamente lo contrario del commit que quieres deshacer.

```text
Historial antes de revertir:

A ─── B ─── C (añade una función con un error)
        ▲
        │
      main

Historial después de git revert C:

A ─── B ─── C ─── C' (deshace los cambios de C)
        ▲
        │
      main
```

El commit `C` sigue existiendo en el historial.

Lo que ocurre es que después de `C` aparece `C'`, un commit que revierte sus cambios.

Neto, el efecto es que el estado del proyecto vuelve a ser como si `C` nunca hubiera existido, pero sin tocar el pasado.

Esta es la diferencia esencial con los comandos que estudiaremos después:

| Comando | ¿Modifica el historial? | ¿Apta para historial compartido? |
|---|---|---|
| `git revert` | No: añade un commit nuevo | Sí |
| `git reset` | Sí: mueve el apuntador de la rama | Solo si no se compartió |
| `git restore` | No: solo mueve contenido local | Sí |

Para el historial compartido, `git revert` es la opción segura.

---

## 3. git revert hash: el caso básico

El punto de partida es conocer el hash del commit que quieres revertir.

```bash
git log --oneline
```

Salida posible:

```text
c84f1d2 Añadir el botón de exportación
1d04f5b Corregir el título de la página
9a2b314 Crear la estructura inicial
```

Supongamos que el botón de exportación tiene un error y quieres deshacer ese commit.

```bash
git revert c84f1d2
```

Antes de ejecutar el comando, el estado del repositorio debe estar limpio: sin cambios pendientes en el directorio de trabajo ni en el índice.

Si hay cambios pendientes, Git detiene la operación e indica que primero debes guardarlos (por ejemplo, con `git stash`, que estudiarás en esta misma sección) o registrarlos.

Si el historial no está limpio, Git rechaza el comando y muestra un mensaje similar a:

```text
error: your local changes would be overwritten by revert
```

El comando abre tu editor de texto con un mensaje de commit preparado:

```text
Revert 'Añadir el botón de exportación'

This reverts commit c84f1d2.
```

Al guardar y cerrar el editor, Git crea el commit de reversión y muestra algo como:

```text
[main a71c3f8] Revert 'Añadir el botón de exportación'
 Date: Fri Sep 26 16:42:10 2026 +0200
 2 files changed, 4 insertions(+), 18 deletions(-)
```

Puedes ver el commit creado con:

```bash
git log --oneline
```

Salida posible:

```text
a71c3f8 Revert 'Añadir el botón de exportación'
c84f1d2 Añadir el botón de exportación
1d04f5b Corregir el título de la página
9a2b314 Crear la estructura inicial
```

También puedes inspeccionar qué hizo el nuevo commit:

```bash
git show a71c3f8
```

La diferencia mostrada será el inverso de la diferencia original.

### Mantener el mensaje por defecto

Si no quieres editar el mensaje y prefieres aceptar el que Git propone, añade la opción `--no-edit`:

```bash
git revert --no-edit c84f1d2
```

El commit se crea directamente con el mensaje automático.

### Mejorar el mensaje

Un buen mensaje de reversión explica por qué se revirtió el commit.

En lugar del mensaje por defecto, puedes escribir algo como:

```text
Revert 'Añadir el botón de exportación'

El botón provocaba un error cuando el listado estaba vacío.

Se revierte temporalmente mientras se corrige el problema.
This reverts commit c84f1d2.
```

Explicar el motivo ayuda a quien lea el historial meses después.

---

## 4. Revertir varios commits

A veces el problema no es un solo commit, sino varios.

Hay dos formas habituales.

### Varios commits del historial reciente con un rango

Si quieres deshacer todo lo ocurrido desde el commit `1d04f5b` hasta el commit `c84f1d2` (ambos son ejemplos de hashes), se usa la sintaxis de rango:

```bash
git revert 1d04f5b..c84f1d2
```

El rango incluye todos los commits posteriores al primer hash y hasta el segundo, inclusive.

Git crea un commit de reversión por cada commit del rango, en orden inverso (el más reciente primero).

### Varios commits puntuales en una sola línea

También puedes enumerar los commits concretos:

```bash
git revert 3fa9c11 c84f1d2
```

Cada commit indicado genera su reversión.

### Revertir sin crear commits todavía

Si quieres preparar varias revisiones y decidir después cómo registrarlas, usa `--no-commit`:

```bash
git revert --no-commit c84f1d2
```

El cambio queda preparado en el índice, sin crear el commit.

Puedes preparar varias revisiones seguidas y luego registrarlas en un commit único:

```bash
git revert --no-commit c84f1d2
git revert --no-commit 3fa9c11
git commit -m "Deshacer el botón de exportación y el ajuste de colores"
```

Este modo es útil para agrupar correcciones lógicas en un solo commit claro.

---

## 5. Revertir una fusión (merge)

Revertir un commit de fusión requiere una opción extra.

Un commit de fusión tiene dos padres: el estado de la rama donde estabas y el estado de la rama que fusionaste.

Para deshacer una fusión hay que indicar cuál de los dos lados se conserva:

```bash
git revert -m 1 9f31a02
```

La opción `-m 1` significa: «conserva el primer padre y deshaz lo que vino del segundo».

En la práctica, al revertir una fusión desde la rama principal:

* `-m 1` deshace los cambios que entraron por la rama fusionada;
* `-m 2` hace lo contrario: conserva los cambios de la rama fusionada y deshaz los de tu rama.

El caso habitual es `-m 1`, porque lo que se quiere deshacer es el trabajo que acabas de fusionar.

### El detalle importante al revertir una fusión

Hay un comportamiento que conviene conocer.

Cuando reviertes una fusión, Git recuerda que esa rama ya fue fusionada.

Si más adelante vuelves a fusionar la misma rama, los cambios que entraron originalmente no volverán por sí solos.

```text
main:  ... ─── M (fusión) ─── M' (revert de M)
              │
              └── la rama feature sigue apuntando a sus commits
```

Para volver a incorporar ese trabajo, primero se revierte el revert:

```bash
git revert <hash-del-commit-de-reversión>
```

Y después se fusiona la rama de nuevo.

Si el proceso parece tortuoso, la lección es sencilla: revertir una fusión es una decisión que conviene tomar con conocimiento.

---

## 6. Conflictos durante un revert

Cuando el commit que quieres revertir ya no aplica directamente sobre el estado actual, puede aparecer un conflicto.

```text
Conflicto en estilos.css
```

Git detiene la operación y te pide que resuelvas el conflicto, igual que en una fusión.

El flujo es:

```text
git revert c84f1d2
        │
        ▼
Conflicto detectado
        │
        ▼
Abres el archivo y marcas la parte correcta
        │
        ▼
git add estilos.css
        │
        ▼
git revert --continue
```

Si prefieres abandonar la reversión a medias y volver al estado anterior, se utiliza:

```bash
git revert --abort
```

Y si quieres pausar y continuar más adelante:

```bash
git revert --quit
```

Los conflictos de revert son una buena oportunidad para repasar lo aprendido en la sección de conflictos.

---

## 7. Comparación rápida: revert frente a reset

Esta tabla resume la diferencia práctica.

| Situación | Comando adecuado |
|---|---|
| Commit solo en mi computadora, no lo compartí | `git reset` (la próxima sección) |
| Commit ya enviado a GitHub | `git revert` |
| Cambié un archivo y no lo preparé | `git restore` |
| Quiero que el proyecto deje de tener el efecto de un commit, pero el historial siga siendo legible | `git revert` |
| Quiero eliminar por completo un commit de mi historial local | `git reset` |

La regla mental es:

```text
¿El commit se compartió?
        │
        ├── No  → puedes mover el historial (reset)
        │
        └── Sí  → solo puedes añadir (revert)
```

Un historial limpio y sin huecos es importante para ti, pero un historial estable y predecible es importante para todo el equipo.

---

## Práctica guiada

Utiliza un repositorio de prueba, no tu proyecto real.

### Objetivo

Comprender cómo `git revert` corrige un commit sin reescribir el historial.

### Paso 1: prepara el escenario

Crea un repositorio de prueba y registra un primer commit con un archivo `leeme.txt`.

Luego crea un segundo commit que añade una línea equivocada.

```bash
git log --oneline
```

Deberías ver algo como:

```text
e55d201 Añadir línea equivocada
1d04f5b Versión inicial
```

### Paso 2: identifica el hash

Copia el hash del commit que quieres revertir (`e55d201` en el ejemplo).

### Paso 3: ejecuta el revert

```bash
git revert --no-edit e55d201
```

### Paso 4: observa el historial

```bash
git log --oneline
```

Deberías ver tres commits: la versión inicial, el commit equivocado y el nuevo commit de reversión.

El commit equivocado no desapareció del historial: se corrigió añadiendo uno nuevo.

### Paso 5: revisa el contenido

Abre `leeme.txt` y comprueba que la línea equivocada ya no está.

```bash
git show
```

El último commit muestra el cambio invertido.

### Paso 6: revierte el revert

Para volver a tener la línea, revierte el commit de reversión:

```bash
git log --oneline
```

Toma el hash del commit de reversión y ejecuta:

```bash
git revert --no-edit <hash-del-revert>
```

El historial ahora tiene cuatro commits, y el contenido original vuelve a estar presente.

### Resultado esperado

Deberías poder explicar:

* cuántos commits se crearon en total;
* por qué el commit original sigue visible en el historial;
* por qué esta estrategia es segura para enviar a GitHub.

---

## Errores comunes

### Error 1: usar revert en commits que no se compartieron

`git revert` funciona siempre, pero para commits locales suele haber opciones más limpias, como `git reset`.

Utiliza `revert` cuando el historial es compartido o cuando quieres dejar constancia explícita de la corrección.

### Error 2: no dejar el repositorio limpio antes

Si tienes cambios pendientes, `git revert` se niega a funcionar.

Guarda o desvia esos cambios antes: `git stash` es la herramienta pensada para eso.

### Error 3: olvidarse de especificar -m al revertir una fusión

Revertir un commit de fusión sin `-m` produce un error.

Git necesita saber qué lado de la fusión conservar.

### Error 4: esperar que el historial se acorte

`git revert` nunca acorta el historial.

Si necesitas menos commits en la rama, esa es una operación local con `reset`, que tiene sus propios riesgos.

### Error 5: revertir sin saber por qué

Un commit de reversión sin contexto confunde a quien lee el historial después.

Escribe siempre el motivo de la reversión en el mensaje.

### Error 6: revertir la fusión y volver a fusionar esperando que todo vuelva

Como se explicó en la sección 5, al revertir una fusión Git recuerda que la rama ya se integró.

Los cambios no reaparecen solos: hay que revertir el revert antes de volver a fusionar.

---

## Buenas prácticas

* Utiliza `git revert` como primera opción para corregir commits compartidos;
* Deja el mensaje de reversión claro: qué se revierte y por qué;
* Usa `--no-edit` cuando el mensaje automático es suficiente y `--no-commit` para agrupar varias revisiones;
* Ante un conflicto, resuelve con calma: es el mismo flujo de los conflictos de fusión;
* Nunca combines `git revert` con fuerza bruta sobre ramas de otros: coordina primero;
* Recuerda que `git revert` añade commits: es seguro para el equipo, pero el historial crece.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué hace exactamente `git revert hash`;
* por qué no reescribe el historial;
* cómo revertir varios commits con un rango y cómo hacerlo con `--no-commit`;
* qué significa la opción `-m 1` al revertir una fusión;
* por qué, después de revertir una fusión, los cambios no vuelven solos al refusionar;
* qué hacer si aparece un conflicto durante el revert;
* cuándo elegir `revert` en lugar de `reset`.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* `git revert` crea un commit nuevo que deshace los cambios de otro commit;
* no modifica el historial existente: solo añade, por eso es seguro para historial compartido;
* el comando requiere un repositorio limpio antes de ejecutarse;
* se pueden revertir varios commits mediante un rango o mediante una lista;
* revertir una fusión exige la opción `-m` para indicar qué lado se conserva;
* los conflictos de revert se resuelven igual que los conflictos de fusión;
* la regla práctica es: historial compartido se corrige con `revert`; historial local se corrige con `reset`.

La idea principal es:

> **git revert corrige el pasado sin reescribirlo: añade un commit que deshace los cambios de otro.**

---

## Próximo paso

Ahora conoces la opción segura para historial compartido.

El siguiente capítulo estudia la herramienta para historial local: mover el apuntador de la rama hacia atrás.

[`03-git-reset.md`](03-git-reset.md)
