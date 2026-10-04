# Commits y historial

## Introducción

Manual de diagnóstico, capítulo 2: **el historial**. Escenarios clásicos — «hice un commit equivocado», «perdí un commit», «hice un reset incorrecto». La regla que gobierna todo el capítulo: **cuánto está publicado determina cuánto se puede reescribir**. En local, el historial es tuyo; en remoto, hay que cuidar a los demás.

---

## Mapa conceptual de este capítulo

```text
Commits y historial
       │
       ├── 1. El criterio que lo decide todo: ¿publicado?
       ├── 2. Commit equivocado (y cómo deshacerlo)
       │   ├── 3. Commit perdido (recuperación)
       │   └── 4. Reset incorrecto (salir vivo)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. El criterio que lo decide todo: ¿publicado?

```text
MAPA DE DECISIÓN:
   │
   ├── el cambio está SOLO en tu máquina (no lo
   │   empujaste) → puedes reescribir con más libertad
   │   (amend, rebase, reset suave)
   │
   ├── el cambio ya está PUBLICADO y otros trabajan
   │   sobre él → NO reescribas: usa `revert` (Error 1
   │   si haces reset --hard y push --force en main:
       el daño es de equipo — sección 07 cap. 02 Error
       8)
   │
   └── duda → `git log origin/main..HEAD` ¿hay commits
       «extra» tuyos sin publicar? (Error 2 si decides
       sin mirar)
```

```text
   │
   └── los comandos de este capítulo son PILAS
       quirúrgicas, no borradores: se usan sobre todo
       cuando el resultado es UN commit tuyo, no una
       historia compartida (Error 3)
```

---

## 2. Commit equivocado (y cómo deshacerlo)

```text
ESCENARIO A — está mal el ÚLTIMO commit, NO publicado:
   │
   ├── «qué hice»: `git show HEAD` / `git log -1`
   ├── fix rápido: arreglar + `git commit --amend`
   │   (solo si NO está publicado — Error 4 si lo
   │   amendar sobre main publicado: reescribes historia
   │   ajena)
   └── opción correcta cuando lo publicaste: `git revert
       <sha>` (nuevo commit que deshace — Error 5 si
       «revert» suena a borrar: NO borra nada, la
       historia queda completa)
```

```text
ESCENARIO B — están MAL VARIOS commits sin publicar:
   │
   ├── `git rebase -i HEAD~n` → `pick` / `fixup` /
   │   `drop` (Error 6 si `n` no cuenta tus commits:
   │   revisa `git log --oneline` primero)
   └── después: verificar con `git log` y SOLO LUEGO
       push (Error 2 prevención)
```

```text
ESCENARIO C — metiste archivos equivocados en el commit:
   │
   ├── aún sin publicar: `git reset --soft HEAD~1` y
   │   rehaces el staging (sección 04 — Error 7 si
   │   usaste --hard sin querer: perdiste cambios del
   │   working tree)
   └── publicado: corrige con commit nuevo (Error 1
       prevención)
```

```text
   │
   └── «commit equivocado» casi siempre tiene solución
       BARATA si se detecta el mismo día y NO se
       publicó (Error 8 si esperas a que crezca)
```

---

## 3. Commit perdido (recuperación)

```text
SÍNTOMA: «no está en el log» — pero hiciste el commit
   │
   ├── 1. `git reflog` → la pista de tu HEAD: ahí están
   │   TODOS los desplazamientos (Error 9 si no lo
   │   conoces: el reflog es tu primera ayuda)
   │
   ├── 2. encuentra el commit: `git log --oneline` sobre
   │   la referencia del reflog (`git show <sha>`)
   │
   ├── 3. resucítalo:
   │     · solo el contenido: `git cherry-pick <sha>`
   │     · recuperar la rama: `git branch nueva <sha>`
   │
   └── 4. si el problema fue un reset --hard: el reflog
       igual te lo devuelve (Error 10 si «borré para
       siempre»: Git casi nunca borra de verdad)
```

```text
LÍMITES DEL MÉTODO:
   │
   ├── el reflog es LOCAL y enmascara tras ~30/90 días:
   │   recupera PRONTO
   │
   └── si ejecutaste `gc` y pasaron los tiempos, puede
       ser irreversible — por eso el respaldo externo
       (sección 08/25 cap. 05) es el verdadero seguro
```

---

## 4. Reset incorrecto (salir vivo)

```text
LOS TRES RESET (sección 08 cap. 03 — repaso de choque):
   │
   ├── `--soft`  → mueve el puntero; staging Y working
   │   tree intactos (el más seguro)
   ├── `--mixed` → mueve y limpia staging; working tree
   │   intacto (default)
   └── `--hard`  → mueve y BORRA cambios sin commitear
       (el único que destruye trabajo real)
