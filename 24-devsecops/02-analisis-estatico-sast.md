# Análisis estático (SAST)

## Introducción

**SAST** (Static Application Security Testing) es el análisis del código sin ejecutarlo buscando patrones de vulnerabilidad — ya viste su cara en GitHub con CodeQL (sección 20 cap. 04). Aquí ampliamos: SAST como CATEGORÍA (qué familia de herramientas existe más allá de un producto), cómo integrarlo en el PR sin ahogarlo, qué hacer con los falsos positivos, y cómo el análisis se extiende a infraestructura y configuración.

---

## Mapa conceptual de este capítulo

```text
Análisis estático (SAST)
       │
       ├── 1. La familia SAST (más allá de un producto)
       ├── 2. Integración en el PR (volumen y severidad)
       │   ├── 3. Falsos positivos y tuning
       │   ├── 4. Reglas propias y estándares de equipo
       │   └── 5. Estático en otras superficies (IaC,
       │           Dockerfiles, config)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. La familia SAST (más allá de un producto)

```text
QUÉ MIRA CADA VERSIÓN:
   │
   ├── lenguaje: flujos fuente→sumidero, APIs
   │   peligrosas (CodeQL y similares — sección 20
   │   cap. 04)
   │
   ├── linters con reglas de seguridad: reglas simples
   │   y muy rápidas (evaluaciones inseguras, APIs
   │   obsoletas — sección 06 + seguridad)
   │
   ├── análisis de dependencias SCA (sección 20 cap.
   │   03): el «código de otros» también es código
   │
   ├── secretos (sección 20 cap. 02): SAST de
   │   credenciales
   │
   └── IaC/contenedores (punto 5): análisis de
       plantillas y Dockerfiles
```

```text
   │
   └── «SAST» en una charla casi siempre es el
       primero; en un programa, es TODA esta familia
       corriendo en su sitio (Error 1 si se instala
       solo una pieza y se llama «seguridad»)
```

---

## 2. Integración en el PR (volumen y severidad)

```text
EL PACTO CON EL FLUJO (sección 01 cap. 02):
   │
   ├── el PR es la puerta: el análisis corre AHÍ
   │
   ├── severidad que BLOQUEA: lo explotable claro
   │   (o las que el equipo acuerde — Error 2 si
   │   bloquea todo)
   │
   ├── severidad que COMENTA/AVISA: el resto entra a
   │   backlog con dueño (cap. 06)
   │
   └── duración: dentro del presupuesto del PR
       (sección 22 cap. 01 Error 1)
```

```yaml
# esquema de integración (ya cubierto en sección 20
# cap. 02 — aquí el criterio de política):
# en el PR:
#   · secretos         → bloquea (push protection/CI)
#   · SAST crítico     → bloquea
#   · SAST warning     → comenta / ticket
# en main/schedule:
#   · análisis completo / profundo
```

```text
   │
   └── el error no es «poca seguridad» ni «mucha»: es
       no ACORDAR qué bloquea y qué no (Error 2)
```

---

## 3. Falsos positivos y tuning

```text
SUCEDERÁN (y está bien):
   │
   ├── la herramienta no entiende tu contexto (la
   │   fuente no es alcanzable, ya hay sanitización)
   │
   └── si el volumen ahoga, nadie lee — sección 20
       cap. 04 Error 4
```

```text
PROCEDIMIENTO (sección 20 cap. 04 punto 4, aquí como
disciplina):
   │
   ├── leer la ruta completa
   ├── ¿real? → fix en el PR
   ├── ¿falso? → descartar CON MOTIVO (auditable)
   └── mismo falso 3 veces → TUNING (ajustar regla,
       marcar excepción con comentario en código,
       regla propia)
```

```text
   │
   └── la excepción se comenta en el CÓDIGO («por qué
       esta línea es segura») — el descarte ciego
       pierde el aprendizaje (Error 3)
```

---

## 4. Reglas propias y estándares de equipo

```text
CUÁNDO HACE FALTA REGLA PROPIA:
   │
   ├── patrones de tu dominio (p. ej. validación de
   │   un formato interno, uso de tu capa de acceso a
   │   datos)
   │
   └── errores que el equipo ya cometió 2 veces (la
       tercera que la máquina lo vea)
```

```text
FORMA DE HACERLO (mención):
   │
   ├── reglas del linter con checks personalizados
   │   (barato, en el PR)
   │
   └── consultas sobre el motor que uses (si tu
       plataforma lo permite — p. ej. queries sobre la
       base de datos del código)
