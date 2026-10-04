# Seguridad de pipelines y despliegues

## Introducción

El pipeline es la fábrica del software: si la fábrica está comprometida, todo lo que sale de ella está en duda. Este capítulo reúne, desde el ángulo DevSecOps, los controles que protejen el camino de entrega — runners, workflows, credenciales de despliegue, environments y la verificación de lo que se publica. Gran parte ya existe repartida en las secciones 19, 20, 22 y 23; aquí se enfoca como **política de protección de la cadena de entrega**.

---

## Mapa conceptual de este capítulo

```text
Seguridad de pipelines y despliegues
       │
       ├── 1. Por qué el pipeline es un objetivo
       ├── 2. Controles por eslabón
       │   ├── 3. Credenciales del camino de entrega
       │   ├── 4. Entornos y aprobaciones
       │   └── 5. Verificar antes de publicar
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Por qué el pipeline es un objetivo

```text
QUÉ GANA UN ATACANTE CON EL PIPELINE:
   │
   ├── ejecución con tu token y tus secretos
   ├── publicación en tu registro de artefactos
   ├── despliegue en tus entornos
   └── en cadena: lo que despliegas llega a todos tus
       usuarios (cap. 05 — cadena de suministro)
```

```text
VETAS (recap integrador — secciones 19/20/22):
   │
   ├── código de PR con privilegios
   ├── acciones/malos actores en las dependencias de CI
   ├── secretos amplios y de larga duración
   ├── runners expuestos (sección 23 cap. 05 Error 4)
   └── sin aprobación en el paso crítico
```

```text
   │
   └── la jerarquía: la app se parchea; el pipeline
       comprometido SOBREESCRIBE parches (Error 1)
```

---

## 2. Controles por eslabón

```text
ESLABÓN            CONTROL
──────────────────────────────────────────────────────
código del PR      permisos mínimos; nada de ejecutar
                   código externo con privilegios
                   (sección 19 cap. 05)

dependencias de CI actions fijadas + renovación
                   (Dependabot — sección 20 cap. 03)

runner             GitHub-hosted por defecto;
                   self-hosted solo interno (sección
                   23 cap. 05)

secretos           solo en environments, por job
                   (sección 19 cap. 04)

despliegue         environment + aprobación + OIDC
                   (sección 20 cap. 07)

publicación        digest/firma + registro
                   (sección 20/22 caps. 05)

post-publicación   humo + vigilancia (sección 22
                   cap. 04 / 23 cap. 06)
```

```text
   │
   └── el checklist NO es nuevo: es la LISTA MAESTRA
       de las secciones anteriores, puesta en una
       sola página (Error 2 si no existe en un sitio)
```

---

## 3. Credenciales del camino de entrega

```text
REGLAS (sección 20 cap. 07 con énfasis):
   │
   ├── cada despliegue con credencial suya, alcance
   │   mínimo y caducidad corta (OIDC preferible)
   │
   ├── la credencial de producción SOLO existe en el
   │   environment de producción (nunca en el job de
   │   test)
   │
   ├── rotación / revocación ensayada (sección 20
   │   cap. 01)
   │
   └── nadie imprime credenciales: logs de CI
       auditados (sección 19 cap. 04)
```

```text
   │
   └── si mañana alguien revisa «¿qué llaves abren
       producción?» debe responder en una página
       (inventario — sección 20 cap. 01 Error 6)
```

---

## 4. Entornos y aprobaciones

```text
GOBIERNO DEL PASO CRÍTICO:
   │
   ├── aprobación obligatoria en producción con
   │   personas/teams nombrados (sección 20 cap. 07)
   │
   ├── «nadie aprueba su propio cambio de despliegue»
   │   (regla típica de dos personas — Error 3 si no
   │   existe)
   │
   ├── ramas permitidas: solo main/tags ya verificados
   │
   └── registro: quién aprobó, cuándo, qué versión
       (sección 22 cap. 05)
```

```text
   │
   └── la aprobación es el último factor humano donde
       todavía aporta: úsalo para MIRAR, no para
       «dar ok» mecánico (Error 4) — la checklist del
       gate debe decir qué se revisa en 30 segundos
       (¿versión, tests, hallazgos, CHANGELOG)
