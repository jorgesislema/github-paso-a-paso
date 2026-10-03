# git remote

## Introducción

`git remote` es la orden de fontanería amable para gestionar remotos: añadir, listar, inspeccionar, renombrar, reconfigurar y quitar las direcciones con las que habla tu clon. Es corta, segura (solo toca tu config) y absolutamente central para cualquier diagnóstico de sincronización.

En este capítulo dominas el subcomando completo: desde `remote add` hasta `remote show`, incluyendo el secreto de `set-url` para repos movidos y la limpieza de remotos obsoletos.

En este capítulo aprenderás:

* la sintaxis completa de `git remote` (y sus alias habituales);
* `add`, `-v`, `show`, `rename`, `remove`, `set-url`, `prune`;
* usar `remote -v` como primer paso de diagnóstico;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (remotos múltiples y automatización).

---

## Mapa conceptual de este capítulo

```text
git remote
       │
       ├── 1. Panorama de subcomandos
   │        ├── add / remove / rename
   │        ├── -v / show
   │        ├── set-url / get-url
   │        └── prune
   │
       ├── 2. Añadir y quitar
   │
       ├── 3. Inspeccionar: -v y show
   │
       ├── 4. Corregir: set-url (repos movidos)
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       └── 7. Nivel profesional + resumen
```

---

## 1. Panorama de subcomandos

```text
Orden                          Qué hace
──────────────────────────────────────────────────────────
git remote -v                  lista nombre + URL (fetch
                               y push)
git remote add <n> <URL>       crea
git remote remove <n>          borra de tu config
git remote rename <viejo> <n>  renombra (ajusta branches)
git remote show <n>            detalle con red (HEAD,
                               ramas, seguimiento)
git remote set-url <n> <URL>   cambia la URL
git remote get-url <n>         muestra la URL
git remote set-url --add <n> <URL>    añade URL alterna
git remote set-url --delete <n> <patrón>
git remote prune <n>           elimina fotos origin/*
                               obsoletas
```

```text
   │
   ├── -v = --verbose: el día a día
   └── todo vive en .git/config: sin efectos en el
       servidor ni en tu historial
```

---

## 2. Añadir y quitar

### 2.1. Añadir

```bash
git remote add backup https://github.com/tu-usuario/espejo.git
git remote add upstream git@github.com:equipo/proyecto.git
```

```text
   │
   ├── nombre único (error si ya existe)
   │
   └── para clon: git clone <URL> ya crea origin; add
       es para «otro» (backup, upstream, espejo local)
```

### 2.2. Quitar y renombrar

```bash
git remote remove backup
git remote rename backup espejo
git remote -v                    # verifica
```

```text
   │
   ├── remove borra la config local y las fotos
   │   asociadas (refs/remotes/<nombre>); NO toca nada
   │   en el servidor
   │
   └── rename actualiza ramas remotas y config de
       seguimiento que apuntaban al nombre viejo
```

### 2.3. Múltiples URLs para un nombre

```bash
git remote set-url --add origin https://github.com/u/p.git
git remote get-url --all origin
```

```text
   │
   └── Git puede mantener varias URLs por remote
       (casos: migración, réplicas); en uso normal,
       una basta
```

---

## 3. Inspeccionar: `-v` y `show`

### 3.1. `-v` (la lista)

```bash
git remote -v
```

```text
 origin  https://github.com/u/p.git (fetch)
 origin  https://github.com/u/p.git (push)

Lo que responde:
   ¿con quién hablo?  ¿con qué URL?  ¿solo una dirección
   para fetch y push o hay diferencia?
```

### 3.2. `show` (el detalle)

```bash
git remote show origin
```

```text
Salida conceptual (necesita red):
   * remote origin
     Fetch URL: …
     Push  URL: …
     HEAD branch: main
     origin/main          up to date
     origin/feature-x     new to you / …
     …

   │
   ├── te dice el HEAD remoto, las ramas y el estado
   │   respecto a tus locales
   │
   └── equivalente moderno: git ls-remote + lectura
       propia, pero show lo condensa
```

### 3.3. `ls-remote` (la sonda mínima)

