# Conflictos en merge

## Introducción

El merge es la superficie donde la mayoría de personas se encuentran con los conflictos: traer una rama a otra (o bajar lo del equipo) y encontrar los marcadores. Este capítulo concentra lo específico del merge: sus lados (HEAD = lo tuyo, entrante = lo que llega), sus formas de resolver (`--ours/--theirs` sin inversión), sus mensajes y sus salidas (`--abort`, `--continue` vía commit).

Es la versión «cotidiana» del método: si dominas conflictos en merge, dominas el 80% de los casos reales.

En este capítulo aprenderás:

* la semántica de lados en merge (y cómo verificarla);
* resolución con herramientas de merge (`--ours/--theirs`, mergetool);
* el cierre con commit y su mensaje;
* flujos típicos (merge de rama, pull, merge de upstream);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Conflictos en merge
       │
       ├── 1. Semántica de lados
   │        ├── HEAD = tuyo / >>>>> = entrante
   │        └── verificar con status y log
   │
       ├── 2. Herramientas de resolución
   │        ├── edición manual (la base)
   │        ├── --ours / --theirs
   │        └── mergetool (tres paneles)
   │
       ├── 3. Cierre: commit de merge
   │        ├── mensaje por defecto
   │        └── mensaje que documenta decisiones
   │
       ├── 4. Flujos típicos con conflicto
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Semántica de lados

### 1.1. Quién es quién

```text
git switch main
git merge feature-x        # conflicto

En el archivo:
<<<<<<< HEAD
lo que hay en main (TU rama actual)
=======
lo que hay en feature-x (lo que entra)
>>>>>>> feature-x
```

```text
Verificación (si dudas):
   │
   ├── git status  →  "merging" y nombre de la rama
   │
   ├── git log -1 HEAD  →  último commit de main
   │   (¿es el contenido tuyo?)
   │
   ├── git log -1 feature-x  →  el entrante
   │
   └── git show :2:<archivo> / :3:<archivo>  →  los
       contenidos exactos de cada lado
```

### 1.2. Mapa mental

```text
        ancestro
          │
    ┌─────┴─────┐
  main (HEAD)  feature-x
    │              │
    └──── merge ───┘
          │
        conflicto: «¿qué pongo?»
```

---

## 2. Herramientas de resolución

### 2.1. Edición manual (la base)

```text
   │
   ├── abrir, decidir, borrar marcadores, guardar
   │
   ├── siempre disponible y siempre la más precisa
   │
   └── es la que más se usa en la práctica real
```

### 2.2. `--ours` / `--theirs`

```bash
git checkout --ours notas.md      # mantener lo tuyo
git checkout --theirs notas.md    # traer lo entrante
git add notas.md                  # marcar resuelto
```

```text
Cuándo usarlos:
   │
   ├── UNO de los lados es el correcto para TODO el
   │   archivo (sin matices)
   │
   ├── o como primer paso (dejar un lado) y luego
   │   editar encima a mano
   │
   └── en MERGE no hay inversión (a diferencia del
       rebase: capítulo 06)
```

### 2.3. `git mergetool`

```bash
git mergetool        # abre herramienta por cada
                     # conflicto
```

```text
   │
   ├── tres paneles: local | resultado | remoto (+
   │   ancestro en muchas herramientas)
   │
   ├── configurable (git config merge.tool <herramienta>)
   │
   └── confortable en archivos grandes; el marcador
       manual sigue siendo el estándar portable
```

### 2.4. Resolución en la web (GitHub)

```text
   │
   ├── en PRs con conflicto: botón «Resolve conflicts»
   │   (editor con marcadores)
   │
   ├── mismo método: editar → confirmar → commit de
   │   resolución
   │
   └── regla: termina en UNA superficie (web o local)
```

---

## 3. Cierre: commit de merge

### 3.1. El mensaje por defecto

```bash
git commit
```

```text
Se abre el editor con:
   Merge branch 'feature-x' into main

   # Conflicts:
   #     notas.md
   │
   └── sirve: registra qué rama entró y qué archivos
       discutieron
```

### 3.2. Mensaje que documenta

```bash
git commit -m "Merge feature-x: resuelve notas.md manteniendo A y añadiendo B"
```

```text
Cuándo mejorar el mensaje:
   │
   ├── la resolución no era obvia (se decidió algo)
   │
   └── futuras auditorías lo agradecerán (¿por qué
       quedó así?)
```

### 3.3. Tras el cierre

```bash
git status                 # clean
git log --graph --oneline  # M con dos padres
git show HEAD --stat       # qué entró
```

---

## 4. Flujos típicos con conflicto

### 4.1. Merge de rama de tarea en main

