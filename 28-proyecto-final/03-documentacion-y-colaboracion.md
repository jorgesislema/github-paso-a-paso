# Documentación y colaboración

## Introducción

Un proyecto sin documentación solo puede ser entendido por su autor; un proyecto documentado **se puede heredar**. Este capítulo construye la cara visible del Proyecto final: un README que funciona como puerto de entrada, docs que responden las preguntas reales, y los mecanismos de colaboración (issues, plantillas, responsabilidades) que demuestran que el repo está pensado para más de una persona. Aquí se aplican las secciones 14 y 16 con criterio de evaluación: lo que se documenta, se prueba.

---

## Mapa conceptual de este capítulo

```text
Documentación y colaboración
       │
       ├── 1. El README como puerto de entrada
       ├── 2. La carpeta docs/ (lo que sí documentar)
       │   ├── 3. Issues y plantillas que estructuran
       │   └── 4. Responsabilidades (CODEOWNERS) y
       │       contribución
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. El README como puerto de entrada

```text
SECCIONES DEL README (sección 14 cap. 02 — el orden
que se espera):
   │
   ├── 1. QUÉ ES: una frase + para quién (Error 1 si
   │   empieza con «este proyecto» y nada más)
   ├── 2. CÓMO EJECUTAR: requisitos + instalación +
   │   UN comando probado (Error 2 si nunca lo
   │   probaste en limpio — Error 2 sección
   │   04 cap. 27: «en mi máquina»)
   ├── 3. CÓMO USAR: 1 ejemplo real con salida esperada
   ├── 4. CÓMO CONTRIBUIR: enlace a CONTRIBUTING (punto
   │   4)
   ├── 5. CÓMO FUNCIONA POR DENTRO: arquitectura breve
   │   o diagrama (sección 14 cap. 06)
   ├── 6. ESTADO/VERSION: badges del CI + última versión
   │   (Error 3 sección 03 cap. 27 — el badge
   │   miente si el check no bloquea)
   └── 7. LICENCIA (si aplica) y contactos/roles
```

```text
LA PRUEBA DEL README (Error 3 si no la pasó):
   │
   └── «tour de 15 minutos»: alguien (o tu yo de
       mañana, sin contexto) ejecuta el proyecto SOLO
       con el README — si no lo logra, el README está
       incompleto
```

```text
   │
   └── en la defensa, el README es la PRIMERA cosa que
       se abre: guárdalo impecable desde la semana 1 y
       mantenlo en cada PR que cambie comportamiento
       (Error 4 si se documenta «al final»: al final
       nadie lo documenta)
```

---

## 2. La carpeta docs/ (lo que sí documentar)

```text
LO QUE VA EN DOCS/ (sección 14 — y SOLO eso):
   │
   ├── decisiones/  → ADRs (sección 25 cap. 06 — al
   │   menos los 2 del diseño + los que nazcan)
   ├── flujo.md     → cómo trabajáis (ramas, PRs,
   │   convención — sección 26 cap. 01 punto 3)
   ├── rubrica.md   → criterios del proyecto (diseño
   │   punto 4)
   └── guías        → lo que un usuario/colaborador
       pregunta 2 veces (sección 14:
       la segunda pregunta es documentación)
```

```text
LO QUE NO VA (Error 5):
   │
   ├── notas personales, borradores, el histórico del
   │   curso — el docs/ del proyecto documenta EL
   │   PROYECTO
   │
   └── duplicados del README (lo importante se ENLAZA,
       no se copia — Error 2 — sección 14
       cap. 04: documentos que se contradicen)
```

```text
   │
   └── regla de mantenimiento: si un doc miente, es
       peor que no tenerlo (Error 7 — Error
       3 sección 25 cap. 05: docs que mienten)
```

---

## 3. Issues y plantillas que estructuran

```text
PLANTILLAS (sección 16 cap. 06 / sección 18):
   │
   ├── plantilla de BUG: qué esperabas · qué pasó ·
   │   pasos · entorno — y etiqueta automática (Error
   │   8 si los bugs llegan como «no funciona»)
   │
   ├── plantilla de TAREA/FEATURE: contexto · criterio
   │   de hecho · fuera de alcance (sección 01 de esta
   │   sección — alcance escrito)
   │
   └── PR template: checklist (pruebas, docs, sin
       secretos) — ya lo usaste en el capítulo 02
```

```text
DISCIPLINA DEL TABLERO (Error 1 capítulo anterior):
   │
   ├── etiquetas: bug · tarea · idea · en curso (mínimo)
   ├── asignación: cada issue con dueño cuando está en
   │   curso (sección 16 cap. 05)
   └── cierre con enlace al PR (evidencia trazable)