```bash
git ls-remote origin
git ls-remote --heads origin       # solo ramas
git ls-remote --symref origin HEAD # ¿rama por defecto?
```

```text
   │
   ├── NO modifica nada: solo pregunta «¿qué refs
   │   tienes?»
   │
   └── perfecto para: probar URL/auth sin efectos
       secundarios
```

---

## 4. Corregir: `set-url`

### 4.1. El caso clásico

```bash
git remote set-url origin https://github.com/usuario/proyecto-nuevo.git
git remote -v                 # verifica
git fetch                     # prueba de vida
```

### 4.2. Cambiar esquema (https ↔ ssh)

```bash
git remote set-url origin git@github.com:usuario/proyecto.git
```

### 4.3. Con `origin` enlazado a ramas

```text
   │
   ├── set-url NO rompe los enlaces de seguimiento
   │   (mismo nombre, otra URL)
   │
   └── tras cambiar URL: fetch y revisar `branch -vv`
       (las fotos se refrescarán con la nueva fuente)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «remote origin already exists»

**Qué ocurrió:** `remote add origin` con origin ya presente (caso normal tras clonar).

**Por qué:** ya estaba (clone lo creó).

**Cómo comprobarlo:** `git remote -v`.

**Opciones:**
* si querés cambiar la URL: `set-url`;
* si querés «otro»: otro nombre (`backup`, `upstream`);
* si quieres empezar de cero: `remove` y `add`.

**Riesgos:** remove sin querer cuando solo querías cambiar.

**Solución:** add ≠ set-url.

**Cómo se evita:** mirar `-v` antes (un segundo).

---

### Error 2: `remote show origin` falla (pero push funciona o viceversa)

**Qué ocurrió:** unos comandos de red responden y otros no.

**Por qué posibles:**
* show necesita red completa y autenticación; un proxy/firewall puede cortar partes;
* credencial guardada para push pero URL de show distinta;
* red inestable.

**Cómo comprobarlo:** probar `git ls-remote origin` (misma conversación, menos dependencias) y abrir la URL en el navegador.

**Opciones:** corregir URL/credencial/proxy según el caso.

**Riesgos:** diagnósticos confusos («Git está roto»).

**Solución:** aislar: ¿URL? ¿auth? ¿red?

**Cómo se evita:** no sacar conclusiones de un solo comando.

---

### Error 3: Renombrar y romper seguimientos antiguos

**Qué ocurrió:** renombraste `origin`→`github` y algunas ramas quedaron con parejas viejas.

**Por qué:** la config de branch puede quedar apuntando al nombre anterior en casos mixtos (versión/configuración dependiente).

**Cómo comprobarlo:** `git branch -vv` (parejas raras), `git config --get-regexp branch`.

**Opciones:** re-enlazar con `-u` las afectadas.

**Riesgos:** pull/push a nada.

**Solución:** tras renombrar, repasar `-vv`.

**Cómo se evita:** renombrar poco (y si se hace, checklist).

---

### Error 4: URL con errores silenciosos (doble barra, .git faltante)

**Qué ocurrió:** fetch falla o clona algo raro; a veces ni hay error claro (servidor distinto).

**Por qué:** URL tecleada a mano.

**Cómo comprobarlo:** comparar carácter a carácter con la de GitHub; `ls-remote`.

**Opciones:** copiar/pegar de nuevo; set-url.

**Riesgos:** apuntar al repo equivocado (peor: uno existente del que tienes permiso).

**Solución:** siempre copiar de la interfaz.

**Cómo se evita:** disciplina de copiado.

---

### Error 5: Esperar que `remote remove` afecte al servidor

**Qué ocurrió:** miedo a haber borrado el repo o ramas allá.

**Por qué:** confusión config local vs. servidor.

**Cómo comprobarlo:** `ls-remote` (si no lo quitaste de config); navegador.

**Opciones:** nada que deshacer (salvo re-add).

**Riesgos:** pánico.

**Solución:** remove solo borra tu entrada.

**Cómo se evita:** concepto del capítulo 01.

---

### Error 6: Demasiados remotos y guiones que «apuntan a todos»

**Qué ocurrió:** `git push --all` envió todas tus ramas locales a un remoto que no debía recibirlas (pruebas, personales).

**Por qué:** push indiscriminado + remoto con nombre genérico.

**Cómo comprobarlo:** reflejo en el servidor; `remote -v`.

**Opciones:** borrar lo enviado si no debe estar (coordinado); revisar guiones.

**Riesgos:** ensuciar remoto equivocado.

**Solución:** `push` explícito por rama (y `--all` solo con intención).

**Cómo se evita:** nunca en alias global sin repaso; revisar destino antes.

---

## 6. Práctica guiada

### Objetivo

Gestionar remotos completos en un repositorio de práctica (con espejo local, sin depender de red).

### Paso 1: listado

```bash
git remote -v
git config --get-regexp '^remote\.'
```

### Paso 2: espejo local

```bash
# (rutas según tu sistema; en Windows puedes usar %TEMP%)
git init --bare <RUTA>/espejo.git
git remote add espejo <RUTA>/espejo.git
git remote -v
git push -u espejo main
git remote show espejo         # funciona: es «red» local
```

### Paso 3: renombrar y corregir

```bash
git remote rename espejo backup
git remote -v
git remote set-url backup <OTRA-RUTA-VALIDA>
git remote get-url backup
git push                        # ¿con -u del paso 2
                                # sobrevivió al rename?
