# Recuperación ante incidentes y desastres

## Introducción

Dos palabras distintas que la prisa confunde: **incidente** (algo roto ahora: un servicio, un release, una credencial) y **desastre** (algo perdido: el repo, el entorno, la capacidad de operar). A nivel senior se preparan por separado — con ritmos, escenarios y simulacros distintos — y se ensayan antes de que hagan falta. Este capítulo integra lo estudiado (secciones 20 cap. 01, 22 cap. 06, 23 cap. 06, 24 cap. 05) en un marco único: respuesta, recuperación y aprendizaje para el peor día.

---

## Mapa conceptual de este capítulo

```text
Recuperación ante incidentes y desastres
       │
       ├── 1. Incidente vs. desastre (dos mundos)
       ├── 2. Respuesta a incidentes (ritmo y roles)
       │   ├── 3. Desastre: respaldo, RTO/RPO, pruebas
       │   └── 4. Aprendizaje: post-mortem → control
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Incidente vs. desastre (dos mundos)

```text
INCIDENTE (algo funciona MAL):
   │
   ├── ejemplos: release roto, CI caído, secretos
   │   filtrados, servicio degradado
   │
   ├── objetivo: CONTENER → RESOLVER → normalizar
   │   (sección 22 cap. 06 / 23 cap. 06 / 24 cap. 05)
   │
   └── ritmo: horas
```

```text
DESASTRE (algo NO ESTÁ):
   │
   ├── ejemplos: repo borrado, ransomware, pérdida de
   │   credenciales maestras, provider caído para
   │   siempre, devolución de un disco entero
   │
   ├── objetivo: RESTAURAR capacidad de operar (desde
   │   respaldos y espejos) aunque se pierda lo
   │   reciente
   │
   └── ritmo: días — y solo funciona si se PREPARÓ
```

```text
   │
   └── confundirlos es caro: tratar un desastre como
       incidente = improvisar sin respaldo (Error 1);
       tratar cada incidente como desastre = pánico y
       coste innecesario (Error 2)
```

---

## 2. Respuesta a incidentes (ritmo y roles)

```text
MOMENTOS (ritmo — sección 22 cap. 06 / 24 cap. 05):
   │
   ├── 1. DETECTAR: alerta o reporte — quién recibe y
   │   quién coordina (Error 3 si «el que se dé
   │   cuenta»)
   │
   ├── 2. CONTENER: separar daño de alcance (pausar
   │   despliegue, rotar credencial, revertir release)
   │   — ANTES de entenderlo todo (Error 4 si se
   │   investiga mientras se sangra)
   │
   ├── 3. COMUNICAR: canal, dueños, estado (sección 16
   │   /23 cap. 06 — actualizar, no silencio)
   │
   ├── 4. RESOLVER Y VERIFICAR: fix + humo + observar
   │   (sección 23 cap. 06)
   │
   └── 5. NORMALIZAR: post-mortem < 48 h (punto 4)
```

```text
ROLES DE INCIDENTE (mínimos — Error 3 prevención):
   │
   ├── coordinador (dirige, decide prioridades)
   ├── quien ejecuta (fix/revert)
   └── quien comunica (fuera del teclado — Error 4
       prevención: nadie hace las 3 a la vez si el
       incidente es grande)
```

```text
   │
   └── los GUIONES preparados cambian el ritmo:
       secretos (sección 20 cap. 01), suministro
       (sección 24 cap. 05), rollback (sección 22 cap.
       06) — se PRACTICAN (Error 5 si solo existen en
       un doc)
```

---

## 3. Desastre: respaldo, RTO/RPO, pruebas

```text
PREGUNTAS DE DESASTRE (las que hay que responder
ANTES):
   │
   ├── ¿qué respaldamos? (repo, historial, artefactos,
   │   config, secretos — sección 08/20/22)
   │
   ├── ¿dónde y con qué frecuencia? (fuera del mismo
   │   provider — Error 6: espejo/backup externo)
   │
   ├── RTO: cuánto TARDAMOS en volver a operar
   │   (objetivo escrito)
   │
   └── RPO: cuánto PERDEMOS como máximo (último
       respaldo — cuántos minutos/horas de trabajo)
```

```text
LO QUE SE PRUEBA (Error 6 si no):
   │
   ├── restauración REAL: clonar desde respaldo, no
   │   «confiamos en que está»
   ├── simulacro de desastre en calendario (Error 5 —
   │   mismo criterio que los de sección 24 cap. 05)
   └── espejo del repo que sobrevive al provider
       (Error 7 si todo depende de un solo sitio)
