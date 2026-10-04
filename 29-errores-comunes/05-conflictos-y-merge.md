# Conflictos y merge

## Introducción

Manual de diagnóstico, capítulo 5: **los conflictos**. Son el momento en que Git te dice «dos personas cambiaron lo mismo y no sé cuál prefieres». No son un fallo de Git ni un ataque personal: son Git deteniéndose en el punto exacto donde hace falta un criterio humano. Este capítulo convierte el conflicto en un procedimiento: leer, resolver por partes, verificar y cerrar.

---

## Mapa conceptual de este capítulo

```text
Conflictos y merge
       │
       ├── 1. Qué es realmente un conflicto
       ├── 2. Las marcas y cómo leerlas
       │   ├── 3. Resolver un conflicto (procedimiento)
       │   └── 4. Conflictos durante pull/rebase
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué es realmente un conflicto

```text
PRECONDICIÓN (sección 05/07 — repaso):
   │
   ├── dos líneas (commits) cambiaron el MISMO archivo,
   │   en regiones que Git no sabe combinar
   │
   └── Git NO elige por ti: fusionar contenido de texto
       puede perder trabajo — prefiere pararse (Error
       1 si lo ves como fallo: es una pausa
       deliberada)
```

```text
DÓNDE APARECE:
   │
   ├── durante `git merge` (Error 2: conflicto en
   │   merge normal — resolución en working tree)
   ├── durante `git pull` (Error 3: mismo mecanismo)
   └── durante `git rebase` (Error 4: conflicto
       REPETIDO por cada commit reubicado — Error 5 si
       te desanima: es el mismo conflicto visto en
       varios pasos, no diez problemas distintos)
```

```text
   │
   └── SIEMPRE: los conflictos se resuelven en el
       working tree y se cierran con un commit (o con
       `--continue` en rebase)
```

---

## 2. Las marcas y cómo leerlas

```text
ARCHIVO EN CONFLICTO:
   │
   ├── <<<<<<< HEAD
   │     tu versión (rama actual / lo que venía de
   │     tu lado)
   │   =======
   │     la versión entrante (la otra rama / incoming)
   │   >>>>>>> nombre-rama
   │
   └── en rebase, HEAD es lo que ya se aplicó y lo
       entrante es el commit que se reubica (Error 6
       si confundes los lados: relee el encabezado
       >>>>>>> — dice de qué lado es cada cosa)
```

```text
DIAGNÓSTICO RÁPIDO:
   │
   ├── `git status` → «unmerged paths» lista los
   │   archivos (Error 7 si resuelves «a ojo» sin
   │   listar: alguno se queda sin cerrar)
   ├── `git diff --name-only --diff-filter=U` → solo los
   │   en conflicto
   └── apréndete el mapa: Conflictos → status →
       resolver → add → cerrar (punto 3)
```

```text
TIPOS (Error 8 — sección 07/15):
   │
   ├── contenido: texto en el mismo sitio (el común)
   ├── adición/eliminación: un lado borró, el otro editó
   │   (Error 9: requiere decisión — borrar o
   │   conservar)
   └── rename/rebase: cambia el nombre del archivo
       (Error 10: Git pregunta con `rename`/`delete`
       — responde con criterio del flujo)
```

---

## 3. Resolver un conflicto (procedimiento)

```text
LOS 7 PASOS:
   │
   ├── 1. entender el alcance: `git status` (Error 7
   │   prevención)
   ├── 2. abrir los archivos en conflicto (uno a uno)
   ├── 3. elegir: ¿la mía, la suya, o una MEZCLA de
   │   texto? — la mezcla es lo habitual (Error 11 si
   │   eliges «todo mío» sin leer: pierdes lo ajeno)
   │
   ├── 4. eliminar TODAS las marcas (<<<<, =====, >>>>)
   │   (Error 12 si queda alguna: el commit guardará
   │   el símbolo — el revisor lo verá)
   │
   ├── 5. `git add <archivo>` por cada resuelto
   ├── 6. verificar: `git diff --check` (marcas
   │   restantes) y probar el código (Error 13 si no
   │   pruebas: un conflicto «resuelto» mal puede no
   │   compilar)
   │
   └── 7. cerrar: `git commit` (merge) o `git rebase
       --continue` (Error 14 si olvidas el paso 7: el
       repositorio queda en medio de la operación)
```

```text
SI TE EQUIVOCASTE EN EL CASO (Error 15):
   │
   ├── sin cerrar: `git merge --abort` / `git rebase
   │   --abort` → vuelves al punto de partida
   │
   └── ya cerrado y publicado: NO reescribas; corrige
       con commit nuevo (Error 16 — sección 29 cap. 02)
