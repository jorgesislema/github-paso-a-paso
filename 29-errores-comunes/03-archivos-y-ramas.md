# Archivos y ramas

## Introducción

Manual de diagnóstico, capítulo 3: **«eliminé algo que no debía»** — un archivo (¿del working tree? ¿del índice? ¿del historial?) y una rama (¿local? ¿remota? ¿mergeada?). Casi todos los sustos de esta categoría tienen la misma estructura: confundir EN QUÉ ESTADO estaba la cosa. Este capítulo te da el mapa para clasificar en segundos y actuar sin empeorar.

---

## Mapa conceptual de este capítulo

```text
Archivos y ramas
       │
       ├── 1. Diagnóstico del archivo: ¿dónde estaba?
       ├── 2. Archivo eliminado (tres escenarios)
       │   ├── 3. Rama eliminada (¿dónde estaba?)
       │   └── 4. Rama borrada con trabajo dentro
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Diagnóstico del archivo: ¿dónde estaba?

```text
LAS TRES CAPAS (sección 04 — repaso de choque):
   │
   ├── working tree: tus archivos en disco (rm/delete
   │   del explorador)
   ├── staging/índice: lo preparado para el commit
   │   (`git add`)
   └── historial/commit: lo ya commiteado (las tres
       capas de siempre — sección 01)
