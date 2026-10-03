# Modelo mental de GitHub

## Introducción

En los capítulos anteriores has aprendido:
* Qué es GitHub y para qué sirve;
* La diferencia entre Git y GitHub;
* Qué es un repositorio y los tipos (público y privado);
* Qué es el control de versiones y cómo funciona;

Ahora es el momento de integrar todo este conocimiento en un **modelo mental coherente** que te ayude a comprender cómo GitHub funciona como sistema completo.

Un modelo mental es una representación interna de cómo algo funciona en el mundo real. Tener un buen modelo mental de GitHub te permitirá:
* Predecir qué pasará cuando realices ciertas acciones;
* Solucionar problemas de manera más efectiva cuando algo no funciona como esperas;
* Comunicarte mejor con otros sobre cómo trabajar con el sistema;
* Aprender nuevas funcionalidades más fácilmente al relacionarlas con lo que ya sabes;
* Tomar mejores decisiones sobre cómo estructurar tu trabajo y tu colaboración.

En este capítulo desarrollarás un modelo mental de GitHub que integre:
* El repositorio como unidad fundamental de trabajo;
* Git como motor de control de versiones subyacente;
* GitHub como plataforma de alojamiento y colaboración;
* El flujo de trabajo típico de desarrollo;
* Las características clave de colaboración (Issues, Pull Requests, etc.);
* Los aspectos de gestión y automatización;
* Cómo todo esto se relaciona con tu trabajo local y el de tu equipo.

No necesitas utilizar la terminal en este capítulo. Continuaremos enfocándonos en la comprensión conceptual y los ejemplos visuales.

---

## 1. El repositorio: el contenedor fundamental

Comencemos con el concepto más básico en GitHub: **el repositorio**.

### 1.1. Qué es un repositorio en tu modelo mental

Piensa en un repositorio como:
* **Una carpeta especializada** que contiene todo el historial de un proyecto;
* **Una base de datos de cambios** que registra quién hizo qué y cuándo;
* **Un contenedor de colaboración** que facilita que múltiples personas trabajen juntas;
* **Una unidad de propiedad** que tiene visibilidad definida (pública o privada);
* **Un punto de entrada** para automatización y gestión de proyectos.

### 1.2. Componentes internos de un repositorio

En tu modelo mental, un repositorio GitHub consiste en:

```text
Repositorio GitHub
    │
    ├── Código fuente y archivos
    │   │
    │   └── Estado actual de todos los archivos rastreados
    │
    ├── Historial de versiones (powered by Git)
    │   │
    │   ├── Snapshots/commits ordenados cronológicamente
    │   │
    │   ├── Ramas (branches) que representan líneas de trabajo
    │   │
    │   └── Etiquetas (tags) que marcan versiones importantes
    │
    ├── Configuración del repositorio
    │   │
    │   ├── Visibilidad (pública/privada)
    │   │
    │   ├── Ramas protegidas
    │   │
    │   ├── Política de fusiones
    │   │
    │   └── Otros ajustes de comportamiento
    │
    ├── Herramientas de colaboración
    │   │
    │   ├── Issues (tareas, errores, mejoras)
    │   │
    │   ├── Pull Requests (propuestas de cambio)
    │   │
    │   └── Discussions (conversaciones abiertas)
    │
    ├── Servicios de gestión
    │   │
    │   ├── Projects (tableros de organización)
    │   │
    │   ├── Wiki (documentación)
    │   │
    │   ├── Packages (alojamiento de artefactos)
    │   │
    │   └── Security (alertas de vulnerabilidades)
    │
    └── Automatización e integraciones
        │
        ├── GitHub Actions (CI/CD)
        │
        ├── Webhooks (notificaciones HTTP)
        │
        └── Integraciones de terceros
```

### 1.3. El repositorio como fuente única de verdad

En tu modelo mental, el repositorio en GitHub representa la **fuente única de verdad** para tu proyecto:

```text
Tu trabajo local          Trabajo de compañeros
    │                            │
    │ fetch/pull                 │ fetch/pull
    ▼                            ▼
[Repositorio en GitHub] ←─[Centro de verdad compartida]─→ [Repositorio en GitHub]
    │                            │
    │ push                       │ push
    ▼                            ▼
Tu repositorio local      Repositorio local de compañeros
```

Cualquier cambio que quieras compartir con tu equipo debe pasar por el repositorio en GitHub. Este se convierte en el punto de sincronización donde todos los miembros del equipo convergen y divergen su trabajo.

---

## 2. Git: el motor subyacente

Ahora veamos cómo encaja Git en tu modelo mental.

### 2.1. Git como motor de control de versiones

