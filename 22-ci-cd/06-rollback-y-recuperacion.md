# Rollback y recuperación

## Introducción

Toda entrega lleva un plan B: **rollback** — volver a una versión conocida cuando el despliegue falla. Un rollback sin ensayar es una teoría cara; uno practicado es la diferencia entre minutos malos y un incidente mayor. Este capítulo cubre cuándo y cómo revertir, las técnicas de recuperación (reversión, reenvío, avance con arreglo), la importancia de ensayar, y qué hacer cuando el rollback tampoco sirve.

---

## Mapa conceptual de este capítulo

```text
Rollback y recuperación
       │
       ├── 1. Cuándo se decide un rollback
       ├── 2. Técnicas de recuperación
       │   ├── 3. Requisitos para que funcione
       │   ├── 4. Ensayar: el rollback que no se probó
       │   └── 5. Cuando el rollback no basta
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Cuándo se decide un rollback

```text
SEÑALES (primeros minutos post-deploy):
   │
   ├── humo en rojo (health check / camino crítico)
   ├── métricas de error/latencia fuera de rango
   │   (sección 23)
   ├── quejas inmediatas de usuarios
   └── hallazgo de seguridad en la versión recién
       publicada (sección 20/24)
```

```text
DECISIÓN (y quién):
   │
   ├── umbral predefinido: «si X falla en Y minutos →
   │   rollback» — no se debate en caliente (Error 1)
   │
   └── dueño del gate (autor/aprobador) ejecuta; la
       duda larga es un rollback improvisado (Error 2)
```

```text
   │
   └── rollback NO es derrota: es el sistema
       funcionando — la alternativa (dejar rojo
       esperando) sí es incidente (Error 5)
```

---

## 2. Técnicas de recuperación

```text
A. ROLLBACK (volver atrás):
   │
   ├── desplegar la versión anterior CONOCIDA
   │   (artefacto retenido — sección 05)
   │
   └── más rápido y mentalmente simple — primera
       opción
```

```text
B. ROLL-FORWARD (avanzar con arreglo):
   │
   ├── publicar 1.4.1 que arregla el problema de 1.4.0
   │
   └── cuando «volver» rompe datos/migraciones ya
       aplicadas o el arreglo es rápido y seguro
```

```text
C. FEATURE FLAG / REENVIÓ (mitigación):
   │
   ├── apagar la función dañina sin cambiar de versión
   │
   └── mención: útil cuando el cambio es acotado y la
       plataforma lo permite (sección 25)
```

```text
D. DATOS: cuidado especial (mención):
   │
   ├── las migraciones de datos no siempre se
   │   «des-hacen»: plan de migración compatible hacia
   │   atrás (expand/contract) — p. ej., no borrar
   │   columnas viejas en el mismo deploy que deja de
       usarlas (Error 4)
   │
   └── si hay datos corruptos: procedimiento de datos
       aparte + aviso — la reversión de código no
       repara datos
```

```text
   │
   └── elección: rollback si es compatible; si los
       datos ya avanzaron, roll-forward — decidido de
       ANTES, no durante (punto 4)
```

---

## 3. Requisitos para que funcione

```text
CHECKLIST (todo debe estar ANTES del incidente):
   │
   ├── [ ] versiones anteriores RETENIDAS en el
   │       registry (sección 05 cap. 05)
   ├── [ ] versión actual REGISTRADA (entorno →
   │       versión — sección 05 cap. 04)
   ├── [ ] comando/proceso de reversión documentado
   │       (runbook)
   ├── [ ] secretos/config compatibles entre versiones
   ├── [ ] migraciones compatibles hacia atrás (punto
   │       2D)
   └── [ ] quién ejecuta y quién verifica (roles)
```

```text
   │
   └── si falta alguno, no tienes rollback: tienes un
       deseo (Error 3)
```

```text
VERIFICACIÓN POST-ROLLBACK:
   │
   ├── humo de nuevo (el mismo gate del deploy)
   │
   └── confirmar en el registro: entorno → versión
       antigua (punto 3)
```

---

## 4. Ensayar: el rollback que no se probó

```text
POR QUÉ ENSAYAR (Error 6):
   │
   ├── el primer uso real es en el peor momento
   │
   └── los problemas (config antigua, migración,
       permisos) aparecen cuando NO hay prisa
```

```text
CÓMO:
   │
   ├── simulacro en staging: desplegar nueva →
   │   reversión → humo verde
   │
   ├── cronograma: al menos cuando cambia el proceso
   │   (y por temporada — p. ej. trimestral, sección
   │   18/26)
   │
   └── métrica: tiempo del simulacro (objetivo: pocos
       minutos)
