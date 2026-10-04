# Cadena de suministro en el flujo

## Introducción

La sección 20 cap. 05 mapeó la cadena de suministro y el SBOM; este capítulo los integra al flujo de entrega como política operativa: dónde se verifican los terceros, cómo entra la dependencia nueva al equipo, cómo se firma y se consume con confianza, y qué hacer cuando un eslabón se rompe. La cadena no se audita una vez al año — se gobierna en cada PR y en cada release.

---

## Mapa conceptual de este capítulo

```text
Cadena de suministro en el flujo
       │
       ├── 1. La cadena como política, no como informe
       ├── 2. Entrada: terceros y dependencias en el PR
       │   ├── 3. Construcción: identidad del artefacto
       │   ├── 4. Salida: firmar, publicar, registrar
       │   └── 5. Incidente de suministro: el guion
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. La cadena como política, no como informe

```text
DIFERENCIA DE ENFOQUE:
   │
   ├── informe: «usas 87 librerías» (foto — sección 20
   │   cap. 05 punto 4)
   │
   └── política: CÓMO entra cada una, quién aprueba,
       con qué verificación, qué pasa si se rompe
       (proceso — este capítulo)
```

```text
LAS CUATRO PUERTAS DE LA POLÍTICA:
──────────────────────────────────────────────────────
1. ENTRADA   (criterio de adopción — punto 2)
2. CONSTRUCCIÓN (fijado y receta — punto 3)
3. SALIDA    (firma y registro — punto 4)
4. RESPUESTA (guion de incidente — punto 5)
```

```text
   │
   └── sin política, la cadena se gobierna por
       urgencias: «necesito esa librería hoy» es la
       forma en que entran los eslabones flojos
       (Error 1)
```

---

## 2. Entrada: terceros y dependencias en el PR

```text
CHECKLIST DE ADOPCIÓN (lo que el revisor mira):
   │
   ├── ¿se necesita? (la mejor dependencia — sección
   │   21 cap. 03 punto 4)
   │
   ├── ¿de fuente canónica y mantenida? (reputación,
   │   licencia — mención legal)
   │
   ├── ¿versión fijada y lock actualizado? (sección
   │   21 caps. 01/02)
   │
   ├── ¿scripts de instalación? (riesgo de ejecución
   │   en build — sección 20 cap. 05)
   │
   └── ¿ya existe en el equipo algo equivalente?
       (reutilización — sección 23 cap. 01)
```

```text
PARA ACCIONES DE CI (recap — sección 19 cap. 05):
   │
   ├── oficiales por tag mayor; terceros por SHA
   │
   └── Dependabot renueva (sección 20 cap. 03)
```

```text
   │
   └── el PR es la aduana natural: quien adopta,
       explica; quien revisa, aplica la checklist
       (Error 2 si la revisión solo mira estilo)
```

---

## 3. Construcción: identidad del artefacto

```text
LO QUE GARANTIZA LA CONSTRUCCIÓN (recap integrador):
   │
   ├── receta fijada (lock + base + versiones —
   │   sección 22 cap. 03)
   │
   ├── pipeline con controles (sección 04 de esta
   │   sección)
   │
   └── identidad resultante: versión + commit + digest
       (+ SBOM — sección 20 cap. 05)
```

```text
REPRODUCCIÓN COMO DEFENSA:
   │
   └── si alguien afirma «esta imagen tiene X», puedes
       RECONSTRUIR y verificar (punto 4 de la sección
       22 cap. 03) — sin reproducibilidad, confiar es
       ciego (Error 3)
```

---

## 4. Salida: firmar, publicar, registrar

```text
SALIDA SEGURA:
   │
   ├── firmar/attestar el artefacto desde el pipeline
   │   (identidad de CI — OIDC, sección 20 cap. 07)
   │
   ├── publicar solo desde environment con aprobación
   │   (sección 04 cap. 04)
   │
   ├── SBOM adjunto al release (sección 20 cap. 05)
   │
   └── registrar: entorno → versión → digest → quién
       aprobó (sección 22 cap. 05)
```

```text
CONSUMO CONFIABLE (verificación activa):
   │
   ├── ¿quién VERIFICA las firmas? (el despliegue, el
   │   equipo, la plataforma) — sección 20 cap. 05
   │   Error 4
   │
   └── la política dice DÓNDE se verifica y qué pasa
       si no cuadra (bloquear — Error 4)
```

```text
   │
   └── firmar sin verificador es adorno: la política
       completa es «firmar + comprobar en el consumidor»