```

```text
SI TE PASASTE DE --hard (Error 10):
   │
   ├── 1. NO hagas nada más que escriba en el repo
   │   (Error 10 si sigues trabajando: pisas la
   │   recuperación)
   ├── 2. `git reflog` → última referencia previa al
   │   reset
   ├── 3. `git reset --hard <última-referencia>` o
   │   `git stash`… no: NO reinicies estando nervioso —
   │   recupera con reflog (paso 2)
   └── 4. verifica con `git status` + diff contra lo que
       esperabas
```

```text
SI EL RESET ERA SOLO PARA «DESHACER EL ÚLTIMO COMMIT»:
   │
   └── casi siempre querías `--soft` o `revert`, no
       `--hard` (Error 7 prevención: clasifica ANTES
       de escribir el flag)
```

```text
   │
   └── regla personal: antes de cada `--hard`,
       `git status` y `git stash` preventivo (Error 7
       prevención)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: reescribir historia publicada de otros

**Qué ocurrió:** `reset --hard` + `--force` en main compartido; el trabajo de otra persona desapareció.

**Por qué:** sin distinguir publicado/privado (punto 1).

**Cómo comprobarlo:** `git log origin/main..HEAD` y el historial remoto: ¿desaparecieron commits ajenos?

**Opciones:** recuperar desde reflog/remoto si es posible; restaurar ramas de otros; disculparse con proceso (Error 4 — sección 07 cap. 02 Error 8).

**Riesgos:** pérdida de trabajo y confianza.

**Solución:** publicado → revert (punto 2).

**Cómo se evita:** regla escrita: en ramas compartidas, cero force (sección 07).

---

### Error 2: decidir sin mirar el estado

**Qué ocurrió:** se ejecutó un reset/rebase sin saber si los commits estaban publicados.

**Por qué:** sin diagnóstico previo (punto 1 Error 2).

**Cómo comprobarlo:** ¿miraste `git status` y `git log` antes?

**Opciones:** hoy: audita lo hecho; mañana: el mapa del punto 1 es obligatorio.

**Riesgos:** daño accidental sobre lo correcto.

**Solución:** mapa de decisión (punto 1).

**Cómo se evita:** «mira antes de apretar» como hábito (Error 3).

---

### Error 3: arreglar con herramientas de reescritura todo el tiempo

**Qué ocurrió:** la mitad de los cambios del proyecto se hicieron con amend/rebase/reset.

**Por qué:** uso sin criterio (punto 1 Error 3).

**Cómo comprobarlo:** historial: ¿cuántos amend/force? ¿compartidos?

**Opciones:** cambiar hábito: commits pequeños y correctos; revert para lo público.

**Riesgos:** historial frágil y equipos temerosos.

**Solución:** quirúrgico y local (punto 1).

**Cómo se evita:** convención: reescribir solo lo privado y joven.

---

### Error 4: amend sobre rama publicada

**Qué ocurrió:** el último commit «se arregló» con amend tras hacer push; los demás tuvieron conflictos.

**Por qué:** publicado + amend (punto 2 Error 4).

**Cómo comprobarlo:** `git status` / `git log` antes y después: ¿el SHA cambió tras push?

**Opciones:** avisar y restaurar; si solo tú usas la rama, reempezar con aviso.

**Riesgos:** divergencia confusa.

**Solución:** amend solo privado (Error 1 punto 1).

**Cómo se evita:** revisar `git status -sb` (¿ahead/behind?) antes de amendar.

---

### Error 5: confundir revert con borrar

**Qué ocurrió:** se evitó revert creyendo que eliminaba el commit de la historia.

**Por qué:** semántica desconocida (punto 2 Error 5).

**Cómo comprobarlo:** `git revert` crea un commit nuevo; el original sigue.

**Opciones:** usar revert con confianza en lo publicado.

**Riesgos:** rehacer a mano lo que Git hace seguro.

**Solución:** revert = deshacer sin borrar (punto 2).

**Cómo se evita:** practicar revert en el Proyecto 1 (sección 27 cap. 01).

---

### Error 6: rebase con conteo equivocado

**Qué ocurrió:** `HEAD~3` no incluía el commit que querías (o incluyó de más).

**Por qué:** no se verificó el alcance (punto 2 Error 6).

**Cómo comprobarlo:** `git log --oneline HEAD~4..HEAD` — ¿la lista es la que quieres?

**Opciones:** abortar si el rebase arrancó (`git rebase --abort`) y rehacer con el conteo correcto.

**Riesgos:** reescribir de más.

**Solución:** verifica antes (Error 2 punto 1).

**Cómo se evita:** contar con log, no de memoria.

---

### Error 7: --hard donde querías --soft

**Qué ocurrió:** intención: deshacer el último commit; resultado: además perdí los cambios.

**Por qué:** flag sin clasificar (punto 4).

**Cómo comprobarlo:** reflog — ¿qué comandos corriste? ¿el working tree quedó limpio?

**Opciones:** recuperar por reflog (punto 3); clasificar siempre (punto 4).

**Riesgos:** trabajo sin commitear perdido.

**Solución:** soft/mixed/hard con criterio (punto 4).

**Cómo se evita:** antes de `--hard`, stash preventivo.

