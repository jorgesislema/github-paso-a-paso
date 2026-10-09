# git submodule

## Introducción

A veces tu proyecto depende de otro repositorio que también es un proyecto vivo: una librería interna, un juego de temas, un conjunto de utilidades compartidas entre equipos.

`git submodule` registra OTRO repositorio dentro del tuyo como una referencia fija: tu repo guarda la ruta y el commit exacto del submódulo; la historia del submódulo sigue siendo suya.

Es una herramienta poderosa y con mala fama justa: quien no entiende su modelo mental acumula errores. Este capítulo explica el modelo y el flujo mínimo para usarlo con criterio — incluida la pregunta previa: ¿realmente necesitas un submódulo?

En este capítulo aprenderás:

* el modelo: rutas + gitlink (commit fijo) vs. copias;
* añadir, clonar con `--recurse-submodules`, actualizar;
* cambiar la versión referenciada y publicar el cambio;
* alternativas (subtree, monorepo, dependencias);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

## Mapa conceptual de este capítulo

```mermaid
mindmap
  root((git submodule))
    1. ¿Cuándo SÍ y cuándo NO?
    2. El modelo (gitlink: commit fijo)
    3. Flujo básico: add, clone, update
    4. Cambiar y publicar la versión
    5. Errores comunes con diagnóstico completo
    6. Práctica guiada
    7. Nivel profesional + resumen

---
## 1. ¿Cuándo SÍ y cuándo NO?

```text
Submódulo compensa cuando:
    │
    ├── necesitas versiones EXACTAS y auditables del
    │   otro repo en cada commit del tuyo
    │
    ├── el otro repo es desarrollado en paralelo por
    │   otro equipo y debe mantener su historia
    │
    └── ciertos repos dentro de una organización
```

```text
Submódulo NO compensa cuando:
    │
    ├── solo quieres «arrastrar unos archivos» →
    │   subtree o copia controlada
    │
    ├── buscas siempre la última versión → dependencia
    │   de package manager (npm, pip, cargo...)
    │
    └── el equipo es nuevo en el concepto y el coste
        de aprendizaje supera el beneficio → monorepo o
        paquete interno
```

---

## 2. El modelo (gitlink)

```text
En tu repositorio queda:
    │
    ├── una entrada en .gitmodules (ruta, URL, rama)
    │
    ├── una ENTRADA DE ÍNDICE tipo «gitlink»: el HASH
    │   exacto del submódulo (no su contenido)
    │
    └── la carpeta del submódulo tiene SU PROPIO .git
        (o gitfile) → historia aparte

    proyecto/
    ├── .gitmodules
    ├── src/...
    └── libs/mi-lib/      ← gitlink → hash a1b2c34
                             (ese commit, ni más ni
                             menos)
```

```text
Consecuencias del modelo:
    │
    ├── «actualizar el submódulo» = mover el gitlink a
    │   otro commit → commit en EL PROYECTO padre
    │
    ├── clonar sin recursión deja carpetas VACÍAS
    │   (el contenido no está en tu repo)
    │
    └── el submódulo es inmutable para el padre: dos
        proyectos pueden apuntar a commits distintos
```

---

## 3. Flujo básico

```bash
# añadir:
git submodule add <url> libs/mi-lib
git status                 # .gitmodules + gitlink
git commit -m "feat: integra mi-lib (submódulo)"

# clonar completo:
git clone --recurse-submodules <url-proyecto>
# (o tras clonar normal):
git submodule update --init --recursive
```

```bash
# estado y actualización:
git submodule status        # (-)sin init (U)unmerged
git submodule update        # pone el commit del padre
git submodule update --remote   # trae la punta de la
                                 # rama remota del
                                 # submódulo
```

```text
Lectura de status:
    │
    ├── + → el submódulo está en un commit DISTINTO al
    │        registrado (tienes cambios locales o desfase)
    ├── U → conflicto de fusión
    └── sin prefijo → exactamente en el commit del padre
```

```bash
# quitar:
git submodule deinit libs/mi-lib
git rm libs/mi-lib
# (y limpiar .git/modules/... si procede)
```

---

## 4. Cambiar y publicar la versión

```mermaid
flowchart TD
    A[Dentro del submódulo: fetch y elegir (o --remote para su rama)] --> B[Volver al padre: git status muestra el gitlink modificado]
    B --> C[Commit en el padre: «chore: actualiza mi-lib a <hash>»]
    C --> D[Push del padre (el submódulo ya publicó su commit en SU remoto — si no, falla para otros)]
```

```text
Regla de oro:
    │
    └── el commit referenciado del submódulo DEBE
        existir en su remoto ANTES de que el padre lo
        apunte (si no, nadie más podrá clonarlo)
```

```bash
# ejemplo:
cd libs/mi-lib
git fetch && git checkout <hash-o-rama>
cd ../..
git add libs/mi-lib
git commit -m "chore: mi-lib → a1b2c34"
git push
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: clonar sin recursión (carpetas vacías)

**Qué ocurrió:** «no hay código en libs/mi-lib» tras clonar.

