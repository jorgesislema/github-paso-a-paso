# Entrega continua y despliegue continuo

## Introducción

CI responde «¿este cambio está bien?»; **entrega continua** (CD) responde «¿está listo para producción en cualquier momento?» y **despliegue continuo** va más lejos: cada verde se publica automáticamente. Este capítulo distingue los conceptos, diseña el camino de despliegue con environments y gates, introduce estrategias de publicación (blue-green, canary) y deja claro qué implica firmar con automatización la última milla.

---

## Mapa conceptual de este capítulo

```text
Entrega continua y despliegue continuo
       │
       ├── 1. CD vs. despliegue continuo: la distinción
       ├── 2. El camino: de verde a producción
       │   ├── 3. Environments y gates
       │   ├── 4. Estrategias de publicación
       │   └── 5. Automatizar sin miedo
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. CD vs. despliegue continuo: la distinción

```text
CONTINUO          EN CADA MOMENTO PUEDES
──────────────────────────────────────────────────────
integración       fusionar y saber que funciona
(CI)

entrega           publicar un artefacto VALIDADO
(continuous       cuando decidas — despliegue
delivery)         manual, preparado

despliegue        publicar AUTOMÁTICAMENTE cada
continuo          verde a producción
(continuous
deployment)
```

```text
   │
   └── «¿qué tienen ustedes?» es una pregunta de
       madurez, no de marketing: despliegue continuo
       exige confianza total en las puertas (pruebas,
       humo, reversión) — no es el punto de partida
       (Error 1)
```

```text
   │
   └── este curso enseña a construir hasta entrega
       continua con gates; el salto a despliegue
       continuo es una DECISIÓN del equipo con su
       contexto (sección 26)
```

---

## 2. El camino: de verde a producción

```text
FLUJO (completa el diagrama de la sección 00):
──────────────────────────────────────────────────────
PR verde → fusión a main
   ↓
build del artefacto (identidad — sección 02)
   ↓
despliegue a staging (entorno de pruebas)
   ↓
validación (smoke + e2e + revisión si aplica)
   ↓
APROBACIÓN (environment — sección 20 cap. 07)
   ↓
despliegue a producción
   ↓
verificación post-deploy (humo) → ¿verde?
   ↓
sí → publicado · no → rollback (cap. 06)
```

```text
PIEZAS YA VISTAS QUE CIERRAN EL CIRCUITO:
   │
   ├── environments con aprobación (sección 20 cap.
   │   07)
   │
   ├── artefacto único (sección 02)
   │
   └── checks obligatorios en main (sección 20 cap.
       06)
```

---

## 3. Environments y gates

```text
GATE = condición que debe cumplirse para avanzar:
   │
   ├── gate de calidad: pruebas verdes (sección 03)
   ├── gate de seguridad: escaneos (sección 20/24)
   ├── gate humano: aprobación del environment
   └── gate de humo: verificación tras desplegar
```

```text
ENTORNOS TÍPICOS:
   │
   ├── staging/preview: el cambio con forma de
   │   producto (antes de decidir)
   │
   └── production: con sus secretos y su aprobación
       (sección 20 cap. 07)
```

```text
CUÁNTOS GATES (criterio):
   │
   ├── riesgo alto (pagos, datos, público) → más
   │   gates y aprobación humana
   │
   ├── riesgo bajo (docs, behind flag) → menos
   │
   └── la regla se escribe por tipo de cambio — no
       se improvisa en el día del deploy (Error 4)
```

```text
   │
   └── un gate existe para que la PRISA no borre la
       VERIFICACIÓN: eliminar gates sin análisis es
       cómo empiezan los incidentes (Error 5)
```

---

## 4. Estrategias de publicación

```text
BÁSICO (in-place):
   │
   ├── se reemplaza la versión corriendo
   │
   └── rápido; requiere buen rollback (cap. 06)
```

```text
BLUE-GREEN:
   │
   ├── dos entornos: el nuevo cuesta al lado; el
   │   tráfico cambia de golpe cuando está listo
   │
   ├── ventaja: reversión = volver a apuntar
   └── coste: el doble de capacidad
