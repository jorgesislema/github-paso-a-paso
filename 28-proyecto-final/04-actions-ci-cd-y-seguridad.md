# GitHub Actions, CI/CD y seguridad

## Introducción

El Proyecto final necesita su fábrica: **un pipeline que verifique cada cambio y lo lleve a un estado desplegable, con las puertas de seguridad que impiden que lo verificado se contamine**. Este capítulo ensambla las secciones 19 (Actions), 20 (seguridad) y 22 (CI/CD) en el pipeline del proyecto — con la regla que ya conoces: todo control se prueba en negativo y toda automatización tiene dueño.

---

## Mapa conceptual de este capítulo

```text
GitHub Actions, CI/CD y seguridad
       │
       ├── 1. El pipeline del proyecto (diseño)
       ├── 2. Jobs y puertas que bloquean
       │   ├── 3. Seguridad en el flujo (mínimo exigible)
       │   └── 4. Despliegue: de checks a producción
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. El pipeline del proyecto (diseño)

```text
WORKFLOW(S) DEL PROYECTO (sección 19/22):
   │
   ├── trigger: pull_request + push a main (Error 1
   │   si solo corre a mano: el pipeline no existe)
   │
   ├── job «calidad»:
   │     checkout → setup → instalar (cache) → lint →
   │     pruebas → (artifact de resultados si aplica)
   │
   ├── job «seguridad» (o pasos integrados):
   │     secretos · dependencias · (SAST según stack)
   │
   └── job «deploy» (cap. 04): SOLO en main, después
       de calidad (needs:) — Error 2 si compite en
       paralelo (Error 6 sección 03 cap. 27)
```

```text
REGLAS DEL DISEÑO:
   │
   ├── versiones fijas de actions (sección 19 cap. 05)
   ├── nombres de jobs que se leen (Error 3 si
   │   «build-2-v2-final»: el pipeline es documento —
   │   Error 7 sección 03 cap. 27)
   └── duración < 5 min con cache (presupuesto — Error 5
       sección 04 cap. 25)
```

```text
   │
   └── DIAGRAMA del pipeline en docs/flujo.md — la
       evidencia de que lo diseñaste (Error 3
       prevención)
```

---

## 2. Jobs y puertas que bloquean

```text
LA EVIDENCIA EXIGIBLE (Error 4 si falta alguna):
   │
   ├── check de pruebas REQUERIDO en la rama principal
   ├── PR DE NEGATIVO: rojo deliberado → merge
   │   bloqueado (guarda la captura/URL: es evidencia de
   │   defensa — Error 5 sección 02 cap. 28)
   ├── sin bypass: el dueño tampoco se salta la puerta
   │   (sección 20 cap. 06 — Error 6 si «solo para esta
   │   vez»)
   └── el badge del README muestra el estado VERDADERO
```

```text
QUÉ MÁS PUEDA BLOQUEAR (según stack, categoría):
   │
   ├── formato/lint (Error 3 — sección 27 cap. 03)
   ├── type-check si tu lenguaje lo tiene
   └── chequeo de estructura/docs mínimos si aplica
```

```text
   │
   └── no añadas puertas que no puedas mantener: cada
       check es deuda operativa (Error 7 si acumulas
       6 checks que nadie entiende — Error 7 de esta
       sección)
```

---

## 3. Seguridad en el flujo (mínimo exigible)

```text
CHECKLIST DE SEGURIDAD DEL PROYECTO (sección 20/24 —
lo exigible a esta escala):
   │
   ├── secretos: ninguno en código · secrets de la
   │   plataforma para lo que haga falta · push
   │   protection ACTIVADO (y probado — Error 1 y
   │   Error 7 de la sección 27 cap. 06)
   ├── dependencias: Dependabot activo + responder al
   │   menos 1 alerta con actualización (evidencia)
   ├── permisos del workflow: `permissions` mínimas
   │   (sección 19 cap. 04 Error 1: permisos mínimos
   │   del workflow)
   ├── action references versionadas (punto 1)
   └── .gitignore cubre .env, artefactos, datos (sección
       27 cap. 04 y 05)
```

```text
   │
   └── si tu stack lo permite: SAST básico (CodeQL o
       linter de seguridad — sección 20 cap. 04) como
       paso — con AL MENOS una alerta resuelta como
       evidencia (Error 8 — la
       evidencia es tener ACTUADO, no tener la feature)
```

---

## 4. Despliegue: de checks a producción

```text
SEGÚN TU PROYECTO (sección 22 cap. 04 — categoría):
   │
   ├── estático/sitio: deploy automático en main tras
   │   checks (Proyecto 4 lo hizo — aquí se integra)
   ├── herramienta CLI: publicación de release + artefacto
   │   (cap. 05 de esta sección)
   └── servicio: despliegue a entorno de prueba
       automático + producción con humo (sección 23 —
       «producción» puede ser tu VPS/servicio gratuito:
       lo que importa es el FLUJO)
