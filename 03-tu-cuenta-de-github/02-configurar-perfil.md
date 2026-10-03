# Configurar tu perfil

## Introducción

En el capítulo anterior creaste tu cuenta de GitHub con correo verificado, nombre de usuario elegido y credenciales guardadas.

La cuenta existe, pero está vacía: si alguien abre `github.com/tu-usuario` ahora mismo, verá una página sin nombre, sin foto y sin información.

El perfil es lo primero que ven las personas que te buscan: un reclutador que recibe tu CV, un mantenedor de código abierto que revisa tu Pull Request, un compañero de equipo al que le pasas tu usuario.

Configurar el perfil no es una cuestión de vanidad. Es una cuestión de identidad profesional: el perfil traduce «quién soy y qué hago» a una página que acompaña tu trabajo durante todo tu historial en la plataforma.

En este capítulo aprenderás:

* qué elementos componen tu perfil público;
* cómo acceder a la edición del perfil;
* cómo redactar un nombre real y una biografía que te representen;
* cómo elegir y subir una foto de perfil adecuada;
* qué información es pública y qué información no lo es;
* cómo se conecta el perfil con tu actividad de código;
* los errores más comunes al configurar el perfil;
* cómo se valora el perfil en contextos profesionales.

No necesitas instalar nada. Todo ocurre en el navegador.

---

## Mapa conceptual de este capítulo

```text
Tu perfil de GitHub
       │
       ├── 1. Qué es el perfil y para qué sirve
       │        ├── Identidad pública
       │        ├── Carta de presentación
       │        └── Huella profesional
       │
       ├── 2. Elementos del perfil
       │        ├── Avatar (foto)
       │        ├── Nombre real
       │        ├── Nombre de usuario (URL)
       │        ├── Biografía
       │        ├── Ubicación
       │        ├── Sitio web
       │        ├── Organizaciones visibles
       │        ├── Actividad pública
       │        ├── Estrellas y «following»
       │        └── README del perfil
       │
       ├── 3. Qué es público y qué es privado
       │
       ├── 4. Editar el perfil paso a paso
       │
       ├── 5. La foto de perfil
       │        ├── Técnica
       │        ├── Profesional
       │        └── Accesibilidad
       │
       ├── 6. La biografía
       │        ├── Qué escribir
       │        ├── Qué evitar
       │        └── Ejemplos
       │
       ├── 7. El README del perfil
       │
       ├── 8. Actividad y visibilidad
       │
       ├── 9. Errores comunes
       │
       ├── 10. Práctica guiada
       │
       ├── 11. Nivel profesional
       │        ├── Marca personal
       │        ├── Perfil y reclutamiento
       │        └── Perfil en organizaciones
       │
       └── 12. Resumen y siguiente paso
```

---

## 1. Qué es el perfil y para qué sirve

### 1.1. Definición

El **perfil** es la página pública asociada a tu cuenta, accesible en:

```text
https://github.com/TU_USUARIO
```

Reúne tu identidad (nombre, foto, biografía, ubicación), tu actividad pública (commits, Pull Requests, repositorios, estrellas) y tus relaciones (seguidores, seguidos, organizaciones).

### 1.2. Para qué lo consultan los demás

Antes de diseñar tu perfil, conviene entender quién lo mira y por qué:

```text
Visitante típico          Motivo de visita                    Qué busca en tu perfil
─────────────────────────────────────────────────────────────────────────────────────
Reclutador                Evaluar candidatura                 Nombre, foto, actividad
                                                          repositorios, coherencia

Mantenedor de código      Revisar tu Pull Request              Quién eres, experiencia
abierto                                            previa, otras contribuciones

Compañero de equipo       Conocerte antes de colaborar        Rol, ubicación, proyectos

Colaborador ocasional     Decidir si responde tu mensaje       Señales de actividad y
                                                          seriedad

Tú mismo                  Revisar tu propia presencia          Coherencia con tu marca
                                                          personal
```

Esta tabla es importante porque define el criterio: el perfil no se escribe «para quedar bien», se escribe para que cada visitante encuentre rápidamente la información que busca.

### 1.3. El perfil como continuidad del trabajo

Uno de los aspectos que distingue a GitHub de un currículum en papel es que el perfil no es una declaración: es una ventana al trabajo real.

