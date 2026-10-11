# DiseÃ±o de workflows y estrategias de ramas

## IntroducciÃ³n

El paso de nivel no consiste en conocer mÃ¡s comandos: consiste en **diseÃ±ar el flujo completo de un equipo** â€” desde quÃ© rama nace hasta quÃ© pasa en producciÃ³n â€” eligiendo cada pieza por contexto, no por costumbre. Este capÃ­tulo trata workflow y estrategia de ramas como una sola decisiÃ³n: la forma del flujo determina cÃ³mo se revisa, se prueba, se libera y se recupera un equipo. Pasa en revista todo lo estudiado (secciones 07, 17, 19, 22) y enseÃ±a a escoger con criterio senior.

---

## Mapa conceptual de este capÃ­tulo
```mermaid
mindmap
  root((DiseÃ±o de workflows y estrategias de ramas))
    1. La pregunta senior (contexto, no receta)
    2. Las estrategias como familia (cuÃ¡ndo cada una)
    3. DiseÃ±ar el workflow completo (del issue al despliegue)
      4. Calidad del flujo (quÃ© lo hace lento)
      5. RecuperaciÃ³n escrita en el diseÃ±o
    6. Errores comunes con diagnÃ³stico completo
    7. PrÃ¡ctica guiada
    8. Nivel profesional + resumen
```

---

## 1. La pregunta senior (contexto, no receta)

```text
EL CAMBIO DE PREGUNTA (etapa 26 â€” lo guÃ­a todo):
    â”‚
    â”œâ”€â”€ antes: Â«Â¿QuÃ© comando uso?Â»
    â”‚
    â””â”€â”€ ahora: Â«Â¿QuÃ© ESTRATEGIA resuelve mejor este
        problema para ESTE equipo y ESTE proyecto?Â»
```

```text
FACTORES QUE DECIDEN EL FLUJO:
    â”‚
    â”œâ”€â”€ ritmo de release: Â¿a diario Â· semanal Â· mensual
    â”‚   Â· por evento? (secciÃ³n 17/22)
    â”œâ”€â”€ riesgo: Â¿quÃ© pasa si algo malo llega a
    â”‚   producciÃ³n? (fintech â‰  blog)
    â”œâ”€â”€ tamaÃ±o del equipo y solapamiento de ramas
    â”œâ”€â”€ disciplina real del equipo (Error 1: elegir el
    â”‚   flujo mÃ¡s estricto que el equipo NO va a
    â”‚   cumplir)
    â””â”€â”€ automatizaciÃ³n disponible: el flujo solo escala
        si el CI lo sostiene (secciÃ³n 19/22)
```

```text
    â”‚
    â””â”€â”€ la estrategia es una HIPÃ“TESIS con contexto â€”
        se escribe, se prueba y se revisa (Error 2 si
        nadie sabe cuÃ¡l es la Â«oficialÂ»)
```

---

## 2. Las estrategias como familia (cuÃ¡ndo cada una)

```text
FAMILIA (secciÃ³n 17 â€” revisada con Â«cuÃ¡ndoÂ»):
    â”‚
    â”œâ”€â”€ trunk/development directo: fluye rÃ¡pido,
    â”‚   exige CI fortÃ­simo, feature flags, equipo
    â”‚   disciplinado y releases frecuentes (Error 3 si
    â”‚   se adopta sin esa base)
    â”‚
    â”œâ”€â”€ una rama de desarrollo (dev) + ramas de feature:
    â”‚   equipo medio que quiere integraciÃ³n continua
    â”‚   sin sorpresas de main
    â”‚
    â”œâ”€â”€ release branch (release/X): releases predecibles
    â”‚   y estables â€” clÃ¡sico de versionado mensual/semanal
    â”‚   (secciÃ³n 17 cap. 05)
    â”‚
    â”œâ”€â”€ ramas por release cortas (release â†’ hotfix â†’
    â”‚   volver): mantenimiento de versiones viejas
    â”‚   (secciÃ³n 17 cap. 06)
    â”‚
    â””â”€â”€ GitFlow completo: varios productos con versiones
        largas mantenidas â€” hoy minoritario (Error 4 si
        se copia por completitud, no por necesidad)
```

