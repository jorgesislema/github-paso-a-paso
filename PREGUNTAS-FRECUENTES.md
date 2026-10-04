# Preguntas frecuentes sobre Git y GitHub

## GitHub Paso a Paso

Este documento responde las preguntas que aparecen con mayor frecuencia durante el aprendizaje de Git y GitHub.

Está pensado para personas que empiezan desde cero, pero también incluye situaciones que aparecen en proyectos profesionales.

Si una pregunta no aparece aquí, puedes consultar el [Glosario](GLOSARIO.md) o continuar con el módulo correspondiente.

## Cómo está organizado este documento

Las preguntas se agrupan por etapa (principiantes → colaborativo → profesional). Cada entrada sigue el mismo orden: **pregunta** (encabezado), **respuesta directa** (primeras líneas) y **detalle o enlaces** al material del curso. Si vas a añadir preguntas nuevas, consulta [`CONTRIBUTING.md`](CONTRIBUTING.md) y mantén ese orden: la respuesta va antes que el detalle.

---

# 1. Preguntas para principiantes

## ¿Necesito saber programar para aprender GitHub?

No.

Puedes comenzar a aprender GitHub sin saber programar.

Git y GitHub se utilizan para trabajar con código, pero también pueden utilizarse para:

* documentación;
* archivos Markdown;
* apuntes;
* investigaciones;
* libros;
* datos;
* configuraciones;
* proyectos educativos;
* archivos de texto.

Aprender Git puede incluso ayudarte a desarrollar buenas prácticas antes de aprender programación.

---

## ¿Necesito saber usar la terminal?

No al principio.

Este repositorio comienza utilizando herramientas visuales y posteriormente introduce la terminal.

La progresión recomendada es:

```text
Interfaz web
     ↓
GitHub Desktop
     ↓
Terminal
     ↓
Git avanzado
     ↓
Automatización
```

La terminal se introduce progresivamente para que comprendas qué estás haciendo y no simplemente memorices comandos.

---

## ¿Tengo que memorizar todos los comandos de Git?

No.

Incluso desarrolladores experimentados consultan la documentación.

Lo importante es comprender:

```text
¿Qué problema quiero resolver?
        ↓
¿Qué herramienta necesito?
        ↓
¿Qué comando puedo utilizar?
```

Por ejemplo, no necesitas memorizar inmediatamente todos los parámetros de `git reset`.

Primero debes entender qué problema resuelve `reset` y qué riesgos tiene.

---

## ¿Git y GitHub son lo mismo?

No.

```text
Git
↓
Sistema de control de versiones

GitHub
↓
Plataforma que utiliza Git
+ colaboración
+ repositorios
+ Pull Requests
+ automatización
+ seguridad
```

Puedes utilizar Git sin GitHub.

---

## ¿Puedo usar Git sin Internet?

Sí.

Git es un sistema distribuido de control de versiones.

Muchas operaciones pueden realizarse localmente:

```text
git init
git add
git commit
git log
git diff
git branch
git merge
```

Internet es necesario cuando necesitas comunicarte con servicios remotos, por ejemplo al utilizar un repositorio alojado en GitHub.

---

## ¿GitHub es obligatorio para usar Git?

No.

Git puede utilizarse completamente de forma local.

GitHub es útil cuando necesitas:

* almacenamiento remoto;
* colaboración;
* Pull Requests;
* revisión de código;
* automatización;
* gestión de proyectos;
* publicación de proyectos.

---

# 2. Primeros pasos

## ¿Qué debo instalar primero?

Para comenzar con Git necesitas instalar Git en tu computadora.

Después puedes utilizar:

* terminal;
* editor de código;
* GitHub Desktop;
* otras herramientas gráficas compatibles con Git.

No necesitas instalar todo al mismo tiempo.

---

## ¿Debo comenzar directamente con comandos?

No necesariamente.

Para un principiante puede ser más sencillo comenzar comprendiendo:

1. qué es un archivo;
2. qué es una carpeta;
3. qué es un repositorio;
4. qué es Git;
5. qué es GitHub;
6. qué es un commit.

Después puedes aprender los comandos.

---

## ¿Qué es lo primero que debería practicar?

Una práctica sencilla:

```text
Crear una carpeta
        ↓
Crear un archivo
        ↓
Crear un repositorio Git
        ↓
Modificar el archivo
        ↓
Guardar el cambio
        ↓
Crear un commit
```

Después puedes conectar el repositorio con GitHub.

---

## ¿Qué significa `git init`?

`git init` inicializa un repositorio Git en una carpeta.

Ejemplo:

```bash
git init
```

Git crea la estructura interna necesaria para comenzar a controlar versiones.

---

## ¿Qué significa `git status`?

Muestra el estado actual del repositorio.

Por ejemplo, puede indicarte:

* qué archivos cambiaron;
* qué archivos no están siendo rastreados;
* qué cambios están preparados para commit;
* en qué rama estás.

Es uno de los comandos más importantes para principiantes.

---

# 3. Commits

## ¿Qué es realmente un commit?

Un commit es un registro de cambios dentro del historial de Git.

Puedes imaginarlo como una fotografía del estado que decidiste registrar.

```text
Proyecto
   ↓
Cambios
   ↓
git add
   ↓
git commit
   ↓
Punto registrado en el historial
```

---

## ¿Cada vez que modifico un archivo debo hacer commit?

No necesariamente.

Un commit debería representar un cambio lógico.

Por ejemplo:

```text
Agregar formulario de registro
```

puede ser un buen commit.

Mientras que:

```text
Cambiar botón
Agregar base de datos
Modificar login
Actualizar documentación
Cambiar configuración
```

todo mezclado en un único commit puede dificultar el historial.

---

## ¿Qué debe tener un buen mensaje de commit?

Debe describir claramente el cambio.

Ejemplos:

```text
Agregar validación del formulario
Corregir cálculo del total
Actualizar documentación de instalación
Agregar pruebas para autenticación
```

Evita mensajes demasiado vagos como:

```text
cambios
actualización
arreglos
cosas nuevas
final
final2
ahora si
```

---

## ¿Puedo cambiar un commit?

Sí, pero depende de si el commit ya fue compartido.

Git dispone de herramientas como:

```text
git commit --amend
git rebase
git reset
git revert
```

Cada una tiene consecuencias diferentes.

Nunca debes utilizar una herramienta destructiva sin comprender primero qué modifica.

---

# 4. Staging Area

## ¿Por qué existe `git add`?

Porque Git separa los cambios que tienes en tu directorio de trabajo de los cambios que quieres incluir en el próximo commit.

El flujo es:

```text
Archivo modificado
       ↓
git add
       ↓
Staging Area
       ↓
git commit
```

Esto permite seleccionar exactamente qué cambios quieres registrar.

---

## ¿Tengo que hacer `git add` siempre?

Si quieres incluir cambios en un commit, normalmente debes colocarlos en el área de preparación mediante `git add`, salvo que utilices mecanismos que automaticen parte del proceso.

Para aprender Git correctamente, conviene comprender primero la función de `git add`.

---

# 5. GitHub y repositorios remotos

## ¿Qué significa `git push`?

Envía commits desde tu repositorio local hacia un repositorio remoto.

```text
Computadora
     │
     │ git push
     ▼
GitHub
```

---

## ¿Qué significa `git pull`?

Obtiene cambios del repositorio remoto y los integra en tu rama local según la configuración utilizada.

```text
GitHub
  │
  │ git pull
  ▼
Computadora
```

---

## ¿Qué diferencia hay entre `pull` y `fetch`?

`fetch` obtiene información del remoto sin integrar automáticamente esos cambios en tu rama de trabajo.

```bash
git fetch
```

`pull` normalmente combina la obtención de cambios con una operación de integración.

```bash
git pull
```

