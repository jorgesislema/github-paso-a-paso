# Guía para contribuir

## GitHub Paso a Paso

Gracias por tu interés en contribuir a **GitHub Paso a Paso**.

Este repositorio tiene un objetivo educativo: ayudar a personas que comienzan desde cero a comprender Git y GitHub y acompañarlas progresivamente hasta un nivel profesional.

Todas las contribuciones que mejoren la claridad, exactitud, accesibilidad y calidad técnica del material son bienvenidas.

---

# 1. ¿Quién puede contribuir?

Cualquier persona puede contribuir.

No necesitas ser desarrollador profesional para aportar.

Puedes contribuir si encuentras:

* una falta de ortografía;
* una explicación difícil de entender;
* un enlace incorrecto;
* un ejemplo que puede mejorarse;
* un comando obsoleto;
* un concepto técnicamente incorrecto;
* una sección que necesita mayor explicación;
* un ejercicio que debería modificarse;
* un error en un diagrama;
* una pregunta frecuente que debería añadirse;
* un tema importante que falta.

También puedes proponer nuevos contenidos.

---

# 2. Antes de contribuir

Antes de realizar una modificación, revisa:

1. El `README.md`.
2. `EMPIEZA-AQUI.md`.
3. `GLOSARIO.md`.
4. `PREGUNTAS-FRECUENTES.md`.
5. El capítulo relacionado con tu propuesta.

Esto ayuda a evitar:

* duplicación de contenido;
* conceptos contradictorios;
* estructuras diferentes para temas similares;
* información repetida innecesariamente.

---

# 3. Tipos de contribuciones

Existen diferentes formas de contribuir.

## 3.1 Corrección de ortografía

Puedes corregir:

* tildes;
* errores ortográficos;
* puntuación;
* mayúsculas;
* errores gramaticales;
* palabras mal escritas.

Ejemplo:

```text
Incorrecto:
GitHub es una platafoma para repositorios.

Correcto:
GitHub es una plataforma para repositorios.
```

Las correcciones pequeñas también son importantes.

---

# 3.2 Corrección técnica

Si encuentras una explicación técnicamente incorrecta, puedes proponer una corrección.

Por ejemplo:

```text
Incorrecto:
git pull solamente descarga archivos.

Mejor:
git pull obtiene cambios del repositorio remoto y los integra
según la configuración utilizada.
```

Cuando una modificación afecta a un concepto técnico, intenta incluir una explicación o fuente que permita verificarla.

---

# 3.3 Mejora de explicaciones

Una explicación puede ser técnicamente correcta y, aun así, resultar difícil de comprender.

Puedes proponer:

* ejemplos más sencillos;
* analogías;
* diagramas;
* pasos intermedios;
* explicaciones adicionales;
* ejemplos prácticos.

La claridad es una característica técnica importante en un repositorio educativo.

---

# 3.4 Nuevos ejercicios

Los ejercicios son especialmente valiosos.

Un buen ejercicio debería indicar:

```text
Objetivo
Requisitos
Pasos
Resultado esperado
Errores frecuentes
Qué aprendiste
```

Ejemplo:

```text
Objetivo:
Crear tu primer commit.

Requisitos:
Tener Git instalado.

Resultado esperado:
Un repositorio con al menos un commit.
```

---

# 3.5 Nuevos capítulos

Antes de crear un capítulo completamente nuevo, comprueba que el tema no exista ya.

Si el tema es nuevo, la propuesta debería indicar:

* título;
* ubicación;
* objetivo;
* conceptos que cubrirá;
* nivel;
* relación con otros capítulos.

---

# 3.6 Diagramas e imágenes

Los diagramas pueden utilizarse cuando ayudan a comprender un concepto.

Son especialmente útiles para explicar:

* ramas;
* commits;
* merge;
* rebase;
* repositorios locales y remotos;
* GitHub Actions;
* CI/CD;
* flujos de trabajo.

Un diagrama debe simplificar el concepto, no hacerlo más complicado.

---

# 4. Principios educativos

Este repositorio sigue algunos principios fundamentales.

