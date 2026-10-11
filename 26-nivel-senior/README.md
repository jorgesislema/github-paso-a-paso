# 26 â€” Pensamiento de nivel senior

## Bienvenido a esta secciÃ³n

Has estudiado comandos, flujos, seguridad y operaciÃ³n; aquÃ­ todo se ensambla en una sola capacidad: **decidir mejor con contexto**. La pregunta cambia de Â«Â¿quÃ© comando uso?Â» a Â«Â¿quÃ© estrategia resuelve mejor este problema para este equipo y este proyecto?Â». Esta secciÃ³n no agrega herramientas nuevas: reordena todo lo aprendido bajo la mirada de quien es responsable del conjunto â€” flujo, calidad, gobierno, recuperaciÃ³n, largo plazo y decisiones.
## Mapa conceptual de este capÃ­tulo
```mermaid
mindmap
  root((26 â€” Pensamiento de nivel senior))
    01-diseno-de-workflows-y-estrategias-de-ramas.md
      La pregunta senior (contexto, no receta)
      Las estrategias como familia (cuÃ¡ndo cada una)
    02-revision-de-codigo-y-gestion-de-releases.md
      La revisiÃ³n como sistema, no como trÃ¡mite
      QuÃ© mira una revisiÃ³n senior (capas)
    03-gobernanza-seguridad-y-automatizacion.md
      Gobernanza que no depende de hÃ©roes
      Seguridad como estado, no como acto
    04-recuperacion-ante-incidentes-y-desastres.md
      Incidente vs. desastre (dos mundos)
      Respuesta a incidentes (ritmo y roles)
    05-mantenimiento-y-escalabilidad.md
      Mantenimiento como presupuesto (no heroÃ­smo)
      Las tres escalas (gente, sistema, complejidad)
    06-decisiones-tecnicas.md
      QuÃ© hace Â«tÃ©cnicaÂ» a una decisiÃ³n
      El mÃ©todo completo (seis pasos)
```

## En esta secciÃ³n estudiarÃ¡s

* diseÃ±o de workflows y estrategias de ramas elegidas por contexto;
* revisiÃ³n de cÃ³digo por capas y releases como proceso maduro;
* gobernanza, seguridad y automatizaciÃ³n que no dependen de hÃ©roes;
* respuesta a incidentes y preparaciÃ³n ante desastres con ensayo;
* mantenimiento presupuestado y las tres escalas de crecimiento;
* el mÃ©todo de decisiÃ³n tÃ©cnica: seis pasos, registro y reversibilidad.

## Objetivos de aprendizaje

Al terminar esta secciÃ³n serÃ¡s capaz de:

* diseÃ±ar workflows y estrategias de ramas elegidas por contexto y no por moda;
* revisar cÃ³digo por capas y gestionar releases como proceso maduro con dueÃ±o;
* construir gobernanza, seguridad y automatizaciÃ³n que no dependan de hÃ©roes;
* responder a incidentes y prepararse ante desastres con ensayos previos;
* planificar mantenimiento presupuestado y las tres escalas de crecimiento;
* aplicar el mÃ©todo de decisiÃ³n tÃ©cnica: seis pasos, registro y reversibilidad.

---

## Â¿QuÃ© aprenderÃ¡s en esta secciÃ³n?

1. [`01-diseno-de-workflows-y-estrategias-de-ramas.md`](01-diseno-de-workflows-y-estrategias-de-ramas.md) â€” el flujo completo del issue al despliegue.
2. [`02-revision-de-codigo-y-gestion-de-releases.md`](02-revision-de-codigo-y-gestion-de-releases.md) â€” capas de revisiÃ³n y releases con dueÃ±o.
3. [`03-gobernanza-seguridad-y-automatizacion.md`](03-gobernanza-seguridad-y-automatizacion.md) â€” el sistema que se sostiene solo.
4. [`04-recuperacion-ante-incidentes-y-desastres.md`](04-recuperacion-ante-incidentes-y-desastres.md) â€” dos mundos: incidente y desastre.
5. [`05-mantenimiento-y-escalabilidad.md`](05-mantenimiento-y-escalabilidad.md) â€” presupuesto, seÃ±ales y gran cambio controlado.
6. [`06-decisiones-tecnicas.md`](06-decisiones-tecnicas.md) â€” el mÃ©todo que cierra el nivel.

## CÃ³mo estudiar esta secciÃ³n

Los capÃ­tulos sintetizan secciones anteriores: ten a mano tu `docs/flujo.md` y tu proyecto real. Cada capÃ­tulo pide una decisiÃ³n o documento propio â€” si los produces, al final tendrÃ¡s la carpeta de gobierno de un equipo senior.

## Referencias

* Brooks, F. â€” *The Mythical Man-Month* (1975) â€” principios de decisiÃ³n.
* Google SRE Book â€” respuesta a incidentes (sre.google).
* La secciÃ³n 28 de este curso como caso prÃ¡ctico de decisiÃ³n aplicada.

---



## Checkpoint 26 â€” ComprobaciÃ³n obligatoria
1. Verificar que el mapa conceptual estÃ© presente y correctamente estructurado.
2. Confirmar que los flowchart de procesos principales estÃ©n convertidos a Mermaid.
3. Asegurarse de que las autopreguntas de cierre contengan entre 5 y 8 preguntas de comprensiÃ³n profunda.
4. Revisar que los ejercicios de transferencia estÃ©n presentes y describan una tarea concreta y verificable.
5. Confirmar que los comandos destructivos tengan la advertencia de riesgo correspondiente.
6. Validar que no se hayan superado las 700 lÃ­neas por archivo.
Si puedes hacerlo **sin mirar instrucciones**, el checkpoint estÃ¡ cerrado.


## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruÃ©balo con los capÃ­tulos de la secciÃ³n:

1. Â¿QuÃ© diferencia hay entre un incidente y un desastre en la respuesta?
2. Â¿QuÃ© hace a una decisiÃ³n Â«reversibleÂ» y por quÃ© cambia el mÃ©todo si lo es?
3. Â¿QuÃ© es un Â«hÃ©roeÂ» en un equipo y quÃ© se construye para eliminarlo?
4. Â¿CuÃ¡les son las tres escalas de crecimiento de un repositorio?

---

## PrÃ³ximo paso

Cuando termines los seis capÃ­tulos, continÃºa con la siguiente secciÃ³n:

[`../27-proyectos-practicos/`](../27-proyectos-practicos/)
