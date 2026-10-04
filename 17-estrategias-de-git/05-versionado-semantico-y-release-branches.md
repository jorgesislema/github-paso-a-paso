# Versionado semántico y ramas de release

## Introducción

Un número de versión parece simple — `1.4.2` — y esconde una comunicación precisa: ¿esto puede romper algo? ¿qué novedades trae? ¿debo actualizar? El **versionado semántico (semver)** convierte el número en contrato; las **ramas de release** son el mecanismo de Git para preparar, estabilizar y mantener esas versiones.

Este capítulo conecta la teoría (semver) con la práctica del repositorio (tags, ramas de release, soporte de versiones) y con el flujo del equipo.

---

## Mapa conceptual de este capítulo

```text
Versionado semántico y ramas de release
       │
       ├── 1. Semver: MAJOR.MINOR.PATCH
       ├── 2. De la decisión al tag
       ├── 3. Ramas de release en la práctica
       ├── 4. Soporte de versiones anteriores
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Semver: MAJOR.MINOR.PATCH

```text
MAJOR.MINOR.PATCH   (p. ej. 2.14.3)
   │
   ├── MAJOR  (2): cambios INCOMPATIBLES (breaking)
   ├── MINOR  (14): funcionalidad nueva, compatible
   └── PATCH  (3): correcciones, compatible
```

```text
REGLAS
──────────────────────────────────────────────────────
· al subir MAJOR: se puede NO actualizar sin romper
  (por eso avisa)
· al subir MINOR: puedes actualizar con seguridad
  esperando novedades
· al subir PATCH: solo arreglos
· la v0.x (0.z) permite romper en MINOR: es fase
  experimental — dilo en la doc
```

```text
RELACIÓN CON EL CONTENIDO (sección 14):
   │
   ├── feat  → MINOR     (o MAJOR si breaking)
   ├── fix   → PATCH
   └── BREAKING CHANGE → MAJOR
   (Conventional Commits → número derivado)
```

```text
PRE-RELEASE Y BUILD (mención de la sintaxis semver):
   │
   ├── 2.0.0-rc.1        → candidato a release
   ├── 1.4.0+build.87    → metadata (no afecta
   │   precedencia)
   └── 1.4.0-dev         → uso libre en equipos;
       el consumidor lo entiende si lo documentas
```

```text
   │
   └── el número se comunica al USUARIO; cambia su
       expectativa — no lo subas «porque hubo
       commits»
```

---

## 2. De la decisión al tag

```text
PIPELINE DE VERSIÓN
──────────────────────────────────────────────────────
1. decidir semver: ¿breaking? ¿feat? ¿fix? (y quién
   decide: responsable de release)
2. changelog (sección 14 cap. 04)
3. bump del número (archivo o package manifest)
4. commit de release + TAG ANOTADO
   git tag -a v1.4.0 -m "v1.4.0"
5. push del tag + publicación de release notes
6. (si aplica) rama de soporte release/1.4
```

```bash
# tag anotado (el recomendado: lleva mensaje y autor)
git tag -a v1.4.0 -m "v1.4.0: exportación CSV"
git push origin v1.4.0
# ver
git tag --sort=-v:refname
git show v1.4.0
```

```text
ANOTADO vs LIGERO:
   │
   ├── anotado → objeto con metadata (auditable,
   │   recomendado para releases)
   └── ligero (sin -a) → puntero solo; sirve para
       hitos internos
```

```text
   │
   └── el TAG es ancla en el historial; la «Release»
       de la plataforma es la entrega pública con
       notas y artefactos (sección 14)
