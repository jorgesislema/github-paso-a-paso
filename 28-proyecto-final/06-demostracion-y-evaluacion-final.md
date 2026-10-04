# Demostración y evaluación final

## Introducción

El Proyecto final termina cuando **puedes demostrar, con evidencias, que comprendes el flujo completo**: no basta con que el proyecto funcione — hay que recorrerlo y mostrar dónde vive cada pieza (código, documentación, Git, GitHub, ramas, commits, Pull Requests, pruebas, GitHub Actions, seguridad, CI/CD, release). Este capítulo prepara esa demostración: rutas de evidencia, la rúbrica del capítulo 01 aplicada como autoevaluación y el recorrido de defensa que convierte un repositorio en una prueba.

---

## Mapa conceptual de este capítulo

```text
Demostración y evaluación final
       │
       ├── 1. El recorrido de 15 minutos
       ├── 2. Mapa de evidencias (elemento → dónde)
       │   ├── 3. Autoevaluación con la rúbrica
       │   └── 4. El día de la demostración
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. El recorrido de 15 minutos

```text
EL TOUR (prepáralo y ensáyalo — Error 1 si lo
improvisas):
   │
   ├── 1. Qué es y para quién (README) — 1 min
   ├── 2. Cómo se ejecuta: comando en vivo — 2 min
   ├── 3. Estructura: árbol y responsabilidades — 2 min
   ├── 4. Historial: 2–3 commits que cuentan la historia
   │       — 2 min
   ├── 5. Un PR ejemplar: descripción, revisión,
   │       resolución — 3 min
   ├── 6. El pipeline: qué check hace qué + la prueba
   │       negativa que guardaste — 2 min
   ├── 7. Seguridad: scan, alerta resuelta, secretos —
   │       1 min
   └── 8. Release: versión, notas, artefacto, reversa —
       1 min
```

```text
   │
   └── cada paso tiene su ENLACE anotado (Error 2 si
       durante la demo buscas «a ver dónde estaba…»:
       la preparación ES parte de la demostración)
```

---

## 2. Mapa de evidencias (elemento → dónde)

```text
TABLA DE LA ETAPA 28 → TUS ENLACES (el corazón de la
defensa):
──────────────────────────────────────────────────────
ELEMENTO        DÓNDE VIVE LA EVIDENCIA
código          src/ + commits
documentación   README + docs/ (ADRs, flujo, rúbrica)
Git             historial local: log, ramas
GitHub          repo remoto, issues, tablero
ramas/commits   git log --all --oneline
Pull Requests   pestaña de PRs (≥ 6, con revisión)
pruebas         suite + ejecución en rojo guardada
Actions         workflows + runs (historial)
seguridad       secret scanning, Dependabot, permisos
CI/CD           checks requeridos + deploy (si aplica)
release         etiqueta + notas + artefacto
──────────────────────────────────────────────────────
```

```text
LO QUE DISTINGUE UNA DEFENSA FUERTE (Error 3 si
alguna fila está vacía):
   │
   ├── evidencias ENCONTRABLES (URL/Comando) — no
   │   «ya estaría en algún sitio»
   │
   ├── evidencias EJERCIDAS (rojo visto, alerta
   │   resuelta, bloqueo probado) — Error 4 si solo hay
   │   «configurado»
   │
   └── una fila que puedas explicar con sus CONTRAS:
       «esto lo hice así porque…» (Error 3 —
       sección 26 cap. 06: pagos de la decisión)
```

---

## 3. Autoevaluación con la rúbrica

```text
APLICA TU RÚBRICA (docs/rubrica.md — basada en el capítulo 07):
   │
   ├── flujo: ¿cada elemento del punto 2 tiene evidencia?
   ├── disciplina: historial legible · ≥ 6 PRs · issues
   │   cerrados
   ├── calidad: pruebas bloqueantes + prueba negativa
   ├── seguridad: scan activo + alerta atendida + cero
   │   secretos
   ├── entrega: release + notas + artefacto verificado
   └── lectura: tour de 15 min sin guía
```

```text
CÓMO EVALUAR HONESTAMENTE (Error 5 si te autoengañas):
   │
   ├── puntúa con ENLACES, no con memoria (si no hay
   │   enlace, no hay evidencia)
   │
   ├── los «4/5» sin justificación no valen: anota QUÉ
   │   falta
   │
   └── lo que falte: backlog con fecha ANTES de entregar
       — Error 6 si lo dejas «ya se verá»
```

```text
   │
   └── si una fila queda vacía tras intentarlo: di LO
       QUE FALTA Y POR QUÉ en la demo (Error 7 si lo
       ocultas: la honestidad del alcance recortado es
       madurez — Error 6 sección 01 de esta sección)
