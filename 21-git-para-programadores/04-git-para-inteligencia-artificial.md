# Git para inteligencia artificial

## Introducción

Un proyecto de IA combina todas las presiones anteriores: código, notebooks, datos, experimentos, modelos de gigas y artefactos que cambian con cada corrida. Además aparecen cosas nuevas — prompts, configuraciones de entrenamiento, pipelines — que alguien debe versionar. Este capítulo establece qué va en Git y qué no, cómo documentar modelos y artefactos, y cómo mantener reproducible un pipeline de IA sin convertir el repositorio en un vertedero.

---

## Mapa conceptual de este capítulo

```text
Git para inteligencia artificial
       │
       ├── 1. Mapa de componentes: qué es qué
       │   ├── 2. Código, configs y prompts en Git
       │   ├── 3. Modelos y artefactos fuera del Git
       │   ├── 4. Pipelines de IA versionados
       │   └── 5. Secretos y datos sensibles en IA
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Mapa de componentes: qué es qué

```text
UN PROYECTO DE IA LLEVA:
   │
   ├── código (entrenamiento, evaluación, servicio)
   ├── configuraciones (hiperparámetros, rutas, semillas)
   ├── prompts (instrucciones a modelos)
   ├── datasets (referencias, no copias)
   ├── pesos del modelo (artifact — pesado)
   ├── resultados/métricas
   └── pipeline (orquestación de pasos)
```

```text
DÓNDE VIVE CADA COSA:
──────────────────────────────────────────────────────
EN GIT          código · configs · prompts · tests ·
                documentación · referencias de datos
FUERA DE GIT    datasets crudos · pesos · checkpoints
                · salidas grandes · caches
REGISTRADO       metadatos de modelo (qué commit, qué
                datos, qué métrica, dónde está el artefacto)
```

```text
   │
   └── el repositorio versiona el CÓMO; el almacén
       guarda el QUÉ PESADO — con una ficha que los
       une (punto 3)
```

---

## 2. Código, configs y prompts en Git

```text
CÓDIGO:
   │
   ├── lo normal: entreno/evalúo/sirvo como módulos
   │   revisables (sección 15 aplica igual)
   │
   └── tests de lógica (preproceso, métricas, contrato
       del servicio) — sección 09
```

```text
CONFIGS:
   │
   ├── YAML/JSON de experimento versionados → saber
   │   QUÉ cambió entre corridas (sección 21 cap. 03
   │   punto 4)
   │
   └── nombre único de corrida = config + fecha +
       versión del código
```

```text
PROMPTS:
   │
   ├── son código de producción: versionarlos (cambios
   │   con PR y revisión — sección 15)
   │
   ├── separar prompt de lógica (archivo/constante),
   │   no incrustado en 50 sitios
   │
   └── documentar evaluación: un cambio de prompt sin
       métrica es un salto a ciegas (Error 4)
```

```text
   │
   └── convención: prompts/ con versionado y nota de
       «cómo se evaluó este cambio»
```

---

## 3. Modelos y artefactos fuera del Git

```text
POR QUÉ FUERA:
   │
   └── pesos de gigas no son diffables: rompen clon,
       historial y plataformas (mismo criterio que los
       datasets — cap. 03 Error 1)
```

```text
DÓNDE (opciones — elige y documenta):
   │
   ├── almacén de modelos/registries (categoría de
   │   herramientas de registro de modelos)
   │
   ├── releases/objetos de almacenamiento con
   │   retención (sección 18 cap. 04)
   │
   └── Git LFS para lo pequeño/estable (cap. 05 de
       esta sección — no para checkpoints enormes)
```

```text
LA FICHA (metadatos en el repo):
   │
   ├── modelo-x v1.3
   │   ├── commit del código que lo entrenó
   │   ├── config (versión del YAML)
   │   ├── dataset (referencia+checksum)
   │   ├── métricas de evaluación
   │   └── ubicación del artefacto + digest
   │
   └── así se responde «¿de dónde salió este modelo?»
       (trazabilidad — sección 20 cap. 05)
```

```text
   │
   └── sin ficha, el modelo en el almacén es un
       archivo misterioso (Error 6)
```

---

## 4. Pipelines de IA versionados

```text
QUÉ ES EL PIPELINE AQUÍ:
   │
   └── la orquestación: obtener datos → entrenar →
       evaluar → publicar → (servir)
```

```text
VERSIONAR:
   │
   ├── el código de cada paso
   ├── la definición del pipeline (workflow/CI o
   │   script maestro)
   ├── las configs de cada etapa
   └── el flujo de despliegue del modelo (si aplica)
