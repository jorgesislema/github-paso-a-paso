# Cómo leer los ejemplos

## Introducción

En este repositorio encontrarás muchos ejemplos.

Habrá:

* comandos de Git;
* capturas de pantalla;
* estructuras de carpetas;
* diagramas;
* fragmentos de código;
* ejemplos de commits;
* ramas;
* mensajes de error;
* flujos de trabajo;
* configuraciones;
* ejemplos profesionales.

Pero existe una diferencia importante entre **ver un ejemplo** y **comprender un ejemplo**.

Puedes copiar:

```bash
git add .
git commit -m "Cambios"
git push
```

y conseguir que funcione.

Sin embargo, eso no significa necesariamente que hayas aprendido qué está ocurriendo.

El objetivo de este capítulo es enseñarte a leer los ejemplos de manera activa.

La idea fundamental es:

> **No copies un ejemplo para terminarlo. Estúdialo para entender por qué funciona.**

---

# 1. Un ejemplo no es una receta universal

Uno de los errores más comunes al aprender tecnología es pensar:

> “Si aparece este comando en el ejemplo, debo utilizarlo exactamente igual.”

No necesariamente.

Un ejemplo muestra una situación concreta.

Por ejemplo:

```bash
git add README.md
```

significa que se está preparando específicamente `README.md`.

Pero eso no significa que siempre debas ejecutar:

```bash
git add README.md
```

Quizá en otra situación quieras preparar:

```bash
git add archivo.txt
```

o varios archivos:

```bash
git add archivo1.txt archivo2.txt
```

o, dependiendo de tu objetivo:

```bash
git add .
```

El ejemplo enseña un concepto.

Tú debes aprender a reconocer **cuándo ese concepto se aplica a tu situación**.

---

# 2. Primero entiende qué problema resuelve

Antes de estudiar un comando, pregunta:

> **¿Qué problema intenta resolver este ejemplo?**

Por ejemplo:

```bash
git status
```

No lo estudies solamente como:

> “Este es un comando que tengo que memorizar.”

Piensa:

> “Necesito saber cuál es el estado actual de mi repositorio.”

Entonces:

```text
Problema
   ↓
Necesito conocer el estado
   ↓
git status
   ↓
Información del repositorio
```

Esto permite recordar el comando por su propósito.

---

# 3. Lee los ejemplos en varias capas

Un ejemplo técnico puede analizarse en diferentes niveles.

Una buena estrategia es leerlo así:

```text
Nivel 1 → ¿Qué veo?
Nivel 2 → ¿Qué significa?
Nivel 3 → ¿Por qué se hace?
Nivel 4 → ¿Qué ocurre internamente?
Nivel 5 → ¿Cuándo se utiliza?
Nivel 6 → ¿Cuándo NO debería utilizarse?
Nivel 7 → ¿Qué alternativas existen?
Nivel 8 → ¿Qué riesgos tiene?
```

No necesitas estudiar todos los niveles desde el primer día.

La profundidad aumenta conforme avanzas.

---

# 4. Primera lectura: observa

Supongamos que encuentras:

```bash
git add archivo.txt
git commit -m "Agregar archivo"
git push origin main
```

En la primera lectura simplemente identifica:

* hay tres comandos;
* primero aparece `git add`;
* después `git commit`;
* finalmente `git push`.

No intentes memorizar todavía.

Solo observa.

---

# 5. Segunda lectura: identifica la función

Ahora pregunta:

### ¿Qué hace `git add`?

Prepara cambios para el siguiente commit.

### ¿Qué hace `git commit`?

Crea un commit con los cambios preparados.

### ¿Qué hace `git push`?

Envía commits locales hacia un repositorio remoto.

Ahora el ejemplo empieza a tener sentido:

```text
Cambios
   ↓
git add
   ↓
Staging area
   ↓
git commit
   ↓
Repositorio local
   ↓
git push
   ↓
Repositorio remoto
```

Ya no estás memorizando tres comandos aislados.

Estás observando un flujo.

---

# 6. Tercera lectura: pregunta por qué

Ahora pregunta:

> ¿Por qué `git add` aparece antes de `git commit`?

Porque Git utiliza un área de preparación, conocida como **staging area** o **index**.

Entonces:

```text
Working directory
       ↓
    git add
       ↓
Staging area
       ↓
   git commit
       ↓
Local repository
```

