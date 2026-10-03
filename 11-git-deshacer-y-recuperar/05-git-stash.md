# git stash

## Introducción

A veces tienes trabajo a medio hacer en el directorio de trabajo y necesitas, ahora mismo, cambiar de rama, hacer un `pull` o probar otra cosa sin perder nada y sin crear un commit provisional.

Para eso está `git stash`: un almacén temporal donde guardas el estado de tus cambios, dejas la carpeta limpia y vuelves cuando quieras a recuperarlos.

Es una herramienta de diario, muy segura si entiendes dónde guarda las cosas y cuál es la diferencia entre `apply` y `pop`.

En este capítulo aprenderás:

* qué guarda un stash y dónde vive;
* crear, listar, inspeccionar, restaurar y descartar stashes;
* la diferencia crucial entre `apply` y `pop`;
* opciones útiles: `-m`, `-u`, `--keep-index`, rutas concretas;
* cómo usarlo como red de seguridad antes de operaciones arriesgadas;
* los errores típicos (stash olvidado, pop en conflicto, stash perdido) con diagnóstico completo.

---

## 1. Qué es un stash

Un stash es un conjunto de commits especiales que Git crea con tus cambios pendientes y que guarda fuera de tus ramas.

```text
Tu situación:
   │
   ├── rama feature con archivos modificados
   ├── cambios sin preparar (+ algunos preparados)
   └── necesidad urgente: ir a main, hacer algo,
       volver

git stash
   │
   ├── TODOS esos cambios se copian a una pila de
   │   almacén (refs/stash)
   │
   ├── tu directorio de trabajo queda COMO EL ÚLTIMO
   │   COMMIT (limpio)
   │
   └── cuando quieras: los sacas de vuelta
```

```text
Detalles importantes:
   │
   ├── el stash es LOCAL: no se sube con push
   │
   ├── es una pila: LIFO (el último guardado, el
   │   primero que sale)
   │
   └── cada entrada tiene su propio commit (por eso
       puede guardarse también en el reflog del stash)
```

---

## 2. Crear un stash

### 2.1. El básico

```bash
git stash
# (equivalente moderno: git stash push)
```

```text
Qué guarda (por defecto):
   │
   ├── archivos modificados RASTREADOS (trabajados y
   │   preparados)
   │
   └── NO guarda archivos sin rastrear (nuevos) salvo
       que lo pidas (ver punto 5)
```

```bash
# con mensaje (muy recomendable):
git stash push -m "wip: refactor de login a medias"
```

### 2.2. Verificación

```bash
git status          # limpio (como antes de tus cambios)
git stash list      # tu pila de guardados
```

```text
Salida típica de list:
   stash@{0}: On main: wip: refactor de login a medias
   stash@{1}: On feature: arreglo temporal del CSS
   │
   └── stash@{0} es SIEMPRE el más reciente
```

---

## 3. Inspeccionar lo guardado

```bash
git stash list                      # resumen de la pila
git stash show                      # diff resumido del 0
git stash show stash@{1}            # de otro
git stash show -p stash@{0}         # parche completo
git stash show --stat stash@{0}     # solo nombres y
                                    # conteos
```

```text
Antes de restaurar, conviene saber qué hay dentro:
   │
   ├── show / show -p: ¿es este el stash que quiero?
   │
   └── si tienes varios, nombre o mensaje desde el
       push (punto 2) ahorra ciegas
```

---

## 4. Restaurar: apply vs pop

```bash
git stash apply        # restaura stash@{0} y LO CONSERVA
git stash pop          # restaura stash@{0} y LO QUITA
```

```text
Diferencia:
   │
   ├── apply: el stash sigue en la pila (puedes
   │   aplicarlo otra vez o en otra rama)
   │
   └── pop: apply + drop (el típico «ya lo tengo,
       límpialo»)
```

```bash
# elegir cuál:
git stash apply stash@{2}
git stash pop stash@{2}     # (pop también acepta índice)

# si apply/pop dejan el índice preparado como estaba:
git stash apply --index     # además restaura la
                            # preparación (staged)
```

```text
Criterio:
   │
   ├── quieres conservarlo por si falla → apply
   │
   ├── es un one-shot (recuperarlo y olvidarlo) → pop
   │
   └── ¿aplicarlo en otra rama? → apply (¡el stash no
       «pertenece» a la rama, pero conviene no
       descartarlo)
```

---

## 5. Opciones útiles

### 5.1. Archivos sin rastrear (y borrados)

```bash
git stash push -u -m "con archivos nuevos"    # incluye
                                              # untracked
git stash push -a -m "todo"                    # también
                                              # ignorados
```

```text
   │
   ├── -u (include-untracked): los archivos NUEVOS
   │   también entran al stash (y desaparecen de la
   │   carpeta hasta recuperarlos)
   │
   └── -a (all): hasta los ignorados — con cuidado: la
       carpeta queda «vacía» de extras
```

