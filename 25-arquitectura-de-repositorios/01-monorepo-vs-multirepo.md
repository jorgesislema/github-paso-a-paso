# Monorepo vs. multirepo

## Introducción

La pregunta clásica de proyectos que crecen: **¿un repositorio para todo o varios repositorios?** Este capítulo no traerá una respuesta única — la etapa lo advierte explícitamente — sino el marco para decidir: qué implica cada arquitectura, cuándo encaja cada una y cómo se pagan sus consecuencias con el tiempo. La decisión correcta es la que el equipo puede operar y evolucionar, no la de la moda.

---

## Mapa conceptual de este capítulo

```text
Monorepo vs. multirepo
       │
       ├── 1. Qué significa cada uno
       ├── 2. Monorepo: qué gana y qué paga
       ├── 3. Multirepo: qué gana y qué paga
       │   ├── 4. Factores de decisión (el contexto)
       │   ├── 5. Híbridos y migraciones (mención)
       │   └── 6. La respuesta incómoda: casi nunca es
       │       «el código»
       │
       ├── 7. Errores comunes con diagnóstico completo
       ├── 8. Práctica guiada
       └── 9. Nivel profesional + resumen
```

---

## 1. Qué significa cada uno

```text
MONOREPO (un repo, muchos componentes):
   │
   ├── apps, librerías, configuración, a veces infra —
   │   todo en un árbol
   │
   └── un historial, un PR, un set de ramas (con
       paths y alcances — punto 4 sección 04)
```

```text
MULTIREPO (varios repos, un componente o familia):
   │
   ├── cada servicio/librería en su repo
   │
   └── historias, ramas y ciclos independientes por
       repo
```

```text
   │
   └── no existe «el correcto»: existen CONSECUENCIAS
       — y elegir es aceptarlas (sección 06 de esta
       sección — Error 1 si se busca el santo grial)
```

---

## 2. Monorepo: qué gana y qué paga

```text
GANAS:
   │
   ├── atomicidad: un PR puede tocar API + cliente +
   │   test + docs (cambio atómico — impagable en
   │   refactorizaciones cruzadas)
   │
   ├── visibilidad: un historial para todo (bisect,
   │   blame de punta a punta)
   │
   ├── reutilización: las librerías internas se
   │   importan sin gestión de versiones cruzada (al
   │   principio)
   │
   └── estándares UNOS: plantilla, lint, CI base,
       aplicados a todo de una vez (sección 18)
```

```text
PAGAS (consecuencias):
   │
   ├── CI sin inteligencia: todo se prueba en cada
   │   PR → CUESTA (paths y detección de impacto —
   │   sección 04)
   │
   ├── permisos granulares: todo el mundo suele ver
   │   todo (sección 03)
   │
   ├── gobernanza: más disciplina para que no se
   │   vuelva un vertedero (sección 06)
   │
   └── herramientas y experiencia: el crecimiento
       exige build/test incremental (Error 3 si se
       ignora)
```

```text
   │
   └── monorepo sin herramienta de impacto = tarifa
       progresiva de lentitud (Error 3)
```

---

## 3. Multirepo: qué gana y qué paga

```text
GANAS:
   │
   ├── autonomía: cada equipo su release, sus ramas,
   │   su ritmo (sección 17/22)
   │
   ├── permisos naturales: repo = ámbito de acceso
   │   (sección 16/20)
   │
   ├── CI acotado de por sí: solo lo de aquí
   │
   └── límites claros: la interfaz entre repos obliga
       a definir contratos (punto 2 sección 02)
```

```text
PAGAS (consecuencias):
   │
   ├── cambios cruzados: tocar 2 repos = 2 PRs
   │   coordinados + versiones intermedias (Error 4)
   │
   ├── dispersión: plantillas y estándares se
   │   desincronizan (sección 03)
   │
   ├── descubrimiento: ¿qué repos existen? ¿de quién
   │   son? (inventario — sección 03)
   │
   └── deuda de versiones: dependencias internas con
       semver y publicación (Error 5 si nadie las
       mantiene)
```

```text
   │
   └── multirepo es «coordina más»: la libertad se
       paga con sincronización
```

---

## 4. Factores de decisión (el contexto)

```text
PREGUNTAS (marco — las respuestas deciden):
   │
   ├── tamaño y acoplamiento: ¿los componentes cambian
   │   JUNTOS a menudo? → tira monorepo
   │
   ├── equipos: ¿un equipo o muchos con autonomía? →
   │   multirepo escala bien por personas
   │
   ├── permisos: ¿necesitas aislar secretos/código
   │   sensibles? → multirepo (o monorepo con áreas
   │   muy controladas)
   │
   ├── ciclos de release: ¿todos liberan juntos o
   │   independiente? → ¿políticas de release
   │   compatibles?
   │
   ├── herramienta: ¿tienes (o asumes construir)
   │   CI/CD con detección de impacto? → monorepo lo
   │   exige a escala
   │
   └── auditoría/regulación: ¿qué necesitas demostrar
       y a quién? (sección 24 cap. 06 — cumplimiento)
```

