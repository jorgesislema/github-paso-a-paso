# GitHub Paso a Paso

## De cero a nivel profesional

Bienvenido a **GitHub Paso a Paso**, un repositorio educativo diseÃ±ado para aprender a utilizar **Git y GitHub desde cero hasta un nivel profesional**.

> **VersiÃ³n del contenido:** 1.1 (octubre 2026) â€” ver el [CHANGELOG](CHANGELOG.md) para el historial de cambios.

Este material estÃ¡ pensado especialmente para personas que estÃ¡n dando sus primeros pasos en programaciÃ³n, independientemente de su edad, experiencia profesional o conocimientos previos de informÃ¡tica.

No necesitas ser programador para comenzar.

Tampoco necesitas conocer Git, GitHub ni la terminal.

AquÃ­ aprenderÃ¡s progresivamente desde los conceptos mÃ¡s sencillos hasta los utilizados en equipos profesionales de desarrollo de software.

---

# Â¿QuÃ© vas a aprender?

Durante el recorrido aprenderÃ¡s:

* Conceptos bÃ¡sicos de informÃ¡tica.
* QuÃ© es Git.
* QuÃ© es GitHub.
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
* ResoluciÃ³n de conflictos.
* Trabajo colaborativo.
* Issues.
* GitHub Projects.
* Releases.
* Tags.
* DocumentaciÃ³n con Markdown.
* `.gitignore`.
* SSH.
* Tokens y autenticaciÃ³n.
* GitHub Actions.
* IntegraciÃ³n continua.
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
* AutomatizaciÃ³n.
* Flujos de trabajo profesionales.

Y, finalmente, aplicarÃ¡s estos conocimientos en proyectos completos.

---

# La idea principal

Este repositorio no pretende enseÃ±arte simplemente una lista de comandos.

Queremos que comprendas **quÃ© estÃ¡s haciendo, por quÃ© lo haces y quÃ© ocurre detrÃ¡s de cada operaciÃ³n**.

Por ejemplo, no queremos que memorices:

```bash
git add .
git commit -m "cambios"
git push
```

sin saber quÃ© significa.

Queremos que entiendas:

```text
Modificar archivos
      â†“
Seleccionar cambios
      â†“
Crear un commit
      â†“
Guardar una versiÃ³n
      â†“
Enviar los cambios
      â†“
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
   â”‚
   â”œâ”€â”€ VersiÃ³n 1
   â”œâ”€â”€ VersiÃ³n 2
   â”œâ”€â”€ VersiÃ³n 3
   â””â”€â”€ VersiÃ³n 4
```

Git permite conocer cÃ³mo evolucionÃ³ el proyecto y recuperar versiones anteriores cuando sea necesario.

---

## GitHub

**GitHub** es una plataforma que permite alojar repositorios Git y trabajar con ellos mediante herramientas de colaboraciÃ³n y desarrollo.

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
â”‚
â””â”€â”€ Controla las versiones del proyecto

GitHub
â”‚
â””â”€â”€ Aloja repositorios Git y proporciona
    herramientas para colaborar y desarrollar
```

Git puede utilizarse sin GitHub.

GitHub utiliza Git como parte fundamental de su funcionamiento.

---

# Â¿Para quiÃ©n es este repositorio?

Este repositorio estÃ¡ pensado para:

* Personas que nunca han utilizado Git.
* Personas que nunca han utilizado GitHub.
* Personas que estÃ¡n comenzando a programar.
* Estudiantes de programaciÃ³n.
* Estudiantes de ciencia de datos.
* Estudiantes de inteligencia artificial.
* Personas que quieren aprender desarrollo de software.
* Programadores que quieren mejorar sus conocimientos de Git.
* Personas que desean aprender a trabajar en equipo.
* Personas que quieren comprender herramientas de DevOps y DevSecOps.

TambiÃ©n es adecuado para estudiantes adultos que estÃ¡n comenzando su formaciÃ³n tecnolÃ³gica.

No asumimos que el estudiante ya conozca:

* ProgramaciÃ³n.
* Linux.
* Git.
* GitHub.
* Terminal.
* LÃ­nea de comandos.
* Control de versiones.

Cada concepto importante se explica antes de utilizarlo.

---

# No tengas miedo de cometer errores

Una de las ideas mÃ¡s importantes de este curso es:

> **Aprender Git implica aprender a trabajar con cambios, errores y versiones.**

Puedes equivocarte.

Puedes crear una rama incorrectamente.

Puedes modificar un archivo que no debÃ­as modificar.

Puedes hacer un commit equivocado.

Puedes encontrarte con un conflicto.

Puedes necesitar recuperar una versiÃ³n anterior.

Eso no significa necesariamente que hayas destruido el proyecto.

Precisamente una de las funciones principales de Git es ayudarnos a **registrar, comprender y recuperar cambios**.

Por eso, durante el curso aprenderÃ¡s tanto a realizar operaciones correctamente como a recuperarte cuando algo salga mal.

---

# Â¿CÃ³mo estÃ¡ organizado el repositorio?

El contenido estÃ¡ organizado progresivamente.

```text
00  OrientaciÃ³n
 â†“
