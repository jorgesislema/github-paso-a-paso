# Cómo estudiar este repositorio

## Una guía para aprender Git y GitHub de verdad

Aprender Git y GitHub no consiste en leer cientos de páginas ni en memorizar una lista interminable de comandos.

Tampoco consiste en copiar comandos desde Internet o pedirle a una inteligencia artificial que nos diga qué escribir cada vez que aparece un error.

El objetivo de este repositorio es desarrollar una habilidad mucho más importante:

> **Comprender qué está ocurriendo, actuar conscientemente y poder resolver problemas por cuenta propia.**

Para conseguirlo, utilizaremos un método progresivo basado en:

```text
Comprender
    ↓
Observar
    ↓
Practicar
    ↓
Experimentar
    ↓
Equivocarse
    ↓
Diagnosticar
    ↓
Corregir
    ↓
Repetir
    ↓
Explicar
    ↓
Aplicar
```

---

# 1. No intentes aprender todo de una vez

Git tiene muchas funcionalidades.

Algunas son sencillas:

```bash
git status
git add
git commit
```

Otras requieren más conocimientos:

```bash
git merge
git rebase
git cherry-pick
git reflog
git bisect
```

Y existen conceptos que aparecen en contextos profesionales:

```text
Pull Requests
Code Review
CI/CD
GitHub Actions
DevSecOps
Gobernanza
Arquitectura de repositorios
```

No intentes aprender todo el primer día.

El conocimiento se construye por capas.

```text
Fundamentos
     ↓
Práctica
     ↓
Integración
     ↓
Profundización
     ↓
Especialización
```

---

# 2. Sigue la progresión del repositorio

La estructura está diseñada deliberadamente para aumentar la complejidad.

En términos generales:

```text
00 — Orientación
       ↓
01 — Computación desde cero
       ↓
02 — GitHub desde cero
       ↓
03 — Cuenta de GitHub
       ↓
04 — GitHub Web
       ↓
05 — GitHub Desktop
       ↓
06 — Git desde cero
       ↓
07 — Cómo funciona Git
       ↓
08 — Ramas
       ↓
09 — Git remoto
       ↓
10 — Conflictos
       ↓
11 — Deshacer y recuperar
       ↓
12 — Git avanzado
       ↓
...
       ↓
26 — Nivel senior
```

No es necesario que absolutamente todas las personas comiencen en el mismo punto.

Sin embargo, **no conviene saltarse conceptos fundamentales simplemente porque parecen demasiado sencillos**.

---

# 3. Determina desde dónde debes comenzar

Antes de estudiar, hazte estas preguntas.

### Pregunta 1

¿Sé utilizar una computadora con comodidad?

Si la respuesta es no:

```text
01-computacion-desde-cero/
```

### Pregunta 2

¿Sé qué es GitHub?

Si no:

```text
02-github-desde-cero/
```

### Pregunta 3

¿Tengo una cuenta de GitHub?

Si no:

```text
03-tu-cuenta-de-github/
```

### Pregunta 4

¿Sé utilizar Git desde la terminal?

Si no:

```text
06-git-desde-cero/
```

### Pregunta 5

¿Entiendo realmente qué ocurre cuando ejecuto `git add` y `git commit`?

Si no:

```text
07-como-funciona-git/
```

La ruta correcta depende de tus conocimientos actuales.

---

# 4. Primera regla: leer no es aprender

Leer una explicación puede producir una sensación de comprensión.

Pero existe una diferencia entre:

> "Esto me parece lógico."

y:

> "Puedo hacerlo yo mismo."

Por ejemplo, puedes leer:

```bash
git commit
```

y pensar que lo entiendes.

Pero el aprendizaje real comienza cuando puedes:

1. realizar un cambio;
2. preparar ese cambio;
3. crear un commit;
4. consultar el historial;
5. identificar qué cambió;
6. explicar qué ocurrió.

Por eso:

> **Cada concepto importante debe terminar en una práctica.**

---

# 5. El ciclo de estudio recomendado

Para cada tema utiliza este ciclo:

```text
┌────────────────────┐
│ 1. Leer            │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ 2. Comprender      │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ 3. Ejecutar        │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ 4. Observar        │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ 5. Experimentar    │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ 6. Resolver error  │
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ 7. Explicar        │
└────────────────────┘
```