En tu modelo mental, Git es:
* **El motor que hace posible el historial de versiones**;
* **El responsable de almacenar y gestionar snapshots**;
* **El que maneja ramas, fusiones y recuperación de estados**;
* **El que opera principalmente en tu entorno local**;
* **El que se comunica con el repositorio remoto en GitHub mediante protocolos de red**.

### 2.2. La relación Git-GitHub en tu modelo mental

Visualiza esta relación así:

```text
Tu computadora
    │
    ├── Entorno local de trabajo
    │   │
    │   ├── Archivos de tu proyecto (working directory)
    │   │
    │   ├── Área de preparación (staging/index)
    │   │
    │   └── Repositorio Git local (base de datos de objetos)
    │
    │       ▲
    │       │ push/fetch/pull
    │       │
    ▼       │
[GitHub] ←─[Red de internet]─→ [Otra computadora]
    ▲
    │
    └─ Repositorio Git remoto (almacenado en servidores de GitHub)
```

En este modelo:
* Tu **repositorio Git local** es donde haces commit y gestionas tu historial local;
* El **repositorio Git remoto en GitHub** es donde se almacena la versión compartida que todos pueden acceder;
* Las operaciones **push, fetch y pull** son los mecanismos de sincronización entre local y remoto;
* GitHub agrega capas de colaboración, gestión y automatización alrededor del repositorio Git remoto.

### 2.3. Qué hace GitHub que Git no hace

En tu modelo mental, GitHub extiende Git con:

```text
Git (solo)
    │
    └── Control de versiones distribuido
        │
        ├── Historial de commits
        │
        ├── Ramas y fusiones
        │
        └── Operaciones locales (commit, branch, merge, etc.)

GitHub (Git +)
    │
    ├── Todo lo que Git hace
    │
    ├── Alojamientode repositorios Git remotos
    │
    ├── Interfaz web para explorar historial y archivos
    │
    ├── Herramientas de colaboración (Issues, PRs, Reviews)
    │
    ├── Gestión de acceso y permisos
    │
    ├── Automatización (GitHub Actions)
    │
    ├── Servicios de paquetes y registro
    │
    ├── Seguridad y alertas de vulnerabilidades
    │
    └── Integraciones con herramientas externas
```

---

## 3. Flujo de trabajo típico: poniéndolo todo junto

Desarrollemos un modelo mental del flujo de trabajo típico usando un escenario concreto.

### 3.1. Escenario: agregando una nueva característica

Imagina que quieres agregar una característica de "inicio de sesión con Google" a una aplicación web.

#### Paso 1: preparación

```text
[Tú] deciden trabajar en "inicio de sesión con Google"
    │
    ▼
Aseguras que tu repositorio local está actualizado
    │
    ▼
git fetch origin
    │
    ▼
git checkout main
    │
    ▼
git pull origin main
    │
    ▼
[Tu repositorio local] ahora tiene el último estado de [GitHub/main]
    │
    ▼
Creas una rama para tu trabajo
    │
    ▼
git checkout -b feature/google-login
    │
    ▼
[Tu repositorio local] ahora tiene una nueva rama basada en main
```

#### Paso 2: trabajo local

```text
[Tú] editas archivos para agregar la funcionalidad de login con Google
    │
    ▼
Pruebas tus cambios localmente
    │
    ▼
Cuando llegas a un punto de guardado lógico:
    │
    ▼
Revisas qué archivos cambiaste (git status)
    │
    ▼
Preparas los cambios específicos que quieres incluir (git add -p)
    │
    ▼
Haces commit con mensaje descriptivo
    │
    ▼
git commit -m "Agregar endpoint de autenticación con Google"
    │
    ▼
[Tu repositorio local] ahora tiene un nuevo commit en feature/google-login
    │
    ▼
Repetir según necesites más trabajo
```

#### Paso 3: compartir y colaborar

```text
Cuando tu trabajo está listo para revisión:
    │
    ▼
Envías tu rama al repositorio remoto en GitHub
    │
    ▼
git push origin feature/google-login
    │
    ▼
[GitHub] ahora tiene tu rama feature/google-login con tus commits
    │
    ▼
Abres un Pull Request desde feature/google-login hacia main
    │
    ▼
[GitHub] muestra el PR con:
    │   ├─ Resumen de cambios
    │   ├─ Diff línea por línea
    │   ├─ Espacio para descripción y contexto
    │   └─ Lista de verificaciones requeridas
    │
    ▼
Notificas a tus compañeros para que revisen tu PR
    │
    ▼
[GitHub] envía notificaciones a los revisores asignados
    │
    ▼
Tus compañeros revisan tu código, dejan comentarios y sugieren cambios
    │
    ▼
[Tú] atendés los comentarios:
    │   ├─ Haces más commits locales
    │   ├─ Los pusheas a la misma rama
    │   ├─ El PR se actualiza automáticamente
    │   └─ Resolvés los hilos de comentario
    │
    ▼
Cuando todos están satisfechos:
    │
    ▼
Los revisores aprueban el PR
    │
    ▼
[GitHub] ejecuta verificaciones automatizadas (CI)
    │
    ▼
Si todo pasa:
    │
    ▼
Se mergea el PR a la rama main
    │
    ▼
[GitHub] crea un merge commit (si se configura así) o aplica squash/rebasing
    │
    ▼
[GitHub/main] ahora incluye tu característica
    │
    ▼
[Opcional] Se elimina la rama feature/google-login
```