```

---

## 4. El día de la demostración

```text
PREPARACIÓN (la noche/mañana antes):
   │
   ├── todo en main verde (últimos checks OK)
   ├── entorno listo para ejecutar en vivo (clon limpio
   │   de respaldo — Error 8 si dependes de tu carpeta
   │   «ya configurada»)
   ├── enlaces del punto 2 en una sola página
   └── ensayo completo: 15 minutos, cronometrado (Error
       9 si es la primera vez el día D)
```

```text
DURANTE (ritmo):
   │
   ├── empieza por el README y la ejecución (valor
   │   primero — Error 10 si empiezas por configurar
   │   el entorno: la primera impresión se pierde)
   │
   ├── deja que la demostración responda las preguntas:
       muestra PRs cuando pregunten por calidad, runs
       cuando pregunten por CI (Error 3 prevención)
   │
   └── di los pagos: «elegí X, pagué Y» — el senior se
       reconoce en los trade-offs (Error 1 —
       sección 26 cap. 06)
```

```text
DESPUÉS:
   │
   └── retro final: ¿qué rúbrica se quedó corta? Eso es
       tu plan de mejora — el proyecto terminó, el flujo
       continúa (sección 23 cap. 01)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: demostración improvisada

**Qué ocurrió:** durante la defensa, el autor buscó files y ramas sin saber qué mostrar.

**Por qué:** sin recorrido ensayado (punto 1).

**Cómo comprobarlo:** ¿has hecho el tour completo una vez con cronómetro?

**Opciones:** ensayar hoy, anotar enlaces, repetir hasta 15 min.

**Riesgos:** impresión de desorden (Error 2 punto 1).

**Solución:** recorrido ensayado (punto 1).

**Cómo se evita:** la práctica del punto 6.

---

### Error 2: evidencias no encontrables

**Qué ocurrió:** «¿dónde está el PR?» — tres minutos de búsqueda.

**Por qué:** sin mapa (punto 2).

**Cómo comprobarlo:** pasa la tabla del punto 2: ¿cada fila tiene enlace?

**Opciones:** completar el mapa; corregir lo que no existe (creándolo).

**Riesgos:** la defensa pierde credibilidad por minutos.

**Solución:** mapa con URLs (punto 2).

**Cómo se evita:** mantener el mapa al día con cada entrega de capítulo.

---

### Error 3: fila vacía en la tabla

**Qué ocurrió:** «seguridad» no tenía nada que mostrar: ni scan, ni alerta.

**Por qué:** elementos sin evidencia (punto 2 Error 3).

**Cómo comprobarlo:** revisión fila por fila.

**Opciones:** ejecutar lo falta (activar, resolver, probar) antes de entregar.

**Riesgos:** la etapa 28 exige los 12 elementos.

**Solución:** evidencia obligatoria (punto 2).

**Cómo se evita:** la rúbrica temprana del capítulo 01.

---

### Error 4: «configurado» sin «ejercido»

**Qué ocurrió:** el candidato mostró ajustes activos y nunca pudo mostrar un bloqueo o una alerta atendida.

**Por qué:** confundir feature con evidencia (punto 2 Error 4).

**Cómo comprobarlo:** ¿puedes mostrar el momento en que el control ACTUÓ?

**Opciones:** crearlo: prueba negativa, alerta resuelta, scan ejecutado.

**Riesgos:** demostración hueca.

**Solución:** ejercer (punto 2/3).

**Cómo se evita:** los controles se prueban rompiéndolos (Error 4 — sección 28 cap. 04).

---

### Error 5: autoevaluación inflada

**Qué ocurrió:** «todo 5» en la rúbrica y al preguntar, tres cosas sin evidencia.

**Por qué:** puntúo por memoria (punto 3).

**Cómo comprobarlo:** cada 5 con enlace; si no, es 0.

**Opciones:** reevaluar con enlaces y backlog honesto.

**Riesgos:** descubrirlo peor en la evaluación externa.

**Solución:** puntúa con enlaces (punto 3).

**Cómo se evita:** regla: «sin enlace, sin punto».

---

### Error 6: falta sin plan

**Qué ocurrió:** se detectó que faltaba el changelog y se «dejó para después» — nunca llegó.

**Por qué:** backlog sin fecha (punto 3 Error 6).

**Cómo comprobarlo:** ¿las faltas tienen fecha en algún sitio?

**Opciones:** fecha y dueño (tú) antes de la entrega; o recorte honesto comunicado (Error 7 punto 3).

**Riesgos:** entregas incompletas por descuido.

**Solución:** backlog con fecha (punto 3).

**Cómo se evita:** autoevaluación 48 h antes de la fecha.

---

### Error 7: ocultar lo que falta

**Qué ocurrió:** la demo esquivó la pregunta sobre despliegue; después se supo que no existía.

**Por qué:** sin honestidad de alcance (punto 3 Error 7).