### 5.2. Solo ciertas rutas

```bash
git stash push -m "solo css" -- src/estilos.css
```

```text
   │
   ├── guarda solo lo indicado; el resto de cambios se
   │   queda en la carpeta
   │
   └── útil: cambio grande a medias + necesitas
       limpiar UN archivo para un commit
```

### 5.3. Conservar lo preparado

```bash
git stash push --keep-index -m "lo staged se queda"
```

```text
   │
   ├── el índice (preparado) permanece en la carpeta
   │
   └── ideal para: «commiteo lo preparado y guardo lo
       demás»
```

---

## 6. Gestionar la pila

```bash
git stash list
git stash drop              # borra stash@{0}
git stash drop stash@{1}    # otro
git stash clear             # ¡borra TODOS!
git stash branch <rama>     # crea rama desde la base del
                            # stash y lo aplica
```

```text
stash branch: el rescate «por si acaso»
   │
   ├── el stash nació en un commit base; si esa base
   │   se movió, aplicarlo puede dar conflictos
   │
   ├── git stash branch mi-rescate
   │   → nueva rama en el commit donde guardaste +
   │      aplicar el stash + (si va bien) drop
   │
   └── método preferido cuando llevas el stash varios
       días
```

```text
Orden de limpieza:
   │
   ├── revisar (show) → aplicar/branch → verificar
   │
   └── drop/clear SOLO tras comprobar que el trabajo
       está en su sitio
```

---

## 7. Cuando aplicar da conflicto

```text
pop/apply con conflicto:
   │
   ├── Git aplica lo que puede y marca conflictos
   │   (mismos marcadores de la sección 10)
   │
   ├── EN POP: el stash NO se elimina hasta que
   │   termina bien — si hay conflicto, se queda en la
   │   pila y Git te avisa
   │
   └── solución: resolver el conflicto (método de la
       sección 10) → add → y luego, si quieres
       descartarlo: git stash drop
```

```bash
git stash pop          # conflicto...
# resuelve, git add ...
git stash list         # ¿sigue ahí? (depende de versión/
                       # momento: comprobarlo siempre)
git stash drop         # limpiar si ya no se necesita
```

---

## 8. Red de seguridad y recuperación

### 8.1. Antes de operaciones arriesgadas

```text
Antes de:
   │
   ├── git reset --hard      → stash primero
   ├── git clean             → stash primero (-u)
   ├── checkout que puede chocar → stash
   └── «probar un experimento»    → stash o rama nueva
```

### 8.2. Un stash «perdido»

```text
Motivos típicos:
   │
   ├── pop con drop ya ejecutado y trabajo no guardado
   ├── clear por error
   └── stash de otra máquina (no viaja con push)

Recuperación:
   │
   ├── el stash son commits: siguen en el repo hasta
   │   ser recolectados (gc)
   │
   ├── git fsck --unreachable | findstr commit   (o
   │   grep) → busca commits colgantes
   │
   └── git stash apply <hash>  → restaura uno no listado
```

```bash
# pasos típicos de rescate:
git fsck --unreachable
git show <hash>            # ¿es mi stash?
git stash apply <hash>     # recuperarlo sin listar
```

```text
Prevención (mejor que rescatar):
   │
   ├── mensajes claros en cada push del stash
   ├── no clear «por limpieza» sin haber aplicado
   └── para trabajo importante: rama/commit, no stash
       (el stash es temporal por definición)
```

---

## 9. Práctica guiada

### Objetivo

Guardar, inspeccionar, restaurar y limpiar trabajo con stash, incluyendo un conflicto de aplicación.

### Paso 1: crea trabajo pendiente

```bash
git switch main
echo "original" > stash.md && git add stash.md && git commit -m "base"
echo "cambio en curso" >> stash.md
git stash push -m "ejercicio: cambio en stash.md"
git status                  # limpio
cat stash.md                # contenido original
git stash list              # stash@{0}
```

### Paso 2: inspecciona

```bash
git stash show --stat stash@{0}
git stash show -p stash@{0}
```

1. ¿Qué archivo? ¿Qué contenido guarda?

### Paso 3: restaura con apply

```bash
git stash apply stash@{0}
git status                  # modificado otra vez
git stash list              # sigue (apply no borra)
git restore stash.md        # descarta para el siguiente paso
```

### Paso 4: restaura con pop

```bash
git stash pop stash@{0}
git status                  # modificado
git stash list              # ¡vacío! (pop borró)
git restore stash.md
```

### Paso 5: -u (sin rastrear)

```bash
echo "nuevo" > nuevo.txt     # sin git add
git stash push -u -m "incluye nuevo.txt"
git status                   # limpio; ¿está nuevo.txt?
git stash pop
git status                   # nuevo.txt vuelve
```

### Paso 6: conflicto de aplicación