```

```text
CANARY / ONDEADAS:
   │
   ├── el cambio llega a un % pequeño de tráfico y
   │   crece si las métricas aguantan
   │
   ├── ventaja: daño acotado (sección 23: métricas)
   └── coste: complejidad y observabilidad necesaria
```

```text
FEATURE FLAGS (mención):
   │
   ├── desplegar ≠ activar: el código llega apagado y
   │   se enciende por configuración
   │
   └── combina con cualquiera de los anteriores
       (sección 25: arquitectura)
```

```text
   │
   └── no hay estrategia «mejor»: la decisión
       depende de riesgo, audiencia y operación —
       pensamiento senior (sección 26)
```

---

## 5. Automatizar sin miedo

```text
QUÉ DA MIEDO (y cómo se quita):
   │
   ├── «despliega solo» → gates + humo + rollback
   │   practicado (cap. 06)
   │
   ├── «y si nadie mira» → notificaciones + alertas
   │   de la validación post-deploy (sección 23)
   │
   └── «quién rompe, quién arregla» → responsabilidad
       del autor (sección 16) + runbook (sección 26)
```

```text
CÓMO EMPEZAR:
   │
   ├── 1. despliegue manual PERO con pipeline listo
   │   («publish» de un clic sobre artefacto probado)
   │
   ├── 2. añadir staging automático + humo
   │
   ├── 3. gate de aprobación en production
   │
   └── 4. (opcional) despliegue automático cuando la
       confianza y el riesgo lo permitan — decisión
       consciente, no consecuencia
```

```text
   │
   └── cada paso se documenta en el README de
       operaciones (sección 14 cap. 02)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: saltar a despliegue continuo sin puertas

**Qué ocurrió:** se automatizó el push a producción con pruebas flojas; producción se volvió inestable y se volvió al manual.

**Por qué:** se copió la idea sin los gates (punto 1/3).

**Cómo comprobarlo:** ¿qué gates existen hoy? ¿humo? ¿rollback probado?

**Opciones:** retroceder a entrega con aprobación; construir puertas; reevaluar.

**Riesgos:** incidentes públicos y pérdida de confianza en la herramienta.

**Solución:** madurez por pasos (punto 5).

**Cómo se evita:** el camino del punto 5 como plan escrito.

---

### Error 2: despliegue que reconstruye el artefacto

**Qué ocurrió:** producción recibió un build distinto al probado en staging.

**Por qué:** el deploy compilaba de nuevo (sección 02 Error 2).

**Cómo comprobarlo:** traza del pipeline: ¿qué pieza viaja?

**Opciones:** desplegar el artefacto con identidad (versión+commit).

**Riesgos:** probar A, entregar B.

**Solución:** pieza única (sección 02).

**Cómo se evita:** checklist de pipeline.

---

### Error 3: staging que no se parece a producción

**Qué ocurrió:** todo verde en staging; producción falló por configuración/secretos/versión distintos.

**Por qué:** entornos divergentes (config y dependencias distintas).

**Cómo comprobarlo:** comparar: config, versiones, infraestructura.

**Opciones:** mismo camino de despliegue y receta en ambos; diferencias solo en datos/escala; smoke en producción (punto 2).

**Riesgos:** staging decorativo.

**Solución:** entornos gemelos con humo (punto 3).

**Cómo se evita:** revisión tras incidente «¿por qué staging no lo vio?».

---

### Error 4: gates improvisados (o de más)

**Qué ocurrió:** cada release requería «revisar 3 cosas» distintas según quién coordinaba; otras veces ninguna.

**Por qué:** sin política de gates (punto 3).

**Cómo comprobarlo:** comparar releases: ¿mismas puertas?

**Opciones:** definir gates por tipo de cambio y publicarlos; automatizar lo repetible.

**Riesgos:** fricción arbitraria o vacío arbitrario.

**Solución:** reglas escritas (punto 3).

**Cómo se evita:** plantilla de release (sección 18).

---

### Error 5: desactivar el humo post-deploy

**Qué ocurrió:** se quitó la verificación por «rápida» y un deploy roto duró horas sin detectarse.

**Por qué:** se confundió «rápido» con «sin validar» (punto 2).

**Cómo comprobarlo:** ¿existe verificación post-despliegue? ¿alerta si falla?

