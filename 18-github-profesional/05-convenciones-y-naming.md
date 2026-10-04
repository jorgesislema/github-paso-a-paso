# Convenciones y naming

## Introducción

Un equipo profesional repite decisiones: cómo se llaman las ramas, los commits, los archivos, los tags, las etiquetas y los workflows. Cada decisión repetida sin acordar es una oportunidad de conflicto — rama `feature/login` vs `feat/342-login`, archivo `README.md` vs `readme.md` (que en servidores sensibles a mayúsculas son dos).

Este capítulo reúne las convenciones que suelen escribirse en CONTRIBUTING y que hacen que cien repos del mismo equipo se lean como una sola casa.

---

## Mapa conceptual de este capítulo

```text
Convenciones y naming
       │
       ├── 1. Filosofía: acordar una vez, no mil
       ├── 2. Ramas y commits
       ├── 3. Archivos, etiquetas y metadatos
       ├── 4. Dónde vive y quién la mantiene
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Filosofía: acordar una vez, no mil

```text
QUÉ ES UNA CONVENCIÓN:
   │
   ├── una decisión sobre FORMA que ahorra discusiones
   │   futuras (no sobre arquitectura — eso es ADR)
   │
   └── vale si es legible, aplicable y verificable
       (linter/script cuando sea posible)
```

```text
CRITERIOS DE BUENA CONVENCIÓN:
   │
   ├── alineada con el ecosistema (Python, JS… —
   │   sección 21) antes de inventar
   ├── poca: 10-15 líneas en CONTRIBUTING, no un
   │   manual
   ├── verificable: formato de nombre que un linter o
   │   revisor comprueba en 5 segundos
   └── escrita donde se aplica (CONTRIBUTING para
       personas, configs para herramientas)
```

```text
   │
   └── la convención NO escrita es una opinión: la
       escrita es una decisión del equipo
```

---

## 2. Ramas y commits

```text
RAMAS
──────────────────────────────────────────────────────
· minúsculas, guion bajo o «-», sin acentos/ñ
  (compatibilidad total)
· prefijo de tipo o ticket:
  feat/… · fix/… · chore/… · docs/… · refactor/…
  (o JIRA-123-login — lo que el equipo elija)
· descriptivo y corto: feat/exportar-csv
· NADA: fix2, cambios, temp
```

```text
COMMITS (sección 14 cap. 03)
   │
   ├── convención elegida (p. ej. Conventional
   │   Commits) con ejemplos buenos y malos
   ├── idioma único del historial
   └── regla de tamaño: un commit = una idea
```

```text
TAGS
   │
   ├── siempre con «v» y semver: v1.4.0
   ├── anotado para releases (sección 17/18 cap. 04)
   └── nunca etiquetas «final-2-ahora-si»
```

```text
MERGES (integración — sección 15 cap. 05)
   │
   ├── mensaje de merge/squash con formato acordado
   └── «Closes #n» siempre que cierre trabajo
```

---

## 3. Archivos, etiquetas y metadatos

```text
ARCHIVOS
   │
   ├── nombres en minúsculas-guion: api-client.js,
   │   exportar_csv.py (según ecosistema)
   │   → evita problemas de case en CI/servidores
   ├── extensiones estándar del lenguaje
   └── carpetas según estructura profesional (cap. 01
       de esta sección)
```

```text
ETIQUETAS (sección 16 cap. 03)
   │
   ├── taxonomía de 10-12 con descripciones
   └── nombres cortos, sin sinónimos (bug/bugfix/bug-
       fix es caos)
```

```text
WORKFLOWS (`.github/workflows/`)
   │
   ├── nombre del archivo = propósito: ci.yml,
   │   release.yml, security.yml
   ├── nombre del job estable si es check requerida
   │   (sección 18 cap. 03)
   └── naming de variables/secretos en mayúsculas:
       DEPLOY_TOKEN, NPM_AUTH
```

```text
VERSIONES DE ARCHIVOS
   │
   ├── dependencias/inputs versionados cuando importa
   │   (actions fijas: @v4 o SHA — sección 20)
   └── fechas ISO (2026-10-02) cuando se date
