# Mantenimiento y vida del repositorio

## Introducción

Todo repositorio tiene un ciclo de vida: nace, crece, envejece y — a veces — termina. El mantenimiento es la disciplina que evita que la segunda etapa se convierta en ruina: dependencias vivas, deuda visible, artefactos y ramas sin estancar, y retiros hechos con respeto a quien depende de lo que se cierra. Este capítulo recorre la vida completa del repositorio, incluido su final: archivar, deprecar y retirar son operaciones tan importantes como crear.

---

## Mapa conceptual de este capítulo

```text
Mantenimiento y vida del repositorio
       │
       ├── 1. Las etapas de la vida
       ├── 2. Mantenimiento rutinario (el calendario)
       │   ├── 3. Deuda técnica: ver, medir, pagar
       │   └── 4. Estancamientos: ramas, PRs, artefactos
       │
       ├── 5. Cómo termina un repositorio (deprecar,
       │   archivar, borrar)
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Las etapas de la vida

```text
CICLO (sin mitología — todo repo lo vive):
   │
   ├── 1. inicio: estructura, README, checks base
   │   (sección 14/18)
   ├── 2. crecimiento: PRs, features, más gente
   │   (sección 15/16)
   ├── 3. madurez: estabilidad, releases, dependencias
   │   (sección 17/20/22)
   ├── 4. mantenimiento: solo cambios necesarios,
   │   renovación (aquí)
   └── 5. retiro: deprecar → archivar → (borrar) —
       punto 5
```

```text
   │
   └── cada etapa pide DISTINTAS prácticas: los
       procesos de «crecimiento» aplicados a un repo
       en «mantenimiento» consumen energía inútil
       (Error 1 si nadie sabe en qué etapa está)
```

---

## 2. Mantenimiento rutinario (el calendario)

```text
LO QUE SE HACE EN CALENDARIO (sección 23 cap. 01 —
todo lo que importa tiene dueño y fecha):
   │
   ├── semanal/mensual: dependencias (Dependabot —
   │   sección 20 cap. 03), issues con dueño, PRs
   │   estancados (punto 4)
   │
   ├── trimestral: secretos y tokens (rotación —
   │   sección 20 cap. 01), accesos (Error 3 de
   │   sección 03 cap. 03), versiones del estándar
   │   (sección 04 de esta sección)
   │
   ├── semestral: revisión de protección de ramas,
   │   permisos, métricas (sección 24 cap. 06)
   │
   └── anual: archivar lo muerto, actualizar docs
       raíz (sección 14 cap. 03), revisar etapa y
       arquitectura (sección 01/26 de esta sección)
```

```text
   │
   └── el calendario es DUEÑO + FECHA + CHECKLIST:
       sin eso es una intención (Error 2 — mismo
       criterio que toda política, sección 03 cap. 03)
```

---

## 3. Deuda técnica: ver, medir, pagar

```text
DEUDA (definición operativa): trabajo que HOY es
barato postergar y caro después
   │
   ├── versiones viejas con CVE (sección 20 cap. 03)
   ├── TODO/FIXME acumulados (sección 21/22)
   ├── docs que mienten (sección 14)
   └── dependencias internas huérfanas (sección 01
       cap. 03 Error 5)
```

```text
CICLO HONESTO (Error 4 si se hace de otro modo):
   │
   ├── 1. ver: inventario (issues con label `deuda` o
   │   lista en docs)
   ├── 2. medir: crece o baja? (métrica — sección 24
   │   cap. 06 punto 3)
   ├── 3. pagar: % de capacidad en cada sprint/ciclo
   │   (no «cuando haya tiempo» — Error 4)
   └── 4. evitar: los tickets nuevos nacen con checklist
       de calidad (sección 15)
```

```text
   │
   └── deuda VISIBLE es manejable; escondida es
       fraude contable (Error 5 — los `misc/` de
       sección 02 cap. 06 son deuda en forma de
       carpeta)
```

---

## 4. Estancamientos: ramas, PRs, artefactos

```text
LOS TRES ESTANCAMIENTOS CLÁSICOS:
   │
   ├── ramas viejas: viven meses, divergen, aterran
   │   (Error 6 — sección 07/17: regla de días y
   │   limpieza periódica)
   │
   ├── PRs abiertos sin revisor: el ejemplo que nadie
   │   revisa enseña «aquí no se revisa» (Error 7 —
   │   sección 15 cap. 06: dueños, SLA de revisión,
   │   limitar abiertos)
   │
   └── artefactos y artefactos de CI: runs viejos,
       paquetes, imágenes sin tag — almacenan basura
       y dinero (sección 22 cap. 05: retención con
       política)
```

```text
   │
   └── la limpieza es UN trabajo del calendario (punto
       2), con dueño — no un heroísmo de viernes
