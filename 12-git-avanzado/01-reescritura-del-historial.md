# Reescritura del historial

## Introducción

Hasta ahora el historial ha sido de sólo lectura salvo para operaciones puntuales (`revert`, `reset` con sus límites). Pero existe un momento legítimo en que quieres cambiarlo: el commit malo que todavía no ha visto nadie.

Reescribir historial es el acto de crear commits diferentes a los que ya existen. Es potente, es rutina en el trabajo privado y es peligroso en cuanto el historial está compartido. Este capítulo enseña a decidir cuándo, qué herramienta usar y cómo no romper a nadie.

En este capítulo aprenderás:

* la regla de oro: local vs. compartido;
* `git commit --amend` para mensajes y cambios recientes;
* rehacer commits con `reset --soft`/`--mixed`;
* `rebase -i` como editor de la serie;
* herramientas de reescritura masiva (filter-repo y por qué NO filter-branch);
* cómo reparar después de un empuje reescrito (force-with-lease);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

## Mapa conceptual de este capítulo

```mermaid
mindmap
  root((Reescritura del historial))
    1. La regla de oro
      local casi todo vale
      compartido nada sin coordinar
    2. amend el commit reciente
    3. rehacer con reset la serie
    4. rebase -i el editor de historia
    5. reescritura masiva secrets, archivos
    6. reparar el remoto force-with-lease
    7. Errores comunes con diagnóstico completo
    8. Práctica guiada
    9. Nivel profesional + resumen

---
## 1. La regla de oro

```text
¿El commit es LOCAL (nadie más lo tiene)?
    │
    ├── SÍ → puedes reescribir: amend, reset, rebase -i
    │
    └── NO (ya se empujó y otros trabajan encima)
             → NO reescribir: usa revert (sección 02
               de la sección 11) o un commit nuevo de
               corrección
```

```text
Señales de «ya no es local»:
    │
    ├── git status -sb muestra la rama publicada
    │
    ├── el PR está en revisión y otros han comentado
    │
    └── la rama es de releases o de equipo
```

```text
Por qué la regla existe:
    │
    ├── los hashes cambian: los commits «viejos» dejan
    │   de existir para quien los tenía
    │
    └── quien rebasea encima y luego hace push fuerza
        el trabajo ajeno (punto 6)
```

---

## 2. `git commit --amend`

```bash
git commit --amend              # cambiar mensaje y/o
                                # añadir lo staged
git commit --amend --no-edit    # cambiar contenido,
                                # mismo mensaje
```

```text
Casos típicos:
    │
    ├── mensaje con errata o poco claro
    │
    ├── se olvidó un archivo en el commit (staged y
    │   amend)
    │
    └── commiteaste algo que no debía (usa amend solo
        si el commit NO se publicó)
```

```bash
# ejemplo: añadir el archivo olvidado
git add informe.md
git commit --amend --no-edit
git log -1 --stat
```

```text
Efecto:
    │
    ├── el commit VIEJO deja de estar en la rama
    │   (queda solo en reflog)
    │
    └── el nuevo toma su lugar con hash nuevo
```

---

## 3. Rehacer con `reset`

```text
Últimos 3 commits, quieres conservar solo el cambio
del primero y desmontar los otros dos sin perder
trabajo:

A ── B ── C      →   A
  ▲                      ▲
  HEAD                   HEAD (tras reset A)
```

```bash
# plana: los últimos 5 en uno solo (sin perder nada):
git reset --soft HEAD~5
git commit -m "unificación con mensaje nuevo"
```

```text
Cuándo elegir:
    │
    ├── --soft: voy a recommitear YA (quiero que todo
    │   esté staged)
    │
    ├── --mixed: quiero volver a preparar a mano
    │
    ├── --hard: descartar (evitar; solo con certeza y
        tras stash)
    └── (note: --hard is dangerous; see ⚠️ RIESGO below)
```

---

## 4. `rebase -i`: el editor de historia

```bash
git rebase -i HEAD~4       # editar los últimos 4
```

```text
Se abre el editor con la serie (más antiguo arriba):

