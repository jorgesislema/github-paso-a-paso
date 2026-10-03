# Conflictos en rebase

## Introducción

Rebase reimprime historial, y cuando dos versiones de un commit tocan lo mismo, se detiene y pide decisión. El conflicto en rebase se parece al de merge — mismos marcadores, mismo `add` — pero sus lados están invertidos respecto a lo que la intuición espera, y su cierre es `rebase --continue`, no `commit`.

Este capítulo es la guía especializada de esa superficie: semántica de lados invertida, ciclo de «aplicar → parar → resolver → continuar», `--skip` y `--abort`, y los errores que solo aparecen aquí.

En este capítulo aprenderás:

* por qué rebase produce conflictos (reaplicar sobre base nueva);
* la inversión de lados (HEAD = base, entrante = tu commit);
* el ciclo de resolución y sus comandos (`continue`, `skip`, `abort`, `edit`);
* conflictos en serie (varios commits, varios frentes);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Conflictos en rebase
       │
       ├── 1. Por qué ocurren (reaplicar sobre base nueva)
       │
       ├── 2. Lados invertidos (la trampa)
   │        ├── HEAD = base nueva
   │        └── >>>>>> = tu commit
   │
       ├── 3. El ciclo: aplicar → parar → resolver → continuar
   │        ├── rebase --continue
   │        ├── rebase --skip
   │        └── rebase --abort
   │
       ├── 4. Conflictos en serie
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Por qué ocurren (reaplicar sobre base nueva)

```text
Antes:
   base ── c1 ── c2 (tuyo)          rama vieja
        ── x1 ── x2 (ajeno)         rama nueva

rebase tuyo sobre nueva:
   base ── x1 ── x2 ── c1' ── c2'
                       │
                       └── al aplicar c2 sobre x2:
                           si tocan lo mismo → CONFLICTO
```

```text
Diferencia con merge:
   │
   ├── merge: TRES versiones (ancestro + dos) y un
   │   encuentro puntual
   │
   └── rebase: re-aplica CADA commit tuyo; el
       conflicto puede repetirse por commit
```

---

## 2. Lados invertidos (la trampa)

### 2.1. Quién es quién

```text
git rebase rama-x        # con tus commits por delante

En el archivo:
<<<<<<< HEAD
LO QUE HAY EN rama-x (la base sobre la que aplicas)
=======
TU COMMIT (el que se está reaplicando)
>>>>>>> abc1234 (tu mensaje)

¡INVERTIDO respecto a merge:
   · merge:     HEAD = lo tuyo
   · rebase:    HEAD = la base ajena
```

### 2.2. Verificación obligatoria

```bash
git status                    # "interactive rebase in progress"
git log -1 HEAD --oneline     # ¿es de la base?
git log -1 ORIG_HEAD          # ¿dónde estabas?
git show :2:<archivo>         # HEAD block
git show :3:<archivo>         # tu commit
```

```text
Regla mnemotécnica:
   │
   ├── «HEAD es donde CAE el commit» (la base)
   │
   └── «>>>>>>> es lo que CAE» (tu commit entrando)
```

---

## 3. El ciclo: aplicar → parar → resolver → continuar

```text
CICLO DE REBASE CON CONFLICTOS
──────────────────────────────────────────────────────
1. git rebase <base>            # empieza
2. parada por conflicto         # (mensaje: could not apply)
3. por cada archivo:
   · leer marcadores (¡con inversión!)
   · decidir + limpiar
   · git add <archivo>          # o git rm si se borra
4. git status                   # sin unmerged (y sin
                                # "nothing to rebase" raro)
5. git rebase --continue
   · aplica el commit y sigue
   · ¿siguiente conflicto? → vuelve al paso 3
6. termina: git log --graph --oneline (línea recta)
```

### 3.1. Comandos de control

```bash
git rebase --continue    # seguir (tras add de todo)
git rebase --skip        # OMITIR el commit en conflicto
                         # (¡se pierde! sólo si el cambio
                         # ya existe en la base o es
                         # redundante)
git rebase --abort       # volver al ORIG_HEAD exacto
git rebase --quit        # dejar la serie a medias
                         # (estructura rota: evitar)
```

```text
Cuándo --skip:
   │
   ├── el commit era un cherry-pick duplicado (ya está
   │   en la base)
   │
   └── NUNCA como «me da pereza resolver» (pierdes
       trabajo)
```

### 3.2. `rebase -i` con `edit`

```text
   │
   ├── con `edit` en un commit: te deja ahí «como si
   │   fallara» para dividir/amendar antes de continuar
   │
   └── `git rebase --continue` tras los cambios
       (commit --amend para modificarlo)
```

---

