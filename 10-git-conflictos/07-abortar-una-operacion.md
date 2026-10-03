  Abortar una operación

   Introducción

No todo conflicto debe resolverse a veces: hay momentos en que la mejor decisión es cancelar y volver al punto de partida intacto. `merge --abort`, `rebase --abort` y sus hermanos (`cherry-pick --abort`, `revert --abort`, `stash` en conflicto) existen precisamente para eso: salir limpio, sin perder nada y sin dejar el repositorio a medias.

Este capítulo enseña a abortar con seguridad: qué comandos hay, cuándo usar cada uno, qué restauran exactamente y qué hacer cuando el abort no es posible o ya no es suficiente (estados colgados, trabajo sucio, reflog).

En este capítulo aprenderás:

* los comandos de abortación y su alcance exacto;
* cuándo abortar vs. cuándo resolver (criterio);
* estados a medias (pausas, `--quit`, operaciones colgadas) y cómo sanearlos;
* abortar sin perder trabajo (carpeta limpia, reflog, stash);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

   Mapa conceptual de este capítulo

```text
Abortar una operación
       │
       ├── 1. Comandos de abort (mapa)
   │        ├── merge --abort
   │        ├── rebase --abort
   │        ├── cherry-pick / revert / am --abort
   │        └── stash en conflicto
   │
       ├── 2. Criterio: abortar o resolver
   │
       ├── 3. Estados a medias y sanear
   │
       ├── 4. Abortar sin perder trabajo
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

   1. Comandos de abort (mapa)

```text
OPERACIÓN EN PAUSA           SALIDA LIMPIA
──────────────────────────────────────────────────────
git merge                →  git merge --abort
git rebase               →  git rebase --abort
git cherry-pick          →  git cherry-pick --abort
git revert (commit)      →  git revert --abort
git am                   →  git am --abort
git stash (pop con       →  git stash drop (tras
  conflicto)                resolver) o stash --abort
                            donde exista
git rebase interactivo   →  git rebase --abort
                            (--quit deja la estructura
                            a medias: evitar)
```

```text
Qué restauran:
   │
   ├── merge --abort  → estado previo EXACTO al merge
   │                    (como si no hubieras empezado)
   │
   ├── rebase --abort → ORIG_HEAD: el punto exacto
   │                    antes del rebase
   │
   └── todos: sin cambios perdidos SI la carpeta estaba
       en orden antes de empezar
```

```bash
  comprobación tras abortar:
git status              clean (o con tus cambios previos)
git log --oneline -n 3
```

---

   2. Criterio: abortar o resolver

```text
RESOLVER cuando:                 ABORTAR cuando:
──────────────────────────────────────────────────────
· entiendes ambos lados          · no entiendes la
· la decisión es clara             intención de uno de
· tienes información (history)     los lados
· es tu trabajo y avanzas         · necesitas otra
                                    persona/equipo
· el conflicto es pequeño         · la rama cambió mucho
                                    (mejor re-preparar)
· tienes tiempo/head claro        · no es el momento
                                    (urgencias, PR mal
                                    orientado)
· estás en un ejercicio de        · estás probando
  aprendizaje                       (aprender a empezar
                                    de cero es válido)
```

```text
Regla profesional:
   │
   ├── «abortar es una decisión, no un fracaso»
   │
   └── lo que NUNCA se hace: cerrar a medias para
       «quitárselo de encima» (eso no es abortar, es
       romper)
```

---

   3. Estados a medias y sanear

    3.1. Detección

```bash
git status
```

```text
Posibles estados:
   │
   ├── "You have unmerged paths" + MERGE_HEAD     →
   │   merge en curso
   │
   ├── "interactive rebase in progress"           →
   │   rebase en curso
   │
   ├── "cherry-pick in progress"                  →
   │   cherry-pick en curso
   │
   ├── "nothing to commit" pero operación «rara»   →
   │   pausa/estructura colgada
   │
   └── (.git contenga rebase-merge/rebase-apply,
       CHERRY_PICK_HEAD, MERGE_HEAD…)
```

    3.2. Árbol de sanado

```text
Estado detectado
   │
   ├── ¿quieres terminarlo?   → método de resolución
   │                            (caps. 04-06) y
   │                            continuar/commit
   │
   ├── ¿quieres cancelar?     → --abort del operador
   │
   ├── ¿abort no funciona?    → ver punto 4
   │
   └── ¿ya no hay operación?  → limpiar residuos:
                                revisar archivos con
                                marcadores, quitar
                                índice con add/rm o
                                restaurar (reflog)