#### Paso 4: sincronización posterior

```text
Después del merge:
    │
    ▼
[Tú] actualizas tu rama main local
    │
    ▼
git checkout main
    │
    ▼
git pull origin main
    │
    ▼
[Tu repositorio local/main] ahora tiene el merge de tu característica
    │
    ▼
Eliminas tu rama local de trabajo (opcional)
    │
    ▼
git branch -d feature/google-login
    │
    ▼
Continuas con el próximo trabajo
```

### 3.2. Visualizando el flujo completo en tu modelo mental

```text
Inicio
    │
    ▼
[Crear rama local] ←─[Actualizar desde main]─┐
    │                                       │
    ▼                                       │
[Trabajo local y commits] ←─[Iterar según necesidad]─┐
    │                                       │        │
    ▼                                       │        │
[Push rama a GitHub]                        │        │
    │                                       │        │
    ▼                                       │        │
[Crear Pull Request]                        │        │
    │                                       │        │
    ▼                                       │        │
[Revisión de código] ←─[Comentarios y cambios]─┘        │
    │                                       │              │
    ▼                                       │              │
[Apobaciones y verificaciones]              │              │
    │                                       │              │
    ▼                                       │              │
[Merge a main]                              │              │
    │                                       │              │
    ▼                                       │              │
[Actualizar main local]                     │              │
    │                                       │              │
    ▼                                       │              │
[Limpiar ramas locales] ←─[Fin]             │              │
    │                                       │              │
    └───────────────────────────────────────┘              │
                                                           ▼
                                                    [Esperar próximo trabajo]
```

---

## 4. Capacidades clave de GitHub en tu modelo mental

Organicemos las capacidades de GitHub en categorías que tenga sentido en tu modelo mental.

### 4.1. Capacidades de almacenamiento y versión

```text
Almacenamiento y versiones
    │
    ├── Alojamientode repositorios Git remotos
    │   │
    │   ├── Accesible vía HTTPS y SSH
    │   │
    │   ├── Historial completo disponible para clonar
    │   │
    │   └── Protección contra pérdida de datos
    │
    ├── Exploración de historial mediante web
    │   │
    │   ├── Visualización de commits y cambios
    │   │
    │   ├── Navegación de ramas y etiquetas
    │   │
    │   └── Búsqueda en el código y el historial
    │
    └── Descarga y clonación
        │
        ├── Clonar repositorio completo
        │
        ├── Descargar archivos específicos
        │
        └── Descargar releases etiquetados
```

### 4.2. Capacidades de colaboración

```text
Colaboración
    │
    ├── Issues (trabajo a realizar)
    │   │
    │   ├── Seguimiento de errores, características y tareas
    │   │
    │   ├── Asignación, etiquetado y priorización
    │   │
    │   ├── Discusión mediante comentarios
    │   │
    │   └── Vinculación a commits y PRs
    │
    ├── Pull Requests (propuestas de cambio)
    │   │
    │   ├── Proponer fusión de ramas
    │   │
    │   ├── Revisión de código línea por línea
    │   │
    │   ├── Comentarios y discusión estructurada
    │   │
    │   ├── Integración con revisiones requeridas
    │   │
    │   └── Verificaciones automatizadas (CI/CD)
    │
    ├── Discussions (conversaciones abiertas)
    │   │
    │   ├── Preguntas y respuestas abiertas
    │   │
    │   ├── Intercambio de ideas y retroalimentación
    │   │
    │   └── Construcción de conocimiento comunitario
    │
    └── Forks (copias personales)
        │
        ├── Experimentación sin afectar al original
        │
        ├── Contribución a proyectos externos
        │
        └── Puntos de partida para trabajo derivado
```

### 4.3. Capacidades de gestión

```text
Gestión
    │
    ├── Configuración del repositorio
    │   │
    │   ├── Visibilidad (pública/privada)
    │   │
    │   ├── Ramas protegidas
    │   │
    │   ├── Política de fusiones (squash, merge, rebase)
    │   │
    │   ├── Regla de asignación automática de revisores
    │   │
    │   └── Plantillas de Issues y PRs
    │
    ├── Gestión de acceso y permisos
    │   │
    │   ├── Roles (lectura, escritura, administración)
    │   │
    │   ├── Equipos y organizaciones
    │   │
    │   ├── Protección de ramas mediante reglas
    │   │
    │   └── Control de acceso granular
    │
    ├── Project Management
    │   │
    │   ├── Tableros Kanban (Projects)
    │   │
    │   ├── Seguimiento de progreso mediante hitos
    │   │
    │   └── Integración con Issues y PRs
    │
    └── Documentación
        │
        ├── Wikis para documentación colaborativa
        │
        ├── Páginas de lectura automática (README)
        │
        └── GitHub Pages para sitios de documentación
```

