# Gobernanza

## Introducción

Ya tienes estructura, plantillas, protecciones, releases y convenciones. La **gobernanza** es la capa que lo mantiene vivo: quién decide, cómo se proponen cambios, cómo se audita quién hizo qué y cómo se evita que el crecimiento convierta el orden en burocracia muerta.

Un repositorio profesional es código + documentación + colaboración + pruebas + automatización + seguridad + **gobierno**. Este capítulo cierra la sección con ese gobierno: roles de decisión, procesos ligeros, registro y auditoría.

---

## Mapa conceptual de este capítulo

```text
Gobernanza
       │
       ├── 1. Qué se gobierna (y qué no)
       ├── 2. Roles de decisión
       ├── 3. Procesos ligeros: RFC, cambios, incidentes
       ├── 4. Registro y auditoría
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué se gobierna (y qué no)

```text
GOBIERNA (decisión colectiva o con dueño):
   │
   ├── flujo de trabajo y política de ramas
   ├── convenciones y estructura
   ├── permisos y accesos (sección 16)
   ├── versiones y releases (sección 14/17/18)
   ├── dependencias y superficie de seguridad
   │   (sección 20/24)
   └── qué se acepta como «terminado» (DoD)
```

```text
NO GOBIERNA (o gobierna poco):
   │
   ├── el detalle de implementación (eso es revisión
   │   de PR + ADR)
   ├── decisiones individuales de código con tests
   └── todo lo que un linter puede hacer solo
```

```text
   │
   └── principio: lo mínimo necesario para que N
       personas trabajen sin sorpresas — y nada más
```

---

## 2. Roles de decisión

```text
MAPEO DE DECISIONES
──────────────────────────────────────────────────────
Decisión                  Quién la toma
──────────────────────────────────────────────────────
cambio de rutina (PR)     revisores del área
convención menor          quien mantiene el flujo
flujo/arquitectura        RFC + acuerdo del equipo
                          (lead decide si no hay
                          consenso)
permisos/accesos          admin/owner (registro)
release                   responsable de release
incidente de seguridad    rol de seguridad + lead
                          (sección 20/29)
```

```text
PRINCIPIOS:
   │
   ├── DRI (Directly Responsible Individual): toda
   │   decisión tiene un responsable con nombre
   │
   ├── escalada clara: ¿quién decide si el equipo no
   │   acuerda?
   │
   └── los roles se escriben en CONTRIBUTING/docs, no
       «se saben»
```

```text
   │
   └── sin DRI, las decisiones se «posponen» o las
       toma quien grita más alto
```

---

## 3. Procesos ligeros: RFC, cambios, incidentes

```text
RFC (para cambios de diseño/flujo que afectan a más
de un PR)
   │
   ├── dónde: Discussions o `docs/decisiones/` (ADR)
   ├── estructura: contexto → propuesta → consecuencias
   ├── ventana de comentario (p. ej. 3-5 días)
   └── decisión explícita al final (aceptada /
       rechazada / modificada) con DRI
```

```text
CAMBIOS A LA GOBERNANZA (permisos, plantillas, flujos)
   │
   ├── PR al documento afectado + anuncio
   ├── (si es crítico) ventana de revisión obligada
   └── registro en changelog de gobernanza o commit
       claro
```

```text
INCIDENTES (seguridad u operativos)
   │
   ├── protocolo escrito (sección 20/29):
   │   detectar → contener → comunicar → remediar →
   │   post-mortem sin culpa
   ├── quién lidera, dónde se habla (canal privado)
   └── post-mortem público/interno con acciones
       (con dueño y fecha)
```

```text
   │
   └── ligereza ≠ ausencia: un RFC de 10 páginas
       para un rename es burocracia; NINGÚN acuerdo
       para cambiar la política de ramas es caos
```

---

## 4. Registro y auditoría

```text
QUÉ REGISTRA LA PLATAFORMA:
   │
   ├── commits (autor, fecha, GPG si aplica)
   ├── PRs y sus revisiones (quién aprobó qué)
   ├── merges y tags
   ├── log de auditoría de org/repo (quién cambió
   │   permisos, ramas, apps — según plan)
   └── releases y sus artefactos
