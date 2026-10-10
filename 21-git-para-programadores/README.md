# 21 — Git para programadores, datos e inteligencia artificial

## Bienvenido a esta sección

Hasta aquí el oficio es común a todo el mundo; aquí empieza la aplicación por disciplina. Python pide entornos y locks; JavaScript, un gestor y un `node_modules` invisible; los proyectos de datos separan código de datos y registran experimentos; la inteligencia artificial añade prompts, configuraciones, modelos y pipelines que hay que saber dónde versionar.

## En esta sección estudiarás

* la estructura, dependencias y `.gitignore` de proyectos Python;
* el mundo JavaScript: manifiestos, lockfiles, scripts y salidas de build;
* ciencia de datos: notebooks, entornos, experimentos y reproducibilidad;
* inteligencia artificial: configs, prompts, artefactos y trazabilidad de modelos;
* archivos grandes: criterio de entrada, LFS, almacenes y saneo;
* la lista definitiva de lo que jamás debe entrar al historial.

## Objetivos de aprendizaje

* estructurar un proyecto Python con dependencias fijadas y `.gitignore` correcto;
* aplicar la disciplina de un gestor, un lockfile y unos scripts en JavaScript;
* manejar notebooks con reproducibilidad y registrar experimentos en ciencia de datos;
* versionar prompts, configuración y artefactos en un proyecto de IA;
* decidir el destino de los archivos grandes: LFS, almacén externo o «jamás»;
* aplicar la lista definitiva de lo que jamás debe entrar al historial.

## Mapa conceptual

```mermaid
  root((21 · Git para programadores, datos e inteligencia artificial))
    01 Git para Python
      Estructura del proyecto
      Dependencias versionadas
    02 Git para JavaScript
      Estructura del proyecto
      package.json y lockfiles
    03 Git para ciencia de datos
      Estructura proyecto datos
      Notebooks ordenados
    04 Git para inteligencia artificial
      Mapa de componentes
      Código, configs y prompts en Git
    05 Datos, artefactos y archivos grandes
      Por qué Git odia binarios grandes
      Criterio de entrada
    06 Qué no debe entrar al repositorio
      La regla que lo explica todo
      Lista negra comentada
```

---
## ¿Qué aprenderás en esta sección?

1. [`01-git-para-python.md`](01-git-para-python.md) — estructura, locks, tests y guion de Python.
2. [`02-git-para-javascript.md`](02-git-para-javascript.md) — un gestor, un lock, unos scripts.
3. [`03-git-para-ciencia-de-datos.md`](03-git-para-ciencia-de-datos.md) — notebooks sin caos y experimentos registrados.
4. [`04-git-para-inteligencia-artificial.md`](04-git-para-inteligencia-artificial.md) — prompts, configs, fichas de modelo y pipelines.
5. [`05-datos-artefactos-y-archivos-grandes.md`](05-datos-artefactos-y-archivos-grandes.md) — qué entra, con qué tecnología y cómo sanear.
6. [`06-que-no-debe-entrar-al-repo.md`](06-que-no-debe-entrar-al-repo.md) — credenciales, datos y la respuesta cuando ya entró.

## Cómo estudiar esta sección

Si programas en uno de estos mundos, aplica el capítulo a tu proyecto de práctica mientras lees; si no, lee los tres primeros (patrones que se repiten) y mira los de datos/IA como «así se ven otros equipos». El capítulo 05 y 06 son comunes a todos: léelos siempre.

## Referencias

* Chacon, S. y Straub, B. — *Pro Git* (cap. 2: directorios por lenguaje).
* Git LFS — Documentación oficial (git-lfs.github.com).
* The 12-Factor App — configuration y build (12factor.net).
* Knaus, S. et al. — «Making reproducible research reusable» (PNAS, 2009) — principio de reproducibilidad.

---

## Próximo paso
## Autopreguntas de cierre
1. ¿Cómo explicarías con tus propias palabras el concepto de Bienvenido a esta sección?
1. ¿Cuál es la relación entre En esta sección estudiarás y Objetivos de aprendizaje?
1. ¿Qué pasos seguirías para aplicar Objetivos de aprendizaje en un escenario real?
1. ¿Qué errores comunes debes evitar al trabajar con Mapa conceptual?
1. ¿Cómo medirías el éxito al implementar ¿Qué aprenderás en esta sección??
1. ¿Qué herramientas o comandos mencionados en el capítulo son esenciales para Cómo estudiar esta sección?
1. ¿Cómo adaptarías el proceso descrito en Referencias si tuvieran que trabajar en un entorno distribuido?
1. ¿Qué principio subyace detrás de la recomendación de Próximo paso?
## Próximo paso

Cuando termines los seis capítulos, continúa con la siguiente sección:

[`../22-ci-cd/`](../22-ci-cd/)
