# Changelog y release notes
[`05-license-y-contributing.md`](05-license-y-contributing.md)

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Por qué es importante distinguir entre un changelog (registro acumulado en el repo) y las release notes (narración de una entrega) y cómo afecta esto a la forma en que los usuarios evalúan una actualización?
2. ¿Cómo influye la relación entre Conventional Commits y el versionado semver (feat ? MINOR, fix ? PATCH, breaking ? MAJOR) en la automatización de la generación de changelogs y la toma de decisiones sobre el número de versión?
3. En el flujo semiautomático de generación de changelog, ¿qué papel juega la edición humana después de que la herramienta propone un borrador, y por qué es esencial reescribir en lenguaje de usuario en lugar de dejar el output crudo?
4. ¿Qué elementos deben incluirse siempre en las release notes para comunicar efectivamente a los usuarios qué deben saber antes de actualizar, y por qué es recomendable colocar los breaking changes y deprecaciones al principio con instrucciones de migración?
5. ¿Qué riesgos conlleva publicar un tag sin asociarle release notes ni actualizar el changelog, y cómo puede un checklist de release prevenir estos errores típicos?
6. ¿Cómo diseñarías un proceso de release que garantice que cada versión sea trazable a commits específicos, issues y decisiones de compatibilidad, y qué papel juega la auditoría en ese proceso?

[`05-license-y-contributing.md`](05-license-y-contributing.md)
# Changelog y release notes

## Introducción

Los mensajes de commit documentan cambio a cambio; el changelog y las notas de versión documentan la historia por entregas: qué recibió el usuario en la 1.4.0 y qué debe saber antes de subir.

Son dos piezas distintas: el changelog es un registro acumulado (archivo vivo en el repo); las release notes son la narración de una entrega concreta (publicada con el tag o en la plataforma). Este capítulo enseña a producirlos, automatizarlos con cuidado y comunicar lo que importa.

---
## Mapa conceptual de este capítulo

```mermaid
mindmap
  root((Changelog y release notes))
    Qué es cada uno y por qué importan
    Formato y semántica de versión
    De commits a changelog semiauto
    Release notes que comunican
      Errores comunes con diagnóstico completo
      Práctica guiada
      Nivel profesional + resumen
```

---
## 1. Qué es cada uno

```text
CHANGELOG (archivo en el repo, ej. CHANGELOG.md)
    â
    âââ registro cronológico de versiones
    âââ lo leen: usuarios que evalúan actualizar,
    â   mantenedores, auditoría
    âââ sobrevive a la plataforma: está en el repo
```

```text
RELEASE NOTES (por entrega)
    â
    âââ narración de UNA versión: qué cambió, cómo
    â   actualizar, qué rompe
    âââ se publican: GitHub Releases, blog, mails
    âââ incluyen: destacados, breaking changes,
        deprecaciones, agradecimientos, enlaces
```

```text
    â
    âââ el changelog ACUMULA; las notas CONTAN
    â
    âââ las herramientas generan borradores del
        changelog; el humano redacta las notas (lo que
        le importa al lector, en su idioma)
```

---
## 2. Formato y semántica de versión

```text
KEEP A CHANGELOG (estilo, popular):
    â
    âââ cabecera por versión: [1.4.0] - 2026-10-01
    âââ secciones: Añadido / Corregido /
    â   Cambiado (breaking) / Obsoleto / Eliminado
    âââ enlaces a comparaciones al pie
    âââ sin entradas para cada commit: por entregas
```

```text
SEMVER (versión: MAJOR.MINOR.PATCH)
    â
    âââ MAJOR: cambios incompatibles (breaking)
    âââ MINOR: funcionalidad nueva, compatible
    âââ PATCH: correcciones, compatible
```

```text
Relación con Conventional Commits (cap. 03):
    â
    âââ feat  â MINOR (o MAJOR con !)
    âââ fix   â PATCH
    âââ BREAKING CHANGE â MAJOR
    (así el changelog y el número de versión se
    derivan del historial)
```

```text
Estado del proyecto sin versión estable:
    â
    âââ 0.x: el cambio compatible también puede romper;
        anúncialo igualmente
```

---
## 3. De commits a changelog (semiauto)

```text
FLUJO TÜPICO
ââââââââââââââââââââââââââââââââââââââââââââââââââââââ
1. convención en commits (cap. 03)
2. herramienta genera borrador desde los commits
    desde el último tag (categoría: git-cliff,
    standard-version â como ejemplos)
3. humano edita: agrupa, reescribe en lenguaje de
    usuario (no jerga interna), corrige ruido
4. commit del changelog + tag + release
```

