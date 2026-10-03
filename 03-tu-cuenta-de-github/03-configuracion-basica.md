# Configuración básica

## Introducción

Ya tienes una cuenta con perfil público configurado. Pero por defecto, GitHub trabaja con ajustes genéricos: idioma inglés, apariencia clara, notificaciones activas y correo asociado sin filtrar.

La configuración básica es el conjunto de ajustes que determinan cómo se comporta la plataforma a diario: qué idioma ves, qué aspecto tiene la interfaz, qué correos llegan a tu bandeja, qué correo se asocia a tus commits y qué información tuya es visible.

Configurar esto una vez bien evita dos problemas típicos: la bandeja de correo saturada de notificaciones irrelevantes y la exposición accidental del correo personal en commits públicos.

En este capítulo aprenderás:

* a localizar y recorrer la página de Settings;
* a gestionar correos electrónicos (añadir, verificar, principal, noreply);
* a elegir idioma, zona horaria y apariencia;
* a configurar notificaciones sin volverse loco;
* a controlar la visibilidad de tu actividad y tu correo;
* a entender qué configuración conviene al empezar;
* los errores más comunes y sus soluciones.

No necesitas instalar nada. Todo ocurre en el navegador.

---

## Mapa conceptual de este capítulo

```text
Configuración básica de GitHub
       │
       ├── 1. Mapa de Settings
       │        ├── Dónde está
       │        ├── Secciones principales
       │        └── Qué se configura en cada una
       │
       ├── 2. Correos electrónicos
       │        ├── Correos vinculados y verificados
       │        ├── Correo principal
       │        ├── Añadir y verificar un correo
       │        ├── Notificaciones por correo
       │        └── DIRECCIÓN NO-REPLY (clave para privacidad)
       │
       ├── 3. Idioma, zona horaria y apariencia
       │
       ├── 4. Notificaciones
       │        ├── Tipos de notificación
       │        ├── Por canal (correo, web, móvil)
       │        ├── Suscripciones automáticas
       │        └── Estrategia recomendada
       │
       ├── 5. Visibilidad y privacidad
       │        ├── Actividad pública
       │        ├── Correo en commits
       │        └── Datos del perfil
       │
       ├── 6. Preferencias de cuenta
       │        ├── Teclado
       │        ├── Fecha y formato
       │        └── Límites y borrado de datos
       │
       ├── 7. Errores comunes
       │
       ├── 8. Práctica guiada
       │
       ├── 9. Nivel profesional
       │        ├── Cuentas de empresa
       │        ├── Múltiples identidades
       │        └── Políticas de configuración
       │
       └── 10. Resumen y siguiente paso
```

---

## 1. Mapa de Settings

### 1.1. Cómo llegar

```text
Cualquier página de GitHub
       │
       │ pulsa tu avatar (esquina superior derecha)
       ▼
Menú desplegable
       │
       └── Settings
              │
              ▼
       Página de configuración con menú lateral
```

### 1.2. Estructura del menú lateral

El menú agrupa la configuración en bloques. Este es el mapa completo con la función de cada sección:

```text
SETTINGS
   │
   ├── PUBLIC PROFILE        →  Todo lo visible públicamente:
   │                            nombre, bio, foto, correo visible,
   │                            actividad, pines, README.
   │                            (Capítulo 02 de esta sección)
   │
   ├── ACCOUNT               →  Usuario, correo principal,
   │                            contraseña, idioma regional,
   │                            zonas horarias, cambio de nombre,
   │                            desactivación o borrado de cuenta.
   │
   ├── EMAILS                →  Correos vinculados, verificar,
   │                            correo de notificaciones.
   │                            (Punto 2 de este capítulo)
   │
   ├── PASSWORD AND AUTHENTICATION
   │                         →  Contraseña, sesión iniciada.
   │                            La autenticación de dos factores
   │                            vive en SECURITY. (Capítulo 05)
   │
   ├── SSH AND GPG KEYS      →  Claves públicas para trabajar
   │                            con Git desde la terminal.
   │                            (Capítulo 06 de la sección 07)
   │
   ├── SESSIONS              →  Sesiones activas y dispositivos.
   │
   ├── NOTIFICATIONS         →  Preferencias de notificación.
   │                            (Punto 4 de este capítulo)
   │
   ├── BILLING AND PLANS     →  Planes y facturación.
   │                            (Capítulo 04 de esta sección)
   │
   ├── DANGEROUS ZONE        →  Zona de acciones irreversibles:
   │                            cambio de usuario, desactivación,
   │                            borrado de cuenta, transferencia
   │                            de repositorios.
   │
   └── (Secciones adicionales según el menú vigente:
        accesibilidad, correos patrocinados, etc.)
```

