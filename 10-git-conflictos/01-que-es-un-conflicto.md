# Qué es un conflicto

## Introducción

El conflicto es el momento en que Git dice «esto lo decides tú»: dos líneas de trabajo cambiaron lo mismo y el sistema no puede adivinar cuál es la verdad. Es la cara menos amigable de Git — y también la más malentendida: un conflicto no es un error, no es pérdida de datos y no es señal de que algo se rompió. Es una conversación pendiente entre dos historias.

En esta sección aprenderás a provocarlos sin miedo, a leerlos con calma y a resolverlos con método. Este primer capítulo define qué es un conflicto a nivel de Git (marcadores, estado, índice) y qué NO es.

En este capítulo aprenderás:

* la definición precisa de conflicto (y sus tipos);
* qué significa «unmerged paths» en el índice;
* los marcadores de conflicto y su anatomía;
* qué NO es un conflicto (errores frecuentes);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Qué es un conflicto
       │
       ├── 1. Definición
   │        ├── dos cambios solapados + ancestro
   │        └── tipos: contenido, adición/borrado, rename
   │
       ├── 2. El estado de conflicto
   │        ├── índice: entradas unmerged (stage 1-3)
   │        ├── mensaje y archivos marcados
   │        └── la operación «en pausa»
   │
       ├── 3. Los marcadores
   │        ├── anatomía <<<<<<< ======= >>>>>>>
   │        └── quién es quién
   │
       ├── 4. Qué NO es un conflicto
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Definición

### 1.1. La fórmula

```text
Conflito = ancestro común + dos cambios incompatibles
           en el mismo sitio

   │
   ├── hay ancestro (bifurcación)
   ├── A cambió X; B cambió X (de forma que Git no
   │   puede combinar automáticamente)
   └── Git intenta three-way merge y al llegar a X:
       «decisión humana»
```

```text
Ejemplo mínimo:
   ancestro:  "párrafo uno"
   rama A:    "párrafo uno (revisado)"
   rama B:    "párrafo uno (traducido)"
   → la misma línea con dos destinos distintos
```

### 1.2. Tipos

```text
Tipo                     Qué pasa
──────────────────────────────────────────────────────────
de CONTENIDO             ambos editaron líneas cercanas
adición vs. adición      ambos CREARON el mismo archivo
                         (con contenido posible distinto)
borrado vs. edición      uno borró, otro editó
rename vs. edit/rename   ambos movieron/renaming similar
borrado vs. rename       (casos raros; Git puede pedir
                         resolución explícita)
```

### 1.3. El espectro: automático ↔ humano

```text
sin conflicto         Git combina y sigue
                      (resolución automática)
conflicto             Git PARA y espera tu decisión
error (no confl.)     orden mal dada, suciedad, etc.
                      (otra categoría: nada que ver)

→ un conflicto es un ESTADO normal del merge/rebase,
  no un fallo del sistema
```

---

## 2. El estado de conflicto

### 2.1. Cómo lo expresa Git

```text
Auto-merge failed; fix conflicts and then commit...
CONFLICT (content): Merge conflict in notas.md
Automatic merge failed; stopped at commit…
```

```bash
git status
```

```text
On branch main
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  both modified:   notas.md
```

### 2.2. Qué pasa en el índice (nivel técnico)

```text
   │
   ├── los archivos en conflicto tienen TRES entradas
   │   en el índice (stage): el ancestro y las dos
   │   versiones
   │
   │   git ls-files -u      →  las tres (stage 1,2,3)
   │
   ├── al hacer `git add` de un archivo resuelto:
   │   se queda UNA entrada (stage 0) = resuelto
   │
   └── por eso «add» es también la marca de «esto ya
       está decidido» (sección 07 anterior)
```

### 2.3. La operación en pausa

```text
   │
   ├── merge en curso: .git/MERGE_HEAD existe
   ├── rebase en curso: .git/rebase-merge/ (o
   │   rebase-apply)
   └── Git NO permite otra operación hasta concluir
       o abortar (sección 07 de esta)
```

---

## 3. Los marcadores

### 3.1. Anatomía

```text
<<<<<<< HEAD
versión tuya (tu rama / lo que tenías)
=======
versión que llega (la rama fusionada / la nueva base)
>>>>>>> nombre-de-la-rama
```

