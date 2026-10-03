# git hooks

## Introducción

Git invoca scripts tuyos en momentos concretos: antes de un commit, después de un push, antes de recibir en el servidor. Eso son los hooks: el lugar natural para formatear, validar o bloquear antes de que el error llegue a otros.

Hooks resuelven lo que la disciplina humana olvida: mensajes malos, tests saltados, archivos gigantes, secretos por subir. Este capítulo enseña a escribirlos, instalarlos y — muy importante — a distinguir los del cliente (voluntarios) de los del servidor (obligatorios).

En este capítulo aprenderás:

* el mapa de hooks de cliente y servidor más útiles;
* escribir y probar un hook (`pre-commit`, `commit-msg`);
* dónde viven los hooks y cómo instalarlos por equipo;
* hooks distribuidos (Husky, pre-commit, lefthook) de forma informada;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
git hooks
       │
       ├── 1. Qué son (cliente vs. servidor)
       ├── 2. Los hooks de uso diario
       ├── 3. Escribir hooks (ejemplos)
       ├── 4. Distribución por equipo
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué son (cliente vs. servidor)

```text
HOOKS DE CLIENTE (voluntarios — en .git/hooks)
   │
   ├── pre-commit      antes de crear el commit
   ├── prepare-commit-msg  modificar mensaje inicial
   ├── commit-msg      validar el mensaje
   ├── post-commit    (informativo)
   ├── pre-push       antes de push
   └── ... (post-checkout, pre-rebase...)

HOOKS DE SERVIDOR (obligatorios — en el remoto)
   │
   ├── pre-receive / update  (GitHub: checks y
   │   reglas de rama, vía Actions o configuración)
   └── post-receive
```

```text
La distinción clave:
   │
   ├── cliente: ayuda, pero puede saltarse (quien
   │   ejecuta git commit --no-verify no lo corre)
   │
   └── servidor/CI: la garantía real; el cliente es
       comodidad y velocidad de feedback
```

```bash
# dónde están (por repositorio):
ls .git/hooks/          # (o dir .git\hooks)
# con plantillas:
git config core.hooksPath   # ruta alternativa (ver 4)
```

---

## 2. Los hooks de uso diario

```text
pre-commit
   │
   ├── formatear (black, prettier, gofmt)
   ├── lint
   ├── tests rápidos
   └── bloquear archivos prohibidos (gigantes, .env)

commit-msg
   │
   └── validar formato (Convención de commits, ticket
       obligatorio)

pre-push
   │
   ├── tests completos (más lentos)
   └── bloquear pushes a ramas protegidas (política
       local)

prepare-commit-msg
   │
   └── plantillas (asunto con rama, Co-authored-by)
```

---

## 3. Escribir hooks

### 3.1. Estructura

```text
   │
   ├── es un SCRIPT ejecutable (sh, bash, Python,
   │   PowerShell… según entorno)
   │
   ├── código de salida 0 → el proceso CONTINÚA
   │
   ├── código ≠ 0 → el proceso SE DETIENE (en
   │   pre-commit no se crea el commit)
   │
   └── sin extensión de archivo: nombre exacto del
       hook
```

### 3.2. Ejemplo: `pre-commit` (bash)

```bash
#!/bin/sh
# .git/hooks/pre-commit
set -e
echo "formateando..."
# ejemplo: formateador del proyecto
# black --quiet .
if grep -q "DEBUG_SECRET" $(git diff --cached --name-only); then
  echo "ERROR: posible secreto en los cambios"
  exit 1
fi
exit 0
```

```bash
# Windows: el shebang depende de tu shell;
# también puedes apuntar a un .cmd/.ps1 con
# core.hooksPath y scripts envolventes (el repositorio
# debe estandarizarlo)
chmod +x .git/hooks/pre-commit     # Unix: hacerlo
                                   # ejecutable
```

### 3.3. Ejemplo: `commit-msg`

```bash
#!/bin/sh
# valida: asunto <= 72 caracteres y tipo válido
msg_file=$1
first=$(head -n1 "$msg_file")
len=${#first}
if [ "$len" -gt 72 ]; then
  echo "ERROR: asunto demasiado largo ($len > 72)"
  exit 1
fi
case "$first" in
  feat:*|fix:*|docs:*|chore:*|refactor:*|test:*) exit 0 ;;
  *) echo "ERROR: usa tipo (feat:, fix:, docs:...)"; exit 1 ;;
esac
```

### 3.4. Probar un hook

```bash
git commit --amend --no-edit      # dispara pre-commit
# probar el mensaje:
git commit -m "esto no vale"      # commit-msg debe
                                  # rechazar
# saltarse UNA vez (solo si lo entiendes):
git commit --no-verify
```