## 4.1 Primero comprender, después memorizar

No queremos enseñar Git como una lista de comandos.

La explicación debería responder:

```text
¿Qué es?
¿Por qué existe?
¿Qué problema resuelve?
¿Cómo funciona?
¿Cómo se utiliza?
¿Qué puede salir mal?
```

---

## 4.2 De lo sencillo a lo avanzado

Los contenidos deben avanzar progresivamente.

La ruta general es:

```text
Computación básica
       ↓
GitHub
       ↓
Git básico
       ↓
Modelo interno de Git
       ↓
Ramas
       ↓
Trabajo remoto
       ↓
Conflictos
       ↓
Git avanzado
       ↓
Colaboración
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
Arquitectura
       ↓
Nivel profesional
```

No debemos asumir conocimientos que todavía no se han explicado.

---

## 4.3 Explicar los términos técnicos

Cuando aparezca un término importante por primera vez, debe explicarse.

Por ejemplo, si se introduce:

```text
staging area
```

debe explicarse qué significa antes de utilizarlo como si el lector ya lo conociera.

---

## 4.4 Utilizar ejemplos reales

Siempre que sea posible, los conceptos deben acompañarse con ejemplos.

Por ejemplo:

```bash
git status
```

es más útil cuando se explica:

> "Este comando te permite saber qué está ocurriendo actualmente en tu repositorio."

---

# 5. Reglas de escritura

Todos los documentos deberían seguir estas reglas.

## 5.1 Idioma

El idioma principal del repositorio es el español.

Debe utilizarse español claro y correcto.

Los términos técnicos que normalmente se utilizan en inglés pueden conservarse cuando sea conveniente.

Ejemplos:

* commit;
* branch;
* merge;
* rebase;
* Pull Request;
* staging area;
* workflow;
* runner;
* pipeline.

Cuando sea útil, debe proporcionarse la traducción o explicación.

---

## 5.2 Ortografía

Revisa:

* tildes;
* puntuación;
* concordancia;
* mayúsculas;
* nombres técnicos;
* comandos.

Ejemplo:

```text
Incorrecto:
GitHub es una platafoma donde se aloja codigo.

Correcto:
GitHub es una plataforma donde se aloja código.
```

---

## 5.3 Claridad

Evita frases innecesariamente complejas.

En lugar de:

> El mecanismo subyacente mediante el cual se efectúa la sincronización diferencial de referencias...

Es preferible:

> Git compara el historial local con el remoto y determina qué cambios deben intercambiarse.

La precisión técnica no requiere utilizar lenguaje innecesariamente complicado.

---

## 5.4 No asumir conocimientos

Evita escribir:

> Simplemente hacemos un rebase y después hacemos un push.

Para un principiante puede ser incomprensible.

Es mejor:

> Primero debemos entender qué es un rebase y qué cambia en el historial. Después podremos decidir si es apropiado utilizarlo.

---

# 6. Estructura recomendada para los capítulos

Cuando sea apropiado, un capítulo puede seguir una estructura similar:

```text
# Título

## Introducción

## ¿Qué es?

## ¿Para qué sirve?

## Conceptos necesarios

## Ejemplo sencillo

## Ejemplo práctico

## Cómo hacerlo

## Qué ocurre internamente

## Errores frecuentes

## Buenas prácticas

## Ejercicio

## Resumen

## Siguiente paso
```

No es obligatorio utilizar todas las secciones en todos los documentos.

La estructura debe adaptarse al tema.

---

# 7. Comandos y código

Los comandos deben escribirse utilizando bloques de código.

Ejemplo:

```bash
git status
```

Cuando sea necesario explicar el resultado:

```text
On branch main
nothing to commit, working tree clean
```

No presentes comandos importantes únicamente dentro de párrafos largos.

---

# 8. Nunca ocultar información importante

Si un comando puede provocar pérdida de información, debe advertirse.

Por ejemplo:

```bash
git reset --hard
```

No debe presentarse simplemente como:

> "Este comando arregla el repositorio."

Debe explicarse que puede descartar cambios locales y que debe utilizarse con cuidado.