```text
   │
   └── la decisión se documenta: «elegimos X por Y;
       si Z cambia, reevaluamos» (Error 2 si nadie
       recuerda el porqué)
```

---

## 5. Híbridos y migraciones (mención)

```text
HÍBRIDOS FRECUENTES:
   │
   ├── monorepo de apps pequeñas + repos separados
   │   para servicios con secretos o equipos distintos
   │
   └── multirepo + repos «meta» de plantillas y
       estándares (sección 03)
```

```text
MIGRAR (advertencia seria):
   │
   ├── reescribir historia + coordinar clones + CI +
   │   dependencias internas — es una OBRA, no un
   │   fin de semana
   │
   ├── criterio: se migra cuando el dolor actual es
   │   mayor que la obra (Error 6 si es por moda)
   │
   └── plan: congelar ventana, avisar (sección 16),
       puentes de versión, verificación, post-mortem
```

```text
   │
   └── la migración es la operación más peligrosa del
       repositorio: se coordina como un despliegue
       (sección 22/23 — Error 6)
```

---

## 6. La respuesta incómoda: casi nunca es «el código»

```text
LO QUE REALMENTE DECIDE:
   │
   ├── cómo se coordina la gente (equipos, releases)
   │
   ├── cuánta automatización puedes operar (CI con
   │   impacto, plantillas)
   │
   └── qué permisos y auditoría exige tu contexto
```

```text
   │
   └── proyectos pequeños: empieza con UN repo bien
       estructurado; los problemas de multirepo
       llegan con los equipos, no con los archivos —
       y los de monorepo, con la escala del CI (Error
       1: preguntarse esto en un repo de 3 archivos
       es puro espejismo)
```

---

## 7. Errores comunes con diagnóstico completo

### Error 1: discutir arquitectura con argumentos de dogma

**Qué ocurrió:** semanas de debate «monorepo bueno / multirepo bueno» sin mirar el contexto del punto 4.

**Por qué:** se buscó la respuesta correcta en vez del marco (punto 1).

**Cómo comprobarlo:** ¿existe un documento con factores y decisión?

**Opciones:** aplicar el marco del punto 4 con las respuestas del equipo; decidir con fecha.

**Riesgos:** parálisis y bandos.

**Solución:** contexto, no dogma (punto 4/6).

**Cómo se evita:** la práctica del punto 8.

---

### Error 2: decisión sin registro

**Qué ocurrió:** dos años después, nadie sabía por qué había 40 repos pequeños.

**Por qué:** no se documentó (punto 4).

**Cómo comprobarlo:** ¿hay «ARQUITECTURA.md» con la decisión y sus razones?

**Opciones:** escribir la decisión hoy (aun si heredaste el caos): estado actual + criterios.

**Riesgos:** decisiones huérfanas que nadie puede revisar.

**Solución:** registro con «si Z cambia, reevaluamos» (punto 4).

**Cómo se evita:** plantilla de decisión técnica (sección 26 — mención).

---

### Error 3: monorepo con CI de «todo siempre»

**Qué ocurrió:** cada PR de un typo ejecutaba la suite completa (40 min); el equipo odiaba el repo.

**Por qué:** sin detección de impacto ni paths (punto 2 — sección 04).

**Cómo comprobarlo:** duración del CI vs. tamaño del cambio.

**Opciones:** paths/afectados; jobs por paquete; caché; matriz acotada (sección 22/04).

**Riesgos:** muerte por tiempo de CI (Error de sección 22 cap. 01).

**Solución:** monorepo con impacto (punto 2).

**Cómo se evita:** presupuesto de CI al diseñar (sección 04).

---

### Error 4: cambios cruzados descoordinados en multirepo

**Qué ocurrió:** API v2 salió en un repo; el cliente v1 rompió en producción.

**Por qué:** dos PRs sin secuencia ni contrato (punto 3).

**Cómo comprobarlo:** historial: ¿cambios que necesitaron dos repos? ¿quién coordinó?

**Opciones:** contratos/versiones compatibles (expand/contract — sección 22 cap. 06), releases coordinados, o considerar monorepo si el acoplamiento es real (punto 4).

**Riesgos:** semáforo rojo intermitente.

**Solución:** secuencia y contratos (punto 3).

**Cómo se evita:** revisar acoplamiento en el marco (punto 4).

---

### Error 5: dependencias internas sin mantenimiento

**Qué ocurrió:** la librería compartida de 5 repos dejó de actualizarse; cada uno parcheó por su lado.

**Por qué:** nadie es dueño de la librería (punto 3).

