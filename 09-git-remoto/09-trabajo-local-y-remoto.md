# Trabajo local y remoto

## Introducción

El capítulo final de la sección ensambla todo: el ciclo completo de trabajo distribuido, desde que abres la terminal hasta que tu rama está integrada en el servidor. Aquí conviven las zonas (carpeta, índice, historial), las referencias (ramas, fotos, upstreams) y las órdenes de red (clone, fetch, pull, push) en UN flujo coherente.

Si has seguido el recorrido, ya conoces cada pieza; este capítulo es la coreografía: la rutina diaria de una persona, la de un equipo con PRs, los estados intermedios (ahead/behind/divergida) y cómo diagnosticar cualquier desajuste con el mapa completo.

En este capítulo aprenderás:

* el ciclo local ↔ remoto en un solo diagrama;
* la rutina diaria individual y la de equipo (PR);
* leer y resolver los estados de sincronización;
* el orden de comandos seguro (la receta anti-pérdidas);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Trabajo local y remoto
       │
       ├── 1. El ciclo completo (diagrama maestro)
   │
       ├── 2. La rutina diaria
   │        ├── solo (local → push)
   │        └── equipo (rama → PR → merge → pull)
   │
       ├── 3. Estados de sincronización
   │        ├── ahead / behind / divergida / al día
   │        └── cómo leerlos y resolverlos
   │
       ├── 4. El orden seguro de comandos
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada (día completo simulado)
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. El ciclo completo (diagrama maestro)

```text
                    [ SERVIDOR ]
                (origin / upstream)
                 ▲              │
        push     │              │ fetch / pull
                 │              ▼
   ┌─────────────┴───────────────────────────────────┐
   │  TUS FOTOS          refs/remotes/origin/*       │
   │  (lo último que vi del servidor)                │
   └─────────────────────┬───────────────────────────┘
                         │ (pull integra en tu rama)
                         ▼
   ┌─────────────────────────────────────────────────┐
   │  RAMAS LOCALES     refs/heads/*  (+ upstream)   │
   │  HEAD → rama → commit                            │
   │      ▲                                           │
   │      │ commit                                    │
   │  ┌───┴──────────────────┐                        │
   │  │ ÍNDICE (staging)     │◄── add                 │
   │  └───┬──────────────────┘                        │
   │      ▲                                           │
   │      │ (restore)                                 │
   │  ┌───┴──────────────────┐                        │
   │  │ DIRECTORIO DE TRABAJO│  ← tú editas           │
   │  └──────────────────────┘                        │
   └─────────────────────────────────────────────────┘

Regla de oro del ciclo:
   │
   ├── bajar:   fetch (ver) / pull (ver+integrar)
   ├── producir: editar → add → commit  (local, local)
   ├── subir:   push (con -u la primera vez)
   └── integrar: tú (merge local) o servidor (PR)
```

---

## 2. La rutina diaria

### 2.1. Persona que trabaja sola (o en repo sin PR)

```bash
# AL EMPEZAR
git status
git switch main && git pull
git switch -c tarea-actual            # (si es nueva)

# DURANTE
git add -p <archivo>                  # quirúrgico
git diff --staged
git commit -m "Tema: …"
git push                              # respaldo/visibilidad

# AL TERMINAR
git switch main && git pull
git merge tarea-actual                # (o ff-only)
git push
git branch -d tarea-actual
```

### 2.2. Equipo con Pull Requests (GitHub)

```bash
# EMPEZAR
git fetch --prune
git switch main && git pull           # base fresca
git switch -c fix-tema                # desde main vivo

# TRABAJAR
# … commits pequeños …
git push -u origin fix-tema

# EN LA WEB
# → abrir PR (base: main) → revisiones/checks
# → más commits si hace falta (push en la misma rama)

# DESPUÉS DEL MERGE (en la web)
git switch main && git pull           # baja el merge
git branch -d fix-tema
git push origin --delete fix-tema     # (o auto-borrado)
git fetch --prune
```

### 2.3. Frecuencia recomendada

```text
Momento                       Acción
──────────────────────────────────────────────────────
al sentarte                   status + pull (o fetch)
cada tema cerrado             commit (+ push si toca)
antes de cerrar jornada       push (y main al día)
antes de PR                   fetch + grafo + diff --check
```

---

## 3. Estados de sincronización

### 3.1. El vocabulario

```text
Estado        Significado                       Acción típica
──────────────────────────────────────────────────────────────
al día        local == pareja                    seguir
adelante      commits sin subir                  push
atrás         hay nuevos allí                    pull
divergida     ambos (ambos avanzaron)            pull (integrar)
sin pareja    no hay upstream                    push -u / config
```

### 3.2. Cómo leerlo

