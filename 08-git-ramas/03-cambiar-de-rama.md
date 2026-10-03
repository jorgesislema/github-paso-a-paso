# Cambiar de rama

## Introducción

Cambiar de rama (switch/checkout) es el gesto de «mover tu carpeta y tu HEAD» a otra línea del historial: Git reescribe los archivos que difieren y apunta HEAD al nuevo nombre. Con él alternas entre la función que desarrollas, main que te sirve de base y las ramas de tus compañeras.

El concepto parece simple —y lo es— pero tiene dos reglas que previenen el 90% de los sustos: **cambiar con trabajo sucio puede fallar o arrastrar cambios**, y **los commits existen donde se hicieron**. Este capítulo instala esas reglas.

En este capítulo aprenderás:

* qué hace exactamente un cambio de rama (archivos + HEAD + índice);
* la regla de la carpeta sucia y qué pasa con cambios no commiteados;
* cambiar con trabajo «arrastrable» vs. trabajo perdido;
* `git switch` en profundidad (continúa al siguiente capítulo);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Cambiar de rama
       │
       ├── 1. Qué hace por dentro
   │        ├── archivos que difieren se reescriben
   │        ├── HEAD → nueva rama
   │        └── índice se alinea con el destino
   │
       ├── 2. La regla de la carpeta sucia
   │        ├── cambios compatibles (arrastra)
   │        ├── cambios en conflicto (Git se niega)
   │        └── no commiteado = no tiene rama
   │
       ├── 3. Formas de cambiar (vista general)
   │        ├── switch (moderno)
   │        ├── checkout (clásico)
   │        └── restore/otras alternativas
   │
       ├── 4. Errores comunes con diagnóstico completo
   │
       ├── 5. Práctica guiada
   │
       └── 6. Nivel profesional + resumen
```

---

## 1. Qué hace por dentro

### 1.1. Los tres pasos

```bash
git switch otra-rama
```

```text
1. DIFERENCIAS: calcula qué archivos difieren entre
   la rama actual y la destino
2. CARPETA: reescribe esos archivos (los de la nueva
   versión; elimina/crea los que haga falta)
3. REFERENCIAS: HEAD apunta a otra-rama; el índice se
   pone al día con el commit destino

No crea historial: solo navega.
```

### 1.2. Lo que NO cambia

```text
   │
   ├── no se borra trabajo ya commiteado (sigue en su
   │   rama)
   │
   ├── no se toca el remoto
   │
   └── los archivos IDÉNTICOS en ambas ramas ni se
       tocan (velocidad)
```

### 1.3. Regreso idéntico

```bash
git switch main        # vuelves: tu carpeta recupera
                       # el estado de main
```

```text
   │
   ├── lo commiteado en feature sigue allí (en su rama)
   │
   └── lo NO commiteado es el problema de siempre:
       mira punto 2
```

---

## 2. La regla de la carpeta sucia

### 2.1. Los tres desenlaces

```text
Situación en tu carpeta          Al cambiar de rama
──────────────────────────────────────────────────────────
sin cambios (limpia)             cambias sin más
cambios en archivos QUE NO       Git los ARRASTRA a la
afectan al destino               nueva rama (siguen como
                                 «sin preparar» allí)
cambios en archivos que SÍ       Git se NIEGA: «Your
difieren entre ramas             local changes would be
                                 overwritten»
```

### 2.2. Qué NO arriesgas

```text
   │
   ├── Git casi nunca borra trabajo sin avisar: si
   │   arrastra o se niega, tú decides
   │
   ├── el riesgo real es HUMANO: descartar/pisar sin
   │   leer (git restore / checkout -- archivo)
   │
   └── y otro: cambiarte «a medias» creyendo que tu
       cambio ya estaba en una rama (no lo está)
```

### 2.3. La regla de oro

```text
Antes de cambiar de rama:
   │
   ├── status limpio → cambia tranquila
   ├── trabajo que quieres conservar → commitea o
   │   (git stash, sección 20) y luego cambia
   └── duda → status, decide, actúa
```

### 2.4. Commits vs. cambios sueltos

```text
   │
   ├── tus COMMITS viven en la rama donde los hiciste:
   │   cambiar de rama NO los mueve ni los borra
   │
   ├── tus cambios SIN commitear viven en la CARPETA:
   │   la carpeta «viaja» contigo (arrastrados)
   │
   └── por eso: dos personas en dos ramas comparten
       proyecto, no su trabajo en curso
