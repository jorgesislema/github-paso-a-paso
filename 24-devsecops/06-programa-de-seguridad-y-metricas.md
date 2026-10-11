# Programa de seguridad y mÃ©tricas

## IntroducciÃ³n

Un conjunto de herramientas no es un programa: lo es cuando tiene dueÃ±os, puertas definidas, mÃ©tricas que se miran, respuesta ante incidentes y una costumbre de mejorar. Este capÃ­tulo cierra la secciÃ³n DevSecOps ensamblando todo lo anterior en un programa mÃ­nimo viable para cualquier equipo â€” desde un proyecto con una persona hasta una organizaciÃ³n con auditorÃ­as â€” y definiendo quÃ© medir para saber si la seguridad del flujo funciona de verdad.

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## Mapa conceptual de este capÃ­tulo

```mermaid
mindmap
  root((Programa de seguridad y mÃ©tricas))
    1. El programa mÃ­nimo (sus 6 piezas)
    2. Puertas y severidad (la polÃ­tica unificada)
      3. MÃ©tricas: quÃ© se mira y para quÃ©
      4. Incidentes: respuesta y aprendizaje
      5. Personas: formaciÃ³n y sombreros
    6. Errores comunes con diagnÃ³stico completo
    7. PrÃ¡ctica guiada
    8. Nivel profesional + resumen
```

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 1. El programa mÃ­nimo (sus 6 piezas)

```text
1. CONTROLES POR PUERTA (las secciones 19/20/24 â€”
   lista maestra, secciÃ³n 04 cap. 04 Paso 2)
   â”‚
2. DUEÃ‘OS (por repo y por control â€” secciÃ³n 16 cap.
   06)
   â”‚
3. POLÃTICA DE SEVERIDAD (quÃ© bloquea, quÃ© backlog,
   con quÃ© SLA â€” cap. 02 punto 2)
   â”‚
4. INVENTARIO (dependencias, integraciones, accesos,
   credenciales â€” secciÃ³n 20 cap. 01/03)
   â”‚
5. RESPUESTA (guiones de incidente: secretos,
   suministro, rollback â€” secciÃ³n 20 cap. 01 / 22
   cap. 06 / cap. 05 de esta secciÃ³n)
   â”‚
6. MEJORA CONTINUA (retro con datos + post-mortem con
   control nuevo â€” secciÃ³n 23 cap. 01)
```

```text
   â”‚
   â””â”€â”€ si una pieza falta, el programa no es un
       programa: es una colecciÃ³n de features (Error 1
       â€” revisa cuÃ¡l te falta hoy)
```

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 2. Puertas y severidad (la polÃ­tica unificada)

```text
TABLA ÃšNICA (la que vienes construyendo):
â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
PUERTA        BLOQUEA                  BACKLOG CON SLA
editor        secretos locales         â€”
PR            secretos, SAST crÃ­tico,  warnings,
              deps con CVE alto        dÃ­asâ€“semanas
main/build    imÃ¡genes vulnerables,    medio plazo
              receta fija
staging       DAST crÃ­tico, humo       resto
deploy        gate: checks + hallazgos â€”
              bloqueantes + aprobaciÃ³n
operaciÃ³n     alertas de SLO           post-mortem
```

```text
SLA POR SEVERIDAD (ejemplo â€” define los tuyos):
   â”‚
   â”œâ”€â”€ crÃ­tico/explotable: horas (mitigar hoy)
   â”œâ”€â”€ alto: dÃ­as (7)
   â””â”€â”€ medio/bajo: semanas (30)
```

```text
   â”‚
   â””â”€â”€ la tabla ES el programa en una pÃ¡gina: quien
       llega nuevo la entiende en 10 minutos (Error 2
       si no existe)
```

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 3. MÃ©tricas: quÃ© se mira y para quÃ©

```text
CUATRO FAMILIAS (cada una responde una pregunta):
   â”‚
   â”œâ”€â”€ Â¿detectamos a tiempo?
   â”‚     Â· % hallazgos descubiertos en PR vs. despuÃ©s
   â”‚     Â· tiempo medio PRâ†’correcciÃ³n (por severidad)
   â”‚
   â”œâ”€â”€ Â¿estÃ¡ limpio?
   â”‚     Â· alertas abiertas y su antigÃ¼edad (secciÃ³n
   â”‚       20 cap. 02/03)
   â”‚     Â· cobertura de controles (repos con checklist
   â”‚       completa)
   â”‚
   â”œâ”€â”€ Â¿respondemos?
   â”‚     Â· tiempo de acotaciÃ³n en simulacros (cap. 05
   â”‚       Paso 5)
   â”‚     Â· MTTR de incidentes (secciÃ³n 23 cap. 01)
   â”‚
   â””â”€â”€ Â¿mejoramos?
        Â· reincidencias (Â¿mismo post-mortem 2 veces?)
        Â· excepciones abiertas (bypass, emergencias)
```

