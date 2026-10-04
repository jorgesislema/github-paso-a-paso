# Variables y secretos

## Introducción

Todo workflow necesita datos: una URL, un nivel de log, un token para publicar. Distinguir **variables** (públicas o configurables) de **secretos** (credenciales) y entender cómo llegan al runner es conocimiento crítico: aquí se decide si tu automatización es segura o una fuga en potencial.

Este capítulo cubre los ámbitos de variables (repo, org, entorno, workflow), los secretos y su rotación, el `GITHUB_TOKEN` que Actions otorga por defecto y las reglas para no imprimir secretos en logs.

---

## Mapa conceptual de este capítulo

```text
Variables y secretos
       │
       ├── 1. Ámbitos de variables (y jerarquía)
       ├── 2. Secretos: dónde viven y cómo usarlos
       ├── 3. El token implícito: GITHUB_TOKEN
       ├── 4. Higiene: nunca en logs ni en el repo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Ámbitos de variables (y jerarquía)

```text
DÓNDE VIVEN (de más a menos amplio):
   │
   ├── secretos/variables de ORG    (con herencia a
   │   repos; revisar herencia)
   ├── secretos/variables de REPO   (Settings →
   │   Secrets and variables → Actions)
   ├── secretos de ENVIRONMENT      (staging/produccion
   │   — cap. 03/05)
   ├── variables en el WORKFLOW     (env: en el yaml)
   └── variables del sistema        (GITHUB_*, RUNNER_*)
```

```yaml
env:
  LOG_LEVEL: debug          # en el workflow

jobs:
  test:
    env:
      ENTORNO: pruebas      # en el job
    steps:
      - run: echo "$LOG_LEVEL / $ENTORNO"
      - run: echo "${{ vars.URL_BASE }}"
```

```text
USO:
   │
   ├── vars.* → valores no sensibles (URLs, flags,
   │   versiones)
   ├── secrets.* → credenciales (secrets.X)
   └── la referencia `${{ secrets.X }}` se sustituye
       ANTES de ejecutar el step → si la pones en un
       `run: |` mal escrito, puede acabar en el log
       (punto 4)
```

```text
REGLA DE ORO:
   │
   └── lo que no debe ser público → SECRETOS; lo que
       cambia por entorno → variable de ENVIRONMENT;
       lo que es constante de config → vars
```

---

## 2. Secretos: dónde viven y cómo usarlos

```yaml
jobs:
  publicar:
    environment: produccion        # secretos del env
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Publicar
        env:
          API_KEY: ${{ secrets.API_KEY }}
        run: ./scripts/publicar.sh   # lee $API_KEY
```

```text
BUENAS PRÁCTICAS DE SECRETOS:
   │
   ├── pasar por `env:` del step, NO interpolando
   │   dentro del comando:
   │
   │   ✗ run: curl -H "Auth: ${{ secrets.API_KEY }}"
   │     (puede terminar en el log del shell)
   │   ✓ run: curl -H "Auth: $API_KEY"
   │     env:
   │       API_KEY: ${{ secrets.API_KEY }}
   │
   ├── un secreto por ENTORNO (staging ≠ prod)
   │
   ├── rotación: los secretos tienen fecha de vida
   │   (sección 13/20) — anota cuándo rotar
   │
   └── mínima exposición: si un job no lo usa, no lo
       tiene
```

```text
DÓNDE NO VAN LOS SECRETOS:
   │
   ├── en el repo (ni en `.env` versionado) — cap. 05
   │   sección 13
   ├── en imágenes/artefactos (cachéa con cuidado)
   └── en forks (no los reciben — cap. 05)
```

```bash
# script que recibe el secreto por variable de
# entorno (el lenguaje lo lee sin imprimir):
#   os.environ["API_KEY"]  /  $API_KEY
```

---

## 3. El token implícito: GITHUB_TOKEN

```text
QUÉ ES:
   │
   └── un token de corta vida que Actions genera por
       ejecución y que el workflow puede usar para
       llamar a la API de GitHub (commits, issues,
       releases, packages…)
```

```yaml
permissions:              # mínimo privilegio (cap. 05)
  contents: write         # p. ej. para push de tag
```

```text
USO Y LÍMITES:
   │
   ├── disponible como env por defecto en los steps
   │   (GITHUB_TOKEN) — los actions/checkout lo
   │   configura para git push si permissions lo
   │   permite
   │
   ├── no lo confundas con un PAT: el token de la
   │   ejecución muere con ella y respeta
   │   `permissions`
   │
   └── para API externas (otra plataforma) usa
       secretos propios con alcance mínimo