```bash
git status                     # frases + números
git branch -vv                 # por rama
git log @{upstream}..HEAD --oneline    # adelante (lista)
git log HEAD..@{upstream} --oneline    # atrás (lista)
git log --graph --oneline --decorate --all -n 15
```

### 3.3. Resolver cada estado

```text
Estado        Cómo se resuelve
──────────────────────────────────────────────────────
adelante      git push
atrás         git pull (limpio)
divergida     git pull → (conflicto: método sección 10)
              → push
sin pareja    git push -u origin <rama>
config rara   revisar branch -vv / remote -v
```

---

## 4. El orden seguro de comandos

```text
LA RECETA ANTI-PÉRDIDAS (apréndete de memoria)
──────────────────────────────────────────────────────
1. git status          ¿dónde estoy y qué llevo?
2. git pull            (o fetch + mirar) antes de
                       producir cambios importantes
3. …trabajar…          add → diff → commit (temas)
4. git log a..b        ¿qué voy a subir?
5. git push            subir (respaldo)
6. integrar            tú (merge) o PR (servidor)
7. limpiar             borrar rama + prune
```

```text
Prohibiciones cotidianas (sin emergencia real):
   │
   ├── push --force en ramas compartidas
   ├── restore/checkout -- sin haber visto el diff
   ├── reset --hard con trabajo sin respaldar
   └── trabajar en main (si el equipo usa ramas)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «¿Por qué mi compañero no ve mi trabajo?»

**Qué ocurrió:** commiteaste (y hasta creíste que «ya está»), pero nada aparece en el servidor.

**Por qué posibles:**
* no hubo push;
* push a otra rama;
* push a otro remote (fork vs. oficial).

**Cómo comprobarlo:** `status` (adelante de origin/…), `remote -v`, eventos en la plataforma.

**Opciones:** push correcto (rama + remote).

**Riesgos:** retrabajo si se descubre tarde.

**Solución:** rutina de push al cerrar temas.

**Cómo se evita:** frecuencia del punto 2.3.

---

### Error 2: «Trabajé semanas y ahora todo conflicta»

**Qué ocurrió:** rama larga sin integrar; al volver a main, conflictos enormes.

**Por qué:** falta de sincronización (pull periódico) y vida de rama excesiva.

**Cómo comprobarlo:** `git log main..mi-rama --oneline` (cientos de cambios); grafo.

**Opciones:**
* traer main a la rama frecuentemente (merge main→rama) y continuar;
* dividir la rama en PRs más pequeños;
* en casos extremos: replantear en ramas cortas desde la base actual.

**Riesgos:** un solo «megamerge» final (mortal para la revisión).

**Solución:** integrar a diario.

**Cómo se evita:** disciplina de ramas cortas (sección 08).

---

### Error 3: Mezclar ramas personales y compartidas (rebase ajenos)

**Qué ocurrió:** se reescribió una rama que otra persona usaba → su push rechazado, su mundo roto.

**Por qué:** política de rebase/force inexistente.

**Cómo comprobarlo:** reflogs; reflog del servidor; conversación.

**Opciones:** recuperar desde fotos locales de los afectados; re-publicar la rama en su estado correcto (coordinado).

**Riesgos:** pérdida temporal y confianza.

**Solución:** regla: lo compartido no se reescribe; lo propio, con lease.

**Cómo se evita:** documentarlo en CONTRIBUTING.

---

### Error 4: Pull en medio de conflicto de otra operación

**Qué ocurrió:** «another git process seems to be running» / merge/rebase en curso.

**Por qué:** se intentó operar con estado pendiente (o se cayó el proceso).

**Cómo comprobarlo:** `git status` (lo dice); locks en `.git` (`index.lock`).

**Opciones:**
* concluir o abortar lo que estaba (merge --abort, rebase --abort);
* si quedó lock huérfano por caída: eliminar SOLO tras confirmar que no hay proceso Git vivo.

**Riesgos:** borrar lock en caliente (poco probable pero evitable).

**Solución:** una operación a la vez.

**Cómo se evita:** leer status antes de cada orden.

---

### Error 5: Fotografía vieja (diagnosticar sin fetch)

**Qué ocurrió:** se juzgó el estado del equipo con `origin/*` sin refrescar: conclusiones falsas («ya subieron», «no subieron»).

**Por qué:** diagnóstico sin fetch.

**Cómo comprobarlo:** `ls-remote --heads origin` vs. tus fotos.

**Opciones:** fetch + repetir diagnóstico.

**Riesgos:** decisiones sobre datos caducos.

**Solución:** fetch es paso cero.

**Cómo se evita:** hábito (capítulo 04 de esta sección).

---

### Error 6: Pérdida de trabajo «entre ramas»

**Qué ocurrió:** un cambio sucio viajó arrastrado, se pisó con restore o se perdió en un switch -f.

**Por qué:** zona gris de lo no commiteado.

**Cómo comprobarlo:** `status` en todas las ramas; reflog (si había objetos); editor (historial local).

**Opciones:** recuperar lo posible; si era stash olvidado: `git stash list`.

**Riesgos:** pérdida.

**Solución:** commit frecuente (WIP si hace falta) — lo commiteado es intocable.

**Cómo se evita:** «commitea o stashéa antes de danzar».

---

## 6. Práctica guiada (día completo simulado)

### Objetivo

Simular una jornada real de trabajo distribuido con dos clonos (o espejo local).

### Escenario

Tú (A) y compañera (B) trabajáis en el mismo repo.

### Paso 1: mañana — ambos se ponen al día

```bash
# A y B:
git status && git fetch --prune && git pull
```

### Paso 2: A trabaja en una tarea

```bash
# A:
git switch main && git pull
git switch -c fix-informe
# editar, add, diff --staged, commit x2
git push -u origin fix-informe
```

### Paso 3: B trabaja en paralelo

```bash
# B:
git switch main && git pull
git switch -c docs-entrada
# commit en archivos distintos
git push -u origin docs-entrada
```

### Paso 4: integración (equipo con PR o directa)

```bash
# Opción PR (web): A abre PR fix-informe → B revisa → merge
# Opción directa (repo sin protección):
# A:
git switch main && git pull
git merge fix-informe && git push
git branch -d fix-informe && git push origin --delete fix-informe
git fetch --prune
```

### Paso 5: B se pone al día

```bash
# B:
git switch main && git pull
git log --graph --oneline -n 8        # ve la integración
```

### Paso 6: estado final

```bash
# A y B:
git status                    # al día
git branch -vv                # limpio
git branch -a                 # solo main (+ lo de B)
```

### Resultado Esperado

Haber vivido el ciclo entero: dos flujos paralelos, integración ordenada, limpieza y ambos clonos al día — sin un solo susto.

### Conclusión esperada

El trabajo local y remoto no son mundos distintos: son la misma máquina de estados con dos cables (fetch/push) y una disciplina de ritmo.

---

## 7. Nivel profesional + resumen

### 7.1. Flujos productivos de equipo

```text
Checklist de madurez
──────────────────────────────────────────────────────
✓ ramas por tarea, cortas y con nombre claro
✓ main siempre integrable (CI verde)
✓ PRs pequeños con descripción útil
✓ fetch/pull a diario; push al cerrar temas
✓ política escrita: rebase/force/merge commit
✓ limpieza: auto-borrado + prune
✓ documentación: CONTRIBUTING con el flujo exacto
```

### 7.2. Cuando algo huele mal

```text
Orden de diagnóstico integral:
   │
   1. git status / branch -vv     (dónde estoy)
   2. git remote -v               (con quién hablo)
   3. git fetch --prune           (refresco)
   4. git log --graph --all       (estructura)
   5. git log a..b                (contenido pendiente)
   6. reflog                      (qué pasó recién)
   7. ls-remote                   (verdad del servidor)
   → decisión con datos, nunca con pánico
```

### 7.3. Resumen

En este capítulo aprendiste que:

* el ciclo completo es: zonas locales (carpeta → índice → historial) + fotos (`origin/*`) + servidor, con fetch/pull bajando y push subiendo;
* la rutina diaria: status/pull al empezar, commits pequeños, push frecuente, integrar (tú o PR), limpiar al final;
* los estados de sincronización (al día, adelante, atrás, divergida) se leen con `status`, `-vv` y `log @{upstream}..HEAD`, y cada uno tiene su solución;
* el orden seguro (status → pull → trabajar → log a..b → push → integrar → limpiar) evita la práctica totalidad de pérdidas;
* los errores típicos (trabajo no visto, rama gigante, reescritura de lo compartido, operaciones mezcladas, fotos viejas, trabajo sin commitear) se previenen con ritmo y se diagnostican con el orden del punto 7.2;
* a nivel profesional: flujos maduros se miden en disciplina (ramas cortas, CI, política escrita), no en herramientas exóticas.

La idea principal es:

> **Local produce, remoto distribuye, fetch mira y push entrega — y la sincronización no es un evento, es un ritmo.**

---

## Cómo seguir

Has completado «Trabajo local y remoto»: la sección de red está entera (remote, clone, fetch, pull, push, origin, upstream y el ciclo).

Continúa con el índice de esta sección, o pasa al siguiente bloque: los conflictos —cuando las líneas de trabajo chocan de verdad—.

[`README.md`](README.md) · [`../10-git-conflictos/`](../10-git-conflictos/)
