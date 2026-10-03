# Identificar un conflicto

## Introducción

Antes de resolver hay que ver. Identificar un conflicto es leer las señales de Git —mensajes, `status`, marcadores, índice— y saber exactamente dónde estás: ¿merge o rebase? ¿cuántos archivos? ¿cuál es cada lado? Esa lectura, hecha en dos minutos, evita las resoluciones a ciegas que luego cuestan horas.

En este capítulo construyes el método de identificación: la secuencia de comandos, la traducción de cada señal y la comprobación de que no quedan restos.

En este capítulo aprenderás:

* las señales de conflicto (mensaje, estado, archivos);
* la secuencia de identificación (status → diff → índice);
* distinguir merge de rebase en pausa;
* detectar residuos con `diff --check` y grep;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (checklist de identificación).

---

## Mapa conceptual de este capítulo

```text
Identificar un conflicto
       │
       ├── 1. Señales
   │        ├── mensaje de Git
   │        ├── git status (unmerged paths)
   │        └── archivos con marcadores
   │
       ├── 2. La secuencia de identificación
   │        ├── ¿en qué operación estoy?
   │        ├── ¿qué archivos?
   │        └── ¿qué bloques y quién es quién?
   │
       ├── 3. Índice y estados (ls-files -u)
   │
       ├── 4. Comprobación de residuos
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Señales

### 1.1. El mensaje

```text
Merge:
 CONFLICT (content): Merge conflict in notas.md
 Automatic merge failed; stopped at …

Rebase (aplicando tu commit):
 CONFLICT (merge conflict): ...
 error: could not apply abc1234... Mensaje
 hint: Resolve all conflicts manually, mark them as
 resolved with "git add/rm <files>", then run
 "git rebase --continue".

Push rechazado (NO es conflicto):
 ! [rejected] ... (non-fast-forward)
```

### 1.2. `git status`

```text
En conflicto:
  Unmerged paths:
    both modified:   notas.md
    deleted by us:   viejo.txt
    added by both:   nuevo.md
    ...

Etiquetas útiles:
   both modified      ambos editaron
   added by both      ambos crearon
   deleted by us      vosotros borrasteis; ellos editaron
   deleted by them    al revés
```

### 1.3. Los marcadores en el archivo

```bash
git diff                    # en conflicto: muestra bloques
git diff --name-only --diff-filter=U   # solo los U
                                         (unmerged)
```

---

## 2. La secuencia de identificación

```text
MÉTODO (dos minutos)
──────────────────────────────────────────────────────
1. ¿EN QUÉ ESTOY?
     git status
     · "You have unmerged paths" → conflicto
     · ¿merge?  ¿"Merging"? / MERGE_HEAD
     · ¿rebase? "interactive rebase in progress" /
       rebase-merge en .git
     · ¿nada de esto? → no hay operación (busca otra
       causa)

2. ¿QUÉ ARCHIVOS?
     git status (Unmerged paths)
     git diff --name-only --diff-filter=U

3. ¿QUIÉN ES QUIÉN?
     · merge: HEAD = tuyo; >>>>>> = lo que llega
     · rebase: HEAD = base nueva; >>>>>> = tu commit
     · duda: git log --graph --left-right <lados>

4. ¿QUÉ BLOQUES?
     abre el archivo (o git diff) y localiza cada
     marcador: anota líneas y decisión prevista

5. ¿QUÉ HISTORIAL RESPALDA LA DECISIÓN?
     git log -p --follow -- <archivo>   (contexto)
     git show <commit> -- <archivo>     (cambios
     concretos)
```

---

## 3. Índice y estados (`ls-files -u`)

```bash
git ls-files -u
```

```text
Salida:
 100644 hashA 1 notas.md   ← stage 1: ancestro
 100644 hashB 2 notas.md   ← stage 2: HEAD (tuyo)
 100644 hashC 3 notas.md   ← stage 3: otro lado

   │
   ├── tres entradas = conflicto abierto
   ├── puedes inspeccionar cada versión:
   │      git show :1:notas.md   (ancestro)
   │      git show :2:notas.md   (tuyo)
   │      git show :3:notas.md   (otro)
   └── tras `git add`: 0 entradas (resuelto)