---

## 4. Distribución por equipo

```text
El problema: .git/hooks NO se versiona (está en .git).

Soluciones:
   │
   ├── core.hooksPath: apuntar a una carpeta SÍ
   │   versionada (ej. .githooks/) → instalar con un
   │   git config y ya
   │
   └── frameworks de hooks (Husky para JS, pre-commit
       de Python, lefthook…) → gestionan instalación,
       múltiples lenguajes y activación
```

```bash
git config core.hooksPath .githooks
# ahora .githooks/pre-commit se ejecuta si es
# ejecutable
```

```text
Política profesional:
   │
   ├── el repo incluye hooks + instrucción de
   │   instalación (una línea)
   │
   ├── y el CI repite las mismas validaciones (los
   │   hooks del cliente ayudan; CI garantiza)
   │
   └── --no-verify no engaña a CI
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: hook no se ejecuta

**Qué ocurrió:** guardaste el script pero `git commit` no lo dispara.

**Por qué posibles:**
* no es ejecutable (permisos en Unix);
* nombre mal escrito (typo: `pre-comit`);
* está en la carpeta equivocada (no `.git/hooks` ni `core.hooksPath`);
* lanza error al empezar y Git lo ignora/aborda según versión.

**Cómo comprobarlo:** `ls -l .git/hooks/pre-commit`; ejecutarlo a mano (`./.git/hooks/pre-commit`; con argumentos según versión); `git config core.hooksPath`.

**Opciones:** corregir nombre/ruta; `chmod +x`; revisar salida en terminal.

**Riesgos:** falsa sensación de validación.

**Solución:** probar el hook manualmente tras crearlo (paso obligatorio).

**Cómo se evita:** checklist de instalación en el README del equipo.

---

### Error 2: hook que falla sin mensaje claro

**Qué ocurrió:** el commit se cancela y solo hay un error críptico.

**Por qué:** el script no imprime diagnóstico (o sale con ≠0 silencioso).

**Cómo comprobarlo:** ejecutar el script en la terminal y ver su salida.

**Opciones:** añadir mensajes (`echo "ERROR: ..."` antes de `exit 1`).

**Riesgos:** bloqueos que la gente aprende a saltar con `--no-verify`.

**Solución:** todo hook habla (qué falló y cómo arreglarlo).

**Cómo se evita:** revisión de hooks como código más del equipo.

---

### Error 3: hooks lentos que entorpecen el flujo

**Qué ocurrió:** pre-commit con la suite completa → nadie aguanta y se desactivan.

**Por qué posibles:**
* tests pesados en el momento equivocado;
* sin caché ni paralelismo.

**Cómo comprobarlo:** tiempos del hook (`time ./...`).

**Opciones:** cliente = lint + tests rápidos (<5-10 s); suite completa en `pre-push` o CI; caché.

**Riesgos:** desactivación masiva del hook.

**Solución:** presupuesto de tiempo por hook.

**Cómo se evita:** medir antes de añadir.

---

### Error 4: creer que el hook del cliente es la garantía

**Qué ocurrió:** pasó el pre-commit local, el push llegó y CI explotó (o peor: llegó código sin revisar).

**Por qué:** `--no-verify` y hooks inexistentes en otros ordenadores (si no están distribuidos).

**Cómo comprobarlo:** ejecutar push desde un clon limpio sin hooks.

**Opciones:** instalar hooks de equipo (punto 4) Y validar en CI (obligatorio).

**Riesgos:** calidad dependiente de la buena voluntad.

**Solución:** dos capas.

**Cómo se evita:** regla: «el cliente ayuda, el CI garantiza».

---

### Error 5: hook que modifica staged y «desaparece» trabajo

**Qué ocurrió:** el hook formateó archivos, pero el commit salió con la versión vieja (o sin los cambios del formateo).

**Por qué posibles:**
* el hook formateó el working tree pero no re-hizo `git add`;
* cambios posteriores al add y dentro del hook.

**Cómo comprobarlo:** `git diff --cached` tras el hook.

**Opciones:** en el hook, tras formatear, `git add -u` (o los paths) si pretendes incluirlo.

**Riesgos:** commit que no refleja lo «aprobado» por el hook.

**Solución:** patrón: formatear → re-add → exit 0.

**Cómo se evita:** probar con cambios que el formateador altere.

---

### Error 6: hooks de servidor mal configurados (o saltados igual)

**Qué ocurrió:** se configuró pre-receive en un servidor propio y bloqueó pushes legítimos (o no se configuró nada y todos pasan).

**Por qué posibles:**
* validación demasiado estricta sin mensajes útiles;
* o ausencia de controles (el extremo contrario).

**Cómo comprobarlo:** intentar push bueno y malo; revisar configuración/Actions del servidor.

**Opciones:** en GitHub: protecciones de rama + checks de Actions (cap. 19/20) en lugar de scripts ad-hoc; mensajes claros en los bloqueos.

**Riesgos:** fricción o vacío de calidad.

**Solución:** servidor = reglas de rama + CI; cliente = feedback rápido.

**Cómo se evita:** definir qué es obligatorio y qué es sugerencia (punto 1).

---

## 6. Práctica guiada

### Objetivo

Crear un pre-commit y un commit-msg versionados con `core.hooksPath` y probarlos.

### Paso 1: carpeta versionada

```bash
git init hooksdemo && cd hooksdemo
mkdir .githooks
git config core.hooksPath .githooks
```

### Paso 2: pre-commit

```powershell
# .githooks/pre-commit (Windows PowerShell como envoltorio,
# o bash si usas Git Bash):
# versión sh para Git Bash:
@'
#!/bin/sh
if grep -rn "console.log" --include="*.js" . >/dev/null 2>&1; then
  echo "ERROR: console.log en el código"
  exit 1
