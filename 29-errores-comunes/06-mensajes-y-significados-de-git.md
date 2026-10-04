# Mensajes y significados de Git

## Introducción

Cierre del manual: **el diccionario de mensajes**. Git y GitHub escriben en inglés y con tecnicismos; este capítulo traduce los mensajes más frecuentes a una estructura fija — qué significa, por qué aparece, qué hacer. No es una lista que hay que memorizar: es un índice al que regresar. Cuando termines este capítulo, ningún mensaje nuevo te obligará a adivinar: buscarás su familia (acceso, remoto, contenido, operación) y aplicarás su patrón de diagnóstico.

---

## Mapa conceptual de este capítulo

```text
Mensajes y significados de Git
       │
       ├── 1. Cómo leer cualquier mensaje (método)
       ├── 2. Familia: repositorio y configuración
       ├── 3. Familia: remoto y acceso
       │   ├── 4. Familia: contenido e historia
       │   └── 5. Familia: operaciones detenidas
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Cómo leer cualquier mensaje (método)

```text
ESTRUCTURA DE UN MENSAJE DE GIT:
   │
   ├── fatal: / error: / hint: → severidad
   ├── (a veces) una CAUSA en inglés técnico
   └── (a veces) un hint con la acción sugerida: LÉELO
       — Git suele decir el paso exacto (Error 1 si
       solo lees la primera línea: los hints suelen
       venir debajo)
```

```text
MÉTODO DE 4 PASOS:
   │
   ├── 1. copiar el mensaje COMPLETO (Error 1 si lo
   │   resumes de memoria: pierdes el hint)
   ├── 2. clasificar la familia: ¿acceso? ¿remoto?
   │   ¿contenido? ¿operación detenida?
   ├── 3. diagnóstico con comandos de siempre
   │   (status / log / remote -v / ls-remote)
   └── 4. recorrer a la sección/capítulo que aplica
       (este diccionario como índice)
```

```text
   │
   └── regla de oro: el mensaje es DATOS, no juicio —
       «rejected», «denied» o «refusing» describen un
       control, no un fracaso (Error 3).
```

---

## 2. Familia: repositorio y configuración

```text
"fatal: not a git repository (or any of the parent
 directories)"
   │
   ├── significado: estás FUERA de un repositorio (o
   │   falta .git — si buscas «el bug»: no lo
   │   hay)
   ├── comprobar: `git rev-parse --show-toplevel` /
   │   `ls -a`
   └── acción: cd al proyecto correcto o `git init`
       (Error 5 — si clonaste a medias: reclona)
```

```text
"Please tell me who you are... fatal: unable to auto-
detect email address"
   │
   ├── significado: faltan `user.name` / `user.email`
   │   (sección 02/13)
   ├── comprobar: `git config user.name` / `user.email`
   └── acción: `git config --global user.name "..."` y
       email; los commits viejos NO cambian (Error 7
       si esperas arreglar el pasado: solo aplica a
       partir de ahí)
```

```text
"warning: LF will be replaced by CRLF" / diferencias
de fin de línea
   │
   ├── significado: finales de línea distintos entre
   │   sistemas (sección 13 cap. 03)
   ├── comprobar: `git config core.autocrlf`
   └── acción: configuración consistente + .gitattributes
       en el proyecto (si lo ignoras: diffs
       sucios en cada equipo)
```

```text
"pathspec '<archivo>' did not match any files"
   │
   ├── significado: Git no encuentra ese archivo en esa
   │   ruta (si es un typo: verifica con `git
   │   status`)
   └── acción: ruta relativa desde la raíz del repo;
       comillas si hay espacios
```

---

## 3. Familia: remoto y acceso

```text
"Repository not found."
   │
   ├── significado: la URL apunta a un repo inexistente
   │   o SIN PERMISOS para ti ( GitHub enmascara lo no
   │   autorizado — si juras que «existe»:
   │   también aparece cuando no tienes acceso)
   ├── comprobar: `git remote -v` ( URL correcta?),
   │   `git ls-remote origin` ( ¿autentica?)
   └── acción: corregir URL o acceder con credencial
       (sección 29 cap. 01)
