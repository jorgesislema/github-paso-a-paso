# Staging Area (área de preparación)

## Introducción

En el capítulo anterior viste el primer «lugar» de Git: el directorio de trabajo, donde editas. Ahora toca el segundo, el más peculiar y más malentendido: el **staging area** (área de preparación, también llamada *index*).

El staging es la mesada donde compones tu próximo commit: seleccionas exactamente qué cambios van, los afinas y solo entonces los confirmas. Sin él, cada commit sería un tiro al blanco: «todo lo que cambié, ahora». Con él, cada commit es una decisión consciente.

Por qué existe: porque la historia de un proyecto se lee como una narración, y las narraciones se construyen con pasos ordenados, no con vertidos de cambios. El staging es donde separas «esto es un tema» de «esto es otro».

En este capítulo aprenderás:

* qué es el staging y dónde vive;
* cómo `git add` escribe en él y qué Versiones guardas;
* la relación carpeta → staging → historial con congelaciones;
* qué pasa con cambios parciales y archivos borrados;
* por qué el staging existe (el design rationale);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Staging Area (área de preparación / index)
       │
       ├── 1. Qué es y dónde vive
   │        ├── la mesada intermedia
   │        ├── dentro de .git (índice)
   │        └── ¿por qué no saltar directo a commit?
   │
       ├── 2. git add escribe aquí
   │        ├── lo que add captura
   │        ├── adiciones, cambios y borrados
   │        └── cambios parciales (add -p)
   │
       ├── 3. El mapa de tres lugares (refuerzo)
   │        ├── carpeta → staging → historial
   │        ├── cada paso se congela
   │        └── status como brújula
   │
       ├── 4. Estado del staging
   │        ├── qué ve status
   │        ├── quitar del staging (restore --staged)
   │        └── staging vacío
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       ├── 7. Nivel profesional
   │        ├── commits quirúrgicos
   │        └── staging y flujos de revisión
   │
       └── 8. Resumen y siguiente paso
```

---

## 1. Qué es y dónde vive

### 1.1. La mesada intermedia

```text
Tres lugares, tres roles
──────────────────────────────────────────────
[ Directorio de trabajo ]  → editas aquí (tu día a día)
         │
         │ git add
         ▼
[ Staging Area / index ]   → COMpones el próximo commit
         │
         │ git commit
         ▼
[ Repositorio (historial) ]→ queda guardado para siempre
```

### 1.2. Dónde vive físicamente

```text
   │
   ├── es un archivo dentro de .git (el índice):
   │   .git/index
   │
   ├── guarda, por cada archivo rastreado, la versión
   │   EXACTA (hash) que entrará en el próximo commit
   │
   └── no es «otra carpeta visible»: es una lista de
       selección que Git mantiene internamente
```

### 1.3. ¿Por qué no saltar directo a commit?

```text
Sin staging (hipotético):
   │
   ├── commit = todo lo que esté cambiado a la vez
   ├── un tema se mezcla con otro
   └── la historia queda ilegible y poco fiable

Con staging:
   │
   ├── eliges por archivo, por línea (add -p)
   ├── agrupas cambios relacionados
   └── cada commit = una idea completa y revisable
```

> **La idea central:** el staging convierte el trabajo en narración. Es la diferencia entre «borrador» y «entrega».

---

## 2. `git add` escribe aquí

### 2.1. Lo que add captura

```bash
git add notas.md
```

```text
Qué hace:
   │
   ├── copia la versión ACTUAL del archivo del directorio
   │   al índice
   │
   ├── a partir de ese momento, el «antes» del commit ya
   │   está definido (aunque sigas editando: ver 2.3)
   │
   └── status lo muestra: "staged", listo para commit
```

### 2.2. Adiciones, cambios y borrados

```text
Situación en tu carpeta          add que lo prepara
──────────────────────────────────────────────────────
archivo nuevo (untracked)        git add archivo      → new file
archivo modificado               git add archivo      → modified
archivo borrado                  git add archivo      → deleted
todos los anteriores             git add .            → cuidado:
                                                          revisar
```

El borrado también necesita `add`: Git registrará la eliminación en el próximo commit (lo viste en la sección 05 y se afianza aquí).

### 2.3. Cambios parciales: `git add -p`

```bash
git add -p archivo
```

```text
Git parte tus cambios en «parches» (bloques) y pregunta:
   │
   ├── [y]  preparar este bloque
   ├── [n]  saltarlo
   ├── [s]  dividirlo más
   └── [q]  parar (lo demás queda como estaba)

Resultado: puedes preparar SOLO la mitad de un archivo,
y commitear la otra mitad después.
```

```text
Por qué importa:
   │
   ├── el archivo tocó dos temas a la vez
   └── con -p separas sin prisa ni urgencia
```

### 2.4. Add no afecta al historial

```text
   │
   ├── add NO es commit (nada queda guardado aún)
   ├── si cierras Git, el índice persiste (está en .git)
   └── pero sin commit, «preparado» no es «guardado»
