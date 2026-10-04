# Pipelines y builds

## Introducción

El **pipeline** es la cadena de pasos que convierte tu commit en un artefacto verificado; el **build** es la transformación de código fuente en algo ejecutable. Aunque la sección 19 construyó los workflows, aquí miramos el pipeline como diseño: etapas, dependencias entre jobs, matrices, construcción reproducible y cómo el artefacto viaja entre etapas hasta estar listo para entregar.

---

## Mapa conceptual de este capítulo

```text
Pipelines y builds
       │
       ├── 1. Del commit al artefacto
       ├── 2. Diseño de etapas y dependencias
       │   ├── 3. Builds reproducibles
       │   ├── 4. Matrices y paralelismo
       │   └── 5. Artefactos entre etapas
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Del commit al artefacto

```text
PIPELINE TIPO (cierra el flujo de la sección 00):
──────────────────────────────────────────────────────
commit → push → install → calidad → build → tests
        → security checks → ARTEFACTO (listo para
          entregar — cap. 04)
```

```text
QUÉ ES UN «BUILD» SEGÚN EL PROYECTO:
   │
   ├── frontend: bundle/estáticos compilados
   ├── backend: imagen contenedor / binario / paquete
   ├── librería: paquete publicable (wheel/npm/pkg)
   └── datos/modelo: dataset procesado / modelo
       entrenado (sección 21)
```

```text
   │
   └── el artefacto del build es la MATERIA de la
       entrega: lo que se prueba y se despliega es
       esto, no tu carpeta de trabajo
```

---

## 2. Diseño de etapas y dependencias

```text
EN GRAPHO (jobs y needs — sección 19 cap. 03):
   │
   ├── quality ──┐
   ├── test  ────┼──→ package (build final)
   └── security ─┘
                    │
                    └──→ (cap. 04: a staging)
```

```text
REGLAS DE DISEÑO:
   │
   ├── dependencias mínimas: si dos jobs no se
   │   necesitan, corren en paralelo
   │
   ├── el build final DESPUÉS de lo que lo valida
   │
   ├── nada de «job que hace todo»: cada etapa con su
   │   propósito (falla localizable)
   │
   └── etapas declaradas en el código (workflow
       versionado — revisable como cualquier feature)
```

```text
ARTIFACTOS DE ETAPA:
   │
   ├── cada job deja sus salidas (test reports, build)
   │   para el siguiente y para auditar (punto 5)
   │
   └── el paso siguiente consume lo que el anterior
       produjo — misma pieza, no «reconstruir de
       otra forma» (Error 3)
```

---

## 3. Builds reproducibles

```text
QUÉ ES:
   │
   └── mismo código + misma receta → mismo artefacto
       (con diferencias controladas)
```

```text
CÓMO SE CONSIGUE:
   │
   ├── lockfiles (instalación exacta — sección 21)
   ├── versiones fijas de intérpretes/compiladores
   ├── contenedores de build con versión/digest fija
   │   (sección 20 cap. 05)
   ├── receta de build versionada (Dockerfile, config)
   └── nada de «en mi laptop sale distinto»: el build
       vive en CI (sección 21 cap. 02)
```

```text
POR QUÉ IMPORTA:
   │
   ├── lo probado = lo desplegado (si el build cambia
   │   entre etapas, ¿qué probaste?)
   │
   ├── auditoría: «este binario salió de este commit»
   │   (trazabilidad — sección 20 cap. 05)
   │
   └── rollback posible (cap. 06): solo si puedes
       volver a un artefacto conocido
```

```text
   │
   └── la meta pragmática: suficientemente
       reproducible para confiar — perfecto es
       «misma receta, mismo resultado» verificable
```

---

## 4. Matrices y paralelismo

```text
MATRICES (strategy.matrix):
   │
   ├── correr el MISMO paso con variantes: versiones
   │   de SO/lenguaje/navegador
   │
   └── ej: tests en node 20 y 22 → 2 jobs en paralelo
