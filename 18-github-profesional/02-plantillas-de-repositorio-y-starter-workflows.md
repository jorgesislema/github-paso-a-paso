# Plantillas de repositorio y starter workflows

## Introducción

Cada repositorio nuevo repite lo mismo: estructura, plantillas, workflows, contratos. Si se copian a mano, se estropean y divergen; si viven como **plantillas**, el repositorio nace profesional y el equipo empieza donde debe empezar.

Este capítulo cubre las tres palancas de repetición de GitHub: repositorios con plantilla, *starter workflows* de Actions y plantillas de organización — cómo usarlas, cómo versionarlas y cómo evitar que se vuelvan ruinas antiguas.

---

## Mapa conceptual de este capítulo

```text
Plantillas de repositorio y starter workflows
       │
       ├── 1. Repositorio con plantilla
       ├── 2. Starter workflows (Actions)
       ├── 3. Plantillas de organización
       ├── 4. Evitar que la plantilla envejezca
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Repositorio con plantilla

```text
QUÉ ES:
   │
   ├── un repo marcado «Template repository»
   │
   └── «Use this template» crea un repo NUEVO con su
       contenido (historia NO copiada: arranca limpio
       con los archivos de la plantilla)
```

```text
QUÉ PONER EN LA PLANTILLA:
   │
   ├── estructura de carpetas (cap. 01)
   ├── contratos: README (con marcadores), LICENSE,
   │   CONTRIBUTING, SECURITY, CHANGELOG
   ├── .github/: plantillas de issue/PR, CODEOWNERS
   │   base, workflows básicos de CI
   ├── configs del lenguaje (linters, formatter)
   └── scripts de setup (docs/setup)
```

```text
BUENAS PRÁCTICAS:
   │
   ├── README con «marcadores» a rellenar:
   │   <!-- NOMBRE_DEL_PROYECTO: describe… -->
   │
   ├── checklist de primeros pasos dentro de la
   │   plantilla («al usarla, rellena X, Y, Z»)
   │
   └── el nombre/lógica específica NO se copia: la
       plantilla aporta forma, no contenido
```

```text
   │
   └── Git: el repo plantilla suele ser un repo
       normal con plantillas dentro; el clon nuevo NO
       hereda remoto ni historial (por diseño)
```

---

## 2. Starter workflows (Actions)

```text
QUÉ ES:
   │
   └── workflows que aparecen en «New workflow» de un
       repo como OPCIONES preconfiguradas en vez de
       empezar de cero
```

```text
DÓNDE VIVEN (por organización o repo):
   │
   └── en un repo especial de plantillas de
       organización (mecanismo oficial: repo de la
       org con workflows y metadatos — consultar la
       doc actual); también se pueden copiar archivos
       en .github/workflows/
```

```text
QUÉ CONVENE ESTANDARIZAR:
   │
   ├── CI base: checkout → setup → lint → test
   ├── dependabot de actions/dependencias (sección 20)
   ├── release (sección 22) si el equipo tiene una
   └── seguridad: escaneo (sección 20/24)
```

```text
PLANTILLA DE WORKFLOW CON MARCADORES:
   │
   ├── comandos genéricos documentados («aquí tu
   │   runner de tests»)
   ├── versiones de actions fijadas (no :main —
   │   sección 20)
   └── mínimo que funcione al primer push (un test
       «hello») para que el recién creado tenga CI
       verde
```

---

## 3. Plantillas de organización

```text
MODELO DE ESCALA:
──────────────────────────────────────────────────────
org → repo de plantillas (o repos «template»)
        │
        ├── plantilla «servicio-web»
        ├── plantilla «librería-python»
        ├── plantilla «datos»
        └── starter workflows compartidos
              │
              └── cada equipo crea desde plantilla →
                  consistencia SIN comité central de
                  configuración
```

```text
QUÉ ESTATURA NECESITA:
   │
   ├── dueño de la plantilla (equipo de plataforma o
   │   guild de arquitectura — mención)
   │
   ├── proceso de cambio: PR en la plantilla →
   │   revisión → anuncio (las plantillas afectan a
   │   los NUEVOS repos; los existentes no se
   │   actualizan solos — documentarlo)
   │
   └── versionado de plantillas: git + changelog
       (sí: las plantillas también tienen versiones)