### 4.4. Capacidades de automatización

```text
Automatización
    │
    ├── GitHub Actions (CI/CD)
    │   │
    │   ├── Flujo de trabajo basado en eventos
    │   │
    │   ├── Construcción, prueba y despliegue
    │   │
    │   ├── Ejecución en respuesta a push, PR, etc.
    │   │
    │   ├── Matriz de pruebas (multiplataforma, versiones)
    │   │
    │   └── Despliegue a diversos servicios (Azure, AWS, etc.)
    │
    ├── Webhooks
    │   │
    │   ├── Notificaciones HTTP personalizadas
    │   │
    │   ├── Integración con servicios externos
    │   │
    │   └── Automatización de flujos de trabajo externos
    │
    ├── Packages (registro de paquetes)
    │   │
    │   ├── Almacenamiento de paquetes npm, Docker, Maven, etc.
    │   │
    │   ├── Versionamiento y distribución de artefactos
    │   │
    │   └── Integración con flujos de construcción
    │
    └── Seguridad
        │
        ├── Escaneo de dependencias vulnerables
        │
        ├── Análisis de seguridad de código
        │
        ├── Alertas automatizadas de vulnerabilidades
        │
        └── Políticas de seguridad de repositorio
```

---

## 5. Escenarios comunes y cómo encajan en tu modelo mental

Veamos cómo diferentes situaciones comunes se representan en tu modelo mental.

### 5.1. Trabajo individual en un proyecto personal

```text
[Tú]                     [GitHub]
    │                           │
    │ crear repositorio         │
    ◄───────────────────────────┘
    │                           │
    │ trabajar localmente       │
    │ (commits, ramas, etc.)    │
    │                           │
    │ push cambios              │
    ───────────────────────────►
    │                           │
    │ (opcional) crear Issues   │
    │ para planear trabajo futuro│
    │                           │
    │ (opcional) usar Projects  │
    │ para organizar tareas     │
    │                           │
    ▼                           ▼
[Tú sigue trabajando]   [Repositorio como copia de seguridad y historial]
```

En este escenario, GitHub funciona principalmente como:
* Copia de seguridad remota;
* Historial accesible desde cualquier lugar;
* Plataforma opcional para organización de trabajo (Issues, Projects);
* Medio para mostrar tu trabajo a otros (portafolio).

### 5.2. Trabajo en equipo pequeño

```text
[Desarrollador A]      [Desarrollador B]      [Desarrollador C]
    │                         │                         │
    │ fetch/pull main         │ fetch/pull main         │ fetch/pull main
    │                         │                         │
    ▼                         ▼                         ▼
[Trabajo local y commits] [Trabajo local y commits] [Trabajo local y commits]
    │                         │                         │
    │ push ramas              │ push ramas              │ push ramas
    ───────────────────────►  ───────────────────────►  ───────────────────────►
    │                         │                         │
    │                         │                         │
    ▼                         ▼                         ▼
                    [GitHub]
                    │
                    ├─ Recibir push de todas las ramas
                    ├─ Alojar repositorio central
                    ├─ Facilitar PRs entre desarrolladores
                    ├─ Ejecutar verificaciones automatizadas
                    └─ Mantener historial unificado
                    │
                    ▼
            [Main actualizada con trabajo integrado]
                    │
                    ▲ fetch/pull main
                    │                         │
                    │                         │
                    └─────────────────────────┘
```

En este escenario, GitHub funciona como:
* Centro de colaboración y sincronización;
* Mediador para revisiones de código mediante PRs;
* Ejecutor de verificaciones automatizadas;
* Mantenedor de historial unificado y accesible.

### 5.3. Contribución a proyecto de código abierto

```text
[Tú (contribuidor)]    [Mantenedores del proyecto]
    │                         │
    │ fork del repositorio    │
    ◄─────────────────────────┘
    │                         │
    │ trabajar en fork        │
    │ (commits, ramas, etc.)  │
    │                         │
    │ push cambios al fork    │
    ─────────────────────────►
    │                         │
    │ abrir PR desde fork     │
    │ hacia repositorio original
    ◄─────────────────────────┘
    │                         │
    │ revisar PR, comentar    │
    │ sugerir cambios         │
    │                         │
    │ atender comentarios     │
    │ hacer más commits       │
    │ push al mismo fork      │
    ─────────────────────────►
    │                         │
    │ aprobar y mergear PR    │
    │                         │
    ▼                         ▼
[Fork actualizado]    [Repositorio original con nueva contribución]
    │                         │
    │ sync con upstream       │
    │ (opcional)              │
    ◄─────────────────────────┘
```

