# Proyecto 8: proyecto colaborativo

## Introducción

Un repositorio individual prueba técnicas; **un repositorio compartido prueba el flujo completo con gente real**: ramas que conviven, revisiones cruzadas, reglas que nadie puede saltarse y decisiones que se toman entre varios. El Proyecto colaborativo cierra la etapa 27 juntando todo lo aprendido — issues, PRs, protección, CODEOWNERS, CI, documentación y releases — en un contexto donde ya no basta con que tú entiendas tu historial: tiene que entenderse entre todos.

---

## Mapa conceptual de este capítulo

```text
Proyecto 8: proyecto colaborativo
       │
       ├── 1. Qué construyes (y con quién)
       ├── 2. Reglas del proyecto (el acuerdo escrito)
       │   ├── 3. El flujo que practicarán todos
       │   └── 4. Los papeles (y cómo rotarlos)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes (y con quién)

```text
EL PROYECTO:
   │
   ├── un repositorio útil para 2–4 personas (el
   │   mínimo que crea INTERACCIÓN real): herramienta
   │   compartida, colección de recetas/notes con
   │   aportes, sitio de equipo, plantillas comunes…
   │
   └── lo que importa: NO el producto, sino que el
       FLUJO se ejecute con fricción real (comentarios,
       opiniones, cambios simultáneos)
```

```text
CON QUIÉN (si no tienes equipo):
   │
   ├── 1 compañero en el mismo curso (ideal: se
   │   corrigen mutuamente)
   ├── o dos «personas» tuyas con roles separados (menos
   │   ideal, pero practica permisos)
   │
   └── regla: mínimo 2 PRs REVISADOS POR ALGUIEN QUE
       NO ES SU AUTOR (Error 1 si todos revisan lo
       propio: no es colaboración)
```

```text
   │
   └── entregable: 1 release o versión del proyecto con
       al menos 3 contribuciones cruzadas en el
       historial
```

---

## 2. Reglas del proyecto (el acuerdo escrito)

```text
DOCUMENTO `CONTRIBUTING.md` (sección 14/00 — 1 página):
   │
   ├── cómo se estructura (carpetas, convenciones)
   ├── cómo se pide un cambio: issue → rama → PR
   ├── convención de commits (sección 06)
   ├── qué revisa cada PR (checklist — sección 26 cap.
   │   02 punto 2)
   ├── cómo se decide (mayoría? dueño? — Error 2 si
   │   «ya lo hablaremos»: no hay acuerdo)
   └── qué NO se hace (riesgos: force-push, secrets —
       sección 07/20)
```

```text
CONTROLES CONFIGURADOS (no pedidos — exigidos):
   │
   ├── rama principal protegida: PR obligatorio +
   │   revisor(es) + checks requeridos (sección 20 cap.
   │   06 / 19)
   ├── CODEOWNERS: quién aprueba cada zona (sección 16
   │   cap. 06)
   └── issues con etiquetas (bug, tarea, idea) y
       asignación clara (sección 16)
```

```text
   │
   └── las reglas se PRUEBAN al montar: un PR sin
       revisor debe quedar bloqueado (Error 3 si no lo
       comprobáis: el acuerdo es decoración — Error 5
       sección 03 de esta sección)
```

---

## 3. El flujo que practicarán todos

```text
EL CICLO DEL PROYECTO (cada uno lo ejecuta ≥ 2 veces):
   │
   ├── 1. issue: la idea/tarea con criterio de hecho
   ├── 2. asignación: quién la lleva (sin duplicados)
   ├── 3. rama `feature/...` desde main actualizada
   ├── 4. commits pequeños con convención
   ├── 5. PR: descripción con contexto, enlace al issue,
   │       checklist
   ├── 6. REVISIÓN de otro: comentarios de capa (¿resuelve?
   │       → ¿correcto? → ¿mantenible? — sección 26 cap.
   │       02 punto 2), resolución de hilos
   ├── 7. merge según convención (squash/merge —
   │       decidido en CONTRIBUTING)
   └── 8. issue cerrado + verificación en main (Error 4
       si los issues quedan flotando: el tablero miente)
```

```text
LOS DOS MOMENTOS QUE MÁS APRENDEN:
   │
   ├── el PR con CONFLICTOS (dos tocaron lo mismo): se
   │   resuelven por diálogo y merge — Error 5 si se
   │   resuelven «a la fuerza» (sección 07/08: con
   │   cuidado y verificación)
   │
   └── la revisión DESACORDADA: se discute el código,
       se decide con la regla del CONTRIBUTING (Error
       6 si se recurre a la autoridad — el acuerdo
       estaba para eso)