```

```text
LO QUE AÑADE ESTE CAPÍTULO sobre lo ya hecho:
   │
   ├── gates: nada llega sin calidad + seguridad
   │   (Error 8 si deploy se salta la seguridad)
   ├── humo post-deploy: el pipeline verifica que lo
   │   desplegado RESPONDE (sección 23 cap. 06 en
   │   miniatura)
   └── rollback o reversión documentada (Error 9 si no
       existe el «cómo se deshace» — Error 7 de la
       sección 26 cap. 04)
```

```text
   │
   └── la evidencia: historial de deploys = runs con
       fecha/autor/resultado — «¿cuándo se desplegó X?»
       tiene URL (Error 6 — sección
       27 cap. 03)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: pipeline manual

**Qué ocurrió:** los checks existían pero solo corrían si alguien los lanzaba.

**Por qué:** triggers mal (punto 1).

**Cómo comprobarlo:** abre un PR: ¿corre solo?

**Opciones:** `pull_request` + `push` a main; verificar con un PR nuevo.

**Riesgos:** evidencia de CI inexistente.

**Solución:** trigger correcto (punto 1).

**Cómo se evita:** checklist de configuración del workflow.

---

### Error 2: deploy en paralelo a la calidad

**Qué ocurrió:** se desplegó antes de que terminaran las pruebas.

**Por qué:** sin `needs` (punto 1 Error 2).

**Cómo comprobarlo:** revisar dependencias de jobs.

**Opciones:** encadenar y probar (PR en rojo: ¿deploy NO corre?).

**Riesgos:** publicar lo no verificado.

**Solución:** cadena calidad → deploy (punto 1).

**Cómo se evita:** revisión del workflow como cualquier PR.

---

### Error 3: jobs con nombres indescifrables

**Qué ocurrió:** nadie sabía qué hacía «t-2» ni dónde mirar al fallar.

**Por qué:** sin convención (punto 1 Error 3).

**Cómo comprobarlo:** lee los nombres: ¿se entienden sin abrir el YAML?

**Opciones:** renombrar («calidad», «pruebas», «seguridad», «despliegue»).

**Riesgos:** debugging imposible para otros.

**Solución:** pipeline como documento (Error 7 sección 03 cap. 27).

**Cómo se evita:** convención de nombres en docs/flujo.md.

---

### Error 4: check requerido que nunca se probó

**Qué ocurrió:** «required» no estaba bien configurado; el merge pasó con rojo.

**Por qué:** sin prueba negativa (punto 2).

**Cómo comprobarlo:** PR rojo ahora — ¿bloquea?

**Opciones:** corregir hasta que bloquee; guardar evidencia.

**Riesgos:** el resto del capítulo 2 se evalúa mal.

**Solución:** negativo guardado (punto 2).

**Cómo se evita:** todo control nuevo se prueba rompiéndolo.

---

### Error 5: bypass «de esta vez»

**Qué ocurrió:** el autor forzó el merge «por la entrega».

**Por qué:** excepción sin proceso (punto 2 Error 6 — sección 25 cap. 03 punto 5).

**Cómo comprobarlo:** registros: ¿force-merge? ¿quién? ¿por qué?

**Opciones:** prohibir bypass; si fue necesario, registro con fecha y motivo.

**Riesgos:** la puerta deja de existir.

**Solución:** sin excepciones improvisadas (punto 2).

**Cómo se evita:** la excepción se pide ANTES y queda escrita.

---

### Error 6: secretos o dependencias sin cubrir

**Qué ocurrió:** el proyecto entregado tenía push protection apagado y 7 dependencias desactualizadas.

**Por qué:** checklist de seguridad incompleta (punto 3).

**Cómo comprobarlo:** revisar ajustes: secret scanning, Dependabot, alertas.

**Opciones:** activar todo y resolver AL MENOS 1 alerta real (evidencia).

**Riesgos:** evidencia de seguridad = cero.

**Solución:** checklist del punto 3 completa.

**Cómo se evita:** «evidencia» incluida en la rúbrica (cap. 01 punto 4).

---

### Error 7: puertas que nadie entiende

**Qué ocurrió:** 7 checks con nombres raros; los fallos se «arreglaban» reiniciando.

**Por qué:** acumulación sin diseño (punto 2 Error 7).

**Cómo comprobarlo:** ¿docs/flujo.md explica cada check? ¿cuánto tarda cada uno?

**Opciones:** eliminar lo que no aporta; documentar lo que queda.

