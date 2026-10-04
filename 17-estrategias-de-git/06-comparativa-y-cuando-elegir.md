# Comparativa y cuándo elegir

## Introducción

GitHub Flow, Git Flow, Trunk-Based — no hay estrategia ganadora universal. Hay estrategias que encajan con tu modelo de entrega, tu tamaño de equipo y tu madurez de CI. Elegirla es una decisión técnica con consecuencias operativas; cambiarla también.

Este capítulo cierra la sección comparando los flujos en una sola tabla, dando un árbol de decisión y mostrando cómo evaluar (y evolucionar) el flujo de tu equipo sin dogmas.

---

## Mapa conceptual de este capítulo

```text
Comparativa y cuándo elegir
       │
       ├── 1. Tabla comparativa
       ├── 2. Árbol de decisión
       ├── 3. Factores que inclinan la balanza
       ├── 4. Evolucionar (o cambiar) de flujo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Tabla comparativa

```text
CRITERIO        GitHub Flow   Git Flow      Trunk-Based
────────────────────────────────────────────────────────
ramas vivas     1 por cambio   5 tipos       main (horas)
base            main          develop       main
releases        desde main    release/*     desde main
estabilizar     flag/freeze   nativo        flag/freeze
soporte vers.   poco          natural       por política
ceremonia       baja          alta          media (culta)
exige CI        fuerte        media         muy fuerte
conflictos      bajos*        medios*       mínimos*
flags           opcionales    opcionales    casi obligatorios
app web cont.   EXCELENTE     excesivo      EXCELENTE
versión/tienda  funcional     EXCELENTE     funcional
equipo pequeño  ideal         pesado        si hay CI
```

```text
* los conflictos dependen de la sincronización
  (cap. 04): el flujo no elimina la disciplina
```

```text
LO QUE COMPARTEN TODOS:
   │
   ├── main/producción protegido (PR + checks)
   ├── integración frecuente > integración épica
   ├── rama con nombre y propósito
   └── decisión escrita: sin política, el flujo es
       una opinión
```

---

## 2. Árbol de decisión

```text
¿Tu software se despliega a demanda (web/servicio
con deploy frecuente)?
   │
   ├── SÍ → ¿CI < 10 min y equipo disciplinado?
   │         ├── SÍ → ¿te animas con flags?
   │         │        ├── SÍ → Trunk-Based
   │         │        └── NO → GitHub Flow
   │         └── NO → GitHub Flow (primero arregla
   │                   CI — sección 19)
   │
   └── NO (versiones con número/calendario:
       móvil/escritorio/entrega)
            │
            ├── ¿soportas varias versiones a la vez?
            │      ├── SÍ → Git Flow (o GitHub Flow +
            │      │         release branches)
            │      └── NO → Git Flow ligero o GitHub
            │                Flow con ventana de release
            │
            └── ¿el equipo es novato en Git?
                     └── empieza por GitHub Flow y
                         crece (no adopts ceremonia que
                         no puedes sostener)
```

```text
   │
   └── híbridos LEGÍTIMOS: GitHub Flow + feature flags
       para release graduales; Git Flow + PRs/CI como
       sección 15; trunk con release candidates
```

---

## 3. Factores que inclinan la balanza

```text
INCLINAN A FLUJO SIMPLE (GitHub Flow / trunk ligero)
   │
   ├── deploy continuo / equipo pequeño
   ├── producto sin versiones numeradas
   ├── CI madura y revisión ágil
   └── cultura de PRs pequeños
```

```text
INCLINAN A GIT FLOW (o release branches)
   │
   ├── versiones publicadas en tiendas/entregadas
   ├── soporte de versiones anteriores
   ├── QA/ventana de estabilización por release
   └── departamentos que consumen «la versión X»
```

```text
INCLINAN A TRUNK-BASED
   │
   ├── deploy a diario con CD (sección 22)
   ├── equipo experimentado, tests excelentes
   ├── integración diaria como objetivo cultural
   └── capacidad de flags y rollback (sección 29)
```

```text
FACTORES HUMANOS (deciden tanto como los técnicos):
   │
   ├── experiencia media del equipo con Git
   ├── hábito de revisión (¿hay SLA?)
   ├── tamaño: >10 programadores → más disciplina de
   │   integración (trunk con ramas-hora o flujo
   │   estricto)
   └── regulatorio/auditoría → trazabilidad fuerte
       (Git Flow + tags + firmas)
```

---

## 4. Evolucionar (o cambiar) de flujo

```text
POR QUÉ CAMBIA UN FLUJO:
   │
   ├── crecimiento del equipo
   ├── de «proyecto» a «producto con releases» (o al
   │   revés: de versión a deploy continuo)
   ├── incidentes que revelaron debilidad
   └── mergers/adopción de plantillas de organización
```

```text
CÓMO MIGRAR (ritual de cambio, 5 pasos)
──────────────────────────────────────────────────────
1. diagnostica: ¿dónde duele hoy? (ramas largas?
   releases lentas? main roto?)
2. elige con criterio del árbol (punto 2) — una
   sola dirección
3. escribe la política en CONTRIBUTING (base, ramas,
   integración, release)
4. protege/ajusta ramas en la plataforma (sección 18)
5. comunica + piloto en 1-2 equipos/repos + revisión
   a 30 días
```

```text
   │
   ├── cambiar de flujo es cambio de proceso: pide
   │   retro (¿mejoró lo que dolía?)
   │
   └── conserva lo que funciona: el flujo no es
       identidad, es herramienta
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: elegir por moda («en X lo hacen así»)

**Qué ocurrió:** el equipo copió el flujo de una empresa grande sin tener su CI ni su tamaño.

**Por qué posibles:**
* autoridad del artículo/blog;
* pereza de evaluar contexto.

**Cómo comprobarlo:** ¿se puede señalar qué dolor resuelve en TU caso?

**Opciones:** volver al flujo simple y elegir de nuevo con el árbol (punto 2).

**Riesgos:** ceremonia sostenida a medias → peor que cualquier flujo.

**Solución:** decisión con factores (punto 3) escrita.

**Cómo se evita:** revisión del flujo en la retro de adopción.

---

### Error 2: flujo «a la carta» (cada quien el suyo)

**Qué ocurrió:** unos con develop, otros con trunk, otros sin PRs → la base es un misterio.

**Por qué:** nunca hubo decisión única (o no se comunicó).

**Cómo comprobarlo:** bases de los PR; ramas activas.

**Opciones:** decretar UN flujo (cap. 04 de migración), ajustar ramas, acompañar dos semanas.

**Riesgos:** incompatibilidad permanente entre ramas.

**Solución:** política única por organización/repo.

**Cómo se evita:** onboarding con «así trabajamos aquí».

---

### Error 3: cambiar de flujo a mitad de release

**Qué ocurrió:** a mitad de la ventana de release se decretó otro flujo → caos de ramas.

**Por qué:** timing sin considerar compromisos.

**Cómo comprobarlo:** ramas abiertas a mitad de la migración.

**Opciones:** esperar al cierre de la ventana (o migrar SOLO repos nuevos primero).

**Riesgos:** release rota + desconfianza en el proceso.

**Solución:** migrar en transición limpia (punto 4, paso 1-2 con calendario).

**Cómo se evita:** plan de cambio con «cuándo NO» (no a mitad de entrega).

---

### Error 4: elegir sin mirar la madurez de CI

**Qué ocurrió:** se adoptó trunk/CI obligatoria pero los tests tardan 40 min y son frágiles → nadie integra.

**Por qué:** el árbol de decisión empezó por la filosofía, no por la infraestructura.

**Cómo comprobarlo:** duración/fiabilidad del CI.

**Opciones:** paso 0: invertir en suite rápida (sección 19); flujo simple mientras tanto.

**Riesgos:** rechazo al flujo por problemas de otra cosa.

**Solución:** madurez primero (cap. 03 punto 3).

**Cómo se evita:** checklist de requisitos antes de firmar la política.

---

### Error 5: política escrita que nadie lee

**Qué ocurrió:** CONTRIBUTING tiene 3 líneas de flujo de 2021; la práctica real es otra.

**Por qué:** escribir sin revisar ni formar.

**Cómo comprobarlo:** pedir a 3 personas que expliquen el flujo; comparar con el doc.

**Opciones:** reescribir con el equipo; enseñar en el onboarding; revisar en retro.

**Riesgos:** doc fantasma (peor que no tener: da falsa certeza).

**Solución:** la política vive donde se trabaja (CONTRIBUTING + ajustes de plataforma alineados).

**Cómo se evita:** dueño del flujo y revisión anual.

---

### Error 6: medir el flujo en vez de su propósito

**Qué ocurrió:** discusiones sobre «cuántos commits» o «si el merge debe ser rebase» en vez de «¿entregamos sin sorpresas?».

**Por qué:** se confunde herramienta con objetivo.

**Cómo comprobarlo:** ¿las métricas hablan de tiempos/rojos/ramas viejas o de forma?

**Opciones:** volver a objetivos: tiempo a producción, main rojo, incidentes.

**Riesgos:** burocracia sin valor.

**Solución:** el flujo se juzga por RESULTADOS (punto 7).

**Cómo se evita:** retro con métricas de proceso (sección 15 cap. 06).

---

## 6. Práctica guiada

### Objetivo

Evaluar el flujo de tu proyecto real y escribir la decisión.

### Paso 1: diagnóstico

```text
Responde por escrito:
   │
   ├── ¿cómo se despliega hoy? (a demanda / versión)
   ├── ¿cuánto tarda tu CI? ¿es fiable?
   ├── ¿edad media de ramas abiertas?
   ├── ¿release con calendario o cuando esté?
   └── ¿qué dolió en el último incidente/entrega?
```

### Paso 2: árbol de decisión

1. Recorre el árbol del punto 2 con tus respuestas.
2. Anota la opción saliente y las alternativas descartadas (con razón).

### Paso 3: requisitos

```text
Checklist de lo que tu flujo elegido EXIGE:
   │
   ├── protección de rama + checks
   ├── cadencia de sincronización (cap. 04)
   ├── (si trunk) flags con dueño
   └── (si Git Flow) checklist de release/hotfix
   Marca lo que falta → es tu plan previo.
```

### Paso 4: escribe la política

```markdown
## Flujo de trabajo (CONTRIBUTING)
- Base: main; ramas: feat/*, fix/* (vida < 1 semana)
- Integración: PR + 1 aprobación + checks
- Release: semver desde main; tag + changelog
- Hotfix: rama fix/* → PR acelerado (sección 29)
- (…) elegido el YYYY-MM-DD tras revisión de contexto
```

### Paso 5: alinea la plataforma

1. Rama base protegida, opciones de merge según política (sección 15 cap. 05), «delete branch after merge».

### Paso 6: fecha de revisión

1. Agenda la retro del flujo a 30 días: ¿mejoró lo que dolía?

### Resultado esperado

Decisión de flujo escrita con requisitos, alineación de plataforma y fecha de evaluación.

### Conclusión esperada

Elegir un flujo es elegir un conjunto de costes: el correcto es el que tu equipo puede sostener y medir.

---

## 7. Nivel profesional + resumen

### 7.1. Gobernanza de flujos

```text
   │
   ├── decisión documentada con contexto y fecha
   │   (como un ADR de arquitectura — sección 14)
   │
   ├── requisitos previos explícitos (CI, cultura,
   │   flags) antes de decretar
   │
   ├── piloto + retro a 30 días + dueño del flujo
   │
   ├── métricas de propósito: tiempo de entrega,
   │   main rojo, edad de ramas, incidentes
   │
   └── revisión anual o al cambio de fase del
       producto
```

### 7.2. Resumen

En este capítulo aprendiste que:

* los tres flujos responden a modelos de entrega distintos: web/servicio → flujo simple; versiones/calendario → Git Flow; deploy diario maduro → trunk;
* el árbol de decisión empieza por «¿cómo se despliega?» y sigue por madurez de CI y capacidad de flags;
* los factores humanos (experiencia, hábito de revisión, tamaño) inclinan tanto como los técnicos;
* migrar exige diagnóstico, política escrita, ajuste de plataforma, comunicación y retro — nunca a mitad de una entrega;
* los errores típicos (moda, flujo a la carta, timing, ignorar CI, doc fantasma, medir la forma) se previenen con criterio y métricas de propósito;
* a nivel profesional: la decisión de flujo es un ADR con fecha y revisión.

La idea principal es:

> **No elijas el flujo más moderno: elige el que tu equipo pueda sostener con lo que hoy tiene — y escríbelo, para que sea una decisión y no una costumbre.**

---

## Próximo paso

Has completado la sección de estrategias de Git.

Continúa con el cierre de la sección:

[`README.md`](README.md)