### 1.3. Principio de lectura

Antes de pulsar cualquier botón en Settings, aplica este principio:

> **Separa las dos clases de cambios: los que se pueden deshacer (idioma, apariencia, notificaciones) y los que no (borrado de cuenta, cambio de nombre de usuario, eliminación de claves). Con los primeros experimenta; con los segundos, lee dos veces.**

```text
Cambios reversibles vs. irreversibles
─────────────────────────────────────────────────────
Reversibles (se pueden volver atrás)     Irreversibles o costosos
─────────────────────────────────────────────────────
Idioma de la interfaz                    Borrar la cuenta
Apariencia (claro/oscuro)                Cambiar el nombre de usuario
Notificaciones                           Eliminar una clave SSH
Correo de notificaciones                 Transferir un repositorio
Pines del perfil                         Perder el historial de actividad
Añadir un correo nuevo                   (si se desactiva la cuenta)
```

---

## 2. Correos electrónicos

Este es el apartado más importante de la configuración básica y el que más problemas causa si se ignora.

### 2.1. Conceptos fundamentales

GitHub trabaja con varias ideas distintas alrededor del correo. Distinguirlas evita confusiones:

```text
Conceptos de correo en GitHub
   │
   ├── CORREO VINCULADO
   │      Un correo que añades a la cuenta. Puede haber varios.
   │      Todos deben estar verificados para que la cuenta
   │      esté completa.
   │
   ├── CORREO PRINCIPAL (primary)
   │      El correo al que llegan las notificaciones y que
   │      identifica tu cuenta. Solo puede haber uno.
   │
   ├── CORREO DE NOTIFICACIONES
   │      A dónde se envían los avisos de la plataforma.
   │      Coincide con el principal salvo que lo cambies.
   │
   ├── DIRECCIÓN NO-REPLY DE GITHUB
   │      Una dirección generada por GitHub de la forma:
   │         ID+usuario@users.noreply.github.com
   │      Sirve para que tus commits no revelen tu correo real.
   │
   └── CORREO EN LOS COMMITS
         El correo que queda grabado en cada commit que haces.
         Es distinto del correo de la cuenta: lo decide Git,
         no GitHub (se explica abajo y en detalle en Git).
```

### 2.2. Diagrama: qué correo usa cada acción

```text
                    ┌────────────────────────┐
                    │   TU CUENTA EN GITHUB  │
                    └───────────┬────────────┘
                                │
        ┌───────────────────────┼───────────────────────┐
        │                       │                       │
        ▼                       ▼                       ▼
  Notificaciones          Identidad pública         Tus commits
  (avisos de la           (perfil, actividad)       (escritos con Git)
   plataforma)                                       │
        │                       │                    │
        ▼                       ▼                    ▼
  Correo principal        El correo público      El correo que
  o de notificaciones     que decidiste mostrar   configuraste en
  (tú eliges)             o ninguno               git config
                                                   (tú eliges,
                                                   ver sección 6)
```

La separación es crucial: **puedes recibir avisos en un correo, mostrar otro en el perfil y firmar commits con un tercero** (o con la noreply). Muchos problemas de privacidad vienen de mezclar los tres.

### 2.3. Añadir y verificar un correo

1. Ve a **Settings → Emails**.
2. En el campo de añadir correo, escribe la dirección.
3. Pulsa **Add**.
4. GitHub envía un mensaje de verificación a esa dirección.
5. Abre el correo y pulsa el enlace de verificación (o introduce el código, según el método vigente).
6. El correo aparece como verificado.

```text
Estados de un correo
   │
   ├── Sin verificar
   │      →  No puede ser principal; no genera confianza.
   │
   └── Verificado
          →  Puede ser principal y recibir notificaciones.
```

