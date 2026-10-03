# Repositorio local

## Introducción

El tercer lugar del mapa es el **repositorio local**: el historial completo del proyecto que Git guarda en tu máquina, dentro de la carpeta oculta `.git`. Aquí viven los commits, las ramas y todos los objetos que hacen posible recuperar cualquier versión.

Cuando trabajas sin conexión —en el tren, en un avión, en una cafetería sin wifi— sigues teniendo todo Git a tu disposición: no porque el servicio esté disponible, sino porque el repositorio está completo en tu disco. Esa es la esencia de lo *distribuido*: cada clon es un repositorio de verdad.

En este capítulo aprenderás:

* qué es un repositorio local y qué contiene `.git`;
* la distinción entre directorio de trabajo y repositorio;
* clonar: cómo nace un repositorio local desde uno remoto;
* la relación local ↔ remoto en un esquema;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (respaldos, tamaño, salud del repositorio).

---

## Mapa conceptual de este capítulo

```text
Repositorio local
       │
       ├── 1. Qué es
   │        ├── historial completo en tu disco
   │        ├── la carpeta .git
   │        └── directorio de trabajo vs. repositorio
   │
       ├── 2. Cómo nace un repositorio local
   │        ├── git init (nuevo)
   │        └── git clone (desde uno remoto)
   │
       ├── 3. El esquema local ↔ remoto
   │        ├── un remoto, muchos locales
   │        ├── fetch/pull (bajar) y push (subir)
   │        └── local autónomo
   │
       ├── 4. Qué hay dentro de .git (visión general)
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       ├── 7. Nivel profesional
   │        ├── respaldo y salud
   │        └── repositorios grandes
   │
       └── 8. Resumen y siguiente paso
```

---

## 1. Qué es

### 1.1. Historial completo en tu disco

```text
Un repositorio local contiene
──────────────────────────────────────────────
· todos los commits (desde el primero)
· todas las ramas y sus puntas
· todas las versiones de todos los archivos rastreados
· la configuración local (config)
· el índice (staging) y la cabeza actual (HEAD)
```

No es una «copia parcial» de la nube: es **el** repositorio, con lo que tu clon conoce de él.

### 1.2. La carpeta `.git`

```text
proyecto/
   ├── notas.md          ← directorio de trabajo (lo ves)
   ├── guia.md            ← (lo que editas)
   └── .git/              ← repositorio (oculta; no la toques)
         ├── config
         ├── HEAD
         ├── index
         ├── objects/     ← la base de datos de contenido
         └── refs/        ← punteros a ramas y tags
```

```text
Regla de oro
   │
   ├── Git = .git + tus reglas de uso
   ├── sin .git, la carpeta es «cualquier carpeta»
   └── borrar o dañar .git = perder el historial local
       (por eso, respaldo en el nivel profesional)
```

### 1.3. Directorio de trabajo vs. repositorio

```text
Concepto                Contiene                 Editas
────────────────────────────────────────────────────────
Directorio de trabajo   archivos actuales        sí
Repositorio (.git)      historial y objetos      nunca a mano
```

Tus ediciones ocurren en el directorio; Git archiva en el repositorio. `status`, `add` y `commit` son los puentes entre ambos.

---

## 2. Cómo nace un repositorio local

### 2.1. Desde cero: `git init`

```bash
cd mi-proyecto
git init
```

```text
   │
   ├── crea .git con estructura vacía
   ├── rama inicial (main o master según versión/config)
   └── aún NO hay commits: repositorio «en blanco»
       (estudiamos init en la sección 06)
```

### 2.2. Desde uno existente: `git clone`

```bash
git clone https://github.com/usuario/proyecto.git
```

```text
   │
   ├── crea proyecto/ con .git completo
   ├── copia TODO el historial disponible
   ├── configura el remoto «origin»
   └── deja HEAD en la rama por defecto, lista para
       trabajar
```

```text
init vs. clone
   │
   ├── init  →  yo empiezo el repositorio (era mío o nuevo)
   └── clone →  continúo uno que ya existe (del equipo/red)
```

### 2.3. ¿Y mi repo viejo sin git?

```text
   │
   ├── cd carpeta-vieja && git init
   ├── primer commit = punto cero del historial
   └── desde ahí, el flujo normal (add/commit/push)
```

---

## 3. El esquema local ↔ remoto

### 3.1. Un remoto, muchos locales

```text
                GitHub / servidor
              [ Repositorio remoto ]
              ╱        │         ╲
        clone/push  fetch/pull  clone/push
           ╱          │           ╲
   [ repo local ] [ repo local ] [ repo local ]
    (tú)           (compañero)    (compañera)
```

```text
Cada caja es un repositorio COMPLETO.
El remoto es de referencia y de intercambio,
no un «padre» al que todo cuelga.
```

### 3.2. Bajar y subir