```text
   │
   ├── origen: traer feature a main (o main a feature)
   │
   ├── conflicto → método → commit M → push
   │
   └── si el flujo es PR: la resolución ocurre en la
       integración del PR (web o local)
```

### 4.2. Pull (fetch + merge)

```text
   │
   ├── git pull con política merge: mismo conflicto,
   │   mismos lados (HEAD = tuyo, entrante = remoto)
   │
   └── cierre: git commit (no hay «--continue»: el
       pull ES el merge)
```

### 4.3. Merge de upstream en un fork

```bash
git fetch upstream
git merge upstream/main     # conflicto posible
```

```text
   │
   ├── lados: HEAD = tu main, >>>>>> = upstream/main
   │
   └── resolución típica: dejar que el oficial pese
       más (contexto del proyecto) salvo trabajo local
       legítimo
```

### 4.4. Merge entre ramas de release

```text
   │
   ├── cherry-picks duplicados (conflicto de adición)
   │
   └── método: priorizar el contenido ya probado y
       unificar
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: Invertir lados en merge (o temer la inversión)

**Qué ocurrió:** alguien aplica «la regla de rebase» en un merge y elige mal; o teme usar `--ours` en merge «por si está invertido».

**Por qué:** mezclar los dos capítulos.

**Cómo comprobarlo:** status («merging»); HEAD = último commit de TU rama.

**Opciones:** en merge: ours=tuyo, theirs=entrante (sin inversión).

**Riesgos:** contenido al revés.

**Solución:** verificar con `log -1` de cada lado antes de elegir flags.

**Cómo se evita:** este capítulo (merge) y el 06 (rebase) por separado.

---

### Error 2: `--ours/--theirs` a ciegas en archivo con matices

**Qué ocurrió:** se cogió un lado entero y se perdieron cambios válidos del otro dentro de ese archivo.

**Por qué:** el archivo tenía varias zonas modificadas.

**Cómo comprobarlo:** `git show :2:archivo` y `:3:` comparados con el resultado.

**Opciones:** si no cerró: volver a resolver editando; si cerró: revisar y corregir (fix o rehacer si no publicado).

**Riesgos:** pérdida de trabajo de una rama.

**Solución:** flags solo cuando UNO gana para todo.

**Cómo se evita:** leer cada bloque (método cap. 04).

---

### Error 3: Cerrar el merge con el editor «en blanco» (mensaje vacío o raro)

**Qué ocurrió:** commit de merge sin mensaje (o con solo un enter) en repos con política de mensajes.

**Por qué:** se cerró a prisa con `-m ""` o editor vacío.

**Cómo comprobarlo:** `git log -1` (mensaje vacío).

**Opciones:** si no publicado: `git commit --amend` (merge local reciente, sin push); si publicado: mensajes raros se asumen (no se reescriben por un espacio).

**Riesgos:** historial ilegible.

**Solución:** mensaje informativo desde el principio.

**Cómo se evita:** no pasar `-m` vacío.

---

### Error 4: Pull y conflicto con trabajo sucio mezclado

**Qué ocurrió:** el pull mezcló conflicto entrante con cambios locales sin commitear → confusión total de lados.

**Por qué:** no se respetó la regla de carpeta limpia.

**Cómo comprobarlo:** `status` (¿modificados no preparados + unmerged?).

**Opciones:**
* si aún no hay conflicto entrante: cancelar/estabilizar con commit/stash y re-pull;
* si ya entró: resolver los unmerged y, aparte, revisar los cambios sucios restantes.

**Riesgos:** pisar trabajo propio.

**Solución:** status antes de pull (raíz 26).

**Cómo se evita:** disciplina de cierre de temas.

---

### Error 5: Resuelto pero el merge no cierra («no hay merge en curso»)

**Qué ocurrió:** se resolvió y `git commit` dice que no hay MERGE_HEAD (o ya estaba cerrado/aborted).

**Por qué posibles:**
* alguien hizo `--abort` en otra terminal;
* el cierre ya ocurrió (doble ejecución);
* era rebase (el cierre es `--continue`, no commit).

**Cómo comprobarlo:** `git status` («nothing to commit» / «no merge in progress»); `.git/MERGE_HEAD`.

**Opciones:** según diagnóstico: re-abrir merge (re-ejecutar), o `rebase --continue`, o verificar si ya está cerrado.

**Riesgos:** commits vacíos extraños.

**Solución:** status primero.

**Cómo se evita:** una operación a la vez, una terminal a la vez.

---

### Error 6: Resolver en web y local a la vez

**Qué ocurrió:** dos resoluciones distintas del mismo conflicto → divergencia y confusión.

**Por qué:** dos superficies sin coordinación.

**Cómo comprobarlo:** PR con contenido distinto al local; logs divergentes.

**Opciones:** elegir UNA (la que tenga el PR) y sincronizar la otra con fetch/pull.

**Riesgos:** pérdida de trabajo y retrabajo.

**Solución:** mapeo antes de empezar.

**Cómo se evita:** regla del capítulo 03 (Error 5).

---

## 6. Práctica guiada

### Objetivo

Resolver un conflicto de merge completo usando edición y flags, y cerrarlo con buen mensaje.

### Paso 1: conflicto clásico

```bash
git switch main
echo "versión base" > merge-conf.md && git add . && git commit -m "base"