01  ComputaciÃ³n desde cero
 â†“
02  GitHub desde cero
 â†“
03  Tu cuenta de GitHub
 â†“
04  GitHub desde la web
 â†“
05  GitHub Desktop
 â†“
06  Git desde cero
 â†“
07  CÃ³mo funciona Git
 â†“
08  Ramas
 â†“
09  Repositorios remotos
 â†“
10  Conflictos
 â†“
11  Deshacer y recuperar
 â†“
12  Git avanzado
 â†“
13  ConfiguraciÃ³n y archivos especiales
 â†“
14  DocumentaciÃ³n
 â†“
15  Pull Requests
 â†“
16  Trabajo en equipo
 â†“
17  Estrategias de Git
 â†“
18  GitHub profesional
 â†“
19  GitHub Actions
 â†“
20  Seguridad
 â†“
21  Git para programadores
 â†“
22  CI/CD
 â†“
23  DevOps
 â†“
24  DevSecOps
 â†“
25  Arquitectura de repositorios
 â†“
26  Nivel senior
 â†“
27  Proyectos prÃ¡cticos
 â†“
28  Proyecto final
 â†“
29  Errores comunes
```

No es obligatorio avanzar a la misma velocidad.

Puedes volver a cualquier capÃ­tulo cuando necesites repasar un concepto.

---

# Nuestra metodologÃ­a

Cada tema intenta seguir una estructura sencilla.

## 1. Â¿QuÃ© es?

Primero explicamos el concepto con palabras sencillas.

## 2. Â¿Para quÃ© sirve?

DespuÃ©s explicamos quÃ© problema resuelve.

## 3. Ejemplo de la vida real

Cuando sea posible, relacionamos el concepto con una situaciÃ³n cotidiana.

## 4. Ejemplo tÃ©cnico

DespuÃ©s mostramos cÃ³mo se aplica en informÃ¡tica.

## 5. Comando o herramienta

Si corresponde, mostramos el comando o herramienta utilizada.

## 6. Â¿QuÃ© estÃ¡ ocurriendo?

Explicamos quÃ© sucede internamente.

## 7. PrÃ¡ctica

El estudiante realiza un ejercicio.

## 8. Errores frecuentes

Mostramos problemas habituales y cÃ³mo resolverlos.

## 9. Resumen

Finalmente repasamos los conceptos importantes.

---

# De lo visual a la terminal

No comenzaremos obligÃ¡ndote a utilizar la terminal.

El aprendizaje serÃ¡ progresivo:

```text
GitHub Web
     â†“
GitHub Desktop
     â†“
Terminal bÃ¡sica
     â†“
Git bÃ¡sico
     â†“
Git avanzado
     â†“
Flujos profesionales
```

La finalidad no es evitar la terminal.

La finalidad es que, cuando llegues a ella, **entiendas quÃ© estÃ¡s haciendo**.

---

# Nuestro modelo mental

Uno de los conceptos fundamentales del curso serÃ¡ comprender el recorrido de un cambio.

```text
             ARCHIVOS
                â”‚
                â–¼
        Working Directory
                â”‚
             git add
                â”‚
                â–¼
          Staging Area
                â”‚
           git commit
                â”‚
                â–¼
       Repositorio local
                â”‚
            git push
                â”‚
                â–¼
      Repositorio remoto
                â”‚
                â–¼
             GitHub
```

MÃ¡s adelante aprenderÃ¡s que Git tiene un modelo interno mucho mÃ¡s sofisticado.

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
     â”‚
     â–¼
Usuario de GitHub
     â”‚
     â–¼
Usuario de Git
     â”‚
     â–¼
Programador
     â”‚
     â–¼
Colaborador
     â”‚
     â–¼
Desarrollador profesional
     â”‚
     â–¼
DevOps / DevSecOps
     â”‚
     â–¼
Nivel avanzado
     â”‚
     â–¼
Nivel senior
```