```

---

## 5. Incidente de suministro: el guion

```text
CUANDO UN ESLABÓN SE ROMPE (dependencia/acción/imagen):
──────────────────────────────────────────────────────
1. DETENER: pausar publicaciones afectadas (¿qué
   release lo incluye?)
2. ACOTAR con SBOM/inventario: ¿estamos afectados?
   ¿dónde corre? (sección 20 cap. 05 Error 6)
3. MITIGAR: actualizar la dependencia parcheada, o
   retirar/aislar si no hay parche
4. VERIFICAR: escaneo + humo en lo desplegado
5. PUBLICAR corrección (si procede) por el carril
   (sección 22)
6. POST-MORTEM: ¿por qué entró? ¿qué control falta?
   (punto 2: ¿faltó checklist? ¿fijado?)
```

```text
   │
   └── el guion existe ANTES del incidente (Error 5
       si se escribe el día del suceso) — practicar
       con una falsa alarma (p. ej. un CVE menor) es
       el ejercicio correcto
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: adopción sin criterio («lo vi en un tutorial»)

**Qué ocurrió:** una librería de autor desconocido entró a producción y poco después el repo fue comprometido (caso patrón de supply chain).

**Por qué:** sin checklist de entrada (punto 2).

**Cómo comprobarlo:** revisar PRs de dependencias: ¿se aplicó criterio?

**Opciones:** la checklist del punto 2 como norma de revisión; retirar lo que no la cumpla.

**Riesgos:** el eslabón más flojo de todos.

**Solución:** aduana en el PR (punto 2).

**Cómo se evita:** plantilla de revisión (sección 15 cap. 06).

---

### Error 2: revisión de PR que solo mira estilo

**Qué ocurrió:** la dependencia nueva pasó sin que nadie preguntara «¿por qué esta?».

**Por qué:** la revisión no cubre decisiones de confianza (punto 2).

**Cómo comprobarlo:** histórico: ¿cuántos PRs de deps tuvieron comentario?

**Opciones:** checklist del revisor con las 5 preguntas; formación breve.

**Riesgos:** confianza concedida sin mirar.

**Solución:** revisar el «qué», no solo el «cómo» (punto 2 / sección 21 cap. 06 Error 6).

**Cómo se evita:** plantilla de PR con sección «dependencias nuevas».

---

### Error 3: artefacto no reproducible tras el incidente

**Qué ocurrió:** llegó un CVE y no se pudo reconstruir el build exacto que estaba en producción.

**Por qué:** receta móvil y sin registro (punto 3 / sección 22 cap. 03).

**Cómo comprobarlo:** intento de reproducción: ¿sale el mismo digest?

**Opciones:** fijar todo (bases, versiones), registrar builds.

**Riesgos:** acotación imposible.

**Solución:** receta fija + registro (punto 3).

**Cómo se evita:** checklist de build (sección 22).

---

### Error 4: firmado sin verificación

**Qué ocurrió:** el release iba firmado; el despliegue no comprobaba nada — la firma era decorativa.

**Por qué:** se cerró la mitad del circuito (punto 4).

**Cómo comprobarlo:** ¿dónde está el paso de verificación? ¿qué pasa si falla?

**Opciones:** añadir verificación en el despliegue (bloqueo si no cuadra); si no es posible, dejar de presentar la firma como control.

**Riesgos:** falsa confianza (sección 20 cap. 05 Error 4).

**Solución:** firmar + verificar (punto 4).

**Cómo se evita:** el gate pre-publicación lo incluye (punto 5 de la sección 04).

---

### Error 5: guion de incidente improvisado

**Qué ocurrió:** un aviso de vulnerabilidad severa llegó un viernes; el equipo tardó en saber si estaba afectado.

**Por qué:** sin guion ni práctica (punto 5).

**Cómo comprobarlo:** ¿existe? ¿cuándo se practicó?

**Opciones:** escribir el guion del punto 5; simular con un CVE menor; medir tiempo de acotación.

**Riesgos:** el primer ejercicio se hace en caliente.

**Solución:** guion previo y ensayado (punto 5).

**Cómo se evita:** calendario (sección 18/26).

---

### Error 6: terceros operativos (SaaS, plugins) fuera de la política

**Qué ocurrió:** el foco estaba en librerías y un SaaS con acceso a repos quedó sin revisar (integraciones — sección 20 cap. 06 Error 6).

**Por qué:** la «cadena» se entendió solo como código (punto 1).