```text
Lectura:
   │
   ├── HEAD = tu lado actual
   ├── >>>>>> = el otro lado
   ├── ======= = el centro
   └── en rebase: HEAD es la NUEVA BASE (lo que
       bajaste) y >>>>>> es TU commit (invertido
       respecto a merge — detalle clave: capítulo 06)
```

### 3.2. Variantes y números (versión, mención)

```text
   │
   ├── versiones nuevas pueden añadir números de
   │   commit o índices: <<<<<<< (HEAD abc1234)
   │
   └── y herramientas (mergetool) muestran tres paneles:
       ancestro / tuyo / otro — los mismos datos
```

### 3.3. Tu trabajo al resolver

```text
Resultado deseado del archivo:
   │
   ├── SIN marcadores
   ├── con lo que DEBE quedar (no «los dos textos
   │   pegados» salvo que sea correcto)
   └── listo para `git add`
```

---

## 4. Qué NO es un conflicto

```text
Mito                                  Realidad
──────────────────────────────────────────────────────────
"Git se ha roto"                      es un estado previsto
"perdí los archivos"                  están ahí, con
                                       marcadores
"hay que rehacer el trabajo"          solo hay que
                                       decidir/editar
"conflicto = mala rama"                pueden confluir
                                       ramas perfectas
"si hay conflicto, no se puede        se resuelve y se
abandonar"                            puede abortar
"conflicto con el remoto (push)"      no: push rechazado
                                       no es conflicto de
                                       contenido
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: Confundir «rechazo de push» con conflicto

**Qué ocurrió:** el push fue rechazado y se habló de «conflicto».

**Por qué:** son cosas distintas: non-fast-forward = punta remota adelantada; conflicto = solape al INTEGRAR.

**Cómo comprobarlo:** mensaje exacto («rejected / non-fast-forward» vs. «CONFLICT (content)»).

**Opciones:** push rechazado → fetch/pull; conflicto de merge → resolver.

**Riesgos:** medidas equivocadas (force en un push, por ejemplo).

**Solución:** leer el mensaje completo.

**Cómo se evita:** vocabulario de esta sección.

---

### Error 2: Creer que conflicto = pérdida

**Qué ocurrió:** pánico al ver marcadores (se cerró la terminal, se evita el ordenador).

**Por qué:** miedo a lo desconocido.

**Cómo comprobarlo:** `git status` (todo está ahí); `git diff` (los cambios son visibles).

**Opciones:** resolver con método (capítulo 04) o `merge --abort` (volver atrás limpio).

**Riesgos:** dejar la operación en pausa indefinidamente (bloquea).

**Solución:** saber que hay salida en AMBAS direcciones.

**Cómo se evita:** práctica deliberada (capítulo 02/05 de esta sección).

---

### Error 3: Editar y dar `add` sin eliminar TODOS los marcadores

**Qué ocurrió:** el conflicto «se resolvió» pero quedaron restos de `<<<<<<<` en otra zona del archivo.

**Por qué:** archivo largo, resolución a prisa.

**Cómo comprobarlo:** `git diff --check` (marca restos); `git grep -n "<<<<<<<"`.

**Opciones:** editar de nuevo + add.

**Riesgos:** commit con marcadores (rompe build).

**Solución:** `diff --check` como paso fijo.

**Cómo se evita:** revisión antes de cerrar.

---

### Error 4: Resolver con «dejar los dos textos»

**Qué ocurrió:** el archivo final contiene las DOS versiones seguidas (o duplicadas) porque «no sabía cuál».

**Por qué:** se evitó la decisión (humana).

**Cómo comprobarlo:** lectura; a veces compila y a veces no.

**Opciones:** decidir con contexto: git log del archivo, conversación, ticket.

**Riesgos:** lógica duplicada o rota.

**Solución:** el conflicto pedía una DECISIÓN, no una suma.

**Cómo se evita:** preguntar si no se sabe (la documentación de la rama ayuda).

---

### Error 5: Continuar (commit) con archivos sin resolver

**Qué ocurrió:** `git commit` de cierre falla («you have unmerged paths») o, peor, alguien hace add de archivos ignorados y cierra a medias.

**Por qué:** no revisar `status` antes de concluir.

**Cómo comprobarlo:** status (¿sigue «Unmerged paths»?).

**Opciones:** resolver TODOS y luego commit; o abortar.

**Riesgos:** cierres a medias.

**Solución:** status manda.

**Cómo se evita:** método del capítulo 04 (pasos numerados).

---

### Error 6: Pánico en rebase (conflictos «al revés»)

**Qué ocurrió:** en rebase, los marcadores parecen «invertidos» y la resolución sale mal.

**Por qué:** en rebase, HEAD = base nueva; tu commit es el otro lado (capítulo 06).

**Cómo comprobarlo:** mensaje del rebase; leer marcadores con cuidado.

**Opciones:** método de resolución adaptado (capítulo 06); abortar si es muy enrevesado.

**Riesgos:** confundir lados y «resolver» al revés.

**Solución:** estudiar el capítulo 06 antes de rebase con conflicto.

**Cómo se evita:** en ramas ajenas, preferir merge; rebase solo en propias.

---

## 6. Práctica guiada

### Objetivo

Provocar un conflicto real en un repo de práctica y observar su estado SIN resolver todavía.

### Paso 1: prepara ancestro

```bash
git switch main
echo "línea original" > conflicto.md
git add conflicto.md && git commit -m "Ancestro del conflicto"
```

### Paso 2: dos ramas que chocan

```bash
git switch -c lado-a
echo "versión de A" > conflicto.md
git add conflicto.md && git commit -m "A edita"