```bash
# deja stash.md con contenido X y guárdalo:
echo "X" >> stash.md && git stash push -m "conflicto"
# modifica la misma zona en la rama:
echo "Y" >> stash.md && git add stash.md && git commit -m "Y"
# intenta aplicar:
git stash pop                # conflicto marcado
# resuelve (método sección 10), add, y:
git stash drop               # si el listado aún lo tiene
git status                   # limpio
```

### Paso 7: stash branch

```bash
echo "rama-rescate" >> stash.md && git stash push -m "rescate"
git restore stash.md
git stash branch rescate
git status                   # en rama «rescate» con cambios
git stash list               # vacío (suprimido si fue ok)
git switch main
git branch -d rescate         # limpieza final
```

### Resultado esperado

La pila de stash usada de punta a punta: guardar, ver, aplicar, poblar, resolver conflictos y ramificar — sin perder nada.

### Conclusión esperada

`stash` es una pila local de trabajo temporal: `apply` conserva, `pop` consume, `-u` incluye lo nuevo y `branch` rescata con contexto.

---

## 10. Errores comunes

### Error 1: creer que el stash viaja con push

Un stash es local: `git push` no lo sube y en otro equipo no existe.

Si el trabajo importa para el equipo, convierte el stash en commit en una rama y sube esa rama.

### Error 2: creer que stash guarda los archivos nuevos (sin -u)

Por defecto, los archivos sin rastrear NO entran: siguen en la carpeta y molestan (o rompen la «limpieza» buscada).

Usa `-u` cuando necesites vaciar de verdad la carpeta.

### Error 3: `stash clear` sin haber revisado la pila

Borra todos los guardados y, si nadie los aplicó, el trabajo se pierde (salvo rescate con `fsck`, con la prisas que eso implica).

Revisa `list` y `show` antes; borra de uno en uno con `drop`.

### Error 4: aplicar un stash viejo «a ciegas»

La base cambió: aplicarlo puede dar conflictos o contenido desactualizado.

Inspecciona (`show -p`), aplica en una rama de prueba (`stash branch`) y verifica antes de integrar.

### Error 5: olvidarse de que un `pop` fallido deja estado a medias

Si `pop` entra en conflicto, hay trabajo aplicado parcialmente Y (según versión/momento) el stash aún en la pila: mezclarlo todo genera confusión.

Diagnostica con `status` y `stash list`, resuelve con método y termina con `drop` explícito.

### Error 6: usar stash como sistema de guardado a largo plazo

Un stash de semanas es un commit invisible: nadie lo ve en el historial, no tiene CI y es fácil de limpiar sin querer.

Stash = temporizador corto. Para «guardar para después» de verdad: commit en rama propia.

---

## 11. Buenas prácticas

* Dale mensaje a cada stash (`-m`): el futuro tú lo agradecerá;
* `apply` cuando dudes, `pop` cuando estés seguro;
* recuerda `-u` si necesitas la carpeta realmente limpia;
* usa `stash branch` para rescatar stashes con más de un día;
* antes de `reset --hard`, `clean` o cambios de rama conflictivos: stash primero;
* para trabajo importante, el stash no es el destino: conviértelo en commit y rama;
* limpia la pila con criterio (`drop` de lo revisado, no `clear` a ciegas).

---

## 12. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué guarda `git stash` y qué NO guarda por defecto;
* la diferencia entre `apply` y `pop` y cuándo usar cada uno;
* para qué sirve `-u` y cómo cambia la carpeta;
* qué es `stash@{0}` y cómo inspeccionar un stash antes de aplicarlo;
* cómo rescatar trabajo con `stash branch` y por qué;
* qué hacer si un `pop` da conflicto;
* cómo buscar un stash perdido con `fsck`.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## Resumen

En este capítulo aprendiste que:

* `git stash` guarda tus cambios pendientes en una pila local y deja la carpeta limpia como el último commit;
* por defecto guarda rastreados modificados; `-u` incluye sin rastrear y `-a` también los ignorados;
* `apply` restaura conservando el stash, `pop` restaura y elimina;
* la pila se gestiona con `list`, `show`, `drop` y `clear`; los índices se referencian como `stash@{n}`;
* `stash branch` rescata un stash creando rama en su base (evita conflictos de contexto viejo);
* un `pop` en conflicto se resuelve con el método normal y se limpia con `drop` consciente;
* los stashes son locales y temporales: el trabajo importante vive en commits y ramas;
* los stashes perdidos pueden buscarse con `fsck` y aplicarse por hash.

La idea principal es:

> **git stash es la pila de «ahora no, luego sí»: guarda trabajo temporal sin crear historial, siempre y cuando sepas que es local, efímero y tuyo.**

---

## Próximo paso

Has completado la sección de deshacer y recuperar: `restore`, `revert`, `reset` y ahora `stash`.

El recorrido continúa con la siguiente sección del curso:

[`../12-git-avanzado/`](../12-git-avanzado/)
