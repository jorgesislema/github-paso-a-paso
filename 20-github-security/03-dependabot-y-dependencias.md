# Dependabot y dependencias

## Introducción

Casi ningún proyecto vive solo: importa bibliotecas, acciones de CI y herramientas. Cada dependencia es una decisión de confianza y una superficie de riesgo que cambia con el tiempo. Este capítulo cubre el ciclo de vida de dependencias en GitHub: alertas de vulnerabilidades, actualizaciones automáticas con Dependabot, versionado consciente y la relación entre dependencias, errores de compilación y cadena de suministro.

---

## Mapa conceptual de este capítulo

```text
Dependabot y dependencias
       │
       ├── 1. El inventario: qué dependes de qué
       │   ├── 2. Alertas: vulnerabilidades detectadas
       │   ├── 3. Dependabot: actualizaciones
       │   ├── 4. Versionado y confianza
       │   └── 5. Dependencias de CI (Actions) y del SO
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El inventario: qué dependes de qué

```text
TRES LISTAS DIFERENTES:
   │
   ├── runtime: lo que tu producto ejecuta (imports
   │   del código)
   │
   ├── dev/CI: linters, frameworks de test, actions —
   │   no llega a producción, pero compromete tu CI
   │
   └── plataforma/infra: SO del runner, versiones de
       intérpretes (node, python…)
```

```text
ARCHIVOS DE INVENTARIO (ejemplos):
   │
   ├── package-lock.json / pnpm-lock / yarn.lock
   ├── requirements.txt / poetry.lock / uv.lock
   ├── Cargo.lock / go.sum / Gemfile.lock
   └── Dockerfile (imágenes base) · .github/workflows
       (actions)
```

```text
   │
   ├── el lockfile es la fuente de verdad de QUÉ se
   │   instala (y debe versionarse)
   │
   └── inventario = lockfiles + actions + imágenes:
       todo lo que puede traer código ajeno
```

```bash
# dependencias de runtime (ejemplo node):
npm ls --depth=0
# acciones usadas en CI:
grep -rho "uses: [^ ]*" .github/workflows/ | sort -u
```

---

## 2. Alertas: vulnerabilidades detectadas

```text
QUÉ SON:
   │
   └── la plataforma conoce CVEs/avisos de ecosistemas
       y te avisa cuando tu lockfile/versiones usan una
       versión vulnerable
```

```text
ANATOMÍA DE UNA ALERTA:
   │
   ├── qué dependencia, qué versión, qué vulnerabilidad
   │   (identificador público)
   │
   ├── severidad y ruta (directa o transitiva)
   │
   └── parche disponible: versión corregida
```

```text
RESPUESTA TÍPICA:
   │
   ├── 1. evaluar: ¿es real para tu caso de uso? (la
   │   ruta de explotación te afecta)
   │
   ├── 2. actualizar (dependencia directa + lockfile)
   │   → pasar tests
   │
   ├── 3. si no hay parche: mitigación (workaround,
   │   desactivar el camino afectado) y seguimiento
   │
   └── 4. cerrar alerta con el commit que la resuelve
```

```text
   │
   └── trampa: alerta ≠ incidente, pero «mañana
       miro» sin fecha es deuda (Error 2)
```

---

## 3. Dependabot: actualizaciones

```text
DOS FUNCIONES:
   │
   ├── Dependabot ALERTS: detecta vulnerabilidades
   │   (punto 2)
   │
   └── Dependabot VERSION UPDATES: abre PRs
       actualizando dependencias según tu calendario
```

```yaml
# .github/dependabot.yml (esquema actual):
version: 2
updates:
  - package-ecosystem: "npm"        # ecosistema
    directory: "/"                   # dónde vive el
                                     # manifest
    schedule:
      interval: "weekly"             # cadencia
    groups:                          # agrupar para
      dev-dependencies:              # menos PRs
        patterns: ["*"]
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

```text
QUÉ ELEGIR:
   │
   ├── semanal como base; diario en repos muy activos
   │
   ├── agrupar (groups) para reducir ruido de PRs
   │
   ├── SIEMPRE incluir github-actions (sección 19
   │   cap. 05)
   │
   └── versiones mayores: configurar si se aceptan
       automático o solo aviso (revisión humana)
```

```text
FLUJO DE PR DE DEPENDABOT:
   │
   ├── el PR pasa por CI como cualquier otro (sección
   │   15)
   │
   ├── si el ecosistema lo permite, actualización
   │   automática al verde (según config)
   │
   └── merge con revisión mínima: changelog + tests
```