Después puedes avanzar.

---

# 6. Paso 1 — Lee para comprender

Cuando leas un capítulo, no intentes memorizarlo inmediatamente.

Busca responder:

* ¿Qué concepto estoy aprendiendo?
* ¿Qué problema resuelve?
* ¿Por qué existe?
* ¿Cómo se relaciona con lo anterior?
* ¿Qué cambia en mi proyecto?
* ¿Qué podría salir mal?

Por ejemplo, al estudiar:

```bash
git add
```

no pienses únicamente:

> "Este comando sirve para agregar archivos."

Pregúntate:

> ¿Agregar dónde?

La respuesta lleva al concepto de **Staging Area**.

Ese tipo de pregunta es lo que transforma una instrucción en comprensión.

---

# 7. Paso 2 — Haz el ejemplo exactamente como aparece

La primera vez que estudies un concepto, realiza el ejemplo sin modificarlo.

Por ejemplo:

```bash
git status
```

Observa el resultado.

Después:

```bash
git add archivo.txt
```

Vuelve a ejecutar:

```bash
git status
```

Compara los resultados.

La diferencia entre ambos estados es parte del aprendizaje.

---

# 8. Paso 3 — Cambia el ejemplo

Cuando el ejemplo funcione, modifícalo.

Si el ejemplo utiliza:

```text
archivo.txt
```

prueba con:

```text
notas.txt
```

Después crea otro archivo.

Después modifica dos archivos.

Después modifica uno y deja otro sin preparar.

La pregunta deja de ser:

> "¿Qué dice el tutorial?"

y comienza a ser:

> "¿Qué ocurre si hago esto?"

Ahí comienza el aprendizaje profundo.

---

# 9. Paso 4 — Experimenta en un repositorio de práctica

Es recomendable tener un repositorio exclusivamente para experimentar.

Por ejemplo:

```text
git-practica/
```

Dentro puedes probar:

* commits;
* ramas;
* merges;
* conflictos;
* revert;
* reset;
* stash;
* rebase.

No necesitas preocuparte por romper un proyecto importante.

Puedes experimentar deliberadamente.

---

# 10. Crea un laboratorio de Git

Un buen método de aprendizaje consiste en crear un pequeño laboratorio.

Por ejemplo:

```text
git-laboratorio/
├── README.md
├── notas.txt
└── experimentos/
```

Después inicializa Git:

```bash
git init
```

Consulta:

```bash
git status
```

Realiza un cambio.

Haz un commit.

Realiza otro cambio.

Haz otro commit.

Después consulta:

```bash
git log
```

Ahora tienes un entorno donde puedes experimentar sin miedo.

---

# 11. Provoca errores de forma controlada

Esto es especialmente importante.

Una persona que nunca provoca errores puede saber ejecutar un tutorial.

Pero una persona que aprende a diagnosticar errores desarrolla una habilidad mucho más útil.

Por ejemplo:

* crear dos ramas;
* modificar la misma línea;
* intentar hacer merge;
* observar el conflicto;
* analizarlo;
* resolverlo.

El objetivo no es romper el proyecto.

El objetivo es **crear una situación controlada para comprender qué ocurre**.

---

# 12. Aprende a leer los mensajes de Git

Git suele proporcionar información útil cuando ocurre un problema.

Por ejemplo:

```text
error: failed to push some refs
```

No pienses inmediatamente:

> "Git está roto."

Pregúntate:

> "¿Qué está intentando decirme Git?"

Después analiza:

* qué comando ejecuté;
* qué estado tenía el repositorio;
* qué cambió;
* qué información proporciona el mensaje;
* qué documentación existe sobre ese error.

Los mensajes de error son parte del aprendizaje.

---

# 13. No copies soluciones sin comprenderlas

Internet está lleno de respuestas como:

```bash
git reset --hard HEAD~1
```

o:

```bash
git push --force
```

Puede que una solución sea correcta para una situación concreta.

Pero eso no significa que sea correcta para tu situación.

Antes de ejecutar un comando debes conocer:

```text
¿Qué hace?
¿Qué modifica?
¿Qué puedo perder?
¿Puedo recuperarlo?
¿Estoy trabajando solo?
¿Estoy modificando una rama compartida?
```

Especialmente cuando el comando modifica el historial.

---

# 14. Cuidado con la inteligencia artificial

La inteligencia artificial puede ser una excelente herramienta de aprendizaje.

Puedes utilizarla para:

* explicar conceptos;
* generar ejercicios;
* analizar errores;
* comparar comandos;
* crear ejemplos;
* hacer preguntas;
* practicar entrevistas;
* revisar tus explicaciones.

Pero no debes convertirla en un sustituto de tu comprensión.

Por ejemplo, no es suficiente preguntar:

> "Dime qué comando debo ejecutar."

Es mejor preguntar:

> "Este es el estado de mi repositorio. Este fue el comando que ejecuté y este es el error. Explícame qué ocurrió y qué alternativas tengo. No me des todavía el comando."

Después puedes analizar las opciones.

Esto desarrolla razonamiento técnico.

---

# 15. Utiliza la IA como profesor, no como piloto automático

Una buena interacción puede seguir este patrón:

```text
Tú:
"Explícame qué ocurrió."

        ↓

IA:
"El repositorio local y remoto tienen
historias diferentes."

        ↓

Tú:
"¿Cómo puedo comprobarlo?"

        ↓

IA:
"Puedes revisar el historial y las referencias."

        ↓

Tú:
"¿Qué alternativas tengo?"

        ↓

IA:
"Puedes integrar los cambios mediante
merge o rebase dependiendo del contexto."

        ↓

Tú:
"Explícame los riesgos."

        ↓

IA:
"Rebase puede reescribir historial..."
```

Así estás aprendiendo.

---

# 16. Utiliza la documentación oficial

Este repositorio busca explicar los conceptos de manera sencilla, pero no reemplaza la documentación oficial de las herramientas.

A medida que avances, aprenderás a consultar documentación de:

* Git;
* GitHub;
* GitHub Actions;
* herramientas relacionadas;
* tecnologías utilizadas por tus proyectos.

Una habilidad profesional importante es:

> **Saber buscar información técnica fiable.**

No depender exclusivamente de tutoriales o respuestas de terceros.

---

# 17. Aprende a distinguir tres tipos de información

Cuando investigues algo, diferencia:

### Documentación oficial

Explica cómo funciona una herramienta según su documentación mantenida por el proyecto o proveedor.

### Experiencia de la comunidad

Puede aportar soluciones prácticas y casos reales.

### Opinión personal

Puede ser útil, pero no necesariamente representa una regla técnica.

Por ejemplo:

> "Siempre debes utilizar rebase."

Eso no es una ley de Git.

La elección depende del contexto, del flujo de trabajo y de las reglas del equipo.

---

# 18. Mantén un cuaderno de aprendizaje

Puede ser físico o digital.

Para cada concepto anota:

```text
Concepto:
¿Qué es?
¿Para qué sirve?
¿Qué problema resuelve?
Comando relacionado:
¿Qué ocurre internamente?
Ejemplo:
Error que encontré:
Cómo lo solucioné:
```

Por ejemplo:

```text
Concepto: commit

¿Qué es?
Un registro de cambios en el historial.

¿Para qué sirve?
Para guardar un punto de la evolución del proyecto.

Comando:
git commit

Error:
Intenté hacer commit sin preparar cambios.

Aprendizaje:
Debo comprender el estado del staging area.
```

Con el tiempo tendrás tu propio manual de referencia.

---

# 19. Explica lo que aprendiste

Una de las mejores pruebas de comprensión consiste en explicar un concepto sin mirar las instrucciones.

Por ejemplo:

> "Explícame qué diferencia existe entre `git add` y `git commit`."

Una explicación sencilla podría ser:

> `git add` selecciona cambios para la siguiente fotografía del proyecto y los coloca en el área de preparación. `git commit` registra esos cambios preparados en el historial de Git.

Si puedes explicarlo con tus propias palabras, estás construyendo comprensión.

---

# 20. Utiliza el método de las preguntas

Para cada concepto intenta responder:

### ¿Qué?

¿Qué es?