```text
Perfil declarativo                 Perfil de GitHub
(cv en papel)                      (actividad verificable)
     │                                  │
     ├── «Tengo experiencia            ├── Tus commits tienen fecha,
     │    en Python»                   │   autor y repositorio
     │                                 │
     ├── «He trabajado                 ├── Tus Pull Requests muestran
     │    en equipo»                   │   código revisado por otros
     │                                 │
     └── «Me interesa                  ├── Tus estrellas y repositorios
         la documentación»             │   públicos reflejan intereses
```

Por eso la coherencia entre lo que declaras (nombre, biografía) y lo que haces (actividad) es el verdadero valor del perfil. Un perfil con biografía impecable y cero actividad transmite menos que un perfil discreto con actividad constante.

---

## 2. Elementos del perfil

Este es el inventario completo de elementos. No todos hay que completarlos: la sección 4 indica cuáles son obligatorios, cuáles recomendables y cuáles opcionales.

```text
Elementos del perfil
       │
       ├── AVATAR (foto)
       │      Imagen circular de 264x264 píxeles como medida recomendada.
       │      Aparece en tu página, en tus comentarios, en tus commits
       │      y en las notificaciones.
       │
       ├── NOMBRE DE USUARIO (URL)
       │      github.com/TU_USUARIO
       │      No editable sin consecuencias (se explicó en el capítulo 01).
       │      Aparece en toda tu actividad.
       │
       ├── NOMBRE REAL
       │      El nombre con el que te presentas.
       │      Puede ser distinto del nombre de usuario.
       │      Aparece en tu página de perfil y en la firma de actividad.
       │
       ├── BIOGRAFÍA
       │      Una o dos líneas bajo tu nombre.
       │      Máximo recomendado: una frase clara.
       │
       ├── UBICACIÓN
       │      Ciudad o región.
       │      Útil para colaboración remota y contexto horario.
       │
       ├── SITIO WEB
       │      Enlace a tu portafolio, blog o página personal.
       │
       ├── ORGANIZACIONES
       │      Las organizaciones a las que perteneces y que
       │      decidas mostrar públicamente.
       │
       ├── ACTIVIDAD PÚBLICA
       │      Commits, Pull Requests, Issues, estrellas, forks.
       │      Visible según tu configuración de visibilidad.
       │
       ├── SEGUIDORES Y SEGUIDOS
       │      Personas que te siguen y a quienes sigues tú.
       │
       ├── README DEL PERFIL
       │      Un repositorio especial con tu nombre de usuario
       │      que se muestra en la parte superior del perfil.
       │      Contenido libre en Markdown (se explica en el punto 7).
       │
       └── PINS (repositorios destacados)
              Hasta 6 repositorios que fijas manualmente
              en la parte superior de tu perfil.
```

### 2.1. Relación entre elementos

```text
                    ┌──────────────────────────────┐
                    │        TU PERFIL             │
                    └──────────────┬───────────────┘
                                   │
        ┌──────────────────────────┼──────────────────────────┐
        │                          │                          │
        ▼                          ▼                          ▼
  IDENTIDAD                    TRABAJO                     RELACIONES
        │                          │                          │
  · Avatar                   · Repositorios            · Organizaciones
  · Nombre real              · Commits                 · Seguidores
  · Biografía                · Pull Requests           · Seguidos
  · Ubicación                · Estrellas               · Contribuciones
  · Sitio web                · README del perfil
  · Nombre de usuario        · Pines destacados
```

Los tres bloques se complementan: identidad sin trabajo es una ficha vacía, trabajo sin identidad es anónimo, relaciones sin identidad no construyen red.

---

## 3. Qué es público y qué es privado

Antes de escribir nada en el perfil, conviene tener claro el mapa de visibilidad. Este es un punto de seguridad, no solo de presentación.

```text
DATOS PÚBLICOS (cualquiera con el enlace puede verlos)
   │
   ├── Nombre de usuario (URL)
   ├── Nombre real (si lo completaste)
   ├── Biografía, ubicación, sitio web
   ├── Avatar
   ├── Repositorios públicos
   ├── Actividad pública (commits en repos públicos, PRs, issues)
   ├── Estrellas y favoritos públicos
   ├── Lista de seguidores y seguidos
   └── Organizaciones visibles

DATOS PRIVADOS (solo tú, salvo compartición explícita)
   │
   ├── Correo electrónico verificado
   ├── Contraseña
   ├── Repositorios privados
   ├── Actividad en repositorios privados
   ├── Configuración de la cuenta
   ├── Sesiones activas y 2FA
   └── Organizaciones donde no quieres aparecer
```

Consecuencias prácticas:

* Lo que escribes en la biografía es público para siempre (aunque lo cambies, versiones antiguas pueden haber sido indexadas por buscadores).
* Tu actividad en repositorios públicos queda asociada a tu nombre de usuario.
* Puedes ocultar o filtrar parte de la actividad desde la configuración de privacidad (se toca en el capítulo siguiente, 03-configuracion-basica).

Regla sencilla:

> **No escribas en el perfil información que no te gustaría ver en una portada pública, porque esa página es exactamente eso: una portada pública.**

---

## 4. Editar el perfil paso a paso

### 4.1. Diagrama de acceso

```text
Página principal de GitHub
       │
       │ pulsa tu avatar (esquina superior derecha)
       ▼
Menú desplegable
       │
       ├── Tu perfil      →  ver cómo se ve a los demás
       │
       └── Settings       →  editar todo
                │
                ▼
        Página de configuración
                │
                ├── Public profile   →  nombre, bio, foto, ubicación,
                │                      sitio web, organizaciones
                │
                ├── Account          →  usuario, correo, contraseña
                │
                ├── Security         →  2FA, sesiones (capítulo 05)
                │
                └── Emails, Billing, Notificaciones, etc.
```

### 4.2. Procedimiento de edición

1. Abre el menú de tu avatar (esquina superior derecha).
2. Selecciona **Settings**.
3. En el menú lateral, selecciona **Profile** (en la configuración de la cuenta) o **Public profile** (para los datos visibles públicamente, según la interfaz vigente; ambas rutas llevan a los mismos campos en la versión actual).
4. Verás los campos editables:

```text
Campos del perfil público
   │
   ├── Name                    →  Nombre real
   │
   ├── Public email            →  Correo que decides mostrar (opcional)
   │
   ├── Bio                     →  Biografía (máximo recomendado: 160 caracteres)
   │
   ├── Company                 →  Empresa o proyecto principal
   │
   ├── Location                →  Ciudad
   │
   ├── Website                 →  URL personal
   │
   ├── Social accounts         →  Enlaces a redes profesionales
   │
   ├── Display email address  →  Mostrar u ocultar el correo en el perfil
   │
   └── Avatar                  →  Foto (se explica en el punto 5)
```

5. Pulsa **Update profile** (o el botón equivalente de guardado) para aplicar los cambios.

### 4.3. Recomendaciones campo por campo

| Campo | Obligatorio | Recomendación |
|---|---|---|
| Nombre real | No | Sí: es lo que leen las personas |
| Correo público | No | Casi siempre no: puedes recibir spam |
| Biografía | No | Sí: una frase clara de qué haces |
| Compañía | No | Si trabajas en algo, ponlo |
| Ubicación | No | Sí si buscas trabajo remoto o local |
| Sitio web | No | Sí si tienes portafolio o blog |
| Redes sociales | No | Solo las profesionales |

---

## 5. La foto de perfil

### 5.1. Por qué importa

La foto aparece en todos tus actos en la plataforma: comentarios, Pull Requests, commits, notificaciones. Es el elemento visual que asocian contigo.

```text
Dónde aparece tu avatar
   │
   ├── Tu página de perfil
   ├── Comentarios en Issues y Pull Requests
   ├── Autoría de cada commit
   ├── Lista de colaboradores de un repositorio
   ├── Menciones (@tu-usuario)
   └── Notificaciones y correos de GitHub
```

### 5.2. Opciones de foto

```text
Opción A: Foto personal
   │
   ├── Ventaja: genera cercanía y confianza
   ├── Riesgo: privacidad (algunas personas prefieren no)
   └── Consejo: retrato sencillo, fondo neutro, buena luz

Opción B: Iniciales o avatar generado
   │
   ├── Ventaja: privacidad completa
   ├── Desventaja: menos cercanía
   └── GitHub genera unas iniciales automáticamente si no subes foto

Opción C: Logo o identidad de marca
   │
   ├── Ventaja: coherencia con portafolio o proyecto
   ├── Desventaja: para perfil personal individual resta cercanía
   └── Adecuado si tu actividad es de marca o producto
```

### 5.3. Aspectos técnicos

* Formato recomendado: PNG o JPG.
* Medida recomendada: 264x264 píxeles o superior (cuadrada).
* GitHub recorta la imagen en círculo: no pongas elementos importantes en las esquinas.

### 5.4. Accesibilidad