```

```text
ESTÁNDAR DE EQUIPO = lo que las reglas hacen cumplir:
   │
   ├── validación de entradas en la capa X
   ├── escapado por defecto en la capa Y
   ├── acceso a datos solo por la capa Z
   └── (estos estándares nacen de la sección 09 y la
       15 — el análisis es su guardia automático)
```

```text
   │
   └── el estándar escrito + la regla automática =
       el aprendizaje del equipo convertido en red
       (Error 4 si solo está escrito)
```

---

## 5. Estático en otras superficies (IaC, Dockerfiles, config)

```text
MISMA IDEA, OTROS ARCHIVOS:
   │
   ├── IaC (sección 23 cap. 04): puertos abiertos a
   │   0.0.0.0, storage público, logs sin cifrar —
   │   errores de plantilla detectables sin aplicar
   │
   ├── Dockerfile: root, latest, secretos en COPY,
   │   excesos de capas (sección 23 cap. 03)
   │
   ├── workflows de CI (sección 19 cap. 05): permisos
   │   amplios, acciones sin fijar, eventos
   │   privilegiados
   │
   └── config de app: debug en producción, TLS
       desactivado, timeouts eternos
```

```text
   │
   └── encaja en shift left: el error se ve en el PR
       ANTES de que la plantilla se aplique (punto 5
       de la sección 01) — «pequeño, en su momento»
```

```text
IMPLEMENTACIÓN PRÁCTICA:
   │
   ├── muchas de estas verificaciones vienen como
   │   checks en CI (acciones/herramientas de escaneo
   │   de IaC/imagenes — categoría)
   │
   └── la política es la misma: crítico bloquea,
       resto comenta (punto 2)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: instalar «un SAST» y declarar seguridad

**Qué ocurrió:** solo había análisis de lenguaje; los IaC y Dockerfiles eran un agujero conocido.

**Por qué:** se equiparó SAST con un producto (punto 1).

**Cómo comprobarlo:** revisa la familia: ¿qué superficies cubres hoy?

**Opciones:** añadir las capas que faltan por riesgo (sección 01 punto 2: proporcionalidad).

**Riesgos:** cobertura ilusoria.

**Solución:** familia completa y priorizada (punto 1).

**Cómo se evita:** el mapa de controles (sección 01 Paso 2).

---

### Error 2: todo bloqueante (o nada)

**Qué ocurrió:** o el PR se bloqueaba por notes cosméticas, o los hallazgos reales pasaban sin que nadie los viera.

**Por qué:** sin política de severidad (punto 2).

**Cómo comprobarlo:** ¿está escrito qué bloquea? ¿el equipo lo sabe?

**Opciones:** política: bloquea X, avisa Y; revisar cada trimestre si X es correcto.

**Riesgos:** ruido bloqueante → bypass; permisivo → olvido.

**Solución:** pacto explícito (punto 2).

**Cómo se evita:** documento de política en `docs/seguridad.md` (sección 01 Paso 5).

---

### Error 3: descartar sin motivo ni aprendizaje

**Qué ocurrió:** cientos de descartes iguales sin comentario; un hallazgo real del mismo tipo pasó borrado por costumbre.

**Por qué:** descarte como mecánica de supervivencia (punto 3).

**Cómo comprobarlo:** historial de descartes: ¿comentarios? ¿variación?

**Opciones:** exigir motivo; tuning cuando se repite (punto 3).

**Riesgos:** anestesia del detector.

**Solución:** descarte con motivo y tuning (punto 3).

**Cómo se evita:** checklist de triage (sección 20 cap. 04).

---

### Error 4: estándares solo en el wiki

**Qué ocurrió:** el equipo nuevo repetía los mismos fallos; el wiki decía «valida las entradas» pero nadie lo leía.

**Por qué:** sin guardia automática (punto 4).

**Cómo comprobarlo:** ¿los errores recurrentes tienen regla que los capture?

**Opciones:** convertir el error 2 veces repetido en regla (linter/checks); formación acompañada.

**Riesgos:** aprendizaje que no compone.

**Solución:** estándar + regla (punto 4).

**Cómo se evita:** revisar «errores repetidos» en la retro (sección 26).

---

### Error 5: análisis solo en main

**Qué ocurrió:** los hallazgos aparecían cuando el cambio ya estaba fusionado; la corrección era un PR nuevo.

**Por qué:** trigger mal colocado (sección 20 cap. 04 Error 3).

**Cómo comprobarlo:** en qué eventos corre el análisis.

