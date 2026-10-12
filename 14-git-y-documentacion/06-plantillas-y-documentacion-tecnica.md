# Documentación técnica en `docs/`
[`README.md`](README.md)

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Por qué es importante definir una regla de ubicación clara (por ejemplo, «¿lo busca alguien que ya entró?» ? docs/; «¿lo busca quien llega?» ? README) y cómo afecta esto a la experiencia de usuarios nuevos versus desarrolladores que ya están familiarizados con el proyecto?
2. ¿Cómo influye la presencia de un índice enlazado desde el README raíz en la capacidad de encontrar documentación técnica específica, y qué riesgos existen si el índice falta o está desactualizado?
3. ¿Qué ventajas ofrece utilizar ADRs (Architectural Decision Records) para documentar decisiones de arquitectura frente a simplemente incluir el «cómo» en la documentación de implementación, y cómo se evita que los ADRs se vuelvan obsoletos?
4. ¿De qué manera integrar revisiones de documentación en los PRs (por ejemplo, mediante checklists que verifiquen que los diagramas afectados estén actualizados) contribuye a mantener la documentación sincronizada con el código y a reducir la pudrición?
5. ¿Qué consecuencias tiene almacenar credenciales o información sensible en archivos de documentación dentro de un repositorio público, y cómo mitigarlo utilizando placeholders y referencias a gestores de secretos?
6. ¿Cómo diseñarías un proceso de revisión periódica de documentación que combine el uso de linters de Markdown, verificaciones de enlaces y builds de sitio estático para asegurar que la documentación permanezca útil y accesible a lo largo del tiempo?

[`README.md`](README.md)
# Documentación técnica en `docs/`

## Introducción

El README abre la puerta; detrás necesita una casa ordenada: `docs/` con guías, arquitectura, decisiones y API. Sin estructura, la documentación crece como cajón desastre; con convención, se mantiene y se encuentra.

Este capítulo enseña a organizar la documentación técnica de un repositorio: qué va en `docs/`, qué formatos usar, cómo documentar arquitectura y decisiones, y cómo evitar que se pudra.

---
## Mapa conceptual de este capítulo

```mermaid
mindmap
  root((Documentación técnica en docs/))
    Qué va en docs/ (y qué no)
    Estructura recomendada
    Formatos Markdown ADR diagramas
    Mantenerla viva
      Errores comunes con diagnóstico completo
      Práctica guiada
      Nivel profesional + resumen
```

---
## 1. Qué va en docs/ (y qué no)

```text
VA a docs/:
    â
    âââ guías (primeros pasos, recetas, troubleshooting)
    âââ arquitectura y diagramas de sistema
    âââ decisiones (ADR: arquitectónicas y de proceso)
    âââ referencia de API/CLI (generada o escrita)
    âââ convenciones del proyecto (estilo, seguridad)
    âââ runbooks (operación, incidentes)
```

```text
NO va (está en otro sitio):
    â
    âââ README        â puerta de entrada (cap. 02)
    âââ CHANGELOG     â entregas (cap. 04)
    âââ CONTRIBUTING  â contribuir (cap. 05)
    âââ código/comentarios â en el código, lo
        inseparable (docs Â«junto al códigoÂ» para
        detalles micro)
```

```text
    â
    âââ regla de ubicación: Â«¿lo busca alguien que
    â   ya entró?Â» â docs/; Â«¿lo busca quien llega?Â»
    â   â README
    â
    âââ documentos CORTOS con un objetivo; los
        gordos se dividen y se indexan
```

---
## 2. Estructura recomendada

```text
docs/
âââ README.md          â índice de la documentación
âââ primeros-pasos.md
âââ guias/
â   âââ flujo-de-trabajo.md
â   âââ troubleshooting.md
âââ arquitectura/
â   âââ README.md      â vista general + diagramas
â   âââ modulos.md
âââ decisiones/
â   âââ 0001-usar-postgres.md
â   âââ 0002-versionado-semver.md
âââ referencia/
â   âââ cli.md
âââ operacion/
    âââ runbook-despliegue.md
```

```text
Convenciones:
    â
    âââ índice (docs/README.md) enlazado desde el
    â   README raíz
    â
    âââ nombres en minúsculas-guion (coherente con el
    â   resto del repo)
    â
    âââ numeración solo en decisiones (ADR):
    â   0001, 0002â¦
    â
    âââ fechas ISO (2026-10-02) cuando ayuden
```

---
## 3. Formatos: Markdown, ADR, diagramas

```text
MARKDOWN
    â
    âââ base de todo (cap. 01 de esta sección)
    âââ plantillas por tipo (guía, runbook, ADR)
```