**Riesgos:** alerta-fatiga y reinicios a ciegas.

**Solución:** puertas con dueño y explicación (punto 2).

**Cómo se evita:** revisar el pipeline en la retro (sección 24 cap. 06).

---

### Error 8: seguridad «activada» pero nunca ejercida

**Qué ocurrió:** features de seguridad puestas, cero evidencia de haberlas usado.

**Por qué:** se confundió configurar con practicar (punto 3 Error 8).

**Cómo comprobarlo:** ¿alguna alerta resuelta? ¿algún bloqueo probado?

**Opciones:** crear la evidencia: alerta de prueba, PR bloqueado, scan ejecutado.

**Riesgos:** en la defensa, «tengo la feature» no vale — «la usé» vale.

**Solución:** ejercer los controles (punto 3).

**Cómo se evita:** la rúbrica exige acciones, no ajustes.

---

### Error 9: despliegue sin reversa

**Qué ocurrió:** un mal despliegue no tenía forma rápida de volver al estado anterior.

**Por qué:** sin reversión (punto 4 Error 9).

**Cómo comprobarlo:** «¿cómo se deshace?» — ¿respuesta escrita?

**Opciones:** procedimiento de rollback/revert documentado y (si se puede) practicado.

**Riesgos:** improvisación en la entrega.

**Solución:** vuelta atrás escrita (Error 3 sección 04 cap. 26).

**Cómo se evita:** checklist de despliegue con «reversa».

---

## 6. Práctica guiada

### Objetivo

Pipeline completo del Proyecto final: calidad + seguridad + despliegue, todos probados en negativo.

### Paso 1: workflow de calidad

1. Jobs con nombres claros, actions versionadas, cache (punto 1). Mide duración (< 5 min).

### Paso 2: puerta

1. Check requerido en la rama principal + prueba negativa con PR rojo (punto 2). Guarda la evidencia.

### Paso 3: seguridad

```text
[ ] push protection activado (+ prueba de bloqueo)
[ ] Dependabot activo + 1 alerta resuelta
[ ] permissions mínimas en el workflow
[ ] cero secretos / .env ignorado
[ ] (si aplica) SAST + 1 hallazgo atendido
```

### Paso 4: despliegue

1. Deploy encadenado con `needs` (punto 4). Verifica que en PR NO corre.

### Paso 5: humo y reversa

1. Tras desplegar: verificación de que responde. Escribe el procedimiento de reversa.

### Paso 6: documenta

1. Diagrama del pipeline en docs/flujo.md (punto 1) + badge veraz en README.

### Resultado esperado

Pipeline completo con puertas probadas, seguridad ejercida y despliegue con verificación y reversa escrita.

### Conclusión esperada

La fábrica del Proyecto final no es «un YAML que pasa»: es un conjunto de puertas que efectivamente cierran, seguridad que efectivamente se usó y un despliegue que sabe volver atrás — todo demostrable con runs y evidencias.

---

## 7. Nivel profesional + resumen

### 7.1. Del pipeline al programa

```text
   │
   ├── lo montado aquí es el pipeline que las secciones
   │   19/22/24 describen a escala — el mismo patrón,
   │   menos puertas
   │
   ├── «seguridad ejercida» (alertas resueltas,
   │   bloqueos probados) es exactamente la evidencia
   │   que un auditor o interviewer pide (sección 24)
   │
   ├── la reversa documentada es el germen del plan de
   │   recuperación (sección 26 cap. 04)
   │
   └── métricas para la defensa: duración de CI, nº de
       PRs bloqueados, alertas atendidas, deploys
       exitosos
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el pipeline del proyecto: calidad → seguridad → despliegue, con triggers correctos y `needs` encadenando;
* las puertas se exigen en la plataforma, no en el README, y se prueban en negativo con evidencia guardada;
* seguridad mínima ejercida: push protection probado, alerta resuelta, permisos mínimos, actions versionadas;
* el despliegue verifica (humo) y tiene reversa escrita;
* los errores típicos (pipeline manual, deploy paralelo, nombres raros, puerta sin probar, bypass, seguridad sin usar, checks opacos, features sin ejercer, sin reversa) se previenen con diseño, pruebas y evidencia;
* el pipeline entero queda documentado como parte del entregable.

La idea principal es:

> **Un pipeline se juzga por sus momentos de rojo: el día que efectivamente bloqueó, el día que atrapó un secreto y el día que supo volver atrás — todo lo demás es configuración.**

---

## Próximo paso

Fábrica completa y probada.

Ahora cerrar el ciclo: release, versionado y entrega del Proyecto final.

Continúa con:

[`05-release-y-entrega.md`](05-release-y-entrega.md)