```

```text
EJECUCIÓN EN CI/CD (conexión secciones 19/22):
   │
   ├── entrenamiento largo: job con caché/artefactos,
   │   trigger manual o schedule (sección 19 cap. 02)
   │
   ├── evaluación como check antes de publicar
   │
   └── publicación del modelo con environment y
       aprobación (sección 20 cap. 07)
```

```text
   │
   └── «el modelo se entrenó con el pipeline de
       esta rama y este commit» — la misma disciplina
       del release de software
```

---

## 5. Secretos y datos sensibles en IA

```text
PUNTOS CALIENTES (además de los ya vistos):
   │
   ├── claves de APIs de modelos → solo en CI
   │   secrets/environments (sección 19/20)
   │
   ├── logs de entrenamiento: pueden filtrar rutas,
   │   ejemplos de datos o metadatos sensibles
   │
   ├── datasets con datos personales → NUNCA en git
   │   (cap. 06 de esta sección); referencias con
   │   acceso controlado
   │
   └── artefactos «de prueba» subidos a un repo
       público — revisar antes de compartir
```

```text
   │
   └── la regla de la etapa (sección 00): qué
       información NO debe almacenarse en un
       repositorio — en IA se suma: prompts con
       información confidencial de negocio o de
       usuarios (Error 3)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: pesos/checkpoints en el repo

**Qué ocurrió:** un commit trajo 3 GB de checkpoints; el clon se volvió inviable.

**Por qué:** «para tener el modelo a mano».

**Cómo comprobarlo:** `git ls-files | grep -E "(ckpt|pt|pth|safetensors|onnx)"`; tamaño.

**Opciones:** sacar del índice, ignorar, mover a almacén + ficha; purga consciente si el historial ya pesa (sección 13 cap. 02).

**Riesgos:** repo inmanejable y límites alcanzados.

**Solución:** ficha + almacén (punto 3).

**Cómo se evita:** checklist de plantilla (cap. 06).

---

### Error 2: config de experimento solo en la laptop

**Qué ocurrió:** se encontró un buen modelo y nadie sabía con qué hiperparámetros se entrenó.

**Por qué:** la config se cambió «en caliente» sin versionar.

**Cómo comprobarlo:** ¿existe el YAML de esa corrida? ¿está en git?

**Opciones:** reconstruir de logs si es posible; a partir de ahora versionar configs por corrida (punto 2).

**Riesgos:** modelos irreproducibles.

**Solución:** config versionada con nombre único (punto 2).

**Cómo se evita:** plantilla de experimento (cap. 03 punto 4).

---

### Error 3: prompt con datos sensibles versionado

**Qué ocurrió:** un prompt de prueba contenía correos/clientes de ejemplo reales y quedó en el historial público.

**Por qué:** se pegó contexto real en la instrucción.

**Cómo comprobarlo:** revisión de prompts/ + secret scanning extendido por cultura.

**Opciones:** incidente (limpiar si público) + mover datos reales a fixtures anonimizadas.

**Riesgos:** exposición de información personal (mayor gravedad que una clave).

**Solución:** prompts versionados, datos sintéticos (punto 5).

**Cómo se evita:** regla: en prompts de ejemplo, datos inventados siempre.

---

### Error 4: cambio de prompt sin evaluación

**Qué ocurrió:** se «mejoró» un prompt a ciegas y la calidad cayó; nadie se enteró hasta quejas.

**Por qué:** no había métrica asociada al cambio (punto 2).

**Cómo comprobarlo:** ¿el repo tiene evaluación? ¿el PR de prompt la ejecuta?

**Opciones:** suite de evaluación mínima (casos + métrica) como check de CI; documentar resultado en el PR.

**Riesgos:** regresión invisible.

**Solución:** prompt con evaluación (punto 2/4).

**Cómo se evita:** checklist de PR de prompts.

---

### Error 5: pipeline de IA sin versionar

**Qué ocurrió:** el entrenamiento se hacía con un script manual en una máquina con pasos que nadie conocía.

**Por qué:** nunca se llevó el pipeline al repo (sección 19/22).

**Cómo comprobarlo:** ¿el README describe el proceso? ¿existe script/workflow maestro?

**Opciones:** versionar los pasos y automatizar la orquestación; documentar estados.

**Riesgos:** conocimiento concentrado; «el día que se vaya fulano…».

**Solución:** pipeline como código (punto 4).

**Cómo se evita:** empezar por el script único y crecer.

---

