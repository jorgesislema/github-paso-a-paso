# 29 — Errores comunes

## Bienvenido a esta sección

Los errores no son el final del camino: son el mapa del territorio. Esta sección es un **manual de diagnóstico** basado en situaciones reales — olvidé la contraseña, hice un commit equivocado, eliminé un archivo, empujé al repositorio incorrecto, me rechazaron el push, apareció un conflicto, borré una rama con trabajo, perdí un commit, hice un reset incorrecto, no puedo hacer pull, no puedo hacer push, y no sé qué significa el mensaje que Git me muestra. Cada capítulo convierte una situación en un procedimiento: qué ocurrió, por qué, cómo comprobarlo y cómo evitar que se repita.

## En esta sección estudiarás

* el criterio de diagnóstico: mensaje completo, familia y comprobación antes de actuar;
* contraseñas, tokens y segundo factor: recuperación sin pánico;
* historial: commit equivocado, commit perdido y reset incorrecto con el criterio «¿publicado?»;
* archivos y ramas eliminados: en qué capa estaban y cómo volver;
* sincronización: push al repo incorrecto, push rechazado, pull y push que no avanzan;
* conflictos como procedimiento y los mensajes de Git como diccionario al que regresar.

## Objetivos de aprendizaje

Al terminar esta sección serás capaz de:

* aplicar el criterio de diagnóstico: mensaje completo, familia del error y comprobación antes de actuar;
* recuperar contraseñas, tokens y segundo factor sin pánico;
* elegir entre `reset`, `revert` y `restore` con el criterio «¿está publicado?»;
* localizar archivos y ramas eliminados según en qué capa vivían;
* corregir sincronizaciones: push al repo incorrecto, push rechazado, pull y push bloqueados;
* resolver conflictos como procedimiento de siete pasos.

---

## ¿Qué aprenderás en esta sección?

1. [`01-contrasenas-y-acceso.md`](01-contrasenas-y-acceso.md) — token expirado, 2FA perdido, permisos y lectores.
2. [`02-commits-y-historial.md`](02-commits-y-historial.md) — commit equivocado, commit perdido y reset incorrecto.
3. [`03-archivos-y-ramas.md`](03-archivos-y-ramas.md) — eliminé un archivo / eliminé una rama: diagnóstico de capas.
4. [`04-push-y-pull.md`](04-push-y-pull.md) — push al repo incorrecto, push rechazado, pull y push bloqueados.
5. [`05-conflictos-y-merge.md`](05-conflictos-y-merge.md) — qué son, cómo leerlos y los 7 pasos para resolverlos.
6. [`06-mensajes-y-significados-de-git.md`](06-mensajes-y-significados-de-git.md) — el diccionario: familias de mensajes y método de 4 pasos.

## Cómo estudiar esta sección

Lee los capítulos en orden la primera vez: los criterios del capítulo 01 (acceso) y 02 (¿publicado?) gobiernan los demás. Después usa la sección como referencia: cuando te ocurra algo real, entra al capítulo que corresponda, copia el mensaje de error COMPLETO y sigue su procedimiento. Practica los «Paso a paso» en un repositorio de ensayo antes de necesitarlos en serio — un error practicado vale más que diez leídos.

## Referencias

* Las secciones 10 y 11 de este curso (conflictos; deshacer y recuperar).
* Git — Documentación oficial: sección de errores y Cookbook (git-scm.com).
* La comunidad Git (Stack Overflow) como diccionario de mensajes de error.

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de la sección:

1. ¿Cuál es la primera pregunta antes de actuar sobre un error?
2. Un commit desapareció tras un reset: ¿dónde está y cómo se recupera?
3. Pushaste al repositorio equivocado: ¿cuál es el procedimiento correcto?
4. ¿Qué diferencia hay entre «perdí un archivo» y «perdí una rama» en el diagnóstico?

---

## Próximo paso

Cuando termines los seis capítulos, has completado la ruta del curso. Regresa al mapa general para repasar la ruta o volver a cualquier sección:

[`../README.md`](../README.md)
