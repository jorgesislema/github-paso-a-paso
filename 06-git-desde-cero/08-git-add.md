# git add

## Introducción

`git status` te mostró los cambios. Ahora toca decidir: **`git add`** es el acto de elegir qué cambios pasan al área de preparación (staging area) para formar parte del próximo commit.

Este comando es donde Git demuestra su elegancia: puedes modificar quince archivos y commitear solo tres, agrupar cambios en bloques con sentido y componer tus instantáneas con precisión. El área de preparación es una idea que no existía en los sistemas de control de versiones previos, y entenderla es entender la mitad de Git.

En este capítulo aprenderás:

* qué es el área de preparación y por qué existe;
* la sintaxis de `git add` (archivo, carpeta, todo);
* cómo comprobar lo añadido con status y diff;
* cómo deshacer un add (llevar algo del staging de vuelta);
* lo que NO debes añadir (basura, secretos);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (staging selectivo, patch interactivo).

---

## Mapa conceptual de este capítulo

```text
git add
       │
       ├── 1. El área de preparación (staging)
   │        ├── Qué es
   │        ├── Por qué existe
   │        └── Flujo completo
   │
       ├── 2. La sintaxis de git add
   │        ├── Un archivo
   │        ├── Varias rutas
   │        ├── Carpetas
   │        └── Todo (git add .)
   │
       ├── 3. Comprobar: status y diff --staged
   │
       ├── 4. Deshacer un add (git restore --staged)
   │
       ├── 5. Qué NO añadir
   │
       ├── 6. Errores comunes con diagnóstico completo
   │
       ├── 7. Práctica guiada
   │
       ├── 8. Nivel profesional
   │        ├── Staging selectivo
   │        ├── add -p (interactivo)
   │        └── Orden add → commit en equipo
   │
       └── 9. Resumen y siguiente paso
```

---

## 1. El área de preparación (staging)

### 1.1. Qué es

El **área de preparación** (staging area, también llamada índice) es una zona intermedia donde Git acumula los cambios elegidos para el siguiente commit.

```text
Mapa de los tres lugares
──────────────────────────────────────────────
WORKING DIRECTORY     STAGING AREA        REPOSITORY
(tu carpeta)          (preparación)       (historial)
   │                      │                    │
 cambios en disco  ──add──►  elegidos  ──commit──►  instantánea
                              para el              guardada
                              próximo commit
```

### 1.2. Por qué existe

```text
Sin staging (sistemas previos):
   │
   └── commiteabas TODO lo que estaba cambiado
       (o nada): poco control

Con staging:
   │
   ├── separas «lo que cambió» de «lo que quiero guardar»
   ├── puedes hacer commits parciales y ordenados
   ├── puedes commitear solo lo que ya está revisado
   └── puedes agrupar cambios relacionados de distintos
       archivos
```

Ejemplo cotidiano:

```text
Hoy cambiaste:
   · README.md        (añadiste una sección)     → quiero commitear
   · notas.md         (borrador a medias)         → NO quiero aún
   · guia.md          (corregiste erratas)        → quiero commitear
   · temp.txt         (archivo de prueba)         → jamás

git add README.md guia.md
   →  el próximo commit llevará SOLO esos dos
```

### 1.3. Flujo completo con status

```text
Ciclo
──────────────────────────────────────────────
1. editar
2. git status        → ver "not staged"
3. git add (elegir)  → status muestra "to be committed"
4. git commit        → status vuelve a "nothing to commit"
5. repetir
```

---

## 2. La sintaxis de git add

### 2.1. Un archivo

```bash
git add notas.md
```

Añade solo ese archivo (respecto a la carpeta actual; las rutas son relativas como siempre).

### 2.2. Varias rutas

```bash
git add README.md docs/guia.md
```

Separa cada ruta con un espacio.

### 2.3. Carpetas

```bash
git add docs/
```