```

```text
"Permission denied (publickey)" / "Could not read from
 remote repository. Please make sure you have the
 correct access rights"
   │
   ├── significado: autenticación fallida con el
   │   remoto (llave, token o agente — si solo
   │   cambias la URL: eso no arregla credenciales)
   ├── comprobar: `ssh -T git@github.com` o
   │   `git ls-remote origin`
   └── acción: llave/credencial/token según el método
       (Error 2 — sección 29 cap. 01)
```

```text
"remote: Permission to <repo> denied to <usuario>."
   │
   ├── significado: autenticado PERO sin permiso de
   │   escritura (Error 4: no es un fallo técnico — es gobernanza)
   └── acción: colaborar con PR desde fork o pedir
       permisos (Error 4 — sección 15/16)
```

```text
HTTP: "401 Unauthorized" / "403 Forbidden" / "Bad
 credentials"
   │
   ├── significado: 401 = sin credencial válida; 403 =
   │   credencial válida, permiso no; 403 también
   │   reglas (sección 18/20)
   └── acción: token vigente + scope correcto (sección 29 cap. 01)
```

---

## 4. Familia: contenido e historia

```text
"! [rejected]  main -> main  (fetch first)"
"non-fast-forward"
   │
   ├── significado: el remoto tiene commits que no
   │   tienes (Error 1 — sección 29 cap. 04)
   └── acción: `git pull --rebase origin main` →
       resolver si toca → push (jamás --force en
       compartida)
```

```text
"hint: Updates were rejected because the remote
 contains work that you do not have locally."
"refusing to merge unrelated histories"
   │
   ├── significado: (a) historia divergente; (b) los
   │   repos no comparten ancestro (Error 5: típico de
   │   `git init` + remote ya poblado)
   └── acción: (a) sincronizar; (b) revisar que es lo
       que quieres — `git pull origin main
       --allow-unrelated-histories` solo con criterio
```

```text
"warning: Your branch is ahead of 'origin/main' by N
 commits."
   │
   ├── significado: commits locales SIN publicar (Error 8: no es error,
   │   es estado)
   └── acción: push (o amendar si aún no publicaste)
```

```text
"Everything up-to-date"
   │
   ├── significado: no había NADA que subir (Error 7
   │   si esperabas contenido: no estaba commiteado o
   │   ya estaba todo — Error 4)
   ├── comprobar: `git status` / `git log origin/main..HEAD`
   └── acción: revisar staging (Error 8: el
       archivo «sin commit» vive en status, no en el
       push)
```

```text
"HEAD is detached" / "You are in 'detached HEAD' state"
   │
   ├── significado: apuntas a un commit, no a una rama
   │   (sección 05/08) — los nuevos commits se
   │   «pierden» si no creas rama
   ├── comprobar: `git status` (primera línea)
   └── acción: `git switch -c rama-nombre` para volver
       a trabajar con nombre
```

---

## 5. Familia: operaciones detenidas

```text
"fatal: Unable to create '.../.git/index.lock':
 File exists."
   │
   ├── significado: otra operación Git está corriendo
   │   o quedó un lock huérfano (Error 6)
   ├── comprobar: ¿otra terminal/proceso Git abierto?
   └── acción: si NO hay proceso: borrar el index.lock
       con cuidado (si lo borras con Git
       corriendo: corrupción posible)
```

```text
"error: cannot rebase: You have unstaged changes."
"Please commit your changes or stash them before you
 rebase."
   │
   ├── significado: working tree sucio antes de
   │   reescribir (Error 7 — sección 04/29 cap. 02)
   └── acción: commit o `git stash` → operación →
       `git stash pop`
```

```text
"You are not currently on a branch." / rebase y merge
 interrumpidos (CONFLICT)
   │
   ├── significado: operación EN PAUSA esperando tu
   │   resolución (si sientes urgencia: la
   │   pausa es el diseño)
   └── acción: `git status` dice qué sigue: resolver +
       `git rebase --continue` / commit / `--abort`
       (sección 29 cap. 05)