```

---

## 5. Verificar antes de publicar

```text
GATE PRE-PUBLICACIÓN (el resumen del curso):
   │
   ├── checks de PR verdes (sección 15/19)
   ├── SAST/secretos/deps: sin bloqueantes (cap. 02/03
   │   + sección 20)
   ├── DAST de staging sin críticos (cap. 03)
   ├── artefacto identificado y con SBOM (sección 20
   │   cap. 05 / sección 22 cap. 05)
   └── aprobación del environment (punto 4)
```

```text
DESPUÉS:
   │
   ├── humo con resultado positivo (sección 22 cap. 04)
   │
   └── si falla → rollback ensayado (sección 22 cap.
       06)
```

```text
   │
   └── publicar es el final de una FILA de verdes —
       saltar un eslabón invalida los anteriores
       (Error 5)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: pipeline tratado como «interno de TI»

**Qué ocurrió:** nadie revisaba los workflows; un cambio de pipeline desplegó código no revisado.

**Por qué:** el pipeline no se consideraba código crítico (sección 20 cap. 07 Error 6).

**Cómo comprobarlo:** ¿CODEOWNERS cubre workflows? ¿los PRs de workflow tienen revisor?

**Opciones:** dueño + revisión obligatoria de cambios en `.github/workflows/`.

**Riesgos:** la fábrica sin cerradura.

**Solución:** pipeline = producción (punto 1).

**Cómo se evita:** checklist de repos (sección 18).

---

### Error 2: la lista maestra no existe en un sitio

**Qué ocurrió:** los controles estaban repartidos en 5 documentos; un repo nuevo quedó a medias.

**Por qué:** sin síntesis (punto 2).

**Cómo comprobarlo:** ¿existe UNA página con todos los controles de entrega?

**Opciones:** crear `docs/seguridad-entrega.md` con la lista del punto 2; vincularla del README.

**Riesgos:** huecos por dispersión.

**Solución:** lista maestra (punto 2).

**Cómo se evita:** parte del onboarding de repo nuevo.

---

### Error 3: aprobación de uno solo (o autodespliegue)

**Qué ocurrió:** el autor aprobó su despliegue sin mirar; el error llegó a producción.

**Por qué:** sin regla de dos (punto 4).

**Cómo comprobarlo:** ¿quién puede aprobar? ¿él mismo?

**Opciones:** requerir aprobador distinto del autor; nombrar aprobadores.

**Riesgos:** el gate decorativo.

**Solución:** separación de funciones (punto 4).

**Cómo se evita:** configuración del environment (sección 20 cap. 07).

---

### Error 4: aprobación mecánica

**Qué ocurrió:** «ok» en 2 segundos cada vez; nadie sabía qué debía mirar.

**Por qué:** checklist del gate no definida (punto 4).

**Cómo comprobarlo:** tiempo medio de aprobación; ¿hay criterio escrito?

**Opciones:** 4 puntos a mirar (versión, checks, hallazgos, cambio); si no caben en 30 segundos, el gate es otro (¿qué falla?).

**Riesgos:** firma sin lectura.

**Solución:** checklist de aprobación (punto 4).

**Cómo se evita:** plantilla de gate (sección 18/22).

---

### Error 5: publicar saltándose el gate (hotfix de emergencia mal entendido)

**Qué ocurrió:** un «necesitamos ahora» publicó directo con credencial personal.

**Por qué:** la emergencia no tenía procedimiento (punto 5 / sección 22 cap. 01 Error 5).

**Cómo comprobarlo:** despliegues sin pipeline en el registro.

**Opciones:** camino de emergencia documentado: PR exprés + aprobación exprés + revisión post-hoc; nunca fuera del carril.

**Riesgos:** precedente que se vuelve costumbre.

**Solución:** la fila no se salta; se ACORTA (punto 5).

**Cómo se evita:** acuerdo de equipo (sección 16/26).

---

### Error 6: credenciales de despliegue compartidas «para que funcione el guardia»

**Qué ocurrió:** una misma clave de producción estaba en el equipo entero (y en varios laptops).

**Por qué:** se facilitó el turno de guardia (punto 3).

**Cómo comprobarlo:** inventario: ¿de quién es? ¿en cuántos sitios?

