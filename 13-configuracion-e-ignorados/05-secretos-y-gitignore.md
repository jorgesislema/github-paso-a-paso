# Secretos y .gitignore

## Introducción

`.gitignore` tiene un límite que cuesta caro no conocer: ignora archivos que aún no están en el repositorio. Un secreto que YA se commiteó vive en el historial — y `.gitignore` no lo borra de ahí.

Este capítulo explica por qué ignore ≠ seguridad, qué hacer si un secreto se coló, y cómo estructurar el flujo para que no vuelva a pasar: variables de entorno, `.example` versionado, detección y rotación.

---

## Mapa conceptual de este capítulo

```text
Secretos y .gitignore
       │
       ├── 1. La trampa (ignore no borra historial)
       ├── 2. Flujo correcto desde el inicio
       ├── 3. Si ya se publicó: respuesta en orden
       ├── 4. Detección (secret scanning)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. La trampa

```text
Secuencia típica del error:
   │
   ├── 1. se crea .env con credenciales
   ├── 2. se hace commit (git add . lo cogió todo)
   ├── 3. se añade .env a .gitignore «para el futuro»
   └── 4. se cree que «ya no está» → SIGUE en cada
       commit antiguo y en cada clon
```

```bash
# prueba de que sigue ahí:
git log --all --oneline -- .env
git show <hash>:.env            # ¡ahí está!
```

```text
Por qué importa:
   │
   ├── el repositorio (y sus clones, forks, caches,
   │   CI) contienen el secreto
   │
   ├── un push a un repo público lo expone en
   │   segundos (rastreadores lo buscan)
   │
   └── borrar el archivo en el último commit NO basta
```

```text
Regla fundamental:
   │
   └── .gitignore = prevención de ENTRADA;
       respuesta a un secreto publicado = PURGA +
       ROTACIÓN (los dos siempre)
```

---

## 2. Flujo correcto desde el inicio

```text
ESTRUCTURA DE CONFIGURACIÓN:
   │
   ├── .env              → local, ignorado, NUNCA
   │                       commiteado
   ├── .env.example      → versionado: mismas CLAVES,
   │                       valores vacíos o de ejemplo
   ├── documentación     → cómo obtener/definir cada
   │                       valor
   └── CI/producción     → secretos en el gestor de
                           secretos de la plataforma
                           (GitHub Secrets, vault, etc.)
```

```bash
# .gitignore mínimo para entornos:
.env
.env.*
!.env.example
```

```text
Hábitos que lo evitan:
   │
   ├── nunca `git add .` a ciegas: revisa el status
   │   (¿aparece .env? → stop)
   │
   ├── hook pre-commit que busca patrones de secreto
   │   (sección 12, cap. 09)
   │
   └── secret scanning ACTIVADO desde el primer día
       (cap. 4)
```

---

## 3. Si ya se publicó: respuesta en orden

```text
RESPUESTA A UN SECRETO EN EL HISTORIAL
──────────────────────────────────────────────────────
1. ROTAR primero (credencial comprometida = comprometida;
   aunque purgues, asume que alguien la vio)
   → cambiar clave/ token / contraseña en el servicio
     de origen y revocar la anterior

2. Determinar alcance:
   git log --all --oneline -- <archivo>
   ¿repo público? ¿forks? ¿cuánto tiempo expuesto?

3. Purgar el historial:
   → filter-repo (cap. 01 de la sección 12) para
     quitar el archivo/cadena de TODOS los commits
   → o en casos simples: BFG como alternativa conocida
   → avisar: todos los clones deben volver a clonar

4. Repartir el cambio:
   → force-with-lease de las ramas afectadas
   → avisar al equipo y a quien tenga forks

5. Verificar:
   → buscar el patrón en el historial nuevo
   → comprobar el escaneo de GitHub (push protection)
   → documentar el incidente (post-mortem breve)
```

```text
   │
   ├── el orden importa: si purgas sin rotar, el
   │   secreto «borrado» sigue vivo donde quiera que
   │   se haya copiado
   │
   └── si el repo era PRIVADO y la ventana fue corta:
       el riesgo baja, pero ROTAR igual (barato)
