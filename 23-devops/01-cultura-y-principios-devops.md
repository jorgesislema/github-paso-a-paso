# Cultura y principios DevOps

## Introducción

**DevOps** no es una herramienta ni un cargo: es la unión de desarrollo y operaciones en un solo flujo de responsabilidad. La idea central: quien construye también se preocupa por cómo corre en producción, y quien opera participa en cómo se construye. Git es la columna vertebral de esa unión — el historial, los PRs y los pipelines son el lugar donde ambos mundos se encuentran. Este capítulo define la cultura, sus principios y cómo se mide.

---

## Mapa conceptual de este capítulo

```text
Cultura y principios DevOps
       │
       ├── 1. El problema: dos mundos separados
       ├── 2. Principios del flujo DevOps
       │   ├── 3. El bucle: retroalimentación
       │   ├── 4. Responsabilidad compartida (y dueños)
       │   └── 5. Cómo se mide (métricas de flujo)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El problema: dos mundos separados

```text
EL ANTIGUO MODELO:
──────────────────────────────────────────────────────
Desarrollo: "funciona en mi máquina"
     ↕ (bola de nieve manual)
Operaciones: "otra entrega a las 17:00 de viernes"
```

```text
CONSECUENCIAS:
   │
   ├── entregas lentas y temerosas
   ├── culpas cruzadas en incidentes
   ├── conocimiento concentrado en cada bando
   └── el usuario sufre la distancia entre ambos
```

```text
DEVOPS PROPONE:
   │
   ├── un MISMO equipo responsable de construir y
   │   operar
   │
   ├── el mismo flujo (Git → CI/CD → producción) para
   │   todos
   │
   └── automatización en lugar de traspasos manuales
       (cap. 02)
```

```text
   │
   └── «cultura» no es eslogan: es que operaciones
       tiene voz en el diseño y desarrollo tiene turno
       en la guardia (punto 4)
```

---

## 2. Principios del flujo DevOps

```text
1. FLUJO: trabajo pequeño, continuo, de izquierda a
   derecha (ramas cortas → PR → CI → entrega — todo
   lo visto en el curso)
   │
2. BUCLE DE RETROALIMENTACIÓN: cada paso informa al
   anterior (producción dice la verdad al código)
   │
3. APRENDIZAJE CONTINUO: los incidentes producen
   controles, no culpas (post-mortem — sección 22)
   │
4. AUTOMATIZACIÓN: lo que se hace dos veces se
   automatiza (cap. 02)
   │
5. REUTILIZACIÓN: plantillas, workflows y
   componentes compartidos (sección 19/25)
```

```text
EN GIT SE VEN ASÍ:
   │
   ├── flujo       → sección 17 (estrategias de ramas)
   ├── feedback    → sección 15/19 (PRs + CI)
   ├── aprendizaje → sección 26 (post-mortems)
   └── automatización → secciones 19/22
```

```text
   │
   └── DevOps no añade un capítulo nuevo al curso:
       es la HOJA DE RUTA que los conecta (Error 1)
```

---

## 3. El bucle: retroalimentación

```text
BUCLE COMPLETO:
──────────────────────────────────────────────────────
usuario → producción → métricas/alertas (cap. 06)
   → decisiones → backlog → código → CI → entrega
   → producción (más rápida y mejor)
```

```text
   │
   └── la longitud del bucle es el verdadero indicador
       de madurez: ¿cuánto tarda una idea en llegar
       probada a producción? ¿y un hallazgo de
       producción en convertirse en cambio?
```

```text
BUCLES CORTOS:
   │
   ├── PRs pequeños → feedback de revisión en horas
   ├── CI rápido → feedback técnico en minutos
   ├── despliegues frecuentes → feedback de usuario en
   │   días
   └── alertas útiles → feedback de operación en
       segundos (cap. 06)
```

```text
   │
   └── bucles largos = aprendizaje lento = decisiones
       con datos viejos (Error 3)
```

---

## 4. Responsabilidad compartida (y dueños)

```text
SHARED RESPONSIBILITY NO ES "TODOS DE TODO":
   │
   ├── es "todos responden por el resultado" con
   │   DUEÑOS claros por servicio (sección 16 cap. 06)
   │
   └── el autor del cambio acompaña su despliegue y su
       incidencia (sección 16)
