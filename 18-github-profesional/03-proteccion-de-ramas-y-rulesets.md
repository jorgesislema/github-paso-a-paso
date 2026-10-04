# Protección de ramas y rulesets

## Introducción

Las reglas de rama son el sistema de frenos del repositorio: definen quién puede escribir en `main`, qué se exige antes de integrar (PRs, aprobaciones, checks) y qué está prohibido (fuerza, borrado). Sin ellas, todas las disciplinas anteriores son buenas intenciones.

Este capítulo cubre la protección clásica de ramas y su evolución, los *rulesets* (reglas más granulares y aplicables por diseño), y cómo configurarlas sin bloquear el trabajo legítimo — incluidas las excepciones conscientes para incidentes.

---

## Mapa conceptual de este capítulo

```text
Protección de ramas y rulesets
       │
       ├── 1. Qué protege y por qué niveles
       ├── 2. La protección clásica (branch protection)
       ├── 3. Rulesets: reglas granulares
       ├── 4. Excepciones, bypass y incidentes
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué protege y por qué niveles

```text
CAPAS DE ESCRITURA (repaso de la sección 16):
   │
   ├── rol en el repo (Write = puede pushear ramas)
   ├── PROTECCIÓN DE RAMA (¿puede pushear ESTA rama?
   │   ¿con qué condiciones?)
   └── permisos de plataforma/org (quién configura)
