# git worktree

## Introducción

A veces necesitas dos ramas al mismo tiempo: revisar un hotfix mientras terminas una feature, ejecutar tests de `release` sin cambiar tu entorno, comparar versiones sin clonar de nuevo.

`git worktree` añade un segundo (o tercer) directorio de trabajo conectado al MISMO repositorio: misma base de objetos, mismas ramas, distinta carpeta. Es como clonar, pero instantáneo y sin duplicar historia.

En este capítulo aprenderás:

* qué es un worktree y cuándo compensa frente a clonar o hacer stash;
* crear, listar y eliminar worktrees;
* reglas de convivencia (una rama en un solo worktree);
* el flujo de hotfix/revisión en paralelo;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
git worktree
       │
       ├── 1. Qué es (mismo repo, varias carpetas)
       ├── 2. Operaciones: add, list, remove, prune
       ├── 3. Reglas de convivencia
       ├── 4. Flujos: hotfix y revisión en paralelo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué es

```text
Un repositorio normal:

proyecto/                 ← 1 carpeta, 1 HEAD
.git/                     ← historia (base de objetos)
src/...

Con worktree:

proyecto/                 ← worktree principal (rama main)
├── .git/                 ← historia compartida
proyecto-refs/            ← worktree 2 (rama release)
└── .git (archivo → ...)  ← apunta al .git real
proyecto-exp/             ← worktree 3 (rama exp)
└── .git (archivo → ...)
```

```text
Ventajas:
   │
   ├── sin duplicar historia (peso casi el mismo)
   │
   ├── mismas ramas, tags y stash visibles
   │
   └── cambios aislados por CARPETA (builds separados)
```

```bash
git worktree add ../proyecto-hotfix hotfix-1.2
git worktree list
git worktree remove ../proyecto-hotfix
```

---

## 2. Operaciones

```bash
# crear (carpeta nueva + rama nueva):
git worktree add ../ruta rama-nueva

# crear sin salir del trabajo actual:
git worktree add -b fix-rapida ../fix-rapida

# añadir sobre una rama existente:
git worktree add ../examen release

# ver todos:
git worktree list
#   /ruta/proyecto  abcd123 [main]
#   /ruta/hotfix    ef45..  [hotfix-1.2]

# eliminar:
git worktree remove ../ruta
git worktree remove --force ../ruta   # con cambios

# limpiar referencias de carpetas borradas a mano:
git worktree prune

# mover (renombrar) un worktree:
git worktree move ../vieja ../nueva
```

```text
Nota importante:
   │
   └── borrar la carpeta con el explorador NO basta:
       el repositorio aún la «recuerda» → usa
       worktree remove o prune
```

---

## 3. Reglas de convivencia

```text
   │
   ├── una rama checked-out en UN solo worktree a la
   │   vez (Git lo exige: evita dos HEADs en la misma
   │   rama)
   │
   ├── los worktrees comparten historial, tags y
   │   configuración local del repo
   │
   ├── el stash también es del repositorio: visible
   │   desde cualquier worktree
   │
   └── en worktrees secundarios puedes hacer commit,
       push y merge con normalidad
```

```text
¿Cuándo usar worktree y cuándo no?
   │
   ├── SÍ: dos ramas vivas a la vez, builds distintos,
   │   revisar PRs, hotfix con entorno propio
   │
   ├── NO: como «copia de seguridad» (usa push)
   │
   └── NO: para experimentos destructivos compartiendo
       historia sensible (ahí un clon aparte es más
       seguro)
```

---

## 4. Flujos típicos

### 4.1. Hotfix mientras trabajas

```text
   │
   ├── estás en main con trabajo sucio de la feature
   │
   ├── git worktree add ../p-hotfix hotfix-2.3
   │   → carpeta limpia en la rama del hotfix
   │
   ├── arreglas, pruebas y push desde ahí
   │
   └── tu carpeta principal NO se enteró (cero stash,
       cero cambio de rama)
```