```

```text
   │
   └── el simulacro es parte del definition of done
       del flujo de despliegue: si no se puede
       revertir, el flujo no está terminado
```

---

## 5. Cuando el rollback no basta

```text
ESCENARIOS QUE EXIGEN MÁS:
   │
   ├── datos corregidos mal (punto 2D)
   │
   ├── fuera de horario/soporte: escalado a guardia
   │   (sección 16/26)
   │
   ├── seguridad: además de revertir, ROTAR secretos y
   │   acotar (sección 20 cap. 01) — el rollback no
   │   desactiva un compromiso
   │
   └── rollback fallido (la versión vieja también
       falla): estabilizar con mitigación (flag) +
       diagnostico del entorno, no solo del código
```

```text
DESPUÉS (SIEMPRE):
   │
   ├── post-mortem con la línea de tiempo: por qué
   │   pasó, por qué no lo vio el gate, qué cambio de
   │   proceso evita la repetición (sección 26)
   │
   └── «arreglado» no es «cerrado»: el control nuevo
       es el cierre (patrón de todo el curso)
```

```text
   │
   └── los incidentes buenos son los que dejan un
       gate más (Error 7 relacionado — Error 6 de la
       sección)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: umbral de rollback improvisado

**Qué ocurrió:** discusión 15 minutos sobre si «estaba malo»; al decidir, el daño creció.

**Por qué:** sin umbral predefinido (punto 1).

**Cómo comprobarlo:** ¿está escrito en el runbook? ¿quién decide?

**Opciones:** definir umbral (métrica + ventana); nombrar responsable; ejecutar.

**Riesgos:** minutos caros en caliente.

**Solución:** decisión predefinida (punto 1).

**Cómo se evita:** plantilla de runbook (punto 3).

---

### Error 2: sin dueño de la reversión

**Qué ocurrió:** todos vieron el rojo; nadie ejecutó porque «no era su área».

**Por qué:** roles no asignados (punto 3).

**Cómo comprobarlo:** pregúntale al equipo: «¿quién revierte producción un sábado?».

**Opciones:** dueño + suplente por entorno; práctica en equipo.

**Riesgos:** parálisis.

**Solución:** quién ejecuta y quién verifica (punto 3).

**Cómo se evita:** incluir en la documentación de guardias (sección 26).

---

### Error 3: «versión anterior» inexistente

**Qué ocurrió:** se quiso volver a 1.3 y el registry solo retenía 7 días de builds.

**Por qué:** sin política de retención (sección 05 cap. 05 Error 6).

**Cómo comprobarlo:** ¿puedes listar y descargar la versión previa ahora?

**Opciones:** retención mínima para releases (meses); reconstruir desde tag si el artefacto se perdió (riesgo: dependencias…) — mejor prevenir.

**Riesgos:** rollback imposible.

**Solución:** retenido + registrado (punto 3).

**Cómo se evita:** política escrita (sección 05).

---

### Error 4: migración irreversible en el mismo deploy

**Qué ocurrió:** el deploy eliminó columnas; el rollback de código no restauró los datos.

**Por qué:** migración acoplada sin fase de compatibilidad (punto 2D).

**Cómo comprobarlo:** revisar migraciones: ¿la versión vieja corre con el esquema nuevo?

**Opciones:** expand/contract (añadir primero, eliminar después en deploy posterior); backup/restore si procede.

**Riesgos:** datos dañados más allá del código.

**Solución:** migraciones compatibles hacia atrás (punto 2D).

**Cómo se evita:** revisar migraciones en el PR (sección 15).

---

### Error 5: vergüenza del rollback

**Qué ocurrió:** se mantuvo una versión roja «para no dar marcha atrás».

**Por qué:** se confundió revertir con fracasar (punto 1).

**Cómo comprobarlo:** tiempo medio entre detección y reversión.

**Opciones:** cultura: reversión = control funcionando; métrica de reversión rápida.

**Riesgos:** usuarios pagan la indecisión.

**Solución:** reversión sin estigma (punto 1).

**Cómo se evita:** enfocar la retro en tiempos, no en culpables (sección 26).

---

### Error 6: rollback nunca ensayado

**Qué ocurrió:** el primer rollback real falló por config vieja y se tardó 40 minutos.

**Por qué:** sin simulacro (punto 4).