```

```text
QUÉ DEBES COMPLEMENTAR:
   │
   ├── decisiones en ADR/Discussions (el «por qué»
   │   no está en los logs)
   ├── accesos: alta/baja documentadas (sección 16)
   ├── incidentes: línea de tiempo (sección 29)
   └── post-mortems: lecciones y acciones con dueño
```

```text
REVISIONES PERIÓDICAS (checklist viva):
   │
   ├── trimestral: accesos, apps, dueños, bypass,
   │   dependencias
   │
   ├── por release: changelog, notas, versiones
   │
   └── anual: convenciones y flujo (¿siguen
       sirviendo?) — sección 17 cap. 06
```

```bash
# inspección local del «quién hizo qué»:
git shortlog -sn --all
git log --format='%h %an %ad %s' --date=short -20
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: gobernanza de una persona (el «benevolo dictador» único)

**Qué ocurrió:** todas las decisiones pasan por una sola persona; si se va, el proyecto se paraliza.

**Por qué:** crecimiento sin reparto (normal al inicio).

**Cómo comprobarlo:** ¿quién aprueba todo? ¿hay segundas firmas en áreas críticas?

**Opciones:** delegar por área (CODEOWNERS, revisores), documentar decisiones, formar relevo.

**Riesgos:** punto único de fallo humano.

**Solución:** DRI por área + segundo relevo (punto 2).

**Cómo se evita:** revisión de «bus factor» en la retro anual.

---

### Error 2: burocracia sin valor

**Qué ocurrió:** para cambiar un README hacen falta 2 aprobaciones, 1 RFC y una reunión; la gente deja de proponer.

**Por qué:** se añadieron reglas sin medir coste.

**Cómo comprobarlo:** tiempo de entrega; propuestas abandonadas.

**Opciones:** auditar reglas: ¿qué problema resuelve cada una?; eliminar lo que no proteja nada.

**Riesgos:** estancamiento creativo.

**Solución:** principio del punto 1 (lo mínimo).

**Cómo se evita:** cada regla nueva con hipótesis y fecha de revisión.

---

### Error 3: decisiones que no se registran

**Qué ocurrió:** en una reunión se decidió X; a los 3 meses nadie lo recuerda y se debate otra vez (o al revés).

**Por qué:** se habló sin dejar rastro.

**Cómo comprobarlo:** buscar «¿por qué usamos X?» en la doc: ¿hay ADR?

**Opciones:** escribir ADR retroactivo con fecha honesta; plantilla de acuerdo en el flujo.

**Riesgos:** el equipo re-aprende lo ya aprendido.

**Solución:** decisión = registro (punto 3).

**Cómo se evita:** checklist: «¿dónde queda escrito?».

---

### Error 4: auditoría reactiva (solo tras el incidente)

**Qué ocurció:** la primera revisión de accesos/apps pasó cuando ya hubo un problema.

**Por qué:** no había calendario.

**Cómo comprobarlo:** ¿última revisión de accesos? ¿cuándo fue?

**Opciones:** agendar revisiones trimestrales con dueño; empezar YA por apps y admins.

**Riesgos:** descubrir riesgo en el peor momento.

**Solución:** calendario de revisión (punto 4).

**Cómo se evita:** alertas de calendario + plantilla de checklist.

---

### Error 5: gobernanza no aplicable a los repos existentes

**Qué ocurció:** la nueva política aplica «desde hoy» a repos creados desde plantilla; los 50 viejos siguen igual y nadie sabe cuáles están cubiertos.

**Por qué:** sin plan de cobertura (sección 18 cap. 02).

**Cómo comprobarlo:** muestrear: ¿tienen protección? ¿CODEOWNERS?

**Opciones:** inventario + oleadas de migración; priorizar por riesgo (públicos, producción).

**Riesgos:** política a dos velocidades invisible.

**Solución:** cobertura medida (nº de repos conformes).

**Cómo se evita:** métrica de adopción en el plan de gobernanza.

---

### Error 6: gobernanza sin retro (la que nadie corrige)

**Qué ocurrió:** las reglas de 2023 siguen activas sin que nadie las haya revisado; contradicen el flujo real.