La foto de perfil también es información para tecnologías de asistencia. Si subes una imagen, completa el texto alternativo cuando GitHub lo solicite (en contextos donde aplique). Y si usas iniciales, asegúrate de que el nombre real esté escrito correctamente: es lo que leen quienes no ven la imagen.

---

## 6. La biografía

### 6.1. Qué es

Una línea corta (recomendado hasta 160 caracteres) que aparece bajo tu nombre en el perfil.

### 6.2. Qué incluir

La biografía responde a tres preguntas en el menor espacio posible:

```text
Tres preguntas de la biografía
   │
   ├── ¿Qué haces?
   │      (rol o actividad principal)
   │
   ├── ¿En qué te especializas?
   │      (área concreta: datos, web, documentación...)
   │
   └── ¿Qué te interesa o en qué trabajas?
          (proyecto o contexto actual)
```

### 6.3. Ejemplos

```text
Ejemplos de biografías claras
─────────────────────────────────────────────
«Estudiante de ingeniería. Aprendo Python y
documentación técnica con proyectos abiertos.»

«Desarrolladora de datos. Python, SQL y
visualización. Me interesa la educación con datos.»

«Docente. Enseño fundamentos de programación y
sobre Git desde cero.»

«Ingeniero de software. Infraestructura como
código y automatización con CI/CD.»
```

```text
Ejemplos de biografías poco útiles
─────────────────────────────────────────────
«¡Hola mundo!»                       →  no dice qué haces
«Estudiante»                          →  demasiado vago
«Me encanta la tecnología»            →  cualquiera diría lo mismo
«;););)»                          →  no es información
«Busco trabajo»                       →  mejor decir en qué área
```

### 6.4. Errores frecuentes

* **Exceso de promesas:** «experto en todo» no es creíble y desalinea expectativas.
* **Datos sensibles:** no pongas teléfono, dirección ni correo personal en la biografía (el correo ya tiene su propio control de visibilidad).
* **Modismos efímeros:** evita frases de moda que envejecen mal.
* **Mayúsculas continuas:** leen mal y transmiten estrés.

---

## 7. El README del perfil

### 7.1. Qué es

GitHub permite crear un repositorio especial cuyo nombre coincide exactamente con tu nombre de usuario. El README (archivo `README.md`) de ese repositorio se muestra en la parte superior de tu perfil público.

```text
Requisitos del README de perfil
   │
   ├── El repositorio se llama exactamente como tu usuario
   │      (ejemplo: si tu usuario es maria-lopez,
   │       el repositorio debe ser maria-lopez/maria-lopez)
   │
   ├── Debe ser público
   │
   └── Su archivo README.md aparece en tu página de perfil
```

### 7.2. Para qué sirve

Es la espacio de tu perfil para información que no cabe en la biografía: presentación detallada, enlaces organizados, proyectos destacados, cómo contactarte profesionalmente.

```text
Estructura típica de un README de perfil
─────────────────────────────────────────────
# Hola, soy [nombre]

Presentación en 2-3 líneas.

## Qué hago
- Áreas de trabajo
- Herramientas principales

## Proyectos destacados
- Enlace 1 con descripción
- Enlace 2 con descripción

## Cómo contactarme
- Correo profesional
- Sitio web
```

### 7.3. Cuándo crearlo

No es obligatorio. Conviene cuando:

* tu perfil empieza a ser tu portafolio (estás buscando trabajo o quieres visibilidad);
* tienes varios proyectos que quieres presentar de forma ordenada;
* necesitas enlaces organizados que no entran en la biografía.

Si estás empezando, puedes posponerlo hasta tener contenido que mostrar. La sección 14 (documentación) enseña Markdown con detalle, y puedes volver a este punto entonces.

---

## 8. Actividad y visibilidad

### 8.1. Qué es la actividad pública

La actividad es el rastro de tus acciones en repositorios públicos:

```text
Actividad pública
   │
   ├── Commits en repositorios públicos
   ├── Pull Requests abiertos y fusionados
   ├── Issues abiertos y comentados
   ├── Repositorios creados (públicos)
   ├── Estrellas otorgadas
   ├── Forks de proyectos
   └── Contribuciones a proyectos de terceros
```

### 8.2. Control de visibilidad

Puedes decidir qué parte de tu actividad es visible y cuál no, y si tu correo aparece asociado a tu actividad. Esto se configura desde la configuración de la cuenta (capítulo 03 de esta sección).

La configuración de visibilidad tiene dos planos:

```text
Plano 1: visibilidad de tu actividad
   │
   ├── Puedes ocultar repositorios individuales
   │      (marcarlos como privados o excluirlos del perfil)
   │
   └── Puedes limitar qué se muestra en tu perfil

Plano 2: asociación correo-actividad
   │
   └── GitHub exige un correo asociado a los commits;
       puedes elegir si ese correo se muestra públicamente
       o si GitHub muestra un noreply en su lugar
```

El segundo punto es importante por privacidad: GitHub ofrece una dirección de correo noreply generada por la plataforma para que tus commits no expongan tu correo real. La sección 20 (seguridad) profundiza en esto; conviene saber que existe desde ya.

### 8.3. Contribuciones y el cuadro de actividad

Tu perfil muestra un calendario de contribuciones (el conocido «cuadro verde») que registra tu actividad en repositorios públicos durante el último año. Es un indicador de constancia, no de calidad: la comunidad lo lee como «¿esta persona está activa?», no como «¿esta persona es buena?».

```text
Lectura profesional del cuadro de contribuciones
   │
   ├── Señal positiva: actividad sostenida y constante
   │
   ├── Señal neutra: ausencia de actividad no prueba nada
   │      (una persona puede trabajar en repositorios privados
   │       de su empresa y no aparecer)
   │
   └── Conclusión: es un dato de contexto, no una métrica
          de competencia
```

---

## 9. Errores comunes

### Error 1: Perfil completamente vacío

**Qué ocurre:** la persona se registra, crea repositorios y nunca toca el perfil.

**Consecuencia:** quien llega a tu trabajo (un PR, un commit) no tiene contexto sobre quién eres. En contextos profesionales, un perfil vacío resta confianza.

**Solución:** completar al menos nombre real y biografía: cinco minutos.

### Error 2: Biografía genérica o exagerada

**Qué ocurre:** «Senior developer, experto en todo» con actividad mínima.

**Consecuencia:** la desconexión entre declaración y trabajo se detecta fácilmente y daña la credibilidad.

**Solución:** declarar solo lo que tu actividad respalda. La biografía crece con el trabajo.

### Error 3: Foto inadecuada o ausente

**Qué ocurre:** avatar con imagen de baja calidad, de perfil no profesional, o sin subir foto.

**Consecuencia:** menor reconocimiento en comentarios y Pull Requests.

**Solución:** retrato sencillo o iniciales; nada de imágenes de meme en un perfil profesional.

### Error 4: Exponer datos sensibles

**Qué ocurre:** poner teléfono, dirección o correo personal en la biografía o en el README del perfil.

**Consecuencia:** exposición a spam, phishing y suplantación.

**Solución:** usar el correo noreply de GitHub o un correo profesional; nunca datos de contacto directos en campos públicos.

### Error 5: Cambiar el nombre de usuario pensando en «mejorar el perfil»

**Qué ocurre:** se cambia el usuario sin evaluar consecuencias.

**Consecuencia:** enlaces rotos, referencias en commits antiguos y en otras plataformas.

**Solución:** evaluar el cambio como una migración (qué enlaces existen, qué plataformas lo referencian) antes de ejecutarlo.

### Error 6: Esperar a tener «algo que mostrar» para configurar el perfil

**Qué ocurre:** el perfil queda vacío durante meses.

**Consecuencia:** las personas que llegan a tu trabajo no encuentran contexto.

**Solución:** configurar lo mínimo (nombre, biografía, foto) el primer día; el contenido crece después.

---

## 10. Práctica guiada

### Objetivo

Configurar un perfil público profesional y verificar cómo se ve.

### Paso 1: Preparar el contenido

Antes de abrir GitHub, escribe en un borrador:

```text
Nombre real: __________________________
Biografía (una frase): __________________________
Ubicación: __________________________
Sitio web (si tienes): __________________________
```

### Paso 2: Acceder a la edición

1. Abre GitHub y pulsa tu avatar (esquina superior derecha).
2. Selecciona **Settings**.
3. Ve a la sección de perfil público.

### Paso 3: Rellenar los campos

1. Escribe tu nombre real.
2. Escribe la biografía.
3. Añade ubicación y sitio web si aplican.
4. Decide si muestras el correo público (recomendación: no).

### Paso 4: La foto

1. Sube la foto elegida o déjalo para después (puedes usar las iniciales).
2. Verifica que el recorte circular no corte elementos importantes.

### Paso 5: Guardar y verificar

1. Pulsa el botón de actualización.
2. Abre `github.com/tu-usuario` en otra pestaña.
3. Comprueba que nombre, biografía, ubicación y foto se ven correctamente.

