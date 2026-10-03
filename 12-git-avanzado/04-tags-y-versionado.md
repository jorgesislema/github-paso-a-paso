# Tags y versionado

## Introducción

Los commits identifican instantes; los tags fijan nombres. Cuando dices «en la versión 2.1.0 estaba así», estás hablando de un tag: una etiqueta estable sobre un commit concreto que no se mueve aunque avance la rama.

El versionado no es decoración: es el contrato con quienes usan tu software. Este capítulo cubre cómo crear tags en Git, qué son los anotados, cómo nombrar versiones (SemVer) y cómo los tags se convierten en releases de GitHub.

En este capítulo aprenderás:

* `git tag` ligeros vs. anotados (y cuándo usar cada uno);
* crear, listar, verificar y borrar tags (y el cuidado al borrar);
* convenciones de nombres (SemVer, prefijos v);
* tags como puntos de recuperación y anclas de CI/CD;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (releases de GitHub).

---

## Mapa conceptual de este capítulo

```text
Tags y versionado
       │
       ├── 1. Qué es un tag (y ligero vs. anotado)
       ├── 2. Operaciones: crear, listar, borrar
       ├── 3. Convenciones de nombres (SemVer)
       ├── 4. Tags en el flujo: puntos, CI, releases
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué es un tag

```text
main ── A ── B ── C ── D
                 │
              v2.1.0   ← etiqueta apuntando a C
                         (incluso si main avanza,
                          el tag sigue en C)
```

```bash
# ligero: solo el nombre apunta al commit
git tag v2.1.0-ligero

# anotado (recomendado para versiones): objeto con
# autor, fecha, mensaje y etiqueta
git tag -a v2.1.0 -m "Versión 2.1.0: añade export PDF"
```

```text
Ligero vs. anotado:
   │
   ├── ligero   → marca rápida (personal, temporal)
   │
   └── anotado  → hito oficial: lleva mensaje y
                  metadatos firmables; es lo que se
                  publica como release
```

```text
Los tags NO se copian con push/pull por defecto:
   │
   └── git push              → NO sube tags
       git push --tags       → sube todos
       git push origin v2.1.0 → sube uno (recomendado)
```

---

## 2. Operaciones

```bash
git tag                        # listar locales
git tag -l "v2.*"              # filtrar
git show v2.1.0                # ver el hito
git tag -a v2.1.0 -m "..."     # crear anotado
git tag <hash> v2.0.9          # etiquetar un commit
                                # viejo
git push origin v2.1.0         # subir UNO
git push --tags                # subir TODOS
```

```bash
# borrar (¡cuidado!):
git tag -d v2.1.0              # local
git push origin --delete v2.1.0   # remoto (afecta a
                                  # todos)
```

```text
El cuidado de borrar:
   │
   ├── el tag publicado es un ACUERDO: referencias,
   │   releases y CI pueden depender de él
   │
   ├── borrarlo rompe enlaces (release de GitHub,
   │   artefactos descargados por URL de tag)
   │
   └── regla: si ya salió, no se borra; si hubo error,
       se publica una versión corregida (v2.1.1)
```

---

## 3. Convenciones: SemVer

```text
Formato habitual:  vMAJOR.MINOR.PATCH   (p. ej. v2.1.0)

MAJOR  → cambio incompatible (rompe API/contrato)
MINOR  → funcionalidad nueva, compatible
PATCH  → corrección compatible (fix)

v0.x → mientras es 0, «incompatible» puede pasar sin
       subir MAJOR (convención común)
```

```text
Reglas prácticas:
   │
   ├── prefijo «v» (v2.1.0) o no (2.1.0): elige UNO
   │   y no cambies (rompe enlaces)
   │
   ├── el tag se coloca en el commit EXACTO de la
   │   entrega (tras CI verde)
   │
   └── prerelease: v2.2.0-rc.1, v2.2.0-beta.3 (SemVer
       lo permite)
```

```text
¿Dónde vive la versión además del tag?
   │
   ├── en el proyecto: archivo VERSION o metadata del
   │   manifiesto (según ecosistema)
   │
   └── coherencia: tag y archivo deben coincidir en
       el commit de la entrega