**Por qué posibles:**
* `git clone` sin `--recurse-submodules`;
* sin `submodule update --init` después.

**Cómo comprobarlo:** `git submodule status` (prefijo `-` = sin inicializar).

**Opciones:** `git submodule update --init --recursive`.

**Riesgos:** builds que no encuentran archivos; confusión total.

**Solución:** documentar el clon completo en el README del proyecto (sección 14).

**Cómo se evita:** en equipo, script/CI con `--recurse-submodules`.

---

### Error 2: referenciar un commit que nadie más tiene

**Qué ocurrió:** el submódulo quedó apuntando a un commit local del otro repo (nunca subido).

**Por qué:** se hizo commit de un estado local del submódulo sin push allí.

**Cómo comprobarlo:** en otro clon, `submodule update` falla (object not found).

**Opciones:** subir el commit del submódulo a su remoto (o mover el gitlink a un commit publicado).

**Riesgos:** proyecto incrustable para el resto.

**Solución:** regla del punto 4.

**Cómo se evita:** checklist: push del submódulo ANTES del padre.

---

### Error 3: trabajar con el submódulo «sucio» sin saberlo

**Qué ocurrió:** cambios en libs/mi-lib que el padre no registra; luego se pierden al `update`.

**Por qué:** el submódulo tiene su propio HEAD y su propio estado; `update` lo mueve.

**Cómo comprobarlo:** `git status` en el padre («modified content») y dentro del submódulo.

**Opciones:**
* si son cambios del submódulo: commit + push EN el submódulo y luego gitlink en el padre;
* si no querías tocarlo: `git submodule update --checkout` / reset dentro del submódulo (con cuidado).

**Riesgos:** trabajo descartado.

**Solución:** nunca dejar «trabajo a medias» en un submódulo al cambiar de contexto.

**Cómo se evita:** tratar el submódulo como un repo más en tu rutina de commit.

---

### Error 4: conflictos en `.gitmodules` o el gitlink

**Qué ocurrió:** dos personas cambiaron la versión del submódulo → conflicto en merge.

**Por qué posibles:**
* `.gitmodules` editado por ambos (URL/ruta);
* gitlink (índice) con versiones distintas del submódulo.

**Cómo comprobarlo:** `git status` (unmerged) y `git submodule status`.

**Opciones:** decidir la versión (generalmente la más reciente compatible), `submodule update` a esa y cerrar el merge (add del directorio del submódulo + .gitmodules si tocó).

**Riesgos:** mezclar versiones a medias.

**Solución:** decisión explícita de versión + verificación con `status`.

**Cómo se evita:** actualizar submódulos en momentos definidos (release), no a diario por cada autor.

---

### Error 5: `--remote` en el flujo equivocado

**Qué ocurrió:** alguien hizo `update --remote` y arrastró una versión inestable del submódulo a la rama principal.

**Por qué:** `--remote` mueve el gitlink a la punta de la rama del submódulo (último commit), no a la versión probada.

**Cómo comprobarlo:** `git log -1 libs/mi-lib` (¿es el commit que esperabas?).

**Opciones:** volver el gitlink al commit correcto y commitear de nuevo (si no se publicó, rectificar es fácil).

**Riesgos:** integrar cambios no probados.

**Solución:** `--remote` solo en ramas de exploración; en release, elegir hash explícito.

**Cómo se evita:** política: versiones de submódulos se mueven con commit del padre, revisado.

---

### Error 6: submódulos dentro de submódulos olvidados (recursión)

**Qué ocurrió:** el submódulo a su vez tiene submódulos y quedaron sin inicializar en CI.

**Por qué:** `--recursive` no se usó (o `--init` sin `--recursive`).

**Cómo comprobarlo:** `git submodule status --recursive` (líneas con `-`).

**Opciones:** `submodule update --init --recursive`; revisar scripts.

**Riesgos:** builds fallando solo en entornos nuevos.

**Solución:** un solo comando documentado en CI/README.

**Cómo se evita:** probar el clon limpio como parte del PR (la prueba «clonar en otra carpeta»).

---

## 6. Práctica guiada

### Objetivo

Montar un proyecto con submódulo, actualizarlo y publicar correctamente la referencia.

### Paso 1: dos repos

```bash
# submódulo
git init mi-lib && cd mi-lib
echo "def hola(): return 'hola'" > lib.py
git add . && git commit -m "v1"
git remote add origin <ruta-remota-o-local>
git push -u origin master
cd ..

# proyecto padre
git init mi-proyecto && cd mi-proyecto
echo "app" > app.py && git add . && git commit -m "base"
git submodule add <url-del-mi-lib> libs/mi-lib
git status
git commit -m "feat: integra mi-lib"
```

### Paso 2: clon completo en otro sitio

```bash
git clone <url-del-padre> ../copia
cd ../copia
git submodule status           # sin init (prefijo -)
git submodule update --init --recursive
git submodule status           # exacto (sin prefijo)
cat libs/mi-lib/lib.py         # contenido presente
```

### Paso 3: actualizar versión