```

---

## 4. Dónde vive y quién la mantiene

```text
UBICACIÓN
   │
   ├── CONTRIBUTING.md → secciones cortas: «Ramas»,
   │   «Commits», «Nombres»
   │
   ├── configs en repo → lo verificable (linter,
   │   editorconfig, formatter — sección 21)
   │
   └── plantilla de org → lo que vale para todos los
       repos (cap. 02 de esta sección)
```

```text
MANTENIMIENTO
   │
   ├── dueño: el tech lead del área o el dueño del
   │   flujo (rotativo aceptable)
   │
   ├── cambios por PR igual que código (¡y con
   │   ejemplo antes/después!)
   │
   └── al cambiar convención: anuncio + ventana +
       todos los repos afectados decididos (¿migrar
       o convivir?)
```

```text
VERIFICACIÓN (opciones, por orden de fuerza):
   │
   ├── linter en CI (rechaza el PR)
   ├── revisor con checklist
   └── plantilla que guía (el que escribe ve la forma)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: convención no escrita («ya lo sabemos»)

**Qué ocurrió:** el nuevo escribe `Fix: arreglo de login` en inglés y rama `mi-cambio`; el revisor discute tono en vez de code.

**Por qué:** nunca se documentó.

**Cómo comprobarlo:** preguntar a 3 personas y comparar respuestas; leer CONTRIBUTING.

**Opciones:** escribir con ejemplos (bueno/malo); onboarding con enlace.

**Riesgos:** cada PR tiene 3 comentarios de forma.

**Solución:** sección de convención corta y ejemplificada (punto 4).

**Cómo se evita:** checklist de plantilla de CONTRIBUTING al crear el repo.

---

### Error 2: convención que contradice al ecosistema

**Qué ocurrió:** forzar guiones en un proyecto JS donde el ecosistema usa camelCase, o nombres de archivo con mayúsculas en un repo con CI case-sensitive.

**Por qué:** invención sin mirar estándares.

**Cómo comprobarlo:** comparar con las guías del lenguaje (sección 21) y probar en CI.

**Opciones:** alinearse al ecosistema; documentar la desviación si es deliberada.

**Riesgos:** fricción constante con herramientas.

**Solución:** convención = estándar + excepciones mínimas escritas.

**Cómo se evita:** revisar convención con alguien del ecosistema.

---

### Error 3: naming inconsistente entre repos de la org

**Qué ocurrió:** en el repo A es `feat/`, en el B `feature/`; etiquetas distintas; workflows con otros nombres.

**Por qué:** no hay plantilla de org (sección 18 cap. 02) ni convención central.

**Cómo comprobarlo:** muestrear 3 repos.

**Opciones:** convención base en la plantilla de org; repos existentes: convivir y migrar al tocarlos.

**Riesgos:** quien trabaja en 3 repos vive con 3 dialectos.

**Solución:** fuente única para lo compartido.

**Cómo se evita:** PR de plantilla cuando cambia la convención.

---

### Error 4: convención demasiado larga (nadie la lee)

**Qué ocurrió:** CONTRIBUTING con 400 líneas de estilo; el equipo aplica 3 reglas.

**Por qué:** se regló todo lo imaginable.

**Cómo comprobarlo:** preguntar: «¿qué 5 reglas seguimos?».

**Opciones:** reducir a lo que se revisa; lo demás, a linter o a guía.

**Riesgos:** documento muerto = falsa certeza.

**Solución:** pocas reglas + verificación automática (punto 1).

**Cómo se evita:** cada regla nueva requiere «¿cómo la verificamos?».

---

### Error 5: cambiar convención sin migración

**Qué ocurrió:** se decretó `feat/` en vez de `feature/` y los scripts/PRs abiertos se rompieron.

**Por qué:** cambio a ciegas.

**Cómo comprobarlo:** patrones afectados (scripts, filters, docs).

**Opciones:** anunciar, migrar por oleadas, mantener ambos un tiempo si es indoloro, actualizar docs/scripts en el mismo PR de cambio.

**Riesgos:** roturas dispersas y confusión.

**Solución:** ritual de cambio de convención (punto 4).

**Cómo se evita:** evaluar impacto antes de decretar.