```

---

## 3. El mapa de tres lugares (refuerzo)

### 3.1. Cada paso se congela

```text
Versión 1 (antes)     Versión 2 (después)     Dónde vive la decisión
────────────────────────────────────────────────────────────────────
en carpeta            en staging               qué preparas (add)
en staging            en historial             qué guardas (commit)
en historial (A)      en historial (B)         qué cuenta la historia
                                               (diff/log)
```

### 3.2. Ejemplo narrativo

```text
Lunes por la mañana:
   │
   ├── editas notas.md y guia.md
   ├── separas: notas.md va al commit A (tema 1)
   │       → git add notas.md; git commit -m "Tema 1"
   │
   └── guia.md aún en carpeta (o en staging) para el
       commit B (tema 2)

La historia queda legible: dos pasos, dos temas.
```

### 3.3. status como brújula (otra vez)

```text
git status
   │
   ├── "Changes to be committed"   →  en el staging
   ├── "Changes not staged"        →  en carpeta, sin preparar
   └── "Untracked files"           →  ni en carpeta rastreada
                                       ni en staging
```

---

## 4. Estado del staging

### 4.1. Quitar del staging

```bash
git restore --staged notas.md
```

```text
   │
   ├── el cambio NO se pierde: vuelve a estar «en carpeta»
   │   (sin preparar)
   │
   ├── deshace el add, no el trabajo
   │
   └── equivalente antiguo: git reset HEAD notas.md
       (reset se estudia a fondo en la sección 11)
```

### 4.2. Staging vacío

```text
   │
   ├── si no has hecho add, el índice apunta a HEAD
   │   (último commit): «preparado = nada nuevo»
   │
   └── commit con staging vacío: Git se niega o exige
       opciones (--allow-empty): no registres vacíos sin
       motivo
```

### 4.3. Ver el staging sin el resto del ruido

```bash
git diff --staged      # qué hay AHÍ dentro (vs. historial)
git diff               # qué hay en carpeta sin preparar
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: Commit vacío cuando esperabas cambios

**Qué ocurrió:** `git commit` y Git dice que no hay nada que commitear (o hace un commit vacío con la opción).

**Por qué posibles:**
* cambiaste pero no hiciste `add` (los cambios no están en el staging);
* hiciste `restore --staged` por accidente;
* los cambios ya estaban commiteados (confusión de estados).

**Cómo comprobarlo:** `git status` y `git diff --staged`.

**Opciones:** `git add` lo que corresponda y reintentar.

**Riesgos:** `--allow-empty` sin necesidad → commits fantasma en el historial.

**Solución:** status primero: donde dice «Changes to be committed» es lo que entrará.

**Cómo se evita:** ritual add → diff --staged → commit.

---

### Error 2: add de TODO con `git add .` sin revisar

**Qué ocurrió:** entraron al commit archivos que no debían (temporales, notas sueltas, basura).

**Por qué:** `.` agarra todo el árbol bajo ti; staging no avisa.

**Cómo comprobarlo:** `git status --staged` (o `git diff --staged --stat`) antes de commitear.

**Opciones:**
* `git restore --staged los-que-no-deben` y commitear el resto;
* si ya se commiteó y no se publicó: rehacer (sección 11) o siguiente commit correcto si conviene.

**Riesgos:** historial con archivos que «no eran de ese tema»; posibles secretos (¡revisar siempre!).

**Solución:** restaurar del staging y ser quirúrgico.

**Cómo se evita:** `add <archivo>` por archivo en proyectos con basura potencial, o `.gitignore` desde el minuto cero.

---

### Error 3: «Guardé el archivo pero no aparece en commit»

**Qué ocurrió:** editaste, commiteaste… y el archivo no cambió.

**Por qué:** editaste DESPUÉS del commit, o guardaste en otra copia, o el archivo no está rastreado.

**Cómo comprobarlo:** `git status` (¿untracked? ¿staged? ¿sin preparar?).

**Opciones:** `git add` y nuevo commit.

**Riesgos:** creer que Git perdió el trabajo (no lo pierde: no lo había visto).

**Solución:** leer status en sus tres bloques.

**Cómo se evita:** status antes de cerrar el commit.

---

### Error 4: Creer que add = guardado

**Qué ocurrió:** se cerró el trabajo confiando en que «ya lo había añadido».

**Por qué:** add no es commit: prepara, no guarda en historia.

**Cómo comprobarlo:** `git log` no crece hasta que hay commit.

**Opciones:** commitear.

**Riesgos:** pérdida de contexto (aunque el índice persiste, no es historial ni respaldo).

**Solución:** distinguir preparar vs. guardar.

**Cómo se evita:** mnemonic: *add = pones en la bandeja; commit = cierras la caja.*

---

### Error 5: Restaurar un archivo y perder el staging

**Qué ocurrió:** ejecutaste `git restore archivo` (sin `--staged`) esperando «despreparar» y el archivo volvió a la versión del último commit.

**Por qué:** `restore` sin `--staged` ACTUALIZA LA CARPETA desde el índice/historial: el trabajo sin preparar se perdía si no estaba en el índice.

**Cómo comprobarlo:** el contenido del archivo cambió «hacia atrás».