```

---

## 4. Detección (secret scanning)

```text
Capas de detección:
   │
   ├── Git y GitHub: Secret scanning + push protection
   │   (sección 20) — bloquea el push de secretos
   │   conocidos antes de que entren
   │
   ├── hooks locales: grep de patrones (AKIA…, ghp_…,
   │   «BEGIN PRIVATE KEY») antes del commit
   │
   ├── herramientas de escaneo: detect-genéricos y
   │   formatos propios de tu empresa
   │
   └── CI: escaneo periódico del historial (gitleaks,
       trufflehog… — como ejemplo de categoría)
```

```bash
# ejemplo conceptual de hook (cap. 09 de sección 12):
grep -rE "(AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36})" . \
  && { echo "posible secreto detectado"; exit 1; }
```

```text
Qué NO sustituye a qué:
   │
   ├── el hook falla si el usuario lo salta
   │
   └── push protection / CI no se saltan → ahí está la
       garantía
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «ya añadí el .gitignore, no puede haber problema»

**Qué ocurrió:** el secreto sigue en el historial y en clones/ forks.

**Por qué:** ignore solo cubre no-rastreados (punto 1).

**Cómo comprobarlo:** `git log --all -- .env`; buscar el patrón en la web del repo.

**Opciones:** flujo del punto 3 (rotar + purgar + repartir + verificar).

**Riesgos:** exposición continua.

**Solución:** entender el alcance real de ignore.

**Cómo se evita:** prevenir (punto 2) y activar push protection.

---

### Error 2: borrar el archivo en un commit nuevo y darlo por cerrado

**Qué ocurrió:** se commiteó «remove .env» y se dio por hecho.

**Por qué posibles:**
* el archivo existía en commits anteriores;
* se confundió «limpiar» con «purgar».

**Cómo comprobarlo:** `git log --all --stat -- .env`.

**Opciones:** punto 3 completo.

**Riesgos:** falsa sensación de seguridad (lo peor).

**Solución:** verificación del historial, no del árbol actual.

**Cómo se evita:** checklist de incidente (punto 3 escrito en la doc del equipo).

---

### Error 3: purgar sin rotar

**Qué ocurrió:** el historial quedó limpio pero la credencial siguió siendo válida y se usó (o pudo usarse).

**Por qué:** se trató el síntoma (texto) y no la credencial.

**Cómo comprobarlo:** logs del servicio con usos posteriores; fecha de expurgo vs. expiración.

**Opciones:** rotar YA; investigar uso; revisar alcance.

**Riesgos:** el verdadero incidente.

**Solución:** rotación como paso 1 innegociable.

**Cómo se evita:** plantilla de respuesta (punto 3).

---

### Error 4: `.env.example` con valores reales

**Qué ocurrió:** el ejemplo versionado contenía la clave real.

**Por qué:** copia-pega sin revisar.

**Cómo comprobarlo:** abrir el ejemplo; escaneo.

**Opciones:** corregir en repo; rotar (la clave estuvo pública); añadir regla de revisión.

**Riesgos:** «el ejemplo no es secreto» — sí lo es si contiene valor real.

**Solución:** ejemplos con placeholders (`TU_API_KEY_AQUI`, vacíos).

**Cómo se evita:** revisión de PR que incluya archivos .example.

---

### Error 5: secretos en CI/CD por texto plano en workflows

**Qué ocurrió:** token escrito dentro de un archivo `.yml` de Actions.

**Por qué:** desconocimiento de GitHub Secrets (o pereza).

**Cómo comprobarlo:** buscar el patrón en `.github/workflows/`; escaneo.

**Opciones:** mover a secretos de la plataforma (sección 19/20); rotar; revisar permisos del token.

**Riesgos:** filtración con cada fork/PR público.

**Solución:** `${{ secrets.NOMBRE }}` + mínimo privilegio.

**Cómo se evita:** plantilla de workflow sin literales.

---

### Error 6: panico y reescritura masiva descoordinada

**Qué ocurrió:** filter-repo de madrugada sin avisar → equipo bloqueado, CI roto, forks divergentes.

**Por qué:** no se planificó la ventana.

**Cómo comprobarlo:** estado del equipo (¿alguien clonando a mitad?).

**Opciones:** frenar, coordinar ventana, ejecutar con plan y comunicación (cap. 01 sección 12).

**Riesgos:** segundo incidente (operacional).

**Solución:** incidente = respuesta ordenada, no improvisación.

**Cómo se evita:** ensayar el procedimiento en repo privado de práctica.

