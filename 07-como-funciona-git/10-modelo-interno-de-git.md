# Modelo interno de Git

## Introducción

Este es el capítulo que cierra la sección: la **visión completa** del modelo interno de Git. Aquí ensamblamos todo lo visto —directorio de trabajo, índice, repositorio, remoto, commits, hash, HEAD, grafo y objetos— en un solo diagrama y en un solo flujo: qué ocurre por dentro cuando ejecutas cada orden.

No necesitas saber esto para usar Git a diario; pero cuando lo entiendes, los comandos dejan de ser fórmulas mágicas, los errores se diagnostican por estructura y las secciones avanzadas (restaurar, rebase, conflictos, plumbing) se vuelven comprensibles de un vistazo.

En este capítulo aprenderás:

* el mapa completo de componentes y su relación;
* el recorrido de una orden típica (add, commit, push) por dentro;
* las dos familias de comandos: plumbing (fontanería) vs. porcelain (azulejos);
* cómo todos los conceptos de la sección encajan en el modelo;
* errores y confusiones finales con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Modelo interno de Git
       │
       ├── 1. El mapa completo
   │        ├── tres zonas + remoto
   │        ├── referencias (refs) y HEAD
   │        └── base de datos de objetos
   │
       ├── 2. Qué pasa cuando ejecutas…
   │        ├── git add
   │        ├── git commit
   │        ├── git push / fetch
   │        └── git switch/checkout
   │
       ├── 3. Plumbing vs. porcelain
   │
       ├── 4. Encaje de todos los conceptos
   │
       ├── 5. Errores y confusiones finales
   │
       ├── 6. Práctica guiada
   │
       ├── 7. Nivel profesional
   │        └── seguridad, integridad, rendimiento
   │
       └── 8. Resumen y cierre de sección
```

---

## 1. El mapa completo

### 1.1. Diagrama maestro

```text
                    ┌─────────────────────────────┐
                    │      REPOSITORIO REMOTO     │
                    │   (GitHub / servidor)       │
                    └────────────▲────────────────┘
                          push / fetch / pull
                                 │
