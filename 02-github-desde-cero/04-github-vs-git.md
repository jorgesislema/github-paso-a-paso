# GitHub vs Git

## Introducción

En los capítulos anteriores aprendiste qué es GitHub y qué es un repositorio.

Viste que GitHub aloja repositorios y que estos repositorios permiten registrar cambios en archivos a lo largo del tiempo.

Ahora es el momento de aclarar una distinción fundamental que es crucial para comprender correctamente cómo trabajar con estas herramientas: **la diferencia entre Git y GitHub**.

Esta es una de las confusiones más comunes al comenzar a aprender sobre control de versiones y plataformas de colaboración, pero comprenderla correctamente te evitará muchos malentendidos futuros.

En este capítulo aprenderás:

* qué es Git y qué es GitHub desde el punto de vista técnico;
* cuál es la relación exacta entre ellos;
* por qué es importante no confundirlos;
* cómo se complementan entre sí;
* qué puedes hacer con cada uno por separado;
* ejemplos concretos que ilustren la diferencia;
* errores comunes que surgen al confundirlos;
* buenas prácticas para mantener clara esta distinción en tu mente.

No necesitas utilizar la terminal en este capítulo. Continuaremos enfocándonos en la comprensión conceptual y los ejemplos visuales.

---

## 1. Una primera explicación

Imagina que tienes una herramienta eléctrica potente, como un taladro.

El taladro en sí es el dispositivo que realiza el trabajo físico de hacer agujeros.

Pero para usar ese taladro de manera efectiva, podrías necesitar:

* una batería o fuente de energía;
* un conjunto de brocas de diferentes tamaños;
* un maletín para transportarlo y organizarlo;
* un manual de instrucciones;
* gafas de seguridad para proteger tus ojos.

El taladro es lo que hace el trabajo real, pero los accesorios y el contexto hacen que sea mucho más útil y seguro de usar.

Una analogía similar se aplica a Git y GitHub:

* **Git** es como el taladro: es la herramienta que realiza el trabajo real de control de versiones;
* **GitHub** es como el conjunto de accesorios, la fuente de energía y el manual: es la plataforma que hace que Git sea mucho más útil, seguro y fácil de usar en contextos modernos de trabajo en equipo.

Otra forma de verlo:

```text
Git
    │
    └── Motor que hace funcionar el control de versiones

GitHub
    │
    └── Chasis, ruedas, asiento y controles que hacen que sea práctico usar ese motor en un vehículo
```

Ambos son necesarios para obtener el máximo beneficio, pero cumplen funciones muy diferentes.

---

## 2. Definiciones técnicas

### 2.1. Qué es Git

**Git** es un sistema distribuido de control de versiones.

Es un programa de software que:

* registra cambios realizados en archivos y carpetas a lo largo del tiempo;
* permite recuperar versiones anteriores de esos archivos;
* facilita la combinación de cambios realizados por diferentes personas;
* incluye herramientas para gestionar ramas (líneas de trabajo independiente);
* proporciona mecanismos para detectar y resolver conflictos cuando los cambios entran en conflicto;
* funciona completamente sin conexión a Internet;
* fue creado originalmente por Linus Torvalds en 2005 para el desarrollo del noyau de Linux;
* es software libre y de código abierto.

Git se ocupa del **qué** y el **cómo** del control de versiones:
* ¿Qué cambios se han realizado?
* ¿Cómo se pueden recuperar, combinar y gestionar esos cambios?

### 2.2. Qué es GitHub

**GitHub** es una plataforma web que proporciona alojamiento para repositorios Git y herramientas adicionales para la colaboración, el desarrollo y la gestión de proyectos.

Utiliza Git como su tecnología subyacente de control de versiones, pero agrega capas de funcionalidad que hacen más fácil trabajar en equipo y gestionar el ciclo de vida del software.

GitHub se ocupa del **dónde**, el **cuándo** y el **por qué**:
* ¿Dónde se guarda el repositorio para que otros puedan acceder a él?
* ¿Cuándo se deben realizar ciertos procesos (pruebas, despliegues, revisiones)?
* ¿Por qué se tomaron ciertas decisiones y quién las aprobó?

