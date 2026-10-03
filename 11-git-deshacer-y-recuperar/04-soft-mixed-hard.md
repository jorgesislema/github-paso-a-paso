# git reset: soft, mixed y hard

## Introducción

En el capítulo anterior viste que `git reset` mueve el apuntador de la rama y que existen tres modos.

Ahora toca estudiarlos uno a uno.

Cada modo cambia el apuntador de forma distinta respecto al índice y al directorio de trabajo.

Comprender esa diferencia es lo que separa a quien usa `git reset` a ciegas de quien lo usa con criterio.

En este capítulo aprenderás:

* cómo funciona `git reset --soft`;
* cómo funciona `git reset --mixed` (el modo por defecto);
* cómo funciona `git reset --hard` y por qué es peligroso;
* qué deja preparado, qué desprepara y qué borra cada variante;
* cuándo conviene utilizar cada una;
* cómo practicar los tres modos en un repositorio de prueba.

---

## 1. El punto de partida: tres áreas y un apuntador

Recordemos el estado completo antes de ejecutar cualquier `reset`.

```text
DIRECTORIO DE TRABAJO     ÍNDICE             RAMA (apuntador)
─────────────────────     ──────             ────────────────
Estado actual de          Versiones          Señala al commit
los archivos en disco.    preparadas.        C.

Historial:
A ─── B ─── C ─── D
                  ▲
                  │
                 main
```

Cuando el estado está limpio, las tres zonas se corresponden entre sí.

El ejercicio de este capítulo consiste en crear situaciones donde no se corresponden, y utilizar cada modo de `reset` para ver qué se modifica y qué no.

```text
git reset --soft  → mueve la rama, deja el índice y el trabajo intactos
git reset --mixed → mueve la rama y reconstruye el índice
git reset --hard  → mueve la rama y reconstruye el índice y el trabajo
```

La intensidad crece. La precisión también debe crecer.

---

## 2. git reset --soft: la rama retrocede, todo queda preparado

Supongamos que creaste un commit `D` con un mensaje confuso y ahora quieres rehacerlo.

```text
A ─── B ─── C ─── D (mensaje confuso)
                  ▲
                  │
                 main
```

Se ejecuta:

```bash
git reset --soft HEAD~1
```

Después:

```text
A ─── B ─── C
              ▲
              │
             main

Índice:            conserva los cambios de D, listos para commit
Directorio:        conserva el contenido de D
```

El commit `D` ya no está al final de la rama, pero su contenido sigue intacto y preparado.

Puedes comprobarlo con:

```bash
git status
```

Salida posible:

```text
On branch main
Changes to be committed:
  modified:   leeme.txt
```

Y ahora puedes crear un commit nuevo con un mensaje adecuado:

```bash
git commit -m "Mensaje claro para este cambio"
```

El resultado es que el contenido se mantiene y solo cambió el commit que lo contiene.

### Casos típicos de --soft

* Corregir el mensaje de un commit sin perder el trabajo;
* Agrupar varios commits en uno solo: retrocedes varios y registras todo junto;
* Deshacer un commit para reorganizar el trabajo que contenía.

```text
git reset --soft HEAD~2
```

Con esa variante, los commits `C` y `D` se deshacen y todos sus cambios quedan preparados para un nuevo commit.

Nada se borra: solo se reorganiza.

---

## 3. git reset --mixed: el modo por defecto

`--mixed` es el modo que se ejecuta cuando no se indica ningún modo:

```bash
git reset HEAD~1
```

es equivalente a:

```bash
git reset --mixed HEAD~1
```

El comportamiento:

```text
git reset --mixed HEAD~1
        │
        ├── mueve la rama al commit anterior
        ├── reconstruye el índice a partir de ese commit
        └── no toca el directorio de trabajo
```

Es decir, los cambios del commit deshacer se mantienen en el disco, pero dejan de estar preparados.

```text
A ─── B ─── C
              ▲
              │
             main

Índice:              igual que C
Directorio:          conserva el contenido de D
                     (modificaciones sueltas, sin preparar)
```

El estado típico que verás:

```text
On branch main
Changes not staged for commit:
  modified:   leeme.txt
```

### Casos típicos de --mixed

* Despreparar todo después de un `git add .` demasiado ambicioso:

```bash
git reset
```

Sin ningún argumento, `git reset` significa `git reset --mixed HEAD`: la rama no se mueve, pero el índice se reconstruye y todos los archivos preparados vuelven a estar sueltos.

* Rehacer un commit con pasos más finos: retrocedes con `--mixed` y vuelves a preparar archivo por archivo.

* Corregir el contenido de un commit después de modificar varios archivos: retrocedes y vuelves a decidir qué incluir.

`--mixed` es el punto intermedio: conservas el trabajo, pero pierdes la preparación.

---

## 4. git reset --hard: la variante peligrosa

