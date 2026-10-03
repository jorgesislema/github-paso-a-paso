# git clone

## Introducción

`git clone` es el nacimiento de un repositorio local: descarga el proyecto y su historial desde un remoto, configura `origin`, trae las ramas y te deja listo para trabajar. Es, con diferencia, la orden de red más usada de Git — y tiene matices que cambian lo que recibes (profundidad, ramas, destino, protocolo).

En este capítulo aprenderás:

* qué hace exactamente `git clone` (paso a paso);
* sus opciones clave (`--depth`, `--branch`, `--single-branch`, `--origin`);
* clonar en carpeta concreta y clonar un solo directorio (submódulos, sparse: mención);
* qué NO trae un clon (staging, ramas locales, estados);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (clones en CI, espejos, alternates).

---

## Mapa conceptual de este capítulo

```text
git clone
       │
       ├── 1. Qué hace (paso a paso)
   │        ├── init + remote + fetch + checkout
   │        └── configuración resultante
   │
       ├── 2. Opciones clave
   │        ├── <URL> [carpeta]
   │        ├── -b/--branch
   │        ├── --depth 1 (clon superficial)
   │        ├── --single-branch
   │        └── --origin / --bare
   │
       ├── 3. Qué NO trae el clon
   │
       ├── 4. Errores comunes con diagnóstico completo
   │
       ├── 5. Práctica guiada
   │
       └── 6. Nivel profesional + resumen
```

---

## 1. Qué hace (paso a paso)

### 1.1. La orden

```bash
git clone https://github.com/usuario/proyecto.git
```

```text
Secuencia interna
──────────────────────────────────────────────
1. crea proyecto/ (o la carpeta que indiques)
2. git init dentro (estructura .git)
3. git remote add origin <URL>
4. descarga refs (ramas) y objetos (historial)
5. crea refs/remotes/origin/* (fotos)
6. configura upstream de la rama por defecto
7. rellena tu directorio de trabajo con la versión
   de la rama por defecto (checkout)

Resultado: carpeta + .git completo + origin listo
```

### 1.2. Configuración resultante

```bash
git clone <URL>
cd proyecto
git remote -v          # origin = la URL
git branch -a          # locales + remotas
git status             # rama por defecto, al día
```

### 1.3. Esquema

```text
[remoto] ──clone──► [tu carpeta]
                      ├─ .git (historial completo)
                      ├─ origin (URL)
                      ├─ origin/* (fotos de ramas)
                      └─ archivos (rama por defecto)
```

---

## 2. Opciones clave

### 2.1. Carpeta destino

```bash
git clone <URL> mi-carpeta
git clone <URL> .           # en el directorio actual
                             # (debe estar vacío)
```

### 2.2. Elegir rama

```bash
git clone -b develop <URL>
git clone --branch v1.0 <URL>
```

```text
   │
   ├── clona con esa rama como HEAD local
   ├── con --single-branch: solo trae esa (véase 2.3)
   └── versiones antiguas: combinaba con -b para tags
```

### 2.3. `--single-branch` y `--depth`

```bash
git clone --single-branch <URL>            # solo la rama
                                            # por defecto
git clone --depth 1 <URL>                  # historial
                                            # superficial
git clone --depth 1 -b develop --single-branch <URL>
```

```text
Clon superficial (shallow)
   │
   ├── trae solo los últimos N commits
   │
   ├── usos: CI/despliegue (solo necesitan el código),
   │   red lenta, repos gigantes
   │
   └── limitaciones: git log corto; algunas operaciones
       (bisect, rebase profundo) fallan o necesitan
       «deepen»: git fetch --unshallow
```

### 2.4. `--origin` y `--bare`

```bash
git clone --origin fuente <URL>     # nombre ≠ origin
git clone --bare <URL>              # repositorio de
                                     # servidor (sin
                                     # working tree)
```

```text
   │
   ├── --bare: para servidores/espejos (no trabajas
   │   dentro; no hay archivos de trabajo)
   │
   └── tú trabajas en clones normales; los servidores
       suelen ser bare
```

### 2.5. Protocolos

```bash
git clone git@github.com:usuario/proyecto.git   # ssh
git clone https://github.com/usuario/proyecto.git # https
git clone /ruta/local/proyecto.git              # local
```

