# git reset

## Introducción

`git reset` es el comando que mueve el apuntador de la rama a otro commit.

Con él puedes deshacer commits, corregir mensajes y dejar preparado un estado diferente.

A cambio, conviene entender qué toca y qué no toca, porque sus variantes pueden llegar a descartar trabajo local.

En este capítulo aprenderás:

* qué es exactamente el apuntador de la rama;
* qué hace `git reset` por defecto y qué NO modifica;
* los tres modos del comando: `--soft`, `--mixed` y `--hard`;
* por qué este comando solo debe usarse con historial no compartido;
* cómo funciona el reflog como red de seguridad;
* un ejemplo completo desde cero hasta la recuperación.

El capítulo siguiente profundiza en cada modo. Aquí la meta es entender la idea central y sus límites.

---

## 1. Mover el apuntador de la rama

Cada rama es, en realidad, un apuntador que señala a un commit.

```text
Historial:

A ─── B ─── C ─── D
                  ▲
                  │
                 main
```

La rama `main` no es una lista de commits: es una etiqueta que apunta a `D`.

Cuando creas un commit nuevo, la etiqueta simplemente se mueve al nuevo commit.

`git reset` hace lo mismo, pero hacia atrás:

```bash
git reset C
```

Después de este comando:

```text
Historial:

A ─── B ─── C ─── D
              ▲
              │
             main
```

El commit `D` ya no está señalado por `main`, pero sigue existiendo dentro del repositorio local.

No se borró: solo dejó de estar al final de la rama.

Y ese «aunque no lo señale nadie, sigue ahí» es exactamente lo que permite recuperar después.

---

## 2. Lo que git reset NO toca por defecto

Aquí está la parte que más conviene tener clara.

Cuando ejecutas `git reset` sin opciones adicionales, el modo por defecto es `--mixed`.

Y `--mixed` hace dos cosas, y solo dos:

1. mueve el apuntador de la rama al commit indicado;
2. reconstruye el índice a partir de ese commit.

Lo que NO hace: modificar el directorio de trabajo.

Volvamos al ejemplo anterior.

Si `D` contenía un archivo `leeme.txt` con una línea nueva, y ejecutas:

```bash
git reset C
```

El resultado es:

```text
Rama main:           apunta a C
Índice:              igual que C
Directorio de trabajo: conserva la línea nueva de D,
                       ahora marcada como «modificada, sin preparar»
```

El archivo sigue con su contenido en tu disco.

Git simplemente dejó de considerarlo parte del último commit.

Puedes comprobarlo con:

```bash
git status
```

Salida posible:

```text
On branch main
Changes not staged for commit:
  modified:   leeme.txt
```

Por eso `git reset` (sin `--hard`) es una operación «hacia atrás pero sin pérdida»: el trabajo local se conserva.

Si quieres descartarlo también, esa es otra decisión explícita, y la estudiamos con `--hard` en el próximo capítulo.

---

## 3. Los tres modos: soft, mixed y hard

`git reset` admite tres modos que determinan qué pasa con el índice y con el directorio de trabajo.

La rama, en los tres, se mueve al commit indicado.

Lo que cambia es el resto.

| Modo | ¿Mueve la rama? | ¿Toca el índice? | ¿Toca el directorio de trabajo? |
|---|---|---|---|
| `--soft` | Sí | No | No |
| `--mixed` (por defecto) | Sí | Sí | No |
| `--hard` | Sí | Sí | Sí (descarta cambios) |

Con `--soft`, todo lo que estaba en el commit queda preparado de nuevo, listo para crear un commit diferente.

Con `--mixed`, se desprepara: los cambios quedan sueltos en el directorio de trabajo.

Con `--hard`, se descartan los cambios locales del directorio de trabajo: es la variante peligrosa.

El próximo capítulo dedica una práctica completa a cada uno.

Aquí basta con conocer la dirección de cada variante.

```text
git reset --soft  → la rama retrocede, el índice conserva todo preparado
git reset --mixed → la rama retrocede, el índice se limpia, el trabajo queda suelto
git reset --hard  → la rama retrocede, el índice y el trabajo vuelven al commit destino
```

---

## 4. La advertencia: solo para historial que no compartiste

Ahora viene la regla de oro de `git reset`.

```text
¿El commit está solo en mi computadora?
        │
        ├── Sí  → puedo mover el apuntador sin problemas
        │
        └── No  → no lo toco; uso git revert
```

Cuando un commit ya fue enviado con `git push`, otras personas lo tienen en sus repositorios.

Si mueves tu rama hacia atrás y vuelves a enviar, tu historia local deja de coincidir con la historia que ellos conocen.

Git lo detecta y te pide una fuerza explícita:

```text
To github.com:usuario/prueba.git
 ! [rejected]        main -> main (non-fast-forward)
```

Y entonces aparece la tentación de ejecutar:

```bash
git push --force
```

`git push --force` reemplaza el historial remoto con el tuyo.

Tú lo logras, sí. Pero cualquier persona que ya hubiera trabajado sobre ese historial se encuentra de golpe con un pasado que cambió.

En un equipo, una fuerza así puede borrar horas de trabajo de otras personas.

Por eso la norma profesional es:

> **Nunca hagas fuerza sobre una rama compartida sin coordinación explícita con el equipo.**

Y, cuando existe una alternativa segura, úsala: `git revert` corrige el efecto de un commit sin reescribir el pasado.

En repositorios personales y de estudio, en cambio, mover el historial local es perfectamente normal y es parte del aprendizaje.

---

## 5. El reflog como red de seguridad

«El commit ya no lo señala ninguna rama» suena a pérdida total.

Pero Git registra, además de los commits, los movimientos de las referencias locales.

Ese registro se llama **reflog**.

```text
Historial visible (git log):

A ─── B ─── C
        ▲
      main

Reflog (registro interno de movimientos de HEAD):

0  reset: moving to C
1  commit: Añadir la página de contacto
2  commit: Corregir el título
3  commit: Crear la estructura inicial
```

Cada movimiento importante de HEAD queda anotado con una fecha, un hash y la operación.

Para verlo:

```bash
git reflog
```

Salida posible:

```text
1d04f5b HEAD@{0}: reset: moving to HEAD~1
b7e8d1a HEAD@{1}: commit: Añadir la página de contacto
1d04f5b HEAD@{2}: commit: Corregir el título
9a2b314 HEAD@{3}: commit: Crear la estructura inicial
```

Observa: el hash `b7e8d1a` (el commit que «desapareció» de `git log`) aparece intacto en el reflog.

Para volver a señalarlo con la rama:

```bash
git reset --hard b7e8d1a
```

O, si prefieres no tocar el trabajo local:

```bash
git reset b7e8d1a
```

Y `git log` vuelve a mostrarlo al final de la rama.

El reflog es la red de seguridad que convierte los errores graves en errores recuperables.

Conviene consultar el reflog después de cualquier operación que parezca tener consecuencias, y acostumbrarse a su lectura antes de necesitarla de verdad.

Los registros del reflog tienen una vida limitada (por defecto, unos 30 días para commits ya alcanzados), así que recuperar pronto es mejor que recuperar tarde.

---

## 6. Ejemplo completo

Recorramos la situación de principio a fin.

### Paso 1: el estado inicial

```bash
git log --oneline
```

```text
b7e8d1a (HEAD -> main) Añadir la página de contacto
1d04f5b Corregir el título
9a2b314 Crear la estructura inicial
```

### Paso 2: el error

El commit `b7e8d1a` es equivocado: la página de contacto se añadió con la dirección incorrecta y todavía no se envió a GitHub.

### Paso 3: mover el apuntador

```bash
git reset --hard HEAD~1
```

La rama vuelve a `1d04f5b`. El directorio de trabajo se iguala a ese commit y la línea de la página de contacto desaparece del archivo.

### Paso 4: el repositorio «limpio» pero con una duda

```bash
git log --oneline
```

```text
1d04f5b (HEAD -> main) Corregir el título
9a2b314 Crear la estructura inicial
```

El commit `b7e8d1a` ya no aparece.

¿Se perdió? No. Está en el reflog.

### Paso 5: consultar la red de seguridad

```bash
git reflog
```

```text
1d04f5b HEAD@{0}: reset: moving to HEAD~1
b7e8d1a HEAD@{1}: commit: Añadir la página de contacto
1d04f5b HEAD@{2}: commit: Corregir el título
9a2b314 HEAD@{3}: commit: Crear la estructura inicial
```

El commit sigue ahí, con su hash.

### Paso 6: recuperar (si era necesario)

```bash
git reset --hard b7e8d1a
```

```bash
git log --oneline
```

```text
b7e8d1a (HEAD -> main) Añadir la página de contacto
1d04f5b Corregir el título
9a2b314 Crear la estructura inicial
```

Todo volvió a su sitio.

### Paso 7: corregir sin mover el historial

Ahora que el commit está de nuevo al final de la rama, lo correcto es rehacerlo:

```text
1. Modificar el archivo con la dirección correcta.
2. Preparar y crear un commit nuevo.
```

El historial queda así:

```text
b7e8d1a ─── c31e8f7 (main)
            (corregir dirección de contacto)
```

Y, cuando estés seguro, se envía:

```bash
git push
```

Ningún commit del historial local fue reescrito: el problema se resolvió añadiendo un commit de corrección.

### Variantes que se habrían podido usar

Si solo querías deshacer el commit conservando el archivo modificado:

```bash
git reset --soft HEAD~1
```

El cambio de la página de contacto queda preparado, listo para un commit nuevo con un mensaje mejor.

