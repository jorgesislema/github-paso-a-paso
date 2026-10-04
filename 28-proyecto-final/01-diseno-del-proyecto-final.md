# Diseño del proyecto final

## Introducción

El Proyecto final no es «un proyecto más»: es la **demostración de que comprendes el flujo completo** — código, documentación, Git, GitHub, ramas, commits, Pull Requests, pruebas, GitHub Actions, seguridad, CI/CD y release en un solo entregable. Este capítulo empieza por donde empieza todo lo que has estudiado: el diseño. Aquí se aplican las decisiones técnicas (sección 26 cap. 06) para fijar alcance, estructura y criterios ANTES de escribir la primera línea.

---

## Mapa conceptual de este capítulo

```text
Diseño del proyecto final
       │
       ├── 1. Qué debe demostrar el proyecto
       ├── 2. Alcance: ambición contenida
       │   ├── 3. Stack y estructura (decisiones
       │   │   escritas)
       │   └── 4. Criterios de éxito (rúbrica temprana)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué debe demostrar el proyecto

```text
LA LISTA DE LA ETAPA 28 (el contrato del proyecto):
   │
   ├── código            │  documentación
   ├── Git / GitHub      │  ramas / commits
   ├── Pull Requests     │  pruebas
   ├── GitHub Actions    │  seguridad
   ├── CI/CD             │  release
   │
   └── el objetivo NO es terminar algo grande — es
       demostrar el FLUJO (Error 1 si el proyecto es
       enorme y el flujo es mínimo: exactamente al
       revés)
```

```text
CÓMO SE DEMUESTRA (evidencias, no afirmaciones):
   │
   ├── cada elemento de la lista tiene EVIDENCIA en el
   │   repo: historial, PRs, checks, releases, docs
   │
   └── el evaluador (hoy: tú mañana; mañana: un
       entrevistador o tu equipo) debe poder RECORRER
       el repo y verlo todo sin que nadie explique (Error
       2 si solo tú puedes demostrarlo)
```

```text
   │
   └── principio rector: AMPLITUD DEL FLUJO > TAMAÑO
       DEL PRODUCTO (Error 3 — sección 27 cap. 01:
       repo disciplinado
       vence a producto brillante con 1 commit)
```

---

## 2. Alcance: ambición contenida

```text
REGLA DEL TAMAÑO (Error 4 si se rompe):
   │
   ├── «un comando ejecuta el proyecto» (o tres, con
   │   README)
   ├── pruebas que corren en < 1 min
   ├── CI < 5 min (presupuesto — sección 04 cap. 25)
   └── lo puedes terminar en el PLAZO con margen (Error
       5 si el plan no tiene colchón: el flujo es lo
       que se recorta primero — lo contrario de lo
       que queremos)
```

```text
IDEAS APROPIADAS (la categoría cuenta):
   │
   ├── herramienta CLI útil (convertir, analizar,
   │   reportar) — el formato del Proyecto 5
   ├── micro-servicio/ API pequeña con datos — añade
   │   despliegue (sección 22/23)
   ├── sitio/app con backend mínimo — añade entornos
   └── NO: redes sociales, clones de comercio, apps de
       «cualquier día» (Error 5 — el gran alcance es
       la excusa clásica para no entregar flujo)
```

```text
   │
   └── lo que SÍ puede ser ambicioso: el FLUJO completo
       (todos los elementos del punto 1 con evidencia)
       — ambiciona allí, no en features
```

---

## 3. Stack y estructura (decisiones escritas)

```text
TUS DECISIONES (ADR cortos — sección 25 cap. 06 / 26
cap. 06):
   │
   ├── stack: lenguaje/framework + POR QUÉ (contexto
   │   tuyo: lo que dominas, lo que el mercado pide)
   ├── estructura de repo: árbol con roles (sección 02
   │   cap. 25)
   ├── estrategia de ramas: la más simple que cubra tu
   │   riesgo (sección 01 cap. 26)
   └── qué NO incluyes (y por qué): alcance recortado
       escrito — Error 6 si «luego vemos»
```

```text
ESTRUCTURA BASE (adaptable):
   │
   ├── README.md (el puerto: sección 14 cap. 02)
   ├── docs/  → decisiones, flujo, guías
   ├── src/ o equivalente + tests/
   ├── .github/ → workflows, plantillas, CODEOWNERS
   └── CHANGELOG.md + versionado (sección 17)