### 4.2. Revisión de PRs sin ensuciar

```bash
git fetch origin pull/42/head:pr-42
git worktree add ../rev-pr42 pr-42
# revisas, pruebas, comentas; cierras y borras
git worktree remove ../rev-pr42
git branch -d pr-42
```

### 4.3. Release de larga duración

```text
   │
   ├── worktree permanente en release/1.x
   │
   ├── sus builds y versiones viven separados de tu
   │   main inestable
   │
   └── recordar: limpiar con worktree remove cuando
       termine la rama
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: borrar la carpeta a mano

**Qué ocurrió:** `git worktree list` sigue mostrando la ruta fantasma; `add` a esa ruta falla.

**Por qué:** el explorador no ejecuta `worktree remove`.

**Cómo comprobarlo:** `git worktree list` vs. disco.

**Opciones:** `git worktree prune` (limpia referencias) o `remove` si la carpeta aún existe.

**Riesgos:** confusión y bloqueos de creación.

**Solución:** siempre `worktree remove`.

**Cómo se evita:** rutina de limpieza al cerrar tareas.

---

### Error 2: intentar dos checkouts de la misma rama

**Qué ocurrió:** «branch is already checked out» al crear el segundo worktree o al cambiar de rama en el principal.

**Por qué:** regla de una rama por worktree.

**Cómo comprobarlo:** `git worktree list` (dónde está esa rama).

**Opciones:**
* usar otra rama (o crearla);
* o terminar el uso en el otro worktree y liberar.

**Riesgos:** estados cruzados (por eso Git lo prohíbe).

**Solución:** planificar qué rama vive en cada carpeta.

**Cómo se evita:** convención de nombres por tarea (punto 6).

---

### Error 3: creer que un worktree es un clon aislado

**Qué ocurrió:** ejecutando `reset --hard`/`clean` en un worktree «de prueba» se borró trabajo del repositorio compartido (stash, historial).

**Por qué:** la historia es UNA; solo cambia la carpeta.

**Cómo comprobarlo:** `git stash list` (visible en todos), `git log` idéntico.

**Opciones:** recuperar con reflog/stash (sección 11); si no, diagnóstico honesto.

**Riesgos:** pérdida compartida.

**Solución:** tratar operaciones destructivas con las mismas precauciones en cualquier carpeta.

**Cómo se evita:** la regla universal: stash y verificación antes de `--hard`.

---

### Error 4: worktrees olvidados acumulando ramas

**Qué ocurrió:** meses después, diez carpetas y ramas «presas» que nadie puede usar en otro sitio.

**Por qué:** no se cerró el ciclo.

**Cómo comprobarlo:** `git worktree list` largo.

**Opciones:** `remove` de los que ya no sirven; `branch -d` de las terminadas; `prune`.

**Riesgos:** desorden y bloqueos (Error 2).

**Solución:** worktree = tarea con fecha de caducidad.

**Cómo se evita:** checklist al cerrar PR/rama.

---

### Error 5: scripts/CI que asumen «una carpeta»

**Qué ocurrió:** un script con rutas relativas o `git rev-parse --show-toplevel` inesperado falla en un worktree secundario.

**Por qué posibles:**
* el script asume la carpeta principal;
* rutas absolutas duras.

**Cómo comprobarlo:** ejecutarlo desde el worktree y leer el error.

**Opciones:** usar rutas derivadas del toplevel; parametrizar.

**Riesgos:** CI local roto.

**Solución:** scripts relativos al repo.

**Cómo se evita:** probar herramientas en el worktree secundario si el equipo lo usará.

---

### Error 6: hacer push desde el worktree «equivocado» sin revisar

**Qué ocurrió:** se subió la rama que estaba abierta en la carpeta de revisión en lugar de la rama del hotfix.

**Por qué:** se perdió de vista en qué rama/carpeta se está.

**Cómo comprobarlo:** `git status -sb` (siempre antes de push).

**Opciones:** verificar y rehacer el push correcto; revertir el equivocado si se publicó.

**Riesgos:** mezclar entregas.

**Solución:** status con rama visible en cada push (hay quien pone la rama en el prompt).

**Cómo se evita:** nombrar carpetas con la tarea (punto 6) y revisar el status.

---

## 6. Práctica guiada

### Objetivo

Trabajar dos ramas simultáneamente con worktrees, sin stash y sin cambiar de rama en la principal.

### Paso 1: repositorio base con trabajo sucio

```bash
git init wt && cd wt
echo base > app.txt && git add . && git commit -m "base"
echo "trabajo en curso" >> app.txt     # sucio en main
git status                             # sucio, NO lo
                                        # resuelvas