Para trabajar profesionalmente es importante entender esta diferencia.

---

## ¿Qué es `origin`?

`origin` es el nombre que Git suele asignar al remoto principal cuando clonas un repositorio.

Por ejemplo:

```bash
git remote -v
```

puede mostrar un remoto llamado:

```text
origin
```

`origin` no es una dirección especial de Internet. Es simplemente un nombre utilizado para referirse a un remoto.

---

## ¿Qué ocurre si hago `git push` y alguien modificó el mismo proyecto?

Git puede rechazar tu push si el repositorio remoto contiene cambios que tu historial local todavía no tiene.

Puede aparecer un mensaje indicando que tu rama está detrás del remoto.

Una posible estrategia es:

```text
Obtener cambios
       ↓
Revisarlos
       ↓
Integrarlos
       ↓
Resolver conflictos si existen
       ↓
Volver a intentar push
```

No debes solucionar estos problemas ejecutando comandos al azar.

Primero debes entender qué estado tiene tu repositorio.

---

# 6. Ramas

## ¿Por qué existen las ramas?

Permiten trabajar en diferentes líneas de desarrollo sin mezclar inmediatamente todos los cambios.

Ejemplo:

```text
main
 │
 ├── nueva-funcionalidad
 │
 └── correccion-error
```

---

## ¿Es obligatorio utilizar ramas?

No para todos los proyectos.

En proyectos personales pequeños puedes trabajar directamente sobre `main`.

En equipos profesionales, las ramas suelen utilizarse para separar cambios y facilitar revisión, pruebas y colaboración.

La estrategia depende del proyecto.

---

## ¿Qué diferencia hay entre una rama y una copia de una carpeta?

Una rama no es simplemente una copia física independiente de todo el proyecto.

Es una referencia dentro del historial de Git que permite trabajar sobre una línea determinada de commits.

Comprender esto es importante para avanzar hacia Git avanzado.

---

# 7. Merge y rebase

## ¿Qué es un merge?

Merge combina historias.

Ejemplo:

```text
main
  \
   feature
```

Después del merge, los cambios de `feature` pueden incorporarse a `main`.

---

## ¿Qué es rebase?

Rebase cambia la base desde la que parte una secuencia de commits.

Puede producir un historial más lineal, pero también reescribe la historia de los commits trasladados.

Por eso debe utilizarse con cuidado sobre ramas compartidas.

---

## ¿Cuál debo utilizar: merge o rebase?

No existe una respuesta universal.

Depende de:

* política del equipo;
* estrategia de ramas;
* historial deseado;
* experiencia del equipo;
* si la rama es compartida;
* necesidad de conservar determinados commits de merge.

Una regla práctica importante:

> No reescribas públicamente una historia que otras personas ya están utilizando sin comprender las consecuencias.

---

# 8. Conflictos

## ¿Qué es un conflicto de Git?

Ocurre cuando Git no puede determinar automáticamente cómo combinar determinados cambios.

Ejemplo:

Dos personas modifican la misma parte de un archivo de maneras incompatibles.

Git puede mostrar:

```text
<<<<<<< HEAD
Versión A
=======
Versión B
>>>>>>> otra-rama
```

El desarrollador debe decidir qué contenido debe permanecer.

---

## ¿Un conflicto significa que Git está roto?

No.

Un conflicto significa que Git necesita información humana para determinar cómo integrar cambios incompatibles.

Los conflictos son una parte normal del trabajo colaborativo.

---

## ¿Debo tener miedo de los conflictos?

No.

Debes aprender a resolverlos correctamente.

Una buena práctica es:

```text
Leer el conflicto
      ↓
Entender ambas versiones
      ↓
Decidir el resultado correcto
      ↓
Editar el archivo
      ↓
Probar
      ↓
Registrar la resolución
```

---

# 9. Errores y recuperación

## ¿Qué hago si hice un commit equivocado?

Depende de la situación.

Primero debes determinar:

1. ¿El commit está solamente en mi computadora?
2. ¿Ya hice push?
3. ¿Otras personas tienen ese commit?
4. ¿Quiero conservar los cambios?
5. ¿Quiero eliminar los cambios?
6. ¿Necesito crear un commit que revierta el anterior?

Las respuestas determinan qué herramienta es adecuada.

---

## ¿Qué hago si hice `git reset --hard` por accidente?

No entres en pánico.

En muchos casos Git puede conservar referencias temporales que permiten recuperar estados anteriores.

Una herramienta importante es:

```bash
git reflog
```

Después se debe analizar cuidadosamente el historial antes de intentar recuperar el estado.

---

## ¿`git reset --hard` es peligroso?

Puede serlo.

Puede eliminar cambios del directorio de trabajo y modificar referencias.

No debe utilizarse como un comando genérico para "arreglar Git".

---

## ¿`git revert` es más seguro que `reset`?

En determinadas situaciones de colaboración, `revert` es preferible porque crea un nuevo commit que invierte los cambios sin reescribir el historial compartido.

Pero no significa que `revert` sea siempre la solución correcta.

El contexto importa.

---

## ¿Qué hago si borré un archivo accidentalmente?

Si el archivo estaba controlado por Git, existen diferentes formas de recuperarlo dependiendo de su estado.

Por ejemplo:

```bash
git restore archivo.txt
```

Pero antes debes determinar si:

* el archivo estaba modificado;
* estaba preparado para commit;
* ya estaba confirmado;
* fue eliminado en un commit.

---

# 10. GitHub Desktop

## ¿GitHub Desktop reemplaza a Git?

No.

GitHub Desktop es una interfaz gráfica que facilita operaciones de Git y GitHub.

Por debajo sigue trabajando con conceptos de Git.

---

## ¿Puedo aprender Git usando solamente GitHub Desktop?

Puedes aprender muchos conceptos utilizando una interfaz gráfica.

Sin embargo, para llegar a un nivel profesional es recomendable comprender también la terminal.

La interfaz gráfica ayuda a visualizar.

La terminal ayuda a comprender y automatizar.

Lo ideal es dominar ambos enfoques.

---

## ¿Qué debería utilizar primero: GitHub Desktop o terminal?

Para una persona que comienza desde cero, GitHub Desktop puede ser una transición más sencilla.

Posteriormente:

```text
GitHub Desktop
      ↓
Terminal
      ↓
Git avanzado
      ↓
Automatización
```

---

# 11. GitHub Web

## ¿Puedo trabajar con GitHub directamente desde el navegador?

Sí.

GitHub permite realizar numerosas operaciones desde la web.

Por ejemplo:

* crear repositorios;
* crear archivos;
* editar archivos;
* subir archivos;
* crear commits;
* revisar historial;
* crear issues;
* crear Pull Requests;
* revisar código.

Sin embargo, la interfaz web no sustituye todo lo que Git puede hacer localmente.

---

## ¿Puedo crear un proyecto completo solamente desde GitHub?

En algunos casos sí.

Para proyectos sencillos puedes realizar muchas operaciones desde el navegador.

Para proyectos de software reales normalmente necesitarás un entorno local de desarrollo.

---

# 12. Pull Requests

## ¿Un Pull Request es un comando de Git?

No.

Un Pull Request es una funcionalidad de plataformas como GitHub.

Está relacionado con Git, pero forma parte del flujo de colaboración de la plataforma.

---

## ¿Para qué sirve un Pull Request?

Permite proponer cambios para que otras personas puedan:

* revisar el código;
* comentar;
* ejecutar pruebas;
* solicitar modificaciones;
* aprobar;
* integrar los cambios.

---

## ¿Un Pull Request significa que el código ya está en producción?

No.

Un Pull Request representa una propuesta de integración.

Después pueden existir:

* revisiones;
* pruebas;
* aprobaciones;
* merge;
* build;
* deployment.

---

# 13. Seguridad