pick   a1b2c34 añade informe
squash d4e5f67 fix typo        ← unir al anterior
reword 9a8b7c6 mensaje nuevo
drop   0f1e2d3 borrador        ← eliminar
edit   1122334 pausar aquí

Acciones: pick, reword, edit, squash, fixup, drop,
exec (ejecutar comando en cada paso), break
```

```text
El proceso (después de guardar y cerrar):
    │
    ├── Git re-aplica la serie → posibles conflictos
    │   (método de la sección 06 de la sección 10)
    ├── con edit: estás «pausado» → amendas y
    │   git rebase --continue
    └── al final: historial nuevo, hashes nuevos
```

```bash
# alias útil (opcional):
git config --global alias.hist "log --oneline --graph --decorate"
```

---

## 5. Reescritura masiva (secrets, archivos enormes)

```text
Escenario: subiste un archivo gigante o un secreto a
algunos commits de la rama.
```

```bash
# opción recomendada: git filter-repo (herramienta
# externa, moderna; instálala según su documentación)
# ejemplo conceptual de limpieza de un patrón:
git filter-repo --invert-paths --path cache.tmp
```

```text
    │
    ├── filter-branch (antiguo): existe pero es lento,
    │   propenso a errores y desaconsejado por la
    │   propia documentación de Git → no lo uses
    │
    ├── filter-repo: reemplazo moderno y rápido
    │
    └── si era un SECRETO: reescribir no basta
        (sección 20 de seguridad): ROTAR la credencial
        primero, después limpiar historial, después
        verificar con el escaneo correspondiente
```

```bash
# ¿quién tiene aún lo viejo?
# → todos los que clonaron antes: deben clonar de
#   nuevo o re-escribir su copia (coordinar)
```

---

## 6. Reparar el remoto: `--force-with-lease`

```bash
# reescritura ya hecha en local sobre rama publicada:
git push --force-with-lease origin mi-rama
```

```text
Diferencia crucial:
    │
    ├── push --force            → destruye lo que haya
    │   en el remoto SIN preguntar (peligroso)
    │
    └── push --force-with-lease → falla si alguien más
        empujó desde tu último fetch (no pisas trabajo
        ajeno sin saberlo)
