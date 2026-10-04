# GitHub Paso a Paso

## De cero a nivel profesional

Bienvenido a **GitHub Paso a Paso**, un repositorio educativo diseñado para aprender a utilizar **Git y GitHub desde cero hasta un nivel profesional**.

> **Versión del contenido:** 1.1 (octubre 2026) — ver el [CHANGELOG](CHANGELOG.md) para el historial de cambios.

Este material está pensado especialmente para personas que están dando sus primeros pasos en programación, independientemente de su edad, experiencia profesional o conocimientos previos de informática.

No necesitas ser programador para comenzar.

Tampoco necesitas conocer Git, GitHub ni la terminal.

Aquí aprenderás progresivamente desde los conceptos más sencillos hasta los utilizados en equipos profesionales de desarrollo de software.

---

# ¿Qué vas a aprender?

Durante el recorrido aprenderás:

* Conceptos básicos de informática.
* Qué es Git.
* Qué es GitHub.
* Diferencias entre Git y GitHub.
* Control de versiones.
* Repositorios.
* Commits.
* Ramas.
* Merge.
* Rebase.
* Repositorios locales y remotos.
* `push`, `pull` y `fetch`.
* Pull Requests.
* Code Review.
* Resolución de conflictos.
* Trabajo colaborativo.
* Issues.
* GitHub Projects.
* Releases.
* Tags.
* Documentación con Markdown.
* `.gitignore`.
* SSH.
* Tokens y autenticación.
* GitHub Actions.
* Integración continua.
* Entrega continua.
* Despliegue continuo.
* Seguridad de repositorios.
* Secret Scanning.
* Dependabot.
* Code Scanning.
* CI/CD.
* DevOps.
* DevSecOps.
* Arquitectura de repositorios.
* Estrategias de branching.
* Gobernanza.
* Automatización.
* Flujos de trabajo profesionales.

Y, finalmente, aplicarás estos conocimientos en proyectos completos.

---

# La idea principal

Este repositorio no pretende enseñarte simplemente una lista de comandos.

Queremos que comprendas **qué estás haciendo, por qué lo haces y qué ocurre detrás de cada operación**.

Por ejemplo, no queremos que memorices:

```bash
git add .
git commit -m "cambios"
git push
```

sin saber qué significa.

Queremos que entiendas:

```text
Modificar archivos
      ↓
Seleccionar cambios
      ↓
Crear un commit
      ↓
Guardar una versión
      ↓
Enviar los cambios
      ↓
Repositorio remoto
```

Cuando comprendes el proceso, los comandos dejan de ser algo que debes memorizar y se convierten en herramientas que sabes utilizar.

---

# Git y GitHub no son lo mismo

Esta es una de las primeras cosas que debes aprender.

## Git

**Git** es un sistema de control de versiones distribuido.

Permite registrar los cambios realizados en un proyecto y mantener un historial de sus diferentes versiones.

Por ejemplo:

```text
Proyecto
   │
   ├── Versión 1
   ├── Versión 2
   ├── Versión 3
   └── Versión 4
```

Git permite conocer cómo evolucionó el proyecto y recuperar versiones anteriores cuando sea necesario.

---

## GitHub

**GitHub** es una plataforma que permite alojar repositorios Git y trabajar con ellos mediante herramientas de colaboración y desarrollo.

Entre otras cosas, permite trabajar con:

* Repositorios.
* Pull Requests.
* Issues.
* Code Review.
* GitHub Actions.
* Releases.
* Projects.
* Seguridad.
* Colaboradores.
* Organizaciones.

Una forma sencilla de entenderlo es:

```text
Git
│
└── Controla las versiones del proyecto

GitHub
│
└── Aloja repositorios Git y proporciona
    herramientas para colaborar y desarrollar
```

Git puede utilizarse sin GitHub.

GitHub utiliza Git como parte fundamental de su funcionamiento.

---

# ¿Para quién es este repositorio?

Este repositorio está pensado para:

* Personas que nunca han utilizado Git.
* Personas que nunca han utilizado GitHub.
* Personas que están comenzando a programar.
* Estudiantes de programación.
* Estudiantes de ciencia de datos.
* Estudiantes de inteligencia artificial.
* Personas que quieren aprender desarrollo de software.
* Programadores que quieren mejorar sus conocimientos de Git.
* Personas que desean aprender a trabajar en equipo.
* Personas que quieren comprender herramientas de DevOps y DevSecOps.