```

```text
QUÉ PROTEGE LA REGLA:
   │
   ├── qué ramas (main, release/*, patrones)
   ├── quién puede hacer push directo (nadie, o
   │   roles concretos)
   ├── quién puede integrar (PR obligatorio,
   │   aprobaciones, code owners)
   ├── qué debe pasar antes (checks, comentarios,
   │   resolución de hilos)
   └── qué está prohibido (force push, delete)
```

```text
   │
   └── regla de oro: la protección ES la política de
       flujo (sección 17) ejecutada por la plataforma
       — si no está escrita en reglas, no existe
```

---

## 2. La protección clásica (branch protection)

```text
Settings → Branches (o desde la rama) → Add branch
protection rule
```

```text
PATRÓN típico: main  (y release/* si usas Git Flow)
```

```text
AJUSTES RECOMENDADOS (mínimo serio)
──────────────────────────────────────────────────────
[✓] Require a pull request before merging
      · Require approvals: 1 (2 en áreas críticas)
      · Dismiss stale approvals on new commits
      · Require review from Code Owners
[✓] Require status checks to pass
      · añadir tus checks (lint, test) — necesitan
        haber corrido alguna vez para aparecer
[✓] Require conversation resolution before merging
[✓] Do not allow bypassing the above settings
      · salvo excepción consciente de Admin (ver 4)
[✓] Do not allow force pushes
[✓] Do not allow deletions
```

```text
DETALLLES QUE IMPORTAN:
   │
   ├── «Dismiss stale approvals»: si alguien aprueba
   │   y luego llegan más commits, la aprobación se
   │   invalida (evita aprobar código que ya no es el
   │   que se vio)
   │
   ├── checks requeridas: se eligen por NOMBRE; si
   │   renombras el job, actualiza la regla
   │
   └── incluir administradores (si está activo, las
       reglas también aplican a Admin — más fuerte;
       decide con el equipo)
```

```bash
# equivalente con gh (concepto):
gh api repos/{owner}/{repo}/branches/main/protection \
  -X PUT --input proteccion.json
# (la estructura JSON la define la API actual —
# ver docs; útil para versionar la protección)
```

---

## 3. Rulesets: reglas granulares

```text
QUÉ APORTAN FRENTE A LA PROTECCIÓN CLÁSICA:
   │
   ├── nombre y descripción (la regla se entiende)
   ├── patrones múltiples en una misma regla
   ├── reglas de CREACIÓN de rama (p. ej. obligar
   │   prefijo feat/ al crear — mención)
   ├── enforcement: activo / sobre advertencia
   │   (evaluate → advierte sin bloquear)
   ├── inclusión/exclusión de repos en la org
   │   (política central aplicada a muchos repos)
   └── roles que aplican la regla
```

```text
EJEMPLO DE POLÍTICA (org):
   │
   ├── ruleset «main-protegida» aplicada a todos los
   │   repos: PR + 1 aprobación + no force + no
   │   delete
   │
   └── ruleset «advertencia» inicial: primero en
       modo advertencia (dos semanas), luego bloqueo
       (cambio gestionado)
```

```text
   │
   ├── migrar: cuando la política de equipo crece,
   │   los rulesets reemplazan o complementan las
   │   reglas clásicas — revisa la documentación
   │   actual de la plataforma para el estado exacto
   │
   └── lo crucial es lo MISMO en ambos: política
       ejecutada, no aspiracional
```

---

## 4. Excepciones, bypass y incidentes

```text
QUÉ ES EL BYPASS:
   │
   ├── permite a roles concretos (p. ej. Admin)
   │   integrar sin cumplir la regla
   └── es una PUERTA: úsala conscientemente
```

```text
USO LEGÍTIMO DEL BYPASS (protocolo):
   │
   ├── hotfix en incidente: bypass + PR retroactivo
   │   + aviso en el canal (sección 29)
   ├── migración mecánica masiva (una vez, con plan)
   └── SIEMPRE: registro (quién, cuándo, por qué)
```

```text
PRÁCTICA RECOMENDADA:
   │
   ├── mínimo privilegio para bypass (1-2 roles)
   │
   ├── en org: intenta NO dar bypass global a todos
   │   los repos — deja que la política por defecto
   │   sea estricta
   │
   └── «incluye administradores» ON → los admins
       también cumplen (más fuerza, menos atajos)
```

```text
   │
   └── la excepción sin protocolo es una brecha con
       firma: si bypass es costumbre, la protección
       es decorativa
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: protección sin checks (o con checks que no existen)

**Qué ocurrió:** «Require status checks» marcado pero lista vacía → cualquier cosa pasa.

**Por qué posibles:**
* el job nunca corrió (no aparece en el desplegable);
* se renombró el job.

**Cómo comprobarlo:** abrir la regla: ¿checks seleccionadas? ¿corren en un PR reciente?

**Opciones:** seleccionar el job correcto; comprobar en PR que se exige.

**Riesgos:** falsa sensación de control.

**Solución:** definir checks desde un PR real (punto 2).

**Cómo se evita:** checklist de protección: «checks verdes obligatorias en el último PR».

---

### Error 2: demasiada protección (bloqueo del equipo)

**Qué ocurrió:** se exigen 2 aprobaciones + code owners + 3 checks y los PR tardan días → la gente busca atajos.

**Por qué posibles:**
* se copió política de banco a un equipo de 3;
* no hay revisores disponibles 24/7.

**Cómo comprobarlo:** tiempo de primera revisión y de merge; bypass frecuente.

**Opciones:** bajar a 1 aprobación; 2 solo en áreas críticas; revisar checks lentas (sección 19).

**Riesgos:** el proceso se salta (peor que no tenerlo).

**Solución:** protección proporcional al riesgo y a la capacidad (sección 16 cap. 06).

**Cómo se evita:** revisar tiempos en la retro.

---

### Error 3: main protegida… pero con bypass para todos

**Qué ocurrió:** cualquiera con rol admin/Write avanzado puede hacer lo que quiera → la regla solo frena a los nuevos.

**Por qué:** se dio bypass «para no bloquear».

**Cómo comprobarlo:** quién tiene bypass; «incluye administradores» OFF sin deliberación.

**Opciones:** quitar bypass general; «incluye administradores» ON; dejar bypass solo a 1-2 con protocolo.

**Riesgos:** dos velocidades de verdad.

**Solución:** bypass mínimo + registro (punto 4).

**Cómo se evita:** revisión de reglas al cambiar de fase.

---

### Error 4: renombrar el job y romper la regla

**Qué ocurrió:** se cambió `test` por `unit-tests` en el workflow → la regla pide `test` que ya no llega → todos los PR bloqueados.

**Por qué:** checks requeridas por nombre.

**Cómo comprobarlo:** PR bloqueado con «expected check not found».

**Opciones:** actualizar la regla al renombrar (en el mismo PR); o mantener nombre estable.

**Riesgos:** bloqueo total de integración.

**Solución:** renombrar checks = tocar protección (checklist).

**Cómo se evita:** configurar protección vía código cuando el equipo madura (la regla cambia con PR).

---

### Error 5: release/* sin protección (o con patrón mal escrito)

**Qué ocurrió:** Git Flow con main protegida pero release/* abierta a force push / merges directos.

**Por qué:** solo se protegió main (o el patrón `release/*` mal escrito).

**Cómo comprobarlo:** probar push a release de prueba; revisar patrones.

**Opciones:** añadir patrón; verificar con un intento real.

**Riesgos:** el estabilizador de la versión es el eslabón flojo.

**Solución:** proteger TODAS las ramas persistentes (main, develop, release/*).

**Cómo se evita:** inventario de ramas protegidas en la doc.

---

### Error 6: no incluir admins (y atajos invisibles)

**Qué ocurrió:** los admins «dejan pasar» cambios que ningún PR muestra → historial con huecos.

**Por qué:** la regla no aplica a quien la configura.

**Cómo comprobarlo:** «Include administrators»; revisar commits directos en main.

**Opciones:** activar inclusión; exigir excepciones con PR retroactivo.

**Riesgos:** auditoría incompleta.

**Solución:** nadie está por encima de la política salvo protocolo (punto 4).

**Cómo se evita:** regla de equipo: «si entró sin PR, hay nota en el canal».

---

## 6. Práctica guiada

### Objetivo

Configurar protección seria en un repo de prueba y verificarla con intentos reales.

### Paso 1: checks previas

1. Asegúrate de que el workflow de CI (sección 19) corre en PR y tiene un job estable (p. ej. `test`).

### Paso 2: crea la regla

```text
Branch protection → main:
   │
   ├── Require PR: 1 approval
   ├── Require status checks: test
   ├── Require review from Code Owners
   ├── Require conversation resolution
   ├── Dismiss stale approvals
   ├── No force pushes · No deletions
   └── Include administrators: ON (si el equipo lo
       acepta)
```

### Paso 3: verifica negativo

```bash
git switch main && git push . main:main
# (push directo local → debe rechazarse en remoto)
git push --force origin main
# → rechazado
```

### Paso 4: verifica positivo

1. Abre PR con un cambio → pide aprobación → comprueba que sin verde no se puede merge.

### Paso 5: simula stale approval

1. Aprueba el PR; añade un commit más; observa la aprobación invalidada (si está activa la opción).

### Paso 6: documenta el protocolo de bypass

```markdown
## Excepciones a la protección de main
- Solo en incidente (sección 29) con: aviso en canal,
  PR retroactivo en < 24h y nota en el changelog del
  incidente.
- Quienes pueden: (roles concretos).
```

### Resultado esperado

Protección activa verificada con pushes rechazados, merge condicionado y protocolo de excepción escrito.

### Conclusión esperada

La política de flujo solo existe cuando la plataforma la ejecuta — y la excepción es un procedimiento, no un atajo.

---

## 7. Nivel profesional + resumen

### 7.1. Protección a escala de organización

```text
   │
   ├── reglas por defecto para todos los repos (o
   │   reglas por grupo de repos) vía rulesets
   │   (punto 3)
   │
   ├── política versionada cuando el equipo madura
   │   (API/infra como código — mención)
   │
   ├── enforcement gradual: advertencia → bloqueo
   │
   ├── revisión trimestral: ¿bypass? ¿checks lentas?
   │   ¿patrones completos?
   │
   └── auditoría: log de quién cambió reglas y quién
       usó bypass (sección 18 gobernanza / 20)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* la protección de rama ejecuta la política: PR obligatorio, aprobaciones, code owners, checks, resolución de conversación, sin fuerza ni borrado;
* «dismiss stale approvals» evita aprobar código que ya cambió; las checks se exigen por nombre (cuidado al renombrar);
* los rulesets aportan nombre, patrones múltiples, modo advertencia y aplicación por organización — consultar la doc actual;
* el bypass es una puerta con protocolo: incidente + PR retroactivo + registro, con mínimo privilegio;
* los errores típicos (checks fantasma, exceso de freno, bypass general, rename de job, release sin proteger, admins excluidos) se previenen con verificación real y revisión;
* a nivel profesional: reglas por defecto de org, enforcement gradual y auditoría.

La idea principal es:

> **La rama protegida es donde la política deja de ser texto: exige lo que acordaste, falla cuando algo falta y solo se abre por protocolo — nunca por costumbre.**

---

## Próximo paso

Ya sabes frenar lo que no debe entrar.

El siguiente capítulo: cómo las entregas se publican — releases, artefactos y prereleases.

Continúa con:

[`04-releases-artefactos-y-versiones.md`](04-releases-artefactos-y-versiones.md)
