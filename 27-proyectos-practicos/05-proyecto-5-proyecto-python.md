# Proyecto 5: proyecto Python

## Introducción

El Proyecto 5 añade a la fábrica del Proyecto 4 lo que exige un lenguaje de programación real: **estructura de paquetes, pruebas automatizadas como contrato y una liberación versionada**. Con Python se practican las secciones 21 (git para programadores) y 17 (versionado y releases): el repositorio deja de ser un sitio y se convierte en un producto con versiones, changelog y consumidores — aunque el consumidor seas tú dentro de seis meses.

---

## Mapa conceptual de este capítulo

```text
Proyecto 5: proyecto Python
       │
       ├── 1. Qué construyes y qué conceptos incorpora
       ├── 2. Estructura del proyecto
       │   ├── 3. Pruebas como contrato del pipeline
       │   └── 4. Versiones y release
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes y qué conceptos incorpora

```text
EL PROYECTO:
   │
   ├── una herramienta/CLI o biblioteca Python real
   │   (algo con CLI: procesar archivos, convertir,
   │   generar reportes — utilidad concreta y
   │   ejecutable)
   │
   └── entregable doble: código con pruebas + PRIMER
       RELEASE publicado con versión
```

```text
CONCEPTOS NUEVOS (secciones 17/21/22):
   │
   ├── estructura de paquete Python (sección 21 cap. 01)
   ├── virtualenv/entorno aislado y dependencias fijadas
   │   (sección 21 cap. 01)
   ├── pruebas automatizadas en CI (sección 22 cap. 03)
   ├── semver + tag + changelog (sección 17 cap. 05/06)
   └── release como artefacto (sección 22 cap. 05)
```

```text
   │
   └── el salto: de «sitio que se publica» a «producto
       que se VERSIONA» — y eso cambia cómo escribes
       commits (Error 1 sección 06 cap. 01:
       atómicos ahora importan más)
```

---

## 2. Estructura del proyecto

```text
ÁRBOL SUGERIDO (convención Python — sección 21 cap.
01):
   │
   ├── README.md              → instalación, uso, ejemplos
   ├── pyproject.toml         → metadatos + dependencias
   ├── .gitignore             → entornos, __pycache__,
   │                            .venv (desde el día 1)
   ├── src/<paquete>/         → código
   ├── tests/                 → pruebas
   ├── docs/                  → decisiones/guías (opcional)
   └── .github/workflows/     → calidad, pruebas, release
```

```text
LO QUE NO ENTRA AL REPO (Error 1 si entra):
   │
   ├── .venv/ , __pycache__/ , .pytest_cache/ (gitignore)
   ├── datos grandes de prueba (sección 21 cap. 05:
   │   muestra pequeña + regeneración)
   └── secretos/credenciales (sección 20 cap. 01)
```

```text
   │
   └── convención documentada en README: cómo instalar
       en 3 comandos, cómo ejecutar pruebas en 1 (Error
       2 si «funciona en mi máquina»: el entorno se
       describe, no se supone)
```

---

## 3. Pruebas como contrato del pipeline

```text
EL PRINCIPIO (sección 22 cap. 03):
   │
   ├── pruebas unitarias del paquete (funciones
   │   principales + casos límite)
   │
   ├── el CI ejecuta: install → lint (si aplica) →
   │   pruebas — Y el check es requerido (sección 03
   │   de esta sección — la puerta ya sabes ponerla)
   │
   └── «pruebas que fallan sin el cambio»: si tu suite
       pasaría con el código roto, no prueba nada (Error
       3)
```

```text
CÓMO ELEGIR QUÉ PROBAR:
   │
   ├── la lógica, no el framework (Error 4 si solo
   │   testea imports)
   ├── casos límite: vacío, mal formato, límites
   └── el «humo» de la CLI: `--help` funciona, ejemplo
       real corre
```

```text
   │
   └── métrica honesta: no «% de cobertura» como
       trofeo, sino «¿la suite detecta un error
       deliberado?» — pruébalo rompiendo algo (Error 3
       prevención)