```

### Paso 4: quitar y re-añadir

```bash
git remote remove backup
git remote -v                   # vacío (si era el único)
git remote add origin <URL-real-de-tu-repo>
git remote -v
git push -u origin main
```

### Paso 5: sondas

```bash
git ls-remote origin            # lista de refs reales
git ls-remote --heads origin
git remote show origin          # detalle completo
```

### Paso 6: prune

```bash
git fetch --prune origin
git branch -r                   # fotos limpias
```

### Resultado Esperado

Manejo seguro de la gestión de remotos: crear, corregir, inspeccionar y limpiar sin tocar nada que no corresponda.

### Conclusión esperada

`remote` es un subcomando pequeño con poder enorme: gobierna TODA tu relación con el exterior, y por eso es el primer sospechoso en cualquier problema de sincronización.

---

## 7. Nivel profesional + resumen

### 7.1. Remotos en flujos de equipo

```text
Inventario recomendado
──────────────────────────────────────────────
proyecto simple:
   origin → repo del equipo

open source / fork:
   origin   → mi fork
   upstream → oficial

infraestructura:
   origin  → servidor principal
   backup  → réplica/almacén

y siempre: URLs de copiar/pegar, pruebas con ls-remote
```

### 7.2. Automatización

```text
   │
   ├── en scripts: comprobar remote -v antes de operar
   │
   ├── set-url en despliegues cuando la URL cambia
   │   (secretos fuera del repo: la URL con token NO
   │   se escribe en config compartida)
   │
   └── ls-remote como health-check pre-push en CI
```

### 7.3. Resumen

En este capítulo aprendiste que:

* `git remote` gestiona la config de remotos: add/remove/rename/set-url/get-url/show/prune, con `-v` como inspección diaria;
* `show` da detalle con red y `ls-remote` es la sonda mínima que no toca nada;
* `set-url` arregla repos movidos y cambia de esquema (https↔ssh) sin romper enlaces de seguimiento;
* remove/rename son operaciones de TU config: el servidor no se entera;
* los errores típicos (add con origin existente, show que falla, seguimientos tras rename, URLs tecleadas, miedos por remove, push --all) se resuelven con -v, ls-remote y destinos explícitos;
* a nivel profesional: inventario mínimo de remotos, health-checks con ls-remote y credenciales fuera del repositorio.

La idea principal es:

> **`remote -v` es la primera pregunta de todo diagnóstico de red: quién habla, a dónde y por qué esquema.**

---

## Próximo paso

Ya gestionas las direcciones.

El siguiente paso es la operación que las crea de verdad: clonar un repositorio.

Continúa con:

[`03-git-clone.md`](03-git-clone.md)
