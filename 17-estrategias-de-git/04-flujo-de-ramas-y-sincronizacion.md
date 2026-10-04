# Flujo de ramas y sincronización

## Introducción

Elegir la estrategia (capítulos 01-03) es el mapa; este capítulo es la conducción diaria: cómo mantener las ramas vivas sincronizadas con la base, qué hacer cuando divergen, cómo vivir con ramas largas cuando el trabajo lo exige y cómo integrar sin acumular deuda de conflictos.

La regla que lo resume todo: **cuanto más tiempo vive una rama, más cuesta integrarla** — y la sincronización frecuente es el interés compuesto del trabajo en equipo.

---

## Mapa conceptual de este capítulo

```text
Flujo de ramas y sincronización
       │
       ├── 1. La cuenta de la divergencia
       ├── 2. Rebase vs. merge para sincronizar
       ├── 3. Estrategias de sincronización diaria
       ├── 4. Conviviendo con ramas largas
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. La cuenta de la divergencia

```text
DIVERGENCIA = la rama deja de compartir historia
reciente con la base
```

```bash
# ¿cuánto se ha movido la base desde tu rama?
git fetch origin
git rev-list --count HEAD..origin/main   # la base
                                          # «adelantó»
git rev-list --count origin/main..HEAD   # tú «adelantaste»
```

```text
COSTE INTUITIVO (no lineal):
   │
   ├── mismo archivo tocado en ambos lados →
   │   conflicto al sincronizar
   │
   ├── 1 día → casi gratis (rebase de minutos)
   ├── 1 semana → conflicto posible, revisión ya
   │   olvidada
   └── semanas → «renovar todo el contexto» +
       revisión difícil + miedo a integrar
```

```text
   │
   └── sincronizar es barato HOY y caro MAÑANA:
       la base se mueve igual si no la miras
```

---

## 2. Rebase vs. merge para sincronizar

```text
SINCRONIZAR TU RAMA CON LA BASE
──────────────────────────────────────────────────────
OPCIÓN A — rebase (recomendada para ramas PRIVADAS):
   git fetch origin
   git rebase origin/main
   · historia lineal, commits tuyos «arriba»
   · cambia hashes → si la rama es pública:
     --force-with-lease + avisar

OPCIÓN B — merge de la base en tu rama:
   git fetch origin
   git merge origin/main
   · conserva hashes (sin fuerza)
   · añade merge commits «de sincronización»
```

```text
CUÁNDO CADA UNA:
   │
   ├── rebase → ramas personales/PR: log limpio
   ├── merge → ramas compartidas (varios autores) o
   │   ramas protegidas sin reescritura
   │
   └── NUNCA rebasear commits YA integrados de otros
       (rebase de rama ajena = caos)
```

```text
POLÍTICAS DE EQUIPO COMUNES (mención):
   │
   ├── «rebase antes de pedir revisión» (limpieza)
   ├── «merge para ramas compartidas»
   └── lo importante: escrito y consistente (sección
       15/18)
```

---

## 3. Estrategias de sincronización diaria

```text
CADENCIA SANA
──────────────────────────────────────────────────────
· empezar la mañana: pull --ff-only de la base
· al abrir PR: rebase final (punto 2A)
· rama viva > 1 día: sincronizar al menos 1 vez
· main se mueve a diario → tu rama también
```

```bash
# rutina mínima:
git fetch origin
git switch main && git pull --ff-only && git switch -
git rebase origin/main   # (rama propia) o merge
git push --force-with-lease   # si rebaseaste y ya
                              # estaba publicada
```

```text
REDUCIR CONFLICTOS DE RAÍZ:
   │
   ├── rama corta (cap. 01)
   ├── commits pequeños y no «mezcladores» (sección
   │   14 cap. 03)
   ├── evitar formato-archivos-enteros en la misma
   │   rama que cambios de lógica (sección 15 cap. 02)
   └── renombrar/mover en PRs aparte cuando el
       equipo va rápido (dime qué haces y te digo el
       conflicto)
```

```text
APILADO (stacking) para trabajo secuencial:
   │
   ├── PR1 ← PR2 ← PR3 (base encadenada)
   ├── al integrar PR1: rebase de PR2 y PR3
   └── útil cuando los cambios dependen pero
       deben revisarse por partes (sección 15)
