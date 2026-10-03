# Eliminar ramas

## Introducción

Las ramas son baratas de crear y deberían serlo de borrar: son trabajo terminado, experimentos desechados o tareas ya integradas. Limpiar ramas es higiene de repositorio: menos nombres en `git branch`, menos confusiones en `branch -a` y menos gente navegando a la rama equivocada.

Pero el borrado tiene una salvaguarda que debes respetar: `-d` no borra lo no integrado; `-D` sí. Este capítulo te da el criterio para usar cada uno sin perder trabajo.

En este capítulo aprenderás:

* `git branch -d` (borrado seguro) y `-D` (forzado);
* verificar integración con `git branch -d` y `log a..b`;
* borrar ramas remotas (`push --delete` / `git push origin :rama`);
* limpieza automatizada (purga de remotas eliminadas);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Eliminar ramas
       │
       ├── 1. Borrado local
   │        ├── -d (seguro, con salvaguarda)
   │        ├── -D (forzado, cuidado)
   │        └── verificar antes: log a..b
   │
       ├── 2. Borrado remoto
   │        ├── push --delete / :rama
   │        └── limpiar referencias locales tras
   │
       ├── 3. Limpieza de ramas obsoletas
   │        ├── remotas ya borradas (fetch --prune)
   │        └── ramas locales integradas
   │
       ├── 4. Errores comunes con diagnóstico completo
   │
       ├── 5. Práctica guiada
   │
       └── 6. Nivel profesional + resumen
```

---

## 1. Borrado local

### 1.1. `-d`: seguro

```bash
git branch -d feature-login
```

```text
Comportamiento:
   │
   ├── si la rama está integrada en HEAD (o su punta
   │   es ancestro): la borra
   │
   └── si NO: se NIEGA con mensaje que te dice qué
       hacer (y -D como advertencia de «fuerza»)
```

### 1.2. Comprobar antes: `log <rama>`

```bash
git log main..feature-login --oneline
```

```text
   │
   ├── vacío  →  todo está dentro de main (o lo que
   │   estés usando como destino): borrado seguro
   │
   └── no vacío →  la rama aporta commits: ¿integrar
       (merge/cherry-pick) o tirarlos sabiendo que solo
       reflog los guarda?
```

### 1.3. `-D`: forzado

```bash
git branch -D feature-login
```

```text
   │
   ├── borra aunque NO esté integrado
   │
   ├── «equivalente conceptual» a -d + perder el nombre
   │   de acceso (los commits quedan huérfanos; reflog
   │   los guarda un tiempo)
   │
   └── legítimo: rama de prueba obsoleta, rama local
       duplicada con la remota limpia… pero SIEMPRE
       tras comprobar log/branch -vv
```

### 1.4. Varias a la vez y «la actual»

```bash
git branch -d a b c        # varias
git branch                 # no puedes borrar la ACTIVA
```

```text
Si quieres borrar la que tienes puesta:
   │
   ├── git switch otra; git branch -d la-actual
   └── (con -D igual: primero sal de ella)
```

---

## 2. Borrado remoto

### 2.1. La orden

```bash
git push origin --delete feature-login
git push origin :feature-login          # forma clásica
```

```text
   │
   ├── pide al REMOTO que borre su rama
   │
   ├── si la rama está protegida: el servidor rechaza
   │
   └── (aquí también hay salvaguardas en servidor:
       no borres ramas con trabajo sin integrar sin
       mirar)
```

### 2.2. Tras el borrado en el servidor

```bash
git fetch --prune            (o git fetch -p)
# o: git remote prune origin
```

```text
   │
   ├── tu local sigue conservando refs/remotes/…
   │   «fantasma» (origin/feature-login parece existir)
   │
   ├── --prune elimina esas referencias obsoletas
   │
   └── efecto visible: git branch -a queda limpio