Lo mismo aplica a operaciones como:

```bash
git clean
git push --force
git reset
git rebase
```

---

# 9. Seguridad

Las contribuciones nunca deben incluir secretos reales.

No publiques:

* contraseñas;
* API keys;
* tokens;
* claves privadas;
* credenciales;
* certificados privados;
* datos personales innecesarios.

Nunca utilices credenciales reales en ejemplos.

Utiliza valores ficticios:

```text
API_KEY=ejemplo_no_real
```

en lugar de:

```text
API_KEY=sk-xxxxxxxxxxxxxxxx
```

---

# 10. No subir archivos innecesarios

Antes de hacer un commit revisa:

```bash
git status
```

Comprueba que no estés incluyendo:

* `.env`;
* contraseñas;
* archivos temporales;
* carpetas de entornos virtuales;
* archivos generados;
* datos privados;
* archivos enormes innecesarios.

Utiliza `.gitignore` cuando corresponda.

---

# 11. Cómo proponer una modificación

Si encuentras un problema pequeño, puedes crear una propuesta directamente.

Para cambios mayores, primero es recomendable abrir un Issue o discusión explicando la propuesta.

Incluye:

```text
¿Qué problema existe?

¿Por qué debería cambiarse?

¿Qué solución propones?

¿Qué archivos serían afectados?

¿Existen consecuencias para otros capítulos?
```

Esto permite discutir la modificación antes de invertir tiempo en implementarla.

---

# 12. Crear una rama

No realices cambios directamente sobre la rama principal cuando estés trabajando en una contribución que requiere revisión.

Crea una rama:

```bash
git switch -c docs/mejorar-explicacion-git
```

Ejemplos de nombres:

```text
docs/corregir-readme
docs/mejorar-glosario
fix/error-comando
fix/enlace-roto
feat/nuevo-ejercicio
```

El nombre debe describir razonablemente el objetivo de la rama.

---

# 13. Realizar los cambios

Modifica únicamente lo necesario.

Evita mezclar cambios sin relación.

Por ejemplo, si estás corrigiendo un error en `GLOSARIO.md`, evita modificar simultáneamente veinte archivos sin relación.

Una contribución pequeña y enfocada es más fácil de revisar.

---

# 14. Revisar los cambios

Antes de realizar el commit:

```bash
git status
```

Después:

```bash
git diff
```

Comprueba:

* ortografía;
* formato;
* comandos;
* enlaces;
* ejemplos;
* estructura;
* contenido técnico.

---

# 15. Realizar el commit

Utiliza un mensaje claro.

Ejemplos:

```bash
git commit -m "Corregir explicación de git pull"
```

```bash
git commit -m "Agregar ejercicio sobre ramas"
```

```bash
git commit -m "Actualizar preguntas frecuentes"
```

Evita mensajes como:

```text
git commit -m "cambios"
```

o:

```text
git commit -m "arreglado"
```

---

# 16. Crear un Pull Request

Después de realizar los cambios y subir la rama:

```bash
git push -u origin nombre-de-la-rama
```

Puedes crear un Pull Request desde GitHub.

El Pull Request debería explicar:

### Qué cambió

Describe brevemente la modificación.

### Por qué cambió

Explica el problema que se estaba solucionando.

### Cómo se verificó

Indica qué comprobaciones realizaste.

Ejemplo:

```text
Se corrigió la explicación de git pull.

Se revisó el comportamiento descrito y se actualizó
el ejemplo para diferenciar pull de fetch.

También se revisó la ortografía del documento.
```

---

# 17. Revisión de Pull Requests

Las revisiones deben centrarse en el contenido, no en la persona.

Una buena revisión puede preguntar:

* ¿La explicación es correcta?
* ¿Es comprensible para un principiante?
* ¿El ejemplo funciona?
* ¿El comando es correcto?
* ¿Falta alguna advertencia?
* ¿Existe información duplicada?
* ¿La modificación contradice otro capítulo?

Evita comentarios personales o despectivos.

---

# 18. Si una contribución necesita cambios

Es normal que un Pull Request necesite modificaciones.