---

## 3. Qué NO trae el clon

```text
   │
   ├── no trae tu staging (irrelevante: es local de
   │   quien lo hace)
   │
   ├── no trae estados de trabajo de nadie (solo lo
   │   commiteado)
   │
   ├── no trae credenciales (para repo privado: usa
   │   tu auth)
   │
   ├── no trae issues/PRs de GitHub (son datos de la
   │   plataforma, no del repo Git)
   │
   └── no trae «configuración mágica»: .git/config
       tuyo se crea para este clon (el global es tuyo)
```

---

## 4. Errores comunes con diagnóstico completo

### Error 1: «destination path already exists and is not an empty directory»

**Qué ocurrió:** la carpeta destino existe y tiene cosas.

**Por qué:** Git no mezcla un clon en carpeta sucia (seguridad).

**Cómo comprobarlo:** listar la carpeta.

**Opciones:**
* dar otra carpeta;
* vaciarla conscientemente (si es tuya y vacía de verdad);
* si ya hay un .git viejo ahí: decidir (¿clon ahí? ¿borrar?).

**Riesgos:** borrar contenido por error.

**Solución:** destino limpio o con nombre nuevo.

**Cómo se evita:** elegir carpetas de proyecto dedicadas.

---

### Error 2: Repositorio privado: «could not read Username / Authentication failed»

**Qué ocurrió:** el clon pide usuario o falla la auth.

**Por qué posibles:**
* sin credencial guardada o token caducado;
* SSH sin clave registrada;
* URL con usuario incorrecto.

**Cómo comprobarlo:** abrir la URL en el navegador (¿te pide login y te deja ver?); `ssh -T git@github.com` si es ssh.

**Opciones:**
* https: Git Credential Manager (pide login con 2FA);
* ssh: generar clave y añadirla a la cuenta.

**Riesgos:** guardar token en la URL (¡no! aparecerá en config).

**Solución:** auth moderna (sección 03).

**Cómo se evita:** configurar 2FA/ssh ANTES del primer clon privado.

---

### Error 3: Clon del repo equivocada (fork vs. oficial)

**Qué ocurrió:** trabajas en una copia que no es la que toca (o subes a tu fork sin querer cuando querías el oficial).

**Por qué:** URL copiada con prisa; en forks hay dos.

**Cómo comprobarlo:** `git remote -v`; comparar con la URL de GitHub que ves.

**Opciones:** `remote set-url` (o añadir `upstream`).

**Riesgos:** esfuerzo en el lugar equivocado.

**Solución:** verificar remote -v tras el primer clon (siempre).

**Cómo se evita:** copiar URL de la página exacta del repo que quieres.

---

### Error 4: Clon gigante / lentísimo

**Qué ocurrió:** horas de descarga en un proyecto enorme.

**Por qué:** historial pesado (imágenes, binarios) sin política LFS.

**Cómo comprobarlo:** el tamaño que muestra el navegador de GitHub; el progreso del clon.

**Opciones:**
* `--depth 1` (si no necesitas historia completa);
* sparse clone (clonar solo un subdirectorio: hoy `git clone --filter=blob:none` + sparse-checkout — nivel avanzado);
* hablar con el equipo (repositorio mal dimensionado).

**Riesgos:** shallow complica operaciones de historial.

**Solución:** profundidad mínima para CI; clon completo donde importa la historia.

**Cómo se evita:** LFS/ignorar artefactos desde el diseño (sección 07 anterior).

---

### Error 5: Clonar y no ver issues/PRs/workflows

**Qué ocurrió:** se esperaba que el clon trajera «todo lo de GitHub».

**Por qué:** son datos de la plataforma (API), no objetos Git.

**Cómo comprobarlo:** `git branch -a` no menciona PRs; `ls` sin `.github` si no hay (los workflows SÍ son archivos si existen en el repo).

**Opciones:** usar la web/API para issues y PRs.

**Riesgos:** confusión (leve).

**Solución:** separar: Git = código/historial; GitHub = plataforma.

**Cómo se evita:** este recorrido (raíz 26 ya lo decía).

---

### Error 6: «detached HEAD» o rama inesperada tras clonar

**Qué ocurrió:** el clon apunta a un tag o el HEAD remoto apunta a una rama que localmente no esperabas.