```

```text
   │
   └── «nunca lo hemos restaurado» = no tenemos
       respaldo, tenemos una FE (Error 6)
```

```text
DESPUÉS DEL DESASTRE:
   │
   ├── restaurar por orden: acceso → repo → entorno →
   │   datos (sección 23 — IaC acelera: sección 23
   │   cap. 04)
   └── comunicar expectativas de pérdida (RPO real
       observado) — Error 7 si se promete «todo»
```

---

## 4. Aprendizaje: post-mortem → control

```text
CICLO (cierre — sección 24 cap. 06):
   │
   ├── post-mortem sin culpa en < 48 h
   ├── causa raíz que MIRA EL SISTEMA (no a la persona)
   ├── acciones con dueño + fecha + verificación
   └── el incidente cierra cuando el CONTROL existe
```

```text
   │
   └── métrica de aprendizaje: reincidencias (Error 8
       si se repite lo mismo tres veces — Error 7
       sección 03 de esta sección)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: desastre improvisado como incidente

**Qué ocurrió:** se borró el repo «principal» y la respuesta fue buscar en local — sin espejo ni respaldo externo.

**Por qué:** no se preparó desastre (punto 1/3).

**Cómo comprobarlo:** ¿existe respaldo externo restaurado alguna vez?

**Opciones:** configurar espejo/backup y RESTAURARLO de prueba hoy.

**Riesgos:** pérdida irreversible (Error 8 sección 25 cap. 05).

**Solución:** preparación y prueba (punto 3).

**Cómo se evita:** simulacro de restauración en calendario (punto 3).

---

### Error 2: pánico de desastre ante cada incidente

**Qué ocurrió:** un fallo de 20 minutos activó comunicación global y escalado de «pérdida total».

**Por qué:** clasificación ausente (punto 1).

**Cómo comprobarlo:** ¿hay severidad de incidente y su guion?

**Opciones:** escala de severidad con respuesta proporcional (punto 1/2).

**Riesgos:** desgaste y alerta-fatiga.

**Solución:** los dos mundos separados (punto 1).

**Cómo se evita:** guiones por severidad (sección 23 cap. 06).

---

### Error 3: sin coordinador ni guion

**Qué ocurrió:** tres personas revertían a la vez y dos se comunicaban a audiencias distintas.

**Por qué:** roles no definidos (punto 2).

**Cómo comprobarlo:** ante el último incidente: ¿quién coordinó?

**Opciones:** roles mínimos escritos en el guion (punto 2).

**Riesgos:** esfuerzo duplicado y mensajes contradictorios.

**Solución:** coordinador/executor/comunicador (punto 2).

**Cómo se evita:** el guion incluye los roles (punto 2).

---

### Error 4: investigar mientras se sangra

**Qué ocurrió:** el equipo indagaba la causa raíz con el servicio caído; la contención llegó 40 minutos después.

**Por qué:** se saltó contener (punto 2).

**Cómo comprobarlo:** línea temporal: ¿cuándo se contenía vs. cuándo se entendía?

**Opciones:** regla: contener primero, entender después; rollback como contención por defecto.

**Riesgos:** daño creciente.

**Solución:** orden del punto 2.

**Cómo se evita:** se practica en simulacro (punto 2).

---

### Error 5: guiones que nunca se practican

**Qué ocurrió:** el guion de secretos tenía pasos obsoletos; en el incidente real se improvisó.

**Por qué:** doc sin ensayo (punto 2/3).

**Cómo comprobarlo:** ¿cuándo fue el último simulacro?

**Opciones:** calendario de simulacros por guion (sección 24 cap. 05).

**Riesgos:** documentación que miente bajo presión.

**Solución:** practicar (punto 3).

**Cómo se evita:** simulacro como métrica (sección 24 cap. 06).

---

### Error 6: respaldo sin restauración probada

**Qué ocurrió:** el proveedor reportaba backups OK; al restaurar, los últimos 3 días no estaban (RPO real ≠ RPO asumido).

**Por qué:** no se restauró nunca (punto 3).

**Cómo comprobarlo:** restaurar HOY en un entorno aparte y medir.

**Opciones:** fijar RPO real, aumentar frecuencia si no cumple, alertar si el respaldo falla.

**Riesgos:** fe disfrazada de cobertura.

**Solución:** prueba de restauración (punto 3).

**Cómo se evita:** métrica: «última restauración exitosa: fecha».

---

### Error 7: todo en un solo provider

**Qué ocurrió:** cuenta suspendida = repo, artefactos e historial fuera de alcance a la vez.

**Por qué:** sin espejo externo (punto 3).

**Cómo comprobarlo:** si desaparece tu proveedor principal: ¿qué queda?

