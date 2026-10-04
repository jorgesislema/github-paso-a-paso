# Empieza aquí

## Tu primer paso para aprender Git y GitHub

Si llegaste hasta aquí y no sabes por dónde empezar, estás en el lugar correcto.

Este documento está diseñado para ayudarte a responder una pregunta muy sencilla:

> **¿Qué debo estudiar primero?**

La respuesta depende de tus conocimientos actuales.

No necesitas saber programación para comenzar.

No necesitas conocer Git.

No necesitas conocer GitHub.

No necesitas utilizar la terminal.

Vamos a avanzar paso a paso.

---

# Antes de comenzar

Hay algo importante que queremos decirte:

> **No tienes que aprender todo de una vez.**

Git, GitHub, programación y desarrollo de software contienen muchos conceptos nuevos.

Al principio pueden parecer complicados.

Es completamente normal.

En este repositorio iremos construyendo los conocimientos progresivamente.

Primero aprenderás los conceptos sencillos.

Después aprenderás cómo utilizarlos.

Finalmente aprenderás qué ocurre internamente y cómo aplicar estos conocimientos en proyectos profesionales.

---

# ¿Cuál es tu nivel?

Elige la situación que más se parezca a la tuya.

---

## Nivel 0 — Nunca he programado

Si nunca has programado y tampoco estás familiarizado con conceptos básicos de informática, comienza aquí:

### 1. Computación desde cero

Ve a:

[`01-computacion-desde-cero/`](01-computacion-desde-cero/)

Aprenderás:

* Qué es un archivo.
* Qué es una carpeta.
* Qué es una ruta.
* Qué es una extensión.
* Cómo organizar archivos.
* Qué es un programa.
* Qué es una terminal.

Después continúa con:

[`02-github-desde-cero/`](02-github-desde-cero/)

---

# Nivel 1 — Sé utilizar una computadora, pero Git es nuevo para mí

Si utilizas normalmente una computadora, puedes crear carpetas, descargar archivos y navegar por Internet, pero nunca has utilizado Git o GitHub:

Comienza aquí:

[`02-github-desde-cero/`](02-github-desde-cero/)

Después:

```text
02 → GitHub desde cero
03 → Tu cuenta de GitHub
04 → GitHub desde la web
05 → GitHub Desktop
06 → Git desde cero
```

No necesitas comenzar utilizando comandos.

Primero aprenderás qué significa cada concepto.

---

# Nivel 2 — Ya tengo una cuenta de GitHub

Si ya tienes una cuenta pero nunca has trabajado seriamente con repositorios:

Comienza por:

[`03-tu-cuenta-de-github/`](03-tu-cuenta-de-github/)

Después continúa con:

[`04-github-desde-la-web/`](04-github-desde-la-web/)

Aprenderás a:

* Crear un repositorio.
* Crear archivos.
* Modificar archivos.
* Subir archivos.
* Crear commits.
* Consultar el historial.

---

# Nivel 3 — Ya conozco GitHub Desktop

Si ya utilizas GitHub Desktop pero todavía no entiendes bien Git:

Ve directamente a:

[`06-git-desde-cero/`](06-git-desde-cero/)

Después estudia:

[`07-como-funciona-git/`](07-como-funciona-git/)

Aquí comenzaremos a comprender qué sucede realmente cuando realizamos operaciones con Git.

---

# Nivel 4 — Ya utilizo Git

Si ya conoces comandos como:

```bash
git clone
git add
git commit
git push
git pull
git status
```

puedes comenzar en:

[`07-como-funciona-git/`](07-como-funciona-git/)

Aquí profundizaremos en:

* Working Directory.
* Staging Area.
* Repositorio local.
* Repositorio remoto.
* Commits.
* Hashes.
* HEAD.
* Referencias.
* Historial.
* Grafo de commits.

Este punto es importante porque queremos pasar de:

> “Sé qué comando escribir.”

a:

> “Comprendo qué está haciendo Git.”

---

# Nivel 5 — Ya conozco Git, pero quiero trabajar en equipo

Si ya utilizas Git y GitHub y quieres aprender a colaborar profesionalmente:

Comienza por:

[`15-pull-requests/`](15-pull-requests/)

Después continúa con:

[`16-trabajo-en-equipo/`](16-trabajo-en-equipo/)