```

```text
   │
   └── herramienta adicional (mención honesta): los
       Scaffolds/CLIs de organización también generan
       estructura; el criterio es el mismo — fuente
       única y versionada
```

---

## 4. Evitar que la plantilla envejezca

```text
SEÑALES DE RUINA:
   │
   ├── workflow con actions en versiones antiguas
   ├── comandos que ya no existen
   └── nadie la ha abierto en un año
```

```text
HIGIENE:
   │
   ├── PRs de producto que descubren un hueco →
   │   «¿esto va también a la plantilla?»
   │
   ├── revisión trimestral: ejecutar la plantilla
   │   de punta a punta (crear repo de prueba, CI
   │   verde, README rellenable)
   │
   └── dueño asignado + changelog de plantilla
```

```text
   │
   └── la plantilla es infraestructura: se prueba
       como se prueba un deploy
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: plantilla con contenido específico

**Qué ocurrió:** el repo «nuevo» ya traía código, nombre y secretos de otro proyecto.

**Por qué posibles:**
* se marcó como plantilla un repo de producción;
* se copió con git clone en vez de «Use this template».

**Cómo comprobarlo:** contenido del repo de plantilla; historial.

**Opciones:** limpiar la plantilla (otorgar solo forma); reglas de qué puede entrar.

**Riesgos:** fugas de código/datos entre proyectos.

**Solución:** plantilla = estructura + contratos, cero producto (punto 1).

**Cómo se evita:** checklist de creación de plantilla y revisión.

---

### Error 2: starter workflow que no funciona al crear

**Qué ocurrió:** nuevo repo → workflow falla en el primer push (rutas, lenguajes o runners equivocados).

**Por qué:** no se probó el flujo completo.

**Cómo comprobarlo:** crear repo desde plantilla y observar CI.

**Opciones:** arreglar y re-probar; dejar marcadores visibles en el workflow.

**Riesgos:** «CI roja desde el minuto cero» → se ignora desde el minuto cero.

**Solución:** prueba de humo obligatoria (punto 4).

**Cómo se evita:** plantilla CI verde como criterio de publicación.

---

### Error 3: cada equipo con su plantilla privada

**Qué ocurrió:** cinco plantillas distintas; los repos de la org no se parecen.

**Por qué:** no hubo fuente única (o cada quien clonó sin gobernar).

**Cómo comprobarlo:** inventario de repos nuevos; comparar estructuras.

**Opciones:** consolidar en 1-3 plantillas de org; retirar las privadas (documentando).

**Riesgos:** fragmentación creciente.

**Solución:** plantillas de org con dueño (punto 3).

**Cómo se evita:** gobernanza ligera: PR a la plantilla central.

---

### Error 4: plantilla con versiones de actions «a pelo»

**Qué ocurrió:** `uses: accion/algo@main` o tag movible → la plantilla cambia comportamiento sin aviso (o rompe).

**Por qué:** no se fijaron versiones (sección 20).

**Cómo comprobarlo:** leer los `uses:` de los workflows.

**Opciones:** fijar por tag de versión o SHA; renovar con Dependabot de Actions.

**Riesgos:** supply chain y roturas fantasma.

**Solución:** referencias fijas + actualización controlada.

**Cómo se evita:** linter/regla del equipo para workflows.

---

### Error 5: plantilla que nadie actualiza (los repos viejos no se enteran)

**Qué ocurrió:** la plantilla mejora, los 30 repos existentes siguen con lo viejo.

**Por qué posibles:**
* es el comportamiento esperado (la plantilla solo afecta a nuevos);
* nadie lo documentó.

**Cómo comprobarlo:** divergencia entre plantilla y repos.

**Opciones:** documentar «la plantilla es para nuevos»; migraciones por ola cuando algo es crítico (seguridad, CI); scripts de actualización selectiva.

**Riesgos:** frustración («ya lo arreglamos y sigue pasando»).

**Solución:** expectativa clara + plan de migración para cambios críticos.

**Cómo se evita:** nota en el changelog de la plantilla con impacto.