```

```text
   │
   └── con 3+ contribuciones cruzadas, el historial
       mostrará el verdadero tema: varios autores,
       una historia legible
```

---

## 4. Los papeles (y cómo rotarlos)

```text
PAPELES (pequeños, pero reales):
   │
   ├── autor: escribe el cambio con PR claro
   ├── revisor: capas de revisión + plazo (Error 7 si
   │   «lo veo mañana»: el flujo se enfría)
   └── dueño de release: prepara versión/etiqueta,
       changelog y cierre (sección 26 cap. 02 punto 4)
```

```text
ROTACIÓN (Error 1 sección 25 cap. 03 — sombreros):
   │
   ├── cada uno ejerce los 3 papeles alguna vez
   │
   └── el «dueño de release» rota por entrega — nadie
       es siempre el jefe (Error 2 prevención)
```

```text
   │
   └── medición honesta del proyecto: ¿los PRs se
       revisaron en < 48 h? ¿todos revisaron algo? ¿al
       menos uno rechazó/comentó en serio? (Error 7 —
       la colaboración también se MIDE)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «colaboración» donde todos trabajan solos

**Qué ocurrió:** tres personas con ramas privadas que nunca se cruzaron ni revisaron.

**Por qué:** sin intersección: cada quien su tarea (punto 1).

**Cómo comprobarlo:** PRs con revisor ajeno al autor: ¿cuántos?

**Opciones:** tareas que tocan zonas comunes; asignar revisor de otro.

**Riesgos:** tres repos mentales dentro de uno.

**Solución:** ≥ 2 PRs cruzados (punto 1).

**Cómo se evita:** el reparto de tareas se hace pensando en cruces.

---

### Error 2: acuerdo pendiente de «lo hablamos»

**Qué ocurrió:** un conflicto de estilo sin regla; se resolvió «como pudo» y quedó rencor.

**Por qué:** sin convención escrita (punto 2).

**Cómo comprobarlo:** ¿existe CONTRIBUTING con «cómo se decide»?

**Opciones:** escribir la regla AHORA y aplicarla al caso.

**Riesgos:** cada conflicto reinventa la política.

**Solución:** acuerdo escrito (punto 2).

**Cómo se evita:** el CONTRIBUTING es requisito de entrega.

---

### Error 3: reglas no probadas

**Qué ocurrió:** se configuró la rama protegida… pero nadie verificó que un PR sin revisor quedara bloqueado.

**Por qué:** se dio por hecho (punto 2 Error 3).

**Cómo comprobarlo:** prueba negativa: PR sin revisor y PR sin check.

**Opciones:** corregir configuración y repetir hasta que bloquee.

**Riesgos:** controles que existen en la wiki y no en GitHub.

**Solución:** probar los controles (punto 2).

**Cómo se evita:** checklist de configuración con pruebas negativas.

---

### Error 4: tablero con issues flotantes

**Qué ocurrió:** 14 issues abiertos; la mitad ya estaba hecha desde hace semanas.

**Por qué:** cierre no formaba parte del ciclo (punto 3 Error 4).

**Cómo comprobarlo:** contrastar issues vs. merges/realidad.

**Opciones:** limpieza inicial + «cierra en el PR» como regla.

**Riesgos:** desconfianza en el tablero (Error 2 sección 16 cap. 05).

**Solución:** cierre en el ciclo (punto 3).

**Cómo se evita:** revisión semanal del tablero (10 minutos).

---

### Error 5: conflictos resueltos a la fuerza

**Qué ocurrió:** se hizo force-push sobre el trabajo de otro «para no perder» lo suyo.

**Por qué:** se saltó el proceso delicado (sección 07/08).

**Cómo comprobarlo:** registros: ¿force-push en rama compartida?

**Opciones:** recuperar lo perdido del historial si existe; reconstruir; regla: en ramas compartidas jamás (Error 8 sección 07 cap. 02).

**Riesgos:** trabajo destruido y desconfianza.

**Solución:** conflictos con diálogo y cuidado (punto 3).

**Cómo se evita:** prohibir force-push en ramas compartidas (protección).

---

### Error 6: revisión resuelta por autoridad

**Qué ocurrió:** el desacuerdo se zanjó con «lo decido yo» sin la regla aplicada.

**Por qué:** acuerdo no usado (punto 3 Error 6).

**Cómo comprobarlo:** ¿el CONTRIBUTING tiene cómo se decide? ¿se citó?

