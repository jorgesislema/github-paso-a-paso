# git checkout

## Introducción

`git checkout` es el comodín histórico de Git: cambiaba de rama, creaba ramas, restauraba archivos y hasta sacaba un árbol entero de un commit. Por eso Git 2.23 lo dividió en `switch` + `restore` (capítulos 04 y anteriores): la intención de cada acción separada.

Pero checkout sigue vivo: en tutoriales, en scripts antiguos, en manos de quien lleva años con Git y en la sintaxis clásica `checkout -- archivo`. Leerlo y usarlo con criterio es parte de tu alfabetización; saber cuándo preferir switch/restore es parte de tu madurez.

En este capítulo aprenderás:

* los tres roles de checkout (rama, restauración, extracción);
* `checkout -- <archivo>` y sus equivalencias modernas;
* crear rama al pasar con `-b`;
* los flags peligrosos (`-f`) y sus consecuencias;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (convivencia de ambas familias).

---

## Mapa conceptual de este capítulo

```text
git checkout
       │
       ├── 1. Los tres roles
   │        ├── navegar ramas (como switch)
   │        ├── restaurar archivos (como restore)
   │        └── extraer árboles de un commit
   │
       ├── 2. checkout de rama
   │        ├── rama existente
   │        ├── -b (crear)
   │        └── commit/tag → detached
   │
       ├── 3. restaurar con checkout -- archivo
   │        ├── origen por defecto (índice)
   │        └── equivalencias modernas
   │
       ├── 4. Flags peligrosos: -f
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Los tres roles

```text
Lo que «checkout» hace depende de los ARGUMENTOS
──────────────────────────────────────────────────────────
git checkout rama          →  navegar (switch)
git checkout -b rama       →  crear y navegar
git checkout commit        →  navegar a hash (detached)
git checkout -- archivo    →  restaurar archivo (restore)
git checkout <ruta>        →  (variantes históricas de
                              restauración/extracción)

   │
   └── misma orden, tres intenciones: la ambigüedad
       que motivó el reparto moderno
```

---

## 2. Checkout de rama

### 2.1. Navegar

```bash
git checkout feature
```

1. Idéntico a `git switch feature`: mueve HEAD y tu carpeta (con las mismas reglas de carpeta sucia).

### 2.2. Crear con `-b`

```bash
git checkout -b feature-login
git checkout -b feature-login main
```

1. Equivale a `git switch -c …`: crear + entrar.

### 2.3. A un commit → detached

```bash
git checkout a3f9c21
git checkout v1.0
```

```text
   │
   ├── HEAD apunta al hash/tag directo (detached)
   │   (capítulo 07 de la sección 07)
   │
   └── aviso de Git: si commiteas ahí, guarda con
       git switch -c antes de salir
```

---

## 3. Restaurar con `checkout -- archivo`

### 3.1. La forma clásica

```bash
git checkout -- notas.md
```

```text
Qué hace:
   │
   ├── vuelve notas.md a su estado en el ÍNDICE
   │   (staging; que a su vez suele ser HEAD si no
   │   habías hecho add)
   │
   └── DESCARTA tus cambios sin preparar en ese archivo
       (¡es el equivalente a restore SIN --staged!)
```

### 3.2. Equivalencias modernas

```text
Intención                        Clásico            Moderno
─────────────────────────────────────────────────────────────
volver archivo a HEAD/índice     checkout -- f      restore f
(prepara de nuevo)                                        (por
                                                          defecto
                                                          al
                                                          índice)

quitarlo del staging              reset HEAD f       restore
                                                      --staged f

todo el directorio               checkout .         restore .
```

### 3.3. La confusión famosa (volver a visitarla)

```bash
git restore notas.md          # pisa la CARPETA: SE PIERDE
git restore --staged notas.md # solo des-prepara: no
                              # pierde trabajo
git checkout -- notas.md      # MISMO peligro que restore
                              # sin --staged: pisa carpeta
```

```text
Regla (ya conocida, ahora con dos nombres):
   │
   ├── "--" o sin flag     →  afecta a tu ARCHIVO (ojo)
   └── --staged            →  afecta al índice (seguro
                              para el trabajo en carpeta)