```

---

## 4. Versiones y release

```text
PRIMER RELEASE (sección 17 + 22 cap. 05):
   │
   ├── 1. versión inicial 0.1.0 (semver: sección 17
   │   cap. 05 — 0.x = API inestable, ¡dílo en el
   │   README!)
   ├── 2. changelog: qué incluye y cómo usarla
   ├── 3. tag `v0.1.0` + release en la plataforma (con
   │   notas — sección 17 cap. 06)
   └── 4. artefacto: paquete/zip construido por el
       pipeline (Error 5 si subes el zip a mano: no
       practicaste artefactos)
```

```text
DESPUÉS DEL RELEASE (el ciclo que practicas 1 vez más):
   │
   ├── main sigue creciendo en «desarrollo»
   ├── cambio no compatible → lo notas en changelog
   │   (sección 17 cap. 05)
   └── siguiente release 0.2.0 con el mismo proceso
       (Error 6 si el proceso solo funciona «la primera
       vez»: no es proceso, es ritual)
```

```text
   │
   └── «¿qué versión tengo en producción?» es la
       pregunta que este proyecto te enseña a responder
       para siempre
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: entorno y artefactos en el repo

**Qué ocurrió:** `.venv/` y `__pycache__/` subidos; el repo pesaba 40 MB y los diffs eran ruido.

**Por qué:** .gitignore tardío (punto 2).

**Cómo comprobarlo:** `git ls-files` y el tamaño del historial.

**Opciones:** gitignore + `git rm -r --cached` + commit de limpieza; si el historial quedó sucio, valorar reinicio (Error 8 sección 25 cap. 05 — irreversibilidad).

**Riesgos:** ruido permanente en diffs.

**Solución:** gitignore desde el día 1 (punto 2).

**Cómo se evita:** checklist de repo nuevo (sección 18).

---

### Error 2: «en mi máquina funciona»

**Qué ocurrió:** el CI instaló versión distinta y las pruebas fallaron donde nunca fallaban.

**Por qué:** dependencias no fijadas/descripción incompleta (punto 2).

**Cómo comprobarlo:** ¿otra persona puede instalar con el README y correr las pruebas?

**Opciones:** fijar dependencias (lockfile o rangos exactos según convención), probar el README en limpio.

**Riesgos:** imposibilidad de reproducir (Error 4 sección 05 cap. 22).

**Solución:** entorno descrito y fijado (punto 2).

**Cómo se evita:** «instalación en limpio» como parte de la entrega.

---

### Error 3: pruebas que no prueban

**Qué ocurrió:** suite verde con lógica rota: los tests solo importaban módulos.

**Por qué:** sin aserciones sobre comportamiento (punto 3).

**Cómo comprobarlo:** rompe a propósito una función: ¿la suite falla?

**Opciones:** reescribir con aserciones de resultado y límites; prueba de mutación mental.

**Riesgos:** ceguera de calidad (falso verde).

**Solución:** contrato real (punto 3).

**Cómo se evita:** «¿detecta errores?» como criterio de revisión de cada PR con tests.

---

### Error 4: probar el framework, no la lógica

**Qué ocurrió:** 20 tests verificando que la CLI imprime… sin verificar lo que calcula.

**Por qué:** foco mal puesto (punto 3).

**Cómo comprobarlo:** lee la suite: ¿cuántas aserciones miran resultados de negocio?

**Opciones:** equilibrar: lógica primero, humo después.

**Riesgos:** cero protección donde hay riesgo.

**Solución:** la lógica, no el framework (punto 3).

**Cómo se evita:** mapa: cada módulo con lógica → su test.

---

### Error 5: primer release a mano

**Qué ocurrió:** el zip se generó y subió manualmente; al siguiente release, nadie recordaba los pasos.

**Por qué:** release sin pipeline (punto 4).

**Cómo comprobarlo:** ¿el artefacto lo hizo el CI o una persona?