```text
REGLA DE ORO (secciÃ³n 23 cap. 01 Error 3):
   â”‚
   â”œâ”€â”€ las mÃ©tricas son BARÃ“METRO para conversar en la
   â”‚   retro â€” no nota, no ranking, no castigo
   â”‚
   â””â”€â”€ cada mÃ©trica tiene PREGUNTA asociada: si nadie
       hace la pregunta, se retira la mÃ©trica
```

```text
   â”‚
   â””â”€â”€ empieza con DOS: hallazgos en PR vs. despuÃ©s y
       alertas abiertas > SLA. Con dos que se miren,
       vales mÃ¡s que con veinte decorativos (Error 3)
```

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 4. Incidentes: respuesta y aprendizaje

```text
RESPUESTA (estructura comÃºn â€” secciÃ³n 22 cap. 06):
   â”‚
   â”œâ”€â”€ 1. contener (pausar, revertir, rotar â€” segÃºn el
   â”‚       tipo: guion correspondiente)
   â”œâ”€â”€ 2. comunicar (canal y dueÃ±os â€” secciÃ³n 16)
   â”œâ”€â”€ 3. resolver/verificar (humo, escaneo)
   â””â”€â”€ 4. post-mortem SIN CULPA en < 48 h
```

```text
POST-MORTEM QUE SIRVE (plantilla):
   â”‚
   â”œâ”€â”€ lÃ­nea temporal (de observabilidad â€” secciÃ³n 23
   â”‚   cap. 06)
   â”œâ”€â”€ causa raÃ­z (sin Â«el junior clicÃ³Â» â€” mira el
   â”‚   control que faltaba)
   â”œâ”€â”€ acciones: dueÃ±o + fecha + tipo de control
   â”‚   (Â¿quÃ© puerta ahora lo evitarÃ­a?)
   â””â”€â”€ registro: Â¿se aplicÃ³ la acciÃ³n? (si no, se
       repite el incidente â€” Error 4)
```

```text
   â”‚
   â””â”€â”€ el incidente cierra cuando el CONTROL existe,
       no cuando el servicio vuelve (secciÃ³n 22 cap.
       06 Error 7)
```

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 5. Personas: formaciÃ³n y sombreros

```text
FORMACIÃ“N (lo que evita el 60% de los incidentes):
   â”‚
   â”œâ”€â”€ onboarding: reglas del repo (secciÃ³n 21 cap.
   â”‚   06), secretos (secciÃ³n 20 cap. 01), el flujo
   â”‚   (este curso â€” EMPIEZA-AQUI)
   â”‚
   â”œâ”€â”€ en el flujo: el PR explica por quÃ© (la
   â”‚   revisiÃ³n enseÃ±a â€” secciÃ³n 15 cap. 06)
   â”‚
   â””â”€â”€ simulacros: guiones practicados (cap. 05)
```

```text
SOMBREROS (equipos pequeÃ±os â€” secciÃ³n 24 cap. 01):
   â”‚
   â”œâ”€â”€ la Â«seguridadÂ» rota entre personas con
   â”‚   checklist y calendario
   â”‚
   â””â”€â”€ el traspaso del sombrero es un entregable: la
       lista maestra se lee (Error 5 si vive en una
       cabeza)
```

```text
   â”‚
   â””â”€â”€ cultura: reportar un error propio rÃ¡pido es
       premiado; ocultarlo es el problema (secciÃ³n 00
       / 16)
```

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 6. Errores comunes con diagnÃ³stico completo

### Error 1: colecciÃ³n de herramientas sin programa

**QuÃ© ocurriÃ³:** 6 productos activos, ninguno con dueÃ±o; nadie sabÃ­a quÃ© bloqueaba quÃ©.

**Por quÃ©:** se compraron piezas, no se diseÃ±Ã³ el programa (punto 1).

**CÃ³mo comprobarlo:** pregunta por cada una de las 6 piezas: Â¿existe y quiÃ©n la lleva?

**Opciones:** completar la pieza que falte empezando por dueÃ±os y polÃ­tica.

**Riesgos:** cartera cara e inÃºtil.

**SoluciÃ³n:** las 6 piezas (punto 1).

**CÃ³mo se evita:** revisiÃ³n anual del programa con la lista.

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
### Error 2: polÃ­tica que nadie puede citar

**QuÃ© ocurriÃ³:** ante un hallazgo, cada quien interpretÃ³ la severidad a su manera.

**Por quÃ©:** sin tabla unificada (punto 2).