Este análisis es mucho más importante que memorizar la secuencia.

---

# 7. Cuarta lectura: piensa qué ocurriría si eliminas un paso

Supongamos que tienes:

```bash
git add archivo.txt
git commit -m "Agregar archivo"
```

Pregunta:

> ¿Qué ocurriría si no hago `git add`?

La respuesta depende del estado de los archivos y de qué quieras incluir en el commit.

La pregunta importante es:

> **¿Qué información necesita `git commit` para crear el commit?**

Esta forma de estudiar obliga a comprender el funcionamiento de Git.

---

# 8. Quinta lectura: modifica el ejemplo

Una de las mejores maneras de aprender un ejemplo es cambiarlo.

Si encuentras:

```bash
git add README.md
```

prueba mentalmente:

```bash
git add notas.md
```

Después:

```bash
git add README.md notas.md
```

Pregúntate:

> ¿Qué diferencia existe?

Después experimenta en un repositorio de práctica.

La modificación deliberada transforma un ejemplo estático en un ejercicio.

---

# 9. El ejemplo mínimo

Los ejemplos de este repositorio intentarán ser pequeños cuando el objetivo sea explicar un concepto.

Por ejemplo:

```text
proyecto/
└── archivo.txt
```

es más fácil de estudiar que:

```text
empresa/
├── backend/
├── frontend/
├── infraestructura/
├── documentación/
├── tests/
├── scripts/
├── configuración/
├── servicios/
└── ...
```

Cuando estás aprendiendo un concepto, elimina todo lo que no sea necesario.

Después podrás estudiar situaciones más complejas.

---

# 10. Aprende a distinguir lo esencial de lo accidental

Supongamos que un ejemplo muestra:

```bash
git commit -m "Agregar README"
```

Lo esencial es:

```text
git commit
```

y que `-m` permite proporcionar el mensaje del commit.

El texto:

```text
"Agregar README"
```

es específico del ejemplo.

Podrías utilizar:

```bash
git commit -m "Crear documentación inicial"
```

Por eso debes distinguir:

```text
Concepto
   ↓
git commit -m
```

de:

```text
Dato específico del ejemplo
   ↓
"Agregar README"
```

---

# 11. Las partes que cambian suelen tener una función

Observa:

```bash
git clone https://github.com/usuario/proyecto.git
```

No memorices esa dirección como si fuera universal.

Identifica las partes:

```text
git clone
    ↓
comando

https://github.com/usuario/proyecto.git
    ↓
ubicación del repositorio
```

Otro ejemplo:

```bash
git clone https://github.com/otra-persona/otro-proyecto.git
```

El comando es el mismo.

Lo que cambia es el repositorio.

---

# 12. Aprende a identificar marcadores

En documentación técnica puedes encontrar ejemplos como:

```bash
git clone <URL-DEL-REPOSITORIO>
```

Los símbolos:

```text
<URL-DEL-REPOSITORIO>
```

indican que debes sustituir ese valor.

Por ejemplo:

```bash
git clone https://github.com/usuario/proyecto.git
```

Esto es muy diferente de copiar literalmente:

```bash
git clone <URL-DEL-REPOSITORIO>
```

Debes aprender a reconocer los valores que son marcadores.

---

# 13. No todos los textos entre corchetes significan lo mismo

En documentación puedes encontrar:

```text
[opcional]
```

```text
<valor>
```

```text
{nombre}
```

```text
NOMBRE_DE_USUARIO
```

Su significado depende del contexto y de la documentación.

Por eso no debes asumir automáticamente que puedes copiar esos símbolos.

Primero identifica qué representa cada elemento.

---

# 14. Lee los comentarios de los ejemplos

Los comentarios suelen explicar partes importantes.

Por ejemplo:

```bash
# Mostrar el estado del repositorio
git status

# Ver los cambios
git diff
```

Los comentarios no son comandos.

El primer texto:

```text
# Mostrar el estado del repositorio
```

explica el propósito.

El segundo:

```text
git status
```

es la instrucción que debes ejecutar.

Aprender a distinguir explicación y comando evita errores.

---

# 15. No ejecutes todo el bloque automáticamente

Supongamos que encuentras:

```bash
git status
git add .
git commit -m "Cambios"
git push
```

No significa necesariamente:

> “Copia todo y ejecútalo.”

Primero pregunta:

