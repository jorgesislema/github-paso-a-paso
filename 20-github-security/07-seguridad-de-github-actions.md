# Seguridad de GitHub Actions

## Introducción

La sección 19 enseñó a construir y endurecer workflows; este capítulo mira Actions como **superficie de ataque propia**: environments y sus aprobaciones, credenciales de corta vida con OIDC, artefactos y cachés como vector, y auditoría de automatizaciones. El objetivo es que tu CI/CD sea el eslabón que no se rompe — porque comprometer tu pipeline es comprometer tu siguiente release.

---

## Mapa conceptual de este capítulo

```text
Seguridad de GitHub Actions
       │
       ├── 1. La amenaza: qué gana quien compromete tu
       │   │   pipeline
       │   ├── 2. Environments: el control de despliegue
       │   ├── 3. OIDC: credenciales sin secreto largo
       │   ├── 4. Artefactos, cachés y ejecución
       │   └── 5. Auditoría de workflows
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. La amenaza: qué gana quien compromete tu pipeline

```text
SI CONTROLAN TU WORKFLOW CONTROLAN:
   │
   ├── tu código en el runner (lectura)
   ├── tus secretos (si el workflow los usa)
   ├── tus credenciales de despliegue (si vive ahí)
   ├── el artefacto que publicas (inyectar código en
   │   tu release)
   └── en el peor caso: tu organización (token con
       permisos, registros, packages)
```

```text
VETAS DE ATAQUE (recap + ampliación):
   │
   ├── code del PR con privilegios (sección 19 cap. 05)
   ├── actions sin fijar (cap. 05 sección 20)
   ├── secretos impresos o en artefactos (sección 19)
   ├── environment sin aprobación (punto 2)
   └── workflow editable por quien no debería (punto 5)
```

```text
   │
   └── principio: el workflow que despliega es más
       sensible que el que testea — gobiérnalos como
       si fueran producción (porque desproducen)
```

---

## 2. Environments: el control de despliegue

```text
QUÉ ES UN ENVIRONMENT:
   │
   ├── ámbito con: secretos propios, protecciones y
   │   quién puede aprobar un despliegue
   │
   └── ejemplos: staging, production — el job declara
       `environment: production` y hereda sus reglas
```

```text
PROTECCIONES ÚTILES:
   │
   ├── aprobación requerida (personas/teams concretos)
   │
   ├── ramas desde las que se puede desplegar
   │   (solo main/tags)
   │
   ├── ventana de espera (tiempo de pensar tras
   │   aprobar)
   │
   └── secretos SOLO del environment (el job de test
       no los ve — secreto por ámbito, sección 19
       cap. 04)
```

```yaml
# en el job de despliegue:
# environment: production   ← activa sus reglas
```

```text
   │
   └── el environment convierte «desplegar» en un acto
       consciente con firma humana: es la barrera entre
       «CI verde» y «va a producción»
```

---

## 3. OIDC: credenciales sin secreto largo

```text
PROBLEMA CLÁSICO:
   │
   └── para publicar en la nube necesitas una
       credencial → si es un secret de Actions, es un
       secreto estático de largo plazo (cap. 01)
```

```text
OIDC (identidad federada — concepto):
   │
   ├── la plataforma emite un token corto que la nube
   │   confía (confianza configurada en la nube: quién
   │   puede asumir qué rol)
   │
   ├── el workflow pide `id-token: write` y obtiene
   │   credencial efímera SIN secreto guardado
   │
   └── condición de confianza típica: repo + rama +
       environment («solo production de mi repo»)
```

```text
VENTAJAS:
   │
   ├── nada que robar en el repo (no hay secreto)
   ├── alcance por condición (no vale para otro repo)
   └── caducidad en segundos/minutos
```

```text
   │
   └── mención: el detalle de configuración por
       proveedor está en la documentación actual de
       cada nube — el patrón es este (sección 22 lo
       usa en despliegue)
```

---

## 4. Artefactos, cachés y ejecución

```text
ARTEFACTOS:
   │
   ├── son descargables por quien tenga acceso → nada
   │   sensible dentro (sección 19 cap. 05 Error 5)
   │
   └── retención corta (los tuyos de CI no son
       archivo histórico — cap. 05 sección 19 Error 3)
```

```text
CACHÉ:
   │
   ├── se restaura en ejecuciones → un cache-poisoning
   │   es un vector conocido: caches maliciosas
   │   restauradas en pipelines con privilegios
   │
   └── defensas: qué guarda tu caché (¿solo deps?), de
       qué ejecuciones se rellena (rama base vs. PR de
       forqueado) — revisa el alcance de la herramienta
       de cache que uses