**CÃ³mo comprobarlo:** dile a un miembro: Â«Â¿quÃ© bloquea el PR?Â» â€” si duda, no existe.

**Opciones:** escribir la tabla (punto 2), publicarla, usarla en la retro.

**Riesgos:** gates arbitrarios (secciÃ³n 22 cap. 04 Error 4).

**SoluciÃ³n:** una pÃ¡gina citable (punto 2).

**CÃ³mo se evita:** revisarla en cada cambio de control.

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
### Error 3: dashboard de 20 mÃ©tricas sin preguntas

**QuÃ© ocurriÃ³:** nadie miraba nada; las decisiones seguÃ­an a intuiciÃ³n.

**Por quÃ©:** mÃ©trica sin pregunta (punto 3 / secciÃ³n 23 cap. 01 Error 6).

**CÃ³mo comprobarlo:** Ãºltima decisiÃ³n motivada por la seguridad del dashboard.

**Opciones:** reducir a dos con preguntas; retirar el resto.

**Riesgos:** parÃ¡lisis por vanidad.

**SoluciÃ³n:** pregunta â†’ mÃ©trica â†’ acciÃ³n (punto 3).

**CÃ³mo se evita:** regla Â«cada mÃ©trica con dueÃ±o de preguntaÂ».

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
### Error 4: post-mortems sin acciones aplicadas

**QuÃ© ocurriÃ³:** cien documentos y las mismas causas repitiÃ©ndose.

**Por quÃ©:** acciones sin dueÃ±o/fecha ni verificaciÃ³n (punto 4).

**CÃ³mo comprobarlo:** lista de acciones abiertas y su antigÃ¼edad.

**Opciones:** tracker de acciones con cierre verificado; revisiÃ³n mensual.

**Riesgos:** aprendizaje de ficciÃ³n.

**SoluciÃ³n:** cierra cuando el control existe (punto 4).

**CÃ³mo se evita:** la revisiÃ³n mensual los cuenta como mÃ©trica Â«mejoraÂ» (punto 3).

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
### Error 5: el programa en una cabeza

**QuÃ© ocurriÃ³:** se fue la persona de seguridad y el programa quedÃ³ en PDFs viejos.

**Por quÃ©:** sin sombreros, checklists ni traspaso (punto 5).

**CÃ³mo comprobarlo:** si la persona no estÃ¡, Â¿quiÃ©n sabe citar la polÃ­tica?

**Opciones:** todo por escrito y con rotaciÃ³n real del sombrero (calendario).

**Riesgos:** amnesia institucional.

**SoluciÃ³n:** memoria externa (punto 1/5).

**CÃ³mo se evita:** el programa es un repositorio â€” como este curso.

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 7. PrÃ¡ctica guiada

### Objetivo

Montar el programa mÃ­nimo de tu proyecto: polÃ­tica, mÃ©tricas y respuesta.

### Paso 1: las 6 piezas (auditorÃ­a)

```text
Marca estado:  sÃ­ existe Â· parcial Â· falta
   â”‚
   1 controles por puerta   4 inventarios
   2 dueÃ±os                 5 guiones de respuesta
   3 polÃ­tica severidad/SLA 6 mejora continua
```

1. Empieza por lo que falta y tiene mayor riesgo.

### Paso 2: la tabla unificada

1. Escribe la tabla del punto 2 en `docs/seguridad.md` (o `docs/seguridad-entrega.md` si ya lo tienes â€” fusiona).

### Paso 3: dos mÃ©tricas

1. Elige: (a) hallazgos en PR vs. despuÃ©s y (b) alertas abiertas > SLA.
2. Anota la lÃ­nea base de hoy â€” aunque sea Â«0 medido, empieza maÃ±anaÂ».

### Paso 4: guion de incidente maduro

1. Ten al menos dos guiones: secretos (secciÃ³n 20 cap. 01) y suministro (cap. 05).
2. Programa un simulacro en el calendario (fecha y responsable).

### Paso 5: post-mortem de mentira real

1. Toma un Â«incidenteÂ» pequeÃ±o de la vida real del proyecto (un CI rojo de horas, una dependencia que rompiÃ³) y escribe su post-mortem con la plantilla del punto 4 â€” incluida la acciÃ³n con dueÃ±o.

### Paso 6: publica y cita

```markdown
Del programa, en el README del repo:
- Controles y polÃ­tica â†’ docs/seguridad.md
- Incidentes â†’ docs/incidentes/ (guiones)
- DueÃ±os â†’ tabla de CODEOWNERS/documento
- Las 2 mÃ©tricas â†’ enlace o pÃ¡gina
```

### Resultado esperado

