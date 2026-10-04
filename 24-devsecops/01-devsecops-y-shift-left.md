# DevSecOps y shift left

## Introducción

**DevSecOps** es DevOps con la seguridad dentro del flujo, no al final como inspección final de fábrica. **Shift left** («mover a la izquierda») es el principio: detectar y corregir problemas de seguridad donde son baratos — en el editor, en el PR, en el pipeline — en lugar de en producción o en el informe de un tercero. Este capítulo define el modelo, cambia el rol de todos y sienta las bases de las secciones siguientes: cada puerta del flujo tendrá su control de seguridad.

---

## Mapa conceptual de este capítulo

```text
DevSecOps y shift left
       │
       ├── 1. Del modelo de túnel al modelo de flujo
       ├── 2. Shift left: qué significa en la práctica
       │   ├── 3. Los tres socios (y sus responsabilidades)
       │   ├── 4. Seguridad como checklist del flujo
       │   └── 5. Mito del «solo en el final»
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Del modelo de túnel al modelo de flujo

```text
MODELO ANTIGUO (túnel):
──────────────────────────────────────────────────────
desarrolla → desarrolla → desarrolla → "seguridad lo
revisa" → descubre 40 hallazgos → fricción →
remendos tardíos → o se publica igual
```

```text
DEVSECOPS (flujo integrado):
──────────────────────────────────────────────────────
cada paso del flujo (editor → PR → build → deploy →
operación) lleva SU control de seguridad — pequeño,
automático, accionable
```

```text
RESULTADO:
   │
   ├── hallazgos en el PR (baratos: minutos de
   │   corrección — sección 15)
   │
   ├── seguridad sin puerta final: el proceso no se
   │   atasca el último día
   │
   └── y si algo llega a producción, el post-mortem
       deja un control nuevo (sección 26)
```

```text
   │
   └── la fórmula de la etapa (sección 00): Desarrollo
       + Operaciones + Seguridad como un MISMO proceso
       — no tres departamentos que se pasan tickets
```

---

## 2. Shift left: qué significa en la práctica

```text
MAPA DE CONTROLES POR MOMENTO:
──────────────────────────────────────────────────────
editor       · reglas de secretos locales (sección 13
             / 06)
PR           · revisión humana + SAST + secretos +
             dependencias (sección 20)
build        · dependencias fijadas, imágenes
             escaneadas (sección 20 cap. 03/04)
staging      · DAST (cap. 03) + humo (sección 22)
deploy       · gates: aprobación, OIDC, firma (sección
             20 cap. 07)
operación    · alertas, respuesta, rotación (sección
             23 cap. 06 / sección 20 cap. 01)
```

```text
   │
   └── «izquierda» no es «solo al principio»: es
       TEMPRANO Y CONTINUO — cada momento tiene su
       puerta proporcional (Error 1)
```

```text
PROPORCIONALIDAD (criterio):
   │
   ├── barato y frecuente → PR (secretos, SAST,
   │   deps)
   │
   ├── más caro → main/staging (DAST, escaneos
   │   profundos)
   │
   └── crítico → gate de aprobación (deploy)
```

---

## 3. Los tres socios (y sus responsabilidades)

```text
DESARROLLO:
   │
   ├── escribe seguro desde el editor (patrones,
   │   validación de entradas — sección 09/15)
   ├── corrige hallazgos en SU PR
   └── es dueño de la calidad del cambio (sección 16)
```

```text
OPERACIONES (o plataforma):
   │
   ├── endurece runners, hosts, entornos (sección 23)
   ├── mantiene los gates de despliegue (sección 20/22)
   └── observabilidad y respuesta (sección 23 cap. 06)
```

```text
SEGURIDAD (rol, equipo o «sombrero»):
   │
   ├── define el marco: qué controles, qué severidad,
   │   qué SLA (cap. 06)
   │
   ├── da herramientas y plantillas (no solo
   │   informes)
   │
   └── en equipos pequeños: es un sombrero que ROTa
       (sección 16) — el principio no cambia