## ¿Puedo subir mi contraseña a GitHub?

No.

Nunca debes publicar contraseñas, tokens, claves privadas u otras credenciales.

---

## ¿Puedo subir una API key si el repositorio es privado?

No es una buena práctica.

Un repositorio privado no debe considerarse equivalente a un almacén seguro de secretos.

Las credenciales deben gestionarse mediante mecanismos apropiados para secretos.

---

## ¿Qué hago si publiqué accidentalmente una API key?

Actúa rápidamente.

En términos generales:

```text
1. Revocar la credencial
2. Generar una nueva
3. Revisar dónde fue expuesta
4. Limpiar el problema según corresponda
5. Revisar el historial
6. Analizar posibles usos indebidos
```

Eliminar el archivo del commit más reciente no necesariamente elimina el secreto de todo el historial.

---

## ¿`.gitignore` protege mis secretos?

No.

`.gitignore` evita que determinados archivos sean incluidos accidentalmente en Git.

No protege una credencial que ya fue registrada.

Por ejemplo:

```text
.env
```

en `.gitignore` puede evitar que un archivo `.env` nuevo sea detectado.

Pero si previamente hiciste:

```bash
git add .env
git commit
```

el secreto ya forma parte del historial y requiere una respuesta de seguridad apropiada.

---

# 14. GitHub Actions

## ¿Qué es GitHub Actions?

Es un sistema de automatización integrado en GitHub.

Puede ejecutar tareas automáticamente cuando ocurre un evento.

Ejemplo:

```text
Push
 ↓
GitHub Actions
 ↓
Instalar dependencias
 ↓
Ejecutar pruebas
 ↓
Analizar código
 ↓
Generar resultado
```

---

## ¿Necesito saber programación para usar GitHub Actions?

No para comprender sus conceptos básicos.

Sin embargo, para crear workflows profesionales necesitarás aprender:

* YAML;
* comandos;
* Git;
* pruebas;
* conceptos de CI/CD;
* seguridad.

---

## ¿GitHub Actions solamente sirve para ejecutar pruebas?

No.

Puede utilizarse para:

* pruebas;
* análisis;
* builds;
* empaquetado;
* publicación;
* despliegues;
* automatización;
* tareas administrativas.

---

# 15. CI/CD

## ¿Qué significa CI?

Continuous Integration.

La idea central es integrar cambios frecuentemente y comprobar automáticamente que el software continúa funcionando correctamente.

---

## ¿Qué significa CD?

Puede significar:

* Continuous Delivery;
* Continuous Deployment.

Aunque están relacionados, no significan exactamente lo mismo.

---

## ¿Necesito CI/CD para todos mis proyectos?

No.

Un proyecto educativo pequeño puede no necesitar una infraestructura compleja.

A medida que aumenta la complejidad, el número de desarrolladores o la frecuencia de cambios, la automatización puede aportar mayor valor.

---

# 16. DevOps

## ¿Git forma parte de DevOps?

Git no es sinónimo de DevOps.

Sin embargo, Git suele ser una pieza fundamental de muchos flujos DevOps porque permite versionar:

* código;
* configuración;
* infraestructura;
* automatizaciones;
* documentación.

---

## ¿DevOps significa solamente automatización?

No.

DevOps abarca aspectos técnicos y organizativos relacionados con el flujo entre desarrollo y operaciones.

Incluye conceptos como:

* colaboración;
* automatización;
* CI/CD;
* infraestructura;
* observabilidad;
* confiabilidad;
* entrega de software.

---

# 17. Preguntas sobre aprendizaje

## ¿Soy demasiado mayor para aprender Git?

No.

Git es una herramienta técnica que puede aprenderse progresivamente.

No necesitas aprenderla rápidamente.

La estrategia de este repositorio es:

```text
Concepto
   ↓
Ejemplo
   ↓
Práctica
   ↓
Error
   ↓
Corrección
   ↓
Comprensión
```

La experiencia profesional o de vida no es un impedimento para aprender una herramienta técnica.