```

---

## 4. Tags en el flujo

```text
Puntos de recuperación:
   │
   ├── git checkout v2.1.0    → reproducir la entrega
   │                            sin buscar hashes
   └── git diff v2.1.0..main  → «qué cambió desde la
                                 última versión»
```

```text
CI/CD por tag:
   │
   ├── on: push: tags: ["v*"]
   │      → publicar artefacto SOLO cuando hay versión
   │
   └── evita publicar en cada commit de main
```

```text
Release de GitHub:
   │
   ├── tag anotado + Release en la interfaz
   │   (notas, artefactos binarios, SHA)
   │
   └── el Release es la cara pública; el tag es el
       ancla técnica (sección 18)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: etiquetar el commit equivocado

**Qué ocurrió:** el tag v2.1.0 quedó apuntando a un commit previo al fix final (o a uno posterior con cambios de más).

**Por qué posibles:**
* etiquetado desde la rama sin comprobar HEAD;
* rama actual desactualizada respecto a main.

**Cómo comprobarlo:** `git show v2.1.0` (fecha/contenido), `git log --oneline v2.1.0..main`.

**Opciones:**
* sin publicar: borrar y re-etiquetar (`tag -d` + crear);
* publicado: NO mover el tag; sacar v2.1.1 con lo correcto (o, si es absolutamente necesario y coordinado, borrar y recrear con force-with-lease del tag).

**Riesgos:** reproducibilidad rota; CI publicando desde otro punto.

**Solución:** checklist pre-tag (CI verde, HEAD correcto, sin cambios sucios).

**Cómo se evita:** etiquetar solo desde el flujo de release automatizado cuando sea posible.

---

### Error 2: `git push` sin tags (y el release no aparece)

**Qué ocurrió:** se creó el tag local, el push subió el código pero no la etiqueta.

**Por qué:** por defecto push NO sube tags.

**Cómo comprobarlo:** `git ls-remote --tags origin` (no aparece).

**Opciones:** `git push origin v2.1.0` (o `--tags` con criterio).

**Riesgos:** release incompleto, CI del tag nunca dispara.

**Solución:** paso explícito de tag en el flujo.

**Cómo se evita:** checklist de publicación (punto 4).

---

### Error 3: subir TODOS los tags con `--tags` sin querer

**Qué ocurrió:** tags locales de prueba/personales aparecieron en el remoto.

**Por qué:** `--tags` es indiscriminado.

**Cómo comprobarlo:** `git ls-remote --tags origin`.

**Opciones:** borrar los no deseados (con conciencia de que pueden estar referenciados); revisar historial de releases.

**Riesgos:** ruido público; nombres de prueba visibles.

**Solución:** subir tags de uno en uno (`git push origin vX.Y.Z`).

**Cómo se evita:** no usar `--tags` en repos con historial de tags locales.

---

### Error 4: borrar un tag publicado

**Qué ocurrió:** `push --delete` de un tag ya en uso (release, artefactos).

**Por qué:** se quiso «limpiar» una etiqueta errónea.

**Cómo comprobarlo:** releases/enlaces que apuntaban al tag → 404.

**Opciones:**
* si el release era privado/reciente y coordinado: recrear idéntico;
* si ya se usó: nueva versión (v2.1.1) y notas explicativas.

**Riesgos:** usuarios con versiones no reproducibles.

**Solución:** la regla del punto 2 (publicado = inmutable).

**Cómo se evita:** pre-release (rc) antes de tocar main.

---

### Error 5: versiones que no cuentan historia

**Qué ocurrió:** v1.0.0, v1.0.1, v4.0.0 sin criterio; nadie sabe qué cambió.

**Por qué:** no hay convención ni notas.

**Cómo comprobarlo:** `git log --oneline v1.0.0..v4.0.0` sin estructura; releases vacíos.

**Opciones:** adoptar SemVer + notas de release desde la próxima versión; documentar el criterio (sección 14).

**Riesgos:** usuarios incapaces de evaluar riesgo de actualización.

**Solución:** convención escrita + CHANGELOG.

**Cómo se evita:** decidir el esquema ANTES de la primera versión pública.

---

### Error 6: mover tags con force (la tentación)

**Qué ocurrió:** se «arregló» un tag malo con `git tag -f` y push force, rompiendo a quien ya lo descargó.

**Por qué:** impaciencia por un error de etiquetado.