## 4. Conflictos en serie

```text
Serie de 4 commits, conflicto en el 2 y en el 4:
   │
   ├── aplicando c1' → ok
   ├── aplicando c2' → conflicto → resuelves → continue
   ├── aplicando c3' → ok
   ├── aplicando c4' → conflicto → resuelves → continue
   └── fin: 4 commits re-apilados sobre la base
```

```text
Estrategias para menos paradas:
   │
   ├── git rebase --continue directo con add
   │
   ├── git rerere (recuerda resoluciones repetidas;
   │   útil en ramas rebaseadas muchas veces)
   │
   └── squash/amend previos: menos commits = menos
       superficies de conflicto (a decisión del equipo)
```

```text
¿Qué pasa con el resto de la serie cuando aborto?
   │
   └── --abort restaura el estado EXACTO previo al
       rebase (ORIG_HEAD): ningún commit se pierde
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: Resolver con los lados invertidos (el clásico)

**Qué ocurrió:** se aplicó la semántica de merge y se quedó la base en vez de tu cambio (o viceversa).

**Por qué:** intuición de merge aplicada en rebase.

**Cómo comprobarlo:** `git status` («rebase in progress»); `log -1 HEAD` (base ajena).

**Opciones:**
* sin cerrar: volver a poblar el archivo con el lado correcto y `add`;
* ya cerrado: verificar el contenido del commit resultante (`git show`) y corregir (amend si no publicado; fix siguiente si ya se empujó).

**Riesgos:** tu cambio desaparece «sin avisar» del historial.

**Solución:** regla de inversión (punto 2) antes de tocar nada.

**Cómo se evita:** comprobar quién es quién SIEMPRE en rebase.

---

### Error 2: `rebase --continue` sin `add` (o con cosas raras)

**Qué ocurrió:** `continue` falla («you have unmerged paths») o advierte.

**Por qué:** quedan archivos sin marcar.

**Cómo comprobarlo:** `git status`.

**Opciones:** resolver+add y reintentar.

**Riesgos:** prisa → cerrado incompleto.

**Solución:** status vacío antes de continuar.

**Cómo se evita:** método (cap. 04).

---

### Error 3: `--skip` usado como atajo para no resolver

**Qué ocurrió:** se omitió un commit con cambios propios «para quitarse el conflicto de encima».

**Por qué:** mal entendimiento de `--skip`.

**Cómo comprobarlo:** tras el rebase, el cambio no está en la rama (`git log -p`).

**Opciones:**
* si no está publicado: volver a aplicar el cambio (re-hacer el commit, cherry-pick de reflog);
* si publicado: re-hacer y volver a subir.

**Riesgos:** pérdida de trabajo (el peor error de la sección).

**Solución:** `--skip` solo para redundantes demostrables.

**Cómo se evita:** regla mental: «omitir = borrar commit».

---

### Error 4: Abortar con trabajo sucio o perder cambios en la carpeta

**Qué ocurrió:** `--abort` (o un nuevo rebase) con archivos modificados sin add → conflictos de checkout o cambios pisados.

**Por qué:** no se puso la carpeta en orden.

**Cómo comprobarlo:** `status` antes de abortar/re-empezar.

**Opciones:** si algo se mezcló: recuperar con reflog/stash si fue a stash; si no: diagnóstico file a file.

**Riesgos:** pérdida.

**Solución:** un operador, un estado limpio.

**Cómo se evita:** status antes de cada operación estructural.

---

### Error 5: Rebase de rama ya publicada (conflicto + reescribir historial)

**Qué ocurrió:** conflicto resuelto y la rama rebaseada se empuja con `--force` sobre el remoto → historial del equipo reescrito.

**Por qué:** se rebaseó una rama compartida.

**Cómo comprobarlo:** `git status -sb` (divergencia respecto al upstream); avisos en el push.

**Opciones:**
* si es tu rama personal sin uso: push con actualización aceptable (`--force-with-lease`);
* si es rama compartida: no reescribir; usar merge;
* ya forzada: coordinar con el equipo (todos deben refrescar).

**Riesgos:** trabajo de otros perdido (capítulo 25/27 lo tratan).

**Solución:** rebase solo para historial privado.

**Cómo se evita:** política de equipo clara.

---

### Error 6: Interrumpir el rebase (terminal, crash, Ctrl+C malinterpretado)

**Qué ocurrió:** la serie quedó a medias y alguien intenta «continuar» sin saber dónde está.

**Por qué:** no se conoce el estado de pausa.

**Cómo comprobarlo:** `git status` (dice rebase en progreso); `ls .git/rebase-merge` (o `rebase-apply`).

**Opciones:**
* seguir: resolver pendientes → `--continue`;
* cancelar: `--abort` (vuelve exacto a antes);
* dejarlo: `--quit` (evitar: rompe futuras operaciones si no se limpia).

**Riesgos:** estados colgados que confunden a todos.

**Solución:** una de las tres salidas, elegida conscientemente.

**Cómo se evita:** saber qué significa cada pausa antes de tocar.

---

## 6. Práctica guiada

### Objetivo

Producir un conflicto en rebase, resolverlo con los lados correctos y concluir la serie limpia.

### Paso 1: base y dos líneas de trabajo

```bash
git switch main
echo "linea-1" > rb.md && git add rb.md && git commit -m "base: linea-1"