También es adecuado para estudiantes adultos que están comenzando su formación tecnológica.

No asumimos que el estudiante ya conozca:

* Programación.
* Linux.
* Git.
* GitHub.
* Terminal.
* Línea de comandos.
* Control de versiones.

Cada concepto importante se explica antes de utilizarlo.

---

# No tengas miedo de cometer errores

Una de las ideas más importantes de este curso es:

> **Aprender Git implica aprender a trabajar con cambios, errores y versiones.**

Puedes equivocarte.

Puedes crear una rama incorrectamente.

Puedes modificar un archivo que no debías modificar.

Puedes hacer un commit equivocado.

Puedes encontrarte con un conflicto.

Puedes necesitar recuperar una versión anterior.

Eso no significa necesariamente que hayas destruido el proyecto.

Precisamente una de las funciones principales de Git es ayudarnos a **registrar, comprender y recuperar cambios**.

Por eso, durante el curso aprenderás tanto a realizar operaciones correctamente como a recuperarte cuando algo salga mal.

---

# ¿Cómo está organizado el repositorio?

El contenido está organizado progresivamente.

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
09  Repositorios remotos
 ↓
10  Conflictos
 ↓
11  Deshacer y recuperar
 ↓
12  Git avanzado
 ↓
13  Configuración y archivos especiales
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
27  Proyectos prácticos
 ↓
28  Proyecto final
 ↓
29  Errores comunes
```

No es obligatorio avanzar a la misma velocidad.

Puedes volver a cualquier capítulo cuando necesites repasar un concepto.

---

# Nuestra metodología

Cada tema intenta seguir una estructura sencilla.

## 1. ¿Qué es?

Primero explicamos el concepto con palabras sencillas.

## 2. ¿Para qué sirve?

Después explicamos qué problema resuelve.

## 3. Ejemplo de la vida real

Cuando sea posible, relacionamos el concepto con una situación cotidiana.

## 4. Ejemplo técnico

Después mostramos cómo se aplica en informática.

## 5. Comando o herramienta

Si corresponde, mostramos el comando o herramienta utilizada.

## 6. ¿Qué está ocurriendo?

Explicamos qué sucede internamente.

## 7. Práctica

El estudiante realiza un ejercicio.

## 8. Errores frecuentes

Mostramos problemas habituales y cómo resolverlos.

## 9. Resumen

Finalmente repasamos los conceptos importantes.

---

# De lo visual a la terminal

No comenzaremos obligándote a utilizar la terminal.

El aprendizaje será progresivo:

```text
GitHub Web
     ↓
GitHub Desktop
     ↓
Terminal básica
     ↓
Git básico
     ↓
Git avanzado
     ↓
Flujos profesionales
```

La finalidad no es evitar la terminal.

La finalidad es que, cuando llegues a ella, **entiendas qué estás haciendo**.

---

# Nuestro modelo mental

Uno de los conceptos fundamentales del curso será comprender el recorrido de un cambio.

```text
             ARCHIVOS
                │
                ▼
        Working Directory
                │
             git add
                │
                ▼
          Staging Area
                │
           git commit
                │
                ▼
       Repositorio local
                │
            git push
                │
                ▼
      Repositorio remoto
                │
                ▼
             GitHub
```

Más adelante aprenderás que Git tiene un modelo interno mucho más sofisticado.

Estudiaremos conceptos como:

* Commits.
* Hashes.
* Objetos de Git.
* HEAD.
* Ramas.
* Referencias.
* Historial.
* Grafos de commits.
* Repositorios locales.
* Repositorios remotos.

---

# De estudiante a desarrollador

El objetivo no es que termines el curso sabiendo solamente utilizar GitHub.

Queremos que progresivamente desarrolles una forma profesional de trabajar.

```text
Principiante
     │
     ▼
Usuario de GitHub
     │
     ▼
Usuario de Git
     │
     ▼
Programador
     │
     ▼
Colaborador
     │
     ▼
Desarrollador profesional
     │
     ▼
DevOps / DevSecOps
     │
     ▼
Nivel avanzado
     │
     ▼