```

### Paso 2: worktree en paralelo

```bash
git worktree add ../wt-fix -b fix-rapida
git worktree list
cd ../wt-fix
git status                 # limpio, en fix-rapida
echo fix > hot.txt && git add . && git commit -m "fix"
```

### Paso 3: comprobación de aislamiento

```bash
git log --oneline          # el fix está en la rama
ls                         # hot.txt aquí
# vuelve a la carpeta principal:
cd ../wt
git log --oneline          # main NO tiene el fix
git status                 # tu trabajo sigue sucio
```

### Paso 4: push desde el worktree

```bash
git remote add origin <ruta-o-url>     # desde wt-fix
cd ../wt-fix
git push -u origin fix-rapida
git status -sb
```

### Paso 5: limpieza

```bash
git worktree remove ../wt-fix
git worktree list          # solo el principal
git branch -d fix-rapida
git worktree prune         # higiene
```

### Paso 6: práctica de error

1. Intenta `git worktree add ../otro fix-rapida` (rama ya checked out) → observa el error.
2. Borra a mano una carpeta de prueba y ejecuta `git worktree list` + `prune`.

### Resultado esperado

Dos ramas vivas a la vez, push correcto desde cada carpeta y limpieza completa.

### Conclusión esperada

Worktree multiplica tus carpetas de trabajo sin duplicar historia: una rama por carpeta y ciclo de vida cerrado con `remove`.

---

## 7. Nivel profesional + resumen

### 7.1. Worktrees en equipo

```text
   │
   ├── revisión de PRs con worktree = entorno limpio y
   │   rápido (sin clonar 500 MB)
   │
   ├── ramas de mantenimiento largas con su carpeta
   │   propia y su CI local
   │
   └── algunos flujos de hotfix lo usan como paso
       intermedio antes de un clon completo para
       publicar
```

```text
   │
   ├── en CI convencional NO suelen usarse (cada job
   │   clona): el ahorro es de desarrollo local
   │
   └── en equipos con ramas de release vivas: gran
       reducción de «cambios de rama» y de errores de
       entorno sucio
```

### 7.2. Resumen

En este capítulo aprendiste que:

* un worktree añade otra carpeta de trabajo sobre el MISMO repositorio: historia, tags y stash compartidos; carpeta y rama, propias;
* operaciones: `add`, `list`, `remove`, `move` y `prune` (borrar carpetas a mano deja fantasmas);
* regla dura: una rama checked-out en un solo worktree;
* flujos ideales: hotfix en paralelo, revisión de PRs y ramas de release persistentes;
* los errores típicos (carpetas borradas a mano, misma rama en dos sitios, destructivos compartidos, worktrees olvidados, scripts con rutas, push de la carpeta equivocada) se previenen con ciclo de vida y `status -sb`;
* a nivel profesional: worktrees = entornos de tarea aislados sin el coste de clonar.

La idea principal es:

> **git worktree multiplica carpetas, no repositorios: compartes historia con cuidado y aíslas solo lo que debe estarlo — la rama y el estado de la carpeta.**

---

## Próximo paso

Ya trabajas en varias ramas a la vez.

La siguiente herramienta conecta repositorios dentro de repositorios: submódulos (y cuándo conviene otra solución).

Continúa con:

[`08-git-submodules.md`](08-git-submodules.md)