```

```text
CUÁNDO PARALELIZAR:
   │
   ├── variantes (matriz) — siempre que el coste lo
   │   permita
   ├── suites grandes por módulo/categoría
   └── calidad y tests en paralelo (si no se
       necesitan)
```

```text
CUÁNDO NO:
   │
   ├── si el cuello de botella es una cola de
   │   runners de pago (más paralelo = más coste)
   │
   └── si el resultado depende de orden (tests que
       comparten estado → primero se arreglan —
       sección 19 cap. 06)
```

```text
   │
   └── paralelismo es acelerar; secuencia es
       corrección — decide con datos (tiempos por job)
```

---

## 5. Artefactos entre etapas

```text
PATRÓN:
   │
   ├── job A construye → sube artefacto (upload)
   │
   └── job B (o entorno posterior) lo descarga
       (download) y lo prueba/despliega — MISMA pieza
```

```text
DISCIPLINA:
   │
   ├── el artefacto viaja con su identidad: versión +
   │   commit (sección 18 cap. 04 / cap. 05 de esta
   │   sección)
   │
   ├── retención corta para CI (sección 19 cap. 05)
   │
   └── nada sensible dentro (sección 19 cap. 05)
```

```text
   │
   └── «testea el artefacto, no la reconstrucción» es
       la regla que separa pipelines profesionales de
       artesanales (Error 3)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: pipeline monolítico «de un solo job»

**Qué ocurrió:** un solo job de 40 minutos; si fallaba en el minuto 39 se reejecutaba todo.

**Por qué:** se escribió como script único sin diseño de etapas (punto 2).

**Cómo comprobarlo:** nº de jobs; tiempos; qué se re-ejecuta en «re-run failed».

**Opciones:** partir en jobs con dependencias; caché por job; paralelizar.

**Riesgos:** feedback lento y reintentos caros.

**Solución:** grafo de etapas (punto 2).

**Cómo se evita:** plantilla con estructura de jobs (sección 19).

---

### Error 2: el build cambia entre probar y desplegar

**Qué ocurrió:** los tests pasaron con el build de CI y el despliegue reconstruyó «igualito» — y no era igual.

**Por qué:** dos recetas distintas (Error 3 relacionado).

**Cómo comprobarlo:** ¿el deploy usa el artefacto del pipeline o vuelve a compilar?

**Opciones:** desplegar SIEMPRE el artefacto probado (punto 5).

**Riesgos:** probar A, entregar B.

**Solución:** build único y reproducible (punto 3/5).

**Cómo se evita:** revisar el flujo de despliegue (cap. 04).

---

### Error 3: tests que no prueban el artefacto

**Qué ocurrió:** la suite pasaba sobre el código fuente, pero el paquete empaquetado fallaba en producción.

**Por qué:** el empaquetado era un paso posterior nunca testeado (punto 5).

**Cómo comprobarlo:** ¿el CI prueba el artefacto construido (imagen/paquete)?

**Opciones:** añadir smoke test sobre el artefacto (cap. 04).

**Riesgos:** el fallo sale en producción.

**Solución:** probar lo que se entrega (punto 5).

**Cómo se evita:** checklist de pipeline.

---

### Error 4: versiones móviles en el build

**Qué ocurrió:** «latest» de un compiler/imagen base cambió y el build se rompió sin commits.

**Por qué:** sin fijado (sección 20 cap. 05).

**Cómo comprobarlo:** grep de latest/`@main`/tags móviles en el workflow y Dockerfile.

**Opciones:** fijar versión/digest; renovación controlada.

**Riesgos:** cambios fantasma.

**Solución:** receta fijada (punto 3).

**Cómo se evita:** checklist (sección 19 cap. 05).

---

### Error 5: artefactos con nombres ambiguos

**Qué ocurrió:** `app-latest.tar` existía en tres versiones y alguien desplegó la vieja.

**Por qué:** sin identidad en el artefacto (punto 5).

**Cómo comprobarlo:** cómo se nombran y etiquetan los artefactos.

**Opciones:** versión + commit en el nombre/metadatos; flujo de promoción (cap. 05).