```

---

## 4. Conflictos durante pull/rebase

```text
PULL QUE TRAE CONFLICTO:
   │
   ├── Git pausa EN EL MERGE → trabajas en el working
   │   tree (Error 3 si crees que falló: `git status`
   │   dirá «You have unmerged paths»)
   ├── pasos 3–7 del punto 3
   └── `git commit` → merge commit listo → push
```

```text
REBASE QUE TRAE CONFLICTO:
   │
   ├── Git pausa EN CADA COMMIT problemático (Error 5
   │   punto 1: repetición esperada)
   ├── resuelves → `git add` → `git rebase --continue`
   │   (Error 17 si repites sobre el mismo conflicto:
   │   te olvidaste del `git add`)
   ├── para rendirte: `git rebase --abort` (Error 18
   │   si abandonas a medias sin abort: estado sucio
   │   heredado)
   └── recomendación profesional: rebase con base
       limpia y trabajo propio; merge en ramas
       compartidas (sección 07/15 — Error 4 prevención)
```

```text
   │
   └── la buena noticia: los conflictos de rebase
       resuelven una sola vez (con rebase --continue);
       los de merge, una sola vez (con commit) — nunca
       son eternos si sigues el procedimiento (punto 3)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: ver el conflicto como fallo de Git

**Qué ocurrió:** pánico ante «CONFLICT (content)» y abortar sin leer.

**Por qué:** expectativa errónea (punto 1).

**Cómo comprobarlo:** Git paró EN los archivos correctos — el mensaje es exacto.

**Opciones:** seguir el procedimiento de 7 pasos (punto 3).

**Riesgos:** abandonos y miedo permanente a merge.

**Solución:** conflicto = pausa con criterio humano (punto 1).

**Cómo se evita:** practicar merge/conflicto en el Proyecto 1 (sección 27 cap. 01).

---

### Error 2: mezclar lados por error

**Qué ocurrió:** se editó dejando símbolos o mezclando «mía + suya» literalmente.

**Por qué:** lectura apresurada de las marcas (punto 2).

**Cómo comprobarlo:** `git diff --check` y buscar `<<<<<<<` manualmente.

**Opciones:** corregir y volver a `git add` antes de cerrar.

**Riesgos:** código con basura de merge (funciona a veces y falla otras).

**Solución:** leer marcas con calma (punto 2).

**Cómo se evita:** `git diff --check` como paso obligatorio (punto 3 paso 6).

---

### Error 3: creer que «merge rechazado» es conflicto sin más

**Qué ocurrió:** se confundió un pull sin sincronizar (divergencia) con un conflicto real de contenido.

**Por qué:** no distinguir tipos de rechazo (sección 29 cap. 04).

**Cómo comprobarlo:** ¿aparecieron marcas `<<<<<<<`? Si no, era divergencia.

**Opciones:** divergencia → pull --rebase; contenido → punto 3.

**Riesgos:** tratamiento equivocado en bucle.

**Solución:** clasificar: divergencia vs contenido.

**Cómo se evita:** vocabulario del capítulo 04 (Error 4).

---

### Error 4: rebase en rama compartida y conflicto ajeno

**Qué ocurrió:** se rebaseó una rama que otros usaban; los conflictos aparecieron en sus máquinas.

**Por qué:** herramienta y contexto mal elegidos (punto 4).

**Cómo comprobarlo:** ¿el push posterior requirió force? Entonces reescribiste historia compartida.

**Opciones:** volver a la historia original y usar merge; coordinar el rebase con el equipo.

**Riesgos:** desincronización colectiva.

**Solución:** rebase solo privado; merge compartido (sección 07/15).

**Cómo se evita:** convención escrita de estrategias (sección 07).

---

### Error 5: contar el conflicto repetido como muchos

**Qué ocurrió:** 5 commits en rebase → 5 pausas sobre lo mismo → desánimo y abandono.

**Por qué:** expectativa incorrecta (punto 1 Error 5).

**Cómo comprobarlo:** lee cada pausa: ¿es el mismo archivo/tramo?

**Opciones:** resolver → `--continue` en cada paso; o abort y merge.

**Riesgos:** rendirse a mitad y dejar estado sucio.

**Solución:** misma resolución, varios pasos (punto 4).

**Cómo se evita:** rebase de pocos commits, base reciente.

---

### Error 6: cerrar merge sin `git add`

**Qué ocurrió:** `git rebase --continue` o el commit fallan: «you must edit your merge...» / archivos sin staging.

**Por qué:** paso 5 olvidado (punto 3).

**Cómo comprobarlo:** `git status` — ¿sigue «unmerged»?