**Por qué exige verificación:** para que nadie vincule un correo ajeno a su cuenta (lo que permitiría suplantación y robo de cuenta a través de la recuperación).

### 2.4. Cambiar el correo principal

En **Settings → Emails** puedes elegir cuál es el principal. Al cambiarlo:

* las notificaciones empiezan a llegar al nuevo;
* el nuevo pasa a ser la referencia de la cuenta;
* el anterior queda vinculado (puedes mantenerlo o quitarlo).

### 2.5. Correo de notificaciones independiente

Puedes separar el correo principal del correo de avisos si, por ejemplo, quieres recibir las notificaciones de GitHub en un correo de trabajo distinto del personal. Esto se configura en las preferencias de notificación.

### 2.6. La dirección noreply: privacidad de los commits

GitHub genera para cada usuario una dirección de este estilo:

```text
12345678+mariadev@users.noreply.github.com
```

Donde `12345678` es un identificador numérico de tu cuenta (mantener el identificador evita que cambies el correo si cambias de usuario).

**Cómo activarla para tus commits:**

1. Ve a **Settings → Emails**.
2. Busca la casilla de uso de la dirección noreply para commits (el texto exacto varía con la interfaz: «Block command line pushes that expose my email» y «Keep my email addresses private»).
3. Activa la privacidad del correo.
4. Copia la dirección noreply generada.
5. Configúrala en tu equipo como correo de Git (se verá en la sección 07; el comando es `git config --global user.email "tu-id+usuario@users.noreply.github.com"`).

**Qué protege esto:** que cualquier persona que vea un commit pueda buscar tu correo real. Los commits son públicos y permanentes; el correo asociado viaja con ellos.

```text
Sin noreply                         Con noreply
─────────────────────────           ─────────────────────────
git log muestra:                    git log muestra:
  Autor: María López                Autor: María López
  <maria.correo.personal@           <12345678+mariadev@
   gmail.com>                        users.noreply.github.com>
        │                                    │
        ▼                                    ▼
Cualquiera puede copiar           El correo real no aparece
tu correo y enviarte spam         en ningún commit público
o intentar phishing
```

### 2.7. Bloqueo de empujes que exponen el correo

GitHub ofrece una opción adicional: rechazar (bloquear) los empujes (`push`) realizados desde la línea de comandos con un correo no protegido. Si la activas, un `git push` con tu correo personal no verificado/no noreply será rechazado. Es una red de seguridad: te avisa antes de que expongas el correo.

Recomendación: actívala cuando ya hayas configurado la noreply en tu equipo.

### 2.8. Quitar un correo

Puedes eliminar correos vinculados, con dos condiciones:

* no puedes eliminar el correo principal (primero cambia el principal);
* no puedes eliminar el único correo verificado (añade otro antes).

---

## 3. Idioma, zona horaria y apariencia

### 3.1. Idioma regional

En **Settings → Account** (o en la sección correspondiente del menú vigente) puedes elegir el idioma de la interfaz.

```text
Idioma de la interfaz
   │
   ├── Afecta a: menús, botones, textos de la plataforma
   │
   ├── No afecta a:
   │      ├── El contenido de los repositorios (depende de cada
   │      │   repositorio)
   │      ├── El idioma de tus commits (depende de ti)
   │      └── Las fechas (se configuran aparte)
   │
   └── Consejo: elige el idioma en el que entiendas los mensajes
          de error; te ahorrará malentendidos.
```

### 3.2. Zona horaria

La zona horaria determina cómo muestra GitHub las fechas de actividad (commits, comentarios, eventos).

```text
Por qué importa la zona horaria
   │
   ├── Tu cuadro de contribuciones agrupa los días según tu
   │   zona horaria configurada.
   │
   ├── Las fechas de commits en la interfaz se muestran
   │   en tu hora local.
   │
   └── Un desajuste hace que actividad de la tarde apareza
       como del día siguiente (o al revés).
```

**Consejo:** configúrala en cuanto crees la cuenta; después de un tiempo con actividad, cambiarla produce confusión al revisar fechas históricas.

### 3.3. Apariencia (tema)

GitHub ofrece modos claro y oscuro, y a menudo la opción de seguir la configuración del sistema operativo.