```

---

## 3. Formas de cambiar (vista general)

```bash
git switch otra            # moderno: solo ramas
git checkout otra          # clásico: ramas + restaurar
git checkout -- archivo    # clásico: restaurar archivo
git restore archivo        # moderno: restaurar archivo
git switch -               # a la rama anterior (-)
```

```text
Reparto moderno:
   │
   ├── switch  →  mover HEAD entre ramas (+ -c crear)
   ├── restore →  restaurar archivos/carpetas (+ --staged)
   └── checkout → sigue existiendo (compatibilidad y
                  usos mixtos); los dos mundos conviven
                  en la práctica

(Detalles de switch: capítulo 04; de checkout: 05.)
```

---

## 4. Errores comunes con diagnóstico completo

### Error 1: «local changes would be overwritten»

**Qué ocurrió:** Git se negó a cambiar de rama.

**Por qué:** tienes cambios sin preparar en archivos que son DISTINTOS entre la rama actual y la de destino.

**Cómo comprobarlo:** `git status` (¿cuáles?); `git diff` (¿qué llevas?).

**Opciones:**
* commitear (o preparar+commitear) en la rama actual;
* `git stash` para guardarlo «en un cajón» y volver luego;
* `git restore <archivo>` si el cambio NO te importa (pierde trabajo: seguro de que sí).

**Riesgos:** descartar a la ligera = perder horas.

**Solución:** decisión consciente: guardar o tirar, nunca «a ver qué pasa».

**Cómo se evita:** status antes de switch (hábito raíz).

---

### Error 2: Cambiar de rama y «perder» el trabajo no commiteado

**Qué ocurrió:** cambiaste (Git lo permitió arrastrando), luego cambiaste otra vez… y el cambio ya no aparece.

**Por qué posibles:**
* sigue en la rama donde lo dejaste arrastrado (busca con status allí);
* lo pisaste con restore/checkout -- sin querer.

**Cómo comprobarlo:** `git status` en cada rama; `git diff`; reflog si fue restore.

**Opciones:** buscar en todas las ramas («¿dónde está mi cambio?» con status); si se pisó: herramientas de recuperación (sección 11; si era staged, a veces en índice).

**Riesgos:** pánico.

**Solución:** commitear antes de danzar entre ramas.

**Cómo se evita:** la regla 2.3.

---

### Error 3: «No deja cambiar porque no sé qué nombre tiene»

**Qué ocurrió:** `git switch` con nombre inventado → «invalid reference».

**Por qué:** la rama no existe (o es remota sin local).

**Cómo comprobarlo:** `git branch -a`.

**Opciones:**
* crearla (capítulo 02);
* si es remota: `git switch nombre` en Git moderno la crea con seguimiento, o `switch -c nombre --track origin/nombre`.

**Riesgos:** confusión.

**Solución:** mapa de nombres.

**Cómo se evita:** `branch -vv` de vez en cuando.

---

### Error 4: Cambiar y creer que main «se actualizó» con tu trabajo

**Qué ocurrió:** terminaste en feature, cambiaste a main y «¿dónde está mi trabajo?».

**Por qué:** el trabajo está commiteado en feature (correcto), no en main.

**Cómo comprobarlo:** `git log feature --oneline`; `git log main..feature`.

**Opciones:** integrar (merge/PR, capítulo 06-07); eso es el flujo.

**Riesgos:** duplicar trabajo creyendo que «se perdió».

**Solución:** entender que cada rama tiene su punta.

**Cómo se evita:** grafo con `--decorate` (sección 07 anterior).

---

### Error 5: Cambiar a detached sin querer

**Qué ocurrió:** `git switch <hash>` o checkout de tag → «detached HEAD».

**Por qué:** cambiaste a un COMMIT, no a una rama.

**Cómo comprobarlo:** aviso de Git; `cat .git/HEAD`.

**Opciones:** `git switch -c <nombre>` si hay trabajo; o volver a una rama.

**Riesgos:** commits huérfanos (si commiteas).

**Solución:** siempre nombres de rama en switch.

**Cómo se evita:** no teclear hashes para «probar».

---

### Error 6: Expectativa: «el switch actualiza mis cambios al remoto»

**Qué ocurrió:** creyeron que al cambiar de rama su push/PR se hacía solo.

**Por qué:** switch es 100% local.

**Cómo comprobarlo:** GitHub sin cambios; `git status` (¿adelante/atrás de origin?).

**Opciones:** push cuando corresponda.

**Riesgos:** trabajo invisible para el equipo.

**Solución:** separar navegación local de sincronización.

**Cómo se evita:** esquema local/remoto (sección 04/09).

---

## 5. Práctica guiada

### Objetivo

Cambiar de rama con los tres escenarios de suciedad y ver qué pasa en cada uno.

### Paso 1: cambio limpio

```bash
git status                 # limpia
git switch -c prueba-cambio
# algún commit pequeño
git switch main
git switch -c otra-prueba
git switch main
```

1. Todo fluido: sin cambios sueltos, sin sorpresas.

### Paso 2: cambio compatible (arrastra)

```bash
git switch main
# edita un archivo que es IGUAL en main y en la otra rama
git status                 # sin preparar
git switch -c rama-b
git status                 # el cambio te LLEGA (sigue sin
                           # preparar)