```text
Operación     Dirección   Comando típico     Resultado
──────────────────────────────────────────────────────────
bajar         remoto→local git fetch / pull   tu local
                                              se actualiza
subir         local→remoto git push           el remoto
                                              refleja tu rama
traer nuevo   (ambos)      git clone          un local nace
```

### 3.3. Local autónomo

```text
   │
   ├── sin conexión: status, add, commit, log, diff,
   │   ramas, merge, rebase… todo funciona
   │
   ├── lo único que necesita red: push, pull, fetch,
   │   clone y GitHub web
   │
   └── por eso el historial local es tu «espina dorsal»
```

---

## 4. Qué hay dentro de `.git` (visión general)

```text
.git/ (vistazo; detalle en los capítulos 06–10)
──────────────────────────────────────────────
HEAD        →  a qué commit (rama) apuntas ahora
config      →  tu configuración local
index       →  el staging area
objects/    →  la base de datos: blobs, árboles, commits
refs/       →  punteros: ramas y etiquetas
logs/       →  registro de movimientos de HEAD (reflog)
```

> **No entres a editar nada a mano.** Este recorrido es para entender qué guardas y por qué el `.git` es tan valioso (y por qué conviene saber que existe al respaldar).

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «No es un repositorio git»

**Qué ocurrió:** ejecutaste un comando Git en una carpeta sin `.git`.

**Por qué posibles:**
* estás fuera del proyecto (subiste/bajaste de carpeta);
* el proyecto nunca se inicializó/clonó;
* copiaste el contenido SIN `.git` (arrastre manual de archivos).

**Cómo comprobarlo:** `ls -a` / `dir /a` buscando `.git`; `git status` confirma el error.

**Opciones:**
* cd al proyecto correcto;
* `git init` si es un proyecto nuevo/tuyo;
* `git clone` de nuevo si debía venir de un remoto;
* si copiaste a mano: clona bien y trae tus cambios (ver Error 2).

**Riesgos:** crear un repo «fantasma» en la carpeta equivocada.

**Solución:** ubicarte con status.

**Cómo se evita:** abrir la terminal en la raíz del proyecto; comprobar con status al empezar.

---

### Error 2: Copiar carpetas «a mano» y perder el historial

**Qué ocurrió:** alguien descargó ZIP desde GitHub (o arrastró archivos) y luego «hizo git init»: historial cero, sin conexión con el remoto.

**Por qué:** la carpeta no traía `.git`; init creó uno nuevo vacío.

**Cómo comprobarlo:** `git log` vacío; `git remote -v` sin nada (o después mal configurado).

**Opciones:**
* clonar correctamente y copiar/cerrar sus cambios encima;
* si el historial importa: clonar, copiar archivos sobre la copia clonada y commitear encima.

**Riesgos:** bifurcar el proyecto sin querer; «dos verdades».

**Solución:** el flujo correcto es clone (o init solo si es lo tuyo).

**Cómo se evita:** descargar el código con clone/SSH-HTTPS, nunca con «Code → ZIP» salvo consulta rápida.

---

### Error 3: `.git` borrada o dañada

**Qué ocurrió:** limpiaste «archivos ocultos» o moviste solo los archivos visibles.

**Por qué:** `.git` está oculta; algunos «limpiadores» la tocan.

**Cómo comprobarlo:** status falla o log está vacío en un proyecto que debía tener historia.

**Opciones:**
* si existe copia (otro clon, backup): recupera `.git` o vuelve a clonar;
* si no: los archivos actuales siguen, el historial no (punto de partida nuevo con init).

**Riesgos:** pérdida de historial local (el remoto puede salvarlo si había push).

**Solución:** restaurar desde remoto/backup.

**Cómo se evita:** respaldar `.git` (o confiar en que el remoto está al día: empuja a menudo).

---

### Error 4: Trabajar en la carpeta equivocada (varios clones)

**Qué ocurrió:** cambios «fantasma» que no aparecen donde se espera; dos copias del mismo proyecto.

**Por qué:** clon repetido (ej. `proyecto`, `proyecto-copia`).

**Cómo comprobarlo:** `git remote -v` en cada uno apunta al mismo sitio; fechas de commit distintas.

**Opciones:** elegir UN clon de trabajo; pasar los cambios (copiar y commitear o aplicar patch) al definitivo; borrar el duplicado cuando no aporte.

**Riesgos:** desorden, confusiones de push, conflictos evitables.

**Solución:** un clon principal por proyecto.

**Cómo se evita:** nomenclatura clara y carpetas organizadas.

---

### Error 5: Creer que el remoto está «dentro» del local

**Qué ocurrió:** se borra un remoto y se teme perder todo.

**Por qué:** confusión de capas.

**Cómo comprobarlo:** `git remote -v` solo lista configuración; el historial local no vive en el remoto.

**Opciones:** reañadir remoto (`git remote add`) si se borró.

**Riesgos:** pánico innecesario.

**Solución:** recordar el esquema del punto 3.1.

**Cómo se evita:** mapear: local = historia; remoto = destino de intercambio.

---

### Error 6: Tamaño enorme / «Git va lento»