### ¿Por qué?

¿Por qué existe?

### ¿Para qué?

¿Qué problema resuelve?

### ¿Dónde?

¿Dónde ocurre?

### ¿Cuándo?

¿Cuándo conviene utilizarlo?

### ¿Cómo?

¿Cómo funciona?

### ¿Qué pasa si...?

¿Qué ocurre si algo sale mal?

### ¿Qué alternativas existen?

¿Hay otra forma de resolverlo?

### ¿Qué riesgos existen?

¿Puede provocar pérdida de información?

Este conjunto de preguntas será especialmente importante en los niveles avanzados.

---

# 21. Aprende los comandos por familias

En lugar de memorizar comandos aleatoriamente, agrúpalos por función.

### Estado e inspección

```bash
git status
git log
git diff
git show
```

### Cambios

```bash
git add
git commit
```

### Ramas

```bash
git branch
git switch
git merge
```

### Remotos

```bash
git remote
git fetch
git pull
git push
```

### Recuperación

```bash
git restore
git revert
git reset
git reflog
```

### Avanzado

```bash
git rebase
git cherry-pick
git bisect
git worktree
```

Esto ayuda a construir un mapa mental.

---

# 22. No avances porque "terminaste de leer"

Avanza cuando puedas hacer algo.

Por ejemplo, no consideres terminado el tema de commits simplemente porque leíste el capítulo.

Comprueba si puedes:

* crear un repositorio;
* modificar un archivo;
* preparar el cambio;
* crear un commit;
* consultar el historial;
* explicar lo que ocurrió.

Si no puedes hacerlo, practica nuevamente.

---

# 23. La repetición debe ser progresiva

No necesitas repetir exactamente el mismo ejercicio veinte veces.

Haz variaciones.

Primera vez:

```text
un archivo
```

Segunda:

```text
dos archivos
```

Tercera:

```text
varios commits
```

Cuarta:

```text
dos ramas
```

Quinta:

```text
conflicto
```

Sexta:

```text
recuperación
```

La dificultad debe aumentar gradualmente.

---

# 24. Deja espacios entre sesiones

Aprender Git requiere tiempo.

Es preferible estudiar:

```text
30–60 minutos
```

con concentración y práctica que pasar varias horas leyendo sin experimentar.

Una sesión puede seguir esta estructura:

```text
10 min — repasar
20 min — estudiar
20 min — practicar
10 min — experimentar
```

No es una regla rígida.

Adáptala a tu disponibilidad.

---

# 25. Una sesión de estudio completa

Por ejemplo, si estás estudiando `git commit`:

### 1. Leer

Comprender qué es un commit.

### 2. Preparar

Crear un repositorio de práctica.

### 3. Experimentar

Crear un archivo.

### 4. Observar

Ejecutar:

```bash
git status
```

### 5. Preparar

Ejecutar:

```bash
git add archivo.txt
```

### 6. Observar nuevamente

```bash
git status
```

### 7. Registrar

```bash
git commit -m "Agregar archivo de prueba"
```

### 8. Consultar

```bash
git log
```

### 9. Explicar

Responder:

> ¿Qué ocurrió desde que creé el archivo hasta que hice el commit?

### 10. Repetir

Realizarlo nuevamente sin mirar las instrucciones.

Eso es estudiar.

---

# 26. Aprende de tus propios errores

Cuando cometas un error, registra:

```text
¿Qué intentaba hacer?

¿Qué comando ejecuté?

¿Qué esperaba que ocurriera?

¿Qué ocurrió realmente?

¿Por qué ocurrió?

¿Cómo lo solucioné?

¿Cómo puedo evitarlo?
```

Con el tiempo, tus errores se convierten en conocimiento.

---

# 27. Mantén los experimentos separados de proyectos importantes

Cuando estés aprendiendo comandos avanzados, no experimentes inicialmente sobre un proyecto de producción.

Utiliza:

```text
repositorio-laboratorio/
```

para probar:

```bash
git reset
git rebase
git cherry-pick
git merge
git revert
```

Una vez que comprendas el comportamiento, podrás aplicarlo en escenarios reales con mayor seguridad.

---

# 28. Especial atención a comandos peligrosos