---

## ¿Qué pasa si olvido un comando?

Es normal.

Incluso profesionales consultan comandos y documentación.

Lo importante es saber:

```text
qué quieres conseguir
```

y

```text
qué concepto necesitas aplicar
```

Después puedes consultar la sintaxis exacta.

---

## ¿Debo aprender todos los comandos de Git antes de hacer un proyecto?

No.

Es mejor aprender mientras construyes.

Un recorrido inicial puede ser:

```text
git init
git status
git add
git commit
git log
git diff
git branch
git switch
git merge
git clone
git pull
git push
```

Después puedes avanzar hacia herramientas más especializadas.

---

## ¿Por qué Git parece tan complicado al principio?

Porque Git no solamente contiene comandos.

También introduce conceptos nuevos:

* historial;
* commits;
* ramas;
* referencias;
* staging area;
* repositorios locales;
* repositorios remotos;
* merge;
* rebase.

Cuando estos conceptos se entienden, los comandos empiezan a tener sentido.

---

# 18. Preguntas sobre proyectos profesionales

## ¿Qué diferencia hay entre un repositorio personal y uno profesional?

La diferencia no está solamente en el tamaño.

Un repositorio profesional suele prestar mayor atención a:

* estructura;
* documentación;
* pruebas;
* seguridad;
* historial;
* revisiones;
* automatización;
* permisos;
* gobernanza;
* mantenimiento.

---

## ¿Un buen repositorio necesita un README?

En la mayoría de proyectos que otras personas deben entender o utilizar, un README bien construido es muy recomendable.

Puede responder rápidamente:

```text
¿Qué es?
¿Cómo se instala?
¿Cómo se utiliza?
¿Cómo se prueba?
¿Cómo se contribuye?
```

---

## ¿Debo subir todo mi proyecto a Git?

No necesariamente.

Debes decidir qué archivos pertenecen al proyecto y cuáles son:

* temporales;
* generados;
* secretos;
* dependencias instaladas;
* archivos específicos de una máquina;
* artefactos que pueden reconstruirse.

Aquí `.gitignore` desempeña un papel importante.

---

# 19. Preguntas sobre Git y programación

## ¿Git solamente sirve para programadores?

No.

Puede utilizarse para cualquier conjunto de archivos cuyo historial quieras controlar.

Sin embargo, es especialmente importante en desarrollo de software.

---

## ¿Git sirve para Python?

Sí.

Puede versionar proyectos Python y también utilizarse para automatizar:

* pruebas;
* análisis;
* empaquetado;
* despliegues.

---

## ¿Git sirve para ciencia de datos?

Sí.

Puede utilizarse para:

* código;
* notebooks;
* documentación;
* configuraciones;
* pipelines;
* experimentos reproducibles.

Los archivos de datos grandes requieren estrategias adicionales.

---

## ¿Git sirve para proyectos de inteligencia artificial?

Sí.

Puede versionar:

* código;
* prompts;
* configuraciones;
* pipelines;
* documentación;
* evaluaciones;
* archivos de configuración.

Los modelos grandes, datasets enormes y artefactos pesados pueden requerir herramientas especializadas de gestión de datos y modelos.

---

# 20. Preguntas sobre errores

## ¿Qué hago cuando Git muestra un error que no entiendo?

No ejecutes inmediatamente comandos encontrados al azar en Internet.

Primero:

1. Lee el mensaje completo.
2. Identifica el comando que ejecutaste.
3. Observa el estado del repositorio.
4. Ejecuta:

```bash
git status
```

5. Guarda el mensaje de error.
6. Busca la causa.
7. Comprueba la solución antes de aplicarla.

---

## ¿Por qué `git status` es tan importante?

Porque muestra una fotografía del estado actual de tu repositorio.

Cuando algo sale mal, suele ser uno de los primeros comandos que debes utilizar.

---

## ¿Qué información debo proporcionar cuando pido ayuda?

