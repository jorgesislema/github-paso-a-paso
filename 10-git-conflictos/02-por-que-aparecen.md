# Por qué aparecen los conflictos

## Introducción

Los conflictos no caen del cielo: tienen causas identificables —divergencia, solape, formato, arquitectura— y casi todas se pueden PREVER o REDUCIR. Entender por qué aparecen es la mitad de aprender a resolverlos: si sabes qué los produce, sabes qué evitar.

En este capítulo analizamos las causas reales: desde lo inevitable (dos personas, el mismo archivo) hasta lo evitable (ramas eternas, formatos autogenerados) y lo estructural (archivos «catedral» que todo el mundo toca). Y damos la escala de frecuencia: qué conflictos son «de rutina» y cuáles son síntomas de algo más gordo.

En este capítulo aprenderás:

* las causas clásicas de conflicto (con ejemplos);
* por qué la distancia en el tiempo las multiplica;
* causas técnicas ocultas (fin de línea, codificación, whitespace);
* causas estructurales (diseño de archivos y de equipo);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (métricas y prevención).

---

## Mapa conceptual de este capítulo

```text
Por qué aparecen los conflictos
       │
       ├── 1. Causas clásicas
   │        ├── mismo archivo, mismo tramo
   │        ├── adición vs. adición
   │        └── edición vs. borrado
   │
       ├── 2. El factor tiempo (divergencia)
   │
       ├── 3. Causas técnicas ocultas
   │        ├── fin de línea CRLF/LF
   │        ├── codificación y BOM
   │        └── whitespace / formato automático
   │
       ├── 4. Causas estructurales
   │        ├── archivos «god file»
   │        ├── zonas de edición solapadas
   │        └── falta de coordinación
   │
       ├── 5. Errores comunes (interpretación) + diagnóstico
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Causas clásicas

### 1.1. Mismo archivo, mismo tramo

```text
ancestro:  L40 = "return 42"
rama A:    L40 = "return calculate()"
rama B:    L40 = "return resultado"

→ tres valores distintos en el mismo punto
```

```text
Git combina cuando puede:
   │
   ├── A toca L40, B toca L80 → combina (automático)
   └── A y B tocan L40 → conflicto (decisión)
```

### 1.2. Adición vs. adición

```text
   │
   ├── ambos CREAN utils.py (raro pero posible: mismo
   │   nombre lógico)
   │
   ├── Git: «dos archivos nuevos en el mismo path» →
   │   conflicto (¿cuál es el verdadero?)
   │
   └── solución: elegir uno y llevar el contenido del
       otro encima
```

### 1.3. Edición vs. borrado

```text
   │
   ├── A borra la función X; B la corrige
   │
   ├── Git no puede adivinar: ¿la repongo corregida o
   │   la dejo muerta?
   │
   └── decisión humana (y mensaje del merge que la
       documenta)
```

### 1.4. Renombres cruzados

```text
   │
   ├── A mueve a/ → z/; B mueve a/ → y/
   │
   └── casos raros: Git puede pedir resolución de
       rename; en la práctica: acordar nombres
```

---

## 2. El factor tiempo (divergencia)

### 2.1. La ecuación práctica

```text
conflictos ≈ divergencia × solape × tiempo

   │
   ├── mientras más tiempo «vive» la rama sin
   │   integrar, más cambia main bajo sus pies
   │
   ├── CADA merge pendiente es deuda: el siguiente
   │   merge parte de más lejos
   │
   └── rama de 2 semanas que nadie tocó = conflicto
       potencial gigante en archivos activos
```

### 2.2. Ejemplo vivido

```text
Día 1:  rama nace de main (limpio)
Día 3:  main cambia el módulo X (tú no lo ves)
Día 8:  tú cambias X a tu manera
Día 10: merge → conflicto en X

Con pull diario de main en tu rama:
   │
   ├── día 3: traes el cambio de X (lo ves, lo
   │   entiendes, sigues encima)
   └── día 10: merge casi limpio
```

### 2.3. Ritmo como prevención

```text
   │
   ├── rama corta = menos tiempo = menos divergencia
   │
   ├── integrar a diario = conflictos pequeños y
   │   frecuentes (baratos) en vez de enormes y raros
   │   (caros)
   │
   └── «un conflicto pequeño al día, lejos»
```

---

## 3. Causas técnicas ocultas

### 3.1. Fin de línea (CRLF/LF)

```text
   │
   ├── quien trabaja en Windows guarda CRLF; quien
   │   está en Linux, LF (o viceversa según config)
   │
   ├── Git puede ver TODAS las líneas cambiadas →
   │   conflictos absurdos en archivos «que nadie
   │   tocó»
   │
   └── solución: core.autocrlf / .gitattributes
       (sección 06; política de equipo)
```

### 3.2. Codificación / BOM

```text
   │
   ├── UTF-8 con y sin BOM; acentos mal guardados
   │
   └── mismo efecto: diferencias fantasma → conflictos
       o restos sucios