```markdown
<!-- ADR: registro de decisión -->
# ADR-0001: Postgres como base de datos

## Estado: Aceptada (2026-10-02)

## Contexto
Necesitamos transacciones y consultas ad-hocâ¦

## Decisión
Usamos PostgreSQL 16â¦

## Consecuencias
+ ecosistema, + SQL conocido
- operación del servidor propioâ¦
```

```text
DIAGRAMAS
    â
    âââ ASCII en Markdown (portable, versionable,
    â   como en este curso) para esquemas simples
    â
    âââ Mermaid/PlantUML: bloques de código que la
    â   plataforma renderiza â orden de magnitud para
    â   diagramas grandes (mención: elegir uno y
    â   mantenerlo)
    â
    âââ arquitectura: cajas y flechas con la
        frontera de datos y confianza visible (sección
        25)
```

```text
RECUERDA:
    â
    âââ el formato sigue al lector: runbook debe ser
    â   copiable en incidente (paso a paso, comandos)
    â
    âââ ADR = Â«por qué decidimosÂ», no Â«cómo está
        hechoÂ» (ese es el doc de arquitectura)
```

---
## 4. Mantenerla viva

```text
Señales de pudrición:
    â
    âââ comandos/paths que ya no existen
    âââ contradicción entre README y docs/
    âââ ADRs sin actualizar estado (Â«PropuestaÂ» de
        hace dos años)
```

```text
Higiene:
    â
    âââ los PR que cambian comportamiento tocan docs/
    â   (checklist, sección 05)
    â
    âââ docs con Â«dueñoÂ» (CODEOWNERS por carpeta,
    â   sección 18)
    â
    âââ ADRs: solo se cambia el estado con nuevo ADR
    â   (superseded por ADR-NNNN) â el pasado no se
    â   reescribe
    â
    âââ revisión periódica: Â«¿seguiría siendo cierto
        este documento hoy?Â»
```

---
## 5. Errores comunes con diagnóstico completo

### Error 1: docs/ como cajón de sastre

**Qué ocurrió:** todo lo que sobró cayó en `docs/` sin índice ni orden.

**Por qué:** sin convención de entrada.

**Cómo comprobarlo:** listar `docs/`; contar documentos sin enlace en el índice.

**Opciones:** estructura del punto 2; mover, fusionar o eliminar.

**Riesgos:** nadie encuentra nada â docs muertos.

**Solución:** índice obligatorio y criterio de ubicación (punto 1).

**Cómo se evita:** plantilla de secciones al crear la carpeta.

---

### Error 2: documentar el Â«cómoÂ» y olvidar el Â«por quéÂ»

**Qué ocurrió:** docs que describen la implementación actual pero no las razones â cada lector reinterpreta y Â«mejoraÂ» lo que ya se decidió.

**Por qué:** no hay ADRs.

**Cómo comprobarlo:** buscar en la doc palabras como Â«decidimosÂ», Â«porqueÂ»; si no hay, falta contexto.

**Opciones:** crear ADRs para las decisiones vivas (a posteriori, con fecha honesta).

**Riesgos:** decisiones re-hechas sin memoria.

**Solución:** separar ADR (porqué) de arquitectura (qué está así).

**Cómo se evita:** exigir ADR para cambios de arquitectura en el PR.

---

### Error 3: diagramas desactualizados (fotos del pasado)

**Qué ocurrió:** el diagrama muestra un componente que ya no existe.

**Por qué:** imagen pegada sin fuente, o dibujo no versionado.

**Cómo comprobarlo:** contrastar con el despliegue real.

**Opciones:** redibujar desde fuente (Mermaid/ASCII en repo); borrar si ya no se entiende.

**Riesgos:** ingenieros construyendo sobre una mentira.

**Solución:** diagramas como texto en el repo, actualizados en el mismo PR.

**Cómo se evita:** casilla Â«diagrama afectado actualizadoÂ» en PRs de arquitectura.

---

### Error 4: runbooks escritos como ensayo

**Qué ocurrió:** en un incidente, el runbook de 5 párrafos no se puede seguir con una mano.

**Por qué:** formato narrativo.

**Cómo comprobarlo:** intentar simular: leer en frío y ejecutar los pasos.

**Opciones:** reescribir paso a paso con comandos copiables, verificación por paso y Â«si falla ââ¦Â».

**Riesgos:** MTTR peor; pánico.

**Solución:** plantilla de runbook operativa (pasos, comandos, verificación, rollback).

**Cómo se evita:** ensayar runbooks en ejercicios.

---

### Error 5: docs duplicados con versiones distintas

**Qué ocurrió:** el Â«cómo desplegarÂ» aparece en README, en docs/ y en un wiki, con diferencias.

**Por qué:** crecimiento sin dueño.