1. ¿En qué directorio estoy?
2. ¿Es realmente un repositorio Git?
3. ¿Qué cambios tengo?
4. ¿Quiero incluir todos los archivos?
5. ¿El commit está correctamente definido?
6. ¿Existe un remoto configurado?
7. ¿Tengo autorización para hacer `push`?
8. ¿Estoy en la rama correcta?

Leer antes de ejecutar es una habilidad fundamental.

---

# 16. Un ejemplo puede asumir condiciones previas

Muchos ejemplos funcionan porque existe una situación previa.

Por ejemplo:

```bash
git push
```

puede asumir que:

* estás dentro de un repositorio;
* tienes una rama;
* existe un remoto;
* existe una relación de seguimiento adecuada;
* tienes autenticación;
* existen commits para enviar.

Si copias solamente el último comando, quizá no funcione.

Por eso pregunta:

> **¿Qué tuvo que ocurrir antes para que este ejemplo funcionara?**

---

# 17. Busca las condiciones iniciales

Antes de ejecutar un ejemplo, identifica:

```text
¿Existe el repositorio?
¿Estoy en el directorio correcto?
¿Git está instalado?
¿Estoy en la rama correcta?
¿Hay cambios?
¿Hay commits?
¿Existe un remoto?
¿Tengo permisos?
```

Esto se puede representar así:

```text
Condiciones iniciales
        ↓
Comando
        ↓
Resultado esperado
```

Si las condiciones iniciales no coinciden, el resultado puede ser diferente.

---

# 18. Ejemplo: crear un commit

Supongamos:

```bash
git add archivo.txt
git commit -m "Agregar archivo"
```

Antes del ejemplo probablemente debe existir:

```text
archivo.txt
```

y debe haber un repositorio Git.

El flujo completo sería:

```text
Crear archivo
     ↓
Repositorio Git
     ↓
Modificar archivo
     ↓
git status
     ↓
git add
     ↓
git commit
```

El ejemplo pequeño representa solamente una parte del proceso.

---

# 19. Pregunta siempre “¿qué debería observar?”

Un buen ejemplo debería permitirte comprobar si funcionó.

Por ejemplo:

```bash
git commit -m "Agregar archivo"
```

Después puedes observar:

```bash
git status
```

o:

```bash
git log --oneline
```

El aprendizaje mejora cuando puedes comparar:

```text
Antes
  ↓
Acción
  ↓
Después
```

---

# 20. La estructura antes → acción → después

Esta es una de las formas más importantes de leer ejemplos.

Por ejemplo:

```text
ANTES

archivo.txt modificado
        ↓
      git add
        ↓
DESPUÉS

archivo.txt preparado
```

Después:

```text
ANTES

cambio en staging
        ↓
      git commit
        ↓
DESPUÉS

nuevo commit
```

Después:

```text
ANTES

commit local
        ↓
      git push
        ↓
DESPUÉS

commit enviado al remoto
```

Esta forma de pensar permite comprender el flujo.

---

# 21. Aprende a leer diagramas

Los diagramas también son ejemplos.

Por ejemplo:

```text
Working Directory
       │
       │ git add
       ▼
Staging Area
       │
       │ git commit
       ▼
Local Repository
       │
       │ git push
       ▼
Remote Repository
```

No debes leerlo solamente como una imagen.

Interpétalo:

> “Un cambio comienza en mi directorio de trabajo, pasa al área de preparación, después se registra en un commit local y finalmente puede enviarse al repositorio remoto.”

Eso es comprensión.

---

# 22. Las flechas tienen significado

Cuando veas:

```text
A → B
```

pregunta:

> ¿Qué representa esta transición?

Puede representar:

* un comando;
* transferencia de datos;
* cambio de estado;
* dependencia;
* flujo de trabajo;
* relación conceptual.

Por ejemplo:

```text
git add
```

puede representar:

```text
Working Directory
       ↓
Staging Area
```

Mientras:

```text
git commit
```

representa:

```text
Staging Area
        ↓
Local Repository
```

### Diagramas y accesibilidad

Todos los diagramas de este repositorio son **texto plano** (bloques con `│`, `├──` y flechas `→`/`↓`) dentro de bloques de código. No son imágenes: por eso se leen en cualquier visor, se copian, se editan y — si usas un lector de pantalla — se leen línea a línea.

Para leer un diagrama sin apoyarte en la forma, sigue este orden:

1. **Lee la línea de título o la oración que lo introduce:** dice qué se está mostrando (el capítulo, además, lo acompaña casi siempre con un «mapa conceptual de este capítulo» que es el índice del diagrama).
2. **Enumera los bloques:** los nombres que aparecen en los recuadros o al inicio de cada rama son los conceptos; el orden vertical u horizontal es el orden de lectura.
3. **Lee las flechas de izquierda a derecha y de arriba a abajo:** cada flecha es una transición (un comando, un paso, una consecuencia). Pregunta siempre «¿qué orden o qué estado produce esta flecha?» — la flecha es el verbo del diagrama.
4. **Busca los marcadores:** `(1)`, `(2)` y los `───` suelen indicar etapas; léelos como una lista ordenada.

Y una regla si vas a contribuir: **todo diagrama nuevo debe llevar una línea de texto antes que lo resuma** («este diagrama muestra X: bloques A y B unidos por el comando C»). Así el diagrama sigue siendo legible aunque su forma no se vea.

---

# 23. Aprende a leer árboles de archivos

Puedes encontrar:

```text
mi-proyecto/
├── README.md
├── .gitignore
├── src/
│   └── main.py
└── tests/
    └── test_main.py
```

No necesitas memorizar la estructura.

Debes aprender a interpretarla.

La primera línea:

```text
mi-proyecto/
```

representa la carpeta principal.

Después:

```text
README.md
.gitignore
```

son archivos.

Y:

```text
src/
tests/
```

son carpetas.

Dentro de `src` existe:

```text
main.py
```

y dentro de `tests`:

```text
test_main.py
```

---

# 24. Los nombres de archivos también enseñan conceptos

Por ejemplo:

```text
README.md
```

te indica que existe documentación en Markdown.

```text
.gitignore
```

es un archivo de configuración de Git.

```text
.github/
```

es un directorio utilizado por GitHub para diferentes configuraciones y automatizaciones.

La estructura de un proyecto puede transmitir información incluso antes de leer el contenido.

---

# 25. Cómo leer ejemplos de comandos

Cuando veas:

```bash
git branch -d nueva-rama
```

separa las partes:

```text
git
 ↓
programa

branch
 ↓
subcomando

-d
 ↓
opción

nueva-rama
 ↓
argumento
```

Esto es mucho mejor que memorizar toda la línea como una sola unidad.

---

# 26. Comando, opción y argumento

Muchos comandos siguen una estructura aproximada:

```text
programa
   ↓
subcomando
   ↓
opciones
   ↓
argumentos
```

Por ejemplo:

```bash
git log --oneline --graph --all
```

Podemos identificar:

```text
git
 └── log
      ├── --oneline
      ├── --graph
      └── --all
```

Las opciones modifican cómo funciona la operación o cómo se muestra el resultado.

Los detalles exactos dependen del comando.

---

# 27. No memorices las opciones inmediatamente

No necesitas recordar:

```bash
git log --oneline --decorate --graph --all
```

desde el primer día.

Puedes consultarlo cuando sea necesario.

Lo importante inicialmente es saber:

> “Existe una forma de visualizar el historial de manera gráfica y resumida.”

Después podrás aprender las opciones.

---

# 28. Aprende a comparar dos ejemplos

Supongamos:

```bash
git pull
```

y:

```bash
git fetch
```

No estudies ambos como dos comandos aislados.

Pregunta:

> ¿Qué problema resuelve cada uno?

Después:

> ¿Qué cambia en mi repositorio?

Y:

> ¿Qué ocurre con mi rama actual?

Comparar ejemplos es una excelente forma de aprender diferencias conceptuales.

---

# 29. Los ejemplos pueden ser deliberadamente incompletos

A veces un ejemplo no muestra todo el proceso.

Esto no necesariamente es un error.

Puede ser que el objetivo sea explicar una operación específica.

Por ejemplo:

```bash
git merge feature-login
```

puede aparecer sin mostrar:

```bash
git switch main
```

porque el capítulo podría estar explicando exclusivamente qué hace `merge`.

Sin embargo, antes de ejecutarlo debes preguntarte:

> ¿En qué rama debo estar para que esta operación tenga sentido?

---

# 30. Lee los títulos y subtítulos

Los títulos proporcionan contexto.

Por ejemplo:

```text
## Crear una rama

git switch -c nueva-funcionalidad
```

El título indica el objetivo.