**Cómo comprobarlo:** ¿dueño? ¿última release? ¿issues abiertos?

**Opciones:** dueño explícito + renovación en calendario; versiones semver con migración; o fusionar si el mantenimiento no se sostiene.

**Riesgos:** fragmentación silenciosa.

**Solución:** la compartida es un producto (punto 3 / sección 16 cap. 06).

**Cómo se evita:** inventario de componentes con dueños (sección 03).

---

### Error 6: migración por moda

**Qué ocurrió:** «todos los grandes usan monorepo» → migraron sin herramienta de CI y cayeron en el Error 3.

**Por qué:** se copió la conclusión, no el contexto (punto 5).

**Cómo comprobarlo:** ¿la migración tiene criterios y plan escritos?

**Opciones:** revertir o invertir en la herramienta que el modelo exige; decidir con el marco.

**Riesgos:** la obra peor que el dolor previo.

**Solución:** migra solo si el dolor lo justifica (punto 5).

**Cómo se evita:** marco del punto 4 antes de firmar obras.

---

## 8. Práctica guiada

### Objetivo

Documentar la arquitectura de repositorios de tu proyecto (o el futuro que planeas) con criterios.

### Paso 1: contexto

```text
Responde (tu proyecto real):
   │
   ├── nº de componentes y su acoplamiento (¿cambian
   │   juntos?)
   ├── nº de equipos/personas y su autonomía
   ├── permisos/aislamiento que necesitas
   ├── ritmo de release por componente
   └── capacidad de CI (¿impacto/paths disponibles?)
```

### Paso 2: matriza de opciones

| Factor | Tu contexto | Tira hacia |
|--------|-------------|------------|
| acoplamiento | ... | monorepo / multi |
| equipos | ... | ... |
| permisos | ... | ... |
| releases | ... | ... |
| CI | ... | ... |

1. Rellena y cuenta: ¿hacia dónde tira tu lista?

### Paso 3: decisión registrada

```markdown
# Decisión: arquitectura de repositorios
- Fecha:
- Decisión: [monorepo / multirepo / híbrido]
- Razones: [las 3 más fuertes de la matriza]
- Consecuencias aceptadas: [las pagas — punto 2/3]
- Reevaluar si: [qué cambio la invalidaría]
```

### Paso 4: consecuencias operativas

1. Según la decisión, aplica lo que te toca: paths de CI (monorepo — sección 04) o inventario/plantillas (multirepo — sección 03).

### Paso 5: rehecho el caos heredado

1. Si la arquitectura NO fue tu decisión: documenta el estado actual + sus razones + qué dolores tiene — es la base de cualquier cambio futuro.

### Resultado esperado

Matriza de contexto llena, decisión (o diagnóstico del estado) documentado con consecuencias y reevaluación.

### Conclusión esperada

La arquitectura de repositorios no se descubre en un tutorial: se decide con el contexto del equipo y se firma con sus consecuencias — por escrito, para poder revisarla.

---

## 9. Nivel profesional + resumen

### 9.1. Arquitectura a escala

```text
   │
   ├── monorepo grande: build/test incremental, cachés
   │   compartidas, OWNERS/CODEOWNERS por área
   │   (sección 03), paths estrictos (sección 04)
   │
   ├── multirepo grande: catálogo de servicios
   │   (inventario con dueños), plantillas org-wide,
   │   dependencias internas con semver y soporte
   │
   ├── híbrido consciente: la frontera documentada
   │   («qué va juntos y qué no, y por qué»)
   │
   ├── métrica: duración de CI por cambio, nº de
   │   repos sin dueño, cambios cruzados coordinados
   │
   └── revisión anual de arquitectura con el marco
       (punto 4) — Error 2 prevención
```

### 9.2. Resumen

En este capítulo aprendiste que:

* monorepo = atomicidad y estándares únicos, pagando con CI y gobernanza;
* multirepo = autonomía y permisos naturales, pagando con coordinación y dispersión;
* la decisión la dan los factores de contexto (acoplamiento, equipos, permisos, releases, CI) — documentada con razones y reevaluación;
* migraciones: obras coordinadas, por dolor, no por moda;
* los errores típicos (dogma, decisión sin registro, CI de todo, cambios descoordinados, librerías huérfanas, migración copiada) se previenen con marco y registro;
* a nivel profesional: inventario, plantillas y revisión anual.

La idea principal es:

> **No hay arquitectura correcta: hay consecuencias aceptadas conscientemente — la elección madura es la que firma su precio y anota qué la haría cambiar de opinión.**

---

## Próximo paso

Ya decides con criterio dónde vive el código.

Ahora cómo se estructura dentro y cómo se dibujan los límites entre componentes.

Continúa con:

[`02-estructura-y-limites-de-componentes.md`](02-estructura-y-limites-de-componentes.md)