```

    3.3. `--quit` (uso avanzado, peligroso)

```text
   │
   ├── deja la estructura de rebase a medias (sin
   │   restaurar nada)
   │
   ├── sirve para expertos que saben cómo seguir
   │   manualmente
   │
   └── en aprendizaje: NO usar (causa estados colgados
       que confunden)
```

---

   4. Abortar sin perder trabajo

```text
PRECONDICIÓN (siempre):
   │
   ├── antes de merge/rebase: carpeta limpia (todo
   │   commiteado o stashado) — raíz 26
   │
   └── con eso, --abort es no destructivo por diseño
```

```bash
  ¿y si ya pasó algo raro?

git status
git reflog                        historial de HEAD
    ... verás el punto anterior al rebase/merge

git checkout -b recuperacion      copia de seguridad opcional
                                  desde el estado actual

  si hubo cambios sueltos en la carpeta:
git diff                          evaluar
git stash push -m "antes de limpiar"     guardarlos

  para volver a un estado anterior conocido:
git reset --hard <commit>         OJO: destructivo: sólo con
                                  certeza (cap. 26/27)
  (alternativa segura: nueva rama desde el commit:
git switch -c desde-aqui <commit>)
```

```text
Orden de preferencia para recuperarse:
   │
   ├── 1. nueva rama / stash (no destruye nada)
   ├── 2. reflog + reset --hard sólo si lo entiendes
   └── 3. nunca: rehacer trabajo sin comprobar reflog
```

---

   5. Errores comunes con diagnóstico completo

    Error 1: `--abort` con cambios sin commitear

**Qué ocurrió:** el abort falla o arrastra/mezcla cambios de trabajo (checkout del estado previo).

**Por qué:** carpeta sucia durante una operación estructural.

**Cómo comprobarlo:** `git status` (modified sin commit).

**Opciones:**
* guardarlo: `git stash push` → abort → `stash pop`;
* si ya mezcló: revisar archivo a archivo (`git diff`) y estabilizar.

**Riesgos:** pérdida o confusión de trabajo propio.

**Solución:** limpiar (commit/stash) antes de abortar.

**Cómo se evita:** precondición del punto 4.

---

    Error 2: Ejecutar `--abort` equivocado («merge --abort» en rebase)

**Qué ocurrió:** Git no reconoce la operación («There is no merge to abort» o similar).

**Por qué:** no se identificó el operador en curso (cap. 03).

**Cómo comprobarlo:** `git status` (dice qué hay en curso).

**Opciones:** usar el `--abort` correcto; si no, seguir el árbol del punto 3.2.

**Riesgos:** prisa → más estados raros.

**Solución:** status → abort correcto.

**Cómo se evita:** identificar siempre primero.

---

    Error 3: Creer que abortar borra lo ya resuelto en otros archivos

**Qué ocurrió:** se abortó tras resolver tres archivos y se «perdió» esa resolución.

**Por qué:** `--abort` restaura TODO al punto de partida (por diseño).

**Cómo comprobarlo:** tras abortar, los archivos vuelven al estado previo.

**Opciones:** si la resolución importaba: rehacerla (o si estaba en stash/copias, recuperarla); para conservar parcial: no abortar — seguir resolviendo.

**Riesgos:** retrabajo.

**Solución:** saber que abort = cancelación total.

**Cómo se evita:** criterio del punto 2 (abortar solo al empezar/mal planteado).

---

    Error 4: Abortar y no comprobar que quedó limpio

**Qué ocurrió:** tras abort quedaron restos (marcadores, índice raro) y la siguiente operación falla.

**Por qué:** no se verificó.

**Cómo comprobarlo:** `status` + `diff --check` + grep de marcadores.

**Opciones:** limpiar los restos (checkout del archivo / add-rm / reset del índice).

**Riesgos:** contaminar el siguiente merge.

**Solución:** checklist post-abort (status, check, grep).

**Cómo se evita:** tratar el abort como paso con verificación.

---

    Error 5: Abortar en lugar de pedir ayuda cuando hay duda real

**Qué ocurrió:** se canceló el conflicto de un PR importante para «dejarlo para luego» y se perdió contexto/dirección.

**Por qué:** miedo/prisa sin plan.

**Cómo comprobarlo:** PR bloqueado, sin rama en curso, equipo esperando.

**Opciones:** rehacer con contexto (raramente desde cero: reflog guarda el estado), involucrar al dueño del dominio.

**Riesgos:** retrabajo, fricción de equipo.

**Solución:** decidir con el criterio del punto 2.

**Cómo se evita:** abort es opción, no reflejo.

---

    Error 6: Saneado agresivo (borrar `.git` a mano, re-clonar a ciegas)

**Qué ocurrió:** alguien intentó «arreglar» estados raros manipulando `.git` o borrando el repo sin verificar commits locales.

**Por qué:** desesperación sin usar reflog/stash.

**Cómo comprobarlo:** pérdida aparente de trabajo.

**Opciones:**
* recuperar vía reflog (commits) y stash;
* clonar de nuevo NO recupera trabajo local sin push/stash — solo si estaba publicado.

**Riesgos:** pérdida definitiva.

**Solución:** herramientas nativas primero (`status`, `reflog`, `fsck`).

**Cómo se evita:** nunca tocar `.git` manualmente.

---

   6. Práctica guiada

    Objetivo

Abortar merge y rebase con verificación, y sanear un estado colgado.

    Paso 1: conflicto y abort de merge

```bash
git switch main
echo "A" > ab.md && git add . && git commit -m "base"
git switch -c ab-a && echo "A2" > ab.md && git commit -am "a"
git switch main && git switch -c ab-b && echo "B2" > ab.md && git commit -am "b"
git switch main && git merge --no-ff ab-a
git merge --no-ff ab-b          conflicto
git status
git merge --abort
git status                      limpio
git log --oneline -n 3          igual que antes
```

    Paso 2: conflicto y abort de rebase

```bash
git switch -c ab-rb main
git rebase ab-b                 conflicto (si difieren)
git status
git rebase --abort
git status                      exactamente previo
git log --graph --oneline -n 5
```

    Paso 3: post-verificación

```bash
git diff --check
git grep -n "<<<<<<<" || echo "sin marcadores"
```

    Paso 4: práctica de criterio

Con un conflicto en pausa (repite paso 1 y NO abortes), responde:

1. ¿Qué operación es? (status)
2. ¿Qué archivos? (`diff-filter=U`)
3. ¿Entiendes ambos lados? (¿sí/no por qué?)
4. Decisión: resolver o abortar — justifícalo.
5. Ejecuta tu decisión y verifica.

    Paso 5: simulación de residuo (avanzado)

```bash
  tras un abort, provoca un residuo artificial:
echo "<<<<<<< HEAD" >> ab.md
git add ab.md
git status                      staged con marcador
git diff --cached
  ¡corrección!: edita el archivo, quita la línea, add
git diff --cached --check
git reset HEAD ab.md            o deja lo correcto staged
```

1. Practica detectar restos y sanearlos.

    Resultado Esperado

Cancelaciones limpias, verificadas, y capacidad de decidir entre resolver y abortar con argumentos.

    Conclusión esperada

Abortar bien es tan disciplinado como resolver: identificar, asegurar el trabajo, cancelar y comprobar.

---

   7. Nivel profesional + resumen

    7.1. Abort en flujos reales

```text
   │
   ├── PR con conflicto mal planteado: abort en local +
   │   re-preparar la rama desde main actualizado
   │   (o «Update branch» en la web y resolver ahí)
   │
   ├── rebase local abortado: nada visible para el
   │   equipo (ventaja de no haber empujado)
   │
   ├── merge abortado tras botón web: recargar la
   │   página (la superficie web también «aborta» al
   │   descartar)
   │
   └── post-mortems: si un conflicto se aborta dos
       veces, la rama/planteamiento está mal (raíz 24)
```

    7.2. Checklist post-abort

```text
□ status limpio (o con lo previo esperado)
□ diff --check sin marcadores
□ grep de marcadores vacío
□ log --graph con la estructura previa
□ stash/diff revisados si se guardó algo
□ siguiente operación arranca normal
```

    7.3. Resumen

En este capítulo aprendiste que:

* cada operación con pausa tiene su `--abort` (merge, rebase, cherry-pick, revert, am) y restaura el punto previo exacto;
* abortar vs. resolver es una decisión con criterio (entender, información, momento) — abortar es legítimo;
* los estados a medias se detectan con `status` y se sanan con el árbol: continuar, abortar, o limpieza manual conservadora;
* abortar sin perder trabajo exige carpeta limpia previa y, si algo se tuerce, `stash`/`reflog`/nuevas ramas antes que `reset --hard` o manipular `.git`;
* los errores típicos (suciedad, abort equivocado, pérdida de resoluciones parciales, verificación ausente, prisa vs. ayuda, saneado destructivo) se previenen con el checklist;
* a nivel profesional: abort repetido = síntoma de planteamiento erróneo, no de mala suerte.

La idea principal es:

> **Cancelar bien es avanzar: identifica la operación, asegura tu trabajo, aborta y verifica — el repositorio queda como si nada hubiera pasado.**

---

   Próximo paso

Sabes abortar y sanear.

El último capítulo de la sección previene conflictos: buenas prácticas para que aparezcan menos (y sean más fáciles).

Continúa con:

[`08-buenas-practicas.md`](08-buenas-practicas.md)