**Cómo comprobarlo:** ¿qué partes de la rúbrica no se mencionaron?

**Opciones:** mencionarlo con el plan de remediación; el alcance recortado estaba escrito (Error 6 sección 01).

**Riesgos:** la confianza se rompe entera.

**Solución:** decirlo con plan (punto 3).

**Cómo se evita:** cultura de decisiones escritas (sección 25/26).

---

### Error 8: dependencia del entorno personal

**Qué ocurrió:** en vivo, la demo falló porque dependía de archivos de la máquina del autor.

**Por qué:** sin clon limpio de respaldo (punto 4).

**Cómo comprobarlo:** ¿puedes clonar y ejecutar en 5 minutos?

**Opciones:** preparar clon limpio y ensayar desde ahí.

**Riesgos:** fallo en vivo.

**Solución:** entorno reproducible (punto 4).

**Cómo se evita:** «instalación en limpio» como hábito (sección 27 cap. 04 Error 2).

---

### Error 9: primer ensayo el día D

**Qué ocurrió:** el tour completo se hizo por primera vez durante la demostración.

**Por qué:** sin ensayo (Error 9 del punto 4).

**Cómo comprobarlo:** ¿cuántas veces has cronometrado el tour?

**Opciones:** ensayar al menos dos veces; pulir tiempos.

**Riesgos:** nervios + desorden.

**Solución:** ensayo cronometrado (punto 4).

**Cómo se evita:** fecha de ensayo en el plan de entrega.

---

## 6. Práctica guiada

### Objetivo

Dejar el Proyecto final listo para demostrarse: mapa completo, rúbrica cerrada y tour ensayado.

### Paso 1: mapa de evidencias

1. Rellena la tabla del punto 2 con tus enlaces reales. Cada fila: URL o comando exacto.

### Paso 2: parches

1. Filas vacías o «solo configurado»: ejecuta (prueba negativa, alerta, scan, release…). Son tus tareas prioritarias.

### Paso 3: autoevaluación honesta

1. Aplica la rúbrica con enlaces (punto 3). Las faltas: backlog con fecha.

### Paso 4: ensayo 1

1. Tour completo cronometrado desde un clon limpio (punto 4). Anota dónde te pierdes.

### Paso 5: ensayo 2

1. Repite: ≤ 15 min, sin buscar enlaces, con la prueba negativa a mano.

### Paso 6: la página de defensa

```text
Una sola página:
   [ ] enlaces del mapa de evidencias
   [ ] comando de ejecución
   [ ] PR ejemplar + run del pipeline
   [ ] release + reversa
   [ ] (si aplica) lo que falta y su plan
```

### Resultado esperado

Tabla completa con enlaces, rúbrica puntuada con evidencia y dos ensayos cronometrados del recorrido.

### Conclusión esperada

La demostración no añade nada al proyecto: lo REVELA — y un proyecto que se revela solo, en 15 minutos y sin su autor de guía, es exactamente la prueba de que el flujo se comprendió de verdad.

---

## 7. Nivel profesional + resumen

### 7.1. De la demo al trabajo

```text
   │
   ├── este recorrido es literalmente lo que haces al
   │   presentar un proyecto a un equipo o entrevista:
   │   README → ejecutar → PRs → pipeline → release
   │
   ├── el mapa de evidencias es la base de tu portafolio:
   │   enlaces estables a trabajo real (Error 2
   │   prevención)
   │
   ├── la autoevaluación honesta con plan es «mejora
   │   continua» aplicada a ti mismo (sección 23 cap. 01)
   │
   └── y el tour que explica sus CONTRAS es la señal
       que un senior detecta al instante: quien conoce
       sus trade-offs conoce su oficio (sección 26
       cap. 06)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* la demostración es un recorrido ensayado de 15 minutos: README, ejecución, historial, PR, pipeline, seguridad y release;
* el mapa de evidencias convierte cada elemento de la etapa 28 en un enlace encontrable y ejercido;
* la rúbrica se autoevalúa con enlaces — sin enlace, sin punto — y las faltas tienen backlog con fecha o recorte honesto;
* el día D se prepara: clon limpio, página única, ensayos cronometrados;
* los errores típicos (improvisar, evidencias perdidas, filas vacías, configurado sin ejercer, rúbrica inflada, faltas sin plan, ocultar, entorno personal, ensayo tardío) se previenen con preparación;
* el proyecto termina con una retro: lo que faltó es el plan de mejora siguiente.

La idea principal es:

> **Demostrar el flujo completo no es un discurso: es un recorrido donde cada afirmación se señala con un enlace — y donde lo que falta se dice antes de que alguien lo pregunte.**

---

## Próximo paso

Has completado el Proyecto final.

Continúa con el cierre de la sección:

[`README.md`](README.md)