Durante el curso aparecerán comandos que pueden modificar o eliminar información.

Por ejemplo:

```bash
git reset --hard
git clean
git push --force
git rebase
```

Antes de utilizar uno de ellos, debes comprender:

```text
Estado actual
      ↓
Comando
      ↓
Qué modifica
      ↓
Qué puede perderse
      ↓
Cómo recuperar
      ↓
Ejecutar
```

No conviertas comandos destructivos en recetas para copiar y pegar.

---

# 29. Aprende primero en local

Cuando estés aprendiendo conceptos nuevos, muchas veces es mejor trabajar primero con un repositorio local.

Por ejemplo:

```text
Computadora
    ↓
Git
    ↓
Repositorio local
```

Después añadiremos:

```text
Repositorio local
    ↓
GitHub
```

Esto permite aislar conceptos.

Primero comprendes Git.

Después comprendes Git + GitHub.

---

# 30. Después aprende a colaborar

Una vez que comprendas Git individualmente, comienza a trabajar con conceptos como:

```text
Branch
Pull Request
Code Review
Merge
Issues
Projects
```

Finalmente llegarás a:

```text
Equipo
   ↓
Workflow
   ↓
CI/CD
   ↓
Seguridad
   ↓
Automatización
```

La progresión importa porque cada nivel utiliza conceptos anteriores.

---

# 31. No tengas miedo de volver atrás

Si estás estudiando ramas y descubres que todavía no comprendes commits:

```text
Vuelve a commits.
```

Si estás estudiando Pull Requests y no comprendes ramas:

```text
Vuelve a ramas.
```

Si estás estudiando CI/CD y no comprendes GitHub Actions:

```text
Vuelve a GitHub Actions.
```

Aprender no es una línea perfectamente recta.

Puede ser:

```text
Avanzar
   ↓
Detectar una laguna
   ↓
Retroceder
   ↓
Comprender
   ↓
Volver a avanzar
```

Eso es normal.

---

# 32. Cómo medir tu progreso

Puedes utilizar cuatro niveles.

## Nivel 1 — Reconocer

> "He visto este concepto."

Todavía no es suficiente.

## Nivel 2 — Comprender

> "Puedo explicar qué es."

Ya existe comprensión conceptual.

## Nivel 3 — Aplicar

> "Puedo utilizarlo."

Ya existe habilidad práctica.

## Nivel 4 — Explicar y decidir

> "Puedo utilizarlo, explicar sus consecuencias y decidir cuándo conviene utilizarlo."

Este es el objetivo de los niveles avanzados.

---

# 33. Una matriz sencilla de aprendizaje

| Nivel        | Puedes...                   |
| ------------ | --------------------------- |
| Reconocer    | identificar el concepto     |
| Comprender   | explicarlo                  |
| Aplicar      | utilizarlo                  |
| Diagnosticar | encontrar errores           |
| Comparar     | evaluar alternativas        |
| Decidir      | seleccionar una estrategia  |
| Enseñar      | explicárselo a otra persona |

El objetivo profesional es llegar progresivamente a los últimos niveles.

---

# 34. Cómo estudiar si tienes poco tiempo

No necesitas estudiar durante horas todos los días.

Puedes dividir el aprendizaje:

```text
Lunes
Concepto

Martes
Ejemplo

Miércoles
Práctica

Jueves
Experimento

Viernes
Repaso
```

Incluso pequeñas sesiones constantes pueden ser útiles si realmente practicas.

---

# 35. Cómo estudiar si tienes mucho tiempo

Si tienes varias horas disponibles, evita pasar todo el tiempo leyendo.

Una sesión extensa puede dividirse:

```text
20 % teoría
50 % práctica
20 % experimentación
10 % documentación y repaso
```

La proporción puede variar.

La idea es que la práctica tenga un peso importante.

---

# 36. Cómo utilizar este repositorio como manual de consulta

No tienes que leerlo siempre de principio a fin.

Una vez que tengas experiencia, puedes utilizarlo como referencia.

Por ejemplo:

> "¿Cuál es la diferencia entre revert y reset?"

Consulta:

```text
11-git-deshacer-y-recuperar/
```

> "¿Cómo funcionan las ramas?"