```

---

## 4. Flags peligrosos: `-f`

```bash
git checkout -f feature
git checkout -f -- notas.md
```

```text
   │
   ├── -f fuerza: sobrescribe cambios locales que
   │   normalmente bloquearían (rama) o descarta
   │   cambios (archivo)
   │
   ├── equivalente al -f de switch
   │
   └── misma etiqueta que reset --hard / clean: no es
       rutina, es cirugía
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «pathspec did not match» / archivo inexistente

**Qué ocurrió:** `checkout -- archivo` con ruta mal escrita o archivo no rastreado.

**Por qué:** la ruta no coincide con nada rastreado.

**Cómo comprobarlo:** `git ls-files | findstr nombre` (o `git status`).

**Opciones:** corregir ruta; si es nuevo sin rastrear, no hay versión previa que restaurar.

**Riesgos:** pensar que Git falló sin motivo.

**Solución:** solo se restauran archivos rastreados.

**Cómo se evita:** copiar rutas de `git status`.

---

### Error 2: «Please commit your changes or stash» al cambiar de rama

**Qué ocurrió:** checkout (y switch) se negaron.

**Por qué:** cambios sucios en conflicto con el destino (capítulo 03).

**Cómo comprobarlo:** `git status` / `diff`.

**Opciones:** commit / stash / restore-descartar / `-f` (último recurso).

**Riesgos:** `-f` pierde trabajo.

**Solución:** limpiar el camino antes de cambiar.

**Cómo se evita:** ritual status.

---

### Error 3: Restaurar y perder trabajo (la clásica)

**Qué ocurrió:** ejecutaste `checkout -- archivo` (o `restore archivo`) para «deshacer el deshacer» y tu edición de horas voló.

**Por qué:** esas órdenes vuelven al estado guardado (índice/HEAD): lo no guardado se pisa.

**Cómo comprobarlo:** el archivo «se ve» como antes; reflog no tiene tu texto (no estaba en ningún objeto).

**Opciones:**
* si había add antes: a veces el blob está en el índice/objects (recuperable con plumbing: `git fsck --lost-found` / `ls-files -s`);
* editor con historial local: a menudo la vía más rápida.

**Riesgos:** pérdida real.

**Solución:** ante duda: copia el archivo o commit/stash antes de restaurar.

**Cómo se evita:** entender el origen de cada orden (punto 3.2).

---

### Error 4: Detached por querer «mirar» con checkout

**Qué ocurrió:** `checkout v1.0` para ver y luego no sabías volver (y quizá commiteaste).

**Por qué:** checkout a tag/hash = detached.

**Cómo comprobarlo:** aviso; `cat .git/HEAD`.

**Opciones:** `git switch -c rescate` (si hay commits); `git switch main` (si no).

**Riesgos:** trabajo colgando de hash.

**Solución:** regla de la sección 07 anterior.

**Cómo se evita:** `git show`/`git log` para mirar en vez de checkout (no mueve nada).

---

### Error 5: Doble filosofía en el equipo (mix caótico)

**Qué ocurrió:** la mitad del equipo escribe «checkout --» y la otra «restore»; los novicios no saben si eso pisa o no.

**Por qué:** convivencia sin convención.

**Cómo comprobarlo:** revisar scripts y hábitos.

**Opciones:** elegir la familia moderna (switch+restore) como estándar del equipo; documentar en CONTRIBUTING; el clásico sigue funcionando.

**Riesgos:** errores de predicción (lo peor con comandos destructivos).

**Solución:** un vocabulario por proyecto.

**Cómo se evita:** entrenar con la terminología que el equipo usa.

---

### Error 6: `checkout <ruta>` (sin `--`) y resultados raros

**Qué ocurrió:** `git checkout notas.md` (sin `--`): Git puede interpretarlo como rama, y da error o hace algo inesperado en versiones/configuraciones varias.

**Por qué:** sin `--`, el argumento se interpreta primero como destino de navegación.

**Cómo comprobarlo:** mensaje; `git status`.

**Opciones:** usar siempre `--` para rutas en órdenes que lo admiten (o la forma moderna `restore`).