En este escenario, GitHub funciona como:
* Facilitador de fork para experimentación sin permisos de push directo;
* Medio para proponer cambios mediante PRs desde forks;
* Plataforma para revisión pública y discusión comunitaria;
* Garantía de que los mantenedores mantienen el control final sobre qué se integra.

### 5.4. Flujo de trabajo con lanzamiento automático

```text
[Desarrollador]         [GitHub]                     [Servicios externos]
    │                         │                             │
    │ push feature/xxxx       │                             │
    ───────────────────────►  │                             │
    │                         │                             │
    │ abrir PR hacia main     │                             │
    ◄─────────────────────────┘                             │
    │                         │                             │
    │ revisión y aprobación   │                             │
    │                         │                             │
    │ mergear PR              │                             │
    │                         │ ───────────────────────►   │
    │                         │ déclencher GitHub Actions   │
    │                         │                             │
    │                         │ construir aplicación        │
    │                         │ ejecutar pruebas            │
    │                         │ crear artefacto (Docker, etc)│
    │                         │                             │
    │                         │ ───────────────────────►   │
    │                         │ despliegue a staging        │
    │                         │                             │
    │                         │ ───────────────────────►   │
    │                         │ despliegue a producción     │
    │                         │                             │
    │                         │                             │
    │ (opcional) crear release│                             │
    │ etiquetado v1.2.3       │                             │
    ◄─────────────────────────┘                             │
    │                         │                             │
    │ generar notas de lanzamiento                     │
    │                         │                             │
    ▼                         ▼                             ▼
[Notificación de éxito] [Aplicación en producción] [Usuarios felices]
```

En este escenario, GitHub funciona como:
* Iniciador de flujos de trabajo automatizados;
* Origen de eventos que desencadenan construcción y despliegue;
* Mediador entre código y sistemas de entrega;
* Proveedor de visibilidad sobre el estado del proceso de lanzamiento.

---

## 6. Límites y fronteras en tu modelo mental

Es importante también entender qué **no** es parte de GitHub o dónde termina su responsabilidad.

### 6.1. Qué GitHub no es

```text
GitHub NO es:
    │
    ├── Tu entorno local de desarrollo
    │   │
    │   ├── Tu editor de código (VS Code, IntelliJ, etc.)
    │   │
    │   ├── Tu compilador o intérprete
    │   │
    │   └── Tu base de datos local o servicios de desarrollo
    │
    ├── El único lugar donde existe tu código
    │   │
    │   │ (también existe en tu máquina local y en los forks de otros)
    │   │
    │   └── (el historial está distribuido, aunque GitHub aloja una copia autoritativa)
    │
    ├── Un servicio de alojamiento general de archivos
    │   │
    │   │ (está optimizado para repositorios Git, no para almacenamiento arbitrario)
    │   │
    │   └── (para archivos grandes binary, se recomienda Git LFS o servicios externos)
    │
    ├── Un reemplazo para la comunicación directa del equipo
    │   │
    │   │ (complementa, pero no reemplaza reuniones, chat, llamadas, etc.)
    │   │
    │   └── (la comunicación efectiva sigue requiriendo interacción humana directa)
    │
    └── Una garantía de calidad de código
        │
        │ (proporciona herramientas para revisión y pruebas, pero no asegura calidad por sí mismo)
        │
        └── (la calidad depende de las prácticas del equipo, no solo de las herramientas)
```

### 6.2. La frontera entre local y remoto

En tu modelo mental, esta frontera es crucial:

```text
Frontera Local ←─► Remoto
    │                       │
    │  Lo que controlas completamente: │  Lo que compartes y sincronizas:
    │  │                               │
    │  ├─ Working directory           │  ├─ Historial compartido (push/pull)
    │  ├─ Área de preparación         │  ├─ Ramas visibles para otros
    │  ├─ Commits locales             │  ├─ Issues y PRs
    │  ├─ Ramas locales               │  ├─ Revisión de código
    │  ├─ Historial local no pusheado │  ├─ Verificaciones automatizadas
    │  │                               │  ├─ Lanzamientos y releases
    │  └─ Experimentación privada     │  └─ Configuración del repositorio
    │                                 │
    ▼                                 ▼
Lo que es privado y aislado     Lo que es público y colaborativo
    │                                 │
    │  Puedes reescribir historial    │  Historial es inmutable una vez compartido
    │  Puedes experimentar libremente │  Cambios afectan a otros
    │  No afectas a otros directamente│  Requieren consenso y coordinación
    ▼                                 ▼
Libertad individual             Responsabilidad compartida
```

