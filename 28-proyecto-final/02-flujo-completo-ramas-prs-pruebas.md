# Flujo completo: ramas, Pull Requests y pruebas

## Introducción

Con el diseño escrito, este capítulo ejecuta el corazón del Proyecto final: **el flujo de trabajo completo** — ramas que nacen de issues, commits atómicos con mensaje, Pull Requests revisados y pruebas que bloquean. No es teoría nueva (secciones 05–07, 15 y 22 cap. 03): es aplicarlas con la disciplina que exige un proyecto evaluado, produciendo el historial y los PRs que servirán de evidencia en la defensa final.

---

## Mapa conceptual de este capítulo

```text
Flujo completo: ramas, PRs y pruebas
       │
       ├── 1. El ciclo de trabajo del proyecto
       ├── 2. Commits que cuentan la historia
       │   ├── 3. Pull Requests que se revisan de verdad
       │   └── 4. Pruebas: desde el primer bloque
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. El ciclo de trabajo del proyecto

```text
EL CICLO (ejecútalo desde el PR 1 hasta el último):
   │
   ├── 1. issue: tarea con criterio de hecho (sección
   │   16) — el plan visible
   ├── 2. rama: `feature/...` o `fix/...` desde main
   │   actualizada (sección 07 cap. 04)
   ├── 3. trabajo en pequeños commits (punto 2)
   ├── 4. pruebas nuevas para lo que agregas (punto 4)
   ├── 5. PR: descripción con contexto + enlace al issue
   │   + checklist (sección 15 cap. 04)
   ├── 6. revisión (tu 2.º revisor o tú con distancia)
   │   → resolución de comentarios
   ├── 7. checks verdes → merge según convención
   └── 8. issue cerrado en el mismo PR (Error 1 si se
       arrastran: el tablero y el historial mienten)
```

```text
LO QUE ESTO GENERA (las evidencias del capítulo 06):
   │
   ├── historial multi-commit legible
   ├── ≥ 6 PRs con revisión y conversación
   ├── issues trazados: uno → un PR → cerrado
   └── checks que bloquearon cuando toca (Error 2 si
       jamás bloquearon nada)
```

```text
   │
   └── el flujo es el 60 % del proyecto: si el producto
       crece a expensas del ciclo, el proyecto fracasa
       (Error 3 — Error 5 sección 01 de esta sección)
```

---

## 2. Commits que cuentan la historia

```text
DISCIPLINA (sección 06 — ahora evaluada):
   │
   ├── atómico: un cambio = un commit (Error 4 si
   │   «todo junto»: la historia se vuelve ilegible)
   │
   ├── mensaje: qué hace y por qué corto (imperativo)
   │
   ├── staging consciente: `git add <archivo>` por
   │   pieza, revisar con `git status`/`git diff` antes
   │   (sección 04)
   │
   └── la prueba: `git log --oneline` — ¿se sigue la
       historia del proyecto sin abrir los diffs?
```

```text
HISTORIA DEBIDA (lo que busca un evaluador):
   │
   ├── base → feature → fix → refactor → release (los
   │   tipos de cambio se DISTINGUEN)
   │
   └── si la historia quedó sucia y aún no se
       compartió: reordena antes (Error 5 — sección 06
       cap. 03; si ya se compartió, no reescribas: Error 5 sección 07 cap. 02 — no rompas a otros)
```

```text
   │
   └── los commits son el GUION de tu defensa: en el
       capítulo 06, citarás el historial como evidencia
```

---

## 3. Pull Requests que se revisan de verdad

```text
EL PR MODELO (qué lleva cada uno):
   │
   ├── «qué y por qué» + enlace al issue
   ├── cómo probarlo (comandos o evidencia)
   ├── checklist cumplido (estructura, pruebas, docs)
   └── revisor con comentarios de CAPA: ¿resuelve? →
       ¿correcto? → ¿mantenible? (sección 26 cap. 02
       punto 2)
```

```text
REGLAS DEL PROYECTO (yacen desde aquí):
   │
   ├── ≥ 6 PRs; NINGUNO autorevisado sin pausa (Error
   │   6 si auto-apruebas en segundos: Error 3 sección
   │   02 cap. 27)
   │
   ├── al menos 2 PRs con comentarios REALES
   │   (pregunta/sugerencia, no «ok»)
   │
   ├── un PR rechazado o con cambios pedidos (Error 7
   │   si todos pasaron a la primera: ¿se revisó o se
   │   firmó?)
   │
   └── checks requeridos: ningún merge sin verde (Error
       2 prevención)
```

```text
   │
   └── la conversación del PR es evidencia de
       COLABORACIÓN — guárdala: en la defensa, un hilo
       bien resuelto vale más que un log perfecto