```text
SEÃ‘AL DE ELECCIÃ“N:
    â”‚
    â”œâ”€â”€ Â«liberamos cuando estÃ¡ listo y a menudoÂ» â†’
    â”‚   trunk/flags o dev simple
    â”œâ”€â”€ Â«liberamos cada jueves y hay que arreglar lo
    â”‚   anteriorÂ» â†’ release branch
    â””â”€â”€ Â«mantenemos 3 versiones soportadasÂ» â†’ ramas de
        mantenimiento (secciÃ³n 17 cap. 06)
```

```text
    â”‚
    â””â”€â”€ la elecciÃ³n correcta es la MÃS SIMPLE que
        cubre tu riesgo (Error 4: complejidad heredada
        de un problema que no tienes)
```

---

## 3. DiseÃ±ar el workflow completo (del issue al despliegue)
```mermaid
flowchart TD
    A["1. trabajo: issue/board quiÃ©n nace y cÃ³mo se asigna"] --> B["2. rama: nombre, origen, vida"]
    B --> C["3. commit: convenciÃ³n â€” Â¿exige tipo? Â¿issue?"]
    C --> D["4. PR: checklist, reviewers, gates"]
    D --> E["5. CI: quÃ© corre, cuÃ¡nto tarda, quÃ© bloquea"]
    E --> F["6. merge: Â¿squash, merge, rebase? Â¿por quÃ©?"]
    F --> G["7. release: Â¿automÃ¡tico al merge? Â¿etiqueta? Â¿manual?"]
    G --> H["8. despliegue: a dÃ³nde llega primero (staging)"]
    H --> I["9. post: observabilidad + rollback listo"]
```

```text
    â”‚
    â””â”€â”€ el workflow se DIBUJA (diagrama en docs) y se
        cita: Â«Â¿dÃ³nde estÃ¡ escrito nuestro flujo?Â» es
        una pregunta senior (Error 5 si la respuesta es
        Â«como siempre se hizoÂ»)
```

---

## 4. Calidad del flujo (quÃ© lo hace lento o frÃ¡gil)

```text
MÃ‰TRICAS DEL FLUJO (secciÃ³n 24 cap. 06 â€” solo lo
medido se mejora):
    â”‚
    â”œâ”€â”€ lead time: issue â†’ producciÃ³n
    â”œâ”€â”€ tiempo de PR abierto a revisiÃ³n (Error 5 de
    â”‚   secciÃ³n 25 cap. 05)
    â”œâ”€â”€ duraciÃ³n de CI por PR (Error 5 secciÃ³n 04 de
    â”‚   25)
    â””â”€â”€ frecuencia de releases y su tasa de fallo
```

```text
SÃNTOMAS Y REMEDIOS (senior = diagnosticar):
    â”‚
    â”œâ”€â”€ PRs grandes y lentos â†’ parte el trabajo (secciÃ³n
    â”‚   15 cap. 01 Error 1) + lÃ­mite de abiertos
    â”œâ”€â”€ CI rojo constante â†’ estabilizar antes de aÃ±adir
    â”‚   puertas (secciÃ³n 19 cap. 06)
    â”œâ”€â”€ merges conflictivos â†’ integrar mÃ¡s a menudo
    â”‚   (Error 3 â€” pull frecuente, secciÃ³n 17 cap. 04)
    â””â”€â”€ releases manuales y heroicos â†’ automatizar
        release/rollback (secciÃ³n 22 cap. 06)
```

```text
    â”‚
    â””â”€â”€ el senior no aÃ±ade proceso: QUITA FRICCIÃ“N de
        lo que ya funciona y ENDURECE donde rompe (Error
        6 si la respuesta a todo es Â«mÃ¡s reglasÂ»)
```

---

## 5. RecuperaciÃ³n escrita en el diseÃ±o