Cada etapa incorpora nuevos conocimientos y responsabilidades.

---

# Git como herramienta profesional

En proyectos reales, Git no se utiliza Ãºnicamente para guardar copias de archivos.

Forma parte del proceso completo de desarrollo:

```text
PlanificaciÃ³n
     â†“
Desarrollo
     â†“
Git
     â†“
Pull Request
     â†“
Code Review
     â†“
Pruebas
     â†“
IntegraciÃ³n
     â†“
Despliegue
     â†“
ProducciÃ³n
```

Cuando avancemos hacia CI/CD y DevOps veremos cÃ³mo Git puede convertirse en uno de los puntos centrales de este flujo.

---

# GitHub y la inteligencia artificial

Los proyectos modernos tambiÃ©n utilizan Git y GitHub para desarrollar sistemas de inteligencia artificial.

Por eso encontraremos ejemplos relacionados con:

* Python.
* Ciencia de datos.
* Machine Learning.
* Inteligencia artificial.
* Modelos de lenguaje.
* APIs.
* Aplicaciones web.
* AutomatizaciÃ³n.

Aprender Git y GitHub es especialmente importante cuando trabajamos con proyectos de IA porque los proyectos suelen incluir cÃ³digo, configuraciones, documentaciÃ³n, experimentos y diferentes versiones de modelos o datos.

---

# Seguridad

La seguridad no serÃ¡ un tema que dejaremos para el final.

A medida que avancemos aprenderemos conceptos como:

* No subir contraseÃ±as.
* No publicar claves API.
* Utilizar `.gitignore`.
* Utilizar mecanismos de autenticaciÃ³n adecuados.
* SSH.
* Tokens.
* GestiÃ³n de secretos.
* Secret Scanning.
* Dependabot.
* Code Scanning.
* Seguridad de dependencias.
* Seguridad de la cadena de suministro de software.

Una regla fundamental serÃ¡:

> **Un repositorio no debe convertirse accidentalmente en un lugar donde se publiquen secretos.**

---

# Aprender haciendo

Este repositorio estÃ¡ diseÃ±ado para practicar.

No recomendamos leer todos los documentos sin ejecutar los ejemplos.

El ciclo de aprendizaje recomendado es:

```text
Leer
 â†“
Comprender
 â†“
Practicar
 â†“
Equivocarse
 â†“
Investigar
 â†“
Corregir
 â†“
Repetir
 â†“
Comprender mejor
```

La prÃ¡ctica es una parte fundamental del aprendizaje.

---

# Proyectos

A lo largo del recorrido encontrarÃ¡s proyectos progresivos.

Comenzaremos con proyectos sencillos:

* Primer repositorio.
* Diario digital.
* Recetario.
* PÃ¡gina web.

DespuÃ©s avanzaremos hacia:

* Proyecto Python.
* Proyecto de ciencia de datos.
* Proyecto de inteligencia artificial.
* Proyecto colaborativo.

Finalmente construiremos un proyecto utilizando herramientas y prÃ¡cticas profesionales.

---

# Proyecto final

El objetivo final serÃ¡ construir un proyecto que integre buena parte de los conocimientos aprendidos.

Dependiendo del recorrido del estudiante, puede incluir:

```text
CÃ³digo
DocumentaciÃ³n
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

El proyecto final permitirÃ¡ comprobar que el estudiante no solamente conoce conceptos aislados, sino que puede utilizarlos dentro de un flujo de trabajo completo.

---

# Â¿Tengo que aprender todos los comandos de Git?

No.

No es necesario memorizar decenas de comandos.

Es mÃ¡s importante comprender:

```text
Â¿QuÃ© quiero hacer?
       â†“
Â¿QuÃ© problema estoy resolviendo?
       â†“
Â¿QuÃ© herramienta necesito?
       â†“