```

---

## 4. Pruebas: desde el primer bloque

```text
SECUENCIA (sección 22 cap. 03 aplicada):
   │
   ├── 1. humo mínimo desde el PR 1 (el proyecto corre)
   ├── 2. pruebas UNITARIAS por funcionalidad nueva
   │   (junto al código — Error 8 si «las pruebas
   │   después»: después no llega)
   ├── 3. casos límite y manejo de errores (Error 9 si
   │   solo el camino feliz)
   ├── 4. la suite en el CI como CHECK REQUERIDO (cap.
   │   04 de esta sección)
   └── 5. prueba negativa al menos UNA: romper a
       propósito y ver el rojo (Error 2 prevención)
```

```text
LO QUE NO HACE FALTA (Error 10 si lo exiges):
   │
   ├── cobertura del 100 % — SÍ aserciones sobre la
   │   lógica que importa
   └── framework exótico — el estándar de tu lenguaje
       basta (sección 21 cap. 01)
```

```text
   │
   └── «¿puedo tocar el código con confianza?» es la
       pregunta que las pruebas responden — y las tuyas
       deben responder SÍ con evidencia (rojo/verde)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: issues arrastrados

**Qué ocurrió:** PRs mergeados con sus issues todavía abiertos; el tablero no reflejaba nada.

**Por qué:** cierre fuera del ciclo (punto 1 Error 1).

**Cómo comprobarlo:** issues abiertos vs. PRs mergeados.

**Opciones:** cerrar con enlace en el PR; regla «cierra en el mismo PR».

**Riesgos:** evidencia contradictoria (Error 2 sección 16 cap. 05).

**Solución:** cierre en el ciclo (punto 1).

**Cómo se evita:** checklist del PR incluye «cierra #n».

---

### Error 2: checks que nunca bloquearon

**Qué ocurrió:** el CI estaba «activo», pero un PR con fallo se fusionó igual.

**Por qué:** no requerido o con bypass (punto 1 Error 2).

**Cómo comprobarlo:** prueba negativa: PR con test rojo → ¿merge bloqueado?

**Opciones:** requerir el check; quitar bypass; repetir la prueba.

**Riesgos:** toda la sección de CI del proyecto queda sin evidencia.

**Solución:** puerta probada (punto 1/4).

**Cómo se evita:** la prueba negativa es paso obligatorio (cap. 04).

---

### Error 3: features a costa del flujo

**Qué ocurrió:** semana 4: «solo termino esta función» — el PR 2 y las pruebas quedaron pendientes.

**Por qué:** secuencia invertida (punto 1 Error 3).

**Cómo comprobarlo:** commits de la semana: ¿cuántos pasaron por PR?

**Opciones:** congelar features; ejecutar 2 ciclos completos esta semana.

**Riesgos:** no demostrar el flujo (Error 1 sección 01 de esta sección).

**Solución:** el ciclo manda (punto 1).

**Cómo se evita:** plan semanal con cupo fijo de «ciclos de PR».

---

### Error 4: commits de «todo junto»

**Qué ocurrió:** feature completa en un commit; la mitad del trabajo sin historia.

**Por qué:** sin atómica (punto 2).

**Cómo comprobarlo:** `git log --stat` — ¿commits con decenas de archivos?

**Opciones:** para el trabajo que queda: commits por pieza; no reescribas lo compartido (punto 2 Error 5).

**Riesgos:** historia ilegible en la defensa.

**Solución:** atómicos (punto 2).

**Cómo se evita:** `git status` antes de cada add.

---

### Error 5: historial reescrito sobre trabajo compartido

**Qué ocurrió:** un `rebase -i` sobre main ya empujado confundió a los demás.

**Por qué:** se reescribió historia pública (sección 07 cap. 02 Error 8).

**Cómo comprobarlo:** ¿la rama la usan otros? ¿se publicó?

**Opciones:** revert en vez de rewrite para lo público; avisa si fue rama compartida.

**Riesgos:** conflictos y pérdida de confianza.

**Solución:** reescribe solo lo privado (punto 2).

**Cómo se evita:** regla: main y ramas compartidas no se reescriben.

---

### Error 6: auto-revisión instantánea

**Qué ocurrió:** los PRs se aprobaban solos en segundos; los comentarios eran «ok».

**Por qué:** sin distancia ni segundo revisor (punto 3 Error 6).

**Cómo comprobarlo:** tiempo PR→aprobación; nº de comentarios sustantivos.

**Opciones:** pausa obligatoria, revisor asignado distinto (si hay equipo), mínimo 2 hilos reales.

**Riesgos:** revisión decorativa (Error 3 sección 02 cap. 26).

**Solución:** revisión de verdad (punto 3).

**Cómo se evita:** la rúbrica exige «2 PRs con comentarios reales».

---

### Error 7: todos los PRs pasaron a la primera

**Qué ocurrió:** 8 PRs, cero cambios pedidos — señal de que nadie miró.

**Por qué:** presión por avanzar (punto 3 Error 7).

**Cómo comprobarlo:** historial de revisiones: ¿alguna ronda de cambios?

**Opciones:** revisar uno a fondo AHORA y pedir cambios reales; si el código está bien, que la conversación lo demuestre (preguntas de capa superior).