```

---

## 3. Ramas de release en la práctica

```text
CUÁNDO HACE FALTA RAMA DE RELEASE
   │
   ├── Git Flow (cap. 02): release/* estabiliza
   │   mientras develop avanza
   ├── soporte: mantener 1.4 mientras sale 2.0
   └── ventanas de QA sin frenar main
```

```text
CICLO (variante Git Flow — cap. 02)
──────────────────────────────────────────────────────
develop ──► release/1.4.0 (solo fixes/docs)
                │
                ├──► main + tag v1.4.0
                └──► develop (doble merge)
```

```text
CON GITHUB FLOW / TRUNK (sin rama de release):
   │
   ├── la estabilización es temporal: main se pone
   │   «tranquilo» (feature freeze por horas/días) y
   │   se taggea desde main
   │
   └── si necesitas tocar 1.4 tras publicar 2.0 → ahí
       sí creas release/1.4 de SOPORTE (punto 4)
```

```text
POLÍTICA MÍNIMA A ESCRIBIR:
   │
   ├── quién taggea
   ├── desde qué rama
   ├── checklist: changelog + notas + artefactos +
   │   CI en tag
   └── ventana de congelación (si aplica)
```

---

## 4. Soporte de versiones anteriores

```text
ESCENARIO: publicaste 2.0 pero un cliente sigue en 1.4
```

```text
OPCIONES
──────────────────────────────────────────────────────
a) rama de soporte release/1.4
   · desde el tag v1.4.0
   · solo fixes críticos (¿con backport del fix de
     main? manual y consciente)
   · nuevo tag v1.4.1 desde esa rama
   · caducidad: «1.4 soportado hasta (fecha)»

b) solo main (sin soporte multi-versión)
   · «actualiza a 2.x» — legítimo si lo comunicas
     (semver lo permite: 2.0 avisó del breaking)

c) LTS (long-term support) para versiones elegidas
   · política explícita: cuántas versiones, cuánto
     tiempo (mención de madurez)
```

```text
   │
   ├── cada versión soportada = coste (CI, seguridad,
   │   dependencias) — el inventario de versiones es
   │   deuda operativa consciente
   │
   └── seguridad: fixes de dependencias críticas a
       veces obligan a parchear versiones viejas
       (sección 20/24)
```

```bash
# trabajar en soporte:
git switch -c release/1.4 v1.4.0
# fix + test + tag v1.4.1
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: subir MAJOR por arreglos menores

**Qué ocurrió:** 1.0.0 → 2.0.0 porque «cambió bastante» sin breaking real.

**Por qué posibles:**
* confusión entre «cambio grande» y «incompatible»;
* ausencia de criterio.

**Cómo comprobarlo:** leer notas: ¿hay migración obligatoria? Si no → no es MAJOR.

**Opciones:** si aún no se comunicó, bajar a MINOR; si ya se publicó, corregir la política y comunicar (no reetiquetar en silencio).

**Riesgos:** semver pierde valor (los consumidores no confían).

**Solución:** definición escrita: breaking = requiere acción del usuario (sección 14 cap. 04).

**Cómo se evita:** decisión de versión en la revisión de release.

---

### Error 2: etiquetar con la versión equivocada / etiqueta mutable

**Qué ocurrió:** v1.4.0 apunta a un commit que no es el que se desplegó; o se borró y recreó el tag.

**Por qué posibles:**
* tag desde rama no correcta;
* re-creación tras error.

**Cómo comprobarlo:** `git show v1.4.0` (commit, fecha, mensaje).

**Opciones:** si se publicó: siguiente versión corrige (v1.4.1) con nota; nunca reescribir un tag público si otros lo clonaron (si es imprescindible → aviso + regenerar).

**Riesgos:** artefactos y código desincronizados.

**Solución:** tag anotado desde el commit del release, en checklist.

**Cómo se evita:** script de release que etiqueta (sección 22).

---

### Error 3: rama de release que recibe features

**Qué ocurrió:** release/1.4 con commits de funcionalidad nueva mezclada con fixes.

**Por qué:** se usó para «terminar» trabajo en curso.

**Cómo comprobarlo:** historial de la rama vs. su propósito.

**Opciones:** mover features a develop/main; dejar solo fixes.

**Riesgos:** release impredecible; QA miente.

**Solución:** rama de release = estabilización pura (punto 3).

**Cómo se evita:** regla «features solo en la siguiente versión».

---

### Error 4: sin política de soporte («¿v1.3 sigue?»)

**Qué ocurrió:** nadie sabe si 1.3 se puede parchear; los clientes preguntan y cada quien responde distinto.

**Por qué:** no se definió.

**Cómo comprobarlo:** ¿existen ramas de soporte? ¿está escrita la política?

**Opciones:** definir: versiones soportadas + ventana + canal de anuncio.

**Riesgos:** promesas inconsistentes.

**Solución:** política de soporte en la doc (punto 4).

**Cómo se evita:** revisar al publicar cada major.

---

### Error 5: versiones derivadas solo del calendario

**Qué ocurrió:** `2026.10.02` o `v87` sin comunicar compatibilidad → el consumidor no sabe si actualizar.

**Por qué posibles:**
* calendario (calver) sin convención explícita;
* copia sin contexto.

**Cómo comprobarlo:** ¿el número responde a breaking/feat/fix?

**Opciones:** adoptar semver; o calver PERO con notas y compatibilidad declaradas (calver es válido si además comunicas breaking — decisión documentada).

**Riesgos:** ambigüedad de compatibilidad.

**Solución:** lo importante es el CONTRATO, no la moda del número (punto 1).

**Cómo se evita:** decidir el esquema con el equipo al inicio.

---

### Error 6: bump manual sin changelog ni notas

**Qué ocurrió:** el número subió, el CHANGELOG no, y nadie sabe qué cambió.

**Por qué:** el bump es un paso manual más que se olvida.

**Cómo comprobarlo:** comparar tags con entradas del changelog (sección 14 cap. 04).

**Opciones:** regenerar notas desde el historial; checklist de release.

**Riesgos:** releases incomunicadas.

**Solución:** release = bump + changelog + tag + notas (punto 2).

**Cómo se evita:** script único de release (sección 22).

---

## 6. Práctica guiada

### Objetivo

Publicar una versión semver completa: decisión, changelog, tag y rama de soporte simulada.

### Paso 1: decisión

```text
Tu repositorio de práctica tiene desde v0.1.0:
   │
   ├── añadiste una feature → ¿MINOR?
   ├── ¿algún cambio rompe el uso anterior? → MAJOR
   └── apunta tu decisión en el commit del release
```

### Paso 2: changelog

1. Entrada en CHANGELOG.md (sección 14 cap. 04): `## [0.2.0] - 2026-10-02` con Añadido/Corregido.

### Paso 3: bump + commit + tag

```bash
echo "0.2.0" > VERSION && git add VERSION CHANGELOG.md
git commit -m "release: v0.2.0"
git tag -a v0.2.0 -m "v0.2.0"
git push origin main --follow-tags
```

### Paso 4: release pública

1. En la plataforma: crear Release desde el tag con las notas del changelog.

### Paso 5: soporte simulado

```bash
git switch -c release/0.1 v0.1.0
# aplica un «fix» imaginario
git commit -am "fix: arreglo de seguridad en parser"
git tag -a v0.1.1 -m "v0.1.1"
# ← así se parchea una versión vieja sin tocar main
git switch main && git branch -d release/0.1
```

### Paso 6: política escrita

```text
En CONTRIBUTING/docs:
   │
   ├── esquema de versiones (semver) y quién decide
   ├── checklist de release (changelog, tag, notas)
   └── soporte: «versiones N y N-1 durante (ventana)»
```

### Resultado esperado

Versión publicada con tag anotado + changelog + notas, y política de soporte escrita.

### Conclusión esperada

Semver es contrato y el tag es el ancla: cada release se decide, se documenta y se etiqueta de la misma forma.

---

## 7. Nivel profesional + resumen

### 7.1. Release engineering con versiones

```text
   │
   ├── semver + Conventional Commits → número
   │   derivable y changelog automático (sección 14)
   │
   ├── tag anotado + CI en tag (build de release,
   │   artefactos firmados — mención, secciones
   │   20/22)
   │
   ├── ramas de soporte solo con política escrita y
   │   caducidad
   │
   ├── LTS para versiones elegidas; el resto: «update»
   │
   └── semver para dependencias: consumidores y
       proveedores (compatibilidad hacia atrás como
       valor) — sección 21/25
```

### 7.2. Resumen

En este capítulo aprendiste que:

* semver comunica compatibilidad: MAJOR breaking, MINOR feat, PATCH fix — v0.x puede romper en MINOR;
* el pipeline: decidir semver → changelog → bump → tag anotado → release pública;
* las ramas de release sirven para estabilizar (Git Flow) o soportar versiones publicadas — nunca para meter features;
* el soporte multi-versión es coste consciente: política, ventana y caducidad;
* los errores típicos (MAJOR inflado, tag mutado, features en release, sin política, solo-calendario, bump sin notas) se previenen con checklists y criterio;
* a nivel profesional: semver derivable, CI en tag y LTS planificado.

La idea principal es:

> **El número de versión es un contrato con quien consume tu software: semver lo firma, el tag lo ancla y las notas lo cuentan — todo lo demás es rutina repetible.**

---

## Próximo paso

Ya tienes el horizonte de versiones.

El último capítulo de la sección: comparar los flujos y elegir el tuyo con criterio.

Continúa con:

[`06-comparativa-y-cuando-elegir.md`](06-comparativa-y-cuando-elegir.md)