---

## 6. Práctica guiada

### Objetivo

Simular un secreto colado, detectarlo, responder correctamente (sin rotación real: simulación) y verificar la purga.

### Paso 1: provocar el error

```bash
git init secrettest && cd secrettest
echo "API_KEY=ABCDEF123456" > .env
echo "app" > app.py
git add . && git commit -m "feat: init"
# ahora el ignore (demasiado tarde):
echo ".env" > .gitignore
git add .gitignore && git commit -m "chore: ignora .env"
```

### Paso 2: demostrar que sigue

```bash
git log --all --oneline -- .env
git show HEAD~1:.env            # el secreto, ahí
```

### Paso 3: estructura correcta

```powershell
@'
API_KEY=TU_API_KEY_AQUI
'@ | Set-Content .env.example
```

```bash
git rm --cached .env            # del índice (queda en disco)
git add .env.example .gitignore
git commit -m "chore: ejemplo versionado, .env fuera"
git status --ignored
```

### Paso 4: purga (simulación educativa)

```text
En un caso real: git filter-repo (o herramienta
equivalente) para eliminar .env de TODOS los
commits, luego reparto con force-with-lease y aviso.
En esta práctica, comprueba solo el «antes/después»:
   │
   ├── lista de commits con el archivo: git log
   │   --all -- .env
   │   (en el ejercicio real aquí quedaría VACÍO tras
   │   la purga)
   └── y RECuerda: el paso 1 real es ROTAR la clave
```

### Paso 5: hook de detección

```bash
# .githooks/pre-commit (versión sh):
#!/bin/sh
if git diff --cached | grep -qE "^\+.*(AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{36}|API_KEY=[^T])"; then
  echo "ERROR: posible secreto en el diff staged"
  exit 1
fi
exit 0
# actívalo con core.hooksPath (sección 12, cap. 09)
```

```bash
echo "API_KEY=SECRETO_REAL" >> .env
git add .env 2>/dev/null || true     # si está
                                     # ignorado no entra;
                                     # prueba en otro
                                     # archivo visible
git commit -m "prueba"               # debe fallar si
                                     # detecta
```

### Resultado esperado

Demostrado que ignore no borra historial, estructura example/real correcta y detección funcionando en el hook.

### Conclusión esperada

Prevención (ejemplo versionado + detección) y respuesta (rotar + purgar + repartir) son dos mitades del mismo plan.

---

## 7. Nivel profesional + resumen

### 7.1. Programa de secretos (resumen)

```text
PREVENIR                          DETECTAR
──────────────────────────────────────────────────────
.env ignorado                 · push protection (GitHub)
.env.example versionado       · hooks pre-commit
gestor de secretos en CI      · escaneo en CI/histórico
mínimo privilegio (tokens)    · revisión de PR

RESPONDER (si algo se coló)
   │
   ├── 1. rotar   2. acotar   3. purgar (filter-repo)
   ├── 4. repartir (lease + aviso)   5. verificar
   └── 6. post-mortem breve → mejora preventiva
```

### 7.2. Resumen

En este capítulo aprendiste que:

* `.gitignore` solo evita entradas futuras; el historial guarda lo ya commiteado (visible con `git log --all -- <archivo>`);
* flujo correcto: `.env` local ignorado + `.env.example` versionado + secretos de plataforma en CI/producción;
* la respuesta a un secreto publicado tiene orden fijo: ROTAR, acotar, purgar historial (filter-repo), repartir con aviso y verificar;
* la detección se capa: hooks locales (voluntarios), push protection y CI (obligatorios);
* los errores típicos (ignore como remediación, borrado superficial, purga sin rotar, example con valor real, secretos en workflows, pánico descoordinado) se previenen con plan escrito;
* a nivel profesional: programa de secretos con prevención, detección y respuesta ensayada.

La idea principal es:

> **Ignorar es prevenir la entrada; si el secreto ya entró, solo valen dos cosas: rotar la credencial y purgar el historial — en ese orden.**

---

## Próximo paso

Ya conoces el límite de `.gitignore` y la respuesta a incidentes.

El último capítulo de la sección completa tu kit: alias, incluir configs y hábitos de configuración avanzada.

Continúa con:

[`06-configuracion-avanzada-y-alias.md`](06-configuracion-avanzada-y-alias.md)