Después puedes interpretar el comando.

No leas únicamente el bloque de código.

Lee:

```text
Título
   ↓
Explicación
   ↓
Ejemplo
   ↓
Resultado
```

---

# 31. Lee la explicación antes del comando

Cuando estudies este repositorio, evita saltar directamente a los bloques de código.

Primero lee:

1. qué es;
2. para qué sirve;
3. cuándo se utiliza;
4. después observa el ejemplo.

Esto evita convertir la documentación en una lista de comandos para copiar.

---

# 32. Después del ejemplo, intenta explicarlo

Una técnica sencilla:

Después de leer:

```bash
git switch -c nueva-rama
```

cierra temporalmente la documentación y responde:

> ¿Qué hizo este comando?

Si puedes responder:

> “Creó una nueva rama y cambió a ella”

has comprendido el objetivo básico.

Después puedes profundizar.

---

# 33. Cambia una variable del ejemplo

Si el ejemplo dice:

```bash
git switch -c nueva-rama
```

prueba mentalmente:

```bash
git switch -c feature-login
```

Después:

```bash
git switch -c feature-documentacion
```

La estructura permanece.

Lo que cambia es el nombre de la rama.

Esto ayuda a separar:

```text
estructura del comando
```

de:

```text
datos específicos del ejemplo
```

---

# 34. Pregunta “¿qué pasaría si...?”

Una de las mejores técnicas para aprender es modificar mentalmente las condiciones.

Por ejemplo:

> ¿Qué pasa si la rama ya existe?

> ¿Qué pasa si tengo cambios sin commit?

> ¿Qué pasa si estoy en otra rama?

> ¿Qué pasa si el remoto no existe?

> ¿Qué pasa si no tengo permisos?

Estas preguntas transforman una explicación pasiva en razonamiento.

---

# 35. Los ejemplos de errores son especialmente importantes

Si el repositorio muestra:

```text
error: Your local changes would be overwritten...
```

no lo leas como:

> “Esto es un mensaje que debo evitar.”

Pregunta:

> ¿Qué condición provoca este mensaje?

Después:

> ¿Por qué Git evita realizar la operación?

Finalmente:

> ¿Qué opciones existen para resolverlo?

Los errores permiten comprender las reglas internas de Git.

---

# 36. Lee los ejemplos de forma progresiva

No todos los ejemplos tienen el mismo nivel.

Podemos clasificarlos aproximadamente así:

### Nivel 1 — Visual

```text
archivo → carpeta → repositorio
```

### Nivel 2 — Operación básica

```bash
git status
```

### Nivel 3 — Flujo

```bash
git add
git commit
git push
```

### Nivel 4 — Conceptual

```text
Working Directory
→ Staging Area
→ Repository
```

### Nivel 5 — Diagnóstico

```bash
git status
git diff
git log
```

### Nivel 6 — Profesional

```text
Issue
→ Branch
→ Commit
→ Pull Request
→ Review
→ CI
→ Merge
→ Release
```

No necesitas comprender todos los niveles inmediatamente.

El repositorio está diseñado para que profundices progresivamente.

---

# 37. Un ejemplo sencillo puede contener una idea avanzada

Por ejemplo:

```bash
git commit
```

parece muy sencillo.

Pero detrás existe una arquitectura mucho más compleja:

```text
Working Tree
      ↓
Index
      ↓
Commit
      ↓
Tree
      ↓
Blobs
      ↓
Parent Commit
      ↓
Commit Graph
```

Al principio solo necesitas entender:

> “El commit registra una versión del proyecto.”

Más adelante aprenderás cómo Git representa internamente esa información.

Esto es aprendizaje progresivo.

---

# 38. No intentes comprender todo internamente desde el primer día

Es posible profundizar mucho en Git.

Puedes estudiar:

* objetos;
* blobs;
* trees;
* commits;
* referencias;
* HEAD;
* índices;
* reflogs;
* packfiles;
* almacenamiento interno.

Pero si todavía no sabes crear un commit, comenzar por los internals puede dificultar el aprendizaje.

La progresión correcta es:

```text
Uso
 ↓
Comprensión
 ↓
Modelo mental
 ↓
Internals
 ↓
Optimización
 ↓
Diseño profesional
```

---

# 39. Cómo leer ejemplos de GitHub

En GitHub puedes encontrar:

* README;
* código;
* workflows;
* issues;
* Pull Requests;
* releases;
* configuraciones;
* documentación.

No todo debe leerse de la misma manera.

Por ejemplo:

```text
README
↓
¿Qué hace el proyecto?

Código
↓
¿Cómo está implementado?

.github/workflows
↓
¿Qué automatización existe?

Issues
↓
¿Qué problemas o tareas se están gestionando?

Pull Requests
↓
¿Cómo se modificó el proyecto?

Releases
↓
¿Qué versiones se publicaron?
```

Aprender a navegar un repositorio es una habilidad importante.

---

# 40. Aprende leyendo repositorios reales

Después de dominar los ejemplos básicos, puedes abrir repositorios públicos y observar:

```text
README.md
.gitignore
LICENSE
src/
tests/
.github/
```

Pregúntate:

* ¿cómo está organizado?
* ¿qué archivos son importantes?
* ¿cómo documentan el proyecto?
* ¿cómo nombran las ramas?
* ¿cómo describen los commits?
* ¿utilizan Pull Requests?
* ¿tienen automatización?
* ¿existen pruebas?
* ¿cómo publican versiones?

Esto te acerca progresivamente al trabajo real.

---

# 41. Cómo leer una captura de pantalla

Una captura de pantalla también es un ejemplo.

No la mires únicamente para reproducir los clics.

Pregúntate:

1. ¿Qué aplicación aparece?
2. ¿En qué sección estoy?
3. ¿Qué elemento está seleccionado?
4. ¿Qué acción se realizó?
5. ¿Qué cambió después?
6. ¿Qué información muestra?
7. ¿Qué parte es importante para el concepto?

La captura debe ayudarte a construir un modelo mental.

---

# 42. No dependas para siempre de las capturas

Las capturas son útiles para principiantes.

Pero progresivamente debes aprender a reconocer los conceptos aunque la interfaz cambie.

GitHub puede modificar:

* nombres de botones;
* ubicación de opciones;
* diseño;
* menús;
* apariencia.

Por eso:

> **Aprende el concepto, no solamente dónde estaba un botón.**

---

# 43. Cómo leer ejemplos de GitHub Desktop

Supongamos que aparece:

```text
Changes
    ↓
Commit to main
    ↓
Push origin
```

No lo memorices como una secuencia de botones.

Relaciona la interfaz con Git:

```text
Cambios
    ↓
Commit
    ↓
Push
```

La interfaz gráfica está ejecutando operaciones que también puedes realizar mediante Git.

Esto será importante cuando posteriormente estudies:

```text
GitHub Web
GitHub Desktop
Git CLI
```

---

# 44. El mismo concepto puede aparecer de varias formas

Por ejemplo, crear un commit puede hacerse mediante:

### Git

```bash
git add archivo.txt
git commit -m "Agregar archivo"
```

### GitHub Desktop

Mediante la interfaz gráfica.

### GitHub Web

Editando un archivo y realizando un commit desde el sitio.

Las interfaces son diferentes.

El concepto fundamental sigue siendo:

```text
Registrar una nueva versión en el historial
```

Por eso debes aprender primero el concepto y después las herramientas.

---

# 45. Aprende a traducir entre interfaz y concepto

Puedes construir esta relación:

```text
GitHub Desktop
      ↓
Commit
      ↓
Git commit
```

o:

```text
GitHub Desktop
      ↓
Push origin
      ↓
git push
```

Esto te permitirá cambiar de herramienta sin sentir que estás empezando desde cero.

---

# 46. Cómo leer un ejemplo profesional

Más adelante encontrarás un flujo como:

```text
Issue #42
   ↓
feature/login
   ↓
Cambios
   ↓
Tests
   ↓
Commit
   ↓
Push
   ↓
Pull Request
   ↓
Code Review
   ↓
CI
   ↓
Merge
   ↓
Release
```

No intentes memorizarlo.

Pregúntate:

* ¿qué problema representa la Issue?
* ¿por qué se crea una rama?
* ¿qué función tiene el commit?
* ¿por qué se hace una Pull Request?
* ¿qué comprueba CI?
* ¿qué significa merge?
* ¿qué relación existe entre merge y release?

Esto convierte un diagrama en conocimiento.

---

# 47. Cómo estudiar un ejemplo profesional por capas

Puedes dividirlo:

### Capa 1

¿Qué está ocurriendo?

### Capa 2