**Por qué:** HEAD del servidor apuntaba ahí (o clonaste con -b de un tag en versiones viejas).

**Cómo comprobarlo:** `git status`; `git remote show origin` (HEAD branch).

**Opciones:** `git switch <rama>` (trae la que quieras).

**Riesgos:** trabajar en la base equivocada.

**Solución:** comprobar rama tras clonar.

**Cómo se evita:** `clone -b <rama>` si siempre trabajas sobre una concreta.

---

## 5. Práctica guiada

### Objetivo

Clonar en todas sus formas clave y verificar la configuración resultante.

### Paso 1: clon completo (tu repo de GitHub)

```bash
cd <directorio-de-pruebas>
git clone https://github.com/TU-USUARIO/TU-REPO.git
cd TU-REPO
git remote -v
git log --oneline -n 5
git branch -a
```

### Paso 2: carpeta con nombre

```bash
git clone https://github.com/TU-USUARIO/TU-REPO.git copia2
```

### Paso 3: clon superficial (de un repo público cualquiera)

```bash
git clone --depth 1 https://github.com/octocat/Hello-World.git shallow1
cd shallow1
git log --oneline          # poco historial (esperado)
git fetch --unshallow      # trae el resto (si lo
                           # necesitas)
git log --oneline | Measure-Object -Line
```

### Paso 4: elegir rama

```bash
git clone -b main --single-branch <URL> solo-main
cd solo-main
git branch -a              # solo main + origin/main
```

### Paso 5: clon local (simulación de red)

```bash
git clone /ruta/a/otro/repo.git clone-local
cd clone-local
git remote -v              # apunta al local (transporte
                           # indiferente)
```

### Paso 6: clon bare (vista de servidor)

```bash
git clone --bare /ruta/a/otro/repo.git repo-bare.git
cd repo-bare.git
ls                         # sin archivos de trabajo
git log --oneline -n 3     # sí historial
```

### Resultado Esperado

Capacidad de elegir el tipo de clon adecuado y de verificar, tras clonar, remoto, rama y alcance del historial.

### Conclusión esperada

Clonar es «traer el proyecto a casa con su historia y una dirección de vuelta»; las opciones deciden cuánta historia y qué nombre recibe esa dirección.

---

## 6. Nivel profesional + resumen

### 6.1. Clones en CI/CD

```text
Patrones
──────────────────────────────────────────────
· --depth 1 + --single-branch: rápido y suficiente
  para compilar/testear
· clon completo donde hacen falta tags/bisect
· credenciales: token efímero del runner (nunca en el
  repositorio)
· submódulos: --recurse-submodules cuando aplique
  (sección 24+ si tu proyecto los usa)
```

### 6.2. Clones espejo y alternates

```text
   │
   ├── --mirror: espejo completo de refs (para
   │   servidores/backup; ver sección 09/26)
   │
   ├── object alternates: varios clones compartiendo
   │   objetos (ahorro de disco; herramientas de
   │   migración) — avanzado, con cuidado
   │
   └── GitHub Desktop y editores: usan clone por
       debajo: saber sus flags ayuda a entender lo
       que ofrecen
```

### 6.3. Resumen

En este capítulo aprendiste que:

* `git clone` crea init + remote + fetch + checkout: historial completo, `origin` configurado y fotos `origin/*`;
* opciones: carpeta destino, `-b/--branch`, `--single-branch`, `--depth` (shallow), `--origin` y `--bare`;
* un clon no trae credenciales, estados personales ni datos de plataforma (issues/PRs);
* los errores típicos (carpeta no vacía, auth, repo equivocada, clon gigante, expectativas de plataforma, rama inesperada) se diagnostican con remote -v, navegador y status;
* a nivel profesional: clones superficiales en CI, credenciales de runner efímeras y mirrors/alternates para infraestructura.

La idea principal es:

> **`clone` es la instantánea completa del proyecto con un cable de vuelta: tu decisión está en cuánta historia traes y a qué URL apunta ese cable.**

---

## Próximo paso

Ya tienes tu clon conectado.

Ahora las órdenes de la conexión: empezamos por bajar lo que otros subieron: `git fetch`.

Continúa con:

[`04-git-fetch.md`](04-git-fetch.md)
