# origin

## Introducción

`origin` es el nombre con el que casi todo el mundo conoce a su remoto principal: la convención que `git clone` escribe por ti y que aparece en cada `push`, `pull`, `branch -vv` y en la columna `origin/*` de tus ramas. No tiene magia — es solo el nombre por defecto—, pero entender bien qué es y qué no es evita confusiones enteras (¿origin es GitHub? ¿es el original? ¿y en un fork?).

Este capítulo consolida origin como concepto: su origen (nada que ver con Git), sus interacciones con ramas y seguimiento, y cómo convive con otros nombres como `upstream`.

En este capítulo aprenderás:

* la naturaleza de `origin` (nombre por defecto de convención);
* todo lo que «origin» toca: fotos, upstreams, mensajes;
* origin en clones, forks y remotos alternativos;
* errores y malentendidos con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
origin
       │
       ├── 1. Un nombre por defecto
   │        ├── convención, no magia
   │        └── cómo se crea
   │
       ├── 2. Todo lo que origin toca
   │        ├── refs/remotes/origin/*
   │        ├── upstreams (branch.<x>.remote = origin)
   │        └── mensajes y atajos
   │
       ├── 3. origin en distintos contextos
   │        ├── clone normal
   │        ├── fork (origin + upstream)
   │        └── remote alternativo (origin ≠ GitHub)
   │
       ├── 4. Errores y malentendidos
   │
       ├── 5. Práctica guiada
   │
       └── 6. Nivel profesional + resumen
```

---

## 1. Un nombre por defecto

### 1.1. Cómo aparece

```bash
git clone <URL>
git remote -v
#  origin  <URL> (fetch)
#  origin  <URL> (push)
```

```text
   │
   ├── clone lo llama origin automáticamente (y su
   │   refspec mapea ramas → origin/*
   │
   ├── git remote add origin <URL> lo mismo en repos
   │   iniciados a mano
   │
   └── «origin» = fuente de la que vino mi clon:
       traducción razonable del nombre
```

### 1.2. Puede (y a veces debe) cambiar

```bash
git remote rename origin github
git remote add origin <otra-URL>    # tras quitarlo
```

```text
En la práctica:
   │
   ├── la mayoría vive con origin para siempre
   │
   └── en migraciones/renombres: puedes llamarlo
       distinto — solo afecta a TU config y la de tu
       clon
```

---

## 2. Todo lo que origin toca

### 2.1. El inventario

```text
Dónde aparece              Significado
──────────────────────────────────────────────────────────
refs/remotes/origin/*      fotos del remoto (solo con
                           fetch/push)
branch.<rama>.remote =     «la pareja de esta rama es
origin                     origin» (upstream)
messages «... with          estado vs. ese remoto
'origin/main'»
git push / pull sin        destino por defecto: origin
argumentos (si el
upstream lo es)
origin/HEAD                indicador de rama por
                           defecto del remoto
```

### 2.2. origin/HEAD

```bash
git remote show origin | grep HEAD
git symbolic-ref refs/remotes/origin/HEAD
```

```text
   │
   └── apunta a la rama por defecto del servidor (main);
       en clones raros (HEAD mal apuntado) puede faltar:
       git remote set-head origin -a lo recalcula
```

### 2.3. Con `@{upstream}`

```text
Si tu rama trackea origin/main:
   │
   ├── git pull  →  integra origin/main
   ├── git push  →  sube a origin/main
   └── git log @{upstream}..HEAD  →  tu progreso
       respecto a ORIGIN (no a «GitHub» ni a «la nube»:
       a esa referencia concreta)
```

---

## 3. origin en distintos contextos

### 3.1. Clone normal

```text
origin = el repo del que cloné (tu servidor/compañera)
```

### 3.2. Fork

```text
origin   = TU fork (donde publicas)
upstream = repo oficial (de donde actualizas main)

git remote add upstream <URL-oficial>
git fetch upstream
git switch -c main-upstream upstream/main   # (patrón)
   │
   └── o mantener main local = origin/main y traer
       cambios con upstream cuando toque — el equipo
       define el flujo exacto
```

### 3.3. origin ≠ GitHub

```text
   │
   ├── puede ser tu servidor, un espejo local, otra
   │   persona…
   │
   └── y GitHub puede NO estar en origin: en algunos
       flujos, origin es el server interno y GitHub es
       un remoto más (backup/publicación)
```

---

## 4. Errores y malentendidos

### Error 1: «origin es GitHub»

**Qué ocurrió:** en un repo sin GitHub (o con otro servidor) los mensajes de origin confunden.

**Por qué:** asociación mental por costumbre.

**Cómo comprobarlo:** `git remote -v` (la URL manda).

**Opciones:** nombrar con claridad si os confundís (`git remote rename origin interno`).

**Riesgos:** diagnósticos contra la plataforma equivocada.

**Solución:** origin = lo que diga `-v`.

**Cómo se evita:** recordar que es un nombre.

---

### Error 2: «origin es el original/verdad»

**Qué ocurrió:** en forks, se da por hecho que origin es el oficial.

**Por qué:** nombre engañoso para el caso.

**Cómo comprobarlo:** `remote -v` (¿URL de quién?).

**Opciones:** añadir `upstream` y dejar claro qué es qué.

**Riesgos:** PRs al fork propio, cambios al sitio equivocado.

**Solución:** mapeo explícito.

**Cómo se evita:** anotarlo al clonar un fork.

---

### Error 3: Borrar origin y desorientarse

**Qué ocurrió:** `remote remove origin` y todos los mensajes/parejas se rompen.

**Por qué:** se quitó el nombre que casi todo referenciaba.

**Cómo comprobarlo:** `remote -v` vacío; `branch -vv` sin parejas; push falla.

**Opciones:** re-añadir con la URL correcta y re-enlazar `-u` donde haga falta.

**Riesgos:** tiempo perdido (no historial).

**Solución:** re-add + set-upstream.

**Cómo se evita:** renombrar en vez de quitar (rename conserva enlaces).

---

### Error 4: origin/* que no avanza (foto muerta)

**Qué ocurrió:** `git log origin/main` está viejo; status dice cosas raras respecto a «lo que yo veo en GitHub».

**Por qué:** sin fetch desde hace tiempo.

**Cómo comprobarlo:** fetch + comparar; `ls-remote --heads origin`.

**Opciones:** fetch (con pruner si procede).

**Riesgos:** conclusiones falsas.

**Solución:** refrescar.

**Cómo se evita:** fetch.prune y rutina.

---

### Error 5: Origin apunta a URL vieja tras migración de organización

**Qué ocurrió:** repo transferido a otra org en GitHub; Git sigue con URL anterior (a veces GitHub redirige, a veces no).

**Por qué:** config local sin actualizar.

**Cómo comprobarlo:** `remote -v` vs. URL nueva; fetch fallido o advertencia.

**Opciones:** `set-url` con la URL nueva; avisar al equipo.

**Riesgos:** trabajos publicados al lugar antiguo (o autenticaciones raras).

**Solución:** set-url + pruebas con ls-remote.

**Cómo se evita:** al transferir repos, actualizar remotos de todos los clonos.

---

### Error 6: origin/HEAD roto (HEAD branch desconocido)

**Qué ocurrió:** `remote show origin` no sabe la rama por defecto o GitHub muestra un HEAD raro tras cambios.

**Por qué:** refs/remotes/origin/HEAD desactualizada o ausente.

**Cómo comprobarlo:** `git symbolic-ref refs/remotes/origin/HEAD`.

**Opciones:** `git remote set-head origin -a` (recalcula contra el servidor).

**Riesgos:** menores (confusión en scripts que usen HEAD remoto).

**Solución:** set-head -a.

**Cómo se evita:** tras cambios de rama por defecto en el servidor.

---

## 5. Práctica guiada

### Objetivo

Mapear origin en tu repositorio real y practicar sus operaciones de mantenimiento.

### Paso 1: inventario completo

```bash
git remote -v
git config --get-regexp '^remote\."?origin"?\.'
git symbolic-ref refs/remotes/origin/HEAD   # (o el
                                             # error si
                                             # no existe)
```

1. Anota: URL, refspec y HEAD.

### Paso 2: fotos y upstreams

```bash
git fetch --prune
git branch -a
git branch -vv
git config --get-regexp '^branch\.' | Select-String origin
```

1. Relaciona: ¿qué ramas tienen pareja `origin/*`?

### Paso 3: atajos

```bash
git log @{upstream}..HEAD --oneline     # progreso tuyo
git log HEAD..@{upstream} --oneline     # ajenos sin bajar
```

### Paso 4: renombrar y volver (seguro)

```bash
git remote rename origin github
git remote -v
git branch -vv                     # ¿parejas «github/…»?
git remote rename github origin
git remote -v
git branch -vv                     # vuelve a origin/…
```

### Paso 5: origin/HEAD

```bash
git remote set-head origin -a
git symbolic-ref refs/remotes/origin/HEAD
git remote show origin | Select-String HEAD
```

### Paso 6: en un fork (si aplica)

```bash
git remote add upstream <URL-oficial>
git remote -v
git fetch upstream
git branch -r                      # origin/* y upstream/*
```

### Resultado Esperado

Un mapa mental exacto de tu origin: qué es, qué toca y cómo repararlo si algo se mueve.

### Conclusión esperada

Origin deja de ser «el nombre que sale» para ser una referencia que entiendes y gobiernas: -v, fotos, upstreams y HEAD bajo control.

---

## 6. Nivel profesional + resumen

### 6.1. Convenciones en equipos

```text
   │
   ├── conservar origin en repos normales (menos
   │   sorpresas en scripts y documentación)
   │
   ├── en forks: origin (yo) + upstream (oficial) como
   │   convención casi universal en open source
   │
   ├── migraciones de org: set-url por guión + aviso
   │
   └── documentos de onboarding: «tu origin debería
       decir X» — verificable con remote -v
```

### 6.2. Diagnóstico con origin

```text
Orden rápido cuando «no sincroniza»:
   │
   1. git remote -v            (¿URL correcta?)
   2. git ls-remote origin     (¿responde?)
   3. git status               (¿ahead/behind/pareja?)
   4. git fetch --prune        (¿foto fresca?)
   5. git log a..b             (¿qué hay de verdad?)
```

### 6.3. Resumen

En este capítulo aprendiste que:

* `origin` es solo la convención de nombre del remoto principal; lo verdadero es la URL y el refspec en tu config;
* toca todo: fotos `origin/*`, upstreams de ramas, mensajes de status y destinos por defecto de push/pull; `origin/HEAD` marca la rama por defecto del servidor;
* según el contexto (clone, fork, servidor interno) el papel de origin cambia: en forks, conviven `origin` y `upstream`;
* los malentendidos (origin = GitHub, origin = oficial, borrarlo, fotos viejas, migraciones, HEAD roto) se resuelven con `-v`, `ls-remote`, fetch/prune y `set-head -a`;
* a nivel profesional: convención estable, onboarding verificable y un orden de diagnóstico fijo.

La idea principal es:

> **Origen no es un sitio: es un nombre que apunta a un sitio —y quien controla ese puntero, controla la conversación con el servidor.**

---

## Próximo paso

Has consolidado `origin`.

En muchos proyectos existe un segundo nombre fundamental: `upstream`.

Continúa con:

[`08-upstream.md`](08-upstream.md)