¿Qué herramienta participa?

### Capa 3

¿Qué estado cambia?

### Capa 4

¿Por qué existe ese paso?

### Capa 5

¿Qué podría salir mal?

### Capa 6

¿Cómo se controla el riesgo?

### Capa 7

¿Cómo se automatiza?

Esta metodología será especialmente útil cuando llegues a:

* Pull Requests;
* GitHub Actions;
* CI/CD;
* DevOps;
* DevSecOps;
* arquitectura de repositorios.

---

# 48. Los ejemplos no sustituyen la práctica

Leer:

```bash
git branch nueva-rama
```

no equivale a crear una rama.

Leer:

```bash
git merge nueva-rama
```

no equivale a resolver un conflicto.

Leer:

```bash
git revert HEAD
```

no equivale a comprender cuándo utilizar `revert`.

La lectura prepara la práctica.

La práctica confirma la comprensión.

---

# 49. El ciclo correcto para estudiar un ejemplo

Utiliza este proceso:

```text
1. Leer
   ↓
2. Identificar el objetivo
   ↓
3. Separar conceptos y datos
   ↓
4. Comprender las condiciones iniciales
   ↓
5. Predecir el resultado
   ↓
6. Ejecutar en un laboratorio
   ↓
7. Observar el resultado
   ↓
8. Comparar con la predicción
   ↓
9. Modificar el ejemplo
   ↓
10. Explicarlo con tus palabras
```

Este es uno de los métodos más efectivos para convertir documentación en conocimiento.

---

# 50. Ejercicio: desmonta un ejemplo

Toma este ejemplo:

```bash
git switch -c feature-documentacion
git add README.md
git commit -m "Mejorar documentación"
git push -u origin feature-documentacion
```

Ahora responde:

### Pregunta 1

¿Qué hace la primera línea?

### Pregunta 2

¿Qué debe existir antes?

### Pregunta 3

¿Qué significa `feature-documentacion`?

### Pregunta 4

¿Qué archivo se prepara?

### Pregunta 5

¿Qué registra el commit?

### Pregunta 6

¿Qué significa `origin`?

### Pregunta 7

¿Qué significa `-u`?

### Pregunta 8

¿Dónde termina el commit después del `push`?

### Pregunta 9

¿Qué podría hacer que el `push` falle?

### Pregunta 10

¿Qué cambiarías para utilizar otra rama?

No necesitas responderlas todas inmediatamente.

La finalidad es aprender a **desmontar un ejemplo**.

---

# 51. Ejercicio: cambia el ejemplo

Transforma:

```bash
git switch -c feature-documentacion
git add README.md
git commit -m "Mejorar documentación"
git push -u origin feature-documentacion
```

en un flujo para una nueva funcionalidad llamada:

```text
login
```

Podrías terminar con algo conceptualmente parecido a:

```bash
git switch -c feature-login
```

y después adaptar las demás operaciones.

Pero antes de ejecutarlo, explica qué representa cada parte.

---

# 52. Ejercicio: elimina una línea

Observa:

```bash
git add README.md
git commit -m "Mejorar documentación"
git push
```

Ahora elimina mentalmente:

```bash
git add README.md
```

Pregunta:

> ¿Qué cambiaría?

Después elimina:

```bash
git push
```

Pregunta:

> ¿Qué parte del flujo ya no ocurre?

Finalmente elimina:

```bash
git commit
```

Pregunta:

> ¿Puede `git push` enviar un cambio que todavía no está registrado en un commit?

Este ejercicio ayuda a comprender las relaciones entre las operaciones.

---

# 53. Ejercicio: predice antes de ejecutar

Crea:

```text
prueba.txt
```

Después:

```bash
git status
```

Antes de ejecutarlo, escribe qué crees que aparecerá.

Después ejecuta el comando.

Compara:

```text
Predicción
    vs.
Resultado real
```

Si tu predicción fue incorrecta, no significa que fracasaste.

Significa que descubriste una diferencia entre tu modelo mental y el comportamiento real.

Eso es aprendizaje.

---

# 54. Ejercicio: explica sin mirar

Después de estudiar un ejemplo, cierra el documento.

Intenta explicar:

```text
¿Qué hice?
¿Por qué lo hice?
¿Qué ocurrió?
¿Qué cambió?
¿Qué puedo comprobar?
```

Si puedes explicarlo, probablemente lo comprendiste.