```

```text
"GPG error" / "Signature verification failed"
   │
   ├── significado: commits firmados con llave no
   │   confiable o inexistente (si
   │   tu organización exige firmas, configura GPG/SSH
   │   signing — sección 18/13)
   └── acción: verificar `git config --show-origin
       --get user.signingkey` y claves públicas
```

```text
HTTP de GitHub: "429 Too Many Requests" / "abuse
 detection"
   │
   ├── significado: límite de tasa por llamadas
   │   repetidas ( scripts, CI mal configurado)
   └── acción: backoff en scripts, revisar workflows
       (sección 19 cap. 06)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: resumir el mensaje de memoria

**Qué ocurrió:** se recordó «algo de permisos» y se aplicó la receta equivocada.

**Por qué:** sin copia completa (punto 1 Error 1).

**Cómo comprobarlo:** ¿puedes citar la línea exacta ahora?

**Opciones:** copiar el mensaje completo y clasificar (punto 1).

**Riesgos:** bucles de intentos aleatorios.

**Solución:** mensaje = datos (punto 1).

**Cómo se evita:** guardar el mensaje en tus notas de error.

---

### Error 2: confundir familias de mensajes

**Qué ocurrió:** un «Repository not found» (URL/accesso) se trató como fallo de contenido.

**Por qué:** sin clasificación (punto 1 paso 2).

**Cómo comprobarlo:** `git ls-remote` separa acceso de contenido al instante.

**Opciones:** seguir la familia correcta de este diccionario.

**Riesgos:** soluciones de la familia equivocada.

**Solución:** las 4 familias (puntos 2–5).

**Cómo se evita:** método de 4 pasos siempre.

---

### Error 3: tratar controles como fallos

**Qué ocurrió:** «rejected» / «refusing» se leyeron como «Git está roto».

**Por qué:** expectativa errónea (punto 1 Error 3).

**Cómo comprobarlo:** el mensaje siempre nombra la causa o el hint.

**Opciones:** seguir el hint; escalar solo si el hint falla.

**Riesgos:** pánico y medidas destructivas (force, borrar).

**Solución:** control, no fallo (punto 1).

**Cómo se evita:** vocabulario de esta sección (capítulos 04–05).

---

### Error 4: mezclar permisos con autenticación

**Qué ocurrió:** un 403 (permiso) se trató rotando tokens (autenticación).

**Por qué:** familias confundidas (punto 3).

**Cómo comprobarlo:** `git ls-remote` pasa → eres autenticado; el fallo es de permiso.

**Opciones:** pedir permisos o usar PR desde fork.

**Riesgos:** rotación inútil de credenciales y bloqueos.

**Solución:** 401/403 con criterio (punto 3).

**Cómo se evita:** separar «¿entra?» de «¿puede escribir?».

---

### Error 5: tomar hints peligrosos sin criterio

**Qué ocurrió:** `--allow-unrelated-histories` o flags sugeridos se aplicaron a ciegas en un repo ajeno.

**Por qué:** hint sin contexto (punto 4).

**Cómo comprobarlo:** ¿el repo es tuyo? ¿comparte historia por diseño?

**Opciones:** revisar alcance antes de cualquier flag; abortar si no aplica.

**Riesgos:** historia fusionada incorrectamente.

**Solución:** hint = pista, no orden (punto 1).

**Cómo se evita:** decidir con status/log antes de acatar.

---

### Error 6: borrar index.lock con procesos Git vivos

**Qué ocurrió:** se borró el lock mientras corría un commit en otra terminal.

**Por qué:** diagnóstico incompleto (Error 6 punto 5).

**Cómo comprobarlo:** ¿otra terminal/IDE ejecutando Git?

**Opciones:** esperar a que termine; solo si está huérfano, borrar.

**Riesgos:** índice corrupto.

**Solución:** verificar procesos primero (punto 5).

**Cómo se evita:** una sola operación Git a la vez por repositorio.

---

### Error 7: ignorar el estado previo

**Qué ocurrió:** rebase/pull ejecutados con trabajo sucio y sin leer el aviso.

**Por qué:** sin `git status` previo (Error 7 punto 5).