---

## 7. Cómo usar tu modelo mental para resolver problemas

Tu modelo mental de GitHub no es solo para entender: es una herramienta para razonar y resolver problemas.

### 7.1. Preguntas que tu modelo mental te ayuda a responder

Cuando te encuentres con una situación, pregúntate:

#### ¿Dónde ocurre esto en mi modelo mental?
* ¿Es un problema local (en mi máquina) o remoto (en GitHub)?
* ¿Está relacionado con el historial, las ramas, la colaboración o la automatización?
* ¿Está en el flujo de trabajo de desarrollo o en la gestión del repositorio?

#### ¿Qué componente está involucrado?
* ¿Es el motor Git subyacente o una capa de GitHub (Issues, PRs, Actions)?
* ¿Está en el almacenamiento, la colaboración, la gestión o la automatización?
* ¿Es algo que afecta a mi trabajo individual o al trabajo del equipo?

#### ¿Cuál sería el flujo esperado según mi modelo mental?
* ¿Qué debería suceder paso a paso según mi comprensión?
* ¿En qué punto se desvía la realidad de lo esperado?
* ¿Qué suposición de mi modelo mental podría estar incorrecta o incompleta?

#### ¿Qué acción tomar basada en mi modelo mental?
* ¿Necesito trabajar localmente (commit, branch, reset)?
* ¿Necesito interactuar con el remoto (push, pull, fetch)?
* ¿Necesito usar las herramientas de colaboración de GitHub (PR, Issues)?
* ¿Necesito ajustar la configuración o permisos del repositorio?

### 7.2. Ejemplos de aplicación

#### Problema: "Mis cambios no aparecen en GitHub después de hacer commit"

**Análisis con modelo mental:**
* Commit es operación local (en mi repositorio Git local);
* Para que aparezca en GitHub, necesito push;
* Probablemente olvidé hacer push después del commit.

**Solución:** `git push origin nombre-de-rama`

#### Problema: "No puedo hacer pull porque dice que tengo cambios conflictos"

**Análisis con modelo mental:**
* Pull intenta fusionar cambios remotos con mi working directory;
* Tengo cambios locales no committeados que entrarían en conflicto;
* Git no permite sobreescribir cambios no committeados durante pull.

**Solución:** O bien `git stash` mis cambios locales, hacer pull, luego `git stash pop`;
O bien committear mis cambios locales primero, luego hacer pull.

#### Problema: "Abrí un PR pero no se ejecuta ninguna verificación"

**Análisis con modelo mental:**
* Los PRs en GitHub pueden desencadenar GitHub Actions;
* Si no se ejecutan verificaciones, quizás:
  * No hay workflows configurados en `.github/workflows/`;
  * Los workflows no se disparan por eventos de PR;
  * Hay permisos insuficientes para ejecutar Actions;
  * El workflow tiene condiciones que no se cumplen.

**Solución:** Verificar existencia y configuración de workflows; revisar permisos; revisar condiciones del workflow.

#### Problema: "Quiero volver a un estado anterior pero temo perder trabajo"

**Análisis con modelo mental:**
* Tengo opciones según si los cambios están locales o ya pusheados:
  * Si están solo locales: `git reset` o `git checkout` pueden ayudar;
  * Si ya están pusheados: debo considerar el impacto en otros;
  * Para volver sin afectar historial compartido: `git revert` es más seguro;
  * Para trabajo experimental: debería estar en una rama separada.

**Solución:** Depende del contexto, pero mi modelo mental me recuerda considerar el alcance y las consecuencias antes de actuar.

---

## 8. Evolución de tu modelo mental

Tu modelo mental no es estático: debe evolucionar a medida que ganas experiencia.

### 8.1. Desde principiante a intermedio

**Principiante ve:**
* GitHub = "lugar donde guardo mi código";
* Commit = "guardar archivo";
* Push = "subir a internet";
* Pull Request = "enviar código para que lo miren";
* Issues = "lista de cosas por hacer".

**Intermedio ve:**
* GitHub = "plataforma de colaboración basada en Git";
* Commit = "instantánea del estado del proyecto con contexto";
* Push = "sincronizar mi historial local con el remoto compartido";
* Pull Request = "propuesta estructurada para integrar trabajo con revisión";
* Issues = "sistema de seguimiento de trabajo vinculado al código";
* Ramas = "líneas de desarrollo aisladas para trabajo paralelo";
* Fusiones = "puntos de integración donde se combina trabajo";
* Actions = "automatización que responde a eventos del repositorio".

### 8.2. Desde intermedio a avanzado