**Opciones:** humo mínimo (health check + un camino real); alerta al equipo (sección 23).

**Riesgos:** detección por usuarios.

**Solución:** último gate obligatorio (punto 2/3).

**Cómo se evita:** checklist de despliegue.

---

### Error 6: rollback conocido en teoría

**Qué ocurrió:** hubo que revertir y nadie sabía cómo (¿versión anterior? ¿qué config? ¿quién?).

**Por qué:** nunca se practicó (cap. 06).

**Cómo comprobarlo:** pregúntalo: «¿cómo vuelves a la versión 1.2?» — si hay dudas, no está.

**Opciones:** runbook + práctica en staging; artefactos retenidos para volver (sección 18 cap. 04).

**Riesgos:** minutos que se vuelven horas.

**Solución:** reversión ensayada (cap. 06).

**Cómo se evita:** incluir rollback en la checklist de release.

---

## 7. Práctica guiada

### Objetivo

Construir el camino staging → producción con gates en un proyecto de práctica.

### Paso 1: entorno

1. Define `staging` y `production` como environments (sección 20 cap. 07): staging sin aprobación, production con aprobación.

### Paso 2: pipeline de entrega

```text
main → build (artefacto identificado) → deploy
staging → humo en staging → [espera] → aprobación →
deploy production → humo en production
```

1. Implementa con jobs y `environment:` (sección 19).

### Paso 3: humo

```yaml
# esquema de smoke:
# - health check (curl de /health o similar)
# - un camino crítico (login o equivalente)
```

1. Añade el paso en ambos entornos con alerta si falla.

### Paso 4: publica los gates

1. Escribe en `docs/operaciones.md` la tabla de gates (punto 3) con los gates actuales.

### Paso 5: simulación de fallo

1. Despliega algo rojo a staging a propósito (cambia un test o el humo): observa que NO avanza a producción.

### Paso 6: decisión sobre automatización

1. Responde por escrito: ¿hoy podríamos auto-desplegar? ¿Qué gate falta? (Concreta: ¿humo? ¿métricas? ¿aprobación?).

### Resultado esperado

Camino completo con environments, humo en ambos lados, gates documentados y una simulación fallida controlada.

### Conclusión esperada

La entrega continua es un carril con barreras visibles: cada gate existe por escrito y la última milla solo se automatiza cuando las puertas ya se han ganado la confianza.

---

## 8. Nivel profesional + resumen

### 8.1. Entrega a escala

```text
   │
   ├── estrategia de despliegue por tipo de servicio
   │   (in-place, blue-green, canary, flags) —
   │   documentada (sección 26)
   │
   ├── environments como código (infraestructura
   │   versionada — sección 23)
   │
   ├── gates con datos: métricas de canary, error
   │   budgets (sección 23/26)
   │
   ├── despliegues con ventana, notificación y
   │   responsable (sección 16)
   │
   ├── reversión ensayada en simulacros (sección 26
   │   /24)
   │
   └── métrica: frecuencia de despliegue y tiempo de
       recuperación (código para DORA — mención,
       verifique su marco de referencia)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* entrega continua = listos para publicar en cualquier momento; despliegue continuo = publicar cada verde — con madurez de por medio;
* el camino: artefacto → staging → humo → aprobación → producción → humo → rollback si hace falta;
* gates por riesgo, escritos y no improvisados;
* estrategias: in-place, blue-green, canary, flags — la elección es de contexto;
* automatizar sin miedo: humo, alertas y reversión practicada;
* los errores típicos (salto a CD, reconstrucción, entornos divergentes, gates arbitrarios, sin humo, rollback de papel) se previenen con diseño y ensayo;
* a nivel profesional: estrategias documentadas y métricas de frecuencia/recuperación.

La idea principal es:

> **Desplegar rápido no es lo opuesto a despliegue seguro: es el resultado de puertas automatizadas, humo que vigila y una reversión que ya ha funcionado alguna vez.**

---

## Próximo paso

Ya entregas con gates.

Ahora la pieza que viaja por ese carril: los artefactos y sus versiones.

Continúa con:

[`05-artefactos-y-versionado.md`](05-artefactos-y-versionado.md)