**Opciones:** añadir pull_request; el análisis completo puede esperar a main, pero lo crítico va en PR.

**Riesgos:** shift left de nombre.

**Solución:** puerta en el PR (punto 2).

**Cómo se evita:** plantilla de CI (sección 18).

---

### Error 6: análisis que frena el PR fuera de presupuesto

**Qué ocurrió:** el escaneo profundo añadía 12 minutos a cada PR; el equipo pidió «solo en main» para todo.

**Por qué:** sin diseño de coste (punto 2).

**Cómo comprobarlo:** duración del análisis por evento.

**Opciones:** dividir: rápido en PR, profundo en main/schedule; caché; paralelizar.

**Riesgos:** el todo-o-nada: o lento en PR o ciego en PR.

**Solución:** proporcionalidad (punto 2 / sección 01).

**Cómo se evita:** presupuesto del PR (sección 22 cap. 01).

---

## 7. Práctica guiada

### Objetivo

Completar la capa estática de tu proyecto y escribir su política de severidad.

### Paso 1: inventario de superficies

```text
Tu repo:
   │
   ├── código       → ¿qué analiza? (SAST/linter)
   ├── dependencias → ¿Dependabot? (sección 20)
   ├── secretos     → ¿push protection?
   ├── Dockerfile   → ¿escaneo?
   ├── IaC/config   → ¿escaneo?
   └── workflows    → ¿revisión/sección 19?
```

1. Marca cubierto / hueco.

### Paso 2: hueco crítico primero

1. Elige el hueco de mayor riesgo (si no hay secretos: eso) y ciérralo (sección 20 caps. 02/03).

### Paso 3: política de severidad

```markdown
## Política SAST
- Bloquea el PR: secretos, hallazgos críticos de
  lenguaje, IaC con exposición pública
- Comenta/ticket: warnings y notas (dueño, SLA 30 días)
- Análisis profundo: main + schedule
- Descartes: con motivo; repetición → tuning
```

1. Publica en `docs/seguridad.md`.

### Paso 4: triage real

1. Provoke o espera un hallazgo: llévalo por los 4 pasos (ruta → fuente → protección → fix/descarte con motivo).

### Paso 5: primera regla de equipo

1. Toma un error que tu equipo haya cometido 2 veces y añade la regla que lo detecta (linter o check disponible).

### Paso 6: medir

1. Cuenta: hallazgos del PR, falsos positivos, tiempo añadido al PR. Anota como línea base (cap. 06).

### Resultado esperado

Superficies cubiertas o con plan, política publicada, un triage completo y una regla propia.

### Conclusión esperada

El análisis estático es el guardia del PR: completo por superficie, proporcional en severidad y educado por tuning — cuando disciplina, cada falso positivo lo convierte en regla mejor.

---

## 8. Nivel profesional + resumen

### 8.1. SAST a escala

```text
   │
   ├── estándar de la casa: mismas herramientas y
   │   severidades en todos los repos (plantillas —
   │   sección 18/25)
   │
   ├── tuning con datos: frecuencia de falsos
   │   positivos por regla; reglas propias del dominio
   │
   ├── IaC/config/Dockerfile como superficie de PR
   │   obligatoria en infra (sección 23/25)
   │
   ├── integración con el backlog de seguridad: los
   │   no bloqueantes tienen dueño y SLA (cap. 06)
   │
   └── métrica: hallazgos por PR, % descartados,
       tiempo de análisis, defectos escapados (post-
       mortem)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* SAST es familia: lenguaje, dependencias, secretos, IaC, Dockerfiles, workflows;
* integración en PR con política de severidad acordada: crítico bloquea, resto tiene dueño;
* falsos positivos: motivo auditable y tuning cuando se repiten — la excepción se comenta en el código;
* estándar de equipo + regla automática = aprendizaje que se compone;
* proporcionalidad: rápido en PR, profundo en main;
* los errores típicos (un producto llamado seguridad, todo/nada, descartes ciegos, wiki sin guardia, solo main, PR lento) se previenen con política y datos;
* a nivel profesional: estándar de la casa con métricas de tuning.

La idea principal es:

> **Un análisis estático solo protege cuando es completo por superficie, proporcional en el PR y disciplinado en sus excepciones — lo demás es un check verde que nadie lee.**

---

## Próximo paso

Ya lees el código sin ejecutarlo.

Ahora la otra mitad: probar el sistema que corre.

Continúa con:

[`03-analisis-dinamico-dast.md`](03-analisis-dinamico-dast.md)