Â¿QuÃ© comando realiza esa operaciÃ³n?
```

Con la prÃ¡ctica, los comandos utilizados habitualmente se vuelven naturales.

AdemÃ¡s, aprenderemos a consultar la documentaciÃ³n cuando no recordemos una opciÃ³n.

Un profesional no necesita recordar absolutamente todo.

Necesita saber **cÃ³mo encontrar, verificar y utilizar correctamente la informaciÃ³n que necesita**.

---

# Â¿Y si nunca he programado?

No hay problema.

El repositorio comienza desde conceptos bÃ¡sicos.

Si algÃºn tÃ©rmino resulta desconocido, puedes consultar:

**[GLOSARIO.md](GLOSARIO.md)**

TambiÃ©n encontrarÃ¡s explicaciones y ejemplos antes de introducir conceptos mÃ¡s complejos.

---

# Â¿Y si ya sÃ© programar?

Puedes avanzar mÃ¡s rÃ¡pidamente por las primeras secciones.

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

Comprender estos conceptos permite utilizar Git de una manera mucho mÃ¡s profesional.

---

# Una regla para todo el curso

Durante este recorrido encontrarÃ¡s comandos, botones, herramientas y procedimientos.

Pero intenta recordar siempre:

> **No memorices solamente quÃ© hacer. Comprende por quÃ© hacerlo.**

Ese principio serÃ¡ mucho mÃ¡s importante que memorizar comandos.

---

# Ruta recomendada

Si estÃ¡s comenzando completamente desde cero:

```text
00   OrientaciÃ³n
01   ComputaciÃ³n desde cero
02   GitHub desde cero
03   Tu cuenta
04   GitHub desde la web
05   GitHub Desktop
06   Git desde cero
07   CÃ³mo funciona Git
08   Ramas
09   Git remoto
10   Conflictos
11   RecuperaciÃ³n
12   Git avanzado
13   ConfiguraciÃ³n
14   DocumentaciÃ³n
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

# Â¿DÃ³nde comenzar?

Si nunca has utilizado Git ni GitHub:

**Comienza aquÃ­:**

â†’ [`EMPIEZA-AQUI.md`](EMPIEZA-AQUI.md)

Si ya tienes experiencia con Git:

â†’ Comienza por [`06-git-desde-cero`](06-git-desde-cero/)

Si ya conoces Git y quieres mejorar tus prÃ¡cticas profesionales:

â†’ Comienza por [`15-pull-requests`](15-pull-requests/)

Si quieres aprender automatizaciÃ³n:

â†’ Ve a [`19-github-actions`](19-github-actions/)

Si te interesa DevOps:

â†’ Ve a [`23-devops`](23-devops/)

Si quieres profundizar en seguridad:

â†’ Ve a [`20-github-security`](20-github-security/)

Si buscas conocimientos avanzados:

â†’ Ve a [`26-nivel-senior`](26-nivel-senior/)

---

# FilosofÃ­a del repositorio

Este proyecto se basa en una idea sencilla:

> **La tecnologÃ­a debe poder aprenderse paso a paso.**

No importa si tienes 20, 40, 60 o 70 aÃ±os.

No importa si nunca has escrito una lÃ­nea de cÃ³digo.

No importa si vienes de otra profesiÃ³n.

La experiencia previa puede ayudarte, pero comenzar desde cero no significa que no puedas llegar lejos.

Lo importante es avanzar progresivamente, practicar y comprender lo que estÃ¡s haciendo.

---

# Objetivo final

Al terminar el recorrido, el estudiante deberÃ­a ser capaz de comprender y participar en un flujo moderno de desarrollo de software basado en Git y GitHub.

Desde:

```text
"Â¿QuÃ© es GitHub?"
```

hasta:

```text
"Â¿CÃ³mo diseÃ±o y mantengo un flujo
profesional de desarrollo, colaboraciÃ³n,
automatizaciÃ³n y seguridad?"
```

Ese es el objetivo de **GitHub Paso a Paso**.

---

## Licencia

Este material estÃ¡ destinado a fines educativos.

Consulta el archivo [`LICENSE`](LICENSE) para conocer las condiciones completas de uso, modificaciÃ³n y distribuciÃ³n del contenido.

---

## Contribuciones

Si encuentras:

* Errores ortogrÃ¡ficos.
* Errores tÃ©cnicos.
* Enlaces rotos.
* Explicaciones confusas.
* Ejemplos incorrectos.
* InformaciÃ³n desactualizada.

puedes consultar [`CONTRIBUTING.md`](CONTRIBUTING.md) para conocer cÃ³mo contribuir al proyecto.

---

## Â¿Encontraste un problema?

No tengas miedo de reportarlo.

Encontrar un error tambiÃ©n forma parte del proceso de aprendizaje y mejora del software.

Consulta:

**[`comunidad/como-reportar-un-error.md`](comunidad/como-reportar-un-error.md)**

---

# Bienvenido

No necesitas saberlo todo para comenzar.

Solo necesitas dar el primer paso.

**Bienvenido a GitHub Paso a Paso.**