```

---

## 5. Cómo termina un repositorio (deprecar, archivar, borrar)

```text
SECUENCIA (nunca saltar pasos — Error 8):
   │
   ├── 1. deprecar: anuncio + fecha + alternativa
   │   (issues/discussions + banner en README —
   │   sección 14/16)
   │
   ├── 2. congelar: ramas protegidas, solo fixes de
   │   seguridad (sección 20)
   │
   ├── 3. archivar: GitHub ARCHIVA (lectura + clon
   │   posible, sin escritura/PRs/issues) — el
   │   historial queda para siempre
   │
   └── 4. borrar (solo si aplica): eliminar es PERDER
       referencias, enlaces y espejos — requiere
       dueño del ecosistema + confirmación de que nadie
       lo clona/depende (inventario — sección 03)
```

```text
ADVERTENCIA (antes de borrar — sección 08 cap. 03):
   │
   ├── buscar referencias: ¿otros repos lo importan?
   │   ¿scripts? ¿documentación externa?
   ├── clonar de seguridad si hay duda
   └── borrar es la única operación IRREVERSIBLE del
       repositorio (Error 8)
```

```text
   │
   └── el retiro exitoso es aquel donde el último
       usuario fue informado con tiempo y tenía
       alternativa (Error 1)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: repos en etapa equivocada

**Qué ocurrió:** un proyecto estable seguía con workflows de «nuevo proyecto»: comités, plantas de features, sin dueño de mantenimiento.

**Por qué:** nadie definió la etapa (punto 1).

**Cómo comprobarlo:** pregunta: ¿qué etapa es y quién lo dice?

**Opciones:** declarar etapa + prácticas correspondientes (punto 1).

**Riesgos:** energía gastada donde no toca.

**Solución:** etapa declarada (punto 1).

**Cómo se evita:** revisión anual de cartera (punto 2).

---

### Error 2: mantenimiento «cuando haya tiempo»

**Qué ocurrió:** nunca hubo tiempo; las dependencias acumularon 14 meses de CVEs.

**Por qué:** sin calendario ni dueño (punto 2).

**Cómo comprobarlo:** ¿hay fecha de última renovación y próxima?

**Opciones:** calendario con dueños (punto 2) + automatizar lo automatizable (Dependabot).

**Riesgos:** deterioro compuesto.

**Solución:** calendario real (punto 2).

**Cómo se evita:** la retro pregunta «¿se cumplió el mantenimiento?».

---

### Error 3: deuda escondida

**Qué ocurrió:** nadie sabía cuántos TODO había; el estallido fue un mes de paralización.

**Por qué:** sin ver ni medir (punto 3).

**Cómo comprobarlo:** cuenta TODO/FIXME/labels de deuda; ¿hay tendencia?

**Opciones:** inventario + métrica + capacidad reservada (punto 3).

**Riesgos:** sorpresa cara.

**Solución:** ver, medir, pagar (punto 3).

**Cómo se evita:** deuda etiquetada desde el día 1.

---

### Error 4: deuda con «resolvemos cuando haya tiempo»

**Qué ocurrió:** misma historia que Error 2, esta vez para código: la deuda seguía creciendo.

**Por qué:** sin capacidad asignada (punto 3).

**Cómo comprobarlo:** ¿algún ciclo dedicó tiempo real a deuda?

**Opciones:** porcentaje fijo (10–20 %) en cada ciclo.

**Riesgos:** póliza de deuda infinita.

**Solución:** capacidad con nombre (punto 3).

**Cómo se evita:** métrica «deuda abierta > 90 días».

---

### Error 5: ramas eternas

**Qué ocurrió:** una rama de 8 meses chocó con 40 commits; nadie la quiso rebasear.

**Por qué:** sin regla ni limpieza (punto 4).

**Cómo comprobarlo:** `git branch -vv` con fechas; ¿ramas > días acordados?

**Opciones:** regla de días + limpieza automática de huérfanas; avisos en PRs viejos.

**Riesgos:** merge imposible.

**Solución:** caducidad (punto 4).

**Cómo se evita:** plantilla con la regla (sección 18).

---

### Error 6: PRs que nadie revisa

**Qué ocurrió:** 27 PRs abiertos; el más viejo, 3 meses; el equipo dejó de abrir más.

**Por qué:** sin SLA ni dueños de revisión (punto 4 — sección 15 cap. 06).

**Cómo comprobarlo:** antigüedad de PRs abiertos y % con revisor asignado.

**Opciones:** asignar dueños, SLA de primera revisión, limitar PRs simultáneos.

**Riesgos:** estancamiento cultural.

**Solución:** revisión con dueño y plazo (punto 4).

**Cómo se evita:** métrica de antigüedad en la retro.

---

### Error 7: artefactos que crecen para siempre

**Qué ocurrió:** el storage de artefactos pasó a costar más que el runner.

**Por qué:** sin política de retención (punto 4 — sección 22 cap. 05).