```

1. Comprueba con `git diff`: tu texto sigue ahí.

### Paso 3: cambio en conflicto (se niega)

```bash
git switch main
# edita main.md (existe distinto en las dos ramas)
git switch rama-b           # ¿error «would be overwritten»?
git status                  # revisa qué impide el cambio
```

Decide:
* conservar: `git add main.md; git commit -m "…"` (queda en main);
* tirar: `git restore main.md` (solo si lo pierdes a propósito).

### Paso 4: trabajo en ambas (el truco del regreso)

```bash
git switch main
# edita y COMMItea en main
git switch rama-b
# tu commit de main NO está aquí (correcto)
git log main --oneline -n 2   # allí vive
git switch main              # vuelve: todo como antes
```

### Paso 5: a la rama anterior

```bash
git switch -                # alterna con la anterior
git switch -                # y de vuelta
```

### Resultado esperado

Capacidad de predecir si Git te dejará cambiar, y de saber en qué estado quedará tu trabajo tras cambiar.

### Conclusión esperada

Cambiar de rama es seguro cuando tu carpeta está limpia o tu trabajo está commiteado; el peligro solo existe en la zona gris de los cambios sin decidir.

---

## 6. Nivel profesional + resumen

### 6.1. Flujo limpio de equipo

```text
Rutina recomendada
──────────────────────────────────────────────
· status → commit o stash → switch
· cambios a medias: WIP commits locales (se pueden
  reordenar/amendar antes de publicar)
· nunca «arrastrar» trabajo sin saberlo: si lo haces
  (Git avisa), revisa status al llegar
· en scripts/CI: commitea siempre (stash en CI es
  antipatrón)
```

### 6.2. Stash como alternativa profesional

```text
   │
   ├── git stash: guarda cambios sucios en una pila y
   │   limpia la carpeta (sección 20)
   │
   ├── ideal: cambio a medio hacer + urgencia en otra
   │   rama
   │
   └── regla: stash NO es respaldo; sácalo pronto
       (olvidarlo es olvidar trabajo)
```

### 6.3. Resumen

En este capítulo aprendiste que:

* cambiar de rama reescribe los archivos que difieren, mueve HEAD y alinea el índice; no crea historial ni toca el remoto;
* los cambios sin commitear viven en la CARPETA y viajan contigo solo si no generan conflicto; si lo generan, Git se niega;
* los commiteos viven en la rama donde se hicieron: cambiar no los mueve;
* formas: `switch` (moderno, solo ramas) y `checkout` (clásico, mixto); `switch -` alterna;
* los errores típicos (would be overwritten, trabajo «perdido», nombre inexistente, detached, esperar sync) se diagnostican con `status`/`diff`/`branch -a`;
* a nivel profesional: carpeta limpia antes de moverse, WIP commits o stash, y distinción nítida entre navegar y sincronizar.

La idea principal es:

> **Moverte entre ramas mueve tu vista del proyecto, no tu trabajo: lo commiteado queda donde estaba, y lo sucio solo viaja si tú lo dejas.**

---

## Próximo paso

Ya entiendes el cambio de rama en abstracto.

Los siguientes dos capítulos dedican una orden a cada comando: primero `git switch`.

Continúa con:

[`04-git-switch.md`](04-git-switch.md)