---

### Error 6: convención con acentos, espacios y ñ

**Qué ocurrió:** rama `característica-especial` o archivo `contraseñas.txt` falla en CI o en git en algunas máquinas.

**Por qué:** se escribió el nombre «como se pronuncia» sin considerar herramientas.

**Cómo comprobarlo:** ejecutar en CI/otro SO.

**Opciones:** renombrar (si no compartida) a ASCII; regla explícita.

**Riesgos:** fallos intermitentes según dónde se clone.

**Solución:** nombres ASCII para ramas/archivos técnicos (punto 2).

**Cómo se evita:** regla en plantilla y revisor atento.

---

## 6. Práctica guiada

### Objetivo

Escribir el bloque de convenciones de un proyecto y verificarlo.

### Paso 1: recopilar

```text
De tu repo actual, anota lo que YA se hace (bien o
mal):
   │
   ├── ramas abiertas: ¿patrón?
   ├── últimos 10 commits: ¿convención?
   ├── etiquetas: ¿coherentes?
   └── nombres de workflow: ¿claros?
```

### Paso 2: decide

```markdown
## Convenciones
- Ramas: `tipo/descripcion-corta` (ASCII, minúsculas)
- Commits: Conventional Commits en español
  (`feat:`, `fix:`, `docs:`) — imperativo, asunto ≤50
- Archivos: minúsculas-guion; mayúsculas solo si el
  ecosistema lo exige
- Tags: `vX.Y.Z` anotados en releases
- Etiquetas: (lista de la sección 16 cap. 03)
- Workflows: `ci.yml`, `release.yml`; checks con
  nombre estable
```

### Paso 3: ejemplos buenos y malos

1. Añade 3 pares bueno/malo (esto es lo que la gente recuerda).

### Paso 4: verifica

```text
   │
   ├── ¿qué reglas puede verificar un linter? →
   │   configúralo (editorconfig/commitlint/lint de
   │   nombres)
   │
   └── ¿cuáles quedan a revisor? → checklist de PR
       con esas 2-3 reglas
```

### Paso 5: publica y forma

1. CONTRIBUTING + enlace desde el README y desde el mensaje de bienvenida a colaboradores.
2. Prueba con una rama/commit nuevos cumpliendo la guía.

### Paso 6: agenda revisión

1. Fecha de revisión de convenciones en 90 días (¿se usa? ¿dolerá cambiar algo?).

### Resultado esperado

Convenciones escritas con ejemplos, parte automatizada y fecha de revisión.

### Conclusión esperada

Una convención corta y verificable vale más que un reglamento: se aplica porque es fácil de recordar y de comprobar.

---

## 7. Nivel profesional + resumen

### 7.1. Convenciones a escala

```text
   │
   ├── base de org (plantilla) + excepciones por repo
   │   (escritas)
   │
   ├── verificación en CI: formato, nombres, mensajes
   │   (linters de convención)
   │
   ├── convención como ADR cuando cambia de forma
   │   mayor (sección 14)
   │
   └── métrica: comentarios de forma por PR (si
       suben → falta linter o claridad)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* las convenciones son decisiones de forma acordadas una vez: ramas (`tipo/descripcion` ASCII), commits (convención elegida), tags (`vX.Y.Z`), archivos (minúsculas-guion), etiquetas y workflows;
* se alinean al ecosistema antes de inventar y se verifican con linter o checklist;
* viven en CONTRIBUTING (corto, con ejemplos), configs en repo y plantilla de org para lo compartido;
* los errores típicos (no escrita, contra el ecosistema, dispersa entre repos, demasiado larga, migración olvidada, nombres no-ASCII) se previenen con diseño y ritual de cambio;
* a nivel profesional: convención base de org, verificación en CI y métrica de comentarios de forma.

La idea principal es:

> **La convención es una decisión que se toma una vez y se ejecuta mil veces: si no se verifica sola, no es convención — es una opinión con letras bonitas.**

---

## Próximo paso

Ya tienes las formas acordadas.

El último capítulo de la sección: gobernanza — quién decide qué y cómo se audita.

Continúa con:

[`06-gobernanza.md`](06-gobernanza.md)