```

```bash
# flujo de reparación:
git fetch origin
git log origin/mi-rama --oneline -n 5   # ¿ha movido otro?
# si tú necesitas reescribir:
git push --force-with-lease origin mi-rama
# avisa al equipo: refresquen su copia
```

---

## 7. Errores comunes con diagnóstico completo

### Error 1: `--amend` sobre un commit ya empujado

**Qué ocurrió:** el push posterior fue rechazado (non-fast-forward) o alguien empujó encima y ahora hay divergencia.

**Por qué posibles:**
* amend de un commit que ya estaba en el remoto;
* no se consultó `git status -sb`.

**Cómo comprobarlo:** `git log origin/rama --oneline` vs. local; el hash antiguo ya no coincide.

**Opciones:**
* si nadie trabajó encima: `push --force-with-lease`;
* si hay trabajo ajeno: revert del cambio + commit nuevo (nunca pisar).

**Riesgos:** perder commits de otros (con force puro).

**Solución:** regla del punto 1 + lease.

**Cómo se evita:** amend solo en la terminal donde nació el commit, antes del primer push.

---

### Error 2: rebase -i y «me salté» un commit

**Qué ocurrió:** tras el rebase faltan cambios (o un commit entero).

**Por qué posibles:**
* `drop` o `skip` usado sin revisar;
* resolución de conflicto que dejó un lado fuera.

**Cómo comprobarlo:** `git reflog` (antes/después), `git log -p` de la zona.

**Opciones:** `git reflog` → `git reset --hard HEAD@{n}` al estado previo al rebase (la red de seguridad existe); rehacer con calma.

**Riesgos:** trabajo aparentemente perdido (no lo está: reflog guarda hasta ~90 días por defecto).

**Solución:** siempre mirar el plan (`rebase -i` abre el editor: léelo entero antes de guardar).

**Cómo se evita:** no usar `drop` a ciegas; practicar en repos de prueba.

---

### Error 3: fuerza bruta en rama compartida

**Qué ocurrió:** `push --force` borró los commits de un compañero.

**Por qué:** sin lease y sin avisar.

**Cómo comprobarlo:** en el remoto, los commits de la otra persona desaparecieron de la rama; en su local, `status -sb` muestra divergencia.

**Opciones:**
* recuperar desde el local de la persona (commits aún existen allí) y re-subirlos;
* reconstruir con cherry-pick de sus hashes.

**Riesgos:** pérdida y pérdida de confianza.

**Solución:** `--force-with-lease` como mínimo; mejor: no reescribir ramas de otros.

**Cómo se evita:** política de equipo (sección 17).

---

### Error 4: reescritura masiva sin avisar al equipo

**Qué ocurrió:** filter-repo limpio en local; cinco personas con clones «envenenados» a medias.

**Por qué:** no se planificó la propagación.

**Cómo comprobarlo:** los clones antiguos aún contienen el archivo/secreto.

**Opciones:** todos deben clonar de nuevo (o re-escribir su copia); coordinar ventana de mantenimiento.

**Riesgos:** el problema reaparece al primer merge desde un clone viejo.

**Solución:** plan de re-sincronización escrito ANTES de ejecutar.

**Cómo se evita:** prevenir (revisar antes de subir; secret scanning — sección 20).

---

### Error 5: usar `reset --hard` en la reescritura «por si acaso»

**Qué ocurrió:** junto con la limpieza se descartaron cambios sin commitear.

**Por qué:** se mezcló «rehacer historial» con «limpiar carpeta».

**Cómo comprobarlo:** `git status` previo mostraba modificaciones; ahora no hay rastro.

**Opciones:** recuperar solo lo que se pueda (editor, backups); diagnóstico honesto.

**Riesgos:** pérdida de trabajo no relacionado.

**Solución:** una operación a la vez: stash de seguridad antes de cualquier `--hard`.

**Cómo se evita:** checklist: carpeta limpia → reescribir → verificar.

---

### Error 6: esperar que `revert` sea «más rápido» cuando toca reescribir (o al revés)

**Qué ocurrió:** se reescribió una rama de release (mal) o se acumularon veinte commits revert en rama privada (innecesario).

**Por qué:** no se aplicó el criterio local/compartido.

**Cómo comprobarlo:** estado del remoto y política del equipo.

**Opciones:** decidir con la tabla del punto 1; documentar la elección en el PR.

**Riesgos:** historial confuso o trabajo perdido.

**Solución:** criterio explícito, no costumbre.

**Cómo se evita:** preguntar «¿quién lo tiene?» antes de «¿qué comando?».

---

## 8. Práctica guiada

### Objetivo

Reescribir en local con seguridad (amend, reset, rebase -i) y practicar la reparación con lease.

### Paso 1: laboratorio

```bash
git init rew && cd rew
echo a > f.txt && git add . && git commit -m "A"
echo b >> f.txt && git add . && git commit -m "B"
echo c >> f.txt && git add . && git commit -m "C"
git log --oneline
```

### Paso 2: amend

```bash
git commit --amend -m "A: versión inicial del fichero"
git log --oneline -n 1     # hash nuevo, mensaje nuevo
```

### Paso 3: desmontar con reset

```bash
git reset --soft HEAD~2    # B y C desmontados, cambios
                            # staged
git status                 # todo preparado
git commit -m "B+C unidos"
git log --oneline          # historia plana nueva
```

### Paso 4: rebase -i

```bash
echo d >> f.txt && git add . && git commit -m "D"
echo e >> f.txt && git add . && git commit -m "E"
git rebase -i HEAD~2
# en el editor: reword D, fixup E → guarda
git log --oneline
```

### Paso 5: recuperación con reflog

```bash
git reflog | Select-String -Pattern 'rebase'   # o grep
git reset --hard HEAD@{1}    # (elige el punto previo
                              # correcto según tu reflog)