---

### Error 8: esperar a «arreglar el commit» (y publicarse)

**Qué ocurrió:** el commit equivocado se amendaron y corrigieron durante días hasta que chocó con remoto.

**Por qué:** detección tardía (punto 2 Error 8).

**Cómo comprobarlo:** edad del commit erróneo.

**Opciones:** cuanto antes: si privado, amend/rebase; si publicado, revert.

**Riesgos:** el arreglo cuesta cada vez más.

**Solución:** mismo día (punto 2).

**Cómo se evita:** revisar `git log -1` antes de cada push.

---

### Error 9: no conocer el reflog

**Qué ocurrió:** «perdí un commit» y se reimplementó desde cero… existiendo el reflog.

**Por qué:** recurso desconocido (punto 3 Error 9).

**Cómo comprobarlo:** ejecuta `git reflog` ahora: ¿ves tu historia de HEAD?

**Opciones:** recuperar por reflog y aprender el flujo (punto 3).

**Riesgos:** trabajo reimplementado y errores repetidos.

**Solución:** reflog como primera ayuda (punto 3).

**Cómo se evita:** incluirlo en tu repertorio mínimo (sección 08).

---

### Error 10: seguir trabajando tras un --hard sospechoso

**Qué ocurrió:** tras el reset, se siguieron editando archivos; la recuperación por reflog quedó pisada.

**Por qué:** pasos en mal orden (punto 4 Error 10).

**Cómo comprobarlo:** ¿qué comandos escribiste DESPUÉS del reset?

**Opciones:** detener, reflog inmediato; lo no pisado se recupera.

**Riesgos:** perder la pista buena.

**Solución:** detenerse y diagnosticar (punto 4).

**Cómo se evita:** protocolo: status → log → accionar.

---

## 6. Práctica guiada

### Objetivo

Dominar los tres escenarios en un repositorio de práctica ANTES de que pasen en serio.

### Paso 1: el mapa

1. Escribe en tu block de notas: ¿publicado? → revert; ¿privado y último? → amend/reset; ¿privado y varios? → rebase -i.

### Paso 2: commit equivocado (privado)

1. Crea 3 commits; arruina el 2.º. Corrígelo con `rebase -i` (fixup). Verifica `git log`.

### Paso 3: commit equivocado (publicado)

1. Push, luego `git revert <sha>` + push. Verifica que el original SIGUE en el historial.

### Paso 4: commit perdido

1. `git reset --soft HEAD~1` (simula pérdida) → recupera con `git cherry-pick` desde el reflog.

### Paso 5: reset --hard peligroso

1. Con cambios sin commitear: `git reset --hard` → recupera desde el reflog con `git reset --hard <ref>`.

### Paso 6: la regla personal

1. Anota tu protocolo de 4 líneas (punto 1 + stash preventivo) en `docs/flujo.md` de tu proyecto.

### Resultado esperado

Los tres escenarios ejecutados y recuperados con éxito en práctica, con tu protocolo escrito.

### Conclusión esperada

Un error de historial deja de ser pánico cuando tienes un criterio (¿publicado?), una herramienta (reflog) y un protocolo probado: lo practicado en calma se recupera en caliente.

---

## 7. Nivel profesional + resumen

### 7.1. Historial en el trabajo real

```text
   │
   ├── en equipo, la regla única es: NO reescribir lo
   │   compartido — revert y aviso (sección 07/16)
   │
   ├── reflog y cherry-pick son tus herramientas de
   │   «rescate cotidiano»: resuelven el 95 % de
   │   «perdí un commit»
   │
   ├── historial LIMPIO se logra con commits pequeños y
   │   buenos mensajes desde el origen — la corrección
   │   pesada es la excepción (sección 06)
   │
   └── métrica personal: ¿cuántos force-push has hecho
       este mes? (cero es el objetivo — sección 20 cap.
       06)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el criterio maestro es «¿está publicado?»: privado se reescribe, público se revierte;
* commit equivocado: amend (último, privado), rebase -i (varios, privado), revert (publicado);
* commit perdido: reflog → cherry-pick o rama nueva — casi nada se pierde de verdad;
* reset: soft (seguro) < mixed < hard (destruye) — y el hard se recupera con reflog si no sigues trabajando;
* los errores típicos (reescritura ajena, decidir sin mirar, abuso de herramientas, amend público, revert mal entendido, conteo erróneo, hard donde soft, detección tardía, reflog desconocido, seguir tras el hard) se previenen con el mapa y el protocolo;
* a nivel profesional: cero force en ramas compartidas y buen historial como prevención.

La idea principal es:

> **El historial casi nunca se pierde: se esconde — y quien conoce el mapa «publicado/privado» y el reflog convierte un susto en un procedimiento de cinco minutos.**

---

## Próximo paso

Historial bajo control.

Ahora los problemas de archivos y ramas: borrados y recuperaciones.

Continúa con:

[`03-archivos-y-ramas.md`](03-archivos-y-ramas.md)