```

---

## 4. Conviviendo con ramas largas

```text
CUÁNDO UNA RAMA ES LARGA LEGÍTIMAMENTE:
   │
   ├── spike/investigación (pero caducidad corta)
   ├── cambio enorme que NO puede partirse (raro)
   └── soporte de versión antigua (release/* de
       Git Flow, cap. 02)
```

```text
DISCIPLINA DE RAMA LARGA:
   │
   ├── sincronizar con la base al menos cada 1-2
   │   días (punto 3)
   ├── PR de borrador PRONTO (alinear diseño antes
   │   de escribir 3000 líneas)
   ├── mantener mergeable: nunca «wip permanente»
   ├── parte lo que ya está terminado (PR 1 de N)
   │   aunque la rama total siga viva
   └── fecha de caducidad: si supera X, se decide en
       la retro (partir, flag o descartar)
```

```text
   │
   └── rama larga NO es rama muerta: si nadie
       sincroniza ni revisa, es un proyecto paralelo
       con fusion pendiente
```

```text
CUANDO LA RAMA YA NO SIRVE:
   │
   ├── descartar es válido: git branch -D (con
   │   confirmación de que no hay trabajo valioso)
   └── ¿hay? → extraer lo útil a PRs pequeños
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: nunca sincronizar («ya lo hago al final»)

**Qué ocurrió:** la rama acumula 40 commits de divergencia; el «rebase final» es un proyecto.

**Por qué posibles:**
* falta de hábito;
* miedo a la fuerza.

**Cómo comprobarlo:** `git rev-list --count HEAD..origin/main`.

**Opciones:** rebase gradual (empezar hoy); si es monstruo, partir la rama antes de rebasear.

**Riesgos:** bloqueo total de integración.

**Solución:** diario/1-2 días (punto 3).

**Cómo se evita:** checklist del PR: «rebase reciente» (sección 15 cap. 02).

---

### Error 2: force push sobre rama compartida

**Qué ocurrió:** rebaseaste la rama del compañero y su trabajo local quedó «huérfano» (o se sobrescribió su push).

**Por qué posibles:**
* rama con varios autores y rebase unilateral;
* `--force` en vez de `--force-with-lease`.

**Cómo comprobarlo:** reflog remoto, historial del PR (commits desaparecidos).

**Opciones:** recuperar desde reflog/local del compañero; reconstruir; avisar y acordar política.

**Riesgos:** pérdida de trabajo y confianza.

**Solución:** rebase solo en ramas propias; `--force-with-lease`; aviso si hay más autores.

**Cómo se evita:** política escrita de ramas compartidas (punto 2).

---

### Error 3: conflictos resueltos «para desatascar» sin entender

**Qué ocurrió:** elegido «theirs» en todo; se perdió un arreglo de la base.

**Por qué:** prisa + miedo (sección 10).

**Cómo comprobarlo:** revisar la resolución con diff; ejecutar tests.

**Opciones:** rehacer la resolución (rebase --abort y otra pasada); pedir mirada a quien conoce ambos lados.

**Riesgos:** silencio roto: el código «compila» pero olvidó lógica.

**Solución:** resolución consciente (sección 10) + tests del área.

**Cómo se evita:** conflictos poco frecuentes (sincronizar) para que cada uno se resuelva con calma.

---

### Error 4: «mi rama no se puede tocar hasta que esté perfecta»

**Qué ocurrió:** perfeccionamiento local durante semanas; nadie ha visto el código; al final, rechazo total.

**Por qué posibles:**
* perfeccionismo;
* miedo a la revisión.

**Cómo comprobarlo:** fecha de primer commit vs. fecha de PR.

**Opciones:** abrir PR de borrador YA; partir lo terminado; mostrar avances parciales.

**Riesgos:** 40 horas en dirección equivocada.

**Solución:** feedback temprano (sección 15).

**Cómo se evita:** «PRs pequeños y tempranos» como cultura.

---

### Error 5: sin política de base (¿develop? ¿main? ¿release?)

**Qué ocurrió:** unos raman desde develop, otros desde main, otros desde release → los PR pelean contra la base equivocada.

**Por qué posibles:**
* flujo mixto sin decidir (cap. 06);
* documentación vieja.

**Cómo comprobarlo:** bases de los PR abiertos; CONTRIBUTING.

**Opciones:** elegir flujo (cap. 06), escribir «rama base = X», revisar PRs abiertos.

**Riesgos:** diffs con ruido; integraciones accidentales de releases.

**Solución:** una base por tipo de trabajo, documentada.

**Cómo se evita:** plantilla de PR con base correcta (sección 15).

---

### Error 6: ramas huérfanas acumuladas

**Qué ocurrió:** 30 ramas remotas: features cerradas, experimentos muertos, alguna «temp».

**Por qué:** nadie borra (los borrados automáticos solo cubren ramas de PR mergeado).

**Cómo comprobarlo:** `git branch -r --sort=-committerdate`.

**Opciones:** borrar mergeadas/basura; cerrar PRs viejos; activar «delete branch after merge»; limpieza mensual.

**Riesgos:** confusión (¿esta rama está viva?), superficie para mal push.

**Solución:** higiene de ramas como rutina.

**Cómo se evita:** automatismos + dueño de limpieza (rotativo).

---

## 6. Práctica guiada

### Objetivo

Practicar sincronización con rebase y merge, medir divergencia y limpiar ramas.

### Paso 1: mide divergencia

```bash
git fetch origin
git rev-list --count HEAD..origin/main
git rev-list --count origin/main..HEAD
# anota ambos números en tu rama de práctica
```

### Paso 2: crea conflicto

```bash
git switch main && git switch -c conflicto-demo
echo "base" > doc.txt && git add . && git commit -m "A"
git push -u origin conflicto-demo
git switch main
echo "main" > doc.txt && git add . && git commit -m "B" && git push
git switch conflicto-demo
git merge origin/main      # conflicto
```

### Paso 3: resuelve con criterio

```bash
# abre doc.txt, elige el contenido correcto (sección 10)
git add doc.txt && git commit   # merge completado
git log --graph --oneline -5
```

### Paso 4: la misma rama con rebase

```bash
git reset --hard HEAD~1        # deshaz el merge (práctica)
git rebase origin/main         # vuelve a conflicto
# resuelve: git add doc.txt && git rebase --continue
git log --graph --oneline -5   # historia lineal
```

### Paso 5: compara

```text
   │
   ├── merge: commit de merge con contexto
   └── rebase: línea recta, hashes nuevos
   (para rama propia → rebase; compartida → merge)
```

### Paso 6: higiene

```bash
git branch -r --sort=-committerdate
# borra ramas mergeadas y basura; activa «delete
# branch after merge» si no lo está
```

### Resultado esperado

Divergencia medida, conflicto resuelto en ambos modos y ramas viejas retiradas.

### Conclusión esperada

Sincronizar es una rutina barata que evita el proyecto de «integrar al final» — rebase para lo propio, merge para lo compartido, criterio para los conflictos.

---

## 7. Nivel profesional + resumen

### 7.1. Sincronización como práctica de equipo

```text
   │
   ├── política escrita: base, rebase-vs-merge,
   │   fuerza con aviso (CONTRIBUTING)
   │
   ├── cadencia: diaria (pull) + pre-PR (rebase) +
   │   retro: «¿ramas viejas?»
   │
   ├── apilado con base encadenada para trabajo
   │   secuencial (sección 15)
   │
   ├── métricas: antigüedad de ramas abiertas,
   │   divergencia media, conflictos por PR
   │
   └── higiene automatizada: borrado post-merge +
       limpieza periódica de huérfanas
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el coste de integrar crece con la divergencia — medible con `git rev-list --count`;
* sincronizar: rebase en ramas propias (force-with-lease), merge en compartidas — nunca reescribir lo ajeno;
* la rutina diaria (pull, rebase pre-PR) y el apilado mantienen las cadenas vivas;
* las ramas largas se toleran con disciplina: sincronizar, PR temprano, partir y fecha de caducidad;
* los errores típicos (nunca sincronizar, fuerza ajena, conflictos a ciegas, rama-perfección, base ambigua, huérfanas) se previenen con política y higiene;
* a nivel profesional: política escrita y métricas de antigüedad/divergencia.

La idea principal es:

> **La rama que no se sincroniza es un préstamo con intereses: paga un poco cada día (rebase) o pagarás todo junto cuando ya no haya tiempo.**

---

## Próximo paso

Ya sabes pilotar la vida de las ramas.

Falta ordenar el horizonte: versiones, semver y ramas de release.

Continúa con:

[`05-versionado-semantico-y-release-branches.md`](05-versionado-semantico-y-release-branches.md)