### 2.3. Relación entre Git y GitHub

La relación entre Git y GitHub es de **dependencia y extensión**:

```text
GitHub
    │
    └── Utiliza a Git como su tecnología subyacente
        │
        │
        ▼
Git
    │
    └── Proporciona el sistema de control de versiones fundamental
```

Piensa en Git como el motor y GitHub como el vehículo completo:
* El motor (Git) puede funcionar por sí mismo y realizar su función esencial;
* El vehículo (GitHub) hace que sea mucho más práctico, seguro y cómodo usar ese motor en viajes largos y con pasajeros;
* Sin el motor, el vehículo no puede moverse;
* Sin el vehículo, el motor es mucho menos útil para transportar personas y cosas a largas distancias.

---

## 3. Qué puedes hacer con cada uno por separado

### 3.1. Qué puedes hacer con Git solo (sin GitHub)

Con solo Git instalado en tu computadora, puedes:

* crear repositorios locales con `git init`;
* seguir cambios en archivos con `git add` y `git commit`;
* ver el historial de cambios con `git log`;
* ver diferencias entre versiones con `git diff`;
* crear y cambiar entre ramas con `git branch` y `git checkout`;
* combinar cambios mediante merge y rebase;
* guardar cambios temporales con `git stash`;
* recuperar versiones anteriores con `git checkout` o `git reset`;
* explorar el historial para encontrar cuándo se introdujo un error con `git bisect`;
* crear etiquetas para marcar versiones importantes con `git tag`;
* trabajar completamente sin conexión a Internet;
* usar Git para cualquier tipo de proyecto: código, documentos, datos, configuraciones, etc.

En resumen: con solo Git, tienes todo el poder del control de versiones localmente, pero limitado a tu computadora personal.

### 3.2. Qué puedes hacer con GitHub solo (sin Git local)

Esto es un poco más complicado de imaginar, porque GitHub depende de Git para su funcionamiento principal. Sin embargo, puedes hacer ciertas cosas en GitHub sin tener Git instalado localmente:

* explorar repositorios públicos en la interfaz web;
* leer documentación y archivos en repositorios públicos;
* crear y gestionar tu perfil de usuario;
* crear organizaciones y equipos;
* gestionar repositorios mediante la interfaz web (crear, eliminar, cambiar configuración);
* crear y gestionar issues, pull requests y discussions;
* revisar código y dejar comentarios en la interfaz web;
* usar GitHub Pages para alojar sitios web estáticos;
* usar GitHub Actions para automatizar flujos de trabajo (aunque algunos pasos requieren Git localmente);
* recibir notificaciones sobre actividad en repositorios que sigues;
* buscar y descubrir proyectos interesantes;
* patrocinar proyectos de código abierto.

En resumen: con solo el acceso a GitHub web, puedes participar en muchas actividades de colaboración y gestión, pero no puedes crear nuevos commits ni modificar el historial de repositorios (para eso necesitas Git localmente).

---

## 4. Cómo trabajan juntos

Cuando usas Git y GitHub juntos, obtienes lo mejor de ambos worlds.

### 4.1. Flujo básico de trabajo

```text
Trabajo local con Git
    │
    ▼
Haces cambios y commits en tu repositorio local
    │
    ▼
Cuando estás listo para compartir:
    │
    ▼
Push: envías tus commits al repositorio remoto en GitHub
    │
    ▼
Tus compañeros pueden:
    │
    ▼
Pull: obtener tus cambios desde el remoto
    │
    ▼
Continuar trabajando desde el punto donde lo dejaste
```

### 4.2. Flujo de colaboración típico

```text
Tienes una idea o identificas un problema
    │
    ▼
Creas una rama para trabajar en esa característica o corrección
    │
    ▼
Haces tus cambios y haces commit(s) en tu rama local
    │
    ▼
Push: envías tu rama al repositorio remoto en GitHub
    │
    ▼
Abres un Pull Request proponiendo que se integren tus cambios
    │
    ▼
Tus compañeros revisan tu código, dejan comentarios y sugieren mejoras
    │
    ▼
Haces los cambios necesarios y actualizas tu Pull Request
    │
    ▼
Se aprueba el Pull Request y se mergea a la rama principal
    │
    ▼
Se elimina tu rama temporal (opcional)
    │
    ▼
Se celebra el logro y se continúa con el siguiente trabajo
```