Añade recursivamente todo lo que haya cambiado dentro de la carpeta.

### 2.4. Todo lo que cambió

```bash
git add .
```

```text
Significado de "."
   │
   ├── añade todo lo modificado/nuevo/deleted
   │   en la carpeta actual y sus subcarpetas
   │
   ├── atajo común: `git add -A` (también cubre cambios
   │   en otras zonas del repo y borrados, según versión)
   │
   └── comodidad ALTA, precisión BAJA:
       revisa status DESPUÉS de añadir (punto 3)
```

### 2.5. Resumen de formas

```text
Forma                  Alcance
──────────────────────────────────────────────
git add archivo.md     ese archivo
git add carpeta/       todo lo de esa carpeta
git add .              todo desde aquí hacia abajo
git add -A             todo el repositorio (según versión)
git add -u             solo rastreados modificados/borrados
                       (no añade archivos nuevos)
```

---

## 3. Comprobar: status y diff --staged

### 3.1. status tras add

```text
git status
──────────────────────────────────────────────
Changes to be committed:
        new file:   README.md      ← ya preparado

Changes not staged for commit:
        modified:   notas.md       ← sigue fuera

(on branch main; nothing else)
```

La traducción: `README.md` entró al staging; `notas.md` no.

### 3.2. diff del staging

Para ver EXACTAMENTE qué llevará el próximo commit:

```bash
git diff --staged
```

```text
git diff                →  cambios EN TU CARPETA que NO están
                            en el staging (lo que queda por elegir)
git diff --staged       →  cambios YA elegidos (lo que se
                            commiteará)
```

Este par es la herramienta de verificación definitiva:

```text
Antes de commit:
   git status        →  lista
   git diff --staged →  contenido exacto del próximo commit
```

---

## 4. Deshacer un add

### 4.1. El comando

```bash
git restore --staged ruta/archivo
```

```text
Qué hace
   │
   ├── saca el archivo del área de preparación
   ├── sus cambios NO se pierden: siguen en tu carpeta
   │   (working directory)
   └── el archivo vuelve a aparecer como "not staged"
       (o untracked, según el caso)
```

### 4.2. Ejemplo

```bash
# añadí por error:
git add temp.txt

# lo saco del staging (sigue existiendo en disco):
git restore --staged temp.txt

# status: temp.txt vuelve a "untracked"
```

### 4.3. Advertencia: no confundir con restore completo

```text
restore --staged     →  saca del staging (cambios intactos) ✔
restore archivo      →  DESCARTA cambios en la carpeta
                         (vuelve al último commit)  ✗ ojo
```

(La sección 11 profundiza en restore; aquí basta la distinción del doble guion.)

---

## 5. Qué NO añadir

```text
Lista de comprobación antes de `git add`
──────────────────────────────────────────────
[ ] ¿Archivos temporales (temp, .tmp, pruebas)?
       → no añadir; mejor .gitignore
[ ] ¿Archivos generados (build, dist, cachés)?
       → no añadir (o el proyecto lo decide)
[ ] ¿Datos personales o secretos?
       → JAMÁS (.env real, claves, tokens)
[ ] ¿Basura del sistema (.DS_Store, Thumbs.db)?
       → no añadir; .gitignore
[ ] ¿Tamaños absurdos (imágenes/datos gigantes)?
       → revisar antes de cargar el historial
[ ] ¿Todos los cambios restantes son los deseados?
       → releer status tras el add
```

> **Nota:** `.gitignore` se estudia en esta misma sección (capítulos posteriores/temas de organización); aquí queda la idea: lo que no debe entrar, mejor ni añadirlo.

---

## 6. Errores comunes con diagnóstico completo

### Error 1: git add en la carpeta equivocada

**Qué ocurrió:** `git add notas.md` y el archivo «no se añade» (o se añade otro con igual nombre).

**Por qué:** terminal en otra carpeta; las rutas son relativas.