```

```bash
git config fetch.prune true   # siempre, en config
```

---

## 3. Limpieza de ramas obsoletas

### 3.1. Inventario ordenado

```text
Preguntas de limpieza
──────────────────────────────────────────────
1. ¿está integrada?      git log main..rama --oneline
2. ¿tiene pareja remota? git branch -vv
3. ¿alguien más la usa?  (equipo: preguntar/PR cerrado)
4. ¿es mía de pruebas?   bórrala (-d o -D si hace falta)
```

### 3.2. Visualizar lo no integrado

```bash
git branch --no-merged main     # solo las que aportan
git branch --merged main        # las listas para -d
```

### 3.3. Guion de limpieza básica (ejemplo conservador)

```bash
git fetch --prune
git branch --merged main | Where-Object { $_ -notmatch 'main|master|release' } |
  ForEach-Object { git branch -d $_.Trim() }
```

```text
Reglas de seguridad para automatizar:
   │
   ├── NUNCA incluir -D
   ├── excluir main/ramas de release/personales
   └── probar primero en el modo «listar»
```

---

## 4. Errores comunes con diagnóstico completo

### Error 1: «not fully merged» al usar -d

**Qué ocurrió:** `-d` se negó a borrar.

**Por qué:** la rama tiene commits que no están en HEAD (lo revisas tú ahora).

**Cómo comprobarlo:** mensaje de Git (muestra los commits) y `git log HEAD..rama --oneline`.

**Opciones:**
* integrar: merge (o PR) y reintentar `-d`;
* tirar: `-D` con conocimiento (reflog como red);
* si son WIP que quieres conservar en otra parte: cherry-pick a otra rama antes.

**Riesgos:** con -D, perder referencia de trabajo (temporalmente).

**Solución:** decidir: integrar o tirar — nunca «ya la borro y ya».

**Cómo se evita:** revisar `log a..b` como paso previo (punto 1.2).

---

### Error 2: Borrar la rama activa

**Qué ocurrió:** «Cannot delete branch 'main' checked out» (o la actual).

**Por qué:** HEAD apunta ahí.

**Cómo comprobarlo:** `git status`.

**Opciones:** cambiar a otra rama y reintentar.

**Riesgos:** ninguno (Git lo impide).

**Solución:** switch antes.

**Cómo se evita:** rutina: `switch main` al cerrar tarea → `-d`.

---

### Error 3: Borro la remota y mi local «la sigue viendo»

**Qué ocurrió:** `push --delete` ok, pero `git branch -a` aún la muestra (y switch a ella falla o crea algo raro).

**Por qué:** falta `--prune`.

**Cómo comprobarlo:** `git branch -a` vs. GitHub.

**Opciones:** `git fetch --prune` (o activar `fetch.prune`).

**Riesgos:** confusión, errores en guiones.

**Solución:** pruner es parte del borrado remoto.

**Cómo se evita:** config `fetch.prune=true`.

---

### Error 4: Borrar rama con trabajo del equipo (remota compartida)

**Qué ocurrió:** borras origin/feature de alguien y le arrancas su referencia publicada (su push fallará o se confunde).

**Por qué:** -D remoto sin avisar.

**Cómo comprobarlo:** PR abierto, avisos de equipo.

**Opciones:** coordinar; si se borró: la persona puede volver a hacer push con su local (su rama local sigue con el trabajo) — el daño suele ser recuperable, pero molesto.

**Riesgos:** fricción, CI roto si referenciaba la rama.

**Solución:** borrado remoto = acto de equipo.

**Cómo se evita:** borrar SOLO tus ramas y las cerradas por política.

---

### Error 5: Creer que borrar rama borra su trabajo del historial

**Qué ocurrió:** miedo a que `main` deje de contener lo integrado al borrar la rama de tarea.

**Por qué:** confusión rama vs. contenido.

**Cómo comprobarlo:** `git log main` antes/después (idéntico).

**Opciones:** ninguna: el contenido vive en los commits de main.

**Riesgos:** inhibición innecesaria.

**Solución:** rama = nombre; contenido = objetos/commits.

**Cómo se evita:** capítulo 01 de esta sección.

---

### Error 6: «La borro mañana»… y cincuenta ramas muertas

**Qué ocurrió:** repos con 50 ramas, mitad sin vida.

**Por qué:** sin rutina de cierre.

**Cómo comprobarlo:** `git branch -a`; GitHub sin filtro.

**Opciones:** rituales: al cerrar PR (borrar con opción de GitHub), al terminar tarea local, pruner activado.

**Riesgos:** desorientación del equipo.

**Solución:** limpieza en el flujo, no «un día».

**Cómo se evita:** checklist de cierre de tarea: integrado → push → borrar (local y remota).

---

## 5. Práctica guiada

### Objetivo

Practicar el borrado seguro, el forzado consciente y la limpieza remota.

### Paso 1: rama integrada (borrado seguro)

```bash
git switch main
git switch -c borrable
echo hola >> demo-borrado.md
git add demo-borrado.md && git commit -m "Demo borrable"
git switch main
git merge borrable
git log main..borrable --oneline    # vacío
git branch -d borrable              # ¡fuera!
```

### Paso 2: rama NO integrada (-d se niega)

```bash
git switch -c resistente main
# un commit
git switch main
git branch -d resistente            # ERROR esperado
git log main..resistente --oneline  # ¿qué pierdes?
git branch -D resistente            # fuerza (con
                                    # conocimiento)