**Opciones:** OIDC/credencial por entorno con aprobación; el guardia aprueba, no posee la llave.

**Riesgos:** robo no detectable y no revocable por persona.

**Solución:** credencial del carril, no de las personas (punto 3).

**Cómo se evita:** revisión trimestral (sección 20 cap. 01).

---

## 7. Práctica guiada

### Objetivo

Consolidar la política de protección de tu cadena de entrega en una sola lista verificable.

### Paso 1: lista maestra

1. Crea `docs/seguridad-entrega.md` con el esquema del punto 2 (eslabón → control → ¿dónde está? → ¿falta?).

### Paso 2: verificación

```bash
# comprobaciones rápidas:
grep -rn "uses:" .github/workflows/          # ¿fijadas?
grep -rn "permissions:" .github/workflows/   # ¿explícitas?
grep -rn "environment:" .github/workflows/   # ¿gates?
grep -rn "pull_request_target" .github/workflows/
```

1. Marca el estado real de cada eslabón en tu lista.

### Paso 3: cierra el hueco más crítico

1. Según tu lista: ¿falta aprobación? ¿OIDC? ¿fijado de actions? Empieza por el mayor riesgo (sección 01 cap. 02: proporcionalidad).

### Paso 4: regla de dos

1. Configura el environment de producción: aprobador distinto del autor (simula: intenta aprobar tu propio despliegue — con dos usuarios o entendiendo el límite de tu plan).

### Paso 5: checklist de aprobación

```markdown
Al aprobar un despliegue verifico (30 s):
1. Versión y commit correctos
2. Checks verdes (tests, seguridad)
3. Sin hallazgos bloqueantes abiertos
4. CHANGELOG/resumen del cambio
```

1. Pégalo en la descripción del gate o en el runbook.

### Paso 6: emergencia

1. Escribe el procedimiento de emergencia: PR exprés, quién aprueba, qué se revisa después y cuándo (fecha y responsable).

### Resultado esperado

Lista maestra con estado real, hueco crítico cerrado, regla de dos operativa y procedimiento de emergencia escrito.

### Conclusión esperada

La protección del camino de entrega no inventa nada nuevo: reúne y verifica los controles que ya conoces — la diferencia es que están en UNA lista que alguien mira.

---

## 8. Nivel profesional + resumen

### 8.1. Entrega protegida a escala

```text
   │
   ├── política única para toda la organización,
   │   aplicada por plantillas de repo (sección 18/25)
   │
   ├── OIDC universal para despliegues; cero claves
   │   estáticas (sección 20 cap. 07)
   │
   ├── auditoría: cambios de pipeline y aprobaciones
   │   con registro (audit log)
   │
   ├── simulacros: intento de bypass y de credencial
   │   (sección 24 / 26)
   │
   ├── gates verificables por chequeo automático (no
   │   solo por fe)
   │
   └── métrica: % de despliegues por carril, nº de
       excepciones de emergencia/mes, aprobaciones
       medias por despliegue
```

### 8.2. Resumen

En este capítulo aprendiste que:

* el pipeline es un objetivo de primer orden: comprometerlo es comprometer todo lo que publica;
* controles por eslabón (PR, acciones, runner, secretos, despliegue, publicación, humo) — la lista maestra del resto del curso;
* credenciales del carril: por environment, mínimo alcance, OIDC, inventario;
* aprobación con separación de funciones y checklist de 30 segundos;
* la fila de verificación no se salta: ni en emergencias (se acorta con procedimiento);
* los errores típicos (pipeline sin revisor, lista dispersa, autodespliegue, aprobación ciega, bypass, llave compartida) se previenen con gobernanza;
* a nivel profesional: política única por plantilla y métrica de excepciones.

La idea principal es:

> **El último eslabón que protege a tus usuarios no es el test: es la fábrica que los fabrica — si su puerta, sus llaves y su revisor son de mentira, todo lo demás es teatro.**

---

## Próximo paso

Ya proteges el carril.

Ahora el eslabón más largo: la cadena de suministro completa, desde terceros hasta tu artefacto firmado.

Continúa con:

[`05-cadena-de-suministro-en-el-flujo.md`](05-cadena-de-suministro-en-el-flujo.md)