```

```text
   │
   └── sin este reparto, seguridad se vuelve «los que
       dicen no» — y DevSecOps muere (Error 3)
```

---

## 4. Seguridad como checklist del flujo

```text
CHECKLIST VIVA (por repositorio — sección 18/20):
   │
   ├── [ ] secret scanning + push protection
   ├── [ ] dependencias: Dependabot + alertas con SLA
   ├── [ ] SAST en PR (cap. 02)
   ├── [ ] imágenes/Dockerfile revisados (sección 23
   │       cap. 03)
   ├── [ ] secretos solo en environments
   ├── [ ] DAST en staging (cap. 03 — si aplica)
   └── [ ] permisos y ramas protegidas (sección 20
       cap. 06)
```

```text
   │
   └── la checklist NO es burocracia: es la
       MEMORIA DEL EQUIPO — se automatisa lo posible
       (punto 5 de la sección 02 DevOps) y se revisa
       (sección 18)
```

---

## 5. Mito del «solo en el final»

```text
POR QUÉ PERSISTE:
   │
   ├── es más fácil centralizar que integrar
   │
   └── «al final ya veremos» suena a eficiencia —
       hasta que «al final» es caro (punto 1)
```

```text
REALIDAD (por qué shift left gana):
   │
   ├── el coste de corregir crece con la distancia al
   │   PR (Editorial: horas en PR, días en staging,
   │   incidente en producción)
   │
   ├── en el PR, quien sabe POR QUÉ el código está
   │   así está mirando la pantalla (contexto fresco)
   │
   └── y «al final» sigue existiendo: es la red que
       capa lo que se escapó (punto 2: no se elimina,
       se complementa)
```

```text
   │
   └── Shift left no es quitar el control final: es
       que el control final no sea el ÚNICO (Error 5)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: shift left mal entendido («solo al principio»)

**Qué ocurrió:** se pusieron reglas en el editor y se retiraron todas las verificaciones de staging/producción «porque ya es shift left».

**Por qué:** se confundió «temprano» con «único» (punto 2).

**Cómo comprobarlo:** ¿qué controles quedan después del PR?

**Opciones:** restaurar las puertas proporcionales (cap. 03 humo/DAST, gates de deploy).

**Riesgos:** hueco en el medio del flujo.

**Solución:** temprano Y continuo (punto 2).

**Cómo se evita:** mapa de controles por momento (punto 2) revisado en gobernanza.

---

### Error 2: seguridad como cuello de botella final

**Qué ocurrió:** la revisión de seguridad ocurría en el día antes del release; encontraba todo y bloqueaba.

**Por qué:** nunca hubo shift left real (punto 1).

**Cómo comprobarlo:** ¿cuándo se descubren la mayoría de hallazgos?

**Opciones:** mover controles al PR; acordar SLA de revisión; formación.

**Riesgos:** el ciclo entero se frena cada vez más.

**Solución:** flujo integrado (punto 1).

**Cómo se evita:** métrica «hallazgos descubiertos en PR vs. después» (cap. 06).

---

### Error 3: «seguridad dice que no»

**Qué ocurrió:** cada propuesta chocaba con un no; el equipo aprendió a esquivar.

**Por qué:** seguridad sin herramientas ni servicio (punto 3).

**Cómo comprobarlo:** ¿seguridad participa desde el diseño? ¿tiene plantillas y automación?

**Opciones:** seguridad provee gates automatizados y templates; medir ayuda, no vetos.

**Riesgos:** bypass cultural.

**Solución:** tres socios con entregables (punto 3).

**Cómo se evita:** acuerdos de colaboración escritos (sección 16/26).

---

### Error 4: checklist decorativa (no auditada)

**Qué ocurrió:** la checklist existía en un wiki y varios repos la incumplían sin que nadie lo notara.

**Por qué:** sin dueño ni verificación (punto 4).

**Cómo comprobarlo:** auditar 5 repos contra la checklist.

**Opciones:** automatizar la verificación (plantillas + chequeos); dueño por repo; revisión trimestral.