`--hard` es la única variante que toca el directorio de trabajo.

```bash
git reset --hard HEAD~1
```

El comportamiento:

```text
git reset --hard HEAD~1
        │
        ├── mueve la rama al commit anterior
        ├── reconstruye el índice a partir de ese commit
        └── reescribe el directorio de trabajo para igualarlo al índice
```

Las modificaciones locales de los archivos rastreados se descartan.

```text
A ─── B ─── C
              ▲
              │
             main

Índice:              igual que C
Directorio:           igual que C (los cambios de D desaparecen del disco)
```

### Por qué es peligroso

Porque el descarte no pasa por ninguna papelera.

Si modificaste `leeme.txt` sin haberlo preparado ni registrado, y ejecutas `git reset --hard`, el cambio se pierde de tu disco.

Afortunadamente, casi siempre existe una salida: el reflog, que vimos en el capítulo anterior.

Pero depende de que el estado anterior estuviera registrado en alguna referencia.

### Lo que --hard NO borra

Hay un límite importante: `git reset --hard` solo afecta a archivos rastreados.

Los archivos sin rastrear (archivos nuevos que nunca pasaron por `git add`) no se eliminan.

```text
git reset --hard
        │
        ├── archivos rastreados: se igualan al commit destino
        ├── archivos preparados: se descartan
        └── archivos sin rastrear: no se tocan
```

Para eliminar también los archivos sin rastrear existe `git clean`, que es otra operación, más destructiva todavía y fuera del alcance de este curso básico.

### Casos típicos de --hard

* Volver al último commit y descartar todos los experimentos locales;
* Sincronizar tu estado con la rama principal antes de continuar:

```bash
git reset --hard main
```

(Solo si tu rama actual no contiene commits propios que quieras conservar.)

* Limpiar el estado después de una fusión conflictiva que quieres abandonar por completo.

Antes de cada `--hard`, responde esta pregunta:

> ¿Tengo trabajo local que no está registrado y que no quiero perder?

Si la respuesta es sí, primero prepáralo o guárdalo (por ejemplo, con `git stash`).

---

## 5. Tabla de resumen

| Situación después del reset | `--soft` | `--mixed` | `--hard` |
|---|---|---|---|
| La rama apunta al commit destino | Sí | Sí | Sí |
| El índice conserva los cambios | Sí | No | No |
| El directorio de trabajo conserva los cambios | Sí | Sí | No |
| Se descartan cambios locales | No | No | Sí |
| Riesgo de pérdida de trabajo | Muy bajo | Bajo | Alto |

Una forma mnemotécnica:

```text
soft  → suave: solo se mueve la rama
mixed → mezcla: la rama retrocede y el trabajo queda suelto
hard  → duro: se iguala todo al commit destino
```

---

## 6. ¿Cuándo usar cada uno?

Antes de elegir, clasifica tu situación.

### Quiero corregir el commit sin perder nada

```text
Situar: el commit ya existe y su contenido está bien, pero el mensaje
        o la organización no.

Herramienta: git reset --soft
```

El trabajo queda preparado y listas para rehacer el commit.

### Quiero decidir de nuevo qué preparar

```text
Situar: preparé archivos equivocados o quiero desmontar un commit
        y volver a seleccionarlo archivo por archivo.

Herramienta: git reset --mixed (o git reset sin modo)
```

El trabajo queda suelto y decides de nuevo con `git add`.

### Quiero descartar los cambios locales

```text
Situar: el trabajo local no me interesa (o ya fue copiado a otra parte).

Herramienta: git reset --hard
```

Se descarta. Revisa antes con `git status` y `git diff` qué vas a perder.

### El commit ya está compartido

```text
Situar: el commit llegó a GitHub y otras personas lo tienen.

Herramienta: git revert
```

`reset` no está en la lista. Sobre historial compartido no se toca el pasado.

---

## 7. Los commits «perdidos» siguen en el reflog

Cada vez que `git reset` mueve la rama, el commit que dejó de estar al final sigue registrado en el reflog.

```text
git reflog
        │
        ▼
a1b2c3d HEAD@{1}: commit: El commit que «perdí»
e4f5g6h HEAD@{0}: reset: moving to HEAD~1
```

Para recuperarlo:

```bash
git reset --hard a1b2c3d
```

Si necesitas volver a tener solo su contenido, sin el commit:

```bash
git checkout a1b2c3d -- leeme.txt
```

(o en la sintaxis moderna, `git restore --source=a1b2c3d leeme.txt`, que estudiamos en el primer capítulo de esta sección).

Por eso, un `reset --hard` casi nunca es el final de la historia: mientras el reflog conserve el rastro, el estado anterior sigue a tu alcance.

---

## Práctica guiada

Vamos a practicar los tres modos en un repositorio de prueba.

No utilices tu proyecto real.