**Cómo comprobarlo:** `pwd`/`cd` y `git status` (mira qué lista).

**Opciones:** navegar a la carpeta correcta y repetir; o usar la ruta correcta.

**Riesgos:** añadir lo equivocado (casi siempre inofensivo, pero confuso).

**Solución:** status después de cada add.

**Cómo se evita:** abrir terminal desde la raíz del repo y usar rutas completas desde ahí.

---

### Error 2: Añadir todo con `git add .` sin revisar

**Qué ocurrió:** entró basura, temporales y hasta un secreto en el staging.

**Por qué:** atajo sin revisión.

**Cómo comprobarlo:** `git status` tras el add; `git diff --staged`.

**Opciones:**
* sacar los indeseados: `git restore --staged ruta` (repetir por cada uno);
* si aún no se commiteó: la situación es reversible con total facilidad.

**Riesgos:** si se commitea y sube: historial contaminado (y secretos expuestos: el problema serio).

**Solución:** sacar del staging antes de commit.

**Cómo se evita:** revisión pos-add como ritual; en proyectos con riesgo, añadir por ruta y no «todo».

---

### Error 3: Confundir add con commit

**Qué ocurrió:** se ejecutó `git add` y se creyó que «ya quedó guardado».

**Por qué:** niveles del flujo (staging ≠ historial).

**Cómo comprobarlo:** status dice «to be committed» (aún no commiteado); history no cambió.

**Opciones:** ejecutar `git commit` (próximo capítulo).

**Riesgos:** creer que hay historial cuando no lo hay.

**Solución:** add y commit son dos actos.

**Cómo se evita:** memorizar la cadena add → commit → push.

---

### Error 4: Ejecutar restore completo en vez de restore --staged

**Qué ocurrió:** se quería deshacer el add y se borraron los cambios del archivo.

**Por qué:** olvidar `--staged` (punto 4.3).

**Cómo comprobarlo:** el archivo perdió las ediciones (status: sin cambios).

**Opciones:**
* deshacer en el editor (si recuerdas el contenido);
* o en editores con historial local;
* Git no los tenía: no eran commit.

**Riesgos:** pérdida de trabajo (igual que «Discard» en Desktop).

**Solución:** símbolo: `--staged` = «solo del staging».

**Cómo se evita:** leer el comando completo antes de Enter (siempre).

---

### Error 5: Añadir archivos que NO cambian

**Qué ocurrió:** `git add archivo-inalterado` no hace nada (o lo esperaba y «falló»).

**Por qué:** add solo tiene efecto sobre diferencias reales.

**Cómo comprobarlo:** status no cambia.

**Opciones:** ninguna: es comportamiento correcto.

**Riesgos:** confusión, nada más.

**Solución:** entender que Git trabaja con diferencias.

**Cómo se evitar:** no hace falta (aprender el modelo).

---

### Error 6: ¿Y los borrados?

**Qué ocurrió:** borré un archivo y no sé cómo reflejarlo en el commit.

**Por qué:** duda sobre si un borrado necesita add.

**Cómo comprobarlo:** status lista `deleted: archivo` en «not staged».

**Opciones:**
* `git add archivo-borrado` (o `git rm`, que hace ambas cosas: ver más adelante);
* así el borrado entra al staging y al commit.

**Riesgos:** olvidarlo y commitear sin el borrado.

**Solución:** los borrados también se preparan con add.

**Cómo se evita:** tratar «cualquier cambio» (incluso deleted) igual ante add.

---

## 7. Práctica guiada

### Objetivo

Practicar staging selectivo: elegir qué entra y qué no, y verificarlo.

### Preparación

Repositorio de práctica en la terminal, con cambios preparados del capítulo anterior (o repítelos): `notas.md` modificado, `tareas.md` nuevo (o en el estado que quieras).

### Paso 1: añadir uno