### Error 6: modelo publicado sin ficha

**Qué ocurrió:** en el almacén había cinco versiones de un modelo; nadie sabía cuál iba a producción ni con qué datos se entrenó.

**Por qué:** publicar fue solo «subir el archivo» (punto 3).

**Cómo comprobarlo:** ¿cada artefacto tiene su metadatos (commit, config, dataset, métricas)?

**Opciones:** fichas para lo existente (aunque sea a posteriori desde logs) y obligatorio en el proceso nuevo.

**Riesgos:** despliegue a ciegas; imposible auditar (sección 20 cap. 05).

**Solución:** registro de modelos (punto 3).

**Cómo se evita:** paso obligatorio de publicación.

---

## 7. Práctica guiada

### Objetivo

Dejar un mini-proyecto de IA con la frontera código/artefactos clara y trazable.

### Paso 1: estructura

```text
mi-ia/
├── src/            # entreno, evalúo, sirvo
├── prompts/
├── configs/        # un YAML por corrida
├── tests/
├── data/README.md  # referencia al dataset
├── models/README.md  # fichas de artefactos
├── manifest/lock + .gitignore + README
```

### Paso 2: .gitignore de artefactos

```gitignore
checkpoints/
*.pt
*.pth
*.safetensors
outputs/
data/raw/
```

1. Verifica `git ls-files` limpio de binarios.

### Paso 3: primer prompt versionado

1. Extrae el prompt principal a `prompts/` con nota de cómo lo evalúas (aunque sea «casos en tests/»).

### Paso 4: ficha de modelo

```markdown
## modelo-ejemplo v1
- código: commit abc123
- config: configs/2026-10-02-baseline.yaml
- datos: dataset-X v3 (checksum ...)
- métricas: ...
- artefacto: [almacén] + digest
```

1. Añade el archivo a `models/` y apunta al artefacto que subiste al almacén.

### Paso 5: pipeline mínimo

1. Versiona un `run.sh` (o workflow) que: instala, entrena con config, evalúa y escribe métricas.
2. Añade CI ligero: tests + evaluación rápida con fixtures.

### Paso 6: secretos

1. Comprueba que ninguna clave de API está en el repo (búsqueda + sección 20) y que vive en un environment.

### Resultado esperado

Frontera código/artefactos, prompt versionado, ficha de modelo y pipeline reproducible.

### Conclusión esperada

La IA se versiona como disciplina: el repo guarda cómo se hace; el almacén guarda el qué pesado; la ficha los ata — y sin ella, el modelo es un archivo sin historia.

---

## 8. Nivel profesional + resumen

### 8.1. IA a escala

```text
   │
   ├── registro de modelos como sistema de verdad
   │   (cada producción con ficha y aprobación)
   │
   ├── evaluación como check obligatorio: cambios de
   │   prompt/config solo con métrica en el PR
   │
   ├── pipelines en CI/CD con environments (deploy de
   │   modelo — sección 22/24)
   │
   ├── trazabilidad completa: modelo → config → datos
   │   → código (requisito creciente de auditoría —
   │   mención)
   │
   ├── datos y artefactos con permisos y retención
   │   (sección 16/20)
   │
   └── métrica: % de modelos publicados con ficha
       completa; tiempo de reproducción de entrenamiento
```

### 8.2. Resumen

En este capítulo aprendiste que:

* mapa de componentes: código, configs y prompts en Git; datasets y pesos fuera con referencias;
* prompts versionados como código, con evaluación asociada;
* ficha de modelo: el puente entre git y el almacén de artefactos;
* pipeline de IA versionado y ejecutado con la disciplina de release;
* secretos y datos sensibles: APIs en environments, prompts sin datos reales, artefactos revisados antes de compartir;
* los errores típicos (pesos en git, config perdida, prompt con datos, cambio sin métrica, pipeline manual, modelo sin ficha) se previenen con fronteras y plantillas;
* a nivel profesional: registro de modelos, evaluación obligatoria y trazabilidad auditable.

La idea principal es:

> **El modelo es un artefacto; la inteligencia del proyecto está en la receta que lo produce — versiona la receta, registra la ficha y deja que los gigas vivan donde pueden ser gobernados.**

---

## Próximo paso

Ya sabes qué entra y qué no en un repo de IA.

Quedan dos piezas de esta sección: los archivos grandes que a veces sí van en Git y la lista final de lo que jamás debe entrar.

Continúa con:

[`05-datos-artefactos-y-archivos-grandes.md`](05-datos-artefactos-y-archivos-grandes.md)