**Intermedio ve lo anterior; avanzado añade:**
* GitHub = "ecosistema de herramientas que soportan el desarrollo moderno de software";
* Commit = "unidad básica de trabajo colaborativo y trazabilidad histórica";
* Push/pull = "mecanismo de consenso para convergencia y divergencia de trabajo";
* Pull Request = "interfaz para revisión de calidad, transferencia de conocimiento y decisión colectiva";
* Issues = "lenguaje compartido para describir trabajo, prioridades y dependencias";
* Ramas = "estructuras para gestionar incertidumbre, experimentación y riesgo";
* Fusiones = "puntos de síntesis donde se resuelven conflictos creativos y técnicos";
* Actions = "infraestructura programable que convierte el repositorio en un sistema activo";
* Seguridad y permisos = "marcos de confianza que permiten colaboración a escala";
* Forks = "mecanismo para permiso colaborativo sin compromiso directo";
* Releases = "puntos de entrega que separan desarrollo interno de valor externo";

### 8.3. Preguntas para evolucionar tu modelo mental

Para seguir mejorando tu modelo mental, pregúntate periódicamente:

* ¿Qué aspectos de GitHub aún me parecen mágicos o misteriosos?
* ¿Qué situaciones comunes me hacen sentir que falta alguna pieza en mi comprensión?
* ¿Qué nuevas características he visto y cómo las encajaría en mi modelo existente?
* ¿Qué flujos de trabajo complejos he observado y cómo los explicaría con mi modelo?
* ¿Qué limitaciones he encontrado y cómo explicaría esas limitaciones desde mi modelo?
* ¿Qué metáforas o analogías me ayudan a explicar GitHub a otros con diferentes niveles de experiencia?

---

## 9. Resumen: los pilares de tu modelo mental de GitHub

Consolidemos los elementos clave que deberías tener en tu modelo mental:

### 9.1. El repositorio como núcleo
* Contenedor fundamental que combina código, historial y colaboración;
* Fuente única de verdad para el trabajo compartido del equipo;
* Unidad de propiedad con visibilidad definida (pública/privada).

### 9.2. Git como motor subyacente
* Responsable del control de versiones distribuido;
* Opera principalmente en el entorno local con sincronización remota;
* Maneja snapshots, ramas, fusiones y recuperación de estados.

### 9.3. GitHub como plataforma extensor
* Aloja repositorios Git remotos y los hace accesibles;
* Añade capas de colaboración (Issues, PRs, Reviews);
* Proporciona gestión de acceso, protección de ramas y configuración;
* Ofrece automatización mediante Actions y webhooks;
* Integra servicios de paquetes, seguridad y documentación.

### 9.4. Flujo de trabajo como patrón de vida
* Trabajo aislado en ramas locales;
* Compartición periódica mediante push;
* Propuesta estructurada de cambios mediante Pull Requests;
* Revisión de código y discusión como paso previo a la integración;
* Integración controlada mediante fusión a ramas principales;
* Sincronización regular mediante pull para mantenerse actualizado;
* Eliminación de ramas temporales tras fusión exitosa.

### 9.5. Colaboración como propiedad emergente
* Transparencia mediante historial visible y atribuible;
* Responsabilidad mediante autoría clara y mensajería descriptiva;
* Consenso mediante revisión y aprobación antes de la fusión;
* Transferencia de conocimiento mediante comentarios y discusión vinculada al código;
* Independencia mediante trabajo asincrónico y ramas aisladas.

### 9.6. Automatización como fuerza multiplicadora
* Respuesta a eventos (push, PR, issue) mediante workflows definidos;
* Construcción, prueba y despliegue automáticos;
* Retroalimentación temprana sobre calidad y compatibilidad;
* Liberación de esfuerzo humano para tareas creativas y de decisión;
* Consistencia mediante ejecución reproducible de procesos.

### 9.7. Evolución como principio
* Tu modelo mental debe mejorar con la experiencia y el uso;
* Cada situación problemática es una oportunidad para refinar tu comprensión;
* La metáfora adecuada depende del contexto y la audiencia;
* El verdadero valor no está en las herramientas, sino en las prácticas que permiten;
* El objetivo final es habilitar trabajo humano efectivo, creativo y sostenible.

---

## 10. Práctica final: aplicar tu modelo mental

Para consolidar tu aprendizaje, aplica tu modelo mental a estos escenarios:

### Escenario A: Trabajo individual
Quieres aprender un nuevo framework y crear un proyecto de prueba para experimentar.

**Aplica tu modelo mental:**
* ¿Cómo estructurarías tu repositorio?
* ¿Qué usarías localmente vs. lo que compartirías en GitHub?
* ¿Cómo usarías ramas para experimentar sin afectar tu trabajo principal?
* ¿Cómo documentarías tu aprendizaje para futuras referencias?

### Escenario B: Equipo de tres personas
Tres desarrolladores están creando una aplicación móvil juntos.

