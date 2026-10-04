# Releases, artefactos y versiones

## Introducción

La sección 14 enseñó a documentar entregas (changelog y notas); este capítulo las publica como piezas de ingeniería en GitHub: **Releases** con tags anclados, artefactos que la gente descarga, prereleases para candidatos y un flujo que reduce el error humano en el momento más delicado — el de publicar.

Publicar mal es caro: número equivocado, artefacto que no corresponde, notas incompletas. Publicar bien es aburrido y repetible.

---

## Mapa conceptual de este capítulo

```text
Releases, artefactos y versiones
       │
       ├── 1. Release: tag + notas + artefactos
       ├── 2. Artefactos: qué y cómo se publican
       ├── 3. Prereleases y candidatos
       ├── 4. Flujo de publicación manual → asistida
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Release: tag + notas + artefactos

```text
PIEZAS
──────────────────────────────────────────────────────
TAG (en Git)
  · ancla auditable: commit + versión + autor + fecha
  · anotado (recomendado): git tag -a v1.4.0

RELEASE (en la plataforma)
  · nombre (v1.4.0) apuntando al tag
  · notas (sección 14 cap. 04)
  · artefactos adjuntos (binarios, paquetes, SBOM)
  · marcadores: pre-release / latest
  · discusión de la release (si se habilita)
```

```text
   │
   ├── el tag es VERDAD en Git; la Release es la
   │   CARÁTULA pública con lo demás
   │
   ├── si borras la Release, el tag sigue; si borras
   │   el tag mal hecho, avisa a quien lo clonó
   │
   └── orden seguro (punto 4): cambiar es publicar,
       no reescribir
```

---

## 2. Artefactos: qué y cómo se publican

```text
QUÉ SE ADJUNTA (según proyecto):
   │
   ├── binarios/ejecutables compilados
   ├── paquetes (npm, wheels, contenedores referenciados)
   ├── checksums (SHA256SUMS) para verificar descarga
   ├── SBOM / informe de vulnerabilidades (sección 24)
   └── firmas (mención: GPG/sigstore — sección 20)
```

```text
CÓMO SE PRODUCEN (dos caminos):
   │
   ├── A) manual: compilar → adjuntar en la UI (frágil,
   │   solo muy puntual)
   │
   └── B) automatizado (recomendado): tag push →
       workflow de Actions construye, prueba, sube
       artefactos a la Release (sección 19/22)
```

```text
BUENAS PRÁCTICAS:
   │
   ├── artefacto generado DESDE ese tag (reproducible
   │   en lo posible)
   ├── checksums publicados SIEMPRE
   ├── nombres de archivo con versión + plataforma
   │   (app-1.4.0-linux-x64.tar.gz)
   └── el artefacto no se «sube a mano» si hay CI: la
       mano es el eslabón débil
```

```bash
# verificación esperable por el usuario:
sha256sum -c SHA256SUMS
```

---

## 3. Prereleases y candidatos

```text
USOS:
   │
   ├── v2.0.0-rc.1  → candidato: pruebas finales
   ├── v1.5.0-beta  → audiencia temprana
   └── v0.9.0-preview → demostración
```

```text
EN LA PLATAFORMA:
   │
   ├── marcar la Release como «pre-release» → no
   │   cuenta como la última para quien instala
   │   «lo más reciente»
   │
   └── mismo flujo: tag anotado + notas (¡diciendo
       qué falta!) + artefactos
```

```text
CICLO RC → FINAL:
   │
   ├── rc.1 → probar (equipo/usuarios) → rc.2 si hay
   │   cambios → v2.0.0
   │
   ├── si el RC no mejora: NO publicar el final por
   │   fecha (reprogramar con comunicación —
   │   sección 14)
   │
   └── el candidato que nadie prueba no es un
       candidato: es un tag con esperanza
```

```text
   │
   └── comunicar: notas de RC en el mismo canal que
       las finales (Discussions/README — sección 16)