**Qué ocurrió:** el clon tarda muchísimo o status es lento.

**Por qué posibles:** archivos grandes versionados, basura acumulada, antivirus revisando `.git`, disco lento.

**Cómo comprobarlo:** `git count-objects -vH` (tamaño de objetos); historial con blobs gigantes.

**Opciones:**
* evitar versionar artefactos (gitignore desde el principio);
* en casos ya heredados: políticas de limpieza (LFS, reescritura con herramientas de equipo — no a solas);
* revisar exclusiones de antivirus para el proyecto.

**Riesgos:** reescribir historia en solitario rompe a los demás (sección 11/25).

**Solución:** prevención + diagnóstico.

**Cómo se evita:** solo fuente en el repo, no compilados ni datos.

---

## 6. Práctica guiada

### Objetivo

Ver y comprobar la existencia del repositorio local en tus proyectos.

### Paso 1: mira `.git`

```bash
cd <tu-proyecto>
ls -a          # Windows: dir /a
```

1. Localiza `.git`.
2. No entres a modificar nada; solo constátala.

### Paso 2: comprueba la salud

```bash
git status
git log --oneline -n 5
git remote -v
```

1. status → rama y estado;
2. log → historial presente (si está vacío: repo nuevo);
3. remote → con qué remoto habla (o ninguno).

### Paso 3: repositorio local sin red

1. Desconéctate (o trabaja en avión/pausa de wifi).
2. Ejecuta `git status`, `git log`, `git diff`, `git add` + commit de prueba.
3. Todo debe funcionar: el historial es local.

### Paso 4: init vs. clone

```bash
# en una carpeta de prueba cualquiera:
mkdir demo-init && cd demo-init && git init
git status          # repo vacío, rama inicial

# y un clon de verdad (tu repo de GitHub):
git clone <url-de-tu-repo> demo-clone
cd demo-clone && git remote -v   # origin ya configurado
```

1. Compara: init (blanco) vs. clone (con historia y remoto).

### Paso 5: segura del mundo

1. Lista tres respuestas a «¿dónde está mi historia?»:
   * en `.git` de tu clon;
   * en el remoto (si haces push);
   * en los clon(es) de tus compañeros.

### Resultado esperado

Mapeo mental completo: dónde vive el historial, cómo se crea un repositorio local y por qué tu trabajo continúa sin conexión.

### Conclusión esperada

El repositorio local es tu copia soberana del proyecto. Comprendes ahora por qué Git es distribuido y por qué `.git` es el archivo más preciado de tu carpeta.

---

## 7. Nivel profesional

### 7.1. Respaldo y salud

```text
Rutina de confianza
──────────────────────────────────────────────
· push frecuente a tu remoto (backup remoto de hecho)
· clone de respaldo en otra máquina para cambios
  críticos
· nunca editar .git a mano
· git fsck (comprobación de integridad) si algo raro:
  reporta objetos huérfanos o dañados
```

### 7.2. Repositorios grandes

```text
   │
   ├── separar fuentes de artefactos (gitignore)
   │
   ├── Git LFS para binarios inevitables
   │
   ├── submódulos/monorepos: solo con criterio del equipo
   │
   └── historial sucio ya heredado: plan de equipo
       (reescritura coordinada, congelación y avisos;
        herramientas como filter-repo) — NUNCA en solitario
```

### 7.3. Varios repos, un flujo

```text
   │
   ├── cada proyecto: un clon principal
   ├── ramas por tarea (sección 08)
   └── el remoto central sirve de integración y respaldo;
       tus locales producen y experimentan sin miedo
```

---

## 8. Resumen

En este capítulo aprendiste que:

* el repositorio local es el historial completo del proyecto en tu disco, dentro de la carpeta oculta `.git`;
* directorio de trabajo (lo que editas) y repositorio (lo que Git guarda) son cosas distintas; `add`/`commit` son los puentes;
* un repositorio local nace con `git init` (proyecto nuevo) o `git clone` (copia completa con remoto configurado);
* el esquema distribuido: un remoto de intercambio y muchos locales autónomos; sin conexión solo pierdes push/pull/clone;
* `.git` guarda HEAD, config, índice, objects y refs (los verás en detalle en los próximos capítulos);
* los errores típicos (carpeta sin git, ZIP en vez de clon, `.git` dañada, clones duplicados, repos gigantes) se diagnostican con status/log/remote y se evitan con flujo correcto y prevención;
* a nivel profesional: empuja a menudo, respalda `.git`, y trata la historia como infraestructura compartida.

La idea principal es:

> **Tu clon es el proyecto completo: `.git` es la caja fuerte donde Git guarda cada decisión del pasado, y por eso trabajas sin permisos de nadie y sin conexión.**

---

## Próximo paso

Ya conoces el repositorio local.

El siguiente paso es su contraparte: el repositorio remoto y cómo se relaciona con el tuyo.

Continúa con:

[`04-repositorio-remoto.md`](04-repositorio-remoto.md)