fi
exit 0
'@ | Set-Content -Path .githooks/pre-commit -NoNewline
```

```bash
chmod +x .githooks/pre-commit      # si aplica
echo "console.log('x')" > app.js
git add app.js
git commit -m "feat: x"            # debe FALLAR con
                                    # mensaje claro
```

### Paso 3: commit-msg

```bash
# .githooks/commit-msg: asunto no vacío
#!/bin/sh
first=$(head -n1 "$1")
if [ -z "$first" ]; then echo "ERROR: mensaje vacío"; exit 1; fi
exit 0
```

```bash
git commit -m ""                   # falla
git commit -m "feat: x"            # pasa (quita antes
                                    # el console.log)
```

### Paso 4: instalar en copia

```bash
git add .githooks && git commit -m "chore: hooks del equipo"
git clone . ../copia-hooks
cd ../copia-hooks
git config core.hooksPath .githooks   # o documentado en
                                      # setup
# reprobar: mismo comportamiento
```

### Paso 5: pre-push

```bash
# .githooks/pre-push: avisa antes de subir
#!/bin/sh
echo "push validando... (simulado)"
exit 0
```

1. Ejecuta `git push` y observa el aviso.

### Resultado esperado

Hooks versionados, instalables en una línea y con mensajes de error accionables.

### Conclusión esperada

Un hook útil es corto, rápido, hablador y acompañado de CI; la instalación en una línea es parte del hook.

---

## 7. Nivel profesional + resumen

### 7.1. Stack profesional típico

```text
Cliente (feedback rápido):
   │
   ├── formateador + lint (pre-commit)
   ├── validación de mensaje (commit-msg)
   └── tests rápidos (pre-push, opcional)

Servidor/CI (garantía):
   │
   ├── mismos checks (formateo, lint) → nadie puede
   │   saltárselos de verdad
   ├── tests completos, seguridad (sección 20)
   └── reglas de rama (merge solo con checks verdes)

Distribución:
   │
   ├── core.hooksPath versionado, o framework
   │   (Husky/lefhthook/pre-commit) según ecosistema
   └── «setup» en documentación de contributing
```

### 7.2. Medición

```text
   │
   ├── tiempo total de hooks < 10 s (objetivo típico)
   │
   └── si crece: mover a CI o cachear
```

### 7.3. Resumen

En este capítulo aprendiste que:

* los hooks son scripts en puntos del flujo; cliente = voluntario y rápido, servidor/CI = obligatorio;
* `pre-commit` valida/corrige cambios, `commit-msg` valida mensajes, `pre-push` valida antes de subir;
* existen en `.git/hooks` (no versionada) o vía `core.hooksPath`/frameworks para distribuirlos;
* salida 0 = seguir, ≠0 = parar; todo hook debe explicarse con mensajes claros;
* los errores típicos (no ejecutable, nombre/ruta, lentitud, confiar en el cliente, staged desincronizado, servidor mal regulado) se previenen con patrón cliente+CI;
* a nivel profesional: los mismos checks en hook y en CI, presupuesto de tiempo y setup en una línea.

La idea principal es:

> **Los hooks convierten las reglas del equipo en ejecución automática en tu máquina; la calidad real llega cuando esas mismas reglas viven también en el servidor.**

---

## Próximo paso

Has completado la sección de Git avanzado: reescritura, rebase interactivo, cherry-pick, tags, bisect, blame, worktree, submódulos y hooks.

Continúa con el README de cierre de la sección:

[`README.md`](README.md)