```

---

## 4. Flujo de publicación manual → asistida

```text
CHECKLIST DE RELEASE (la que se repite SIEMPRE)
──────────────────────────────────────────────────────
[ ] versión decidida (semver — sección 17 cap. 05)
[ ] changelog actualizado
[ ] CI verde en main
[ ] commit de release (bump) + tag anotado
[ ] tag push → workflow construye artefactos
[ ] notas publicadas (destacado, breaking, migración)
[ ] anuncio (dónde lo ve el usuario)
[ ] post: abrir milestone siguiente, archivar RCs
```

```text
EVOLUCIÓN:
   │
   ├── nivel 1: todo manual con checklist escrita
   ├── nivel 2: script local (bump + tag + push)
   └── nivel 3: workflow que se dispara con un tag o
       con «Run workflow» y hace build+publicación
       (sección 19/22)
```

```text
   │
   └── en cualquier nivel: HUMANO revisa notas y
       versión; la máquina construye y adjunta
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: tag en el commit equivocado

**Qué ocurrió:** el tag v1.4.0 apunta a un commit previo al fix que se quería incluir.

**Por qué:** se tagueó desde una rama desactualizada.

**Cómo comprobarlo:** `git log v1.4.0 -1`, comparar con lo esperado.

**Opciones:** si NO se publicó: borrar tag local/remoto y rehacer (rápido, con aviso si alguien lo clonó); si se publicó: release corregida como v1.4.1 con nota.

**Riesgos:** el código etiquetado no es el probado.

**Solución:** tag desde main actualizado con CI verde, en checklist.

**Cómo se evita:** tag solo desde el workflow (nivel 3).

---

### Error 2: artefacto que no corresponde al tag

**Qué ocurrió:** el binario de la 1.4.0 se compiló de una rama con cambios extra.

**Por qué:** build manual desde la máquina de alguien.

**Cómo comprobarlo:** regenerar desde el tag y comparar checksums.

**Opciones:** subir artefacto correcto (o nueva release); migrar a build desde tag en CI.

**Riesgos:** usuarios ejecutando código no auditado.

**Solución:** artefactos solo desde CI del tag (punto 2).

**Cómo se evita:** prohibir adjuntos manuales (cultura del equipo).

---

### Error 3: notas copiadas de otra versión / sin breaking

**Qué ocurrió:** notas de 1.4.0 con texto de 1.3.0; usuarios sin aviso del cambio incompatible.

**Por qué:** copy-paste sin revisión.

**Cómo comprobarlo:** leer notas vs. diff real vs. changelog.

**Opciones:** editar notas (permitido) con adición clara «actualizado»; si el breaking ya causó daño, comunicar por el canal principal.

**Riesgos:** pérdida de confianza; daños de actualización.

**Solución:** nota = redacción humana desde el changelog (sección 14).

**Cómo se evita:** checklist: «¿breaking arriba con migración?».

---

### Error 4: prerelease marcado… y no se prueba

**Qué ocurrió:** v2.0.0-rc.1 publicado y olvidado; al día siguiente v2.0.0 sin ningún feedback.

**Por qué:** RC sin ventana ni dueño.

**Cómo comprobarlo:** tiempo entre rc.1 y final.

**Opciones:** ventana explícita de prueba; si no hubo tiempo real, alargar (comunicado).

**Riesgos:** el RC es teatro.

**Solución:** «RC = ventana con responsables» (punto 3).

**Cómo se evita:** plan de release con fechas de RC y final.

---

### Error 5: borrar/rehacer una release pública en silencio

**Qué ocurrió:** se editó el tag (borrado y recreado) porque «nadie lo había visto» — y un espejo/CI lo había clonado.

**Por qué:** subestimar que el tag ya viajó.

**Cómo comprobarlo:** logs de clon/caches; actividad de descargas.

**Opciones:** versiones nuevas para corregir; si es imprescindible reescribir (seguridad grave), comunicación explícita + nuevo tag visible.

**Riesgos:** artefactos divergentes para la misma «versión».

**Solución:** inmutabilidad de lo publicado (punto 1).

**Cómo se evita:** checklist: «¿ya se push? entonces, no se toca».

---

### Error 6: releases sin CI (y versión que nadie verificó)