**Cómo comprobarlo:** ¿hay retención configurada? ¿última revisión de consumo?

**Opciones:** retención por tipo de artefacto; purgas automáticas; comprimir lo que se conserva.

**Riesgos:** factura y lentitud.

**Solución:** política de retención (punto 4).

**Cómo se evita:** consumo como métrica revisada.

---

### Error 8: borrar sin deprecar

**Qué ocurrió:** se borró «un repo sin actividad» del que 3 sistemas seguían clonando.

**Por qué:** se saltó secuencia e inventario (punto 5).

**Cómo comprobarlo:** antes de borrar: ¿buscaste referencias? ¿clonaste respaldo?

**Opciones:** restaurar desde respaldo si existe; reconstruir si no (el historial se perdió).

**Riesgos:** pérdida irreversible (sección 08 cap. 03).

**Solución:** deprecar → congelar → archivar → borrar (punto 5).

**Cómo se evita:** checklist de retiro con dueño del ecosistema.

---

## 7. Práctica guiada

### Objetivo

Poner en orden la vida de tus repositorios: etapa, calendario, deuda y retiro.

### Paso 1: etapa

```text
Cada repo: ¿inicio · crecimiento · madurez ·
mantenimiento · retiro?
   │
   └── anótalo (README o doc de cartera)
```

### Paso 2: calendario

1. Escribe la tabla del punto 2 con tu frecuencia y TUS dueños (aunque seas 1: nómbrate).

### Paso 3: deuda

```text
1. Cuenta TODO/FIXME + deps viejas
2. Crea label/inventario de deuda
3. Reserva capacidad: ____ % del próximo ciclo
```

### Paso 4: estancamientos

1. Ramas con fecha: ¿cuáles superan la regla? Ciérralas (merge o borrar — sección 07).
2. PRs abiertos: ¿cuál es el más viejo y quién lo revisa? Asigna dueño y SLA.
3. Artefactos: comprueba política de retención (sección 22 cap. 05).

### Paso 5: retiro pendiente

1. ¿Hay repos muertos? Pon en marcha la secuencia del punto 5: anuncio de deprecación con fecha.
2. Nada de borrar hoy: hoy solo se anuncia.

### Paso 6: documenta

```markdown
## Vida del repositorio
- Etapa actual: [etapa]
- Calendario de mantenimiento: [tabla + dueños]
- Deuda: [inventario + % de capacidad]
- Retiros en curso: [cuáles y su fecha]
```

### Resultado esperado

Etapas declaradas, calendario con dueños, inventario de deuda y un retiro iniciado por la vía correcta.

### Conclusión esperada

Un repositorio no se cuida con arrebatos: se mantiene con calendario, se audita con contabilidad honesta y se retira con respeto a quien aún lo usa.

---

## 8. Nivel profesional + resumen

### 8.1. Cartera de repositorios a escala

```text
   │
   ├── inventario de cartera: cada repo con dueño,
   │   etapa, última actividad, versión del estándar
   │   (Error prevención: nada huérfano)
   │
   ├── retención y coste: runners, storage, dependencias
   │   — métricas económicas del ecosistema
   │
   ├── retiro como proceso formal: RFC de retiro,
   │   comunicado, fecha, archivado, verificación de
   │   dependencias (sección 03 cap. 03 — registro)
   │
   ├── renovación continua: dependencias, tokens,
   │   versiones del estándar en un solo calendario
   │   maestro
   │
   └── métricas: PRs con antigüedad > SLA, deuda > 90
       días, repos sin actividad archivados, costo
       mensual del ecosistema
```

### 8.2. Resumen

En este capítulo aprendiste que:

* los repositorios tienen etapas con prácticas distintas — declarar la etapa evita gastar donde no toca;
* mantenimiento = calendario con dueños: dependencias, accesos, versiones, limpiezas;
* la deuda técnica se ve, se mide y se paga con capacidad reservada — escondida es fraude;
* estancamientos (ramas, PRs, artefactos) se gestionan con reglas, SLA y retención;
* el retiro tiene secuencia: deprecar → congelar → archivar → borrar (borrar es irreversible);
* los errores típicos (etapa equivocada, «cuando haya tiempo», deuda oculta, ramas eternas, PRs sin revisor, storage infinito, borrado sin aviso) se previenen con proceso;
* a nivel profesional: cartera con dueños, coste medido y retiro formal.

La idea principal es:

> **La salud de un repositorio no se mide en lo que se añade, sino en lo que se mantiene vivo y en lo que se retira a tiempo — ambos con calendario, dueño y registro.**

---

## Próximo paso

Ya sabes construir, gobernar y mantener arquitectura.

La última pregunta es cómo ELEGIR: contexto, consecuencias y decisiones registradas.

Continúa con:

[`06-como-decidir-el-contexto.md`](06-como-decidir-el-contexto.md)