Nivel senior
```

Cada etapa incorpora nuevos conocimientos y responsabilidades.

---

# Git como herramienta profesional

En proyectos reales, Git no se utiliza únicamente para guardar copias de archivos.

Forma parte del proceso completo de desarrollo:

```text
Planificación
     ↓
Desarrollo
     ↓
Git
     ↓
Pull Request
     ↓
Code Review
     ↓
Pruebas
     ↓
Integración
     ↓
Despliegue
     ↓
Producción
```

Cuando avancemos hacia CI/CD y DevOps veremos cómo Git puede convertirse en uno de los puntos centrales de este flujo.

---

# GitHub y la inteligencia artificial

Los proyectos modernos también utilizan Git y GitHub para desarrollar sistemas de inteligencia artificial.

Por eso encontraremos ejemplos relacionados con:

* Python.
* Ciencia de datos.
* Machine Learning.
* Inteligencia artificial.
* Modelos de lenguaje.
* APIs.
* Aplicaciones web.
* Automatización.

Aprender Git y GitHub es especialmente importante cuando trabajamos con proyectos de IA porque los proyectos suelen incluir código, configuraciones, documentación, experimentos y diferentes versiones de modelos o datos.

---

# Seguridad

La seguridad no será un tema que dejaremos para el final.

A medida que avancemos aprenderemos conceptos como:

* No subir contraseñas.
* No publicar claves API.
* Utilizar `.gitignore`.
* Utilizar mecanismos de autenticación adecuados.
* SSH.
* Tokens.
* Gestión de secretos.
* Secret Scanning.
* Dependabot.
* Code Scanning.
* Seguridad de dependencias.
* Seguridad de la cadena de suministro de software.

Una regla fundamental será:

> **Un repositorio no debe convertirse accidentalmente en un lugar donde se publiquen secretos.**

---

# Aprender haciendo

Este repositorio está diseñado para practicar.

No recomendamos leer todos los documentos sin ejecutar los ejemplos.

El ciclo de aprendizaje recomendado es:

```text
Leer
 ↓
Comprender
 ↓
Practicar
 ↓
Equivocarse
 ↓
Investigar
 ↓
Corregir
 ↓
Repetir
 ↓
Comprender mejor
```

La práctica es una parte fundamental del aprendizaje.

---

# Proyectos

A lo largo del recorrido encontrarás proyectos progresivos.

Comenzaremos con proyectos sencillos:

* Primer repositorio.
* Diario digital.
* Recetario.
* Página web.

Después avanzaremos hacia:

* Proyecto Python.
* Proyecto de ciencia de datos.
* Proyecto de inteligencia artificial.
* Proyecto colaborativo.

Finalmente construiremos un proyecto utilizando herramientas y prácticas profesionales.

---

# Proyecto final

El objetivo final será construir un proyecto que integre buena parte de los conocimientos aprendidos.

Dependiendo del recorrido del estudiante, puede incluir:

```text
Código
Documentación
Git
GitHub
Ramas
Pull Requests
Code Review
Tests
GitHub Actions
CI/CD
Seguridad
Release
```

El proyecto final permitirá comprobar que el estudiante no solamente conoce conceptos aislados, sino que puede utilizarlos dentro de un flujo de trabajo completo.

---

# ¿Tengo que aprender todos los comandos de Git?

No.

No es necesario memorizar decenas de comandos.

Es más importante comprender:

```text
¿Qué quiero hacer?
       ↓
¿Qué problema estoy resolviendo?
       ↓
¿Qué herramienta necesito?
       ↓