```

```text
PREGUNTA CLAVE: ¿el archivo estaba en un COMMIT?
   │
   ├── NO (recién creado o solo en disco) → si lo
   │   borraste, no hay dónde recuperarlo en Git (Error
   │   1 si buscas en el historial: no estaba)
   │
   ├── SÍ, en commit local → `git checkout HEAD -- <f>` o
   │   `git restore --source=HEAD -- <f>` (Error 2 si
   │   usas restore sin source: apunta al HEAD
   │   actual, no al que tú quieres)
   │
   └── SÍ, publicado → está en el remoto: clone, reflog
       o historial del remoto (Error 3 si «ya no existe
       en ningún lado»: existe en origin/*)
```

```text
   │
   └── comandos de confirmación: `git status` (¿staged
       como borrado?), `git log --oneline -- <f>` (¿en
       qué commits vivió?), `git diff` (¿qué quedó
       pendiente?)
```

---

## 2. Archivo eliminado (tres escenarios)

```text
A — borrado en disco, SIN git add:
   │
   ├── `git restore <f>` (o `git checkout -- <f>`)
   └── Error 4 si ya habías hecho `git add`: restore no
       basta — sigue con el escenario B
```

```text
B — el borrado está EN EL STAGING (`git rm` o `git add`
del borrado):
   │
   ├── `git rm --cached <f>` revierte el staged (y
   │   `git restore <f>` si el archivo desapareció de
   │   disco)
   └── Error 5 si además lo commiteaste y empujaste:
       sigue el escenario C
```

```text
C — commiteado (y quizás publicado):
   │
   ├── recuperar contenido: `git checkout <sha> -- <f>`
   │   y commitear de nuevo (Error 6 si borras «para
   │   siempre» de la rama actual: lo recuperas desde
   │   cualquier sha)
   │
   ├── si querías ELIMINARLO de verdad de rama actual:
       ya lo hiciste; el historial lo conserva (y eso
       es bueno — sección 08/21 cap. 06)
   │
   └── si hay datos sensibles: INCIDENTE, no error
       (sección 20 cap. 01 / 21 cap. 06) — rotar y
       plan de historia
```

```text
   │
   └── el orden de recuperación siempre es: status →
       log del archivo → restore/checkout con la fuente
       correcta (Error 2 prevención)
```

---

## 3. Rama eliminada (¿dónde estaba?)

```text
PRIMERO: ¿la rama tenía trabajo ÚNICO?
   │
   ├── `git branch -d` solo borra si está mergeada
   │   (Error 7 si usaste -d y Git rechaza: es la
   │   PROTECCIÓN avisándote de que hay trabajo sin
   │   merge — lee el mensaje, no lo ignores)
   │
   └── `git branch -D` fuerza el borrado (Error 8 si
       lo usaste sin leer: ahí podías perder lo único)
```

```text
RECUPERACIÓN (la rama solo existía local y no estaba
mergeada):
   │
   ├── 1. `git reflog` → la referencia de la rama
   │   (`branch: Reflog de: nombre`)
   ├── 2. `git branch recuperada <sha>` (Error 9 si no
   │   aparece: hazlo ANTES de que el reflog caduque —
   │   punto 4)
   └── 3. continúa lo que faltaba y mergea
```

```text
SI LA RAMA ERA REMOTA:
   │
   ├── `git push origin --delete nombre` → también se
   │   puede recrear desde local si la tienes (Error
   │   10 si la borran «por limpieza» y alguien seguía
   │   en ella: aviso antes de borrar — sección 16/25
   │   cap. 05: limpieza con calendario)
   └── si la remota se borró y NO la tienes local:
        reflog del remoto no existe — solo el respaldo/clon
        de otra persona (Error 11 prevención: clon de
        otra persona o respaldo)
```

```text
   │
   └── regla: jamás borres una rama con `-D` sin antes
       `git log main..nombre` (Error 8 prevención: ¿qué
       perderías?)
```

---

## 4. Rama borrada con trabajo dentro

```text
PROTOCOLO COMPLETO:
   │
   ├── 1. NO trabajar más en esa copia (Error 12 si
   │   sigues: pisas el reflog)
   ├── 2. `git reflog` → último sha de la rama
   ├── 3. `git branch nombre <sha>` → la rama vuelve
   ├── 4. verifica: `git log main..nombre` — ¿aparece lo
   │   que faltaba?
   └── 5. merge/PR normal desde ahí (Error 13 si
       mergeas «a ciegas»: revisa primero con log y
       diff)
```

```text
   │
   └── si el reflog ya caducó: la otra persona/clon que
       la tenga, o el respaldo — por eso los remotos y
       push frecuentes existen (sección 06: «push a
       tiempo» es un seguro)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: buscar en el historial un archivo que nunca se commiteó

**Qué ocurrió:** archivo borrado de disco y «recuperarlo con Git» — nunca entró en ningún commit.

**Por qué:** sin diagnóstico de capas (punto 1).

**Cómo comprobarlo:** `git log -- <f>` — ¿vacío?

**Opciones:** si existe copia en otro lado (correo, carpeta), restaurar de ahí; si no, rehacer.

**Riesgos:** perder tiempo y confianza en Git.

**Solución:** clasificar la capa primero (punto 1).

**Cómo se evita:** `git add` temprano de lo que importa (hábito de add frecuente).

---

### Error 2: restore sin fuente correcta

**Qué ocurrió:** se quería el archivo de un commit viejo y se ejecutó `git restore <f>` (que toma HEAD).

**Por qué:** sin `--source`/sha (punto 1 Error 2).

**Cómo comprobarlo:** `git diff <sha> -- <f>` — ¿coincide con lo esperado?

**Opciones:** `git checkout <sha> -- <f>` o `git restore --source=<sha> -- <f>`.

**Riesgos:** «recuperar» una versión que no era.

**Solución:** fuente explícita (punto 1).

**Cómo se evita:** escribir SIEMPRE de dónde sale lo que restauras.

---

### Error 3: creer que un archivo publicado desapareció

**Qué ocurrió:** borrado local + push; el autor juró que «ya no existe en ningún lado».

**Por qué:** sin mirar el remoto/historial (punto 1 Error 3).

**Cómo comprobarlo:** `git log origin/main -- <f>`; clonar el remoto.

**Opciones:** restaurar desde el remoto y commitear (punto 2 C).

**Riesgos:** reimplementar algo que Git conserva.

**Solución:** el remoto es respaldo (push frecuente = seguro).

**Cómo se evita:** push frecuente = seguro.

---

### Error 4: -d rechazado y repetir con -D

**Qué ocurrió:** `git branch -d` dijo «no está mergeada»; se forzó con -D y se perdió el trabajo único.

**Por qué:** ignorar la protección (punto 3 Error 7/8).

**Cómo comprobarlo:** reflog: ¿la referencia de la rama está ahí?

**Opciones:** recuperar por reflog (punto 4); rehacer lo perdido si caducó.

**Riesgos:** pérdida de días de trabajo.

**Solución:** leer el mensaje de Git (punto 3) — la protección era por algo.

**Cómo se evita:** `git log main..rama` antes de borrar CUALQUIER cosa.

---

### Error 5: borrar rama remota «de limpieza» sin avisar

**Qué ocurrió:** una rama con trabajo sin merge se eliminó del remoto por ordenanza de higiene.

**Por qué:** limpieza sin criterio ni aviso (punto 3 Error 10).

**Cómo comprobarlo:** ¿la rama tenía PR abierto o trabajo sin merge?

**Opciones:** recrear desde el reflog local de quien la tenía; establecer regla: solo ramas viejas Y mergeadas.

**Riesgos:** desapariciones colectivas.

**Solución:** limpieza con calendario y avisos (sección 25 cap. 05 punto 4).

**Cómo se evita:** política escrita de ramas huérfanas.

---

### Error 6: seguir trabajando tras borrar la rama

**Qué ocurrió:** se continuó en el árbol actual y el reflog de la rama se enmascaró.

**Por qué:** orden incorrecto (punto 4 Error 12).

**Cómo comprobarlo:** reflog: ¿sigue visible la referencia?

**Opciones:** recuperar YA (punto 4); si se enmascaró, revisar reflog completo por shas.

**Riesgos:** perder la pista.

**Solución:** detenerse y recuperar (punto 4).

**Cómo se evita:** protocolo escrito de 5 pasos (punto 4).

---

## 6. Práctica guiada

### Objetivo

Ejecutar cada escenario de borrado y recuperación en un repositorio de práctica.

### Paso 1: tres capas de un archivo

1. Crea archivo, `git add`, commit. Ahora bórralo de tres formas (disco, staged, commiteado) y recupéralo (punto 2 A/B/C).

### Paso 2: archivo de un sha

1. Modifica y commitea; intenta `git restore <f>` (¿qué versiones ves?). Luego `git restore --source=<sha> -- <f>` y compara (Error 2 prevención).

### Paso 3: rama protegida

1. Crea rama con trabajo sin merge → `git branch -d` (lee el rechazo) → `git log main..rama` → merge → borra (punto 3).

### Paso 4: rama forzada perdida

1. Crea rama con trabajo → `git branch -D` → recupera con reflog + `git branch` (punto 4).

### Paso 5: diagnóstico en 30 segundos

```text
Escenario cualquiera:
   [ ] status → ¿dónde está el borrado?
   [ ] log <archivo/rama> → ¿en qué commit/sha?
   [ ] restore/checkout con FUENTE correcta
```

### Paso 6: la regla personal

1. Añade a tu flujo: «antes de borrar rama: `git log main..rama`; antes de borrar archivo: `git log -- archivo`».

### Resultado esperado

Todos los borrados y recuperaciones ejecutados con éxito y tu regla de pre-borrado escrita.

### Conclusión esperada

Borrar deja de ser un acto irreversible cuando sabes en qué capa está la cosa y dónde queda su última copia — el diagnóstico de 30 segundos es todo lo que separa el susto de la recuperación.

---

## 7. Nivel profesional + resumen

### 7.1. Borrados en el trabajo real

```text
   │
   ├── borrado de archivos en equipo: usar `git rm` +
   │   PR — no el explorador (sección 15: el cambio se
   │   revisa)
   │
   ├── datos sensibles borrados = incidente con
   │   procedimiento, no atajo (sección 20/21 cap. 06)
   │
   ├── limpieza de ramas con política: solo mergeadas +
   │   antigüedad + aviso (sección 25 cap. 05)
   │
   └── métricas: ramas forzadamente borradas por mes
       (cero es el objetivo), archivos recuperados por
       reflog (señal de add a tiempo)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el diagnóstico del archivo depende de la capa: disco, staging o commit — con su comando de recuperación cada uno;
* recuperación por fuente: restore/checkout con el sha correcto, nunca «a ciegas»;
* ramas: `-d` protege, `-D` fuerza — y el reflog recupera lo forzado mientras no caduque;
* el pre-borrado tiene regla: `git log main..rama` y `git log -- archivo`;
* los errores típicos (historial sin el archivo, fuente mal elegida, «ya no existe», -D sin leer, limpieza remota sin aviso, seguir tras borrar) se previenen con diagnóstico de 30 segundos;
* a nivel profesional: borrados por PR, incidentes para sensibles y política de limpieza.

La idea principal es:

> **En Git casi nada se borra de verdad: se desplaza de capa — y saber en qué capa está lo que perdiste es la mitad de la recuperación antes de escribir un solo comando.**

---

## Próximo paso

Archivos y ramas recuperados.

Ahora los problemas de sincronización: push, pull y sus rechazos.

Continúa con:

[`04-push-y-pull.md`](04-push-y-pull.md)