**Riesgos:** confusión.

**Solución:** `--` como separador fijo.

**Cómo se evita:** hábito de sintaxis explícita.

---

## 6. Práctica guiada

### Objetivo

Practicar los tres roles de checkout y contrastarlos con switch/restore.

### Paso 1: navegar y crear

```bash
git checkout -b ck-uno      # crear+entrar
git checkout main           # volver
git checkout -b ck-dos
git checkout main
git branch -d ck-dos ck-uno # limpiar (según estado)
```

### Paso 2: a tag/hash

```bash
git checkout HEAD~2         # detached (lee el aviso)
git checkout -b temporal    # salvo (o directamente:)
# git checkout main         # si no había trabajo
git branch -d temporal      # si la creaste sin uso
```

### Paso 3: restaurar

```bash
# edita notas.md sin add
git checkout -- notas.md    # ¡vuelve al estado previo!
git diff                    # vacío: el cambio era solo
                            # de carpeta
```

```bash
# edita + add, y edita de nuevo
git checkout -- notas.md    # vuelve al estado del
                            # STAGING (tu add), no a HEAD
git diff --staged           # el preparado sigue
```

1. Comprueba la jerarquía: índice manda en `checkout --`.

### Paso 4: equivalencias lado a lado

```bash
# mismo efecto con la familia moderna:
git restore notas.md
git restore --staged notas.md
git switch main
```

1. Traduce mentalmente cada orden del ejercicio anterior.

### Paso 5: -f con un archivo de prueba

```bash
echo basura >> notas.md
git checkout -f -- notas.md    # descarta sin piedad
git status                     # limpio respecto a eso
```

1. Solo en archivo de prueba: la fuerza se siente.

### Resultado esperado

Capacidad de elegir entre las dos familias sin sorpresas y de saber exactamente QUÉ estado restaura cada orden (índice vs. carpeta).

### Conclusión esperada

Checkout es la orden vieja que hace tres trabajos; hoy ya puedes darle a cada trabajo su comando moderno —y usar el viejo con los ojos abiertos.

---

## 7. Nivel profesional + resumen

### 7.1. Convivencia de familias

```text
Contexto                       Qué usar
──────────────────────────────────────────────────────
equipo nuevo (2026)            switch + restore
legado / scripts existentes    checkout (sin romper)
lectura de tutoriales          traducir a switch/restore
personal                       el que no te sorprenda
                               (predecibilidad > moda)
```

### 7.2. checkout en flujos avanzados

```text
   │
   ├── git checkout <commit> -- <ruta>: extraer una
   │   versión CONCRETA de un archivo a la carpeta
   │   (clásico y válido; restore --source lo moderniza)
   │
   ├── git checkout -b rama origen/rama: patrón de
   │   publicación antiguo (hoy: switch -c --track)
   │
   └── herramientas de terceros aún invocan checkout:
       saber leerlo evita sustos en automatizaciones
```

### 7.3. Resumen

En este capítulo aprendiste que:

* checkout navega ramas (`switch`), crea con `-b` (`switch -c`), va a commits (detached) y restaura archivos con `-- <ruta>` (`restore`);
* `checkout -- archivo` vuelve el archivo al estado del ÍNDICE: descarta cambios sin preparar (peligro idéntico a `restore` sin flag);
* `-f` fuerza por encima de todo: mismas consecuencias que en switch;
* los errores típicos (pathspec, suciedad bloqueante, pérdida al restaurar, detached accidental, `--` olvidado) se prevén con status y con la traducción a la familia moderna;
* a nivel profesional: convivencia ordenada de familias según el equipo, y el patrón clásico de extraer versiones de archivos con `restore --source` / `checkout <commit> -- ruta`.

La idea principal es:

> **`checkout` es Git con una sola palabra para tres ideas; tú ya sabes cuál es cuál —y prefieres la familia que no deja dudas.**

---

## Próximo paso

Ya sabes moverte y restaurar.

Ahora toca devolver dos líneas de trabajo a una sola: fusionar ramas.

Continúa con:

[`06-fusionar-ramas.md`](06-fusionar-ramas.md)