¿Qué comando realiza esa operación?
```

Con la práctica, los comandos utilizados habitualmente se vuelven naturales.

Además, aprenderemos a consultar la documentación cuando no recordemos una opción.

Un profesional no necesita recordar absolutamente todo.

Necesita saber **cómo encontrar, verificar y utilizar correctamente la información que necesita**.

---

# ¿Y si nunca he programado?

No hay problema.

El repositorio comienza desde conceptos básicos.

Si algún término resulta desconocido, puedes consultar:

**[GLOSARIO.md](GLOSARIO.md)**

También encontrarás explicaciones y ejemplos antes de introducir conceptos más complejos.

---

# ¿Y si ya sé programar?

Puedes avanzar más rápidamente por las primeras secciones.

Sin embargo, te recomendamos revisar los fundamentos de Git.

Muchos programadores saben utilizar:

```bash
git add
git commit
git push
```

pero no comprenden completamente:

* El staging area.
* HEAD.
* Las referencias.
* El grafo de commits.
* Rebase.
* Reflog.
* Reset.
* Restore.
* Cherry-pick.
* Estrategias de branching.
* Flujos colaborativos.

Comprender estos conceptos permite utilizar Git de una manera mucho más profesional.

---

# Una regla para todo el curso

Durante este recorrido encontrarás comandos, botones, herramientas y procedimientos.

Pero intenta recordar siempre:

> **No memorices solamente qué hacer. Comprende por qué hacerlo.**

Ese principio será mucho más importante que memorizar comandos.

---

# Ruta recomendada

Si estás comenzando completamente desde cero:

```text
00   Orientación
01   Computación desde cero
02   GitHub desde cero
03   Tu cuenta
04   GitHub desde la web
05   GitHub Desktop
06   Git desde cero
07   Cómo funciona Git
08   Ramas
09   Git remoto
10   Conflictos
11   Recuperación
12   Git avanzado
13   Configuración
14   Documentación
15   Pull Requests
16   Trabajo en equipo
17   Estrategias
18   GitHub profesional
19   GitHub Actions
20   Seguridad
21   Git aplicado
22   CI/CD
23   DevOps
24   DevSecOps
25   Arquitectura
26   Nivel senior
27   Proyectos
28   Proyecto final
29   Errores comunes
```

---

# ¿Dónde comenzar?

Si nunca has utilizado Git ni GitHub:

**Comienza aquí:**

→ [`EMPIEZA-AQUI.md`](EMPIEZA-AQUI.md)

Si ya tienes experiencia con Git:

→ Comienza por [`06-git-desde-cero`](06-git-desde-cero/)

Si ya conoces Git y quieres mejorar tus prácticas profesionales:

→ Comienza por [`15-pull-requests`](15-pull-requests/)

Si quieres aprender automatización:

→ Ve a [`19-github-actions`](19-github-actions/)

Si te interesa DevOps:

→ Ve a [`23-devops`](23-devops/)

Si quieres profundizar en seguridad:

→ Ve a [`20-github-security`](20-github-security/)

Si buscas conocimientos avanzados:

→ Ve a [`26-nivel-senior`](26-nivel-senior/)

---

# Filosofía del repositorio

Este proyecto se basa en una idea sencilla:

> **La tecnología debe poder aprenderse paso a paso.**

No importa si tienes 20, 40, 60 o 70 años.

No importa si nunca has escrito una línea de código.

No importa si vienes de otra profesión.

La experiencia previa puede ayudarte, pero comenzar desde cero no significa que no puedas llegar lejos.

Lo importante es avanzar progresivamente, practicar y comprender lo que estás haciendo.

---

# Objetivo final

Al terminar el recorrido, el estudiante debería ser capaz de comprender y participar en un flujo moderno de desarrollo de software basado en Git y GitHub.

Desde:

```text
"¿Qué es GitHub?"
```

hasta:

```text
"¿Cómo diseño y mantengo un flujo
profesional de desarrollo, colaboración,
automatización y seguridad?"
```

Ese es el objetivo de **GitHub Paso a Paso**.

---

## Licencia

Este material está destinado a fines educativos.

Consulta el archivo [`LICENSE`](LICENSE) para conocer las condiciones completas de uso, modificación y distribución del contenido.

---

## Contribuciones

Si encuentras:

* Errores ortográficos.
* Errores técnicos.
* Enlaces rotos.
* Explicaciones confusas.
* Ejemplos incorrectos.
* Información desactualizada.

puedes consultar [`CONTRIBUTING.md`](CONTRIBUTING.md) para conocer cómo contribuir al proyecto.

---

## ¿Encontraste un problema?

No tengas miedo de reportarlo.

Encontrar un error también forma parte del proceso de aprendizaje y mejora del software.

Consulta:

**[`comunidad/como-reportar-un-error.md`](comunidad/como-reportar-un-error.md)**

---

# Bienvenido

No necesitas saberlo todo para comenzar.

Solo necesitas dar el primer paso.

**Bienvenido a GitHub Paso a Paso.**