```

```text
Cada marcador corresponde a esos stages:
   │
   ├── HEAD block = :2
   ├── other block = :3
   └── (el ancestro rara vez se muestra, pero guía la
       decisión: «¿qué cambió cada uno?»)
```

---

## 4. Comprobación de residuos

```bash
git diff --check          # señala <<<<<<< y líneas de
                          # conflicto restantes
git grep -n "<<<<<<<"    # búsqueda directa (por árbol)
git grep -n "<<<<<<<" -- <archivo>
```

```text
Antes de CUALQUIER cierre (add/commit/continue):
   │
   ├── 1. diff --check limpio
   ├── 2. grep sin resultados
   └── 3. revisión humana del diff final del archivo
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «No veo conflicto pero no me deja continuar»

**Qué ocurrió:** `merge --continue`/`rebase --continue`/`commit` falla.

**Por qué posibles:**
* quedan archivos unmerged sin `add`;
* quedan marcadores (add hecho sin revisar);
* en rebase: faltan pasos (add TODOS los resueltos).

**Cómo comprobarlo:** `git status` (¡siempre arriba dice qué falta!); `git ls-files -u`.

**Opciones:** resolver los que faltan → add → continuar.

**Riesgos:** forzar con flags raros (no).

**Solución:** status como brújula.

**Cómo se evita:** método del punto 2.

---

### Error 2: Confundir la operación en curso (merge vs. rebase vs. cherry-pick)

**Qué ocurrió:** se resolvió «como merge» en un rebase (o viceversa) y los lados salieron invertidos.

**Por qué:** no se identificó la operación primero.

**Cómo comprobarlo:** `git status` («merging» vs. «interactive rebase in progress»); presencia de `.git/MERGE_HEAD` o `.git/rebase-merge`.

**Opciones:** continuar con la lectura correcta de lados (capítulo 06 si es rebase); si ya se cerró mal: rehacer (reflog) con método.

**Riesgos:** resolución invertida (contenido equivocado).

**Solución:** paso 1 de la secuencia.

**Cómo se evita:** nunca empezar a editar sin status.

---

### Error 3: Conflicto «invisible» (archivo enorme, marcador lejano)

**Qué ocurrió:** se creyó resuelto; había un marcador en la línea 2000.

**Por qué:** revisión a prisa.

**Cómo comprobarlo:** `git diff --check` (lo detecta aunque tú no lo hayas visto).

**Opciones:** editar y volver a comprobar.

**Riesgos:** commit con marcadores.

**Solución:** check automatizado (paso obligatorio).

**Cómo se evita:** grep/check siempre (punto 4).

---

### Error 4: Resolución sin entender «quién es quién»

**Qué ocurrió:** se eligió un lado por intuición sin entender los cambios de cada rama.

**Por qué:** saltarse la identificación histórica.

**Cómo comprobarlo:** si el resultado no explica lo que ambas ramas querían.

**Opciones:** `log -p` de ambos lados; conversación si hay duda.

**Riesgos:** perder intención de una rama entera.

**Solución:** mirar historia antes de decidir (paso 5).

**Cómo se evita:** rutina completa (2 minutos bien gastados).

---

### Error 5: Identificar «por el archivo de GitHub» y resolver en local sin entender estado

**Qué ocurrió:** en la web hay un resolutor de conflictos; alguien lo usó sin saber en qué rama/PR está, y el local quedó divergido.

**Por qué:** mezclar superficies sin mapear.

**Cómo comprobarlo:** `git status` local (desactualizado), PR en estado raro.

**Opciones:** fetch + leer el estado real; cerrar la resolución en UN sitio (web o local) y sincronizar.

**Riesgos:** dos resoluciones distintas.

**Solución:** elegir superficie y terminarla.

**Cómo se evita:** flujo único por PR.

---

### Error 6: Tomar conflicto de OTRO archivo como referencia

**Qué ocurrió:** resolvieron todos los archivos «igual que el primero» sin mirar cada uno.

**Por qué:** prisa/pereza.