git switch -c rb-ajena
echo "linea-1 ajena" > rb.md && git commit -am "ajeno: toca rb.md"
# (rige la misma zona)
```

### Paso 2: tus commits encima de la base vieja

```bash
git switch -c rb-mia main
echo "mia-A" >> rb.md && git add rb.md && git commit -m "mio A"
echo "mia-B" >> rb.md && git add rb.md && git commit -m "mio B"
```

### Paso 3: rebase → conflicto

```bash
git rebase rb-ajena
git status                     # rebase in progress
git log -1 HEAD --oneline      # ¿del ajeno?
cat rb.md                      # marcadores con inversión
```

1. Anota: HEAD = lado ajeno; `>>>>>>>` = tu commit `mio A`.

### Paso 4: resolver con inversión correcta

```text
Decisión (ejemplo): conservar el texto ajeno en su
línea y añadir las líneas propias debajo (resultado:
todo lo correcto de ambos, sin marcadores).
```

```bash
# edita rb.md hasta dejarlo limpio
git diff --check
git grep -n "<<<<<<<"
git add rb.md
git rebase --continue           # puede parar en "mio B"
# repite: resolver, add, continue
```

### Paso 5: verificación final

```bash
git log --graph --oneline -n 8  # línea recta
git show HEAD --stat
cat rb.md                       # sin marcadores, contenido
                                # esperado
```

### Paso 6: salidas (ensayo)

```bash
# en un conflicto de prueba cualquiera:
git rebase --abort
git status                      # exactamente como antes
git log --oneline -n 3
```

### Resultado Esperado

Serie re-apilada con lados invertidos resueltos correctamente y sin pérdidas.

### Conclusión esperada

En rebase, el que llega es tu commit y la base manda en HEAD: comprobado eso, el resto es el método de siempre con `--continue`.

---

## 7. Nivel profesional + resumen

### 7.1. Rebase en flujos de equipo

```text
Políticas habituales
──────────────────────────────────────────────────────
· rebase + push normal: ramas PRIVADAS / no publicadas
· rama publicada: merge (o rebase con
  --force-with-lease + aviso explícito)
· PRs: preferir merge de main en la rama (o rebase
  local seguido de force-with-lease) — decisión de
  equipo, documentada
· rerere activo en ramas vivas rebaseadas con
  frecuencia
```

### 7.2. Auditoría de resolución

```text
   │
   ├── tras rebase largo: `log -p` muestrear cada
   │   commit reaplicado (¿se conservó la intención?)
   │
   ├── CI obligatorio (historial reescrito = rama
   │   «nueva»)
   │
   └── en fork workflows: up-to-date con upstream
       vía rebase suave cuando no hay conflictos
       (capítulo 30)
```

### 7.3. Resumen

En este capítulo aprendiste que:

* rebase produce conflictos al re-aplicar cada commit tuyo sobre una base nueva (posiblemente varios, en serie);
* los lados están invertidos: HEAD = base sobre la que caes, `>>>>>>>` = tu commit; verificar con `status`/`log -1` antes de decidir;
* el ciclo: resolver → `add` → `rebase --continue` (o `--skip` solo si redundante, `--abort` para volver exacto a ORIG_HEAD);
* los conflictos en serie exigen revisitar el método en cada parada; `rerere` y menos commits reducen fatiga;
* los errores típicos (inversión, continue sin add, skip destructivo, suciedad en abort, force sobre rama compartida, pausa interrumpida) tienen diagnóstico y solución concretos;
* a nivel profesional: rebase solo donde reescribir es legítimo y siempre con CI después.

La idea principal es:

> **En rebase, tu commit es el que entra y la base es HEAD: confirma el lado, resuelve con método y cierra con `--continue` — nunca saltes pasos para «quitarte el conflicto» de encima.**

---

## Próximo paso

Sabes resolver en merge y en rebase.

Ahora: cuándo y cómo CANCELAR una operación sin dañar nada.

Continúa con:

[`07-abortar-una-operacion.md`](07-abortar-una-operacion.md)