Si querías despreparar también:

```bash
git reset --mixed HEAD~1
```

El cambio queda suelto en el directorio de trabajo.

Y si querías descartarlo del todo:

```bash
git reset --hard HEAD~1
```

Cada variante deja el trabajo local en un estado distinto; el próximo capítulo las practica una por una.

---

## Práctica guiada

Utiliza un repositorio de prueba.

### Objetivo

Mover el apuntador de la rama y recuperar el commit mediante el reflog.

### Paso 1: prepara dos commits

Crea un repositorio de prueba y registra dos commits seguidos, por ejemplo:

```text
crear el archivo base
añadir una línea extra
```

### Paso 2: mueve la rama hacia atrás

```bash
git reset --hard HEAD~1
```

Comprueba:

```bash
git log --oneline
git status
```

El último commit ya no aparece en el historial y el estado está limpio.

### Paso 3: consulta el reflog

```bash
git reflog
```

Localiza el hash del commit que «desapareció».

### Paso 4: recupéralo

```bash
git reset --hard <hash-del-commit>
```

Comprueba con `git log --oneline` que volvió a su sitio.

### Paso 5: repite con --soft

Realiza el mismo ejercicio, pero esta vez usa `--soft`.

Observa la diferencia en `git status`: los cambios del commit deshacer quedan preparados en lugar de descartados.

### Resultado esperado

Deberías poder explicar:

* qué cambió en cada comando (`log`, `status`, `reflog`);
* por qué el reflog hizo posible la recuperación;
* cuál de los dos modos conservó el trabajo local.

---

## Errores comunes

### Error 1: ejecutar git reset sobre historial compartido sin pensarlo

Mover la rama hacia atrás y hacer fuerza para enviarla rompe el historial de otras personas.

Si el commit ya está en GitHub, la herramienta correcta es `git revert`.

### Error 2: confundir --mixed con --hard

Ambos mueven la rama, pero solo `--hard` descarta el trabajo local.

Un `--mixed` equivocado se recupera fácilmente; un `--hard` equivocado requiere el reflog.

### Error 3: no consultar el reflog después de un reset

El reflog es barato de leer y seguro de consultar.

Hábito recomendado: después de cualquier `git reset`, mirar `git reflog` y confirmar que el estado anterior está localizado.

### Error 4: creer que los commits «perdidos» se borraron del disco

Mientras el reflog (o cualquier referencia) los señale, los objetos siguen en el repositorio.

El reflog los protege durante un tiempo razonable.

### Error 5: utilizar HEAD~1 sin saber a qué apunta

El sufijo `~1` significa «un commit antes que el actual», y `~2` significa «dos antes».

Antes de usarlo, comprueba con `git log --oneline` qué commit es el destino.

### Error 6: tratar git reset como «la herramienta de deshacer genérica»

`git reset` mueve el apuntador de la rama.

Para cambios sin preparar, la herramienta es `git restore`.

Para historial compartido, la herramienta es `git revert`.

Cada una tiene su caso.

---

## Buenas prácticas

* Utiliza `git reset` únicamente sobre commits que no fueron enviados;
* Después de cada `reset`, ejecuta `git status` y `git reflog` para situarte;
* Usa `--soft` cuando quieras rehacer el commit conservando el trabajo preparado;
* Prefiere `--mixed` (por defecto) si quieres volver a decidir qué preparar;
* Reserva `--hard` para cuando estés seguro de descartar el trabajo local;
* Ante la duda sobre una rama compartida, pregunta antes de forzar.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué representa una rama dentro de Git;
* qué hace `git reset` por defecto y qué no modifica;
* qué diferencia existe entre `--soft`, `--mixed` y `--hard`;
* por qué `git reset` sobre historial compartido es un problema para el equipo;
* cómo localizar un commit «perdido» en el reflog;
* cómo recuperar el estado anterior tras un `reset --hard`;
* cuándo cada herramienta (`restore`, `revert`, `reset`) es la adecuada.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* una rama es un apuntador que señala a un commit;
* `git reset` mueve ese apuntador a otro commit;
* por defecto (`--mixed`) el índice se reconstruye y el directorio de trabajo no se toca;
* `--soft` conserva el trabajo preparado; `--hard` lo descarta;
* el comando es seguro sobre historial local y peligroso sobre historial compartido;
* el reflog registra los movimientos de HEAD y permite recuperar commits que dejaron de señalarse;
* la recuperación es un superpoder: Git lo registra casi todo.

La idea principal es:

> **git reset mueve el apuntador de la rama; el reflog guarda el rastro, y el historial compartido no se toca.**

---

## Próximo paso

El capítulo anterior daba la dirección de cada modo.

El siguiente los práctica uno a uno, con diagramas y ejemplos completos.

[`04-soft-mixed-hard.md`](04-soft-mixed-hard.md)