**Opciones:** `git add` los resueltos y reintentar.

**Riesgos:** bucle de error frustrante.

**Solución:** add = marcar resuelto (punto 3 paso 5).

**Cómo se evita:** los 7 pasos en orden, siempre.

---

### Error 7: resolver a ojo sin listar

**Qué ocurrió:** se resolvió el archivo obvio y otro quedó en conflicto sin cerrar.

**Por qué:** sin `git status` (punto 3 Error 7).

**Cómo comprobarlo:** `git status` al final: ¿unmerged paths vacío?

**Opciones:** resolver los restantes y cerrar.

**Riesgos:** commit con conflictos sin resolver.

**Solución:** listar antes y después.

**Cómo se evita:** status como paso 1 y paso final.

---

### Error 8: elegir «todo mío» sin leer

**Qué ocurrió:** se sobrescribió la versión entrante completa «para salir rápido».

**Por qué:** resolución por pereza (punto 3 Error 11).

**Cómo comprobarlo:** `git log -p` de la otra rama — ¿qué aportaba?

**Opciones:** rehacer la resolución mezclando bien (si no está publicado); commit corregidor (si lo está).

**Riesgos:** perder trabajo legítimo del equipo.

**Solución:** mezclar con criterio (punto 3 paso 3).

**Cómo se evita:** revisión de PR que exige contexto (Error 5 — sección 15).

---

## 6. Práctica guiada

### Objetivo

Provocar conflictos a propósito y resolverlos hasta que el procedimiento sea mecánico.

### Paso 1: conflicto mínimo

1. Dos clones sobre un remoto local: cambia la MISMA línea en ambos. Push del primero → pull del segundo → conflicto.

### Paso 2: resolver a mano

1. Aplica los 7 pasos (punto 3): status, leer, mezclar, quitar marcas, add, `git diff --check`, cerrar.

### Paso 3: rebase repetido

1. Apila 3 commits que tocan lo mismo → pull --rebase contra cambios remotos → resuelve en cada pausa con `--continue`.

### Paso 4: abortos

1. Practica `git merge --abort` y `git rebase --abort` en conflictos simulados: el estado vuelve intacto.

### Paso 5: adición/eliminación

1. Un lado borra un archivo, el otro lo edita: responde a la pregunta de rename/delete con criterio (punto 2).

### Paso 6: la regla personal

1. Añade a `docs/flujo.md`: «conflicto = status → leer → mezclar → check → add → cerrar».

### Resultado esperado

Tres conflictos resueltos (merge, pull, rebase) y tu regla escrita.

### Conclusión esperada

El conflicto deja de dar miedo cuando es un procedimiento numerado: Git detiene, tú decides, Git cierra — y ninguna pausa se parece ya a un error.

---

## 7. Nivel profesional + resumen

### 7.1. Conflictos en el trabajo real

```text
   │
   ├── estrategia previa reduce conflictos: rebase de
   │   tu trabajo antes de abrir PR (sección 07/15)
   │
   ├── conflictos grandes = señal de acoplamiento: los
   │   archivos «guerra» se diseñan con límites
   │   (sección 25 cap. 02)
   │
   ├── en PR: explicar la resolución en la descripción
   │   — el reviewer revisa el resultado y el criterio
   │   (sección 15)
   │
   └── métricas: conflictos por merge, tiempo medio de
       resolución, conflictos repetidos en el mismo
       archivo (sección 20 cap. 06)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* un conflicto es Git parándose donde hace falta un criterio humano, no un fallo;
* las marcas dicen quién es quién: HEAD/tuyo vs entrante/suyo;
* el procedimiento de 7 pasos (status → leer → mezclar → quitar marcas → add → check → cerrar) resuelve cualquier conflicto;
* rebase repite el conflicto por commit; merge lo hace una vez — y ambos se abortan limpio;
* los errores típicos (pánico, marcas residuales, confundir divergencia, rebase ajeno, rendirse en bucle, olvidar add, resolver a ojo, elegir «todo mío») se previenen con el procedimiento;
* a nivel profesional: estrategia que minimiza conflictos, límites de diseño y resolución explicada en el PR.

La idea principal es:

> **El conflicto no es el problema: es Git señalándote exactamente dónde una decisión humana vale más que cualquier algoritmo — y un procedimiento fijo convierte esa decisión en rutina.**

---

## Próximo paso

Conflictos resueltos con criterio.

Ahora el cierre de la sección: los mensajes de Git, qué significan y cómo leerlos.

Continúa con:

[`06-mensajes-y-significados-de-git.md`](06-mensajes-y-significados-de-git.md)