Consulta:

```text
08-git-ramas/
```

> "¿Cómo funcionan los Pull Requests?"

Consulta:

```text
15-pull-requests/
```

> "¿Cómo configuro CI?"

Consulta:

```text
19-github-actions/
```

Así el repositorio se convierte en:

```text
Curso
+
Manual
+
Referencia
+
Laboratorio
```

---

# 37. No necesitas memorizar todo

Incluso profesionales con años de experiencia consultan documentación.

Es normal olvidar:

```bash
git bisect
git worktree
git reflog
```

Lo importante es saber:

> "Existe una herramienta para este problema y sé dónde consultar cómo utilizarla."

Un buen profesional no necesariamente memoriza todo.

Sabe **encontrar, verificar y aplicar información técnica correctamente**.

---

# 38. Cómo saber si estás preparado para avanzar

Antes de pasar al siguiente tema, intenta responder:

```text
□ ¿Sé explicar el concepto?
□ ¿Puedo realizar el ejemplo?
□ ¿Puedo repetirlo sin mirar?
□ ¿Puedo modificar el ejemplo?
□ ¿Sé interpretar el resultado?
□ ¿Sé identificar un error básico?
□ ¿Sé explicar qué ocurrió?
□ ¿Sé dónde consultar si olvido algo?
```

Si puedes marcar la mayoría, continúa.

Si no, practica un poco más.

---

# 39. Tu laboratorio debe ser seguro

Durante el aprendizaje:

* utiliza repositorios de práctica;
* no guardes secretos reales;
* no uses contraseñas reales;
* no experimentes con datos sensibles;
* no ejecutes comandos destructivos sobre proyectos importantes;
* realiza copias cuando sea necesario;
* verifica el repositorio antes de operaciones peligrosas.

Especialmente:

> **Nunca utilices un proyecto de producción como laboratorio de aprendizaje.**

---

# 40. La regla de las tres comprobaciones

Antes de ejecutar una operación importante, comprueba:

### 1. ¿Dónde estoy?

```bash
pwd
```

o utiliza la herramienta equivalente de tu sistema.

### 2. ¿Qué estado tiene Git?

```bash
git status
```

### 3. ¿Qué estoy a punto de hacer?

Comprende el comando antes de ejecutarlo.

Estas tres comprobaciones pueden evitar muchos errores.

---

# 41. Después de una operación importante, verifica

No asumas que el comando produjo exactamente lo que esperabas.

Después de una operación importante:

```bash
git status
```

y, cuando corresponda:

```bash
git log
```

o:

```bash
git diff
```

La secuencia profesional es:

```text
Ejecutar
   ↓
Observar
   ↓
Verificar
   ↓
Continuar
```

---

# 42. Aprende a trabajar con estados

Una parte importante de Git consiste en comprender estados.

Por ejemplo:

```text
Archivo modificado
       ↓
Staging
       ↓
Commit
       ↓
Repositorio local
       ↓
Push
       ↓
Repositorio remoto
```

No pienses únicamente en comandos.

Piensa:

> **¿En qué estado se encuentra mi cambio?**

Esta pregunta será fundamental cuando lleguemos a problemas reales.

---

# 43. Cuando algo falle, detente

Una reacción común ante un error es ejecutar más comandos rápidamente.

Eso puede empeorar el problema.

En cambio:

```text
ERROR
  ↓
DETENERSE
  ↓
LEER
  ↓
COMPRENDER
  ↓
VERIFICAR ESTADO
  ↓
ANALIZAR OPCIONES
  ↓
ACTUAR
```

Esta es una habilidad profesional.

---

# 44. La documentación de este repositorio tiene un propósito

Cada capítulo está diseñado para responder progresivamente:

```text
¿Qué es?
   ↓
¿Por qué existe?
   ↓
¿Qué problema resuelve?
   ↓
¿Cómo se utiliza?
   ↓
¿Qué ocurre internamente?
   ↓
¿Qué puede salir mal?
   ↓
¿Cómo se recupera?
   ↓
¿Cuándo conviene utilizarlo?
```

No todos los temas tendrán la misma profundidad.

Los conceptos básicos se explicarán de forma sencilla.