Una solicitud de cambio no significa que la persona haya hecho un mal trabajo.

Forma parte del proceso de revisión.

La conversación debería centrarse en:

```text
Problema
   ↓
Explicación
   ↓
Propuesta
   ↓
Corrección
   ↓
Nueva revisión
```

---

# 19. Cambios técnicos que requieren especial cuidado

Las modificaciones relacionadas con Git deben revisarse cuidadosamente cuando afecten:

* comportamiento de comandos;
* historial;
* merge;
* rebase;
* reset;
* revert;
* recuperación;
* autenticación;
* seguridad;
* GitHub Actions;
* permisos;
* CI/CD.

Una explicación técnicamente incorrecta puede provocar pérdida de datos o introducir vulnerabilidades.

---

# 20. Verificación de ejemplos

Antes de incluir un comando en un tutorial, intenta comprobarlo en un repositorio de prueba.

Por ejemplo:

```text
repositorio-prueba/
├── README.md
└── ejemplo.txt
```

Evita probar comandos destructivos directamente sobre un proyecto importante.

Especialmente:

```bash
git reset --hard
git clean
git push --force
```

---

# 21. Cambios en GitHub Actions

Los workflows de GitHub Actions requieren especial atención.

Antes de modificar un workflow:

1. Comprende qué evento lo ejecuta.
2. Revisa qué permisos utiliza.
3. Revisa qué secretos utiliza.
4. Comprueba las acciones externas.
5. Comprueba los comandos ejecutados.
6. Verifica que no se expongan credenciales.
7. Comprueba el resultado.

La automatización puede ejecutar código con permisos importantes.

---

# 22. Contribuciones relacionadas con seguridad

Si encuentras una vulnerabilidad de seguridad real, evita publicar inmediatamente todos los detalles en un Issue público.

Primero debe utilizarse el mecanismo privado de reporte de seguridad disponible para el proyecto, si existe.

Una vulnerabilidad real puede requerir coordinación antes de hacerse pública.

---

# 23. Documentación de fuentes

Cuando una contribución introduce información técnica importante, es recomendable indicar fuentes fiables.

Pueden utilizarse:

* documentación oficial;
* especificaciones;
* documentación de Git;
* documentación de GitHub;
* documentación de herramientas;
* RFC;
* estándares;
* publicaciones técnicas reconocidas.

Las fuentes deben utilizarse para verificar la información, no simplemente para decorar el documento.

---

# 24. Mantener la información actualizada

Las herramientas evolucionan.

Un documento puede quedar técnicamente obsoleto aunque anteriormente haya sido correcto.

Cuando actualices información, considera:

* versión de Git;
* cambios de GitHub;
* cambios en GitHub Actions;
* cambios de seguridad;
* cambios en interfaces;
* comandos obsoletos;
* nuevas prácticas.

Evita afirmar que algo es "la única forma correcta" cuando existen varias alternativas válidas.

---

# 25. No eliminar contenido solamente porque sea antiguo

Un concepto antiguo puede seguir siendo importante para comprender Git.

Antes de eliminar una explicación, comprueba si:

* sigue siendo técnicamente válida;
* explica conceptos históricos;
* aparece en proyectos existentes;
* ayuda a comprender una característica moderna.

Si una característica está obsoleta, explica su estado en lugar de ocultar la información sin contexto.

---

# 26. Calidad antes que cantidad

No buscamos llenar el repositorio con cientos de páginas.

Buscamos crear material:

```text
Claro
   +
Correcto
   +
Práctico
   +
Progresivo
   +
Actualizado
   +
Comprensible
```

Un buen ejemplo puede ser más útil que diez páginas de teoría.

---

# 27. Filosofía de las contribuciones

Una buena contribución debería dejar el repositorio mejor que como lo encontró.

Puede ser una modificación de una sola línea:

```text
"corregir una palabra"
```

o una contribución grande:

```text
"crear un capítulo completo sobre conflictos"
```

Ambas pueden ser valiosas.

La calidad y utilidad de la contribución son más importantes que su tamaño.

---

# 28. Lista de comprobación antes del Pull Request