git switch main
git switch -c lado-b
echo "versión de B" > conflicto.md
git add conflicto.md && git commit -m "B edita"
```

### Paso 3: provoca

```bash
git switch main
git merge lado-a      # (si ff, fuerza con --no-ff o
                      #  haz commit en main antes)
git merge lado-b      # ← CONFLICTO
```

### Paso 4: observa el estado

```bash
git status                     # Unmerged paths
git diff                       # marcadores visibles
git ls-files -u                # stage 1/2/3 (¡míralos!)
cat conflicto.md               # (o Get-Content) marcadores
```

1. No resuelvas todavía. Quédate con la imagen.

### Paso 5: salir limpio (por ahora)

```bash
git merge --abort
git status                     # limpio, como antes
git log --graph --oneline -n 6
```

### Resultado Esperado

Haber visto un conflicto por dentro (estado, índice, marcadores) y haber salido de él con `--abort` sin miedo.

### Conclusión esperada

El conflicto es un estado con nombre, índice y salida: ni magia ni desastre. Ahora ya puedes mirarlo de frente.

---

## 7. Nivel profesional + resumen

### 7.1. Conflictos como trabajo normal

```text
   │
   ├── en equipos grandes: conflictos diarios; la
   │   diferencia es el MÉTODO (rápido, limpio, revisado)
   │
   ├── herramientas: mergetool de tres paneles, IDEs con
   │   resolución visual (usan los mismos marcadores)
   │
   └── política: nadie mergea «a ciegas»; diff --check
       + CI antes de concluir
```

### 7.2. Conflictos como señal

```text
Conflicto frecuente en un archivo = síntoma de:
   │
   ├── rama demasiado viva (acortar)
   ├── dos personas/dominios pisándose (repartir)
   ├── archivo «god file» (partir)
   └── formato/autogenerado mezclado (sacarlo)
   → el conflicto es información sobre el DISEÑO del
     equipo, no solo del merge
```

### 7.3. Resumen

En este capítulo aprendiste que:

* un conflicto es el resultado de dos cambios incompatibles respecto a un ancestro; Git para y pide decisión humana;
* el estado se manifiesta con «unmerged paths» (índice con tres entradas por archivo) y una operación en pausa (MERGE_HEAD o rebase);
* los marcadores `<<<<<<< / ======= / >>>>>>>` separan tu lado del otro (y en rebase, los lados están invertidos respecto a merge);
* NO es un error, ni pérdida, ni irrecuperable: se resuelve (add por archivo) o se aborta limpio;
* los errores típicos (confundir con push rechazado, pánico, marcadores residuales, «dejar los dos», cerrar a medias, invertir lados en rebase) se previenen con `status`, `diff --check` y método;
* a nivel profesional: método rápido y revisado, herramientas de tres paneles y leer el conflicto como diagnóstico de diseño.

La idea principal es:

> **Un conflicto es Git siendo honesto: «aquí no decido yo» — y la honestidad, con método, es infinitamente preferible a la adivinación.**

---

## Próximo paso

Sabes qué es un conflicto.

Ahora: por qué aparecen exactamente (y cómo evitarlos).

Continúa con:

[`02-por-que-aparecen.md`](02-por-que-aparecen.md)