```

```text
EJECUCIÓN (runners):
   │
   ├── GitHub-hosted: efímeros y parcheados por la
   │   plataforma (menos mantenimiento tuyo)
   │
   ├── self-hosted: tu SO, tus parches, tu red — y si
   │   corren en un repo abierto a PRs externos, son
   │   el objetivo soñado (regla: self-hosted solo
   │   para flujos internos/de confianza)
   │
   └── etiquetas: etiqueta «ubuntu-latest» es pública;
       etiquetas propias = acceso controlado
```

---

## 5. Auditoría de workflows

```text
QUÉ SE AUDITA:
   │
   ├── quién cambió .github/workflows/ (historial +
   │   dueño por CODEOWNERS — sección 16 cap. 06)
   │
   ├── patrones peligrosos: pull_request_target, uses:
   │   sin fijar, permissions amplias (sección 19
   │   cap. 05)
   │
   ├── environments: quién aprueba production
   │
   └── eventos de la organización: cambios de settings
       de Actions (audit log de org — plan
       correspondiente)
```

```text
CHECKLIST DE RELEASE DE UN WORKFLOW:
   │
   ├── [ ] permissions mínimas
   ├── [ ] actions fijadas
   ├── [ ] secretos solo en environment
   ├── [ ] deploy tras aprobación
   └── [ ] artefactos sin datos sensibles
```

```text
   │
   └── el workflow es código con poder: se revisa en
       PR como cualquier feature (Error 6 si no)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: secreto de producción usado por todos los jobs

**Qué ocurrió:** el token de despliegue estaba disponible en el job de tests; un step comprometido lo copió.

**Por qué:** secret a nivel repo en vez de environment.

**Cómo comprobarlo:** dónde se define y quién lo referencia.

**Opciones:** mover el secreto al environment y solo al job de deploy (punto 2).

**Riesgos:** el job menos sensible tenía el secreto más sensible.

**Solución:** secreto por ámbito (punto 2).

**Cómo se evita:** revisión de workflows (punto 5).

---

### Error 2: despliegue sin aprobación

**Qué ocurrió:** cualquier merge a main publicó en producción automáticamente y un mal merge llegó a usuarios.

**Por qué:** environment sin protecciones o sin declarar.

**Cómo comprobarlo:** settings del environment; `environment:` en el job.

**Opciones:** añadir aprobación + rama permitida; si el proyecto es de entrega continua deliberada, al menos ambiente con gates de calidad (decisión consciente documentada).

**Riesgos:** cero humano en el paso crítico.

**Solución:** environment como control (punto 2).

**Cómo se evita:** plantilla de release (sección 18).

---

### Error 3: credencial estática de nube en secret

**Qué ocurrió:** una access key de larga duración vivía en el repo (y su alcance era amplio).

**Por qué:** se siguió el tutorial antiguo.

**Cómo comprobarlo:** qué secretos de deploy existen y qué usan.

**Opciones:** migrar a OIDC con condición repo+environment (punto 3); revocar la clave estática.

**Riesgos:** secreto que vale para siempre y para mucho.

**Solución:** credencial efímera (punto 3).

**Cómo se evita:** checklist de despliegue.

---

### Error 4: self-hosted runner expuesto a PRs externos

**Qué ocurrió:** un runner propio en un repo con PRs de forqueados ejecutó código de un forqueado en la red interna.

**Por qué:** se buscó «gratis y rápido» sin mirar el modelo de confianza.

**Cómo comprobarlo:** qué etiquetas/recursos corren flujos de PR externos.

**Opciones:** reservar self-hosted a flujos internos; GitHub-hosted para externos; etiquetas con acceso controlado (punto 4).

**Riesgos:** puerta a la red interna.

**Solución:** confianza acorde al runner (punto 4).

**Cómo se evita:** política escrita de runners.

---

### Error 5: cache poisoning por restauración ciega

**Qué ocurrió:** una caché rellenada en un contexto de menor confianza se restauró en un pipeline con privilegios.

**Por qué:** caché compartida sin pensar en quién la escribe.

**Cómo comprobarlo:** qué usa tu herramienta de caché y de dónde hereda; qué metes en el cache (¿solo dependencias de lockfile?).

**Opciones:** acotar contenidos a artefactos deterministas (lockfile); evitar cache de binarios sensibles; separar ámbitos si la herramienta lo permite.