**Opciones:** workflow de release por tag (sección 22 cap. 05); probar con v0.1.0.

**Riesgos:** releases irreproducibles.

**Solución:** artefacto del pipeline (punto 4).

**Cómo se evita:** «tag → artefacto solo» como criterio de done.

---

### Error 6: proceso que solo funciona la primera vez

**Qué ocurrió:** el segundo release se saltó changelog y notas; los consumidores no supieron qué cambió.

**Por qué:** no se formalizó el ciclo (punto 4).

**Cómo comprobarlo:** compara release 1 y 2: ¿mismos pasos?

**Opciones:** checklist de release (sección 26 cap. 02 punto 4) en `docs/`.

**Riesgos:** releases inconsistentes.

**Solución:** proceso idéntico (punto 4).

**Cómo se evita:** la checklist es parte del workflow (reutilizable).

---

## 6. Práctica guiada

### Objetivo

Entregar una herramienta Python con pruebas bloqueantes y release 0.1.0 publicado por pipeline.

### Paso 1: estructura

1. Árbol del punto 2 + `.gitignore` de Python + README con instalación en 3 comandos.

### Paso 2: código y pruebas

1. Lógica principal + suite con aserciones (punto 3). Prueba negativa: rompe algo y verifica rojo.

### Paso 3: pipeline

1. CI: install → lint (si aplica) → tests. Check requerido en PR (sección 03 de esta sección).

### Paso 4: documenta el uso

1. README con ejemplos ejecutables (copiar-pegar y funciona).

### Paso 5: release 0.1.0

```text
changelog → tag v0.1.0 → release en plataforma
   │        → artefacto del CI
   └── verifica: ¿quién hizo el zip?
```

### Paso 6: entrega

```text
Checklist:
   [ ] estructura + gitignore limpio
   [ ] pruebas bloqueantes (probadas en negativo)
   [ ] instalación en limpio verificada
   [ ] README con uso real
   [ ] release 0.1.0 con notas y artefacto del CI
```

### Resultado esperado

Herramienta instalable por terceros, suite fiable y primer release reproducible desde el pipeline.

### Conclusión esperada

Con el primer release automatizado entiendes algo que cambia tu carrera: un proyecto no es «código que corre», es «código con versión, pruebas y consumidores que pueden confiar en qué tienen».

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto a la vida real

```text
   │
   ├── semver + changelog + notas: exactamente lo que
   │   se exige en un equipo real (sección 17/26 cap.
   │   02)
   │
   ├── dependencias fijadas + Dependabot (Proyecto 4)
   │   + SAST básico = el arranque de la sección 20
   │
   ├── el «release por tag» es la semilla de la entrega
   │   continua de la sección 22 cap. 04
   │
   └── con datos del Proyecto 6 añadirás artefactos no
       codeables (datasets, reportes) al mismo esquema
       (sección 21 cap. 05)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* estructura Python con entorno fijado y gitignore desde el inicio elimina «funciona en mi máquina»;
* pruebas son contrato: aserciones sobre lógica, probadas rompiendo algo, bloqueantes en el PR;
* semver + changelog + tag + artefacto del CI = primer release profesional;
* el proceso de release se repite idéntico — checklist, no ritual;
* los errores típicos (repo con entornos, dependencias sueltas, tests decorativos, foco en framework, release a mano, proceso de una vez) se previenen con estructura y proceso;
* la progresión: este producto con versión alimenta el Proyecto 6 de datos.

La idea principal es:

> **Un proyecto Python maduro se reconoce en tres respuestas inmediatas: cómo se instala, qué pruebas lo protegen y qué versión está publicada — y las tres tienen respuesta escrita, no recordada.**

---

## Próximo paso

Ya liberas versiones con pruebas.

Ahora el Proyecto 6: cuando el repositorio contiene datos — y Git debe tratarlos con criterio.

Continúa con:

[`06-proyecto-6-proyecto-de-datos.md`](06-proyecto-6-proyecto-de-datos.md)