**Riesgos:** evidencia de «firmado», no revisado.

**Solución:** PRs que mejoran con revisión (punto 3).

**Cómo se evita:** revisión como práctica con plazo (sección 26 cap. 02).

---

### Error 8: pruebas «después»

**Qué ocurrió:** la semana final no había tiempo y las pruebas quedaron «para el final» — nunca llegaron.

**Por qué:** secuencia (punto 4 Error 8).

**Cómo comprobarlo:** ¿cada funcionalidad del PR trae su test?

**Opciones:** backlog de pruebas por funcionalidad sin test; ejecutar por bloques ya entregados.

**Riesgos:** sin evidencia de calidad.

**Solución:** junto al código (punto 4).

**Cómo se evita:** «prueba o no está hecho» en la definition of done (sección 15 cap. 04).

---

### Error 9: solo el camino feliz

**Qué ocurrió:** las pruebas cubrían lo normal; el input vacío rompía todo.

**Por qué:** sin límites (punto 4).

**Cómo comprobarlo:** ¿tests de vacío, error y límites?

**Opciones:** añadir casos límite por módulo principal.

**Riesgos:** falsa seguridad.

**Solución:** límites incluidos (punto 4).

**Cómo se evita:** checklist de pruebas: felicidad + límites.

---

## 6. Práctica guiada

### Objetivo

Ejecutar 6 ciclos completos del flujo con evidencias de revisión y pruebas bloqueantes.

### Paso 1: tablero

1. ≥ 6 issues con criterios claros (uno por bloque de tu diseño).

### Paso 2: ciclo ×6

```text
issue → rama → commits atómicos → pruebas → PR
→ revisión (comentarios reales) → verde → merge →
issue cerrado
```

1. Documenta los tiempos (PR→revisión) — métrica futura.

### Paso 3: la prueba negativa

1. Un PR con test rojo deliberado: verifica que NO se puede mergear. Corrige y continúa (punto 4 Error 2).

### Paso 4: historial

1. Revisa `git log --oneline`: ¿se cuenta la historia? ¿tipos de cambio distinguibles?

### Paso 5: revisión cruzada

1. Si hay equipo: 2 PRs revisados por el otro. Si no: revisión con distancia (horas) + anotaciones como si fueras otro.

### Paso 6: entrega de capítulo

```text
Checklist:
   [ ] ≥ 6 issues cerrados con su PR
   [ ] historial legible (tipos de cambio visibles)
   [ ] ≥ 6 PRs con checklist cumplido
   [ ] ≥ 2 PRs con comentarios sustantivos
   [ ] 1 PR bloqueado en rojo (evidencia guardada)
   [ ] pruebas por funcionalidad + casos límite
```

### Resultado esperado

Seis ciclos completos: historia legible, conversación de revisión y puerta probada en negativo.

### Conclusión esperada

Cuando el ciclo se ha repetido seis veces sin saltarse pasos, el flujo deja de ser un requisito del enunciado y se convierte en la manera en que trabajas — que era exactamente lo que el Proyecto final debía demostrar.

---

## 7. Nivel profesional + resumen

### 7.1. Del ciclo al equipo real

```text
   │
   ├── lo practicado es el flujo diario de cualquier
   │   equipo: la única diferencia real es cuántas
   │   personas revisan y qué gates añade la empresa
   │   (sección 19/20)
   │
   ├── los PRs con conversación son tu cartera de
   │   ejemplos de «así trabajo» (sección 26 cap. 02)
   │
   ├── la métrica PR→revisión que mediste es la misma
   │   que un lead usa en su retro (sección 24 cap. 06)
   │
   └── las pruebas con rojo/verde evidencian lo que la
       sección 22 cap. 03 exige: «siempre la misma
       respuesta con la misma entrada»
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el ciclo completo (issue → rama → commits → pruebas → PR → revisión → merge → cierre) es la unidad de progreso del Proyecto final;
* los commits atómicos con tipos distinguibles forman el guion de la defensa;
* los PRs necesitan contexto, checklist, conversación real y checks requeridos — probados en negativo;
* las pruebas nacen con cada bloque, incluyen límites y bloquean el merge;
* los errores típicos (issues arrastrados, checks sin dientes, features a costa del flujo, commits gigantes, historia reescrita, auto-revisión, aprobaciones sin mirar, pruebas eternas, camino feliz) se previenen con disciplina y métricas;
* la evidencia recogida aquí alimenta directamente la demostración final.

La idea principal es:

> **El flujo completo no se demuestra con un diagrama sino con repetición: seis ciclos sin saltos, un historial legible y al menos una puerta que efectivamente cerró.**

---

## Próximo paso

Flujo ejecutado con evidencias.

Ahora la cara visible del proyecto: documentación y colaboración que otros puedan seguir.

Continúa con:

[`03-documentacion-y-colaboracion.md`](03-documentacion-y-colaboracion.md)