**Cómo comprobarlo:** buscar el término en todo el repo (grep).

**Opciones:** elegir fuente única; los demás enlazan.

**Riesgos:** el lector elige la versión vieja.

**Solución:** una verdad, muchos enlaces.

**Cómo se evita:** revisión de duplicados al añadir documentos grandes.

---

### Error 6: documentación interna filtrada o insegura

**Qué ocurrió:** runbook con credenciales, IPs internas o vulnerabilidades en repo público (o en repo privado con acceso demasiado amplio).

**Por qué:** mezclar operación real con doc sin clasificar.

**Cómo comprobarlo:** escaneo de secretos (sección 13/20); revisar qué contiene cada doc.

**Opciones:** externalizar credenciales (referencias a gestor de secretos); clasificar acceso; si se publicó â flujo de incidente (cap. 05 sección 13).

**Riesgos:** incidente de seguridad.

**Solución:** docs con placeholders y mínima exposición.

**Cómo se evita:** escaneo en CI y revisión de seguridad (secciones 20/24).

---
## 6. Práctica guiada

### Objetivo

Crear un `docs/` ordenado con índice, una guía, un ADR y un runbook corto.

### Paso 1: esqueleto e índice

1. Crea la estructura del punto 2 (las carpetas que apliquen).
2. Escribe `docs/README.md` enlazando cada documento.

### Paso 2: guía

1. `docs/guias/troubleshooting.md`: 3 problemas frecuentes con Â«síntoma â diagnóstico â arregloÂ».

### Paso 3: ADR

1. `docs/decisiones/0001-<tema>.md` con contexto, decisión, consecuencias y estado (fecha ISO).

### Paso 4: runbook

1. `docs/operacion/runbook-despliegue.md`: pasos numerados con comandos, verificación y rollback.

### Paso 5: diagrama versionado

1. Añade en `docs/arquitectura/README.md` un diagrama ASCII (o Mermaid) del sistema de práctica.

### Paso 6: enlazar y verificar

```mermaid
flowchart TD
    A["README raíz"] --> B["docs/README.md"]
    B --> C["cada documento"]
    D["Prueba de clics"] --> E["Prueba de ejecución del runbook en el sandbox"]
```

### Resultado esperado

`docs/` con índice navegable, guía, ADR, runbook y diagrama vivo.

### Conclusión esperada

La documentación técnica se organiza como producto: ubicación por pregunta, formatos por propósito y dueños por área.

### Ejercicio de transferencia

Imagina que debes documentar el proceso de despliegue de una aplicación web en un entorno de staging para un equipo de operaciones que no conoce el código. Crea un runbook operativo en `docs/operacion/` que incluya pasos numerados con comandos copiables, verificación por paso y condiciones de rollback. Además, añade un diagrama de arquitectura actualizado en `docs/arquitectura/` que muestre los componentes involucrados y sus fronteras de confianza. Entiende que el runbook debe ser usable sin conexión a internet y que el diagrama debe estar en formato Mermaid para facilitar revisiones en PR. Entrega los archivos runbook y diagrama, junto con una captura de prueba de ejecución del runbook en un entorno aislado.

---
## 7. Nivel profesional + resumen

### 7.1. Doc como sistema

```text
    â
    âââ índice + plantillas + dueños (CODEOWNERS)
    â
    âââ ADR obligatorio para cambios de arquitectura
    â   (proceso del equipo, sección 15/25)
    â
    âââ diagramas como código (fuente en repo, revisión
    â   en PR, render en CI si aplica)
    â
    âââ docs como código: linter de Markdown, enlaces
    â   verificados en CI, builds de sitio estático
    â   (categoría: docs-as-code)
    â
    âââ clasificación y escaneo: nada de credenciales
        en docs (secciones 20/24)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* `docs/` recibe guías, arquitectura, decisiones (ADR), referencia y operación â con índice enlazado desde el README;
* formatos por propósito: guía corta, ADR de contexto/decisión/consecuencias, runbook paso a paso, diagramas versionados (ASCII/Mermaid);
* los ADRs preservan el Â«por quéÂ» y no se reescriben: se superseden con nuevos ADRs;
* la vida de los docs depende de dueños, checklist en PRs y revisión periódica;
* los errores típicos (cajón desastre, solo Â«cómoÂ», diagramas-foto, runbooks de ensayo, duplicados, credenciales en doc) se previenen con convención y automatización;
* a nivel profesional: docs-as-code con linter, enlaces y CI.

La idea principal es:

> **La documentación es infraestructura del conocimiento: se versiona, se revisa y tiene dueño â porque lo que no se mantiene, engaña.**

---
## Próximo paso

Has completado la organización de `docs/`.

Cierra la sección con el índice:

[`README.md`](README.md)