```

```text
   │
   └── el `permissions:` del workflow decide el
       PODER de este token — sin declararlo, hereda
       permisos potencialmente amplios según
       configuración del repo/org (cap. 05)
```

---

## 4. Higiene: nunca en logs ni en el repo

```text
RIESGO HABITUAL: EL LOG
   │
   ├── la plataforma enmascara secretos REGISTRADOS
   │   como secretos de la plataforma (buena capa) —
   │   PERO:
   │   │
   │   ├── un secreto que pases por otra variable o
   │   │   transformado (base64) puede no enmascararse
   │   └── la protección no es una excusa para
   │       imprimirlos
   │
   └── regla: los secretos viajan por env y se usan
       sin echo/set -x
```

```text
CHECKLIST ANTES DE PUBLICAR UN WORKFLOW:
   │
   ├── [ ] ¿algún `run` con `${{ secrets.` dentro de
   │       la línea del comando? → mover a env:
   ├── [ ] ¿scripts con `set -x` o `echo $VAR`?
   ├── [ ] ¿el artefacto incluye .env o config con
   │       credenciales?
   └── [ ] ¿el fork/PR recibirá este workflow con
           secretos? (cap. 05)
```

```text
SI SE FILTRA UN SECRETO DE ACTIONS:
   │
   └── flujo de incidente (cap. 05 sección 13):
       ROTAR → acotar (¿quién lo vio? logs, forks) →
       limpiar si procede → post-mortem
```

```bash
# patrón seguro de uso en step:
#   env:
#     TOKEN: ${{ secrets.DEPLOY_TOKEN }}
#   run: |
#     ./deploy.sh --token "$TOKEN"    # el script no
#                                     # imprime
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: secreto como variable (o al revés)

**Qué ocurrió:** la API_KEY estaba en `vars` (visible) o URLs en `secrets` (imposibles de revisar).

**Por qué:** se confundieron ámbitos.

**Cómo comprobarlo:** Settings → Secrets and variables; ¿qué contiene cada uno?

**Opciones:** mover con criterio (punto 1); rotar si la key estuvo en vars (estuvo expuesta a quien lea settings/PRs).

**Riesgos:** exposición o inutilidad.

**Solución:** regla de oro del punto 1.

**Cómo se evita:** checklist de alta de configuración.

---

### Error 2: secreto en la línea del comando

**Qué ocurrió:** log con `curl -H "Auth: ghp_…"` (o parte).

**Por qué:** `${{ secrets.X }}` interpolado dentro de `run:`.

**Cómo comprobarlo:** leer el log; buscar el patrón.

**Opciones:** mover a `env:` (punto 2); si se filtró → rotar (incidente).

**Riesgos:** credencial en logs almacenados.

**Solución:** env + script que no imprime.

**Cómo se evita:** revisión de workflows (checklist del punto 4).

---

### Error 3: secreto inaccesible («secret not found»)

**Qué ocurrió:** `secrets.DEPLOY_TOKEN` vacío o error.

**Por qué posibles:**
* creado en el ámbito equivocado (repo vs. environment vs. org);
* el job no declaró `environment:`;
* nombre mal escrito (case-sensitive);
* secrets no disponibles en ciertos eventos (forks).

**Cómo comprobarlo:** dónde está definido vs. dónde se usa; evento y ámbito.

**Opciones:** crearlo donde se usa; declarar environment; corregir nombre.

**Riesgos:** deploys que fallan a medias.

**Solución:** ámbito + uso alineados (punto 1/2).

**Cómo se evita:** documentar el mapa de secretos por workflow.

---

### Error 4: GITHUB_TOKEN con permisos de más (o de menos)

**Qué ocurrió:** un workflow no puede pushear (403) o, peor, puede cosas que no debería.

**Por qué posibles:**
* `permissions:` ausente (hereda configuración);
* permisos amplios por comodidad.

**Cómo comprobarlo:** declarar explícitamente; revisar settings de «Workflow permissions» del repo.

**Opciones:** mínimo privilegio: `contents: read` por defecto, `write` solo donde se suba algo.

**Riesgos:** token con poder para modificar issues/PRs/repo en exceso.

**Solución:** permissions explícitas por workflow (punto 3, cap. 05).

**Cómo se evita:** plantilla con `permissions: contents: read`.

---

### Error 5: secretos compartidos entre entornos

**Qué ocurrió:** el mismo token para staging y prod; un despliegue de prueba tocó producción.

**Por qué:** un solo secreto «global».