AuditorÃ­a de las 6 piezas con una cerrada, polÃ­tica citable, dos mÃ©tricas con lÃ­nea base y simulacro en calendario.

### Ejercicio de transferencia
Aplica los principios de un programa de seguridad a un proceso de gestiÃ³n de un proyecto de construcciÃ³n. Define las seis piezas del programa (controles por fase, dueÃ±os, polÃ­tica de severidad, inventario de recursos, respuesta a incidentes, mejora continua) y cÃ³mo se aplicarÃ­an en cada etapa (diseÃ±o, licitaciÃ³n, construcciÃ³n, puesta en marcha). Entrega un documento que describa el programa y sus mÃ©tricas clave.
### ConclusiÃ³n esperada

El programa es lo que sobrevive a la prisa: cuando la polÃ­tica se cita, las mÃ©tricas se miran y los guiones se practican, la seguridad se volviÃ³ una propiedad del equipo â€” no de una herramienta.

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## 8. Nivel profesional + resumen

### 8.1. El programa a escala

```text
   â”‚
   â”œâ”€â”€ gobierno: dueÃ±os por repo, comitÃ©/foro mensual
   â”‚   de seguridad-entrega (nombre simple, pero foro)
   â”‚
   â”œâ”€â”€ mÃ©tricas consolidadas en un tablero Ãºnico con
   â”‚   preguntas (punto 3)
   â”‚
   â”œâ”€â”€ simulacros en calendario: secretos, suministro,
   â”‚   rollback (secciÃ³n 22 cap. 06 / cap. 05)
   â”‚
   â”œâ”€â”€ auditorÃ­a interna anual: Â¿las 6 piezas? Â¿las
   â”‚   mÃ©tricas se usan? (Error 1 â€” secciÃ³n 20/24)
   â”‚
   â”œâ”€â”€ cumplimiento (menciÃ³n): marcos y regulaciones
   â”‚   piden EXACTAMENTE esto: polÃ­tica, evidencias,
   â”‚   mÃ©tricas y mejora â€” el programa bien hecho
   â”‚   documenta su evidencia
   â”‚
   â””â”€â”€ mÃ©tricas de programa: acciones de post-mortem
       cerradas a tiempo; % repos con checklist
       completa; tiempo de acotaciÃ³n
```

### 8.2. Resumen

En este capÃ­tulo aprendiste que:

* programa = controles + dueÃ±os + polÃ­tica + inventarios + respuesta + mejora â€” las seis piezas o no es programa;
* la tabla de puertas y severidad con SLA es la pÃ¡gina que todo el mundo debe poder citar;
* mÃ©tricas por familia (detectar, limpiar, responder, mejorar), empezando por dos con preguntas;
* incidentes: contener â†’ comunicar â†’ resolver â†’ post-mortem sin culpa con acciÃ³n verificada;
* personas: onboarding, revisiÃ³n que enseÃ±a, simulacros y sombreros con traspaso;
* los errores tÃ­picos (colecciÃ³n sin programa, polÃ­tica citable no, mÃ©tricas decorativas, post-mortems de ficciÃ³n, programa en una cabeza) se previenen con estructura y calendario;
* a nivel profesional: gobierno, auditorÃ­a interna y evidencia para cumplimiento.

La idea principal es:

> **Un programa de seguridad es lo que permanece cuando nadie estÃ¡ mirando: polÃ­tica que se cita, mÃ©tricas que se preguntan y guiones que ya se han practicado â€” todo lo demÃ¡s es una herramienta esperando su incidente.**

---\n\n## Autopreguntas de cierre\nSin mirar el material, responde mentalmente y luego compruébalo con este capítulo:\n1. ¿Cuáles son las seis piezas esenciales de un programa mínimo de seguridad y por qué es necesario que todas estén presentes para considerar que se tiene un programa y no solo una colección de herramientas?\n2. ¿Cómo se compone la tabla unificada de puertas y severidad y qué información contiene para guiar las decisiones de seguridad en el flujo?\n3. ¿Cuáles son las cuatro familias de métricas descritas en el capítulo y qué pregunta clave responde cada familia?\n4. ¿Cuál es la estructura común de respuesta a incidentes y qué elementos debe incluir un post-mortem efectivo para generar aprendizaje?\n5. ¿Cómo se integra la formación y la rotación de sombreros en equipos pequeños para garantizar que el conocimiento de seguridad se comparta y no quede en una sola persona?\n6. ¿Qué riesgos existen si se permiten métricas decorativas o post-mortems sin acciones aplicadas, y cómo se mitigan esos riesgos mediante reglas claras?\n\n
## PrÃ³ximo paso

Has completado la secciÃ³n de DevSecOps.

ContinÃºa con el cierre:

[`README.md`](README.md)