```text
TODO FLUJO DISEÃ‘ADO TRAE SU VUELTA ATRÃS:
    â”‚
    â”œâ”€â”€ Â«Â¿cÃ³mo se revierte un release malo?Â» â€”
    â”‚   respuesta escrita y probada (secciÃ³n 22 cap.
    â”‚   06 â€” Error 7 si no existe)
    â”‚
    â”œâ”€â”€ Â«Â¿cÃ³mo se recupera main si alguien hace
    â”‚   daÃ±o?Â» â€” protecciÃ³n + reset coordinado (secciÃ³n
    â”‚   08/16)
    â”‚
    â””â”€â”€ Â«Â¿cÃ³mo se recupera el repo si desaparece todo?Â»
        â€” respaldo y espejo (punto siguiente: secciÃ³n 04
        Error 5, cap. 03 disaster)
```

```text
    â”‚
    â””â”€â”€ un flujo sin plan de vuelta es una autopista
        sin barandilla: hasta que hace falta (Error 7)
```

---

## 6. Errores comunes con diagnÃ³stico completo

### Error 1: estrategia mÃ¡s estricta que el equipo

**QuÃ© ocurriÃ³:** GitFlow completo adoptado; en dos meses todos trabajaban en main Â«para no frenarÂ».

**Por quÃ©:** se eligiÃ³ por teorÃ­a, no por disciplina real (punto 1).

**CÃ³mo comprobarlo:** Â¿se cumplen los pasos del flujo en los Ãºltimos 20 PRs?

**Opciones:** simplificar a la estrategia que SÃ se cumple; o formar/automatizar hasta poder sostener la estricta.

**Riesgos:** el flujo oficial deja de reflejar la realidad (peor que ninguno).

**SoluciÃ³n:** la mÃ¡s simple que cubra el riesgo (punto 1/2).

**CÃ³mo se evita:** auditar disciplina antes de elegir (punto 1).

---

### Error 2: nadie sabe cuÃ¡l es la estrategia oficial

**QuÃ© ocurriÃ³:** tres patrones de rama conviviendo segÃºn quiÃ©n abrÃ­a el PR.

**Por quÃ©:** no se escribiÃ³ ni comunicÃ³ (punto 1/3).

**CÃ³mo comprobarlo:** pregunta a 3 miembros: Â«Â¿de dÃ³nde sale tu rama?Â» â€” respuestas distintas = Error.

**Opciones:** escribir el flujo en un diagrama de una pÃ¡gina; enlazarlo en el PR template.

**Riesgos:** inconsistencia y conflictos evitables.

**SoluciÃ³n:** flujo dibujado y citado (punto 3).

**CÃ³mo se evita:** la plantilla de repo lo incluye (secciÃ³n 18).

---

### Error 3: trunk directo sin base

**QuÃ© ocurriÃ³:** sin feature flags ni CI fortaleza, cada merge Â«experimentalÂ» rompÃ­a a todos.

**Por quÃ©:** se copiÃ³ el modelo sin sus prerrequisitos (punto 2).

**CÃ³mo comprobarlo:** Â¿hay flags? Â¿CI < presupuesto y estable? Â¿equipo entrenado?

**Opciones:** aÃ±adir la base (flags, CI) o retroceder a rama de integraciÃ³n.

**Riesgos:** producciÃ³n como sala de pruebas.

**SoluciÃ³n:** prerrequisitos primero (punto 2).

**CÃ³mo se evita:** checklist de adopciÃ³n de estrategia.

---

### Error 4: GitFlow Â«porque es el completoÂ»

**QuÃ© ocurriÃ³:** proyecto con release quincenal heredÃ³ release/hotfix/develop/feature â€” cuatro ramas vivas para dos personas.

**Por quÃ©:** complejidad copiada de un problema inexistente (punto 2).

**CÃ³mo comprobarlo:** Â¿cuÃ¡ntas ramas Â«de procesoÂ» viven hoy? Â¿quÃ© problema resuelve cada una?

**Opciones:** eliminar las que no resuelven; simplificar (secciÃ³n 17 cap. 03 Error 1).

**Riesgos:** coste permanente en coordinaciÃ³n.