Una buena pregunta técnica debería incluir:

```text
1. ¿Qué estoy intentando hacer?
2. ¿Qué comando ejecuté?
3. ¿Qué esperaba que ocurriera?
4. ¿Qué ocurrió realmente?
5. ¿Cuál es el mensaje de error completo?
6. ¿Qué muestra git status?
```

Ejemplo:

```text
Estoy intentando subir mi rama a GitHub.

Ejecuté:
git push

Esperaba que se publicara la rama.

Obtengo:
[mensaje de error completo]

git status muestra:
[resultado]
```

Esto permite diagnosticar mucho mejor el problema.

---

# 21. Preguntas avanzadas

## ¿Qué significa reescribir el historial?

Significa modificar la estructura histórica de commits de manera que determinados commits puedan cambiar de identidad o dejar de formar parte de la historia visible de una rama.

Operaciones como:

```text
rebase
reset
rebase -i
```

pueden producir este efecto.

---

## ¿Por qué es peligroso reescribir una rama compartida?

Porque otras personas pueden tener referencias a los commits originales.

Si el historial cambia, sus repositorios locales pueden quedar desalineados con el remoto.

Por eso las operaciones de reescritura deben utilizarse con especial cuidado en ramas compartidas.

---

## ¿Qué es un repositorio monorepo?

Es un repositorio que contiene varios componentes o proyectos relacionados.

No significa simplemente "un repositorio grande".

Es una decisión arquitectónica que puede afectar:

* herramientas;
* permisos;
* CI/CD;
* estructura;
* dependencias;
* gobernanza.

---

## ¿Qué es DevSecOps?

Es un enfoque que integra seguridad dentro del ciclo de desarrollo y operaciones.

La idea es que la seguridad no dependa únicamente de una revisión final.

Puede incluir:

```text
Código
 ↓
Análisis
 ↓
Dependencias
 ↓
Pruebas
 ↓
Seguridad
 ↓
Build
 ↓
Deploy
```

---

# 22. Preguntas sobre el aprendizaje profesional

## ¿Cuándo puedo decir que sé Git?

No existe un único punto exacto.

Un nivel inicial implica poder:

* crear repositorios;
* realizar commits;
* consultar historial;
* trabajar con ramas;
* hacer push y pull.

Un nivel intermedio implica comprender:

* merge;
* conflictos;
* rebase;
* recuperación;
* repositorios remotos;
* Pull Requests;
* colaboración.

Un nivel profesional avanzado implica además comprender:

* estrategias de ramas;
* automatización;
* CI/CD;
* seguridad;
* gobernanza;
* recuperación;
* arquitectura;
* flujos de trabajo;
* resolución de incidentes.

---

## ¿Ser bueno en Git significa memorizar muchos comandos?

No.

El dominio profesional de Git consiste principalmente en comprender el modelo de datos y las consecuencias de las operaciones.

Por ejemplo, un desarrollador avanzado no solamente sabe que existe:

```bash
git reset
```

También entiende qué puede ocurrir con:

* `HEAD`;
* referencias;
* staging area;
* working tree;
* historial;
* commits;
* cambios locales.

---

## ¿Un desarrollador senior utiliza Git de manera diferente?

Puede utilizar las mismas herramientas básicas, pero normalmente presta mucha más atención a las consecuencias.

Por ejemplo:

Un principiante puede preguntar:

> ¿Qué comando uso?

Un desarrollador experimentado suele preguntar:

> ¿Qué estado tiene el repositorio, qué historia quiero conservar y qué impacto tendrá esta operación sobre el resto del equipo?

Ese cambio de mentalidad es una parte importante del aprendizaje profesional.

---

# 23. Preguntas sobre inteligencia artificial

## ¿Puedo utilizar inteligencia artificial para aprender Git?

Sí.

La IA puede ayudarte a:

* explicar comandos;
* interpretar errores;
* generar ejemplos;
* crear ejercicios;
* simular conflictos;
* explicar historiales;
* revisar workflows.