**Cómo comprobarlo:** `git diff` del merge: cambios sospechosamente idénticos.

**Opciones:** revisar uno por uno (los marcadores varían).

**Riesgos:** contenido incorrecto en archivos distintos.

**Solución:** método por archivo (capítulo 04).

**Cómo se evita:** checklist de archivos pendientes (`diff-filter=U`).

---

## 6. Práctica guiada

### Objetivo

Recorrer el método de identificación completo sobre un conflicto provocado.

### Paso 1: monta el conflicto (si no tienes uno)

```bash
git switch main
echo "base" > identificar.md && git add . && git commit -m "base"
git switch -c id-a && echo "A" > identificar.md && git commit -am "A"
git switch main && git switch -c id-b && echo "B" > identificar.md && git commit -am "B"
git switch main && git merge --no-ff id-a
git merge --no-ff id-b    # conflicto
```

### Paso 2: paso 1 — ¿en qué estoy?

```bash
git status
ls .git                   # (o dir) ¿MERGE_HEAD?
```

1. Traduce: «merging», «unmerged paths».

### Paso 3: paso 2 — ¿qué archivos?

```bash
git diff --name-only --diff-filter=U
```

### Paso 4: paso 3 — quién es quién

```bash
git ls-files -u
git show :2:identificar.md
git show :3:identificar.md
git show :1:identificar.md
```

1. Relaciona stages con marcadores del archivo.

### Paso 5: paso 5 — contexto

```bash
git log --oneline id-a id-b -- identificar.md
git log -p -n 2 -- identificar.md
```

### Paso 6: simulación de cierre y check

```bash
# NO resuelvas aún; solo ensaya las comprobaciones:
git diff --check            # marca los marcadores
git grep -n "<<<<<<<"
git merge --abort
git status                  # limpio
```

### Resultado Esperado

Un método mecánico que puedes ejecutar en cualquier conflicto: seis comandos y una lectura.

### Conclusión esperada

Identificar es separar hechos de pánico: operación, archivos, lados, bloques, historia — en ese orden, siempre.

---

## 7. Nivel profesional + resumen

### 7.1. Identificación en equipo

```text
En PRs con conflictos (web o local):
   │
   ├── ver el estado ANTES de resolver (¿qué merge es?
   │   ¿qué base?)
   │
   ├── resolver en una sola superficie (la que esté
   │   el PR) y refrescar la otra
   │
   ├── en el mensaje del PR: documentar decisiones no
   │   obvias de resolución
   │
   └── CI vuelve a correr tras resolver: identificar
       incluye verificar que «verde» otra vez
```

### 7.2. Plantilla de identificación (checklist)

```text
□ git status → operación y lista de U
□ diff-filter=U → archivos
□ ls-files -u → lados (1/2/3)
□ log/commit de contexto → intención de cada lado
□ decisión por archivo
□ diff --check + grep → sin residuos
□ add → continuar/commit
□ CI/ tests → verificación final
```

### 7.3. Resumen

En este capítulo aprendiste que:

* las señales son: mensaje (CONFLICT…), `status` (unmerged paths) y marcadores en archivos;
* la secuencia: identificar la operación (merge/rebase/otra) → listar archivos → establecer lados (HEAD/otros, o stages 2/3) → leer bloques → consultar historia;
* el índice en conflicto tiene tres entradas por archivo (`ls-files -u`): ancestro, tuyo, otro — y `git show :N:archivo` las abre;
* `diff --check` y `git grep -n "<<<<<<<"` detectan residuos aunque no los veas;
* los errores típicos (continuar sin add, operación confundida, residuos invisibles, resolución a ciegas, superficies mezcladas) se previenen con la secuencia;
* a nivel profesional: checklist fijo, una sola superficie de resolución y verificación con CI.

La idea principal es:

> **Identificar antes de tocar: seis comandos convierten el «no entiendo qué pasa» en «sé exactamente dónde estoy y qué decisión me espera».**

---

## Próximo paso

Ya identificas cualquier conflicto.

Ahora el corazón de la sección: resolverlo.

Continúa con:

[`04-resolver-un-conflicto.md`](04-resolver-un-conflicto.md)
