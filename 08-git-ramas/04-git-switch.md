# git switch

## Introducción

`git switch` es el comando moderno para moverse entre ramas: nació (Git 2.23, 2019) para separar lo que checkout mezclaba —navegar ramas y restaurar archivos— y dejar una orden con un solo significado. Si en el capítulo anterior viste la teoría del cambio de rama, aquí es la práctica completa de esta orden: crear, cambiar, volver y contextualizar con ramas remotas.

En este capítulo aprenderás:

* sintaxis y opciones de `git switch`;
* crear con `-c` y rastrear remotas automáticamente;
* `switch -` (la rama anterior) y deshacer cambios con `-f`;
* combinaciones con ramas remotas (`--track`, origen);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (flags peligrosos).

---

## Mapa conceptual de este capítulo

```text
git switch
       │
       ├── 1. Sintaxis básica
   │        ├── switch <rama>
   │        ├── switch -c <rama>
   │        └── switch - (anterior)
   │
       ├── 2. Opciones clave
   │        ├── -c/-C (crear / crear y pisar)
   │        ├── --track y creación desde remota
   │        ├── -f / --discard-changes
   │        └── -d (borrar al salir)
   │
       ├── 3. La rama anterior: switch -
   │
       ├── 4. Crear desde remota sin querer duplicar
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Sintaxis básica

### 1.1. Cambiar

```bash
git switch feature-login
```

```text
   │
   ├── busca refs/heads/feature-login (o la crea si
   │   solo existe origin/feature-login: punto 4)
   │
   ├── mueve HEAD y tu carpeta (reglas de la sección
   │   anterior: carpeta sucia puede bloquear)
   │
   └── mensaje: "Switched to branch 'feature-login'"
```

### 1.2. Crear y cambiar

```bash
git switch -c feature-login
git switch -c feature-login main      # desde otra base
git switch -c fix HEAD~2              # desde un commit
```

### 1.3. Ver dónde estás

```bash
git switch            # sin argumentos: te dice en cuál
                      # estás (o error si detached)
git status            # siempre confirma
```

---

## 2. Opciones clave

### 2.1. `-c` crear vs. `-C` crear pisando

```bash
git switch -c rama-x     # falla si rama-x ya existe
git switch -C rama-x     # RECREA: apunta rama-x a la
                         # base indicada (borra lo que
                         # «apuntaba»)
```

```text
Cuidado con -C:
   │
   ├── solo con ramas desechables cuyo destino NO
   │   importa (típico: rama local obsoleta frente a
   │   la remota actualizada)
   │
   └── si tenía commits únicos: quedan solo en reflog
```

### 2.2. `-f` / `--discard-changes`

```bash
git switch -f otra-rama
```

```text
   │
   ├── cambia AUNQUE tengas cambios sucios DESCARTÁNDOLOS
   │   (los que se perderían con el cambio)
   │
   └── equivalente a checkout -f: la orden de «sin
       escrúpulos». Úsese con la misma etiqueta que
       un producto de limpieza industrial
```

### 2.3. `-d` / `--detach` (otros)

```bash
git switch --detach HEAD~2   # mirar un commit
git switch -d rama-x         # (en algunos Git: borrar
                             # tras salir; verifica tu
                             # versión: switch -h)
```

```text
Nota: el soporte exacto de -d varía por versión;
la forma portable de borrar al salir sigue siendo:
   git switch main; git branch -d rama-x
```

---

## 3. La rama anterior: `switch -`

```bash
git switch feature
# ... trabajo ...
git switch -        # vuelta a la anterior (main)
git switch -        # y otra vez (feature)
```

```text
   │
   ├── invoca refs/ORIG_HEAD de navegación: la última
   │   rama en la que estuviste
   │
   └── uso: alternar entre dos (como alt+tab de Git)
```

---

## 4. Crear desde remota sin duplicar

### 4.1. El atajo moderno

```bash
git switch feature-compañera
```

```text
Si NO existe localmente y SÍ origin/feature-compañera:
   │
   ├── Git la crea automáticamente
   ├── configura el seguimiento (upstream = origin/…)
   └── mensaje: "... set up to track origin/..."
```

### 4.2. Forma explícita

```bash
git switch -c feature-compañera --track origin/feature-compañera
```

### 4.3. Evitar la duplicación inconsciente

```text
Peligro clásico:
   │
   ├── creas tu PROPIA «main» local desde cero cuando
   │   ya existe origin/main → dos mundos
   │
   └── prevención: si dudas de si existe, branch -a;
       si existe remota, switch la usa (4.1) o track
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «invalid reference: nombre»

**Qué ocurrió:** la rama no existe (ni local ni como remota rastreable).

**Por qué:** nombre mal escrito o rama nunca subida/bajada.

**Cómo comprobarlo:** `git branch -a`; `git fetch` (a veces llega con fetch).

**Opciones:** corregir nombre; crearla; fetch y reintentar.

**Riesgos:** ninguno.

**Solución:** mapa de nombres.

**Cómo se evita:** listar antes en scripts (o aceptar el error: es claro).

---

### Error 2: «would be overwritten by switch»

**Qué ocurrió:** cambios sucios en archivos que difieren entre ramas.

**Por qué:** capítulo anterior, punto 2.

**Cómo comprobarlo:** `git status` / `git diff`.

**Opciones:** commit / stash / restore consciente; `-f` solo sabiendo que tira trabajo.

**Riesgos:** con -f, pérdida directa.

**Solución:** decidir antes de pasar.

**Cómo se evita:** status como ritual.

---

### Error 3: Crear con -c una rama que ya existe

**Qué ocurrió:** error «branch already exists».

**Por qué:** nombre repetido.