```text
Opciones típicas de apariencia
   │
   ├── Light     →  fondo claro
   ├── Dark      →  fondo oscuro
   └── System    →  sigue al sistema operativo
```

Criterio de elección: el que menos fatiga visual te cause en sesiones largas de lectura de código. No hay valor académico en uno u otro.

### 3.4. Otras preferencias de presentación

Dentro de las preferencias de cuenta encontrarás también:

* formato de fecha y hora;
* atajos de teclado (GitHub tiene atajos propios: tecla `?` muestra la lista en la interfaz web);
* ajustes regionales (calendario, primera semana del año).

---

## 4. Notificaciones

La configuración de notificaciones es la que más mejora la experiencia diaria. Sin configurar, GitHub puede inundarte de correos.

### 4.1. Tipos de eventos que generan notificación

```text
Eventos notificables
   │
   ├── Repositorios que sigues
   │      ├── Issues abiertos o comentados
   │      ├── Pull Requests abiertos, comentados, fusionados
   │      └── Releases publicados
   │
   ├── Tu propia actividad
   │      ├── Respuestas a tus comentarios
   │      ├── Menciones (@tu-usuario)
   │      ├── Asignaciones (issues o PRs asignados a ti)
   │      └── Estados de tus Pull Requests (aprobado, rechazado)
   │
   ├── Organizaciones
   │      ├── Invitaciones a repositorios u organizaciones
   │      ├── Cambios de miembros y roles
   │      └── Avisos administrativos
   │
   ├── Cuenta
   │      ├── Inicios de sesión desde nuevos dispositivos
   │      ├── Alertas de seguridad
   │      └── Avisos de facturación (si aplica)
   │
   └── Producto
          ├── Novedades de GitHub (puedes desactivarlas)
          └── Correos promocionales
```

### 4.2. Canales de entrega

Cada evento puede llegar por varios canales:

```text
Canales
   │
   ├── CORREO          →  llega a tu bandeja (puede ser excesivo)
   │
   ├── WEB (en GitHub) →  el centro de notificaciones en la
   │                      plataforma: el icono de campana
   │
   ├── MÓVIL           →  si usas la aplicación con avisos
   │                      activos
   │
   └── PUSH            →  notificaciones del navegador
                          (si las permites)
```

### 4.3. Por qué llega tanto correo: las suscripciones automáticas

Este es el punto que confunde a todo el mundo:

```text
Regla de suscripción
──────────────────────────────────────────────
Automáticamente quedas SUSCRITO a un hilo cuando:
   │
   ├── Abres un issue o un Pull Request
   ├── Comentas en un issue o Pull Request
   ├── Te mencionan (@tu-usuario)
   ├── Eres asignado al asunto
   ├── Haces fork de un repositorio (ciertos eventos)
   └── Participas de cualquier forma en la conversación

Mientras estés suscrito, cada nuevo comentario te genera
notificación. Muchas no las quieres.
```

### 4.4. Desuscribirse (una por una)

Cada notificación de correo lleva un enlace de **unsubscribe / desuscribirse**, y dentro de la plataforma puedes gestionar tus suscripciones desde el centro de notificaciones. Cuando un hilo ya no te interesa, desuscríbete: es la acción que más limpieza produce.

### 4.5. Estrategia recomendada para empezar

```text
Configuración inicial sensata
──────────────────────────────────────────────
Por correo (bandeja):
   ✓  Asignaciones (issues/PRs asignados a ti)   →  SÍ
   ✓  Menciones                                   →  SÍ
   ✓  Respuestas a tus comentarios                →  SÍ
   ✓  Seguridad de la cuenta                      →  SÍ
   ✗  Actividad de repositorios que solo miras     →  NO
   ✗  Novedades de producto                        →  NO
   ✗  Correos promocionales                        →  NO

Por la campana de la plataforma:
   ✓  Todo lo anterior se centraliza aquí
   ✓  Revisar a diario sustituye 20 correos diarios
```

Con esta base, tu correo solo recibe lo que requiere acción tuya, y la campana de GitHub absorbe el resto.

### 4.6. Resumen de menú de notificaciones

**Settings → Notifications** presenta controles agrupados:

```text
Notificaciones: controles típicos
   │
   ├── Participación en conversaciones
   │      →  correo / web según corresponda
   │
   ├── Asignaciones y menciones
   │      →  siempre por correo recomendado
   │
   ├── Actualizaciones de repositorios
   │      →  mejor solo en la plataforma
   │
   ├── Novedades de GitHub
   │      →  desactivar al empezar
   │
   └── Resúmenes periódicos (digest)
          →  opcional: un correo con resumen en vez de
             correos individuales
```

---

## 5. Visibilidad y privacidad

### 5.1. Actividad pública

Desde la configuración puedes decidir qué parte de tu actividad es visible y si los repositorios nuevos nacen públicos o privados (esto último también se elige al crear cada repositorio).

```text
Decisiones de visibilidad
   │
   ├── ¿Mi actividad aparece en mi perfil?
   │      →  sí por defecto; puede limitarse
   │
   ├── ¿Los repositorios nuevos son públicos o privados?
   │      →  privado por defecto recomendado al empezar;
   │         se puede cambiar en cada creación
   │
   └── ¿Mi correo aparece asociado a la actividad?
          →  no si usas noreply (punto 2.6)
```

### 5.2. Recomendación inicial

```text
Al empezar
   │
   ├── Repositorios nuevos: PRIVADOS hasta que decidas publicar
   ├── Correo: NO-REPLY en los commits
   ├── Perfil: nombre y biografía sí; correo personal no
   └── Estrellas y «siguiendo»: puedes ocultarlas si no quieres
          mostrar tus gustos públicamente
```

### 5.3. Qué no controla esta configuración

Para no generar falsas expectativas:

```text
La configuración NO puede
   │
   ├── Hacer privado un repositorio ya público sin que
   │   desaparezcan sus copias (forks) en otros usuarios
   │
   ├── Borrar commits que otros ya clonaron
   │
   ├── Garantizar que algo publicado no se copió
   │
   └── Evitar que mencionen a tu usuario en público
```

**Lección:** lo que se publica una vez puede haberse copiado. La privacidad se protege antes de publicar, no después.

---

## 6. Preferencias de cuenta diversas

### 6.1. Nombre de usuario y datos de la cuenta

**Settings → Account** permite:

* ver y cambiar el nombre de usuario (con advertencias, ya vistas);
* cambiar el nombre real;
* ver fechas clave (creación de la cuenta);
* desactivar o borrar la cuenta (zona peligrosa, ver punto 6.4).

### 6.2. Contraseña

El cambio de contraseña está en **Password and authentication**. Buen momento para recordar:

```text
Buena contraseña
   │
   ├── Larga (16+ caracteres)
   ├── Frase de palabras o generada por gestor
   ├── Única (no reutilizada de otros sitios)
   └── Guardada en un gestor de contraseñas
```

El cambio de contraseña cierra las demás sesiones activas (opción disponible al cambiarla): útil si crees que alguien más la conoce.

### 6.3. Sesiones y dispositivos

**Settings → Sessions** muestra desde dónde tienes sesión iniciada:

```text
Qué revisar en sesiones
   │
   ├── ¿Reconoces todos los dispositivos y ubicaciones?
   │      →  si no, cierra la sesión y cambia la contraseña
   │
   └── ¿Hay sesiones viejas sin usar?
          →  ciérralas: reduce la superficie de ataque
```

### 6.4. Zona peligrosa: desactivar y borrar

```text
DESACTIVAR cuenta
   │
   ├── Efecto: el perfil desaparece públicamente
   ├── Reversible: al volver a iniciar sesión, se reactiva
   └── Uso: pausas largas, por privacidad temporal

BORRAR cuenta
   │
   ├── Efecto: elimina tu usuario, correos, llaves SSH/PGP,
   │           claves de API y tokens
   ├── No garantiza el borrado inmediato de clones o forks
   │           hechos por otros
   └── Irreversible: la acción más costosa de la plataforma
```

> **Advertencia:** nunca pulses «Delete account» como prueba. No hay «modo demo»; lo que se borra, se borra.

---

## 7. Errores comunes

### Error 1: Ignorar la configuración de correo