---

## 4. Versionado y confianza

```text
SEMVER Y MÁS ALLÁ:
   │
   ├── lockfile fija la versión probada (¿qué usas
   │   aunque pediste ^1.2.0?)
   │
   └── el «semver» es intención del mantenidor, no
       garantía: revisa changelogs de majors
```

```text
CONFIANZA DE UNA DEPENDENCIA:
   │
   ├── mantenimiento vivo, releases, transparencia
   ├── tamaño/uso: muy popular ≠ invulnerable, pero
   │   auditado por más gente
   ├── postinstall/scripts: los scripts de instalación
   │   son código ejecutado en TU máquina/CI — riesgo
   │   de cadena de suministro (cap. 05)
   │
   └── alternativas: ¿la necesitas? (menos deps =
       menos riesgo)
```

```text
   │
   └── política práctica: deps nuevas se discuten en
       el PR (¿por qué? ¿mantenida? ¿alternativa?) —
       sección 26 hace esto una disciplina
```

---

## 5. Dependencias de CI (Actions) y del SO

```text
ACTIONS:
   │
   ├── inventario con grep (punto 1)
   │
   ├── renovación con Dependabot (ecosystem
   │   github-actions) — p. ej. checkout v4 → v5
   │
   └── fijado por SHA/tag mayor (sección 19 cap. 05)
```

```text
IMÁGENES BASE Y RUNNERS:
   │
   ├── Dockerfile: ¿base con versión fija? ¿se
   │   actualiza? (dependabot también cubre
   │   dockerfiles según config)
   │
   └── runners gestionados: parches del SO son de la
       plataforma (sección 19) — tú vigilas
       intérpretes (setup-* con versiones fijas)
```

```text
   │
   └── la vulnerabilidad de CI también es
       vulnerabilidad: comprometer tu pipeline es
       comprometer tu release (sección 24)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: sin lockfile versionado

**Qué ocurrió:** CI instalaba versiones distintas a las probadas localmente; nadie sabía qué había en producción.

**Por qué:** .gitignore mal extendido (sección 13) o prisa.

**Cómo comprobarlo:** ¿existe en el repo? ¿los diffs lo mueven?

**Opciones:** versionarlo; regenerarlo desde cero si está corrupto.

**Riesgos:** no-reproducibilidad + vulnerabilidades invisibles.

**Solución:** lockfile = código (punto 1).

**Cómo se evita:** checklist de init (sección 02).

---

### Error 2: alertas acumuladas

**Qué ocurrió:** decenas de alertas abiertas «desde hace meses».

**Por qué:** sin dueño ni SLA; se confunde gravedad con urgencia.

**Cómo comprobarlo:** panel de seguridad del repo: nº y antigüedad.

**Opciones:** triaje (afecta/no afecta), parches por prioridad, mitigaciones, SLA por severidad.

**Riesgos:** el incidente real se pierde en el ruido.

**Solución:** flujo con dueño (punto 2/6).

**Cómo se evita:** revisión mensual en gobernanza.

---

### Error 3: Dependabot PRs rotos ignorados

**Qué ocurrió:** los PRs de Dependabot fallaban CI y nadie los tocaba; las dependencias quedaron congeladas años atrás.

**Por qué:** PRs automáticos sin dueño ni ritual de merge.

**Cómo comprobarlo:** PRs abiertos de dependabot + su estado de checks.

**Opciones:** tiempo fijo mensual para mergear; groups para menos PRs; merge automático de minor/patch cuando CI pasa.

**Riesgos:** inercia → salto gigante doloroso después.

**Solución:** rutina de mantenimiento (punto 3).

**Cómo se evita:** cadencia en el calendario del equipo (sección 26).

---

### Error 4: salto de versión mayor sin revisar

**Qué ocurrió:** actualización mayor «para cerrar la alerta» rompió APIs en producción.

**Por qué:** changelog no leído; CI no cubría el camino afectado.

**Cómo comprobarlo:** diff del paquete; qué cambió de API; qué tests fallaron.

**Opciones:** revertir; subir por partes; ampliar tests antes de reintentar.

**Riesgos:** pánico y saltos mayores sin control.

**Solución:** majors con revisión (punto 3).

**Cómo se evita:** PRs de Dependabot separados por tipo.

---

### Error 5: dependencias que nadie usa (superficie muerta)

**Qué ocurrió:** el inventario tenía 20 libs y solo 6 se importaban; 3 con alertas sin uso real.

**Por qué:** nadie depura.

**Cómo comprobarlo:** análisis de imports/`npm ls`; alertas sobre paquetes no usados.

**Opciones:** eliminar; documentar las que se dejan «por si acaso».

**Riesgos:** superficie de ataque gratuita.

**Solución:** menos dependencias (punto 4).

**Cómo se evita:** revisión de deps en retiros de features.

---

### Error 6: acciones de CI fuera del inventario

**Qué ocurrió:** secret scanning y dependencias estaban verdes, pero una action sin actualizar llevaba un año con un problema conocido.

**Por qué:** solo se miraban manifestos de runtime.

**Cómo comprobarlo:** grep de `uses:` (punto 1) vs. la config de Dependabot.

**Opciones:** añadir ecosystem github-actions; fijar y renovar.

**Riesgos:** CI como caballo de Troya.

**Solución:** inventario completo de tres listas (punto 1).

**Cómo se evita:** checklist de repos.

---

## 7. Práctica guiada

### Objetivo

Poner el inventario y la renovación automática de un proyecto al día.

### Paso 1: inventario

```bash
git ls-files | grep -E "(lock|requirements|go.sum|Cargo.lock)"
grep -rho "uses: [^ ]*" .github/workflows/ | sort -u
docker images  # si trabajas con Dockerfiles: revisa bases
```

1. Lista las tres categorías (runtime, dev/CI, plataforma).

### Paso 2: dependabot.yml

```text
Crea .github/dependabot.yml con:
   │
   ├── tu ecosistema de runtime (weekly + groups)
   └── github-actions (weekly)