```bash
git status                    # identifica los cambios
git add tareas.md             # solo este
git status                    # ¿en qué sección está ahora?
git diff --staged             # lee lo que se commiteará
```

### Paso 2: añadir otro por ruta

```bash
git add notas.md
git status                    # los dos preparados; nada pendiente
```

### Paso 3: simular error y deshacer

```bash
# crea un archivo que no quieras commitear:
# (en el explorador o con el editor) archivo-temporal.txt

git add archivo-temporal.txt
git status                    # entró: error detectado

git restore --staged archivo-temporal.txt
git status                    # volvió a untracked; cambios intactos
```

### Paso 4: carpeta completa

```bash
# crea o modifica algo dentro de docs/
git add docs/
git status                    # lo de docs preparado
```

### Paso 5: la verificación final

```bash
git diff --staged             # revisa línea a línea
git status                    # lista completa: ¿todo correcto?
```

No commitees todavía: este capítulo termina en el staging perfecto.

### Resultado esperado

Capacidad de elegir con precisión qué entra al commit y de verificarlo por dos vías (status y diff --staged).

### Conclusión esperada

`git add` convierte un lío de cambios en una propuesta concreta: esto es lo que voy a guardar. Revisar esa propuesta es la mitad de la disciplina del commit.

---

## 8. Nivel profesional

### 8.1. Staging selectivo

```text
Patrón profesional
──────────────────────────────────────────────
1. Trabajo sobre un tema
2. `git status` → ver todo lo que tocó
3. separar mentalmente: «de este tema» / «ruido»
4. add por rutas (nunca `. ` a ciegas en repos ajenos)
5. `git diff --staged` → revisión
6. commit
7. repetir para el siguiente bloque
```

### 8.2. add -p: parches interactivos

Para el máximo control, Git permite añadir «a trozos» (parche a parche):

```bash
git add -p
```

```text
Funcionamiento (idea)
   │
   ├── Git muestra un trozo de cambio (hunk)
   ├── tú respondes: ¿añadir este trozo? (s/n/…)
   └── resultado: partes de un MISMO archivo en commits
       distintos

Útil cuando un archivo mezcla dos temas y no puedes
(o no quieres) separarlo antes.
```

(En la práctica, a veces es más limpio separar los cambios en el editor; `-p` es la herramienta cuando eso no es posible.)

### 8.3. Orden en equipo

```text
Convención habitual
   │
   ├── add → diff --staged → commit (nunca saltos)
   ├── mensajes que describen EL COMMIT, no «lo que hay»
   ├── nada de add de credenciales jamás (y si ocurre
   │   antes de commit: sacarlo; después de push: revocar)
   └── en repos ajenos: add por rutas conocidas
```

---

## 9. Resumen

En este capítulo aprendiste que:

* el área de preparación (staging) es la zona intermedia donde se eligen los cambios del próximo commit;
* su existencia permite commits parciales, ordenados y revisados;
* `git add` acepta archivos, carpetas y el «todo» (`.` o `-A`), siendo lo selectivo la práctica recomendada;
* `git status` traduce el estado (staged vs. no staged) y `git diff --staged` muestra el contenido exacto del próximo commit;
* deshacer un add es `git restore --staged`: los cambios se quedan en tu carpeta, solo salen de la preparación;
* los borrados también se añaden; lo que no debe entrar (temporales, generados, secretos) no se añade;
* los errores típicos (carpeta equivocada, add a ciegas, confundir add con commit, restore sin --staged) se diagnostican con status y diff;
* a nivel profesional, el staging selectivo y `-p` son la base de commits limpios.

La idea principal es:

> **`git add` es una decisión, no un trámite: convierte «lo que cambió» en «lo que quiero recordar», y esa selección es lo que hace legible el historial.**

---

## Próximo paso

Ya tienes elegido el contenido del commit.

El siguiente paso es confirmarlo: `git commit`.

Continúa con:

[`09-git-commit.md`](09-git-commit.md)