### Resultado esperado

Tu perfil público muestra una identidad clara y coherente: nombre, biografía útil y datos de contexto.

### Conclusión esperada

El perfil es la traducción de tu identidad profesional a la plataforma. Con cinco minutos de configuración dejas de ser «un usuario más» y pasas a ser una persona identificable detrás de tu trabajo.

---

## 11. Nivel profesional

### 11.1. Marca personal y coherencia

En el nivel profesional, el perfil se gestiona como parte de una marca personal coherente:

```text
Coherencia de marca personal
       │
       ├── Sitio web personal
       │      └── Misma propuesta que la biografía de GitHub
       │
       ├── LinkedIn u otra red profesional
       │      └── Mismo nombre y misma línea de actividad
       │
       ├── GitHub
       │      └── Biografía y README alineados con los anteriores
       │
       └── Repositorios públicos
              └── Temas coherentes con lo declarado
```

La coherencia no significa idéntica: cada plataforma tiene su registro. Significa que alguien que te encuentre en dos de ellas deduce lo mismo sobre tu actividad.

### 11.2. El perfil como evidencia en procesos de selección

En procesos de selección técnica, el perfil se revisa con criterios concretos:

```text
Qué se valora en un perfil técnico
   │
   ├── Actividad constante (no masiva: constante)
   ├── Repositorios con README claro
   ├── Pull Requests a proyectos de terceros (colaboración real)
   ├── Evolución visible (proyectos que avanzan, no solo iniciales)
   ├── Perfil actualizado (biografía acorde al trabajo actual)
   └── Comunicación clara en Issues y comentarios
```

Ninguno de estos elementos requiere un perfil elaborado: requiere un perfil honesto y actividad real.

### 11.3. Perfil en el contexto de organizaciones

Cuando perteneces a una organización, tu perfil muestra ese vínculo (si la organización es visible). Esto tiene implicaciones:

```text
Implicaciones del vínculo organización-perfil
   │
   ├── Señal de pertenencia
   │      └── «Trabaja en X» se lee como contexto profesional
   │
   ├── Puedes ocultar la membresía si prefieres discreción
   │
   └── En organizaciones con SSO/Enterprise,
       el vínculo puede estar gestionado por políticas
```

La política de cuándo mostrar u ocultar membresías la decide cada organización (sección 18).

### 11.4. Errores profesionales

* **Perfiles con actividad artificial:** generar commits vacíos solo para llenar el cuadro de contribuciones se detecta y daña la credibilidad.
* **Biografía desactualizada:** sigues declarando un rol que ya no ejerces.
* **Exposición de información interna:** mencionar en el README del perfil detalles confidenciales del trabajo actual (métricas, clientes, roadmaps).

---

## 12. Resumen

En este capítulo aprendiste que:

* el perfil es la página pública `github.com/tu-usuario` y actúa como cartilla de presentación profesional verificable;
* los elementos se agrupan en tres bloques: identidad (foto, nombre, biografía, ubicación), trabajo (repositorios, actividad, README, pines) y relaciones (organizaciones, seguidores);
* la regla de visibilidad es simple: lo que escribes en el perfil es público, y el correo y los datos de contacto tienen controles propios;
* la edición ocurre en Settings → perfil público, y con completar nombre, biografía y foto se tiene un perfil funcional;
* la foto debe ser cuadrada, con recorte circular, y puede ser personal o iniciales según tu criterio de privacidad;
* la biografía responde tres preguntas en una frase: qué haces, en qué te especializas y en qué trabajas;
* el README del perfil (repositorio con el nombre de tu usuario) permite una presentación extendida en Markdown;
* el cuadro de contribuciones es un indicador de constancia, no de calidad;
* los errores más comunes (perfil vacío, biografía exagerada, datos sensibles, cambio impulsivo de usuario) se evitan con una configuración inicial de cinco minutos;
* a nivel profesional, el valor del perfil está en la coherencia entre lo declarado y el trabajo real.

La idea principal es:

> **El perfil no se decora: se alinea con tu trabajo. Su función es dar contexto a quien llega a tu código, y su calidad depende de la honestidad y la constancia, no del diseño.**

---

## Próximo paso

Ya tienes perfil público configurado.

El siguiente paso es recorrer la configuración básica de la cuenta: correos, idioma, apariencia y notificaciones, para que la plataforma trabaje a tu favor desde el primer día.

Continúa con:

[`03-configuracion-basica.md`](03-configuracion-basica.md)