```

```text
ROLES QUE SIGUEN EXISTIENDO (sin silos):
   │
   ├── quien diseña, quien revisa, quien despliega,
   │   quien observa — rotan y se solapan
   │
   └── el especialista de plataforma (si lo hay) da
       plataforma; no puerta (Error 5)
```

```text
   │
   └── guardias (mención): turnos donde alguien es la
       cara del servicio — proceso clásico, con
       descanso y rotación (sección 16/26)
```

---

## 5. Cómo se mide (métricas de flujo)

```text
CUATRO INDICADORES CLÁSICOS (mención: marco de
referencia DORA — verifique su marco actual):
   │
   ├── frecuencia de despliegue    (¿cuántas veces
   │                                 entregamos?)
   ├── lead time de cambios        (commit → producción)
   ├── tiempo de restauración      (incidente →
   │                                 servicio OK)
   └── tasa de cambio fallido      (¿cuántos
                                     despliegues
                                     rompen?)
```

```text
   │
   └── no son «calificaciones»: son un BARÓMETRO del
       flujo — un número malo abre la pregunta «¿dónde
       está el cuello de botella?» (Error 6)
```

```text
CÓMO EMPEZAR A MEDIAR (sin obsesión):
   │
   ├── cuenta despliegues del mes (frecuencia)
   ├── mide duración del CI y del release (lead time
   │   aproximado)
   └── revisa incidentes: ¿tiempo de respuesta?
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: «ya hacemos DevOps porque usamos Actions»

**Qué ocurrió:** se adoptó la herramienta y la cultura siguió igual: dev construía, ops sufría.

**Por qué:** se confundió medio con fin (punto 2).

**Cómo comprobarlo:** ¿operaciones participa en diseño? ¿desarrollo tiene guardia? ¿el post-mortem es conjunto?

**Opciones:** trabajar los principios (flujo, feedback, dueños); la herramienta ya está.

**Riesgos:** DevOps de folleto.

**Solución:** cultura primero, herramienta después (punto 2).

**Cómo se evita:** retro que mire el bucle completo (punto 3).

---

### Error 2: mega-entregas «porque los ciclos son caros»

**Qué ocurrió:** se liberaba cada 3 meses porque el proceso era tan doloroso que se amortizaba el sufrimiento.

**Por qué:** el bucle es largo y nadie lo acorta (punto 3).

**Cómo comprobarlo:** frecuencia de entrega actual vs. deseada.

**Opciones:** atacar el cuello de botella real (¿tests lentos? ¿aprobación manual? ¿entorno compartido?) — no pedir «más esfuerzo».

**Riesgos:** ciclo largo = cambio grande = riesgo grande = más lentitud (círculo vicioso).

**Solución:** acortar por donde duele (punto 3).

**Cómo se evita:** métrica de lead time en la retro (punto 5).

---

### Error 3: métricas como examen

**Qué ocurrió:** el equipo maquilló frecuencia de despliegue para «puntuar mejor».

**Por qué:** número sin pregunta asociada (punto 5).

**Cómo comprobarlo:** ¿los números se discuten o se exhiben?

**Opciones:** usarlas solo para diagnóstico y conversación; retirar el hábito de «ranking».

**Riesgos:** Goodhart: el número deja de medir.

**Solución:** barómetro, no nota (punto 5).

**Cómo se evita:** acuerdo de equipo sobre cómo se usan las métricas (sección 26).

---

### Error 4: responsabilidad compartida = responsabilidad nadie

**Qué ocurrió:** incidente y todos a esperar a «el de operaciones» (que no estaba).

**Por qué:** se quitó el silo sin poner dueños (punto 4).

**Cómo comprobarlo:** ¿hay dueño por servicio y suplente?

**Opciones:** restaurar dueños claros con rotación de guardias.

**Riesgos:** la aldea se quedó sin alguacil.

**Solución:** compartida CON nombres (punto 4).

**Cómo se evita:** matriz de dueños (sección 16 cap. 06).

---

### Error 5: plataforma como puerta lenta

**Qué ocurrió:** cada despliegue pedía ticket al equipo de plataforma y tardaba días.

**Por qué:** el especialista controló el cuello de botella (punto 4).

**Cómo comprobarlo:** tiempo de espera por despliegue.