**Riesgos:** «¿qué se desplegó?» sin respuesta.

**Solución:** identidad obligatoria (punto 5).

**Cómo se evita:** plantilla de release (sección 18 cap. 04).

---

### Error 6: matrices caras sin necesidad

**Qué ocurrió:** 6 versiones × 2 SO en cada PR; el coste se triplicó y nadie miraba los resultados de variantes raras.

**Por qué:** matrices por precaución, sin criterio (punto 4).

**Cómo comprobarlo:** duración/coste por matriz; cuándo se usó la info de la variante X.

**Opciones:** variantes completas en main/schedule; en PR solo la versión principal.

**Riesgos:** coste y tiempos inflados.

**Solución:** paralelismo con datos (punto 4).

**Cómo se evita:** revisión de coste en la retro.

---

## 7. Práctica guiada

### Objetivo

Reconstruir un pipeline como grafo de etapas con artefacto único.

### Paso 1: mapa actual

```text
Dibuja tu pipeline actual: jobs, dependencias y
tiempos. ¿Qué es un job que hace cinco cosas?
```

### Paso 2: grafo

```text
quality (lint)  ──┐
test (unit)  ─────┼──→ package (build + smoke)
security (opc.) ──┘
```

1. Implementa con `needs:` y comprueba que los independientes corren en paralelo.

### Paso 3: artefacto único

1. `package` sube el artefacto con nombre `app-<version>+<sha>` (o metadatos equivalentes).
2. Añade un smoke test que ejecute/inspeccione ESA pieza.

### Paso 4: reproducibilidad

1. Fija versiones de intérprete/imagen base (punto 3).
2. Ejecuta el pipeline dos veces seguidas: ¿mismo resultado? (compáralo en la medida de lo posible).

### Paso 5: matriz con criterio

1. Añade una matriz SOLO de variantes que te importen en main; en PR, versión única.

### Paso 6: documenta

```markdown
## Pipeline
| Job | Qué verifica | Duración | Artefacto |
|-----|--------------|----------|-----------|
| quality | lint/format | ... | — |
| test | unit + integration | ... | report |
| package | build + smoke | ... | app-x+sha |
```

### Resultado esperado

Grafo por etapas, artefacto identificado y smoke test sobre la pieza real.

### Conclusión esperada

Un buen pipeline es una cadena de evidencias: cada etapa deja su rastro y el artefacto final es el mismo que se probó.

---

## 8. Nivel profesional + resumen

### 8.1. Pipelines a escala

```text
   │
   ├── workflows reutilizables por plantilla (sección
   │   19/25): el pipeline «de la casa» con puntos de
   │   extensión
   │
   ├── builds en contenedores con receta fija (sección
   │   20/23)
   │
   ├── artefactos con identidad + SBOM (sección 20
   │   cap. 05) generados en package
   │
   ├── métricas: duración por etapa, coste por PR,
   │   tasa de reproducibilidad del build
   │
   └── presupuesto de coste de CI (equipo/organización
       — sección 26)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* el pipeline convierte commit en artefacto verificado; las etapas son un grafo con dependencias mínimas;
* builds reproducibles: lockfiles, versiones fijadas, receta versionada — probar = entregar;
* matrices para variantes; paralelismo con criterio y datos;
* artefactos entre etapas: la misma pieza viaja, con identidad (versión+commit);
* los errores típicos (monolito, build distinto, probar otra cosa, versiones móviles, nombres ambiguos, matrices caras) se previenen con diseño y disciplina;
* a nivel profesional: plantillas, SBOM en package y métricas de coste.

La idea principal es:

> **El pipeline es una cadena de evidencias: si el artefacto que despliegas no es exactamente el que probaste, todo lo anterior — tests, revisiones, escaneos — se aplica a otra cosa.**

---

## Próximo paso

Ya construyes artefactos fiables.

Ahora cómo las pruebas se organizan dentro de esa cadena.

Continúa con:

[`03-pruebas-automatizadas-en-la-entrega.md`](03-pruebas-automatizadas-en-la-entrega.md)