```

### 3.3. Formato automático / whitespace

```text
   │
   ├── el editor de A reindenta TODO el bloque que tocó
   │   → «cambios» que no eran del tema
   │
   ├── al merge, esas reescrituras chocan con B
   │
   └── solución: formato en CI/consola (no a mano),
       pre-commit del equipo, diff con opciones de
       whitespace
```

### 3.4. Archivos generados versionados

```text
   │
   ├── lockfiles, bundles, minificados: dos generates
   │   distintos → conflicto garantizado
   │
   └── solución: LFS/gestionar por herramienta, no
       editar a mano (sección 07)
```

---

## 4. Causas estructurales

### 4.1. El «god file»

```text
   │
   ├── un archivo gigante que todos tocan (índice,
   │   menú, config compartida, styles globales)
   │
   └── conflicto casi garantizado en cada merge
       → partirlo (sección 24+: arquitectura)
```

### 4.2. Zonas solapadas sin propietario

```text
   │
   ├── dos personas editan «el mismo bloque» por
   │   desconocimiento (nadie dijo «esto lo lleva X»)
   │
   └── solución: CODEOWNERS, tableros, conversación
       (revisión PREVIA de trabajo paralelo)
```

### 4.3. Ramas que no debían existir

```text
   │
   ├── rama de «todo el sprint» en vez de por tarea
   │
   ├── rama que duplica trabajo ya hecho en main
   │   (alguien hizo lo mismo sin avisar)
   │
   └── solución: flujo por issue/PR y coordinación
```

### 4.4. Reescrituras compartidas (el conflicto «importado»)

```text
   │
   ├── alguien hizo rebase/force en rama compartida →
   │   los demás divergen de golpe → conflictos
   │   incluidos
   │
   └── solución: política anti-rebase en lo ajeno
       (sección 17)
```

---

## 5. Errores comunes en la interpretación (+ diagnóstico)

### Error 1: «Este archivo no lo he tocado»

**Qué ocurrió:** conflicto en un archivo «intacto».

**Por qué posibles:**
* lo tocó «de fondo» (formato, fin de línea, re-indentación);
* alguien más lo tocó en TU rama (¿rama compartida?);
* renombre detectado raro.

**Cómo comprobarlo:** `git log -n 5 -- <archivo>` (en cada lado); `git diff` con `--ignore-all-space` para ver si «de verdad» cambió el contenido.

**Opciones:** si es whitespace/formato: resolver aceptando el lado correcto y arreglar config; si es contenido: mirar historia de ambos lados.

**Riesgos:** dar por bueno un cambio fantasma.

**Solución:** diagnóstico con log + diff -w.

**Cómo se evita:** formato unificado (.gitattributes/CI).

---

### Error 2: «Conflicto otra vez en el mismo archivo»

**Qué ocurrió:** cada merge discute por el mismo fichero.

**Por qué:** god file o zona compartida (punto 4.1/4.2).

**Cómo comprobarlo:** historial: `git log --oneline --follow <archivo>` muestra frecuencia; patrón en varios merges.

**Opciones:** partir el archivo; repartir propiedad; cambiar flujo.

**Riesgos:** seguir pagando el peaje cada vez.

**Solución:** atacar la estructura.

**Cómo se evita:** revisar «top conflictivos» cada cierto tiempo (nivel profesional).

---

### Error 3: «Resolví y volvió el conflicto»

**Qué ocurrió:** se resolvió, se continuó… y el siguiente merge lo trae de nuevo.

**Por qué posibles:**
* se resolvió solo en un lado (¿confundiste merge y rebase?);
* el otro lado nunca se actualizó (pull pendiente);
* se resolvió a medias (un hunk mal).

**Cómo comprobarlo:** `git log --graph`; ver los dos lados (`git show`); repetir `diff --check`.

**Opciones:** resolver de nuevo en el flujo correcto.

**Riesgos:** bucle de resoluciones mal orientadas.

**Solución:** mapear lados (capítulo 06 para rebase).

**Cómo se evita:** método estructurado (capítulo 04).

---

### Error 4: «Git ha elegido mal (y no me avisó)»

**Qué ocurrió:** un merge «automático» produjo un resultado incorrecto (sin conflicto).

**Por qué:** resolución automática posible pero semánticamente errónea (Git no entiende tu lógica).

**Cómo comprobarlo:** revisar el diff DEL MERGE (no solo los marcadores que no hay).

**Opciones:** corregir en commit inmediato (o revert si ya salió).

**Riesgos:** bug «invisible» (peor que un conflicto).

**Solución:** revisar diffs de merge en cambios importantes.

**Cómo se evita:** CI fuerte (tests) — la red de seguridad real.

---

### Error 5: «No hay conflicto pero no funciona»

**Qué ocurrió:** merge limpio, build roto.

**Por qué:** incompatibilidad semántica (ambos cambios válidos aislados, incompatibles juntos).

**Cómo comprobarlo:** tests/CI.

**Opciones:** fix o revert de la integración; aprendizaje.

**Riesgos:** regresión en producción.

**Solución:** CI obligatorio antes de integrar (sección 21).

**Cómo se evita:** conflicto es MÁS seguro que esto: al menos te obliga a mirar.

---

### Error 6: Evitar ramas por miedo a conflictos

**Qué ocurrió:** se centraliza todo en main «para no tener conflictos».

**Por qué:** mala interpretación (el coste real es mayor).

**Cómo comprobarlo:** historial caótico, sin revisión.

**Opciones:** ramas cortas + PRs (menos conflictos, no más).

**Riesgos:** calidad sin revisión.

**Solución:** disciplina de ramas (sección 08).

**Cómo se evita:** este recorrido.

---

## 6. Práctica guiada

### Objetivo

Clasificar conflictos provocados según su causa y medir la divergencia.

### Paso 1: conflicto de contenido (clásico)

1. Repite el ejercicio del capítulo 01 (mismo archivo, una línea).
2. Clasifica: contenido/contenido.

### Paso 2: adición vs. adición

```bash
git switch -c caso-add-a main
echo "contenido A" > nuevo.md
git add nuevo.md && git commit -m "A crea"