Si solamente recuerdas:

```bash
git add ...
git commit ...
git push ...
```

pero no sabes por qué, todavía necesitas profundizar.

---

# 55. Errores comunes al leer ejemplos

## Error 1: copiar sin leer

```text
Copiar → pegar → ejecutar
```

### Problema

No desarrollas comprensión.

---

## Error 2: memorizar literalmente

Pensar:

> “El comando siempre debe utilizar exactamente este nombre.”

### Problema

No sabes adaptarlo.

---

## Error 3: ignorar las condiciones iniciales

Ejecutar un comando sin comprobar el estado del repositorio.

### Problema

El resultado puede ser diferente.

---

## Error 4: ignorar el resultado

Ejecutar un comando y continuar sin comprobar qué ocurrió.

### Problema

Puedes no detectar un error.

---

## Error 5: no modificar los ejemplos

### Problema

Puedes creer que entiendes algo porque solamente repetiste el caso original.

---

## Error 6: aprender solamente la interfaz

Recordar:

> “Tengo que pulsar este botón.”

pero no saber qué operación Git representa.

### Problema

Cuando la interfaz cambia, te desorientas.

---

## Error 7: aprender solamente el comando

Saber:

```bash
git rebase
```

pero no comprender:

* qué problema resuelve;
* qué cambia;
* qué riesgos existen;
* cuándo utilizarlo.

---

# 56. Cómo saber si un ejemplo realmente te enseñó algo

Después de estudiar un ejemplo, deberías poder hacer al menos algunas de estas cosas:

* explicarlo;
* modificarlo;
* reproducirlo;
* predecir su resultado;
* identificar sus condiciones iniciales;
* detectar sus riesgos;
* adaptarlo a otra situación;
* explicar por qué funciona;
* explicar qué ocurre si falla.

Si puedes hacerlas, el ejemplo se convirtió en conocimiento.

---

# 57. El objetivo no es memorizar este repositorio

No queremos que aprendas:

> “En el capítulo 8 aparece este comando.”

Queremos que puedas pensar:

> “Tengo este problema. Sé qué estado tiene Git. Sé qué operación necesito y sé dónde consultar los detalles.”

Esa diferencia es fundamental.

---

# 58. De copiar ejemplos a diseñar soluciones

La progresión educativa debería ser:

```text
Copiar
  ↓
Entender
  ↓
Repetir
  ↓
Modificar
  ↓
Experimentar
  ↓
Diagnosticar
  ↓
Comparar
  ↓
Elegir
  ↓
Diseñar
```

Al principio necesitarás ejemplos.

Más adelante podrás construir tus propios flujos.

---

# 59. Una regla para todo el repositorio

Cuando encuentres un ejemplo, recuerda estas siete preguntas:

```text
1. ¿Qué problema resuelve?
2. ¿Qué condiciones necesita?
3. ¿Qué hace cada parte?
4. ¿Qué debería ocurrir?
5. ¿Cómo puedo comprobarlo?
6. ¿Qué pasaría si cambio algo?
7. ¿Qué riesgos o alternativas existen?
```

Si respondes estas preguntas, el ejemplo deja de ser una receta y se convierte en una herramienta de aprendizaje.

---

# 60. Lo que debes recordar

Los ejemplos están aquí para ayudarte a construir un modelo mental.

No son comandos mágicos.

No son recetas universales.

No siempre contienen todo el contexto necesario para ejecutar una operación real.

Aprende a leerlos:

```text
Ejemplo
   ↓
Problema
   ↓
Condiciones
   ↓
Acción
   ↓
Resultado
   ↓
Explicación
   ↓
Experimentación
   ↓
Adaptación
```

Y recuerda:

> **Copiar un ejemplo puede hacer que algo funcione una vez. Comprenderlo te permite resolver problemas nuevos.**

---

## Próximo paso

Ya tienes una metodología básica para comenzar este recorrido:

```text
01 — ¿Qué vamos a aprender?
        ↓
02 — Cómo estudiar
        ↓
03 — No tener miedo a romper cosas
        ↓
04 — Cómo pedir ayuda
        ↓
05 — Cómo leer los ejemplos
```

El siguiente objetivo será llevar esta metodología a la práctica y aprender a **experimentar de forma sistemática**, utilizando pequeños ejercicios para convertir los conceptos de Git y GitHub en habilidades reales.