**Qué ocurre:** se crea la cuenta y no se toca nada. Llegan todos los correos posibles, o los commits exponen el correo personal.

**Consecuencia:** bandeja saturada y correo real visible en commits públicos.

**Solución:** configurar noreply y afinar notificaciones el primer día (puntos 2.6 y 4.5).

### Error 2: Dejar la zona horaria por defecto

**Qué ocurre:** la actividad se registra con otra zona horaria.

**Consecuencia:** el cuadro de contribuciones agrupa los días mal y las fechas de commits confunden.

**Solución:** ajustarla en cuanto se crea la cuenta.

### Error 3: Suscribirse por error y no desuscribirse

**Qué ocurre:** se comenta una vez en un hilo activo y llegan 30 correos.

**Consecuencia:** sensación de que «GitHub lanza spam», y la tentación de ignorar todo el correo (perdiendo alertas de seguridad).

**Solución:** desuscribirse de los hilos irrelevantes y dejar solo menciones y asignaciones en el correo.

### Error 4: Usar el correo personal en commits por costumbre

**Qué ocurre:** en el equipo local, Git quedó configurado con el correo personal antes de conocer la noreply.

**Consecuencia:** cada commit público arrastra el correo real.

**Solución:** cambiar `git config --global user.email` a la dirección noreply y verificar con `git config --global --get user.email`. Los commits antiguos ya publicados requieren revisión (se ve en secciones posteriores).

### Error 5: Creer que cambiar el correo de la cuenta cambia los commits antiguos

**Qué ocurre:** se cambia el correo en GitHub y se espera que los commits previos se actualicen.

**Consecuencia:** no ocurre: el correo de un commit queda grabado en su momento; cambiarlo implica reescribir historial (algo avanzado y riesgoso).

**Solución:** entender que la identidad de cada commit es la del momento en que se hizo.

### Error 6: Activar todas las notificaciones «por si acaso»

**Qué ocurre:** se activa todo para no perderse nada.

**Consecuencia:** fatiga de notificaciones; en pocas semanas, todo se marca como leído sin leer.

**Solución:** la regla de oro: en el correo solo lo que requiere tu acción.

---

## 8. Práctica guiada

### Objetivo

Dejar la cuenta con correo bien resuelto, notificaciones razonables y privacidad básica activa.

### Paso 1: Correos

1. Abre **Settings → Emails**.
2. Comprueba que tu correo está verificado.
3. Activa la privacidad del correo (noreply) y copia tu dirección noreply.
4. Decide si bloqueas los empujes que exponen el correo (recomendado tras configurar la noreply).

### Paso 2: Idioma y zona horaria

1. Ve a **Settings → Account** (o la sección equivalente).
2. Establece el idioma de la interfaz.
3. Establece tu zona horaria.
4. Revisa el formato de fecha y el tema de apariencia.

### Paso 3: Notificaciones

1. Ve a **Settings → Notifications**.
2. Deja el correo solo para: menciones, asignaciones, respuestas a tus comentarios y seguridad.
3. Desactiva novedades y promociones.
4. Activa el resumen periódico si está disponible y te resulta cómodo.

### Paso 4: Verificación final

Abre tu perfil en una pestaña anónima y comprueba:

```text
Checklist de verificación
   │
   ├── ¿Tu nombre y biografía se ven?                □
   ├── ¿Tu correo personal NO aparece en el perfil?  □
   ├── ¿La noreply está copiada para usarla en Git?  □
   ├── ¿Las notificaciones están afinadas?           □
   ├── ¿La zona horaria es la correcta?              □
   └── ¿Los repositorios nuevos nacen privados?      □
```

### Resultado esperado

Una cuenta que recibe solo las notificaciones que importan, con privacidad de correo activada y presentación coherente.

### Conclusión esperada

La configuración básica no se nota cuando está bien hecha: simplemente recibes solo lo que necesitas y nada se escapa por accidente.

---

## 9. Nivel profesional

### 9.1. Múltiples identidades

Un caso profesional frecuente: necesitas separar la actividad personal de la laboral (o de un proyecto concreto).