**Qué ocurrió:** publicación sin tests en el tag; regresión llega a usuarios.

**Por qué:** el flujo de release no exige verde.

**Cómo comprobarlo:** ¿el workflow corre en tag push?

**Opciones:** añadir trigger `on: push: tags:`; hacerlo obligatorio (protección de tag / política).

**Riesgos:** entrega sin red.

**Solución:** release condicionada a CI verde (punto 4).

**Cómo se evita:** plantilla de workflow de release (sección 19/22).

---

## 6. Práctica guiada

### Objetivo

Publicar una release completa con artefacto generado y prerelease.

### Paso 1: prepara

```text
CI verde en main + changelog al día (sección 14).
Decide la versión (sección 17 cap. 05).
```

### Paso 2: RC

```bash
git switch main && git pull
echo "2.0.0-rc.1" > VERSION && git add VERSION
git commit -m "release: 2.0.0-rc.1"
git tag -a v2.0.0-rc.1 -m "v2.0.0-rc.1"
git push origin main --follow-tags
```

1. Crea la Release marcando **Pre-release** con notas «qué se prueba y qué falta».

### Paso 3: «prueba» y decisión

```text
Recoge feedback simulado (o real):
   │
   ├── ¿bugs? → rc.2
   └── ¿ok? → final
```

### Paso 4: final

```bash
echo "2.0.0" > VERSION && git add VERSION CHANGELOG.md
git commit -m "release: v2.0.0"
git tag -a v2.0.0 -m "v2.0.0"
git push origin main --follow-tags
```

1. Release final (no Pre-release) con notas desde el changelog: destacado + breaking + migración.

### Paso 5: artefacto (nivel 2 o 3)

```text
Opción manual (nivel 1): adjunta un tar/zip del tag
+ archivo SHA256SUMS generado.
Opción CI (recomendada): workflow con
on: push: tags: [v*] que construye y sube a la
release (sección 19 — puedes esbozarlo y completarlo
en esa sección).
```

### Paso 6: post-release

```text
[ ] milestone siguiente abierta
[ ] RC archivado/eliminado
[ ] anuncio escrito (Discussions/README)
[ ] checklist usada → mejórala si algo faltó
```

### Resultado esperado

RC y final publicadas con tags anotados, notas y artefacto con checksum.

### Conclusión esperada

La publicación se vuelve aburrida cuando es siempre el mismo checklist — y cuando la máquina construye lo que la persona firmó.

---

## 7. Nivel profesional + resumen

### 7.1. Publicación a escala

```text
   │
   ├── nivel 3: tag → CI → artefactos + notas
   │   generadas (redacción humana encima) →
   │   publicación
   │
   ├── inmutabilidad: lo publicado no se reescribe;
   │   correcciones = versión nueva
   │
   ├── firmas y checksums en lo descargable
   │   (sección 20)
   │
   ├── prereleases con ventana y dueños
   │
   └── métrica: incidencias post-release (¿cuántas
       veces «corregimos la release»?) — sección 29
```

### 7.2. Resumen

En este capítulo aprendiste que:

* una release es tag anotado + notas + artefactos, con pre-release para candidatos;
* los artefactos se generan desde el tag (preferiblemente por CI) con checksums y nombres versionados;
* el prerelease solo sirve con ventana de prueba y responsables;
* el flujo evoluciona: checklist manual → script → workflow de tag, con el humano firmando versión y notas;
* los errores típicos (tag mal apuntado, artefacto desincronizado, notas viejas, RC sin prueba, reescritura silenciosa, release sin CI) se previenen con inmutabilidad y automatización;
* a nivel profesional: publicación nivel 3 con métrica de incidencias post-release.

La idea principal es:

> **Publicar es un acto de precisión: el tag firma el código, la CI construye el artefacto y las notas cuentan la verdad — lo publicado, publicado queda.**

---

## Próximo paso

Ya entregas versiones como un equipo profesional.

Falta la capa que lo mantiene unido: convenciones y gobernanza del repositorio.

Continúa con:

[`05-convenciones-y-naming.md`](05-convenciones-y-naming.md)