```bash
# inspección manual que la herramienta automatiza:
git log --oneline v1.3.0..HEAD
git log --oneline v1.3.0..HEAD --no-merges
```

```text
    â
    âââ los commits de rama (Â«fusionaÂ») no aportan:
        se omiten
    â
    âââ si los mensajes son malos (cap. 03), la
        herramienta produce basura â la calidad del
        changelog es la calidad del historial
```

---
## 4. Release notes que comunican

```markdown
# v1.4.0 â 2026-10-01

## Destacado
- Exportación a CSV (nuevo comando `export`).

## Cambios
- Añadido: `export --format csv`.
- Corregido: doble refresco de sesión (#482).

## Requiere acción (si aplica)
- El flag `--old-format` queda obsoleto; se eliminará
  en 2.0.

## Agradecimientos
- @colaboradora por el informe del parser.

Comparación completa: v1.3.0...v1.4.0
```

```text
Reglas:
    â
    âââ escribe para el USUARIO de esa versión, no
    â   para el equipo interno
    â
    âââ breaking changes y deprecaciones ARRIBA y
    â   con instrucción de migración
    â
    âââ enlaces: issue, PR, comparación
    â
    âââ honestidad: si hay riesgos conocidos, dilo
```

```text
DÜNDE SE PUBLICAN:
    â
    âââ GitHub Releases (vinculado al tag: el tag es
    â   ancla en el historial; la release es la
    â   entrega con artefactos y notas)
    â
    âââ el changelog vive en el repo; las notas, en
        la release (y opcionalmente enlazadas desde
        el changelog)
```

---
## 5. Errores comunes con diagnóstico completo

### Error 1: changelog desactualizado o ausente

**Qué ocurrió:** versión publicada hace meses sin entrada en CHANGELOG.

**Por qué posibles:**
* no hay dueño del proceso;
* se decide Â«al finalÂ» y se olvida.

**Cómo comprobarlo:** comparar tags con entradas: `git tag --sort=-v:refname` vs. cabeceras del changelog.

**Opciones:** generar desde el historial ahora; hacerlo parte de la rutina de release (checklist).

**Riesgos:** usuarios sin guía de actualización.

**Solución:** el release no se cierra sin changelog/notes.

**Cómo se evita:** plantilla de release con casillas.

---

### Error 2: volcado de commits sin editar

**Qué ocurrió:** el changelog es una lista de Â«fix fix refactorÂ» incomprensible para usuarios.

**Por qué:** se usó la herramienta en crudo.

**Cómo comprobarlo:** leerlo como usuario externo.

**Opciones:** editar/reagrupar; reescribir en lenguaje de producto.

**Riesgos:** nadie lo lee â inútil.

**Solución:** borrador automático + redacción humana (punto 3).

**Cómo se evita:** quien publica la release redacta (rol asignado).

---

### Error 3: número de versión que no refleja lo que cambió

**Qué ocurrió:** se publica PATCH con funcionalidad nueva o cambios que rompen compatibilidad sin subir MAJOR.

**Por qué:** prisa o desconocimiento de semver.

**Cómo comprobarlo:** leer diff de release vs. etiqueta; comprobar casillas Â«breakingÂ».

**Opciones:** corregir versión (si aún no se comunicó), o comunicar claramente y corregir política.

**Riesgos:** automatizaciones de actualización se rompen en silencio.

**Solución:** regla featâMINOR, fixâPATCH, breakingâMAJOR (o proyecto con política propia DOCUMENTADA).

**Cómo se evita:** decisión semántica en la revisión de release, no a última hora.

---

### Error 4: notas que esconden lo que rompe

**Qué ocurrió:** changelog amable, usuarios rotos al actualizar.

**Por qué:** evitar mala noticia.

**Cómo comprobarlo:** sección de breaking/deprecaciones presente y arriba.

**Opciones:** rehacer las notas; comunicar por los canales; añadir guía de migración.

**Riesgos:** confianza rota (peor que el cambio).

**Solución:** breaking changes primero y con instrucción.

**Cómo se evita:** checklist Â«¿algo deja de funcionar?Â».

---

### Error 5: tags creados sin notas ni vínculo

**Qué ocurrió:** el repo tiene tags `v1.4.0` pero ni notas ni release publicada.

**Por qué:** se tagueó desde la línea de comandos y ahí acabó.

**Cómo comprobarlo:** `git tag` + lista de releases en la plataforma.

**Opciones:** crear la release ahora con notas (el tag ya existe).

**Riesgos:** historial sin narración por entrega.

**Solución:** flujo único de release: changelog â commit â tag â publicación.

**Cómo se evita:** script/checklist de release del equipo.