**Riesgos:** ejecución indirecta de contenido ajeno.

**Solución:** caché = deps conocidas (punto 4).

**Cómo se evita:** revisión de workflows que añaden caché.

---

### Error 6: workflow crítico sin dueño ni revisión

**Qué ocurrió:** el release workflow se editó «rápido» por una persona sin revisión y sin CODEOWNERS.

**Por qué:** no se consideró código sensible.

**Cómo comprobarlo:** ¿CODEOWNERS cubre .github/workflows? ¿los PRs lo asignan?

**Opciones:** añadir dueño; exigir revisor; regla de «nadie aprueba su propio cambio de release».

**Riesgos:** cambio silencioso en el camino de producción.

**Solución:** workflows = producción (punto 1/5).

**Cómo se evita:** checklist de repos (sección 18).

---

## 7. Práctica guiada

### Objetivo

Blindar el camino de despliegue de tu proyecto de práctica.

### Paso 1: environments

1. Crea `production` con: secretos propios (si tienes), aprobación requerida (tu usuario o un equipo), rama permitida `main`.
2. Apunta `environment: production` al job de deploy de tu workflow.

### Paso 2: prueba de aprobación

1. Haz un push a main que dispare el deploy: observa el job «esperando aprobación» y apruébalo.
2. Verifica que el job de tests NO tiene acceso a los secretos de production.

### Paso 3: OIDC (si usas nube)

```text
   │
   ├── busca en tu proveedor: «trust relationship con
   │   GitHub OIDC» (la condición: tu repo + rama +
   │   environment)
   ├── en el workflow: permiso id-token: write solo al
   │   job de deploy
   └── elimina la clave estática que había
```

### Paso 4: auditoría

```bash
grep -rn "uses:" .github/workflows/
grep -rn "permissions:" .github/workflows/
grep -rn "pull_request_target" .github/workflows/
git log --oneline -- .github/workflows/   # quién tocó
```

1. Aplica la checklist del punto 5; corrige lo que encuentres.

### Paso 5: dueño

1. Añade `.github/workflows/` a CODEOWNERS con tu equipo (sección 16 cap. 06).

### Paso 6: política

```markdown
## Seguridad de Actions
- Secretos de deploy: solo en environment production
- Deploy: con aprobación; rama main
- Credenciales nube: OIDC (sin claves estáticas)
- self-hosted: solo flujos internos (nunca PR externos)
- Workflows críticos: CODEOWNERS + revisión
```

### Resultado esperado

Despliegue con aprobación, secretos acotados, OIDC donde aplique y workflows auditados.

### Conclusión esperada

La última milla del código es la más sensible: environments, credenciales efímeras y dueño convierten la automatización en algo que también se audita.

---

## 8. Nivel profesional + resumen

### 8.1. Programa de seguridad de CI/CD

```text
   │
   ├── environments por entorno con aprobaciones y
   │   ventanas
   │
   ├── OIDC en todo despliegue a nube (sección 22);
   │   cero claves estáticas de largo plazo
   │
   ├── runners: GitHub-hosted por defecto; self-hosted
   │   con red segregada y solo flujos internos
   │
   ├── caches: contenido determinista de lockfiles;
   │   artefactos con retención corta
   │
   ├── workflows: CODEOWNERS + revisión + checklist de
   │   seguridad (sección 19)
   │
   └── métrica: despliegues con aprobación (%), nº de
       secretos estáticos restantes, cambios de workflow
       sin revisión
```

### 8.2. Resumen

En este capítulo aprendiste que:

* comprometer el pipeline es comprometer el release: los workflows se gobiernan como producción;
* environments acotan secretos, ramas y personas que aprueban cada despliegue;
* OIDC sustituye secretos estáticos por credenciales efímeras con condición (repo + rama + environment);
* artefactos, cachés y runners (especialmente self-hosted expuestos) son vectores que se acotan;
* la auditoría: quién cambia workflows, patrones peligrosos, quién aprueba production;
* los errores típicos (secreto en el job de test, deploy sin aprobación, clave estática, runner expuesto, cache poisoning, workflow sin dueño) se previenen con ámbito y revisión;
* a nivel profesional: OIDC universal y métrica de aprobaciones.

La idea principal es:

> **Tu pipeline es el último guardián del release: si su secreto, su aprobación o su runner son flojos, todo lo anterior — revisiones, tests, escaneos — se salta de una sola vez.**

---

## Próximo paso

Has completado la sección de seguridad.

Continúa con el cierre:

[`README.md`](README.md)