### Objetivo

Diferenciar en la práctica lo que cada modo modifica.

### Paso 1: crea el escenario

Crea un repositorio de prueba con dos commits:

```text
primer commit: leeme.txt con una línea
segundo commit: añadir una segunda línea
```

Comprueba:

```bash
git log --oneline
git status
```

### Paso 2: prueba --soft

```bash
git reset --soft HEAD~1
```

Después ejecuta:

```bash
git status
git log --oneline
```

Observa: la rama retrocedió, el archivo conserva la segunda línea y está preparado.

Crea un commit nuevo con un mensaje mejor y vuelve a `git log`.

### Paso 3: prepara el segundo escenario

Crea un commit nuevo (el mismo o similar) y volví a tener dos commits.

```bash
git reset --mixed HEAD~1
```

Ejecuta:

```bash
git status
```

Observa: la segunda línea sigue en el archivo, pero ahora está suelta, sin preparar.

Prepárala de nuevo con `git add leeme.txt` y registra el commit.

### Paso 4: prueba --hard

Crea otro commit con una línea nueva y modifica el archivo sin preparar.

```bash
git reset --hard HEAD~1
```

Ejecuta:

```bash
git status
git log --oneline
```

Observa: el archivo volvió al contenido del commit anterior y la modificación no preparada desapareció.

Comprueba el reflog:

```bash
git reflog
```

El commit que «perdiste» sigue listado. Recupéralo con:

```bash
git reset --hard <hash>
```

### Paso 5: comprueba el límite de --hard

Crea un archivo nuevo `borrador.txt` sin prepararlo.

Ejecuta:

```bash
git reset --hard HEAD~1
```

El archivo `borrador.txt` sigue existiendo: `--hard` no elimina archivos sin rastrear.

### Resultado esperado

Deberías poder decir, sin mirar las notas:

* qué cambió en cada modo;
* qué se conservó y qué se descartó;
* por qué el reflog permite recuperar después de `--hard`.

---

## Errores comunes

### Error 1: usar --hard para «arreglar» cualquier cosa

`git reset --hard` no es una solución genérica.

Es la variante que descarta trabajo local: úsala solo cuando eso es exactamente lo que quieres.

### Error 2: no revisar git status antes de --hard

Un vistazo a `git status` y `git diff` antes de ejecutar `--hard` evita la mayoría de las sorpresas.

### Error 3: usar --mixed esperando que se descarte el trabajo

`--mixed` conserva el trabajo: lo desprepara, no lo borra.

Si el objetivo es descartar, la variante es `--hard`.

### Error 4: aplicar --soft cuando solo quería despreparar

Con `--soft`, los cambios quedan preparados.

Si después olvidas eso y registras, el commit nuevo contendrá todo lo preparado.

### Error 5: confundir HEAD~1 con un commit concreto

Antes de ejecutar un `reset` con `HEAD~1`, comprueba con `git log --oneline` dónde exactamente vas a llegar.

### Error 6: ejecutar --hard sobre una rama con commits propios

Si tu rama tiene commits que no están en `main`, un `git reset --hard main` los descarta del historial local.

El reflog los protege, pero es mejor no llegar a esa situación.

---

## Buenas prácticas

* Clasifica antes de elegir: ¿conservar preparado, conservar suelto o descartar?;
* Revisa `git status` y `git diff` antes de cualquier `--hard`;
* Habitué a mirar el reflog después de cada `reset`;
* Usa `--soft` para rehacer commits y `--mixed` para desmontar la preparación;
* Guarda con `git stash` el trabajo que no quieras perder antes de un `--hard`;
* Recuerda que sobre historial compartido `reset` no es la herramienta: es `revert`.

---

## Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué modifica cada uno de los tres modos de `git reset`;
* por qué `--mixed` es el por defecto y qué conserva;
* por qué `--hard` puede descartar trabajo y qué NO elimina;
* cuándo cada modo es la elección correcta;
* cómo recuperar un commit después de un `reset --hard`;
* por qué los tres modos están limitados al historial local.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* `git reset --soft` mueve la rama y conserva todo preparado;
* `git reset --mixed` mueve la rama, reconstruye el índice y deja el trabajo suelto;
* `git reset --hard` mueve la rama y descarta las modificaciones locales de los archivos rastreados;
* `--hard` no elimina archivos sin rastrear;
* cada modo tiene un caso típico de uso;
* el reflog registra cada movimiento y permite recuperar el estado anterior.

La idea principal es:

> **Cada modo de git reset combina el mismo movimiento de la rama con un tratamiento distinto del índice y del trabajo local.**

---

## Próximo paso

Ya sabes mover el historial local con criterio.

El siguiente capítulo estudia una herramienta diferente: guardar trabajo a medias sin crear ningún commit.

[`05-git-stash.md`](05-git-stash.md)