---

### Error 6: agradecimientos y métricas falsos

**Qué ocurrió:** Â«+1000 commits, 50 colaboradoresÂ» inflados; agradecimientos a quien no aportó.

**Por qué:** automatización sin revisión.

**Cómo comprobarlo:** contraste con `git shortlog -sn`.

**Opciones:** corregir; usar métricas verificables.

**Riesgos:** ridículo y desconfianza.

**Solución:** datos del historial y revisión humana.

**Cómo se evita:** validar la plantilla de stats.

---
## 6. Práctica guiada

### Objetivo

Producir un changelog de verdad y unas release notes desde un historial de práctica.

### Paso 1: etiqueta de partida

```bash
git tag v0.1.0              # versión inicial
# ... trabaja: haz 2-3 commits con convención
# (feat:, fix:) ...
git log --oneline v0.1.0..HEAD
```

### Paso 2: borrador de entradas

```text
Clasa los commits del rango:
    â
    âââ feat  â Añadido
    âââ fix   â Corregido
    âââ docs/chore â normalmente NO entran
    âââ breaking â Cambiado (arriba del todo)
```

### Paso 3: escribe CHANGELOG.md

```markdown
# Changelog

## [0.2.0] - 2026-10-02

### Añadido
- Exportación CSV (`export --format csv`)

### Corregido
- Doble refresco de sesión (#482)

[0.1.0]: https://.../releases/tag/v0.1.0
[0.2.0]: https://.../releases/tag/v0.2.0
```

### Paso 4: tag + release

```bash
git tag -a v0.2.0 -m "v0.2.0"
# (push de tag: git push origin v0.2.0)
# y en la plataforma: nueva Release con las notas
# del paso 3 (destacado, cambios, breaking)
```

### Paso 5: automatiza el borrador

```text
Configura en tu proyecto una herramienta de
generación desde Conventional Commits (elige según
tu lenguaje) y acordad: herramienta propone â
humano redacta.
```

### Resultado esperado

CHANGELOG con dos versiones, tag anotado y notas publicadas con breaking visible.

### Conclusión esperada

El flujo release = historial limpio â borrador â redacción â tag â publicación; la herramienta acelera, el humano comunica.

### Ejercicio de transferencia

Imagina que estás preparando la versión 2.0.0 de una biblioteca de procesamiento de imágenes que rompe compatibilidad al cambiar el formato de salida de los filtros. Usando el historial de commits desde la versión 1.5.0, genera un borrador de changelog con una herramienta como git-cliff, edítalo para destacar los breaking changes y añadir instrucciones de migración, y crea una release note que explique a los usuarios qué deben hacer para actualizar. Entrega el changelog editado, la release note y una captura del tag y la release en GitHub.

---
## 7. Nivel profesional + resumen

### 7.1. Release engineering mínimo

```text
PIPELINE DE RELEASE
ââââââââââââââââââââââââââââââââââââââââââââââââââââââ
1. congelar (rama/ventana) y revisar commits
2. decidir semver (¿breaking? ¿feat?)
3. changelog: borrador auto + redacción
4. tag anotado + commit del changelog
5. publicar: GitHub Release + notas + artefactos
6. post: anunciar deprecaciones, verificar installs
```

```text
    â
    âââ la plataforma es display; el repo es fuente
    â   (changelog y tags viajan con el código)
    â
    âââ notas en el idioma del usuario (aquí, español
    â   cuando el público lo es)
    â
    âââ auditoría: cada versión rastreable a commits,
        issues y decisión de compatibilidad
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el changelog es registro acumulado en el repo; las release notes narran una entrega y se publican con el tag;
* semver (MAJOR/MINOR/PATCH) y Conventional Commits se refuerzan: featâMINOR, fixâPATCH, breakingâMAJOR;
* el flujo es semiautomático: herramienta propone desde `git log v-tag..HEAD`, la persona redacta en lenguaje de usuario;
* las notas comunican: destacados, cambios, breaking/deprecaciones con migración, agradecimientos, enlaces;
* los errores típicos (changelog ausente, volcado crudo, semver desalineada, breaking escondido, tags sin notas, métricas infladas) se previenen con checklist de release;
* a nivel profesional: pipeline de release documentado y verificable.

La idea principal es:

> **Cuenta la historia por entregas: el repositorio guarda los cambios, el changelog los acumula y las release notes explican al usuario qué debe saber antes de actualizar.**

---
## Próximo paso

Ya documentas versiones y entregas.

La siguiente capa legal y social del repositorio: licencia, contribución y convivencia.

Continúa con:

[`05-license-y-contributing.md`](05-license-y-contributing.md)