**Cómo comprobarlo:** lista de integraciones/app con acceso: ¿con criterio de adopción?

**Opciones:** aplicar el mismo ciclo: entrada (evaluación), permanencia (revisión), salida (revocación).

**Riesgos:** eslabón humano-organizativo sin gobernar.

**Solución:** política de PUERTAS, no de tipo de eslabón (punto 1).

**Cómo se evita:** inventario trimestral (sección 20 cap. 06).

---

## 7. Práctica guiada

### Objetivo

Escribir la política de cadena de suministro de tu proyecto y ensayar su guion.

### Paso 1: política de entrada

```markdown
## Adopción de terceros (en el PR)
1. ¿Se necesita? (alternativas revisadas)
2. Fuente canónica y mantenida
3. Versión fijada + lock
4. Scripts de instalación: revisados
5. Licencia: [política del equipo]
```

1. Pégalo en `docs/seguridad-entrega.md` (sección 04 Paso 1).

### Paso 2: inventario

```bash
# dependencias (tu ecosistema) + acciones + imágenes
git ls-files | grep -E "(lock|requirements|go.sum)"
grep -rho "uses: [^ ]*" .github/workflows/ | sort -u
grep -h "^FROM" Dockerfile* 2>/dev/null
```

1. Anota el inventario y el dueño de cada categoría.

### Paso 3: salida verificable

1. Comprueba: tu release lleva versión+commit+digest y (si puedes) SBOM adjunto (sección 20 cap. 05 / 22 cap. 05).
2. Escribe DÓNDE se verifica (aunque sea «pendiente — fecha»).

### Paso 4: guion

1. Copia el punto 5 a `docs/incidente-suministro.md` con tus rutas reales (¿dónde está el SBOM? ¿quién pausa publicaciones?).

### Paso 5: simulación

```text
Simula: «CVE crítico en una librería X que usas»
   │
   ├── ¿en qué minuto sabes si estás afectado?
   ├── acótalo con tu inventario (paso 2)
   └── escribe los tiempos y los huecos encontrados
```

### Paso 6: revisión del criterio

1. Pasa tus últimas 3 adopciones de terceros por la checklist del paso 1: ¿pasarían? Si no, ¿por qué entraron?

### Resultado esperado

Política de entrada escrita, inventario con dueños, guion con rutas y simulacro con tiempos.

### Conclusión esperada

La cadena de suministro se gobierna donde entra (PR), donde sale (release) y donde se rompe (guion) — los informes son material de apoyo, no el sistema.

---

## 8. Nivel profesional + resumen

### 8.1. Cadena gobernada a escala

```text
   │
   ├── política de adopción de terceros (incluidos
   │   SaaS e integraciones) con evaluación y
   │   renovación de confianza (punto 1/6)
   │
   ├── SBOM automático por release + consulta rápida
   │   (sección 20 cap. 05)
   │
   ├── firmas y verificación obligatoria en despliegue
   │   (punto 4)
   │
   ├── guiones ensayados y proveedores con
   │   compromisos (mención contractual cuando aplica)
   │
   ├── métrica: tiempo de acotación en simulacros;
   │   % de adopciones con checklist; dependencias
   │   fuera de política
   │
   └── integración: el post-mortem de suministro deja
       controles en las puertas 1–3 (mejora continua)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* la cadena se gobierna como política de cuatro puertas: entrada, construcción, salida, respuesta;
* entrada: checklist de adopción aplicada en la revisión del PR (criterio, fuente, fijado, scripts, licencia);
* construcción: receta fija y reproducible — sin ella, acotar es imposible;
* salida: firma + SBOM + registro + verificación activa en el consumidor;
* guion de incidente previo y ensayado: detener, acotar, mitigar, verificar, publicar, aprender;
* los errores típicos (adopción sin criterio, revisión de estilo, no reproducible, firma decorativa, guion caliente, SaaS fuera de política) se previenen con las cuatro puertas;
* a nivel profesional: política con métricas y simulacros.

La idea principal es:

> **La confianza no se concede al instalar: se gobierna al entrar, se verifica al salir y se recupera con un guion ya escrito — el día del aviso, lo único que importa es acotar en minutos.**

---

## Próximo paso

Ya gobiernas la cadena completa.

El capítulo que cierra la sección: juntar todo en un programa con métricas, dueños y mejora continua.

Continúa con:

[`06-programa-de-seguridad-y-metricas.md`](06-programa-de-seguridad-y-metricas.md)