### 4.3. Flujo de automatización

```text
Haces un commit y lo push al repositorio remoto
    │
    ▼
GitHub Actions se activa automáticamente
    │
    ▼
Ejecuta pruebas unitarias y de integración
    │
    ▼
Construye la aplicación o genera artefactos
    │
    ▼
Ejecuta análisis de seguridad y calidad de código
    │
    ▼
Despliega la aplicación a un entorno de prueba o producción
    │
    ▼
Envía notificaciones sobre el éxito o fracaso del proceso
    │
    ▼
El equipo obtiene retroalimentación inmediata sobre la calidad del cambio
```

---

## 5. Visualizando la relación

### 5.1. Analogía del automóvil (revisitado)

```text
GitHub (el vehículo completo)
    │
    ├── Motor (Git)                    ← El que hace el trabajo real
    ├── Ruedas (alojamiento y acceso)  ← Permite moverse y llegar a lugares
    ├── Dirección (colaboración)       ← Permite cambiar de dirección y trabajar en equipo
    ├── Combustible (gestión)          ← Proporciona la energía para seguir adelante
    ├── Seguridad (airbags, frenos)    ← Te protege en caso de problemas
    ├── Entretenimiento (publicación)  ← Hace el viaje más agradable y útil
    └── GPS (automatización)           ← Te ayuda a llegar a tu destino de manera eficiente
```

### 5.2. Analogía de la construcción

```text
Git (el cemento y el acero)
    │
    └── Materiales fundamentales que permiten construir estructuras fuertes y duraderas

GitHub (el equipo de construcción y las herramientas)
    │
    ├── Grúas y montacargas (alojamiento) ← Mueven materiales pesados a lugares altos
    ├── Herramientas eléctricas (colaboración) ← Permiten trabajar más rápido y precisamente
    ├── Planos y especificaciones (gestión) ← Guian el trabajo según el diseño acordado
    ├── Cascos y arneses (seguridad) ← Protegen a los trabajadores de peligros
    ├── Señalización en el sitio (publicación) ← Informa a otros qué se está construyendo y por qué
    ├── Cronómetro y métricas (automatización) ← Miden el progreso y sugieren mejoras
```

### 5.3. Flujo de información

```text
Tú (desarrollador)
    │
    │ escribes código y haces commits
    ▼
Git (local)
    │
    │ registra cambios en el historial local
    │
    │ gestionan ramas y combina cambios
    ▼
GitHub (remoto)
    │
    │ almacena el repositorio centralizado
    │
    │ facilita la colaboración mediante PRs e Issues
    │
    │ automatiza pruebas y despliegues
    │
    │ muestra el estado del proyecto a todos
    ▼
Equipo y stakeholders
    │
    │ ven el progreso y dan feedback
    │
    │ toman decisiones basadas en información visible
    ▼
Tú (desarrollador)
    │
    │ recibes feedback y continúas mejorando
    ▼
Ciclo continuo de mejora
```

---

## 6. Errores comunes

### Error 1: pensar que GitHub es un reemplazo de Git

GitHub no reemplaza a Git; lo complementa. Git puede funcionar perfectamente sin GitHub, pero GitHub no puede funcionar sin Git (o algún otro sistema de control de versiones subyacente).

### Error 2: creer que necesitas GitHub para usar Git

Muchos desarrolladores utilizan Git perfectamente sin ever tocar GitHub. Git funciona en servidores privados, en entornos corporativos con sus propios sistemas, o completamente localmente.

### Error 3: pensar que todos los comandos de Git funcionan de la misma manera en GitHub

Algunos comandos de Git (especialmente los que modifican el historial como `git reset --hard` o `git push --force`) tienen comportamientos diferentes o están restringidos en GitHub por razones de seguridad y colaboración.

### Error 4: creer que GitHub inventó el control de versiones

Git existed for years before GitHub was created. GitHub popularizó ciertas formas de usar Git, pero no creó el concepto de control de versiones.