Los conceptos avanzados aumentarán progresivamente en profundidad técnica.

---

# 45. De principiante a profesional

La evolución esperada es:

### Principiante

> "No sé qué es Git."

### Básico

> "Sé crear commits."

### Intermedio

> "Sé trabajar con ramas y repositorios remotos."

### Avanzado

> "Sé resolver conflictos y recuperar errores."

### Profesional

> "Sé trabajar mediante Pull Requests, revisión, automatización y seguridad."

### Senior

> "Sé diseñar y mejorar estrategias de trabajo basadas en Git para equipos y proyectos."

Ese es el recorrido.

---

# 46. La práctica final de cada tema

Cuando termines un tema importante, intenta hacer tres cosas sin consultar el material.

### 1. Explicarlo

Explícalo con tus propias palabras.

### 2. Utilizarlo

Haz un ejercicio desde cero.

### 3. Romperlo

Crea una situación controlada donde pueda aparecer un error.

Después intenta recuperarte.

Si puedes hacer esas tres cosas, el concepto está mucho más consolidado.

---

# 47. El objetivo no es terminar rápido

No hay ninguna competición.

Terminar 20 capítulos sin comprenderlos vale menos que comprender profundamente cinco.

El objetivo es construir una base sólida.

```text
Velocidad
   ≠
Aprendizaje
```

La velocidad llegará después con la práctica.

---

# 48. Cómo estudiar con otras personas

También puedes aprender en grupo.

Una sesión puede consistir en:

```text
Persona A
explica el concepto

Persona B
realiza el ejercicio

Persona C
intenta provocar un error

Todos
analizan el resultado
```

Enseñar a otra persona suele revelar rápidamente qué partes todavía no comprendemos.

---

# 49. Cómo utilizar los proyectos prácticos

Cuando llegues a `27-proyectos-practicos/`, no intentes simplemente copiar la solución.

Primero:

1. lee los requisitos;
2. intenta resolverlos;
3. crea el repositorio;
4. trabaja con Git;
5. registra commits;
6. crea ramas;
7. documenta;
8. prueba;
9. revisa;
10. compara tu solución con las recomendaciones.

El proyecto debe ser una oportunidad para demostrar comprensión.

---

# 50. El aprendizaje continúa después del repositorio

Git y GitHub continúan evolucionando.

Por eso este repositorio debe considerarse una base de conocimiento que puede actualizarse.

Cuando una herramienta cambie:

* verifica la documentación actual;
* comprueba los comandos;
* revisa las interfaces;
* actualiza los ejemplos;
* documenta los cambios.

Aprender una tecnología también significa aprender a **mantener actualizado el conocimiento técnico**.

---

# 51. Método resumido

Si quieres recordar solamente un método, utiliza este:

```text
1. Lee
   ↓
2. Comprende
   ↓
3. Haz el ejemplo
   ↓
4. Repite sin mirar
   ↓
5. Modifica el ejemplo
   ↓
6. Experimenta
   ↓
7. Provoca un error controlado
   ↓
8. Diagnostica
   ↓
9. Corrige
   ↓
10. Explica
   ↓
11. Aplica en un proyecto
```

---

# 52. La regla más importante

Si solamente recuerdas una cosa de este capítulo, recuerda esto:

> **No estudies Git para recordar comandos. Estudia Git para comprender estados, cambios, historial, colaboración y decisiones técnicas.**

Los comandos son herramientas.

El conocimiento está en comprender **cuándo, por qué y cómo utilizarlas**.

---

# 53. Comenzamos

Ahora que sabes cómo estudiar, puedes comenzar el recorrido.

Si necesitas conocimientos básicos de informática:

```text
01-computacion-desde-cero/
```

Si ya utilizas una computadora con soltura:

```text
02-github-desde-cero/
```

Si ya conoces Git y GitHub, utiliza el mapa de aprendizaje de `EMPIEZA-AQUI.md` para encontrar el punto adecuado.

No tengas prisa.

Lee.

Practica.

Experimenta.

Equivócate de forma segura.

Investiga.

Corrige.

Y vuelve a intentarlo.

> **El objetivo no es que Git deje de parecer complicado. El objetivo es que aprendas a comprenderlo.**