**Opciones:** dar plataforma autoservicio (pipeline, environments, documentación); que plataforma elimine fricción, no la administre.

**Riesgos:** DevOps muerto en el último metro.

**Solución:** servicio interno con SLA (sección 25/26).

**Cómo se evita:** métrica de espera de plataforma.

---

### Error 6: métricas sin pregunta

**Qué ocurrió:** dashboard enorme, decisiones igual de lentas.

**Por qué:** medir sin hipótesis (punto 5).

**Cómo comprobarlo:** última decisión tomada gracias a un número del dashboard.

**Opciones:** empezar con 2–3 indicadores ligados a preguntas reales («¿por qué el lead time es de 3 semanas?»).

**Riesgos:** vanidad de datos.

**Solución:** pregunta → métrica → acción (punto 5).

**Cómo se evita:** el dashboard nace de la retro, no al revés.

---

## 7. Práctica guiada

### Objetivo

Evaluar el bucle completo de tu proyecto y acortar un tramo.

### Paso 1: mapa del bucle

```text
Dibuja TU cadena real:
   │
   idea → rama → PR → CI → aprobación → despliegue →
   producción → alerta → decisión → siguiente cambio
```

1. Anota el tiempo aproximado de cada flecha.

### Paso 2: diagnóstico

1. ¿Dónde está el mayor tiempo? (Ej: aprobación de 4 días, CI de 25 min, despliegue manual mensual.)

### Paso 3: primeras métricas

```text
Este mes:
   │
   ├── nº de despliegues
   ├── duración media del CI de PR
   └── incidentes + tiempo a resolver
```

### Paso 4: acortar UN tramo

1. Elige el cuello de botella y elimínalo (automatiza un paso, mueve un gate, parte un job — técnica en secciones 19/22).
2. Vuelve a medir: ¿mejoró?

### Paso 5: dueños

1. Escribe la lista de componentes con dueño y suplente (aunque seas tú solo: consta por escrito).

### Paso 6: acuerdos de equipo

```markdown
## Acuerdos DevOps
- Preguntas del bucle: [cuáles medimos y por qué]
- Post-mortem sin culpa en cada incidente
- Dueños por componente (y su suplente)
- Plataforma elimina fricción: no es puerta
```

### Resultado esperado

Bucle mapeado, cuello de botella atacado, primeras métricas y acuerdos escritos.

### Conclusión esperada

DevOps es la longitud del bucle: mides dónde se atasca, quitas ese tramo y repites — la cultura se demuestra quitando fricción, no en declaraciones.

---

## 8. Nivel profesional + resumen

### 8.1. DevOps a escala

```text
   │
   ├── platform engineering: equipo que construye la
   │   plataforma autoservicio (sección 25/26)
   │
   ├── métricas de flujo como programa (no ad-hoc),
   │   con conversación en cada retro (sección 26)
   │
   ├── guardias con rotación, on-call y post-mortems
   │   estandarizados (sección 16/26)
   │
   ├── estandares de repositorio y pipelines como
   │   producto interno (sección 18/25)
   │
   └── mejora continua: cada incidente y cada retro
       dejan un control (sección 24/26)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* DevOps une desarrollo y operaciones en un flujo y una responsabilidad — Git es su columna vertebral;
* principios: flujo, retroalimentación, aprendizaje, automatización y reutilización;
* el bucle corto es la medida real de madurez: ideas y hallazgos que giran rápido;
* responsabilidad compartida con DUEÑOS, no con nadie;
* métricas de flujo (frecuencia, lead time, restauración, cambio fallido) como barómetro, no como examen;
* los errores típicos (herramienta sin cultura, entregas gigantes, métricas de folleto, dueños desaparecidos, plataforma-puerta, dashboards sin preguntas) se previenen con foco en el bucle;
* a nivel profesional: plataforma como producto y mejora continua institucionalizada.

La idea principal es:

> **DevOps se mide en la longitud del bucle: cada semana que acortas entre idea, entrega y aprendizaje es cultura demostrada — el resto son palabras sin pipeline detrás.**

---

## Próximo paso

Ya ves el flujo completo.

Ahora la pieza metodológica: convertir en automatización todo lo que se hace dos veces.

Continúa con:

[`02-automatizacion-como-disciplina.md`](02-automatizacion-como-disciplina.md)