**Opciones:** citar la regla y decidirla con ella; si no existe, añadirla.

**Riesgos:** resentimiento y bypass silencioso.

**Solución:** el acuerdo desempata (punto 3).

**Cómo se evita:** toda decisión de conflicto cita su regla.

---

### Error 7: revisión sin plazo

**Qué ocurrió:** PRs esperando días; el proyecto se paró en «esperando revisión».

**Por qué:** sin SLA ni rotación (punto 4).

**Cómo comprobarlo:** mediana «PR → primera revisión».

**Opciones:** acordar 48 h, recordatorios, revisor asignado en automático.

**Riesgos:** muerte por espera (Error 6 sección 02 cap. 26).

**Solución:** plazo y rotación (punto 4).

**Cómo se evita:** métrica de antigüedad en la retro del proyecto.

---

## 6. Práctica guiada

### Objetivo

Entregar una release colaborativa: 3+ contribuciones cruzadas, controles probados y acuerdo escrito.

### Paso 1: forma el equipo

1. 2–4 personas + fecha de entrega. ¿Si no hay equipo? Consigue al menos un revisor externo (punto 1).

### Paso 2: el acuerdo

1. `CONTRIBUTING.md` con las 6 secciones del punto 2 (1 página).

### Paso 3: los controles

1. Rama protegida + revisores + checks requeridos + CODEOWNERS + etiquetas (punto 2).
2. Pruebas negativas: PR sin revisor → bloqueado; PR con check rojo → bloqueado (punto 2 Error 3).

### Paso 4: reparto

1. Tareas en issues con cruces reales (dos personas tocarán zonas comunes — Error 1).

### Paso 5: ejecuta el ciclo ×3

```text
issue → rama → PR → revisión ajena → resolución →
merge → issue cerrado
```

1. Al menos un conflicto o desacuerdo: resuélvelo por el acuerdo (punto 3).

### Paso 6: release

1. Dueño rotativo: changelog + etiqueta + notas (punto 4 / sección 26 cap. 02).

### Paso 7: entrega

```text
Checklist:
   [ ] CONTRIBUTING completo
   [ ] controles probados en negativo
   [ ] ≥ 3 PRs con revisor ≠ autor
   [ ] issues abiertos = trabajo real pendiente
   [ ] release con dueño y notas
   [ ] retrospectiva: ¿qué fricción dolió y qué regla
       faltaba?
```

### Resultado esperado

Release colaborativa con historial multi-autor, controles verificados y acuerdo escrito que funcionó en la práctica.

### Conclusión esperada

La colaboración no es «trabajar a la vez en un repo»: es un conjunto de acuerdos y controles que permiten disentir sin destruir el trabajo — y eso solo se aprende haciéndolo con gente.

---

## 7. Nivel profesional + resumen

### 7.1. Del proyecto al equipo real

```text
   │
   ├── lo que practicaste es literalmente el onboarding
   │   de un equipo nuevo: CONTRIBUTING, controles,
   │   flujo y papeles (sección 16/18)
   │
   ├── papeles rotativos = la semilla de CODEOWNERS y
   │   gobernanza que ya usaste (sección 25 cap. 03)
   │
   ├── la retrospectiva de fricciones es la retro real:
   │   «qué regla faltaba» es la pregunta de mejora
   │   continua (sección 23 cap. 01)
   │
   └── con esto, el Proyecto final (sección 28) solo
       añade alcance — la forma de trabajar ya la
       dominas
```

### 7.2. Resumen

En este capítulo aprendiste que:

* un proyecto colaborativo se mide por intersección: PRs revisados por otros, no por tareas paralelas;
* el acuerdo escrito (CONTRIBUTING) desempata y evita que cada conflicto reinvente la política;
* los controles se exigen en la plataforma y se prueban en negativo;
* el ciclo completo (issue → PR → revisión ajena → merge → cierre) se ejecute ≥ 3 veces con papeles rotativos;
* los errores típicos (colaboración de aislados, acuerdos orales, controles decorativos, tablero mentiroso, force-push, autoridad, revisión sin plazo) se previenen con acuerdo, pruebas y métricas;
* la progresión: el Proyecto final hereda esta forma de trabajar y añade alcance.

La idea principal es:

> **El repositorio colaborativo es donde el flujo deja de ser tutorial y se vuelve comportamiento: las reglas que sobreviven a un desacuerdo real son las únicas que valen la pena tener.**

---

## Próximo paso

Has completado la sección de proyectos prácticos.

Continúa con el cierre:

[`README.md`](README.md)