---

### Error 6: plantilla burocrática (demasiado para empezar)

**Qué ocurrió:** para un script de 20 líneas, la plantilla impone 12 carpetas y 4 workflows.

**Por qué:** una talla para todos.

**Cómo comprobarlo:** repos creados y abandonados; quejas del equipo.

**Opciones:** plantillas por tamaño (script / servicio / librería).

**Riesgos:** se evita la plantilla → vuelta al caos.

**Solución:** escala de plantillas (punto 3).

**Cómo se evita:** encuesta: ¿qué usas y qué sobra?

---

## 6. Práctica guiada

### Objetivo

Crear una plantilla de repo con CI base y usarla para nacer un proyecto.

### Paso 1: repo plantilla

```text
1. Crea repo `plantilla-servicio-web` (privado o público según convenga).
2. Marca: «Template repository».
3. Estructura: cap. 01 (src, tests, docs, .github).
```

### Paso 2: contratos rellenables

1. README con marcadores `<!--rellena…-->` y checklist de primeros pasos.
2. LICENSE, CONTRIBUTING, SECURITY, `.github/` con plantillas de issue/PR y CODEOWNERS base.

### Paso 3: workflow base

```yaml
# .github/workflows/ci.yml  (versión mínima)
name: ci
on:
  pull_request:
  push:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      # fija versiones: no uses @main (sección 20)
      - name: Test de humo
        run: echo "sustituye por tu runner de tests"
```

1. Comprueba CI verde en la plantilla.

### Paso 4: crea desde plantilla

1. «Use this template» → `proyecto-demo`.
2. Comprueba: estructura presente, CI corriendo, README por rellenar.

### Paso 5: prueba de humo completa

```text
Rellena el README del nuevo repo, ejecuta los
comandos documentados y marca la checklist:
   │
   ├── [ ] estructura ok
   ├── [ ] CI verde en primer push
   ├── [ ] plantillas de issue/PR visibles
   └── [ ] contratos adaptados (no copiados tal cual)
```

### Paso 6: gobernanza

1. Escribe quién es dueño de la plantilla y cómo se propone un cambio (PR + anuncio).

### Resultado esperado

Plantilla publicada con CI verde y un proyecto nacido de ella en < 10 minutos.

### Conclusión esperada

La plantilla es el «setup de máquina» del equipo: una sola fuente, probada de punta a punta y con dueño.

---

## 7. Nivel profesional + resumen

### 7.1. Fábrica de repositorios

```text
   │
   ├── plantillas por tipo (script/servicio/librería/
   │   datos) en la org, con changelog y dueño
   │
   ├── starter workflows estandarizados (CI, release,
   │   seguridad) con versiones fijas
   │
   ├── prueba de humo trimestral: crear → CI verde →
   │   README rellenable
   │
   ├── los cambios críticos (seguridad) vienen con
   │   plan de migración a los repos existentes
   │
   └── métrica: tiempo de creación de repo nuevo
       (minutos, no días)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* los repos con plantilla crean proyectos nuevos limpios con estructura, contratos y `.github/` prearmados;
* los starter workflows estandarizan Actions: CI base con versiones fijadas y marcadores claros;
* las plantillas de organización escalan la consistencia con dueño, changelog y proceso de cambio (PR + anuncio);
* la plantilla envejece: se prueba de punta a punta y se mantiene; los repos existentes no se auto-actualizan (documentado);
* los errores típicos (plantilla con producto, CI roja de nacimiento, plantillas fragmentadas, actions sin fijar, desfase con repos viejos, plantilla burocrática) se previenen con diseño y humo;
* a nivel profesional: fábrica de repos con métrica de tiempo de creación.

La idea principal es:

> **Lo que se repite se estandariza: la planta de un repo profesional es un artefacto versionado, probado y con dueño — no una carpeta copiada de un proyecto antiguo.**

---

## Próximo paso

Ya fabricas repos con forma.

El siguiente capítulo protege los que ya existen: reglas de rama y reglas de repositorio.

Continúa con:

[`03-proteccion-de-ramas-y-rulesets.md`](03-proteccion-de-ramas-y-rulesets.md)