```

```text
   │
   └── el tablero es la DEMOSTRACIÓN de planificación:
       en la defensa, mostrar «de aquí salieron los 6
       PRs» es evidencia de flujo gestionado (Error 8
       si el tablero está vacío o es un cementerio)
```

---

## 4. Responsabilidades (CODEOWNERS) y contribución

```text
CODEOWNERS MÍNIMO (sección 16 cap. 06):
   │
   ├── docs/ y README → quien mantiene docs
   ├── src/core → quien diseña
   └── .github/ y workflows → quien mantiene el flujo
       (Error 9 si nadie es dueño del flujo: lo
       rompes sin que nadie lo note)
```

```text
CONTRIBUTING (1 página — Error 10 si no existe):
   │
   ├── el ciclo (issue → rama → PR → revisión) — el
   │   mismo del capítulo 02
   ├── convención de commits y de ramas
   ├── «cómo se decide» (sección 02 cap. 27 Error 2)
   └── qué NO hacer (force-push, secretos, commits
       gigantes)
```

```text
   │
   └── con CODEOWNERS + CONTRIBUTING + plantillas, el
       proyecto demuestra GOBERNANZA mínima — el mismo
       oficio de la sección 25 cap. 03, en miniatura
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: README sin «qué es»

**Qué ocurrió:** el evaluador no supo qué hacía el proyecto en los primeros 30 segundos.

**Por qué:** orden y foco (punto 1).

**Cómo comprobarlo:** lee solo las 3 primeras líneas: ¿se entiende?

**Opciones:** reescribir el encabezado: qué es, para quién, estado.

**Riesgos:** mala primera impresión en la defensa.

**Solución:** el orden del punto 1.

**Cómo se evita:** revisar el README como se revisa un PR.

---

### Error 2: comandos del README nunca probados

**Qué ocurrió:** la instalación no funcionaba «en limpio»: faltaba un requisito.

**Por qué:** se documentó de memoria (punto 1 Error 2).

**Cómo comprobarlo:** clonar en una carpeta aparte y ejecutar el README literalmente.

**Opciones:** corregir el README con lo que la instalación real requiere.

**Riesgos:** «no funciona» en la primera impresión.

**Solución:** README probado en limpio (punto 1).

**Cómo se evita:** cada cambio de instalación actualiza README en el mismo PR.

---

### Error 3: badges decorativos

**Qué ocurrió:** el badge de CI era verde… con un check que no requería nada.

**Por qué:** insignia sin puerta (punto 1 Error 3).

**Cómo comprobarlo:** revisar rama requerida + prueba negativa.

**Opciones:** arreglar la puerta antes que el badge.

**Riesgos:** falsa confianza en la evaluación.

**Solución:** badge que cuenta la verdad (punto 1).

**Cómo se evita:** la evidencia manda: puerta primero.

---

### Error 4: documentación «para el final»

**Qué ocurrió:** el README quedó con «en construcción» al entregar.

**Por qué:** secuencia invertida (punto 1 Error 4).

**Cómo comprobarlo:** fecha del último commit del README vs. del código.

**Opciones:** documentar hoy lo hecho; regla: PR con cambio de comportamiento toca README.

**Riesgos:** proyecto inentendible.

**Solución:** mantenimiento continuo (punto 1).

**Cómo se evita:** checklist del PR incluye «docs si cambia el uso».

---

### Error 5: docs/ con basura personal

**Qué ocurrió:** notas del curso, borradores y 12 documentos contradictorios en docs/.

**Por qué:** sin criterio de pertenencia (punto 2).

**Cómo comprobarlo:** lista de docs/ — ¿cada uno documenta EL proyecto?

**Opciones:** archivar/borrar lo que no corresponde; los ADRs van en su carpeta.

**Riesgos:** nadie confía en el docs/.

**Solución:** docs/ solo del proyecto (punto 2).

**Cómo se evita:** criterio escrito en CONTRIBUTING.

---

### Error 6: duplicados que se contradicen

**Qué ocurrió:** el README decía una instalación y docs/guia.md otra.

**Por qué:** copia en vez de enlace (punto 2 Error 6).

**Cómo comprobarlo:** buscar los mismos pasos en dos documentos.

**Opciones:** una fuente + enlaces.

**Riesgos:** el usuario ejecuta el documento equivocado.

**Solución:** fuente única (punto 2).

**Cómo se evita:** revisión de docs duplicados en la entrega.

---

### Error 7: documentación que miente

**Qué ocurrió:** docs/ describía una estructura que el código ya no tenía.

**Por qué:** docs sin mantenimiento (Error 7 punto 2).