**Cómo comprobarlo:** workflow de deploy: ¿environment? ¿secretos por env?

**Opciones:** crear environments con secretos propios; reviewers en prod.

**Riesgos:** blast radius (sección 20).

**Solución:** un secreto por entorno (punto 2).

**Cómo se evita:** checklist de workflow de deploy (sección 19 cap. 03).

---

### Error 6: secretos «de pruebas» eternos con poder de más

**Qué ocurrió:** un PAT de 2021 con scope completo sigue en el repo; nadie sabe de quién es.

**Por qué:** se creó para probar y se quedó.

**Cómo comprobarlo:** inventario de secretos; fecha de creación (si la plataforma la muestra); dueño.

**Opciones:** eliminar; recrear con alcance mínimo y dueño; rotación programada.

**Riesgos:** incidente con credencial huérfana.

**Solución:** inventario + rotación + dueño (punto 2).

**Cómo se evita:** revisión trimestral de secretos (sección 20).

---

## 6. Práctica guiada

### Objetivo

Montar configuración segura: variables, secretos por environment y un step que los usa sin exponerlos.

### Paso 1: variables

```text
Repo → Settings → Secrets and variables → Actions
   │
   └── Variables: URL_BASE=https://ejemplo.test
```

```yaml
      - run: echo "consultando ${{ vars.URL_BASE }}"
```

### Paso 2: environments con secretos

```text
1. Environments: crear `staging` y `produccion`.
2. En `produccion`: secretos DESPLIEGO_TOKEN +
   reviewers (1).
3. En `staging`: otro token (no el mismo).
```

### Paso 3: workflow que lo usa bien

```yaml
jobs:
  despliegue:
    environment: produccion
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Usa el secreto por env
        env:
          TOKEN: ${{ secrets.DESPLIEGO_TOKEN }}
        run: |
          test -n "$TOKEN"
          echo "token presente (no se imprime)"
```

### Paso 4: comprueba la higiene

1. Lee el log del step: ¿solo dice «token presente»?
2. Abre `permissions` del workflow: `contents: read` (o lo mínimo).

### Paso 5: practica la mala forma (en seguro)

1. Crea un workflow que use `${{ secrets.X }}` en la línea de `run` y observa cómo la plataforma enmascara (o no) — entiende el límite de la protección (punto 4).

### Paso 6: registro de rotación

```text
Tabla en tu doc de operación:
   │
   ├── secreto · ámbito · dueño · última rotación ·
   │   próxima
   └── (los tokens externos: caducidad real)
```

### Resultado esperado

Vars para config, secretos por environment, uso por env sin logs expuestos y tabla de rotación.

### Conclusión esperada

La separación vars/secrets/entornos es el sistema cardiovascular de Actions: si circula mal, o se fuga o se para.

---

## 7. Nivel profesional + resumen

### 7.1. Gestión de secretos en CI/CD

```text
   │
   ├── ámbito mínimo: org → repo → environment;
   │   prod con reviewers (sección 20/22)
   │
   ├── uso siempre por `env:` + scripts mudos
   │
   ├── GITHUB_TOKEN con `permissions` explícitas
   │   (mínimo privilegio)
   │
   ├── inventario y rotación con dueño (revisión
   │   trimestral)
   │
   ├── secret scanning + push protection como red
   │   (sección 13/20)
   │
   └── métricas: nº de secretos, edad de rotación,
       incidents de fuga (cero es el objetivo)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* los ámbitos de configuración: org → repo → environment → workflow → sistema; `vars` para lo no sensible, `secretos` para credenciales;
* los secretos se usan por `env:` del step, nunca interpolados en la línea de comando, y se rotan con dueño;
* `GITHUB_TOKEN` es efímero y gobiernan sus `permissions`;
* la higiene incluye artefactos, scripts con `set -x` y la protección (imperfecta) de enmascaramiento de logs;
* los errores típicos (ámbito confundido, secreto en log, secreto inaccesible, token amplio, entornos mezclados, secretos huérfanos) se previenen con inventario y checklist;
* a nivel profesional: rotación con calendario y red de detección (secret scanning).

La idea principal es:

> **Los secretos viajan por donde tú decides: ámbito mínimo, paso por env, sin eco en logs y con fecha de caducidad — lo que no tiene dueño, tiene fecha de incidente.**

---

## Próximo paso

Ya manejas datos y credenciales con criterio.

Falta la capa que limita el poder del workflow: permisos y seguridad de Actions.

Continúa con:

[`05-permisos-y-seguridad-del-workflow.md`](05-permisos-y-seguridad-del-workflow.md)