**Cómo comprobarlo:** ¿cuándo fue el último simulacro? ¿existe registro?

**Opciones:** programar simulacro en staging; documentar hallazgos; repetir.

**Riesgos:** todo lo anterior se descubre a ciegas.

**Solución:** ensayar (punto 4).

**Cómo se evita:** calendario de simulacros (sección 18/26).

---

### Error 7: sin post-mortem

**Qué ocurrió:** se revirtió, se «resolvió» y la misma causa volvió a publicarse la semana siguiente.

**Por qué:** no hubo causa raíz ni control nuevo (punto 5).

**Cómo comprobarlo:** ¿existe documento de incidente? ¿qué gate cambió?

**Opciones:** post-mortem sin culpa con acciones con dueño y fecha.

**Riesgos:** repetición garantizada.

**Solución:** el incidente cierra con control nuevo (punto 5).

**Cómo se evita:** plantilla de post-mortem (sección 26/24).

---

## 7. Práctica guiada

### Objetivo

Construir y ensayar un proceso de reversión real.

### Paso 1: runbook

```markdown
# Reversión (producción)
1. Umbral: humo rojo o error rate > X% en 5 min
2. Quién: [dueño] · suplente: [otro]
3. Comando/proceso: [pasos exactos]
4. Verificar: humo + registro de versión
5. Comunicar: [canal]
6. Post-mortem: < 24 h
```

1. Revisa que los pasos apuntan a tu flujo real (cap. 04/05).

### Paso 2: requisitos

1. Comprueba el checklist del punto 3: ¿versiones retenidas? ¿registro al día? ¿migraciones compatibles?
2. Corrige lo que falte ANTES del simulacro.

### Paso 3: simulacro en staging

```text
1. despliega versión nueva a staging
2. provoca fallo de humo (apaga el servicio o rompe
   health)
3. ejecuta la reversión del runbook
4. verifica humo verde en la versión anterior
5. cronometra: ¿cuánto tardó de verdad?
```

### Paso 4: roll-forward

1. Practica también el otro camino: publica 1.4.1 sobre 1.4.0 con un arreglo — compara cuándo elegiría cada uno (punto 2).

### Paso 5: registro

1. Tras cada paso, actualiza el registro de despliegues (entorno→versión) — debe reflejar lo ocurrido.

### Paso 6: post-mortem de mentira

1. Escribe un mini-post-mortem del simulacro: qué sorprendió, qué se cambia en el runbook.

### Resultado esperado

Runbook vivo, requisitos verificados, simulacro cronometrado y lecciones aplicadas.

### Conclusión esperada

La reversión es una funcionalidad más del sistema de entrega: se diseña, se verifica y se mantiene — el día que la necesitas, es un procedimiento aburrido.

---

## 8. Nivel profesional + resumen

### 8.1. Recuperación a escala

```text
   │
   ├── runbooks por tipo de servicio con dueños y
   │   suplentes (sección 16/26)
   │
   ├── simulacros en calendario (trimestral o por
   │   cambio de proceso) con métrica de tiempo
   │
   ├── estrategias que simplifican la reversión
   │   (blue-green, canary — sección 04 cap. 04)
   │
   ├── migraciones siempre expand/contract en cambios
   │   destructivos
   │
   ├── incidentes: respuesta → estabilizar →
   │   post-mortem con control nuevo (sección 24/26)
   │
   └── métrica: tiempo medio de reversión; %
       simulacros con éxito; reincidencias
```

### 8.2. Resumen

En este capítulo aprendiste que:

* rollback con umbral y dueño predefinidos — la duda en caliente es un rollback improvisado;
* técnicas: rollback, roll-forward, flags, y el cuidado especial de los datos;
* requisitos: versiones retenidas, registro, runbook, compatibilidad y roles — verificados ANTES;
* ensayar en staging con métrica de tiempo; el primer uso no puede ser el real;
* cuando no basta: mitigación, escalado, y seguridad (rotar ≠ revertir);
* los errores típicos (umbral difuso, sin dueño, sin versión vieja, migración irreversible, estigma, sin simulacro, sin post-mortem) se previenen con proceso escrito;
* a nivel profesional: runbooks con calendario y métricas de reincidencia.

La idea principal es:

> **La confianza en desplegar no viene de que nunca falle, sino de que revertir sea aburrido: versión retenida, proceso ensayado y alguien con nombre y turno.**

---

## Próximo paso

Has completado la sección de CI/CD.

Continúa con el cierre:

[`README.md`](README.md)