Antes de crear un Pull Request, comprueba:

```text
[ ] Entiendo qué problema estoy solucionando.
[ ] Revisé si el problema ya había sido reportado.
[ ] No estoy duplicando contenido.
[ ] El texto está en español correcto.
[ ] Revisé la ortografía.
[ ] Revisé los comandos.
[ ] Probé los ejemplos cuando corresponde.
[ ] No incluí secretos.
[ ] No incluí información privada.
[ ] Revisé git status.
[ ] Revisé git diff.
[ ] El commit tiene un mensaje claro.
[ ] La descripción del Pull Request explica el cambio.
```

---

# 29. Para estudiantes que hacen su primera contribución

Si nunca has contribuido a un repositorio, no necesitas comenzar con una modificación compleja.

Una excelente primera contribución puede ser:

```text
1. Encontrar una falta de ortografía.
2. Crear una rama.
3. Corregirla.
4. Hacer commit.
5. Hacer push.
6. Crear un Pull Request.
```

Con esa pequeña tarea habrás practicado un flujo profesional real.

---

# 30. Si cometes un error

No abandones inmediatamente.

Los errores son parte del aprendizaje.

Si accidentalmente haces algo incorrecto:

```text
Detente
  ↓
No ejecutes más comandos al azar
  ↓
Observa el estado
  ↓
git status
  ↓
Analiza el problema
  ↓
Busca una solución
```

Cuando sea necesario, crea un repositorio de prueba para experimentar.

---

# 31. Código de conducta

Todas las personas que contribuyan deben mantener una comunicación respetuosa.

No se aceptan:

* insultos;
* acoso;
* ataques personales;
* discriminación;
* amenazas;
* comportamiento deliberadamente destructivo.

Las discusiones técnicas pueden ser firmes.

Las personas deben ser tratadas con respeto.

---

# 32. Principio fundamental

La finalidad de una contribución no es demostrar que alguien sabe más que otra persona.

La finalidad es mejorar el conocimiento disponible para todos.

Por eso:

> Una explicación técnicamente correcta pero imposible de entender para un principiante necesita mejorar.

Y también:

> Una explicación sencilla pero técnicamente incorrecta necesita corregirse.

El objetivo es conseguir ambas cosas:

```text
Rigor técnico
      +
Claridad
      +
Práctica
      +
Accesibilidad
```

---

# 33. Flujo resumido para contribuir

El flujo completo puede verse así:

```text
Encontrar un problema
        ↓
Comprenderlo
        ↓
Comprobar que no esté reportado
        ↓
Crear una rama
        ↓
Realizar cambios
        ↓
Revisar cambios
        ↓
Probar
        ↓
Commit
        ↓
Push
        ↓
Pull Request
        ↓
Revisión
        ↓
Correcciones
        ↓
Aprobación
        ↓
Merge
```

Este flujo es, además, una práctica real para aprender Git y GitHub.

---

# 34. Contribuye también aprendiendo

Si estás estudiando Git y GitHub, contribuir a este repositorio puede formar parte de tu aprendizaje.

No necesitas esperar hasta "saber Git".

Puedes aprender Git utilizando Git.

Puedes practicar:

```text
Branches
Commits
Push
Pull
Pull Requests
Code Review
Conflictos
Merge
Documentación
```

Cada contribución puede convertirse en un ejercicio práctico.

---

# 35. Gracias por contribuir

Gracias por ayudar a mejorar **GitHub Paso a Paso**.

Cada corrección, explicación, ejemplo, ejercicio o propuesta puede ayudar a otra persona a superar una dificultad que tú también encontraste.

La meta del proyecto es construir una guía que permita recorrer este camino:

```text
No sé qué es Git
        ↓
Entiendo Git
        ↓
Puedo utilizar Git
        ↓
Puedo colaborar
        ↓
Puedo automatizar
        ↓
Puedo proteger mis proyectos
        ↓
Puedo diseñar flujos profesionales
        ↓
Puedo tomar decisiones técnicas con criterio
```

Una contribución pequeña puede ser el punto de partida para que otra persona aprenda algo importante.