git log --oneline            # historia restaurada
```

### Paso 6: simulación de lease

```bash
git remote add origin <ruta-a-otro-clon-local>   # o usa
# un segundo clon si lo tienes
git push -u origin master   # (rama inicial por defecto)
git commit --amend --no-edit
git push origin master          # rechazado
git push --force-with-lease     # aceptado si nadie más
                                # movió el remoto
```

### Resultado esperado

Historial reescrito en local, recuperado con reflog cuando hizo falta y remoto actualizado sin pisar trabajo ajeno.

### Conclusión esperada

Reescribir es rutina local y coordinación global: la herramienta es fácil, el criterio es lo que protege.

---

## 9. Nivel profesional + resumen

### 9.1. Políticas de reescritura

```text
Equipo profesional típico:
    │
    ├── ramas privadas: reescritura libre (amend,
    │   rebase -i) antes de abrir PR
    │
    ├── rama de PR en revisión: cerrar cambios con
    │   commits nuevos; reescribir solo con aviso y
    │   lease
    │
    ├── main/release: NUNCA reescribir → revert
    │
    └── incidente con secreto: rotar credencial →
        plan de reescritura + aviso + verificación
```

### 9.2. Higiene de historia

```text
    │
    ├── «WIP», «fix typo» aislados: agrupar antes del
    │   PR (squash/fixup)
    │
    ├── mensajes que explican el porqué sobreviven a
    │   cualquier reescritura posterior
    │
    └── CI y hooks (sección siguiente) verifican ANTES
        de que la historia viaje
```

### 9.3. Resumen

En este capítulo aprendiste que:

* la regla de oro: reescribir solo historial local; lo compartido se corrige con `revert` o commits nuevos;
* `amend` cambia el commit reciente; `reset --soft/--mixed` desmonta serie sin perder trabajo; `rebase -i` edita, une, reordena y borra de la serie;
* la reescritura masiva usa `filter-repo` (no `filter-branch`) y, si hay secretos, exige rotación primero;
* el remoto se repara con `push --force-with-lease`, nunca con force ciego sobre ramas de otros;
* los errores típicos (amend publicado, drops perdidos, force destructivo, propagación sin avisar, --hard mezclado, criterio invertido) se previenen con el checklist local/compartido;
* a nivel profesional: política explícita por tipo de rama y higiene de historia como rutina.

La idea principal es:

> **Reescribir historia es seguro mientras sea tuyo y coordinado en cuanto deje de serlo: el hash que cambia en privado es detalle; el que cambia en equipo es una ruptura.**

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Cuándo es aceptable reescribir un commit con `amend` y cuándo está prohibido?
2. ¿Cómo afecta `reset --soft` al índice y al árbol de trabajo comparado con `reset --mixed`?
3. ¿Qué ventaja tiene `rebase -i` sobre `reset --hard` para reescribir una serie de commits?
4. ¿Por qué es peligroso usar `push --force` en una rama compartida y cómo mitiga `--force-with-lease` ese riesgo?
5. ¿En qué situaciones sería apropiado usar `git filter-repo` y qué precauciones deben tomarse si hay secrets involucrados?
6. ¿Cómo puedes recuperar un commit que parece haber desaparecido tras un rebase interactivo?
7. ¿Qué política de equipo sería adecuada para decidir cuándo reescribir historial en una rama de release?
8. ¿Cómo afecta la regla local/compartido a la elección entre `amend`, `reset` y `rebase -i`?

---

## Ejercicio de transferencia

Crea un repositorio de práctica con al menos cinco commits. Usa `git reset --mixed` para desmontar los últimos tres commits, prepara los cambios para un nuevo commit y verifica que el historial se haya reescrito correctamente sin perder trabajo.

## Próximo paso

Ya sabes cuándo y cómo cambiar la historia.

Ahora la herramienta de precisión para editarla: el rebase interactivo, en profundidad.

Continúa con:

[`02-rebase-interactivo.md`](02-rebase-interactivo.md)