**Cómo comprobarlo:** contrastar docs vs. realidad en la entrega.

**Opciones:** actualizar o borrar (lo obsoleto es tóxico).

**Riesgos:** desconfianza permanente.

**Solución:** o actualizado o retirado (punto 2).

**Cómo se evita:** «¿sigue siendo cierto?» en la revisión del PR que cambia estructura.

---

### Error 8: tablero vacío o cementerio

**Qué ocurrió:** cero issues o 30 issues muertos; el flujo no se ve planificado.

**Por qué:** sin disciplina de tablero (punto 3).

**Cómo comprobarlo:** issues vs. PRs vs. realidad.

**Opciones:** sembrar los issues del plan (cap. 01) y limpiar; cerrar con enlace.

**Riesgos:** pierdes la evidencia de planificación.

**Solución:** tablero trazable (punto 3).

**Cómo se evita:** revisión semanal de 10 minutos.

---

### Error 9: sin dueños de zonas

**Qué ocurrió:** un workflow se rompió y nadie sabía a quién preguntar.

**Por qué:** CODEOWNERS ausente (punto 4).

**Cómo comprobarlo:** ¿existe .github/CODEOWNERS? ¿cubre workflows y src?

**Opciones:** crearlo con las 3 zonas (punto 4).

**Riesgos:** zonas huérfanas (Error 1 sección 03 cap. 03).

**Solución:** responsabilidades explícitas (punto 4).

**Cómo se evita:** checklist de entrega incluye CODEOWNERS.

---

## 6. Práctica guiada

### Objetivo

Entregar la cara documental y de colaboración: README probado, docs/ ordenado, tablero y dueños.

### Paso 1: README completo

1. Las 7 secciones del punto 1. Ejecútalo en limpio (punto 1 Error 2) y corrige.

### Paso 2: docs/ ordenado

1. decisiones/ (2 ADRs), flujo.md, rubrica.md, 1 guía si aplica. Borra lo que no es del proyecto (punto 2).

### Paso 3: plantillas

1. Issue de bug + de tarea + PR template (punto 3) y úsalos en los próximos issues.

### Paso 4: tablero

1. El plan del capítulo 01 como issues con etiquetas y criterios (punto 3).

### Paso 5: dueños

1. CODEOWNERS con 3 zonas + CONTRIBUTING de 1 página (punto 4).

### Paso 6: prueba de 15 minutos

```text
Tour con el README solo:
   [ ] entendí qué es en 30 s
   [ ] ejecuté con un comando
   [ ] supe contribuir
   [ ] supe dónde están decisiones y flujo
```

### Resultado esperado

README probado, docs/ limpio, tablero trazable y responsabilidades escritas.

### Conclusión esperada

La documentación del Proyecto final no es adorno: es el protocolo que permite que el flujo, las decisiones y la calidad se VERIFIQUEN sin pedir explicaciones — y eso es exactamente lo que se evalúa.

---

## 7. Nivel profesional + resumen

### 7.1. Documentación a escala

```text
   │
   ├── «documentación como código»: vive en el repo, se
   │   revisa en PR, se versiona (sección 14)
   │
   ├── README + CONTRIBUTING + CODEOWNERS = el
   │   onboarding de 15 minutos que toda organización
   │   quiere (sección 16/18)
   │
   ├── ADRs vivos: la memoria de decisiones que un equipo
   │   necesita al crecer (sección 25/26)
   │
   └── métricas: edad de docs sin revisar, % PRs con
       docs actualizados, issues con dueño (Error 8
       prevención)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el README en orden (qué, ejecutar, usar, contribuir, cómo funciona, estado) se prueba en limpio y se mantiene con cada cambio;
* docs/ solo documenta el proyecto: decisiones, flujo, rúbrica y guías — sin duplicados ni basura;
* plantillas y tablero estructuran la colaboración y demuestran planificación trazable;
* CODEOWNERS + CONTRIBUTING = gobernanza mínima en miniatura;
* los errores típicos (README opaco, comandos sin probar, badges mentirosos, docs de final, basura, duplicados, docs que mienten, tablero muerto, zonas huérfanas) se previenen con mantenimiento y prueba;
* toda esta evidencia alimenta directamente la defensa del proyecto.

La idea principal es:

> **La documentación es el protocolo de verificación del proyecto: lo que un extraño puede comprobar por sí solo con el README es exactamente lo que tu proyecto puede demostrar.**

---

## Próximo paso

Documentación y colaboración listas.

Ahora la fábrica: GitHub Actions, CI/CD y seguridad en el Proyecto final.

Continúa con:

[`04-actions-ci-cd-y-seguridad.md`](04-actions-ci-cd-y-seguridad.md)