**Opciones:** espejo en otro proveedor/local periódico; secretos replicables fuera (con control — sección 20 cap. 01).

**Riesgos:** punto único de fallo.

**Solución:** diversidad de respaldo (punto 3).

**Cómo se evita:** revisión anual de dependencia de proveedor.

---

### Error 8: incidentes que se repiten

**Qué ocurrió:** el mismo fallo de release volvió dos meses después, idéntico.

**Por qué:** post-mortem sin control (punto 4).

**Cómo comprobarlo:** ¿existía el post-mortem anterior? ¿sus acciones?

**Opciones:** cerrar las acciones pendientes; métrica de reincidencias.

**Riesgos:** cultura que documenta pero no cambia.

**Solución:** cierra con control (punto 4).

**Cómo se evita:** revisión mensual de acciones de post-mortems.

---

## 6. Práctica guiada

### Objetivo

Tener respuesta de incidente y preparación de desastre ensayadas — no solo escritas.

### Paso 1: clasifica tus escenarios

```text
INCIDENTES (probables en tu proyecto):
   │ release roto · CI caído · credencial filtrada ·
   │ dependencia comprometida
DESASTRES (baja probabilidad, alto impacto):
   │ repo borrado · pérdida de credenciales maestras ·
   │ caída/cierre del proveedor
```

### Paso 2: guion de incidente

1. Para el escenario más probable: guion con roles (punto 2) y pasos numerados — incluye contención por defecto (revert/pausa).

### Paso 3: RTO/RPO y respaldo

```text
RTO objetivo: ____ horas
RPO objetivo: ____ horas
Respaldos: qué · dónde · frecuencia · ¿externo?
```

### Paso 4: restaura de verdad

1. Clona desde tu respaldo en un lugar limpio. ¿Funciona? ¿Cuánto hay de pérdida real?
2. Anota la fecha: hoy tienes tu primera restauración probada (Error 6 resuelto).

### Paso 5: simulacro

1. Agenda un simulacro de 30 minutos: «escenario X a las 10:00» — roles, guion, y retrospectiva de 10 minutos.

### Paso 6: cierra el ciclo

1. Plantilla de post-mortem + tracker de acciones con dueño y fecha (punto 4) en `docs/incidentes/`.

### Resultado esperado

Guion con roles, RTO/RPO escritos, restauración probada con fecha y simulacro en calendario.

### Conclusión esperada

La recuperación no se improvisa en el pico: se ensaya en calma — quien ha restaurado alguna vez un respaldo es otra persona en el peor día.

---

## 7. Nivel profesional + resumen

### 7.1. El programa de continuidad

```text
   │
   ├── incidentes: severidades con guiones proporcionales
   │   + guardias/turnos + comunicación con audiencias
   │   definidas (sección 23 cap. 06)
   │
   ├── desastres: RTO/RPO por sistema, espejos,
   │   restauración automática de IaC (sección 23 cap.
   │   04), simulacro anual medido
   │
   ├── tabletop/ejercicios: escenarios inventados con
   │   el equipo (año completo en calendario)
   │
   ├── aprendizaje: post-mortems con acciones
   │   verificadas + reincidencias como métrica de
   │   gobierno (sección 03 de esta sección)
   │
   └── métricas: MTTD/MTTR, última restauración
       probada, simulacros hechos, acciones vencidas
```

### 7.2. Resumen

En este capítulo aprendiste que:

* incidente y desastre son dos mundos: contener-resolver vs. restaurar-aceptar pérdida;
* la respuesta tiene ritmo (detectar, contener, comunicar, resolver, normalizar) y roles mínimos (coordinador, executor, comunicador);
* los desastres se preparan con RTO/RPO, respaldos externos y restauraciones PROBADAS;
* guiones practicados en simulacro cambian el pico de tensión;
* el aprendizaje cierra el ciclo: post-mortem sin culpa → acción verificada → incidencia que no se repite;
* los errores típicos (improvisar desastre, pánico, sin roles, investigar sangrando, guiones oxidados, respaldo sin probar, punto único, reincidencias) se previenen con ensayo y métricas;
* a nivel profesional: programa de continuidad con ejercicio anual medido.

La idea principal es:

> **La confianza en la recuperación no se declara: se demuestra con una fecha — el día en que alguien restauró de verdad y el sistema volvió a funcionar.**

---

## Próximo paso

Ya sabes responder al peor día.

Ahora cómo se sostiene el largo plazo: mantenimiento y escalabilidad.

Continúa con:

[`05-mantenimiento-y-escalabilidad.md`](05-mantenimiento-y-escalabilidad.md)