```

```text
   │
   └── decisiones ANTES de código = el proyecto se
       construye sobre acuerdos, no sobre impulso (Error
       6 — Error 2 — sección 25 cap. 06:
       decisión sin registro)
```

---

## 4. Criterios de éxito (rúbrica temprana)

```text
Escribe LA RÚBRICA ANTES de empezar (Error 7 si se
evalúa al final con ojo nuevo):
   │
   ├── BASE: la rúbrica pública del capítulo 07 de esta
   │   sección (07-rubrica-del-proyecto-final.md): 6
   │   dimensiones × 4 niveles — cópiala a
   │   docs/rubrica.md y personalízala a tu alcance
   │
   ├── flujo: ¿evidencia de cada elemento del punto 1?
   ├── disciplina: commits atómicos, ramas, PRs
   │   revisados, issues cerrados
   ├── calidad: pruebas bloqueantes probadas en rojo
   ├── seguridad: secretos fuera, checks activos
   ├── entrega: release versionado con notas
   └── lectura: un recién llegado entiende el repo en
       15 minutos (Error 2 prevención)
```

```text
   │
   └── la rúbrica se convierte en CHECKLIST del capítulo
       06 de esta sección — con ella, «terminado» deja
       de ser una sensación (Error 7)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: proyecto enorme con flujo mínimo

**Qué ocurrió:** seis meses de features; un commit gigante, cero PRs, sin pruebas.

**Por qué:** prioridad invertida (punto 1).

**Cómo comprobarlo:** aplica la lista del punto 1: ¿cuántos elementos tienen evidencia?

**Opciones:** recortar alcance a la mitad y dedicar el tiempo al flujo.

**Riesgos:** no demostrar nada de lo que el proyecto debe demostrar.

**Solución:** amplitud > tamaño (punto 1).

**Cómo se evita:** la rúbrica temprana (punto 4).

---

### Error 2: solo su autor puede explicar el repo

**Qué ocurrió:** nadie entendía la estructura, los nombres ni el historial sin que él lo guiara.

**Por qué:** sin recorrido legible (punto 1 Error 2).

**Cómo comprobarlo:** «tour de 15 minutos» con alguien más (o con tu yo de mañana, sin contexto).

**Opciones:** README + docs + nombres honestos (sección 14/25).

**Riesgos:** proyecto inevaluable.

**Solución:** recorrido sin guía (punto 1).

**Cómo se evita:** criterio de la rúbrica (punto 4).

---

### Error 3: «lo bonito» vs. «lo verificable»

**Qué ocurrió:** el frontend brillaba; el CI era un echo, las pruebas no existían.

**Por qué:** ambición mal dirigida (punto 2 Error 3).

**Cómo comprobarlo:** minutos dedicados a pulir vs. minutos al flujo.

**Opciones:** congelar pulido; ejecutar checklist de flujo.

**Riesgos:** demo bonita que no demuestra nada.

**Solución:** ambiciona en el flujo (punto 2).

**Cómo se evita:** reparto de horas visible: flujo primero.

---

### Error 4: alcance que excede el tiempo

**Qué ocurrió:** a la semana 3 el proyecto seguía en «base»; el flujo «se haría al final».

**Por qué:** tamaño sin plan (punto 2).

**Cómo comprobarlo:** plan con plazos: ¿flujos en el calendario?

**Opciones:** reducir alcance ya; temporalizar el flujo por semanas (capítulos 02–05).

**Riesgos:** la excusa clásica de «no dio tiempo».

**Solución:** un comando + < 1 min pruebas + < 5 min CI (punto 2).

**Cómo se evita:** colchón obligatorio en el plan (punto 2).

---

### Error 5: «primero el producto, luego el flujo»

**Qué ocurrió:** el flujo se pospuso hasta «cuando esté» — y nunca estuvo.

**Por qué:** secuencia invertida (Error 3 punto 2).

**Cómo comprobarlo:** ¿el PR 1, el check 1 y el issue 1 ya existen?

**Opciones:** empezar el flujo HOY con el mínimo funcional (sección 01 cap. 27 — el repo primero).

**Riesgos:** entregar solo producto.

**Solución:** flujo desde el día 1 (punto 1/2).

**Cómo se evita:** los capítulos 02–05 ordenan la secuencia: flujo en paralelo, siempre.

---

### Error 6: decisiones orales o pendientes