**Riesgos:** falsa certeza.

**Solución:** checklist viva y verificable (punto 4).

**Cómo se evita:** parte del checklist de repos (sección 18).

---

### Error 5: solo controles automáticos sin cultura

**Qué ocurrió:** herramientas al verde y alguien pegó un secreto en un issue «porque la herramienta no lo mira» (sección 21 cap. 06 Error 6).

**Por qué:** se automatizó sin formar (Error 5 relacionado).

**Cómo comprobarlo:** incidentes que pasaron POR FUERA de las herramientas.

**Opciones:** formación en onboarding + reglas escritas (sección 00/21 cap. 06); red humana (revisión de PR).

**Riesgos:** huecos humanos.

**Solución:** capas + cultura (punto 5/6).

**Cómo se evita:** el curso y la revisión constante — como este curso entero.

---

## 7. Práctica guiada

### Objetivo

Diseñar el mapa de controles de seguridad de tu proyecto por momento del flujo.

### Paso 1: dibuja el flujo

```text
editor → PR → build → staging → deploy → operación
(tu cadena real, sección 23 cap. 07 Paso 1)
```

### Paso 2: en cada momento, la pregunta

```text
Para cada momento:
   │
   ├── ¿qué control de seguridad va aquí?
   ├── ¿automático o humano?
   └── ¿ya existe o hay que crearlo?
Rellena la tabla con referencias a las secciones 19/20/22/23.
```

### Paso 3: huecos

1. Marca en rojo lo que no existe. Prioriza: secretos y dependencias primero (los más baratos — sección 20 caps. 02/03).

### Paso 4: primeras capas activas

1. Activa lo mínimo: secret scanning + push protection + Dependabot en tu repo de práctica (si no está de la sección 20).

### Paso 5: checklist publicada

1. Publica la checklist (punto 4) en `docs/seguridad.md` con estado real (qué tienes, qué falta, cuándo).

### Paso 6: roles

1. Escribe quién es cada «socio» en tu proyecto (aunque seas uno: qué sombrero llevas en cada momento).

### Resultado esperado

Mapa por momento con huecos priorizados, controles mínimos activos y roles escritos.

### Conclusión esperada

DevSecOps es diseño de flujo: cada momento sabe qué control le corresponde — la seguridad deja de ser un departamento al final del pasillo y pasa a ser una propiedad del camino.

---

## 8. Nivel profesional + resumen

### 8.1. DevSecOps a escala

```text
   │
   ├── seguridad como PRODUCTO interno: plantillas,
   │   gates y herramientas autoservicio (sección 25)
   │
   ├── controles como código, versionados y revisados
   │   (cap. 04 de esta sección / sección 18)
   │
   ├── métricas del programa: hallazgos por momento,
   │   SLA de corrección, tiempo de descubrimiento
   │   (cap. 06)
   │
   ├── formación continua y sombreros rotativos en
   │   equipos pequeños (sección 16/26)
   │
   └── auditoría: la checklist se verifica, no se
       declara (sección 18/24)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* del túnel al flujo: seguridad en cada paso, no en el último;
* shift left = temprano y continuo, con controles proporcionales por momento;
* los tres socios con entregables reales: desarrollar seguro, endurecer entorno, definir marco;
* la checklist del flujo es la memoria del equipo: automatizable y auditada;
* el control final no desaparece: complementa (capa que capa lo escapado);
* los errores típicos (shift left mal leído, cuello de botella, cultura del no, checklist muerta, solo herramientas) se previenen con diseño y acuerdos;
* a nivel profesional: seguridad como producto interno con métricas.

La idea principal es:

> **La seguridad no se añade al proceso: se diseña dentro de él — cada momento del flujo carga su puerta proporcional, y el equipo la ve como ayuda, no como aduana.**

---

## Próximo paso

Ya tienes el modelo.

Ahora las herramientas del flujo: primero lo que se lee sin ejecutar (SAST).

Continúa con:

[`02-analisis-estatico-sast.md`](02-analisis-estatico-sast.md)