git switch -c caso-add-b main
echo "contenido B" > nuevo.md
git add nuevo.md && git commit -m "B crea"

git switch main
git merge --no-ff caso-add-a
git merge --no-ff caso-add-b     # conflicto
git status
git merge --abort
```

### Paso 3: edición vs. borrado

```bash
# rama A: borra el archivo (git rm)
# rama B: lo edita
# merge → conflicto (borrado/edición)
git merge --abort (tras observar)
```

### Paso 4: conflicto «de tiempo» (divergencia)

```bash
# rama larga: nace, y en main haz 5 commits variados
# sin tocar la rama; luego la rama cambia lo mismo
git merge --no-ff <rama>          # conflicto grande
git log --graph --oneline -n 15   # mide la divergencia
git merge --abort
```

1. Comprueba: más tiempo = más conflicto.

### Paso 5: conflicto fantasma (whitespace)

```bash
# en dos ramas: misma línea, una con espacios finales
# o distinto sangrado
git diff -w HEAD..otra-rama      # ¿qué hay DE VERDAD?
git merge                         # conflicto
git diff --check                  # huellas de whitespace
git merge --abort
```

### Paso 6: métrica personal

1. En tu repositorio real: `git log --merges --oneline | Measure-Object -Line`.
2. Lista los archivos que más salen en tus últimos merges: son tus «puntos calientes».

### Resultado Esperado

Capacidad de etiquetar cada conflicto por su causa (y elegir la respuesta adecuada), más una lista de tus archivos problemáticos.

### Conclusión esperada

Los conflictos tienen firmas: la causa dicta la solución — y varias de ellas (tiempo, formato, estructura) se previenen antes de que aparezca el primer marcador.

---

## 7. Nivel profesional + resumen

### 7.1. Prevención en equipos

```text
Palancas, por orden de efecto
──────────────────────────────────────────────────────
1. ramas cortas + integración frecuente
2. formato/CI (imposibilita conflictos fantasma)
3. .gitattributes con reglas de texto
4. partir god files y repartir propiedad
5. CODEOWNERS + revisión de trabajo paralelo
6. política de no reescribir lo compartido
7. medir: archivos más conflictivos = candidatos a
   rediseño
```

### 7.2. Conflictos en la revisión

```text
   │
   ├── el diff del merge es parte de la revisión (si
   │   cambia contenido fuera de lo esperado: alerta)
   │
   ├── conflictos resueltos deben quedar reflejados en
   │   el mensaje o en el PR («resuelto uniendo A y B»)
   │
   └── CI: el merge conflictivo no llega «verde»; es
       la barra mínima
```

### 7.3. Resumen

En este capítulo aprendiste que:

* las causas clásicas son solape de contenido, adición/adición y edición/borrado respecto a un ancestro;
* el tiempo multiplica: divergencia acumulada = conflictos gordos; integrar a diario los mantiene pequeños;
* causas técnicas ocultas (CRLF, codificación, whitespace, generados) producen conflictos «fantasma» y se resuelven con configuración y CI;
* causas estructurales (god files, zonas sin dueño, ramas mal planteadas, reescrituras compartidas) son el patrón de los conflictos recurrentes;
* los errores de interpretación («no lo toqué», «volvió», «merge limpio pero roto») se diagnostican con log, diff -w, diff --check y CI;
* a nivel profesional: prevención en orden de efecto y medición de archivos conflictivos.

La idea principal es:

> **Un conflicto siempre tiene una firma: identifica la causa (tiempo, formato, estructura) y la solución se hace evidente.**

---

## Próximo paso

Ya sabes por qué aparecen.

Ahora: cómo detectarlos e identificarlos al instante.

Continúa con:

[`03-identificar-un-conflicto.md`](03-identificar-un-conflicto.md)