**SoluciÃ³n:** complejidad proporcional al riesgo (punto 2).

**CÃ³mo se evita:** revisiÃ³n anual del flujo con la etapa y ritmo reales.

---

### Error 5: workflow no documentado

**QuÃ© ocurriÃ³:** el flujo existÃ­a solo en la cabeza del lÃ­der; al irse, el equipo reinventÃ³.

**Por quÃ©:** nada escrito (punto 3).

**CÃ³mo comprobarlo:** Â¿dÃ³nde estÃ¡ el diagrama? URL o no existe.

**Opciones:** escribirlo hoy con el recorrido del punto 3.

**Riesgos:** pÃ©rdida de continuidad.

**SoluciÃ³n:** recorrido completo dibujado (punto 3).

**CÃ³mo se evita:** revisar el diagrama cuando cambia el flujo (Error 2).

---

### Error 6: Â«mÃ¡s reglasÂ» como Ãºnica respuesta

**QuÃ© ocurriÃ³:** cada incidente aÃ±adÃ­a una aprobaciÃ³n; los PRs tardaron dÃ­as en empezar.

**Por quÃ©:** se confundiÃ³ endurecer con frenar (punto 4).

**CÃ³mo comprobarlo:** Â¿se midiÃ³ el efecto en lead time tras cada regla?

**Opciones:** medir; retirar reglas sin efecto; automatizar lo automatizable (secciÃ³n 23 cap. 01).

**Riesgos:** burocracia lenta y bypass.

**SoluciÃ³n:** quitar fricciÃ³n, endurecer donde rompe (punto 4).

**CÃ³mo se evita:** toda regla nueva con mÃ©trica y fecha de revisiÃ³n (secciÃ³n 24 cap. 06).

---

### Error 7: flujo sin plan de vuelta

**QuÃ© ocurriÃ³:** un release malo obligÃ³ a improvisar un hotfix en caliente sin probar rollback.

**Por quÃ©:** la recuperaciÃ³n no estaba en el diseÃ±o (punto 5).

**CÃ³mo comprobarlo:** Â«Â¿cÃ³mo se revierte?Â» â€” Â¿respuesta escrita y probada alguna vez?

**Opciones:** documentar el procedimiento y practicarlo en simulacro (secciÃ³n 24 cap. 05).

**Riesgos:** improvisaciÃ³n bajo presiÃ³n.

**SoluciÃ³n:** vuelta atrÃ¡s escrita (punto 5).

**CÃ³mo se evita:** checklist de diseÃ±o de flujo con el paso 9 obligatorio (punto 3).

---

## 7. PrÃ¡ctica guiada

### Objetivo

DiseÃ±ar (o rediseÃ±ar) el flujo completo de TU equipo con criterio senior.

### Paso 1: contexto

```text
Tu equipo/proyecto:
    â”‚
    â”œâ”€â”€ frecuencia de release real: ____
    â”œâ”€â”€ riesgo de cada release: ____
    â”œâ”€â”€ disciplina actual: ____
    â””â”€â”€ automatizaciÃ³n: ____
```

### Paso 2: elige estrategia

1. Con la familia del punto 2, elige la MÃS SIMPLE que cubra tu riesgo y anota por quÃ© (Error 2 â€” queda escrito).

### Paso 3: dibuja el recorrido

1. Completa los 9 pasos del punto 3 para tu equipo. Â¿DÃ³nde duele hoy?

### Paso 4: mÃ©tricas

1. Anota la lÃ­nea base: lead time, PR abierto a revisiÃ³n, CI por PR, frecuencia de release (Error 6 prevenciÃ³n).

### Paso 5: la vuelta atrÃ¡s

1. Escribe: Â«Release malo â†’ cÃ³mo se revierteÂ» (procedimiento concreto con tus comandos/acciones).

### Paso 6: publica

1. Diagrama + estrategia + vuelta atrÃ¡s en `docs/flujo.md`, enlazado desde README y PR template.

### Resultado esperado

Flujo elegido por contexto y escrito: 9 pasos, mÃ©tricas con lÃ­nea base y rollback probado en papel.