**Cómo comprobarlo:** artefactos/descargas con hash distinto al esperado por consumidores.

**Opciones:** comunicar; publicar versión correcta nueva; force solo en tags internos provisionales.

**Riesgos:** pérdida de confianza y reproducibilidad.

**Solución:** inmutabilidad (punto 2).

**Cómo se evita:** anotados + CI para etiquetar con calma.

---

## 6. Práctica guiada

### Objetivo

Crear, verificar, subir y usar tags — y corregir un etiquetado malo sin romper nada publicado.

### Paso 1: proyecto con versiones

```bash
git init tags-demo && cd tags-demo
echo "v0" > lib.py && git add . && git commit -m "v0"
echo "v1" >> lib.py && git add . && git commit -m "feat: algo"
git tag -a v0.1.0 -m "Primera versión funcional"
git tag -l
git show v0.1.0 --stat
```

### Paso 2: avanza y compara

```bash
echo "v2" >> lib.py && git add . && git commit -m "feat: más"
git diff v0.1.0..HEAD -- lib.py   # «desde la
                                   # versión»
```

### Paso 3: subir el tag

```bash
git remote add origin <ruta-o-url>
git push -u origin master           # (o main)
git push origin v0.1.0              # UN tag explícito
git ls-remote --tags origin         # verificación
```

### Paso 4: etiquetar un commit viejo

```bash
git tag -a v0.0.9 <hash del primer commit> -m "antecedente"
git log --oneline --decorate       # decoración visible
```

### Paso 5: corregir un etiquetado NO publicado

```bash
git tag -d v0.1.0                       # local
git tag -a v0.1.0 <hash correcto> -m "..."
# si NO se había subido: nada más que hacer
# si SÍ se subió: NUNCA force; prepara v0.1.1
```

### Paso 6: simulación de CI por tag

```text
Imagina un workflow con:

on:
  push:
    tags: ["v*"]

   │
   ├── al hacer push de v0.1.0 el workflow se
   │   dispara
   │
   └── al hacer push de un commit normal, NO
```

### Resultado esperado

Tags anotados creados, verificados, subidos de uno en uno y usados como referencia de comparación.

### Conclusión esperada

El tag es un contrato: se crea con cuidado, se sube explícitamente y, una vez publicado, no se mueve.

---

## 7. Nivel profesional + resumen

### 7.1. Flujo de release con tags

```text
RELEASE PROFESIONAL
──────────────────────────────────────────────────────
1. main estable, CI verde
2. actualizar versión (manifiesto/archivo)
3. commit "chore: v2.1.0"
4. git tag -a v2.1.0 -m "..."
5. git push origin main && git push origin v2.1.0
6. workflow de tag → build + pruebas + artefactos
7. Release en GitHub con notas (CHANGELOG) y assets
8. (opcional) firma: git tag -s (GPG/SSH) si el
   proyecto lo exige
```

### 7.2. Puntos de verificación

```text
   │
   ├── ¿el tag apunta a main del release?  (show)
   ├── ¿CI verde en ese commit?
   ├── ¿CHANGELOG con la versión?
   ├── ¿coincide el versión del manifiesto?
   └── ¿firmado si el proyecto firma?
```

### 7.3. Resumen

En este capítulo aprendiste que:

* un tag fija un nombre sobre un commit; los anotados llevan metadatos y son los oficiales;
* push no sube tags por defecto: se suben explícitamente (recomendado uno a uno);
* SemVer (MAJOR.MINOR.PATCH) da semántica al nombre y el prefijo `v` se elige una vez;
* los tags son anclas de recuperación, gatillos de CI/CD y base de releases;
* los errores típicos (tag mal apuntado, tags no subidos o de más, borrado publicado, versiones sin criterio, force) se previenen con checklist y la regla de inmutabilidad;
* a nivel profesional: release = CI verde + tag anotado + push explícito + notas de versión.

La idea principal es:

> **El tag es el contrato de versión: se pone con el CI verde, se sube a mano y, si ya se publicó, se corrige con una versión nueva — nunca moviéndolo.**

---

## Próximo paso

Ya fijas versiones en el historial.

La siguiente herramienta es de diagnóstico: encontrar el commit que rompió todo, por búsqueda binaria.

Continúa con:

[`05-git-bisect.md`](05-git-bisect.md)