**Cómo comprobarlo:** `git status` antes de cada operación de reescritura.

**Opciones:** commit o stash → operación → retomar.

**Riesgos:** errores encadenados.

**Solución:** limpio antes de reescribir (punto 5).

**Cómo se evita:** checklist de las 4 preguntas (sección 29 cap. 04 punto 1).

---

### Error 8: confundir estado con error

**Qué ocurrió:** «ahead of origin» o «Everything up-to-date» se trataron como fallos.

**Por qué:** sin lectura de estado (punto 4).

**Cómo comprobarlo:** `git status -sb` — ¿ahead? ¿staged?

**Opciones:** push si hay commits; add/commit si esperabas subir contenido.

**Riesgos:** acciones sobre lo correcto.

**Solución:** leer estado antes de concluir (punto 4).

**Cómo se evita:** dominar status (sección 04 — la herramienta número uno).

---

## 7. Práctica guiada

### Objetivo

Convertir el diccionario en reflejo: reconocer cada familia y resolver sin buscar fuera del curso.

### Paso 1: método en vivo

1. Provoca cada mensaje: fuera de repo, config faltante, URL mala, push rechazado, «ahead», detached, lock. Copia el mensaje completo y aplica los 4 pasos (punto 1).

### Paso 2: fichas

1. Crea `docs/mensajes.md` en tu proyecto: una ficha por mensaje (mensaje — familia — comando de comprobar — acción).

### Paso 3: familia de acceso

1. Practica 401 vs 403 vs «Repository not found» con un token de prácticas y un repo sin permisos (punto 3 Error 4).

### Paso 4: familia de contenido

1. Ejecuta un push rechazado y un «Everything up-to-date»: diagnostícalos de pie, sin apuntes (Error 3 y Error 8).

### Paso 5: familia de operación

1. Deja un rebase en pausa y «resuélvelo» con status como guía: continúa y aborta (sección 29 cap. 05).

### Paso 6: la regla personal

1. Añade a `docs/flujo.md`: «mensaje completo → familia → comando → acción».

### Resultado esperado

Los mensajes frecuentes reconocidos al vuelo y tu fichero de mensajes funcionando como ayuda rápida.

### Conclusión esperada

Un mensaje de Git deja de ser ruido cuando tiene familia y patrón: lo lees completo, lo clasificas, pruebas con un comando y ya sabes el capítulo exacto del curso que resuelve tu caso.

---

## 8. Nivel profesional + resumen

### 8.1. Mensajes en el trabajo real

```text
   │
   ├── equipos: glosario compartido de errores +
   │   runbooks (sección 23/24)
   │
   ├── CI/CD: los mismos mensajes aparecen en logs de
   │   runners — diagnosticar con el mismo método
   │   (sección 19/22)
   │
   ├── seguridad: 403/401/abuse → revisar tokens,
   │   secretos y límites (sección 20 cap. 01/04)
   │
   └── métrica: tickets «Git no funciona» por mes →
       objetivo: que tu equipo resuelva solos con
       este método (sección 20 cap. 06)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* cualquier mensaje se lee igual: completo, clasificado por familia, comprobado con comandos, resuelto con su patrón;
* cuatro familias cubren lo cotidiano: repositorio/configuración, remoto/acceso, contenido/historia y operaciones detenidas;
* los mensajes de control (rejected/refusing/denied) son datos, no fallos — y su hint suele dar el paso;
* 401/403/«not found» separan autenticación, permiso y URL;
* los errores típicos (resumir de memoria, familias cruzadas, pánico ante controles, hints acríticos, locks con procesos vivos, suciedad previa, estados leídos como fallos) se previenen con el método de 4 pasos;
* a nivel profesional: glosario de equipo, runbooks y los mismos mensajes en CI.

La idea principal es:

> **No memorices errores: memoriza el método — mensaje completo, familia, comprobación y patrón hacen que cualquier mensaje nuevo sea tan legible que ya conoces.**

---

## Próximo paso

Has llegado al final de la sección de diagnóstico.

Ahora cierra la sección con su índice y regresa al mapa general del curso:

[`README.md`](README.md)