```text
Estrategias de separación
   │
   ├── Opción A: una sola cuenta bien configurada
   │      ├── Ventaja: historial único y coherente
   │      ├── Riesgo: mezclar proyectos
   │      └── Adecuada cuando tu marca personal es única
   │
   ├── Opción B: dos cuentas (personal + laboral)
   │      ├── Ventaja: separación total
   │      ├── Coste: mantener las dos activas y verificadas
   │      └── Adecuada cuando los contextos son incompatibles
   │         (ejemplo: trabajo gubernamental + proyecto propio)
   │
   └── Opción C: una cuenta con repositorios separados
          ├── Ventaja: simplicidad
          └── Adecuada en la mayoría de casos de desarrollo
```

**Advertencia:** tener dos cuentas obliga a dos gestores de sesión, dos claves SSH y dos correos noreply. Evalúa el coste antes de decidir.

### 9.2. Configuración en empresas (SSO)

En organizaciones con inicio de sesión único (SSO) o Enterprise Managed Users, algunas configuraciones dejan de ser individuales:

```text
Qué puede estar gestionado por la empresa
   │
   ├── Método de autenticación (SSO obligatorio)
   ├── Políticas de 2FA
   ├── Uso de tokens y claves SSH
   ├── Visibilidad de repositorios
   └── Algunos límites de la cuenta
```

Si tu cuenta pertenece a una organización gestionada, ciertos ajustes de **Settings** pueden estar bloqueados o dirigidos por políticas. Antes de «buscar» el botón que no aparece, comprueba si la organización tiene políticas activas (sección 18).

### 9.3. Estandarización en equipos

En equipos con personas nuevas, la configuración básica se convierte en una lista de entrada:

```text
Checklist de incorporación (ejemplo)
──────────────────────────────────────────────
[ ] Correo corporativo verificado
[ ] Noreply configurada en git config del equipo
[ ] 2FA activado (obligatorio en muchas organizaciones)
[ ] Zona horaria correcta
[ ] Notificaciones mínimas
[ ] Sesiones revisadas tras la incorporación
```

Muchas organizaciones automatizan parte de esto con políticas; pero en equipos pequeños, esta lista manual evita los problemas típicos (correos expuestos, alarmas perdidas).

### 9.4. Revisión periódica

La configuración no es «una vez y olvidado»:

```text
Revisión recomendada (trimestral o al cambiar de rol)
   │
   ├── ¿Sigue vigente mi correo principal?
   ├── ¿Hay sesiones de dispositivos que ya no uso?
   ├── ¿Sigue bien la noreply en git config?
   ├── ¿Las notificaciones siguen siendo las que quiero?
   └── ¿Mi biografía refleja mi actividad actual?
```

---

## 10. Resumen

En este capítulo aprendiste que:

* Settings es el panel de control de la cuenta, con secciones claras: perfil público, cuenta, correos, autenticación, claves, notificaciones y zona peligrosa;
* el correo tiene cuatro roles distintos (vinculado, principal, de notificaciones y noreply) y conviene no mezclarlos;
* la dirección noreply de GitHub protege tu correo real en los commits públicos, y conviene activarla y usarla en `git config --global user.email`;
* se puede bloquear el envío de empujes que expongan un correo no protegido;
* el idioma, la zona horaria y la apariencia son ajustes reversibles que conviene hacer desde el primer día;
* las notificaciones masivas vienen de las suscripciones automáticas: quien comenta, se suscribe; la estrategia sencilla es dejar el correo solo para menciones, asignaciones y seguridad, y usar la campana de la plataforma para el resto;
* la visibilidad tiene límites: lo publicado una vez puede copiarse, así que la privacidad se cuida antes de publicar;
* los cambios reversibles se experimentan y los irreversibles (borrar cuenta, cambio de nombre) se leen dos veces;
* en entornos profesionales, parte de la configuración puede estar gobernada por políticas de la organización.

La idea principal es:

> **La configuración básica determina el flujo diario de información y la exposición de tus datos. Una hora de ajustes bien hecha evita meses de ruido y un problema de privacidad.**

---

## Próximo paso

Tu cuenta está presentada y su flujo de información bajo control.

El siguiente paso es blindar el acceso: contraseñas robustas, autenticación en dos factores, sesiones y claves.

Continúa con:

[`04-seguridad-de-la-cuenta.md`](04-seguridad-de-la-cuenta.md)