Aprenderás:

* Pull Requests.
* Code Review.
* Issues.
* Permisos.
* Colaboradores.
* Projects.
* Code Owners.
* Flujos de trabajo.

---

# Nivel 6 — Quiero aprender Git avanzado

Si ya tienes experiencia trabajando con Git, puedes estudiar:

[`11-git-deshacer-y-recuperar/`](11-git-deshacer-y-recuperar/)

y después:

[`12-git-avanzado/`](12-git-avanzado/)

Aquí encontrarás conceptos como:

```bash
git restore
git revert
git reset
git stash
git reflog
git rebase
git cherry-pick
git bisect
git blame
git worktree
```

No intentes memorizarlos todos.

Primero comprende qué problema resuelve cada uno.

---

# Nivel 7 — Quiero aprender GitHub profesional

Continúa con:

[`18-github-profesional/`](18-github-profesional/)

Aprenderás a estructurar repositorios para proyectos reales y equipos de desarrollo.

Estudiaremos:

* Issues.
* Pull Requests.
* Plantillas.
* Releases.
* Projects.
* Code Owners.
* Organizaciones.
* Permisos.
* Documentación.

---

# Nivel 8 — Quiero automatizar mis proyectos

Ve a:

[`19-github-actions/`](19-github-actions/)

Aquí comenzaremos a automatizar tareas.

Por ejemplo:

```text
Desarrollador
     │
     ▼
git push
     │
     ▼
GitHub
     │
     ▼
GitHub Actions
     │
     ├── Ejecutar pruebas
     ├── Analizar código
     ├── Construir aplicación
     └── Desplegar
```

Aprenderás conceptos relacionados con:

* Workflows.
* Events.
* Triggers.
* Jobs.
* Steps.
* Runners.
* Artifacts.
* Secrets.
* Variables.
* Matrices.
* Testing.
* Deployment.

---

# Nivel 9 — Quiero aprender seguridad

Si estás interesado en seguridad informática, continúa con:

[`20-github-security/`](20-github-security/)

Aquí aprenderás a proteger los repositorios y los procesos de desarrollo.

Entre otros temas:

* Tokens.
* SSH.
* Secretos.
* `.gitignore`.
* Secret Scanning.
* Dependabot.
* Code Scanning.
* Dependencias.
* Supply Chain Security.
* Seguridad de CI/CD.

Una de las primeras reglas será:

> **Nunca publiques accidentalmente una contraseña, una clave API o un secreto dentro de un repositorio.**

---

# Nivel 10 — Soy programador

Si ya programas en Python, JavaScript u otro lenguaje, puedes avanzar rápidamente.

Te recomendamos:

```text
06 → Git desde cero
07 → Cómo funciona Git
08 → Ramas
09 → Git remoto
10 → Conflictos
11 → Recuperación
12 → Git avanzado
15 → Pull Requests
16 → Trabajo en equipo
17 → Estrategias
18 → GitHub profesional
```

Después puedes continuar hacia:

```text
19 → GitHub Actions
20 → Seguridad
22 → CI/CD
23 → DevOps
24 → DevSecOps
```

---

# Nivel 11 — Trabajo con datos o inteligencia artificial

Si estudias:

* Ciencia de datos.
* Machine Learning.
* Inteligencia artificial.
* Ingeniería de IA.
* Análisis de datos.

consulta:

[`21-git-para-programadores/`](21-git-para-programadores/)

Encontrarás ejemplos relacionados con:

```text
Python
   ↓
Git
   ↓
GitHub
   ↓
Datos
   ↓
Experimentos
   ↓
Modelos
   ↓
Aplicaciones de IA
```

Git es especialmente útil para mantener un historial de los cambios realizados durante un proyecto.

---

# Nivel 12 — Quiero aprender DevOps

Continúa con:

[`22-ci-cd/`](22-ci-cd/)

y posteriormente:

[`23-devops/`](23-devops/)

Aquí el enfoque cambia.

Ya no solamente aprenderás:

> “¿Cómo guardo mi código?”

Comenzarás a estudiar:

> “¿Cómo automatizo el proceso desde el código hasta la entrega de una aplicación?”

---

# Nivel 13 — Quiero aprender DevSecOps