### ConclusiÃ³n esperada

El flujo senior no es el mÃ¡s famoso: es el que el equipo puede cumplir, medir y revertir â€” y que cualquiera puede leer en un diagrama sin preguntarle a nadie.

### Ejercicio de transferencia
Toma el flujo de otro proyecto conocido (por ejemplo, un proyecto de cÃ³digo abierto que uses) y analÃ­zalo usando los mismos nueve pasos: identifica quiÃ©n nace el trabajo, cÃ³mo se nombran las ramas, etc. Entregable: un documento que describa el flujo de ese proyecto y seÃ±ale una mejora que aplicarÃ­as con criterio senior.

---

## 8. Nivel profesional + resumen

### 8.1. Flujos a escala

```text
    â”‚
    â”œâ”€â”€ estandarizar el NÃšCLEO (rama base, PR, CI,
    â”‚   release) y dejar margen por tipo de componente
    â”‚   (piso y margen â€” secciÃ³n 25 cap. 04 punto 5)
    â”‚
    â”œâ”€â”€ estrategia documentada POR EQUIPO en su fase
    â”‚   (crecimiento vs. mantenimiento â€” secciÃ³n 25
    â”‚   cap. 05 punto 1)
    â”‚
    â”œâ”€â”€ mÃ©tricas del flujo en cartera: lead time y
    â”‚   frecuencia por repo (Error 6 prevenciÃ³n a
    â”‚   escala)
    â”‚
    â”œâ”€â”€ releases como producto: calendario, notas,
    â”‚   rollback (secciÃ³n 17 cap. 06 / 22 cap. 06)
    â”‚
    â””â”€â”€ revisiÃ³n semestral del flujo: Â¿sigue cubriendo
        el riesgo actual? (punto 1 â€” contexto cambiÃ³)
```

### 8.2. Resumen

En este capÃ­tulo aprendiste que:

* la pregunta senior es de contexto: estrategia para ESTE equipo y proyecto, no receta;
* la familia de estrategias (trunk, dev, release, mantenimiento, GitFlow) se elige por ritmo, riesgo y disciplina â€” la mÃ¡s simple que cubra;
* el workflow completo tiene 9 pasos, del issue a la observabilidad, dibujados y citados;
* la calidad del flujo se mide (lead time, PRs, CI, releases) y se mejora quitando fricciÃ³n y endureciendo donde rompe;
* la recuperaciÃ³n (rollback del release, de main, del repo) es parte del diseÃ±o, no un apÃ©ndice;
* los errores tÃ­picos (estrategia imposible, flujo oral, trunk sin base, GitFlow copiado, workflow invisible, Â«mÃ¡s reglasÂ», vuelta atrÃ¡s improvisada) se previenen con contexto, documento y mÃ©tricas;
* a nivel profesional: nÃºcleo estandarizado con margen y revisiÃ³n semestral.

La idea principal es:

> **DiseÃ±ar un flujo no es elegir ramas: es decidir cÃ³mo este equipo concreto convierte trabajo en valor confiable â€” y cÃ³mo vuelve a estar confiable cuando algo sale mal.**

---


## Autopreguntas de cierre
Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:
1. ¿Cuál es la pregunta senior que guía el diseño de workflows y estrategias de ramas?
2. ¿Cómo se elige la estrategia de ramificación más apropiada para un equipo?
3. ¿Qué componentes forman el flujo completo desde el issue hasta el despliegue?
4. ¿Cómo se mide la calidad del flujo y qué se hace para mejorarla?
5. ¿Por qué es importante incluir el plan de vuelta (rollback) en el diseño del flujo?
6. ¿Cómo se evita caer en errores comunes como elegir una estrategia sin base real?

## PrÃ³ximo paso

Ya diseÃ±as flujos con criterio.

Ahora las dos prÃ¡cticas que lo sostienen: revisar cÃ³digo y gestionar releases.

ContinÃºa con:

[`02-revision-de-codigo-y-gestion-de-releases.md`](02-revision-de-codigo-y-gestion-de-releases.md)