### Error 5: usar los términos indistintamente sin comprender la diferencia

Decir "voy a subir esto a Git" cuando en realidad quieres subirlo a GitHub genera confusión. Sé preciso en tu lenguaje.

### Error 6: creer que GitHub controla completamente lo que puedes hacer con tu repositorio

Aunque GitHub impone algunas restricciones (por buenas razones), tú sigues teniendo control total sobre tu repositorio local y puedes decidir cómo interactuar con el remoto.

### Error 7: pensar que necesitas ser experto en Git para usar GitHub

Puedes comenzar a utilizar GitHub desde su interfaz web sin conocer ningún comando de Git. Aprender Git vendrá después, cuando necesites trabajar desde la terminal.

---

## 8. Buenas prácticas

* Mantén clara la distinción en tu mente: Git es el motor, GitHub es el vehículo;
* Usa el término "Git" cuando te refieras al sistema de control de versiones y sus operaciones;
* Usa el término "GitHub" cuando te refieras a la plataforma web y sus servicios de colaboración;
* Recuerda que puedes usar Git sin GitHub, pero no puedes usar GitHub sin Git (o algún otro sistema de control de versiones subyacente);
* Cuando trabajes en equipo, aprovecha lo mejor de ambos: el poder de Git para el control de versiones y las herramientas de GitHub para la colaboración;
* No asumas que todo lo que puedes hacer con Git localmente se puede hacer exactamente de la misma manera en GitHub;
* Aprender ambos te dará una ventaja significativa en el mundo profesional del desarrollo de software;
* La distinción no es solo académica: afecta cómo resuelves problemas, cómo colaboras y cómo gestionas tu trabajo.

---

## 9. Práctica guiada

En esta práctica explorarás la diferencia entre Git y GitHub en un escenario práctico.

### Objetivo
Comprender cuándo estás utilizando Git y cuándo estás utilizando GitHub en un flujo de trabajo típico.

### Paso 1: imagina un escenario de trabajo

Imagina que estás trabajando en un proyecto de programación sencillo y quieres compartir tu trabajo con un compañero para que lo revise.

### Paso 2: identifica cada paso

Para cada paso en el siguiente flujo de trabajo, identifica si estás utilizando Git, GitHub, o ambos:

1. **Inicializas un proyecto nuevo**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

2. **Haces algunos cambios en un archivo y los guardas**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

3. **Preparas los cambios para ser registrados (preparas un commit)**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

4. **Registras los cambios en tu historial local (haces un commit)**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

5. **Verizas el historial de cambios locales**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

6. **Envías tus cambios a tu compañero para que los revise**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

7. **Tu compañero revisa tus cambios y te da feedback**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

8. **Incorporas el feedback de tu compañero y haces más cambios**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

9. **Envías tus cambios actualizados a tu compañero**
   * ¿Qué herramientas estás utilizando?
   * ¿Estás usando Git, GitHub, o ambos?

10. **Tu compañero aprueba tus cambios y los integra en la versión principal**
    * ¿Qué herramientas estás utilizando?
    * ¿Estás usando Git, GitHub, o ambos?

### Resultado esperado
Deberías poder identificar en cada paso si estás utilizando Git (para el control de versiones local), GitHub (para la colaboración y el alojamiento remoto), o ambos trabajando juntos.

### Conclusión esperada
Deberías reconocer que:
* Los pasos 1-5 involucran principalmente Git (trabajo local);
* Los pasos 6-10 involucran tanto Git (para preparar los cambios) como GitHub (para la colaboración y el intercambio);
* Git maneja el control de versiones local y el registro de cambios;
* GitHub maneja el almacenamiento remoto, la colaboración y la comunicación.

---

## 10. Ejercicio de análisis

Observa esta situación:

Tu equipo de tres personas está trabajando en una aplicación web. Cada miembro trabaja desde su propia computadora en diferentes partes del país. Han decidido utilizar Git y GitHub para gestionar su trabajo.

Responde:

1. En cada una de las siguientes afirmaciones, determina si describe principalmente Git, GitHub, o ambos:
   a) "Registramos exactamente qué cambios se hicieron en cada archivo y cuándo"
   b) "Podemos ver exactamente quién propuso cada cambio y cuándo lo hizo"
   c) "Podemos discutir cambios específicos en el código antes de integrarlos"
   d) "Podemos recuperar una versión anterior del proyecto si algo sale mal"
   e) "Podemos ver exactamente qué líneas de código cambiaron entre dos versiones"
   f) "Podemos recibir notificaciones automáticas cuando alguien comenta en nuestro código"
   g) "Podemos crear versiones experimentales de nuestra trabajo sin afectar la versión principal"
   h) "Podemos ver un historial completo de quién tuvo acceso a qué partes del proyecto"
   i) "Podemos realizar pruebas automáticas cada vez que se envían cambios al repositorio principal"
   j) "Podemos recuperar el trabajo completo si se pierde una computadora individual"

2. Para cada afirmación, explica brevemente tu razonamiento.

3. ¿Qué crees que sería más difícil de lograr si solo tuvieran acceso a Git sin GitHub?
4. ¿Qué crees que sería más difícil de lograr si solo tuvieran acceso a GitHub sin Git?
5. ¿Cómo crees que la combinación de ambos hace que el trabajo en equipo sea más efectivo que cualquiera de las dos herramientas por separado?

---

## 11. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* qué es Git y cuál es su función principal;
* qué es GitHub y cuál es su función principal;
* cuál es la relación exacta entre Git y GitHub;
* por qué es importante no confundirlos y qué problemas puede causar la confusión;
* qué puedes hacer con Git solo (sin GitHub);
* qué puedes hacer con GitHub solo (sin Git local);
* cómo trabajan juntos Git y GitHub en un flujo de trabajo típico;
* ejemplos concretos de situaciones donde cada uno es más útil;
* errores comunes que surgen al confundirlos y cómo evitarlos;
* buenas prácticas para mantener clara esta distinción en tu mente y en tu trabajo;
* cómo entender esta diferencia te ayudará a ser más efectivo en tu trabajo con proyectos digitales.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica.

---

## 12. Resumen

En este capítulo aprendiste que:

* Git es un sistema distribuido de control de versiones que registra cambios en archivos y permite recuperarlos, combinarlos y gestionarlos;
* GitHub es una plataforma web que utiliza Git como su tecnología subyacente y agrega herramientas para colaboración, desarrollo y gestión;
* Git y GitHub son diferentes pero complementarios: Git hace el trabajo real de control de versiones, GitHub lo hace más útil, seguro y fácil de usar en equipos;
* Con solo Git, puedes crear repositorios locales, seguir cambios, crear ramas, combinar cambios y recuperar versiones anteriores, pero limitado a tu computadora personal;
* Con solo GitHub web, puedes explorar repositorios, participar en discusiones, gestionar proyectos y usar algunas herramientas de automatización, pero no puedes crear nuevos commits ni modificar el historial;
- Cuando trabajan juntos, Git gestiona el control de versiones local y GitHub proporciona el almacenamiento remoto, las herramientas de colaboración y los servicios de gestión;
* Errores comunes incluyen pensar que GitHub reemplaza a Git, creer que necesitas GitHub para usar Git, y usar los términos indistintamente;
* Buenas prácticas incluyen mantener clara la distinción en tu mente, usar los términos correctamente, y aprovechar lo mejor de ambos según tus necesidades;
* Entender esta diferencia es fundamental para trabajar eficazmente con proyectos digitales, especialmente en equipo.

La idea principal es:

> **Git y GitHub son herramientas distintas pero complementarias: Git hace el trabajo real de control de versiones, mientras que GitHub lo hace más útil, seguro y fácil de usar al agregar herramientas para colaboración, desarrollo y gestión. Confundirlos conduce a malentendidos, mientras que comprender su relación te permite aprovechar lo mejor de ambos.**

---

## Próximo paso

Ya sabes la diferencia entre Git y GitHub.

El siguiente paso es comprender con más detalle los tipos de repositorios (públicos y privados) y cuándo utilizar cada uno.

Continúa con:

[`05-repositorio-publico-y-privado.md`](05-repositorio-publico-y-privado.md)