Pero debes verificar las instrucciones antes de ejecutar comandos potencialmente destructivos.

---

## ¿Debo copiar un comando de IA sin entenderlo?

No.

Especialmente si contiene:

```text
--force
--hard
reset
rebase
clean
push --force
```

Antes de ejecutarlo debes entender qué modifica y qué información podría perderse.

---

## ¿La IA puede solucionar cualquier problema de Git?

No.

Una IA puede proporcionar hipótesis y soluciones, pero necesita información suficiente sobre el estado real del repositorio.

Por eso es importante proporcionar:

```bash
git status
git log
git branch
```

u otra información relevante cuando sea necesario.

---

# 24. Las diez preguntas que debes aprender a responder

Antes de avanzar hacia Git avanzado, deberías poder explicar con tus propias palabras:

### 1. ¿Qué es Git?

Un sistema distribuido de control de versiones.

### 2. ¿Qué es GitHub?

Una plataforma que aloja repositorios Git y proporciona herramientas de colaboración y desarrollo.

### 3. ¿Qué es un repositorio?

Un espacio donde Git administra el contenido y su historial.

### 4. ¿Qué es un commit?

Un registro de cambios dentro del historial.

### 5. ¿Qué hace `git add`?

Coloca cambios seleccionados en la staging area.

### 6. ¿Qué hace `git commit`?

Registra los cambios preparados en el historial local.

### 7. ¿Qué hace `git push`?

Envía commits hacia un repositorio remoto.

### 8. ¿Qué hace `git pull`?

Obtiene cambios remotos y los integra según la configuración.

### 9. ¿Qué es una rama?

Una referencia que permite trabajar sobre una línea determinada del historial.

### 10. ¿Qué es un Pull Request?

Una propuesta de integración de cambios utilizada en plataformas de colaboración como GitHub.

---

# 25. La pregunta más importante

## ¿Qué debería hacer si no entiendo algo de Git?

No avanzar mecánicamente.

Detente.

Busca:

1. el concepto que no entiendes;
2. el problema que intenta resolver;
3. un ejemplo pequeño;
4. una práctica;
5. el resultado;
6. el error, si aparece.

Después vuelve al proyecto.

Git se aprende mucho mejor mediante la combinación:

```text
Comprender
    +
Practicar
    +
Equivocarse
    +
Investigar
    +
Corregir
    =
Aprender
```

No necesitas aprender Git de memoria.

Necesitas construir un modelo mental correcto.

---

# 26. Regla final

Cuando algo salga mal, recuerda:

```text
NO:
"Voy a probar comandos hasta que funcione."

SÍ:
"Voy a averiguar primero en qué estado se encuentra mi repositorio."
```

Y empieza normalmente por:

```bash
git status
```

Entender el estado antes de actuar es una de las habilidades más importantes que desarrollarás durante este recorrido.

---

## Continúa aprendiendo

Si acabas de comenzar:

```text
EMPIEZA-AQUI.md
        ↓
01-computacion-desde-cero/
        ↓
02-github-desde-cero/
        ↓
03-tu-cuenta-de-github/
```

Si ya conoces Git básico:

```text
06-git-desde-cero/
        ↓
07-como-funciona-git/
        ↓
08-git-ramas/
        ↓
09-git-remoto/
```

Si ya trabajas profesionalmente:

```text
15-pull-requests/
        ↓
16-trabajo-en-equipo/
        ↓
17-estrategias-de-git/
        ↓
18-github-profesional/
        ↓
19-github-actions/
        ↓
20-github-security/
        ↓
22-ci-cd/
        ↓
23-devops/
        ↓
24-devsecops/
        ↓
25-arquitectura-de-repositorios/
        ↓
26-nivel-senior/
```

El objetivo final no es simplemente saber utilizar Git.

Es comprender cómo utilizar el control de versiones, la colaboración, la automatización y la seguridad para construir y mantener software de manera profesional.