**Por qué:** nadie es dueño de revisar.

**Cómo comprobarlo:** fecha de última revisión de la política.

**Opciones:** dueño + fecha obligatoria en cada política; revisión anual en la planificación.

**Riesgos:** políticas muertas que se salpan.

**Solución:** gobernanza viva con calendario (punto 4).

**Cómo se evita:** «revisión de políticas» como epica recurrente.

---

## 6. Práctica guiada

### Objetivo

Montar el marco de gobernanza mínimo de un equipo: roles, decisiones y auditoría.

### Paso 1: mapa de decisiones

1. Escribe la tabla del punto 2 adaptada a tu equipo (quién decide cada cosa; quién escala).

### Paso 2: dónde viven las decisiones

```text
   │
   ├── decisiones de diseño → docs/decisiones/ (ADR)
   ├── decisiones de flujo/política → CONTRIBUTING
   ├── acuerdos abiertos → Discussions (con cierre
   │   de decisión)
   └── incidentes → plantilla de post-mortem
```

1. Crea `docs/decisiones/` con el ADR-0001 de una decisión real pendiente.

### Paso 3: RFC ligero

1. Para un cambio pendiente, abre un hilo/discusión con: contexto → propuesta → consecuencias → ventana de 5 días → decisión con DRI.

### Paso 4: calendario de auditoría

```text
[ ] trimestral: accesos (miembros, fuera-colab),
    apps instaladas, bypass, dueños
[ ] release: changelog/notas/tags
[ ] anual: convenciones + flujo + plantillas
```

1. Pon recordatorios reales con responsable.

### Paso 5: checklist de incidente

```markdown
## Post-mortem (plantilla)
- Qué pasó (línea de tiempo)
- Impacto
- Causas (sin culpa: sistema, no personas)
- Acciones con dueño y fecha
- ¿Qué señal falló?
```

### Paso 6: métricas de adopción

```text
   │
   ├── % de repos con protección + CODEOWNERS
   ├── edad de la última revisión de accesos
   └── decisiones sin ADR > 30 días
Publica el panel (aunque sea una tabla en docs).
```

### Resultado esperado

Tabla de roles, ADRs en curso, calendario de auditoría y métricas de adopción escritas.

### Conclusión esperada

La gobernanza ligera se sostiene con dueños, registros y calendarios — no con reuniones ni con la memoria de alguien.

---

## 7. Nivel profesional + resumen

### 7.1. Gobierno que escala sin ahogar

```text
NIVELES
──────────────────────────────────────────────────────
1. repo: roles en CONTRIBUTING + ADR puntuales
2. equipo: RFC ligero + calendario de revisiones +
   post-mortems
3. organización: políticas base (plantillas,
   rulesets, 2FA), log de auditoría, revisiones de
   accesos y apps
4. con compliance: controles explícitos, trazas y
   evidencias (mención: marcos formales)
```

```text
   │
   ├── la madurez se mide por cobertura y frescura:
   │   ¿cuántos repos cubiertos? ¿cuántas políticas
   │   revisadas este año?
   │
   └── la gobernanza sirve cuando acelera: menos
       dudas, menos atajos, menos incidentes
```

### 7.2. Resumen

En este capítulo aprendiste que:

* se gobierna lo que afecta a más de uno (flujo, convenciones, permisos, versiones, seguridad) — no el detalle de código;
* los roles de decisión se escriben con DRI y escalada clara;
* los procesos son ligeros: RFC/ADR para diseño y política, protocolo para incidentes con post-mortem sin culpa;
* el registro combina logs de la plataforma (quién) con decisiones documentadas (por qué); se audita con calendario;
* los errores típicos (dictador único, burocracia, decisiones no registradas, auditoría reactiva, cobertura incompleta, sin retro) se previenen con dueños y métricas;
* a nivel profesional: gobernanza por niveles con frescura y cobertura medidas.

La idea principal es:

> **Gobernar es poco y a menudo: decisiones con dueño y registro, accesos revisados en calendario y políticas que alguien se encarga de que sigan siendo ciertas.**

---

## Próximo paso

Has completado la sección de GitHub profesional.

Continúa con el cierre de la sección:

[`README.md`](README.md)