git reflog | Select-String resistente  # aún aparece
```

### Paso 3: varias y activa

```bash
git switch -c x1 main
git switch -c x2 main
git branch -d x1 x2
git branch -d main                  # se niega (activa)
git switch x1 2>$null; git branch -d main 2>$null
# (en la práctica: no borres main; solo observa la
# negativa si la provocas con otra activa)
```

### Paso 4: inventario

```bash
git branch --merged main
git branch --no-merged main
git branch -vv
```

1. Clasifica: ¿cuáles están listas para `-d`?

### Paso 5: remoto (si tienes repositorio propio)

```bash
# crea y publica una rama de prueba
git switch -c remota-borrable
git push -u origin remota-borrable
# bórrala allí
git push origin --delete remota-borrable
git fetch --prune
git branch -a                        # desapareció
```

### Paso 6: pruner permanente

```bash
git config fetch.prune true
git config --get fetch.prune
```

### Resultado Esperado

Criterio para borrar sin perder trabajo y rutina de limpieza local + remota con pruner.

### Conclusión esperada

Borrar rama es cerrar la tarea: seguro por defecto (`-d`), forzado con conocimiento (`-D`), remoto con coordinación y pruner como mantenimiento automático.

---

## 6. Nivel profesional + resumen

### 6.1. Políticas de limpieza en equipo

```text
   │
   ├── GitHub: «automatically delete head branches»
   │   en la configuración del repo (PR fusionado ⇒
   │   rama remota borrada sola)
   │
   ├── ramas locales: cada quien limpia las suyas
   │
   ├── guiones de equipo: listar + -d (nunca -D en
   │   automático)
   │
   └── ramas protegidas/semanal de release: no se
       tocan por convención
```

### 6.2. Cuando el borrado NO es suficiente

```text
   │
   ├── trabajo en rama abandonada que SÍ conviene
   │   rescatar → cherry-pick (sección 15) o PR tardío
   │
   ├── rama vieja con secretos → el borrado NO borra
   │   historia (habría que reescribir con equipo +
   │   rotar credibles) — sección 11/26
   │
   └── repo enorme con basura → política de LFS/
       limpieza coordinada, jamás unilateral
```

### 6.3. Resumen

En este capítulo aprendiste que:

* `-d` borra solo si está integrada (con salvaguarda); `-D` fuerza y deja commits huérfanos en reflog;
* verifica con `git log <destino>..<rama>` (vacío = integrada) y `--merged/--no-merged`;
* el borrado remoto es `push origin --delete <rama>` (o `:rama`) y exige `fetch --prune` para limpiar referencias locales (mejor: `fetch.prune=true`);
* los errores típicos (no integrada, rama activa, pruner olvidado, ramas ajenas, miedos infundados, acumulación) se resuelven con el inventario y la rutina de cierre de tarea;
* a nivel profesional: auto-borrado de ramas en GitHub tras PR, guiones conservadores y saber que borrar nombre ≠ borrar historia.

La idea principal es:

> **Integrada: bórrala sin miedo (−d). No integrada: decide con el log en la mano — o −D con los ojos abiertos.**

---

## Próximo paso

Ya dominas las ramas locales.

Ahora conecta ese mundo con el remoto: ramas remotas y cómo Git las representa.

Continúa con:

[`09-ramas-remotas.md`](09-ramas-remotas.md)