Después de estudiar DevOps, continúa con:

[`24-devsecops/`](24-devsecops/)

Aprenderás cómo incorporar seguridad dentro del ciclo de desarrollo.

Por ejemplo:

```text
Código
  ↓
Commit
  ↓
Pull Request
  ↓
Análisis de seguridad
  ↓
Pruebas
  ↓
Build
  ↓
Deployment
```

La seguridad deja de ser una actividad exclusivamente posterior al desarrollo.

Se incorpora progresivamente al proceso.

---

# Nivel 14 — Quiero llegar a nivel avanzado o senior

Cuando tengas una base sólida, estudia:

[`25-arquitectura-de-repositorios/`](25-arquitectura-de-repositorios/)

y después:

[`26-nivel-senior/`](26-nivel-senior/)

Aquí cambia el tipo de preguntas.

Ya no se trata solamente de:

> “¿Qué comando utilizo?”

Comenzarás a preguntarte:

> “¿Qué estrategia debería utilizar para este proyecto?”

> “¿Cómo debería organizar los repositorios?”

> “¿Cómo debería controlar los permisos?”

> “¿Cómo debería diseñar el flujo de trabajo?”

> “¿Cómo reducimos los riesgos?”

> “¿Cómo automatizamos el proceso?”

> “¿Cómo recuperamos el sistema después de un incidente?”

Ese cambio de perspectiva es importante para avanzar hacia un nivel profesional.

---

# Ruta completa recomendada

Si quieres realizar todo el recorrido desde cero, utiliza esta ruta:

```text
00  Orientación
 ↓
01  Computación desde cero
 ↓
02  GitHub desde cero
 ↓
03  Tu cuenta de GitHub
 ↓
04  GitHub desde la web
 ↓
05  GitHub Desktop
 ↓
06  Git desde cero
 ↓
07  Cómo funciona Git
 ↓
08  Ramas
 ↓
09  Git remoto
 ↓
10  Conflictos
 ↓
11  Deshacer y recuperar
 ↓
12  Git avanzado
 ↓
13  Configuración de Git
 ↓
14  Documentación
 ↓
15  Pull Requests
 ↓
16  Trabajo en equipo
 ↓
17  Estrategias de Git
 ↓
18  GitHub profesional
 ↓
19  GitHub Actions
 ↓
20  Seguridad
 ↓
21  Git para programadores
 ↓
22  CI/CD
 ↓
23  DevOps
 ↓
24  DevSecOps
 ↓
25  Arquitectura de repositorios
 ↓
26  Nivel senior
 ↓
27  Proyectos
 ↓
28  Proyecto final
 ↓
29  Errores comunes
```

---

# ¿Tengo que completar todo?

No necesariamente.

El recorrido depende de tus objetivos.

Por ejemplo:

### Quiero aprender GitHub para proyectos personales

Puedes llegar aproximadamente hasta:

```text
04 → GitHub desde la web
05 → GitHub Desktop
06 → Git
08 → Ramas
09 → Git remoto
```

### Quiero ser desarrollador

Te recomendamos llegar hasta:

```text
18 → GitHub profesional
19 → GitHub Actions
20 → Seguridad
```

y continuar con los proyectos.

### Quiero trabajar en DevOps

Deberías continuar hasta:

```text
22 → CI/CD
23 → DevOps
24 → DevSecOps
25 → Arquitectura
26 → Nivel senior
```

---

# Una recomendación importante

No avances únicamente leyendo.

Para aprender Git necesitas practicar.

Por ejemplo, después de estudiar:

```bash
git add
git commit
git push
```

realiza inmediatamente un pequeño ejercicio.

Crea un archivo:

```text
hola.txt
```

Escribe algo dentro.

Después:

```bash
git status
```

Observa qué cambió.

Después:

```bash
git add hola.txt
```

Vuelve a ejecutar:

```bash
git status
```

Observa nuevamente qué cambió.

Después:

```bash
git commit -m "Agregar archivo de prueba"
```

Y finalmente:

```bash
git push
```

La finalidad no es memorizar esos comandos.

La finalidad es observar el recorrido:

```text
Archivo modificado
       ↓
Working Directory
       ↓
git add
       ↓
Staging Area
       ↓
git commit
       ↓
Repositorio local
       ↓
git push
       ↓
GitHub
```