```

1. Commit en main y observa cómo aparece la config.

### Paso 3: alertas

1. Abre el panel de seguridad: ¿hay alertas? Aplica el flujo del punto 2 a la primera (evaluar → parchear → cerrar).

### Paso 4: PR de ejemplo

1. Espera o provoca (bump manual de una dev-dep) un PR de actualización y llévalo por CI completo como un PR normal (sección 15).

### Paso 5: política

```markdown
## Dependencias
- Lockfiles: versionados siempre
- Actualizaciones: Dependabot semanal; merge mensual
  con 30 min fijos
- Majors: revisar changelog + tests ampliados
- Acciones: fijadas + renovadas por Dependabot
- Dependencias nuevas: justificación en el PR
```

### Paso 6: métrica

1. Anota: alertas abiertas, días desde la más antigua y nº de PRs de Dependabot activos.

### Resultado esperado

Inventario claro, Dependabot activo en runtime y actions, alertas en flujo y política escrita.

### Conclusión esperada

Las dependencias se gestionan como todo lo demás: inventario, dueño, cadencia y criterio — el caos llega cuando nadie mira el panel.

---

## 8. Nivel profesional + resumen

### 8.1. Gestión de dependencias a escala

```text
   │
   ├── alertas con SLA por severidad (sección 24)
   │
   ├── Dependabot con groups + merge automático de
   │   parches donde el riesgo lo permite
   │
   ├── SBOM y trazabilidad de releases (cap. 05)
   │
   ├── revisión trimestral de superficie: deps muertas,
   │   majors pendientes, imágenes base
   │
   ├── dependencias nuevas: RFC corto en el PR (sección
   │   26)
   │
   └── métrica: % de alertas resueltas en SLA; días de
       retraso medio de actualizaciones
```

### 8.2. Resumen

En este capítulo aprendiste que:

* inventario de tres listas (runtime, CI, plataforma) con lockfiles versionados;
* alertas de vulnerabilidades: evaluar, parchear, cerrar con commit — con dueño y SLA;
* Dependabot para calendario de actualizaciones: ecosistemas, groups, actions incluidas;
* confianza: semver intención, changelogs en majors, scripts de instalación como riesgo;
* los errores típicos (sin lockfile, alertas acumuladas, PRs ignorados, salto ciego, deps muertas, actions olvidadas) se previenen con rutina;
* a nivel profesional: métricas de SLA y superficie mínima.

La idea principal es:

> **Una dependencia es confianza prestada: se lleva inventario, se renueva en calendario y se devuelve cuando deja de servir — el panel de seguridad es tu correa de reversa.**

---

## Próximo paso

Ya gestionas la superficie de dependencias.

Ahora el escaneo del código que tú escribes.

Continúa con:

[`04-code-scanning-y-codeql.md`](04-code-scanning-y-codeql.md)