**Qué ocurrió:** «¿por qué este framework?» sin respuesta escrita; «¿qué queda fuera?» sin lista.

**Por qué:** sin ADR ni alcance recortado (punto 3).

**Cómo comprobarlo:** ¿docs/decisiones con al menos 2 ADRs? ¿lista de «fuera de alcance»?

**Opciones:** escribirlos ahora antes de seguir.

**Riesgos:** desvíos y olvidos del propio autor.

**Solución:** decisiones antes de código (punto 3).

**Cómo se evita:** plantilla ADR de la sección 25 cap. 06.

---

### Error 7: rúbrica improvisada al final

**Qué ocurrió:** al entregar, el evaluador pidió lo que nadie había definido como requisito.

**Por qué:** sin criterios tempranos (punto 4).

**Cómo comprobarlo:** ¿existe la rúbrica escrita antes del inicio?

**Opciones:** escribirla hoy y usarla como checklist de cada capítulo.

**Riesgos:** sorpresa y sensación de injusticia.

**Solución:** rúbrica temprana (punto 4).

**Cómo se evita:** la checklist final (capítulo 06) nace de aquí.

---

## 6. Práctica guiada

### Objetivo

Diseñar el Proyecto final: alcance contenido, decisiones escritas y rúbrica lista.

### Paso 1: propuesta en una página

```text
Qué hago: _______________
Para quién / por qué: _______________
Un comando lo ejecuta: sí/no (debe ser sí)
Plazo: ____ semanas · colchón: ____
```

### Paso 2: la lista de evidencias

1. Marca para cada elemento del punto 1: ¿dónde vivirá su evidencia? (historial, checks, docs, releases).

### Paso 3: decisiones

1. Dos ADRs mínimos: stack (con por qué) y estrategia de ramas. Lista de «fuera de alcance».

### Paso 4: estructura

1. Árbol del repo + carpetas base (punto 3) + README inicial «en construcción».

### Paso 5: rúbrica

1. Escribe los criterios del punto 4 en `docs/rubrica.md` — de aquí sale el capítulo 06.

### Paso 6: esqueleto de flujo

1. Antes de código: issue 1, rama 1, PR 1 (puede ser «base del proyecto») y el primer workflow mínimo (Error 5 prevención).

### Resultado esperado

Propuesta de una página, 2 ADRs, rúbrica escrita y primer PR con workflow ya existentes.

### Conclusión esperada

El proyecto final empieza como cualquier decisión madura: contexto, alcance, consecuencias y criterios — el código llega después, sobre una base que ya sabe a qué responder.

---

## 7. Nivel profesional + resumen

### 7.1. Del diseño a la defensa

```text
   │
   ├── en una entrevista o evaluación, la propuesta de
   │   una página es la PRIMERA cosa que se mira:
   │   demuestra criterio antes que tecnología (sección
   │   26 cap. 06)
   │
   ├── la lista de evidencias es tu guion de defensa
   │   (capítulo 06): cada elemento, un enlace
   │
   ├── «fuera de alcance» escrito es madurez de
   │   ingeniero: el senior corta con razones (sección
   │   25 cap. 06)
   │
   └── la rúbrica compartida con tu evaluador/aclara
       expectativas — «terminado» deja de ser opinión
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el Proyecto final demuestra el FLUJO completo con evidencias, no un producto grande;
* el alcance se contiene con reglas duras: un comando, pruebas < 1 min, CI < 5 min, colchón;
* stack, estructura y estrategia se deciden por escrito (ADRs) con «fuera de alcance»;
* la rúbrica se escribe ANTES y gobierna los capítulos siguientes;
* los errores típicos (tamaño>flujo, repo inexplicable, bonito vs. verificable, sin plan, flujo pospuesto, decisiones orales, rúbrica tardía) se previenen con diseño;
* la secuencia de los próximos capítulos — flujo, docs, CI/CD, release — nace de este diseño.

La idea principal es:

> **Un proyecto final bien diseñado es medio terminado: el alcance acotado, las decisiones escritas y la rúbrica temprana convierten «demostrar el flujo» en un plan ejecutable, no en una esperanza.**

---

## Próximo paso

Diseño listo, rúbrica en mano.

Ahora el corazón: ejecutar el flujo completo — ramas, commits, PRs y pruebas.

Continúa con:

[`02-flujo-completo-ramas-prs-pruebas.md`](02-flujo-completo-ramas-prs-pruebas.md)