git switch -c m-a && echo "A dice: versión A" > merge-conf.md && git commit -am "lado A"
git switch main && git switch -c m-b && echo "B dice: versión B" > merge-conf.md && git commit -am "lado B"

git switch main
git merge --no-ff m-a
git merge --no-ff m-b          # conflicto
```

### Paso 2: lados con certeza

```bash
git status
git log -1 HEAD --oneline      # ¿de qué lado es HEAD?
git log -1 m-b --oneline
git show :2:merge-conf.md
git show :3:merge-conf.md
```

### Paso 3: dos resoluciones

```bash
# (a) edición manual: deja "versión B (decidida en A+B)"
cat merge-conf.md              # revisa sin marcadores
git diff --check
git add merge-conf.md
```
Prepara otro conflicto y prueba (b):
```bash
git merge --abort              # si sigues en pausa
# repite la provocación y entonces:
git checkout --theirs merge-conf.md   # lado entrante
git add merge-conf.md
```

### Paso 4: cerrar con mensaje

```bash
git status                 # sin unmerged
git commit -m "Merge m-b: unifica A y B en merge-conf.md"
git log --graph --oneline -n 8
git show HEAD --stat
```

### Paso 5: pull con conflicto (variante)

1. Con dos clonos: en A sube cambios a un archivo; en B cambia lo mismo sin pull.
2. `git pull` en B → conflicto con los mismos lados (HEAD=B, entrante=A).
3. Resuelve y `git commit`.

### Paso 6: mergetool (opcional)

```bash
git config --global merge.tool <tu-herramienta>  # si tienes
git mergetool
```

### Resultado Esperado

Cierre completo de conflicto de merge con lados verificados, método elegido y mensaje documental.

### Conclusión esperada

En merge, los lados son estables y las herramientas directas: quien verifica quién es quién, resuelve sin sorpresas.

---

## 7. Nivel profesional + resumen

### 7.1. Merge conflicts en flujos con PR

```text
   │
   ├── GitHub ofrece resolver en web (editor con
   │   marcadores) o localmente y hacer push de la
   │   rama
   │
   ├── la resolución cuenta como commit en el PR:
   │   se revisa como cualquier otro
   │
   ├── «Update branch» (traer main a la rama en la
   │   web) genera el merge/ff y a veces los conflictos
   │   donde se resuelve
   │
   └── política de equipo: quién resuelve (autor del
       PR) y cómo se documenta
```

### 7.2. Calidad de resolución

```text
   │
   ├── tests post-resolución obligatorios en lógica
   │
   ├── diff del merge revisado en la revisión
   │
   └── en conflictos «estratégicos» (comportamiento):
       decisión del dueño del dominio, no del que
       llegue primero
```

### 7.3. Resumen

En este capítulo aprendiste que:

* en merge: HEAD = tu rama; entrante = la rama fusionada; se verifica con status, `log -1` de cada lado y `show :2/:3`;
* herramientas: edición manual (base), `--ours/--theirs` (sin inversión en merge) y `mergetool`/editor web con tres paneles;
* el cierre es `git commit` (mensaje por defecto con lista de conflictos, o mejor si la resolución fue no obvia);
* flujos típicos: rama a main, pull y merge de upstream — todos con la misma semántica de lados;
* los errores típicos (inversión importada de rebase, flags a ciegas, mensaje vacío, suciedad mezclada, cierre duplicado, doble superficie) se previenen con status y método;
* a nivel profesional: resolución revisada como parte del PR y decisiones del dominio correcto.

La idea principal es:

> **En merge, la regla es simple y verificable: tuyo a la izquierda, entrante a la derecha — confírmala y resuelve con la herramienta que el archivo merezca.**

---

## Próximo paso

Ya dominas los conflictos de merge.

Ahora la variante con trampa: los conflictos en rebase (con lados invertidos).

Continúa con:

[`06-conflictos-en-rebase.md`](06-conflictos-en-rebase.md)