**Opciones:** deshacer es delicado (sección 11); con suerte el cambio aún existe en otro sitio.

**Riesgos:** pérdida de trabajo reciente.

**Solución:** regla: `--staged` afecta al índice; sin `--staged`, afecta a la carpeta.

**Cómo se evita:** dudar → `-h`; nunca ejecutar restore a ciegas.

---

### Error 6: Ver «preparado» y pensar que ya está en la rama

**Qué ocurrió:** alguien revisó el repo y «su» archivo solo estaba en staging: otra persona no lo ve.

**Por qué:** confusión entre lo local (índice es LOCAL) y lo compartido.

**Cómo comprobarlo:** `git status` muestra «staged» pero `git log` no; en el remoto no aparece.

**Opciones:** commit + push para compartir.

**Riesgos:** «lo tengo hecho y nadie lo ve».

**Solución:** solo el push comparte (sección 09).

**Cómo se evita:** recordar: carpeta = tuyo; staging = tuyo; historial local = tuyo; remoto = del equipo.

---

## 6. Práctica guiada

### Objetivo

Componer dos commits separados por temas usando el staging con precisión.

### Paso 1: dos cambios, un archivo cada uno

1. En `notas.md` escribe «apuntes del tema 1».
2. En `guia.md` escribe «instrucciones del tema 2».
3. `git status` → ambos sin preparar.

### Paso 2: preparar solo uno

```bash
git add notas.md
git status
```

1. `notas.md` en «Changes to be committed»; `guia.md` en «not staged».
2. `git diff --staged --stat` → confirma solo notas.md.

### Paso 3: commit del tema 1

```bash
git commit -m "Añade apuntes del tema 1"
git log --oneline -n 2
```

### Paso 4: el cambio restante

```bash
git status          # guia.md aún sin preparar
git add guia.md
git diff --staged
git commit -m "Añade instrucciones del tema 2"
```

### Paso 5: añadir y quitar del staging

```bash
# edita notas.md otra vez
git add notas.md
git diff --staged      # ahí está
git restore --staged notas.md
git status             # vuelve a "not staged"; el
                       # trabajo NO se perdió
git diff               # el cambio sigue en carpeta
```

### Paso 6: cambios parciales (opcional, recomendado)

```bash
# en notas.md haz dos cambios separados por líneas
git add -p notas.md
# responde n al primero, y al segundo: preguntas
git status             # ¿qué quedó preparado?
```

### Resultado esperado

Dos commits ordenados por tema; dominio de `add` / `restore --staged`; comprensión de que el staging selecciona sin borrar trabajo.

### Conclusión esperada

El staging es tu mesa de trabajo: añades, quitas y afinas hasta que la selección es exacta. El commit solo «imprime» lo que decidiste allí.

---

## 7. Nivel profesional

### 7.1. Commits quirúrgicos

```text
Flujo profesional típico
──────────────────────────────────────────────
1. Trabajas (carpeta cambia todo el rato)
2. git add -p  →  seleccionas lo del tema actual
3. git diff --staged  →  revisión final
4. commit (mensaje del tema)
5. repites para el siguiente tema

Resultado: rama con commits pequeños, revisables
y con mensaje fiel al contenido.
```

### 7.2. Staging y revisiones

```text
   │
   ├── un PR se revisa commit a commit: un staging
   │   mal usado contamina toda la revisión
   │
   ├── «commit atómico» = una decisión de staging
   │   bien tomada
   │
   └── en conflictos (sección 10) el staging es donde
       marcas las resoluciones: add = «esto ya está bien»
```

### 7.3. Internamente (adelanto)

```text
   │
   ├── .git/index es un binario con metadatos + hashes
   │   de los blob seleccionados
   │
   ├── git write-tree (nivel interno) materializa el
   │   árbol del staging cuando commiteas
   │   (sección 07/10, objetos)
   │
   └── por eso add es rápido: actualiza una lista,
       no copia historiales
```

---

## 8. Resumen

En este capítulo aprendiste que:

* el staging area (o índice) es el lugar intermedio donde compones el próximo commit; vive en `.git/index`;
* `git add` copia versiones al índice (adición, modificación o borrado) y `git add -p` permite preparar solo bloques;
* la secuencia mental es carpeta (editas) → staging (seleccionas) → historial (guardas), con `git status` y `git diff --staged` como brújulas;
* `git restore --staged` desprepara sin perder trabajo; `restore` sin la opción afecta a la carpeta (¡cuidado!);
* el staging es LOCAL: no se comparte hasta commit + push;
* los errores típicos (commit vacío, add ciego, confundir add con guardar) se prevén con el ritual add → diff --staged → commit;
* a nivel profesional, la disciplina del staging produce commits atómicos, revisiones legibles y flujos de PR sanos.

La idea principal es:

> **El staging es la mesa donde conviertes trabajo en decisión: Git guardará exactamente lo que selecciones allí, ni más ni menos.**

---

## Próximo paso

Ya entiendes el segundo lugar de Git.

El siguiente es donde se archiva todo: el repositorio local.

Continúa con:

[`03-repositorio-local.md`](03-repositorio-local.md)