Cuando puedas explicar ese recorrido con tus propias palabras, habrás aprendido algo importante.

---

# ¿Qué hago si me equivoco?

Primero:

**No entres en pánico.**

Lee el mensaje que Git te muestra.

Guarda el mensaje de error.

Busca en el repositorio la sección:

[`29-errores-comunes/`](29-errores-comunes/)

También puedes consultar:

[`GLOSARIO.md`](GLOSARIO.md)

y:

[`PREGUNTAS-FRECUENTES.md`](PREGUNTAS-FRECUENTES.md)

Aprender a interpretar los errores es parte del aprendizaje.

---

# Cómo pedir ayuda correctamente

Cuando necesites ayuda, evita escribir solamente:

> “Git no funciona.”

Intenta proporcionar:

1. Qué estabas intentando hacer.
2. Qué comando ejecutaste.
3. Qué esperabas que ocurriera.
4. Qué ocurrió realmente.
5. El mensaje de error completo.

Por ejemplo:

```text
Estoy intentando subir mi proyecto a GitHub.

Ejecuté:

git push origin main

Esperaba que los archivos se subieran.

Git muestra:

[mensaje de error]

¿Qué significa y cómo puedo solucionarlo?
```

Una buena pregunta facilita enormemente la resolución de un problema.

Consulta:

[`comunidad/como-pedir-ayuda.md`](comunidad/como-pedir-ayuda.md)

---

# Una regla para aprender

Durante este curso encontrarás muchos comandos.

No intentes memorizarlos todos inmediatamente.

Utiliza esta secuencia:

```text
Comprender
    ↓
Practicar
    ↓
Repetir
    ↓
Consultar
    ↓
Volver a practicar
```

Con el tiempo, los comandos más utilizados se volverán familiares.

---

# Tu primer objetivo

No pienses todavía en ser experto.

Tu primer objetivo es mucho más sencillo:

> **Crear tu primer repositorio y comprender qué estás haciendo.**

Después aprenderás a modificarlo.

Después aprenderás a guardar versiones.

Después aprenderás a trabajar con ramas.

Después aprenderás a colaborar.

Y progresivamente llegarás a herramientas y prácticas profesionales.

---

# Recuerda

No importa desde dónde comienzas.

Puedes empezar sin conocimientos de programación.

Puedes tener muchos años de experiencia profesional en otra área.

Puedes sentir que la tecnología es complicada.

El aprendizaje será progresivo.

Lo importante es avanzar paso a paso.

```text
Primer paso
     ↓
Primer archivo
     ↓
Primer repositorio
     ↓
Primer commit
     ↓
Primera rama
     ↓
Primer Pull Request
     ↓
Primer proyecto
     ↓
Primer proyecto colaborativo
     ↓
Automatización
     ↓
Seguridad
     ↓
CI/CD
     ↓
DevOps
     ↓
DevSecOps
     ↓
Nivel profesional
```

---

# Comienza ahora

Si eres completamente nuevo:

[`01-computacion-desde-cero/`](01-computacion-desde-cero/)

Si ya sabes utilizar una computadora y quieres conocer GitHub:

[`02-github-desde-cero/`](02-github-desde-cero/)

Si ya utilizas Git:

[`06-git-desde-cero/`](06-git-desde-cero/)

Si ya eres programador:

[`07-como-funciona-git/`](07-como-funciona-git/)

Si quieres aprender colaboración profesional:

[`15-pull-requests/`](15-pull-requests/)

Si quieres automatización:

[`19-github-actions/`](19-github-actions/)

Si quieres seguridad:

[`20-github-security/`](20-github-security/)

Si quieres DevOps:

[`23-devops/`](23-devops/)

Si quieres llegar al nivel avanzado:

[`26-nivel-senior/`](26-nivel-senior/)

---

# Sobre el diseño de este curso

Si te interesa saber **por qué** el curso está ordenado así — y no solo **por dónde** empezar:

[`00-orientacion/07-como-fue-disenado-este-curso.md`](00-orientacion/07-como-fue-disenado-este-curso.md)

---

# Bienvenido al recorrido

No necesitas saberlo todo.

No necesitas aprenderlo todo hoy.

Solo necesitas comenzar.

**Un paso a la vez.**
