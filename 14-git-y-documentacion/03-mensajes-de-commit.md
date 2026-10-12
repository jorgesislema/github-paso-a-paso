# Mensajes de commit
[`04-changelog-y-release-notes.md`](04-changelog-y-release-notes.md)

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Por qué es importante que el asunto de un commit describa el «qué changed» en imperativo y el cuerpo explique el «por qué» con contexto y decisiones, en lugar de solo listar acciones?
2. ¿Cómo afecta el uso de convenciones como Conventional Commits a la generación automática de changelogs y a la capacidad de determinar el incremento de versión semver solo desde el historial?
3. ¿Qué impacto tiene mezclar idiomas o usar un tono emocional en los mensajes de commit sobre la utilidad del historial para auditorías y para nuevos miembros del equipo?
4. ¿Cómo decidir si un mensaje de commit debe incluir un enlace a un issue (p. ej., «Closes #123») y cuándo es suficiente dejar el contexto en el cuerpo sin referencia externa?
5. ¿Qué consecuencias tiene aplicar un rebase o amend a commits ya compartidos sin coordinar con el equipo, y cómo se evita este riesgo?
6. ¿Cómo implementarías una revisión de PR que verifique tanto el formato del asunto (longitud, imperativo) como la presencia de explicación del por qué en el cuerpo?

[`04-changelog-y-release-notes.md`](04-changelog-y-release-notes.md)
# Mensajes de commit

## Introducción

El historial de Git es la memoria del proyecto: cada commit deja una nota. Esa nota es lo primero que leerá quien investigue un bug dentro de seis meses, revise un relevo de equipo o necesite saber qué pasó y por qué.

Un mensaje de commit bien escrito transforma el log de Git en documentación viva. Mal escrito, lo convierte en ruido inútil. Este capítulo cubre formato, convención, idioma y los errores que arruinan un historial.

---
## Mapa conceptual de este capítulo

```mermaid
mindmap
  root((Mensajes de commit))
    Para quién escribes
    Formato estándar asunto y cuerpo
    Convenciones comunes Conventional Commits
    Idioma y estilo
      Errores comunes con diagnóstico completo
      Práctica guiada
      Nivel profesional + resumen
```

---
## 1. Para quién escribes

```text
Lectores reales del mensaje:
    â
    âââ tú, en 3 meses, preguntando Â«¿por qué está
    â   este if aquí?Â»
    â
    âââ quien revise el historial para auditar un
    â   cambio (release, incidente, seguridad)
    â
    âââ quien haga bisect buscando la regresión
    â   (sección 12) â el mensaje es su mapa
    â
    âââ herramientas: changelogs automáticos,
        analytics, integración con issues
```

```text
Regla mental:
    â
    âââ el asunto responde Â«qué cambióÂ»;
        el cuerpo responde Â«por qué cambióÂ»
        (el diff ya cuenta el Â«cómoÂ»)
```

---
## 2. Formato estándar (asunto + cuerpo)

```text
ELEMENTOS
ââââââââââââââââââââââââââââââââââââââââââââââââââââââ
asunto (subject)
   Â· una línea, â¤ 50 caracteres (costumbre clásica)
   Â· imperativo: Â«Añadeâ¦Â», Â«Corrigeâ¦Â», no Â«Añadidoâ¦Â»
   Â· sin punto final
   Â· mayúscula inicial según estilo del equipo

cuerpo (body) â opcional pero valioso
   Â· línea en blanco tras el asunto
   Â· párrafos de â¤ 72 caracteres
   Â· explica EL PORQUÜ: contexto, problema, decisión
   Â· menciona trade-offs y alternativas descartadas

pie (footer) â opcional
   Â· vínculos: "Closes #123", "Refs: â¦"
   Â· notas de revisión: "Reviewed-by: â¦"
   Â· rompes API: "BREAKING CHANGE: â¦"
```

```text
EJEMPLO
ââââââââââââââââââââââââââââââââââââââââââââââââââââââ
Corrige carrera al refrescar el token de sesión

Los refrescos concurrentes generaban dos rotaciones
y la segunda invalidaba la primera, dejando a los
usuarios sin sesión. Se serializa el refresco con la
cola ya existente en SessionManager.

Alternativa descartada: mutex global (mataba
concurrencia innecesaria en el resto del flujo).

Closes #482
```

```text
Por qué el imperativo (Â«CorrigeÂ»): los mensajes
 forman la frase Â«este commit *corrige* â¦Â» al
 aplicarse (y así lo traduce git log --oneline).
```

---
## 3. Convenciones comunes

```text
CONVENTIONAL COMMITS (la más extendida)
    â
    âââ tipo(scope): descripción
    â     feat: funcionalidad nueva
    â     fix: corrección de bug
    â     docs: solo documentación
    â     style: formato (sin cambio de lógica)
    â     refactor: reestructurar sin cambiar
    â                     comportamiento
    â     test: añade/corriga tests
    â     chore: tareas de mantenimiento
    â     ci/build/perf: â¦ según la convención del
    â                     equipo
    â
    âââ BREAKING CHANGE: ! o pie explícito
    â
    âââ sirve a: changelogs automáticos, semver
        derivado, filtros de release
```

```text
feat(api): añade endpoint de exportación CSV
fix(parser): ignora comentarios multi-línea
docs(readme): corrige ejemplo de instalación

Otros esquemas (mención): imperative mood simple,
tipo de rama/issue en el mensaje â lo importante es
que el equipo elija UNO y lo documente.
```

```bash
# el mensaje en el commit:
git commit               # editor con plantilla
git commit -m "fix: ..." # una línea (sin cuerpo)
```

---
## 4. Idioma y estilo

```text
    â
    âââ idioma: el que el equipo documente; lo crítico
    â   es ser consistente y claro (en este repo, en
    â   español con terminología técnica intacta)
    â
    âââ no mezclar idiomas dentro de un historial
    â   sin criterio
    â
    âââ lenguaje neutro y profesional: sin sarcasmo,
    â   sin culpabilizar (Â«chore: no funcionaba el
    â   review de AnaÂ»)
    â
    âââ nombra el dominio: Â«corrige cálculo de IVA en
        exportaciónÂ» > Â«pequeño arregloÂ»
```

```text
Historial como disciplina:
    â
    âââ un commit = una idea revisable
    â
    âââ mensajes se reescriben ANTES de compartir
    â   (amend / rebase -i de la sección 12)
    â
    âââ después de compartir: solo añadiendo (y con
        causa) â reescribir historial compartido
        obliga a coordinar
```

---
## 5. Errores comunes con diagnóstico completo

### Error 1: mensajes de relleno

**Qué ocurrió:** `git log` lleno de Â«updateÂ», Â«fixÂ», Â«wipÂ», Â«cambiosÂ».

**Por qué posibles:**
* prisa y hábito;
* commits automáticos de herramientas;
* plantilla ausente.

**Cómo comprobarlo:** `git log --oneline -20`.

**Opciones:** reescribir lo no compartido (amend, rebase -i); de lo compartido, mejorar desde ahora + regla de equipo.

**Riesgos:** historial inútil para bisect y auditoría.

**Solución:** plantilla de commit + revisión en PR.

**Cómo se evita:** plantilla (`.gitmessage`) y convención documentada en CONTRIBUTING.

---

### Error 2: asunto que no dice qué cambió

**Qué ocurrió:** Â«correcciones variasÂ» o Â«review commentsÂ».

**Por qué:** se describe la acción (Â«atendí comentariosÂ») en vez del cambio del producto.

**Cómo comprobarlo:** leer solo el asunto: ¿sabes qué cambió en el sistema?

**Opciones:** reescribir (Â«Corrige validación de correo en registroÂ»).

**Riesgos:** imposible navegar el log.

**Solución:** asunto = cambio observable.

**Cómo se evita:** revisión de historial en el PR (no solo del diff).

---

### Error 3: el Â«por quéÂ» vive solo en el PR

**Qué ocurrió:** el PR tiene discusión rica; el commit dice Â«fixÂ»; la plataforma desaparece o el repo cambia de host y se pierde el contexto.

**Por qué:** asumir persistencia de la plataforma.

**Cómo comprobarlo:** leer el commit sin contexto externo.

**Opciones:** copiar la decisión esencial al cuerpo (Â«Closes #123Â» mantiene el vínculo).

**Riesgos:** memoria frágil.

**Solución:** cuerpo con contexto + enlace al issue.

**Cómo se evita:** checklist: Â«¿se entiende sin abrir el PR?Â».

---

### Error 4: commits-basura creados por herramientas

**Qué ocurrió:** historial con Â«apply prettierÂ», Â«merge remote-trackingÂ», Â«tempÂ» de IDEs.

**Por qué:** autocommit de extensiones; merge inmediatos innecesarios.

**Cómo comprobarlo:** `git log --oneline | Select-String 'temp|tmp|wip'`.

**Opciones:** limpiar lo no compartido (rebase -i, squash); configurar la herramienta para no autocommit; preferir rebase local sobre merges de sync (política del equipo, sección 16/17).

**Riesgos:** ruido permanente.

**Solución:** una política de sincronización y de commits automáticos.

**Cómo se evita:** revisar la configuración del IDE al entrar al proyecto.

---

### Error 5: estilo inconsistente en el mismo historial

**Qué ocurrió:** unos Â«Fix:Â», otros Â«fixup!Â», otros español/inglés mezclados.

**Por qué:** convención no acordada o no aplicada.

**Cómo comprobarlo:** muestra de 50 mensajes.

**Opciones:** documentar la convención; aplicar desde ya; (lo histórico: se respeta salvo reescritura coordinada).

**Riesgos:** herramientas (changelog) fallan; lectores confundidos.

**Solución:** CONTRIBUTING con ejemplos correctos e incorrectos.

**Cómo se evita:** PR review que también mira mensajes.

---

### Error 6: mensajes engañosos o que culpan

**Qué ocurrió:** Â«arreglo estúpido de XÂ», Â«no tocar estoÂ» sin explicación, mensajes que no coinciden con el diff (fix que no arregla nada).

**Por qué posibles:**
* descuido;
* commits mal separados (mezclan cambios);
* tono emocional.

**Cómo comprobarlo:** revisar diff vs. mensaje; revisar tono.

**Opciones:** reescribir (si no compartido); separar cambios mal agrupados.

**Riesgos:** mala relación, auditoría errónea.

**Solución:** mensaje profesional + un commit = una idea.

**Cómo se evita:** reglas de estilo del equipo y pausa de 10 segundos antes de `git commit`.

---
## 6. Práctica guiada

### Objetivo

Escribir un par de commits con formato completo y limpiar el historial de prueba.

### Paso 1: plantilla

```bash
git config --global commit.template ~/.gitmessage.txt
```

```text
# ~/.gitmessage.txt (plantilla en español)
# <tipo>(<ámbito>): <asunto en imperativo, â¤50>
#
# Por qué: <contexto y problema>
# Alternativas: <si aplica>
#
# Closes #nnn
```

### Paso 2: commit con cuerpo

```bash
echo "cambio" >> nota.txt
git add nota.txt
git commit           # escribe asunto + cuerpo en el
                      # editor
git log -1 --format=full   # verifica estructura
```

### Paso 3: analizar un historial malo

```bash
git log --oneline -10
# clasifica: ¿qué es ruido? ¿qué responde al Â«quéÂ»?
# ¿algún Â«por quéÂ» que solo vive en el PR?
```

### Paso 4: limpiar (solo historia NO compartida)

```bash
git reset --soft HEAD~2      # deshace 2 commits
                               # manteniendo cambios
git commit                   # rehace con mensajes
                               # buenos
# o git rebase -i HEAD~2 with reword/squash
# (sección 12)
```

### Paso 5: convención en el equipo

1. Escribe en CONTRIBUTING: formato, ejemplo bueno, ejemplo malo, cuándo Â«Closes #xÂ».

### Resultado esperado

Historial de prueba legible: asuntos que cuentan el qué, cuerpos con el porqué, plantilla instalada.

### Conclusión esperada

El mensaje es la capa semántica del historial: se redacta como mini-documento y se revisa como parte del PR.

### Ejercicio de transferencia

Elige un proyecto de código abierto pequeño con el que nunca hayas contribuido. Envía un pull request que incluya al menos dos commits: uno con mensaje siguiendo Conventional Commits (tipo, ámbito, asunto â¤50) y otro que corrija un error menor. Asegúrate de que el cuerpo del primer commit explique el por qué con contexto y que el historial resultante sea legible y útil para un revisor externo. Entrega capturas del historial antes y después, junto con el mensaje del pull request.

---
## 7. Nivel profesional + resumen

### 7.1. Historial como artefacto de ingeniería

```text
    â
    âââ convención + plantilla + hooks de lint de
    â   mensajes (categoría: commitlint) in CI
    â
    âââ changelog derivado (feat/fix/BREAKING) y
    â   semver derivado del historial
    â
    âââ historial que sobrevive a migraciones de
    â   plataforma (por eso el contexto está en el
    â   commit, no solo en el PR)
    â
    âââ reescritura: solo lo local/no compartido, o
        coordinación completa (sección 12, cap. 01)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el asunto dice Â«quéÂ» (imperativo, â¤50, una línea) y el cuerpo dice Â«por quéÂ» (contexto, decisiones, alternativas);
* el pie enlaza issues y marca breaking changes;
* Conventional Commits (`tipo(scope):`) alimenta changelogs y releases automáticos;
* el idioma y el tono se eligen como equipo: consistencia, profesionalidad, dominio nombrado;
* los errores típicos (relleno, asuntos vacíos, porqué solo en PR, ruido de herramientas, inconsistencia, mensajes engañosos) se previenen con plantilla, revisión de historial y convención escrita;
* a nivel profesional: historial tratado como artefacto de ingeniería, reescrito solo antes de compartirse.

La idea principal es:

> **El historial es documentación ejecutable: escribe para quien lo leerá dentro de un año, con el qué en una línea y el porqué en el cuerpo.**

---
## Próximo paso

Ya sabes documentar el pasado commit a commit.

El siguiente paso documenta el pasado a gran escala: changelogs y notas de versión.

Continúa con:

[`04-changelog-y-release-notes.md`](04-changelog-y-release-notes.md)