┌────────────────────────────────┴───────────────────────────────┐
│ TU MÁQUINA                                                     │
│                                                                │
│  ┌──────────────────┐    add     ┌──────────────────────────┐  │
│  │ DIRECTORIO DE    │ ─────────► │ ÍNDICE / STAGING         │  │
│  │ TRABAJO          │            │ (.git/index)             │  │
│  │ (archivos que    │ ◄───────── │  selección del próximo   │  │
│  │  editas)         │  restore   │  commit                  │  │
│  └──────────────────┘            └────────────┬─────────────┘  │
│                                               │ commit         │
│                                               ▼                │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ BASE DE DATOS DE OBJETOS  (.git/objects)                │  │
│  │   blobs  ·  trees  ·  commits  ·  tags      (inmutables) │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                               ▲                │
│  ┌───────────────────────────────┐             │ apuntan       │
│  │ REFERENCIAS (.git/refs)       │ ────────────┘               │
│  │   ramas:  refs/heads/main  ──────► commit                   │
│  │   tags:   refs/tags/v1.0   ──────► tag                      │
│  │   remotas: refs/remotes/origin/* ─► commit (copia de red)  │  │
│  │ HEAD: ref: refs/heads/main  (o hash directo)               │  │
│  └───────────────────────────────┘                             │
└────────────────────────────────────────────────────────────────┘
```

### 1.2. Las cuatro capas

```text
Capa            Dónde              Quién la toca
──────────────────────────────────────────────────────────
Archivos        carpeta visible    tú (editor)
Selección       .git/index         git add / restore --staged
Historial       .git/objects       git commit (crea), todo
                                     lo demás (lee)
Nombres         .git/refs + HEAD   branch, switch, push,
                                     pull (mueven)
```

### 1.3. Lo que NO es Git

```text
   │
   ├── no es «un sincronizador de carpetas»: eso es
   │   solo fetch/push
   │
   ├── no es «un backup»: es una base de datos con
   │   historial (y solo respalda lo que empujas)
   │
   └── no es «el servidor de GitHub»: GitHub es un
       cliente-servidor ALREDEDOR de este modelo
```

---

## 2. Qué pasa cuando ejecutas…

### 2.1. `git add notas.md`

```text
1. lee el archivo del directorio de trabajo
2. calcula su blob (hash de contenido) → lo escribe
   en objects (si no existía)
3. actualiza ENTRADAS del índice:
   ruta → (modo, hash del blob)
4. status ahora: «staged»

No toca: historial, ramas, remoto.
```

### 2.2. `git commit -m "…"`

```text
1. construye el árbol (tree) a partir del índice
2. si el árbol ya existe → reutiliza objetos (barato)
3. crea el objeto commit:
      tree  → árbol nuevo
      parent→ HEAD actual (rama actual)
      author/committer → tu config
      mensaje → el tuyo
4. escribe el commit en objects
5. actualiza la REFERENCIA de la rama actual al nuevo
   hash (HEAD, al apuntar a la rama, «sigue»)
6. índice queda igual (se vacía de «cambios staged»:
   ya están en HEAD)

No toca: remoto (hasta push).
```

### 2.3. `git push origin main`

```text
1. mira qué commits tiene origin/main (refs/remotes)
   y cuáles te faltan a ti (comparación de hashes)
2. envía los objetos que al remoto le faltan
3. el remoto actualiza su rama main (si las reglas
   lo permiten)
4. actualiza refs/remotes/origin/main localmente

   │
   └── nada de «subir archivos»: se transfieren
       OBJETOS identificados por hash
```

### 2.4. `git fetch origin`

```text
1. conversa con el remoto: ¿qué puntas tienes?
2. descarga objetos nuevos
3. actualiza refs/remotes/origin/* (¡NO tu rama!)
4. tú decides: merge, rebase o mirar (log origin/main)

pull = fetch + integrar en tu rama actual.
```

### 2.5. `git switch feature`

```text
1. localiza el commit al que apunta feature
2. reescribe el directorio de trabajo para igualarlo
   (reescribiendo lo no rastreado según reglas)
3. apunta HEAD a refs/heads/feature
4. el índice se alinea con el nuevo commit de origen

No crea objetos nuevos: solo reorganiza referencias
y archivos.
```

---

## 3. Plumbing vs. porcelain

```text
Porcelain (lo que usas):        Plumbing (fontanería):
git status, add, commit,        write-tree, commit-tree,
log, diff, switch, merge…       update-ref, hash-object,
                                cat-file, rev-parse…
   │                                    │
   └── UX amable, mensajes              └── piezas precisas,
       y validaciones                        scripts, core de Git

   │
   ├── todo porcelain se EJECUTA sobre plumbing
   ├── ya has tocado plumbing sin saberlo:
   │   cat-file, ls-files -s, rev-parse (en docs futuras)
   └── en la sección 29 verás más plumbing con criterio
```

---

## 4. Encaje de todos los conceptos

```text
Concepto (capítulo)         Papel en el modelo
──────────────────────────────────────────────────────────
Working directory (01)      zona de edición
Staging/index (02)          selección (refs a blobs)
Repositorio local (03)      objects + refs en tu disco
Repositorio remoto (04)     igual, en servidor; destino
Commit (05)                 nodo del grafo
Hash (06)                   identidad de todo objeto
HEAD (07)                   cursor del presente
Grafo (08)                  estructura de padres
Objetos (09)                blobs/trees/commits/tags
Modelo (10)                 EL SISTEMA que los une

Secciones futuras que ya «encajan»:
   11 deshacer = mover refs / restaurar desde objects
   08 ramas = refs/heads
   09 remoto = refs/remotes + transferencia de objects
   10 conflictos = unión de árboles con guiones de pausa
   17 rebase = recrear commits (nodos nuevos) sobre
               otra base
```

---

## 5. Errores y confusiones finales

### Error 1: Modelos mentales a medias

**Qué ocurrió:** cada comando «sorprende» porque se aprendió aislado.

**Por qué:** falta el mapa.

**Cómo comprobarlo:** responde mentalmente: ¿qué zona toca este comando?

**Opciones:** repasar los diagramas (1.1 y sección 07) hasta que status sea traducible.

**Riesgos:** dependencia de recetas.

**Solución:** el mapa como brújula permanente.

**Cómo se evita:** repasar este capítulo de vez en cuando (es la sección de síntesis).

---

### Error 2: Esperar que switch/checkout «cree» lo mismo que commit

**Qué ocurrió:** se confundió crear historia (commit) con navegar historia (switch).

**Por qué:** ambos «mueven» cosas: unos objetos, otros referencias/archivos.

**Cómo comprobarlo:** `count-objects` antes/después de cada uno.

**Opciones:** memoria por capa (tabla 1.2).

**Riesgos:** confusión al investigar qué cambió.

**Solución:** «¿creó objetos?» es la pregunta clave.

**Cómo se evita:** practicar las dos órdenes con count-objects (práctica).

---

### Error 3: Creer que fetch/pull «modifican mis archivos»

**Qué ocurrió:** miedo a hacer pull porque «rompe mi trabajo».

**Por qué:** depende: fetch NO; pull SÍ puede tocar (integra en tu rama).

**Cómo comprobarlo:** fetch → status idéntico; pull → posible cambio en carpeta/grafo.

**Opciones:** preferir fetch + revisar + integrar tú (merge/rebase con calma) cuando haya duda.

**Riesgos:** sorpresas en medio de trabajo sucio.

**Solución:** regla de seguridad: pull con carpeta limpia.

**Cómo se evita:** `git status` antes de cada sync (raíz 26).

---

### Error 4: Pensar que el remoto tiene «todas mis zonas»

**Qué ocurrió:** alguien intentó recuperar su STAGING desde GitHub.

**Por qué:** el remoto recibe objetos y refs: no tu índice ni tu carpeta.

**Cómo comprobarlo:** conceptual: push solo sube objetos/refs.

**Opciones:** staging/carpeta solo existen localmente; se reconstruyen.

**Riesgos:** falsa expectativa de respaldo total.

**Solución:** respaldo = historial empujado (y aun así, sin staging).

**Cómo se evita:** tabla 1.2 otra vez.

---

### Error 5: Tocar refs/objects a mano «por eficiencia»

**Qué ocurrió:** ediciones manuales en `.git/refs` o borrar packs.

**Por qué:** se pensó que eran archivos normales.

**Cómo comprobarlo:** fsck, comandos raros.

**Opciones:** restaurar desde clon/backup.

**Riesgos:** corrupción.

**Solución:** solo comandos de alto nivel (o plumbing consciente).

**Cómo se evita:** regla de oro: `.git` solo se toca con Git.

---

### Error 6: Concluir «Git es complicado»

**Qué ocurrió:** saturación al ver el modelo completo.

**Por qué:** verlo todo de golpe sin usarlo todo.

**Cómo comprobarlo:** ¿usas a diario status/add/commit/log/diff/switch/push? Eso es el 95% del día.

**Opciones:** el modelo es MAPA, no check-list: guárdalo, úsalo cuando algo raro pase.

**Riesgos:** abandono.

**Solución:** seguir el recorrido (las secciones siguientes lo usan todo el rato).

**Cómo se evita:** aprender por capas (que es como está diseñado esto).

---

## 6. Práctica guiada

### Objetivo

Ver el modelo completo en acción con herramientas de bajo nivel.

### Paso 1: línea base

```bash
git count-objects -vH      # objetos y tamaño
git status                 # zona actual
git ls-files -s            # índice
git rev-parse HEAD         # hash completo del presente
git rev-parse --abbrev-ref HEAD   # rama actual
```

### Paso 2: observa add creando objetos

```bash
# edita un archivo
git count-objects -vH      # antes
git add <archivo>
git count-objects -vH      # después (¿blob nuevo?)
git ls-files -s            # el índice apunta al blob
```

### Paso 3: observa commit creando y moviendo

```bash
git commit -m "Modelo: paso 3"
git count-objects -vH      # commit (+ tree si hacía falta)
git cat-file -p HEAD       # su tree y parent
git rev-parse main         # la rama apunta al nuevo hash
```

### Paso 4: el remoto como refs

```bash
git remote -v
git fetch origin
git branch -a              # refs/remotes/origin/* visibles
git rev-parse origin/main  # su puntal local
git status                 # compara tu rama con ella
```

### Paso 5: switch sin crear nada

```bash
git count-objects -vH
git switch -c tmp-modelo
git count-objects -vH      # ¿igual? (solo refs/archivos)
git switch main
git branch -d tmp-modelo
```

### Paso 6: plumbing suave

```bash
git rev-list --count HEAD          # profundidad
git rev-list HEAD | Select-Object -First 5   # hashes
git cat-file -p HEAD^{tree}        # árbol raíz
```

### Resultado esperado

Capacidad de predecir, antes de ejecutar, qué tocará cada orden (objetos, refs, índice o archivos) y de comprobarlo con las herramientas.

### Conclusión esperada

El modelo interno deja de ser teoría: es la hipótesis con la que abres cada comando, y `count-objects`/`rev-parse`/`cat-file` son tus pruebas.

---

## 7. Nivel profesional

### 7.1. Seguridad e integridad de extremo a extremo

```text
   │
   ├── cada transferencia verifica por hash
   │   (un bit corrompido → objeto rechazado)
   │
   ├── firmas en commits/tags añaden AUTORÍA verificable
   │
   ├── ramas protegidas + CI = política sobre refs
   │
   └── reflog = registro local de movimientos de refs
       (forense básico)
```

### 7.2. Rendimiento: por qué Git es rápido

```text
   │
   ├── operaciones locales = 100% disco local (sin red)
   │
   ├── estructuras pequeñas: refs son archivos de texto;
   │   objects comprimidos y empaquetados
   │
   ├── commits baratos: solo tree + commit (contenido
   │   reutilizado)
   │
   └── fetch eficiente: solo objetos que faltan
       (comparación por puntas/objetos conocidos)
```

### 7.3. Dónde mirar cuando algo se rompe

```text
Orden de diagnóstico (nivel avanzado)
──────────────────────────────────────────────
1. git status / git branch -vv     ¿dónde estoy?
2. git fsck --no-progress          ¿integridad?
3. git reflog                      ¿qué pasó con HEAD?
4. cat-file -p HEAD                ¿qué contiene?
5. remote -v + fetch               ¿está sincronizado?
6. docs oficiales / equipo         ¿política específica?
```

---

## 8. Resumen y cierre de la sección

En este capítulo aprendiste que:

* el modelo completo son tres zonas (carpeta, índice, objetos) + referencias (ramas, tags, remotas, HEAD) + un remoto al otro lado de la red;
* cada orden tiene un recorrido preciso: `add` crea blobs y actualiza el índice; `commit` crea tree+commit y mueve la rama; `push/fetch` transfieren objetos y actualizan refs; `switch` reescribe archivos y mueve HEAD;
* `porcelain` (comandos de usuario) se construye sobre `plumbing` (piezas atómicas); ya has usado plumbing con `cat-file`, `ls-files -s` y `rev-parse`;
* los conceptos de la sección son las capas del mismo mapa: trabajar en Git es moverse por esas capas con intención;
* las confusiones finales (modelos a medias, crear vs. navegar, pull vs. fetch, respaldos, tocar a mano) se resuelven con la tabla de capas y el hábito de comprobar con count-objects/rev-parse;
* a nivel profesional: integridad verificable de punta a punta, rendimiento por diseño local y un orden de diagnóstico fiable cuando algo raro pase.

La idea principal es:

> **Git es una base de datos distribuida de objetos inmutables con referencias mutables; tus comandos son operaciones sobre esas dos familias —nada más, nada menos—.**

---

## Cómo seguir

Has terminado «Cómo funciona Git»: ya no usas Git a ciegas.

La sección siguiente formaliza lo que venías usando implícitamente: **las ramas** —cómo crearlas, moverlas, combinarlas y no perderse en ellas.

Continúa con el índice de esta sección (si quieres repasar) o sigue directo a la siguiente:

[`README.md`](README.md) · [`../08-git-ramas/`](../08-git-ramas/)