**Aplica tu modelo mental:**
* ¿Cómo dividirían el trabajo usando ramas?
* ¿Cómo manejarían las dependencias entre su trabajo?
* ¿Cómo usarían Pull Requests para asegurar la calidad?
* ¿Cómo usarían Issues para planificar y seguir el progreso?
* ¿Cómo configurarían protección de ramas para su main?
* ¿Cómo usarían Actions para probar en cada cambio?

### Escenario C: Proyecto de código abierto
Quieres contribuir a un proyecto popular que usas frecuentemente.

**Aplica tu modelo mental:**
* ¿Cómo harías un fork para empezar a trabajar?
* ¿Cómo crearías una rama para tu contribución específica?
* ¿Cómo escribirías un buen mensaje de commit para tu cambio?
* ¿Cómo abrirías un Pull Request que sea fácil de revisar?
* ¿Cómo atenderías los comentarios de los mantenedores?
* ¿Cómo mantendrías tu fork actualizado con el proyecto principal?

### Escenario D: Lanzamiento de producto
Tu equipo está preparando el lanzamiento de una versión importante de su software.

**Aplica tu modelo mental:**
* ¿Cómo usarían etiquetas (tags) para marcar la versión para lanzamiento?
* ¿Cómo crearían una rama de release para preparativos finales?
* ¿Cómo usarían Issues para seguir tareas pendientes de lanzamiento?
* ¿Cómo configurarían Actions para construir y desplegar automáticamente?
* ¿Cómo usarían Releases en GitHub para distribuir la versión lanzada?
* ¿Cómo documentarían el lanzamiento para usuarios y desarrolladores internos?

---

## 11. Cómo saber si lo entendiste

Deberías poder explicar con tus propias palabras:

* el repositorio como unidad fundamental que combina código, historial y colaboración;
* Git como motor subyacente de control de versiones que opera localmente y se sincroniza con remotos;
* GitHub como plataforma que extiende Git con colaboración, gestión y automatización;
* el flujo de trabajo típico que integra ramas locales, push, Pull Requests, revisión y fusión;
* cómo las capacidades de colaboración (Issues, PRs) facilitan el trabajo en equipo;
• cómo las capacidades de gestión (protección de ramas, permisos) permiten trabajo a escala;
* cómo las capacidades de automatización (Actions, webhooks) convierten el repositorio en un sistema activo;
* los límites y fronteras entre lo local y lo remoto, lo privado y lo compartido;
* cómo usar tu modelo mental para razonar sobre problemas y decidir acciones;
* cómo tu modelo mental debe evolucionar con la experiencia y el uso compartido;
* cómo aplicar tu modelo mental a diferentes escenarios de trabajo individual, en equipo y código abierto.

Si alguna respuesta todavía no está clara, vuelve a la sección correspondiente y repite la práctica, enfocándote en cómo las piezas se integran en tu modelo mental completo.

---

## 12. Resumen final

En este capítulo has desarrollado un modelo mental integral de GitHub que integra:

* **El repositorio** como contenedor fundamental de código, historial y colaboración;
* **Git** como motor subyacente de control de versiones que opera principalmente localmente;
* **GitHub** como plataforma que aloja repositorios remotos y agrega colaboración, gestión y automatización;
* **El flujo de trabajo típico** que combina trabajo aislado en ramas locales, compartir mediante push, proponer cambios mediante Pull Requests, revisar código y fusionar a ramas principales;
* **Las capacidades clave** de almacenamiento, colaboración, gestión y automatización que hacen de GitHub más que solo un repositorio Git remoto;
* **Los límites y fronteras** que definen qué es local vs. remoto, privado vs. compartido, individual vs. equipo;
* **Cómo usar tu modelo mental** para razonar sobre problemas, predecir resultados y decidir acciones apropiadas;
* **Cómo evolucionar tu modelo mental** con la experiencia para abordar situaciones cada vez más complejas;

La idea principal es:

> **GitHub no es solo un lugar para guardar código, ni es solo Git en la web. Es una plataforma integrada que combina el poder del control de versiones distribuido con herramientas sofisticadas para colaboración, gestión y automatización. Un buen modelo mental de GitHub te permite ver cómo estas piezas se integran para habilitar trabajo humano efectivo, creativo y sostenible en proyectos de software modernos.**

---

## Próximo paso

Has completado la sección 02-github-desde-cero. Ahora tienes una comprensión sólida de:

* Qué es GitHub y para qué sirve;
* La diferencia entre Git y GitHub;
* Qué es un repositorio y los tipos (público y privado);
* Qué es el control de versiones y cómo funciona;
* Un modelo mental completo de cómo GitHub funciona como sistema integrado;

Continúa con la siguiente sección del tutorial o aplica lo aprendido a tus propios proyectos.

¡Felicitaciones por completar esta sección fundamental del tutorial GitHub Paso a Paso!