**Cómo comprobarlo:** `git branch -a`.

**Opciones:** cambiar nombre; o si quieres «reapuntar»: `-C` (con la advertencia del punto 2.1).

**Riesgos:** -C sin pensar = mover punta de rama con trabajo.

**Solución:** nombre nuevo.

**Cómo se evita:** convención + `branch -vv`.

---

### Error 4: `switch -f` y desaparición de trabajo

**Qué ocurrió:** cambiaste con -f «para no perder tiempo» y los cambios sucios de esa zona desaparecieron.

**Por qué:** eso es literalmente lo que hace -f.

**Cómo comprobarlo:** status en la rama destino; reflog ayuda poco (era trabajo sin commitear: si no había stash/commit, no hay registro).

**Opciones:** recuperación solo si estaba en índice/stash (sección 11); probablemente perdido.

**Riesgos:** alta: horas de trabajo.

**Solución:** -f en el mismo rango que `reset --hard`: excepción, no rutina.

**Cómo se evita:** jamás en automatización ni a prisa; commit/stash primero.

---

### Error 5: En un monorepo/repo con muchas ramas: «¿en cuál estoy?»

**Qué ocurrió:** desorientación tras varios switches.

**Por qué:** no consultar.

**Cómo comprobarlo:** `git switch` (solo), `status`, `branch -vv` (* marca activa).

**Opciones:** siempre status al cambiar.

**Riesgos:** commitear en la equivocada.

**Solución:** hábito raíz 26.

**Cómo se evita:** disciplina.

---

### Error 6: Esperar que switch haga pull

**Qué ocurrió:** cambiaste a main y esperabas ver lo último del equipo.

**Por qué:** switch solo navega TU historial local.

**Cómo comprobarlo:** `git status` (atrás de origin/main) → hace falta pull/fetch.

**Opciones:** `git pull` en main cuando toque.

**Riesgos:** trabajar sobre base vieja (conflictos mayores luego).

**Solución:** pullear al entrar a main para integrar.

**Cómo se evita:** flujo: switch main → pull → switch -c tarea.

---

## 6. Práctica guiada

### Objetivo

Dominar switch en todas sus variantes seguras.

### Paso 1: básico

```bash
git switch -c sw-uno
git switch -                 # a la anterior
git switch -                  # y vuelta
git switch                    # ¿dónde estoy?
```

### Paso 2: crear desde otra base

```bash
git switch main
git switch -c sw-desde-main
git log --graph --oneline --decorate --all -n 8
```

1. Verifica el nacimiento.

### Paso 3: falla segura (sin -f)

```bash
# edita un archivo que difiere entre ramas
git switch otra                # ¿error?
git status                     # entiende por qué
git restore <archivo>          # descarta a propósito
git switch otra                # ahora sí
```

### Paso 4: con remoto (si aplica)

```bash
git fetch origin
git branch -a
git switch <rama-remota-que-no-tienes>
git branch -vv                 # ¿trackeada?
```

### Paso 5: -C con conciencia (solo demo)

```bash
git branch desechable main
git switch -c desechable2 desechable   # (inexistente → crea)
# da un commit en desechable (opcional)
git switch -C desechable main   # REAPUNTA a main: mira
git log desechable --oneline -n 2  # cambió el punta
```

1. Comprende: -C no borra objetos, mueve el nombre.

### Paso 6: alterno rápido

```bash
git switch -c rama-a
git switch -c rama-b
git switch -             # rama-a
git switch -             # rama-b
```

### Resultado Esperado

Uso fluido y seguro de switch, con capacidad de explicar cada flag que usas (y de NO usar los peligrosos sin motivo).

### Conclusión esperada

`switch` es la navegación de Git: rápido, semántico y, cuando lo sabes, imposible de pillar a contrapié.

---

## 7. Nivel profesional + resumen

### 7.1. switch en rutinas

```text
Patrones típicos
──────────────────────────────────────────────
integrar lo del equipo:
   git switch main && git pull

empezar tarea:
   git switch main && git pull && git switch -c tipo-issue

sacar cambios de una rama vieja y volver:
   git switch otra; ...; git switch -

limpiar local obsoleto:
   git branch -D vieja        # (-D consciente)
   git switch -c vieja origin/vieja   # re-apuntada
```

### 7.2. Scripting

```text
   │
   ├── en guiones: usa nombres explícitos, no `-`
   ├── comprueba errores (switch falla con código ≠ 0)
   ├── evita -f en automatización: rompe la paz
   └── CI: checkout de rama con determinismo (Git limpio
       desde clon)
```

### 7.3. Resumen

En este capítulo aprendiste que:

* `git switch <rama>` navega; `-c` crea y cambia (con base opcional); `-` alterna con la anterior;
* `-C` reapunta una rama existente y `-f` cambia descartando trabajo sucio: ambos son cirugía, no rutina;
* si solo existe `origin/<rama>`, switch la crea y la enlaza con seguimiento (evita duplicados);
* switch es 100% local: para ver lo del equipo, pull/fetch aparte;
* los errores típicos (referencia inválida, cambios que bloquean, duplicados, -f, desorientación) se manejan con `status`, `branch -a/-vv` y criterio;
* a nivel profesional: rutinas switch+pull al integrar, nombres explícitos en scripts y flags peligrosos bajo llave.

La idea principal es:

> **`switch` es tu alt-tab por el historial: rápido y barato —la disciplina está en llegar con la carpeta limpia y volver con lo commiteado.**

---

## Próximo paso

`switch` es la vía moderna.

El siguiente capítulo cubre su predecesor —y aún muy presente—: `git checkout`, con sus usos de restaurar archivos.

Continúa con:

[`05-git-checkout.md`](05-git-checkout.md)