```bash
cd ../mi-proyecto/libs/mi-lib
# añade una mejora y sube:
echo "def adios(): return 'adios'" >> lib.py
git add . && git commit -m "v2"
git push
cd ../..
git add libs/mi-lib            # gitlink modificado
git commit -m "chore: mi-lib → v2"
git submodule status           # refleja hash nuevo
```

### Paso 4: ver el estado del sistema

```bash
git show HEAD --stat           # gitlink in the diff
git config --file .gitmodules --list
git status                     # limpio
```

### Paso 5: situaciones de error

```bash
# suciedad en el submódulo:
echo "# basura" >> libs/mi-lib/lib.py
git status                     # «modified content»
# decisión: deshacer (update --checkout) o commitear
# en el submódulo — ensaya ambas
git submodule update --checkout libs/mi-lib
git status                     # limpio
```

### Resultado esperado

Proyecto con submódulo versionado, clon limpio reproducible y actualización publicada en dos pasos (submódulo primero, padre después).

### Conclusión esperada

El submódulo es un puntero a un commit que debe existir para todos: publica en el submódulo, luego actualiza el puntero.

---

## 7. Nivel profesional + resumen

### 7.1. Alternativas y cuándo elegirlas

```text
Opción           Mejor para                Coste
──────────────────────────────────────────────────────
submódulo  versiones exactas + historia   modelo mental
            separada                        complejo
subtree    llevar código dentro con        merges
            historial embebido              ligeros
dependen-  libs públicas/internas según   el ecosistema
cia (npm…)  ecosistema                      manda
monorepo   todo junto y atómico            herramientas
                                                  propias
copiar     última urgencia / code freeze  sin relación
            (nunca un flujo regular)
```

```text
Decisión profesional:
    │
    ├── ¿quiénes actualizan? ¿con qué frecuencia?
    ├── ¿necesitas auditoría «qué versión exacta en
    │   qué fecha»? → submódulo (o lockfile)
    └── ¿el equipo ya lo domina? (coste de adopción)
```

### 7.2. Higiene profesional

```text
    │
    ├── README: clon con --recurse-submodules
    │
    ├── CI: init --recursive obligatorio
    │
    ├── política: submódulos se mueven en commits
    │   dedicados, con mensaje que dice la versión
    │
    └── pruebas de humo tras cada actualización
```

### 7.3. Resumen

En este capítulo aprendiste que:

* el submódulo guarda un gitlink (ruta + hash) y `.gitmodules`; el contenido vive en su repositorio;
* clonar exige `--recurse-submodules` (o `update --init --recursive`); `status` usa prefijos `-`/`+`/`U`;
* actualizar = elegir commit en el submódulo + commit del gitlink en el padre, siempre tras publicar en el remoto del submódulo;
* `--remote` solo con criterio (trae punta de rama, no versión probada);
* los errores típicos (clon vacío, hash no publicado, suciedad invisible, conflictos de versión, --remote inestable, recursión olvidada) se previenen con checklists y documentación del clon;
* a nivel profesional: submódulo es una decisión de arquitectura (versión 17/25), no un parche — se elige comparando alternativas.

La idea principal es:

> **Un submódulo es un puntero a un commit que debe existir para todos: publica primero en el submódulo, mueve después el puntero y documenta el clon completo.**

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con este capítulo:

1. ¿Qué información contiene el archivo `.gitmodules` y qué tipo de entrada en el índice de Git representa un submódulo?
2. ¿Cómo clonarías un repositorio que tiene submódulos para asegurarte de que todos los submódulos se inicialicen y actualicen automáticamente?
3. ¿Qué comando usarías para ver el estado de los submódulos, incluyendo si están inicializados, si tienen cambios locales o si hay conflictos de fusión?
4. ¿Qué pasos seguirías para actualizar un submódulo a un nuevo commit y asegurar que el cambio se publique correctamente en el repositorio padre?
5. ¿En qué situación sería apropiado usar `git submodule update --remote` y qué riesgo implica usarlo en una rama de producción?
6. ¿Cómo detectarías y resolverías un conflicto de fusión que afecta al archivo `.gitmodules` o al gitlink de un submódulo?
7. ¿Qué ventaja tiene usar `git submodule deinit` antes de eliminar el directorio de un submódulo con `git rm`?
8. ¿Cómo evitarías que un submódulo quede apuntando a un commit que solo existe en tu repositorio local y no en el remoto?

---

## Ejercicio de transferencia

Tienes un proyecto que depende de una librería interna desarrollada por otro equipo. Necesitas actualizar la librería a una nueva versión que corrige un error crítico y asegurarte de que la referencia en tu proyecto apunte al commit correcto. Describe los pasos que seguirías para actualizar el submódulo en su propio repositorio, publicar el cambio, actualizar el gitlink en el proyecto padre y verificar que el submódulo apunta al commit esperado, asegurándote de que el commit referenciado exista en el remoto del submódulo antes de mover el puntero.

## Próximo paso

Ya conectas repositorios con control de versiones.

La siguiente herramienta automatiza tus propios comandos en puntos clave: hooks.

Continúa con:

[`09-git-hooks.md`](09-git-hooks.md)