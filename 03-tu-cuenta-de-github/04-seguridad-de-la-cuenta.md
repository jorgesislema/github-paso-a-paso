# Seguridad de la cuenta

## Introducción

Una cuenta de GitHub no es solo un perfil: es la llave maestra de tu código. Desde ella se controla el acceso a repositorios públicos y privados, a credenciales (tokens, claves SSH), a organizaciones y, en muchos casos, a despliegues automáticos.

Por eso la seguridad de la cuenta no es un tema avanzado: es el capítulo que debe leerse cuanto antes, antes de generar claves o antes de pertenecer a un repositorio de trabajo.

Un atacante con acceso a tu cuenta puede: leer código privado, introducir código malicioso en tus proyectos, robar tokens de integración, suplantarte ante tu equipo o borrar historial. El riesgo real es alto y los vectores son conocidos: contraseñas reutilizadas, phishing, sesiones abiertas y tokens con exceso de permisos.

En este capítulo aprenderás:

* por qué la cuenta de GitHub es un objetivo;
* a elegir y gestionar contraseñas correctamente;
* a revisar sesiones y dispositivos;
* a trabajar con tokens de acceso personal (PAT) sin exponerlos;
* a detectar intentos de phishing dirigidos a desarrolladores;
* a configurar las alertas de seguridad;
* los errores más comunes y su diagnóstico completo.

La autenticación en dos factores se trata en el capítulo siguiente (05) por su importancia; aquí se prepara el terreno.

---

## Mapa conceptual de este capítulo

```text
Seguridad de la cuenta
       │
       ├── 1. El modelo de amenazas
       │        ├── Qué protege tu cuenta
       │        ├── Quién te ataca y cómo
       │        └── Qué se gana el atacante
       │
       ├── 2. Contraseñas
       │        ├── Reglas de una contraseña fuerte
       │        ├── Gestores de contraseñas
       │        ├── Reutilización y sus riesgos
       │        └── Cambio de contraseña
       │
       ├── 3. Sesiones y dispositivos
       │        ├── Revisión de sesiones
       │        ├── Cierre remoto
       │        └── Sesiones en equipos compartidos
       │
       ├── 4. Tokens de acceso personal (PAT)
       │        ├── Qué son y para qué sirven
       │        ├── Alcance mínimo (principio de privilegio mínimo)
       │        ├── Caducidad
       │        └── Qué hacer si un token se filtra
       │
       ├── 5. Phishing y engaños dirigidos
       │        ├── Correos falsos de GitHub
       │        ├── Sitios falsos de inicio de sesión
       │        ├── Enlaces sospechosos en issues y PRs
       │        └── Cómo verificar auténticamente
       │
       ├── 6. Alertas y revisiones de seguridad
       │        ├── Correo de nuevos inicios de sesión
       │        ├── Log de auditoría (para organizaciones)
       │        └── Revisiones periódicas
       │
       ├── 7. Errores comunes con diagnóstico completo
       │
       ├── 8. Práctica guiada
       │
       ├── 9. Nivel profesional
       │        ├── Tokens en pipelines y secretos
       │        ├── Cuentas de servicio
       │        └── Respuesta ante incidentes
       │
       └── 10. Resumen y siguiente paso
```

---

## 1. El modelo de amenazas

### 1.1. Qué protege tu cuenta

```text
Lo que controla una cuenta de GitHub
   │
   ├── Repositorios
   │      ├── lectura de código privado
   │      ├── escritura (commits, ramas)
   │      └── configuración (acciones, webhooks, entornos)
   │
   ├── Credenciales asociadas
   │      ├── claves SSH
   │      ├── tokens (PAT, OAuth apps, GitHub Apps)
   │      └── integraciones de terceros
   │
   ├── Identidad
   │      ├── tu nombre en commits falsos
   │      ├── tu firma en Pull Requests
   │      └── tu presencia en organizaciones
   │
   ├── Automatización
   │      ├── flujos de trabajo (Actions) con secretos
   │      ├── despliegues automáticos
   │      └── publicación de releases
   │
   └── Red
          ├── tus organizaciones y equipos
          └── la confianza de quienes colaboran contigo
```

Un punto clave: **la seguridad de tu cuenta también es la seguridad de los demás**. Un token tuyo con permisos sobre un repositorio compartido convierte tu cuenta en puerta de entrada al proyecto completo.

### 1.2. Quién te ataca y cómo

No se trata de enemigos sofisticados siempre; la mayoría de los ataques son automatizados y oportunistas:

```text
Vectores de ataque típicos
   │
   ├── 1. CREDENCIALES REUTILIZADAS
   │      Un servicio tercero se filtra; el atacante prueba el
   │      mismo correo y contraseña en GitHub.
   │      Frecuencia: muy alta. Es el vector nº1.
   │
   ├── 2. PHISHING
   │      Correo o mensaje falso que imita a GitHub pidiendo
   │      iniciar sesión o «verificar» la cuenta.
   │      Frecuencia: alta y dirigida a desarrolladores.
   │
   ├── 3. ROBO DE SESIÓN
   │      Cookies o token robados por extensión maliciosa,
   │      red pública sin cifrar o equipo compartido.
   │      Frecuencia: media.
   │
   ├── 4. TOKENS EXPUESTOS
   │      Un token pegado en código, en un log o en una
   │      conversación pública. Frecuencia: altísima por error,
   │      no por ataque.
   │
   └── 5. INGENIERÍA SOCIAL
         Suplantación en issues, mensajes directos o Pull
         Requests que piden «probar algo».
         Frecuencia: baja pero con impacto alto.
```

### 1.3. Qué gana el atacante

```text
Impacto según lo que consigue
─────────────────────────────────────────────────────
Consigue                  Consecuencia
─────────────────────────────────────────────────────
Contraseña                Acceso completo a la cuenta
                          (salvo que la 2FA lo frene)

Token con permisos        Acceso programático sin 2FA:
                          puede leer/escribir según alcance

Sesión abierta            Mientras dure la sesión, mismo
                          efecto que tener la contraseña

Clave SSH robada          Puede hacer push en repos donde
                          la clave esté autorizada
```

Con este mapa, cada medida posterior se entiende como respuesta a un vector concreto, no como consejo genérico.

---

## 2. Contraseñas

### 2.1. Qué hace fuerte a una contraseña hoy

```text
Criterios de contraseña robusta
   │
   ├── Longitud
   │      →  16 caracteres o más (la longitud pesa más que
   │         la complejidad)
   │
   ├── Impredecibilidad
   │      →  nada de «Usuario2024!» ni secuencias de teclado
   │
   ├── Unicidad
   │      →  no usada en ningún otro servicio
   │
   └── Gestión fuera de la cabeza
          →  guardada en un gestor; no en notas, hojas de
             cálculo ni archivos del repositorio
```

### 2.2. Frases de contraseña vs. cadenas aleatorias

Dos enfoques válidos:

```text
Enfoque A: frase de contraseña (passphrase)
   │
   │   Ejemplo conceptual: 4-6 palabras poco habituales
   │   unidas (no uses el mío: genera la tuya)
   │
   ├── Ventaja: se puede memorizar y teclear sin gestor
   └── Requisito: palabras no previsibles y sin sentido obvio

Enfoque B: cadena generada por gestor
   │
   │   Ejemplo conceptual: 20-30 caracteres aleatorios
   │
   ├── Ventaja: máxima entropía, nunca la escribes
   └── Requisito: imprescindible tener gestor
```

Para GitHub (donde la contraseña casi nunca se teclea con gestor presente), lo habitual es la opción B.

### 2.3. El gestor de contraseñas

Un gestor guarda todas tus contraseñas tras una única contraseña maestra (o clave maestra).

```text
Funcionamiento simplificado
──────────────────────────────────────────────
Contraseña maestra ──► Cofre cifrado ──► Contraseñas
   (la única que              (local o         (una por
    memorizas)                en la nube)       servicio)
```

Reglas de uso con GitHub:

1. Genera la contraseña de GitHub **en** el gestor.
2. Guárdala en el gestor.
3. Actívala en el navegador (autocompletar) para no teclearla.
4. Nunca la reutilices.

> **Idea central:** si tu contraseña de GitHub aparece en una filtración de otro servicio, y era la misma, el atacante ya tiene tu código. La unicidad es la defensa.

### 2.4. Cambiar la contraseña

Ruta: **Settings → Password and authentication** (o **Password**).

Al cambiarla:

```text
Efectos del cambio de contraseña
   │
   ├── Obliga a usar la nueva en todos los dispositivos
   ├── GitHub ofrece cerrar las demás sesiones (útil si
   │   sospechas de acceso no autorizado)
   └── No afecta a tokens ni claves SSH: siguen vigentes
       hasta que tú los elimines
```

Ese último punto es crítico y muchos lo ignoran:

> **Cambiar la contraseña NO invalida tokens ni claves SSH. Si crees que tu cuenta fue comprometida, además de la contraseña: cierra sesiones, elimina claves SSH y revoca tokens.**

---

## 3. Sesiones y dispositivos

### 3.1. Dónde verlas

**Settings → Sessions** (nombre según interfaz) lista las sesiones activas:

```text
Información mostrada por sesión
   │
   ├── Navegador o aplicación
   ├── Sistema operativo aproximado
   ├── Última actividad
   └── Ubicación aproximada (IP)
```

### 3.2. Qué buscar

```text
Revisión de sesiones
   │
   ├── ¿Reconoces el dispositivo?
   │      →  si no, cierra la sesión inmediatamente
   │
   ├── ¿Reconoces la ubicación?
   │      →  una ciudad que nunca visitaste = alerta
   │
   ├── ¿Hay sesiones antiguas sin uso?
   │      →  ciérralas: menos superficie de exposición
   │
   └── ¿Sigues teniendo sesión en un equipo prestado o
       de otra persona?
          →  ciérrala y considera cambiar la contraseña
```

### 3.3. Sesiones en equipos compartidos y públicos

```text
Situaciones de riesgo
   │
   ├── Equipo prestado / café / biblioteca
   │      →  si iniciaste sesión, cierra sesión antes de irte
   │
   ├── Sesión olvidada en pantalla compartida
   │      →  cierra sesión desde tu dispositivo remoto
   │
   └── Navegador con sincronización en equipo familiar
          →  evita iniciar sesión con cuentas de trabajo
             en perfiles sincronizados ajenos
```

### 3.4. Cierre remoto y cierre tras robo

Protocolo si sospechas acceso no autorizado:

```text
Respuesta inmediata (en orden)
──────────────────────────────────────────────
1. Cambiar la contraseña (desde un dispositivo seguro)
2. Cerrar todas las sesiones (opción al cambiar contraseña)
3. Revisar y eliminar claves SSH (Settings → SSH and GPG keys)
4. Revocar tokens (Settings → Developer settings / Tokens)
5. Revisar correos y métodos de recuperación
6. Activar 2FA si no está activa (capítulo siguiente)
7. Revisar la actividad reciente de la cuenta
```

Si no puedes entrar (la contraseña no funciona porque otro la cambió): usa la recuperación por correo **y** contacta con soporte de GitHub con pruebas de propiedad de la cuenta.

---

## 4. Tokens de acceso personal (PAT)

### 4.1. Qué es un token

Un **token de acceso personal** es una contraseña especial para programas: permite autenticarte ante GitHub desde la línea de comandos, scripts o aplicaciones, sin usar tu contraseña real y con permisos controlables.

```text
Contraseña vs. token
─────────────────────────────────────────────────────
Contraseña                Token
─────────────────────────────────────────────────────
Acceso total a la cuenta  Acceso acotado a lo que tú decides
No caduca (normalmente)   Puedes ponerle fecha de caducidad
Una sola                  Puedes crear varios con distinto
                          alcance y revocar cada uno
De uso humano             De uso para programas
```

Por eso la regla de oro:

> **La contraseña es para personas; los tokens son para programas. Nunca uses la contraseña en scripts ni la pegues en código.**

### 4.2. Dónde se crean

Ruta clásica: **Settings → Developer settings → Personal access tokens** (también accesible desde el menú de desarrollador según la interfaz vigente; existen los **classic** y los **fine-grained**).

```text
Tipos de tokens
   │
   ├── Token clásico (classic)
   │      ├── Permisos globales amplios
   │      └── Sigue siendo común en herramientas antiguas
   │
   └── Token de permisos finos (fine-grained)
          ├── Permisos por repositorio y por acción concreta
          ├── Fecha de caducidad obligatoria en muchos casos
          └── Preferible cuando la herramienta lo soporta
```

### 4.3. Principio de privilegio mínimo

Cada token debe tener **solo** los permisos que su uso concreto necesita:

```text
Ejemplo: ¿qué permisos necesita una herramienta que
solo sube código a UN repositorio?
─────────────────────────────────────────────────────
NO le des:            SÍ dale:
· acceso total        · escritura en el repositorio
· admin de org        · (nada más)
· borrar todo
· gestionar usuarios
```

```text
Matriz mental: qué permiso pedir según la tarea
─────────────────────────────────────────────────────
Tarea                          Permiso mínimo típico
─────────────────────────────────────────────────────
Leer código desde script       Lectura de contenido
Subir código (push por API)    Escritura de contenido
Gestionar issues               Gestión de issues
Publicar releases              Gestión de releases
Acceso a Actions               Permisos de flujos
Uso en una organización        Alcance limitado a esa org
```

### 4.4. Caducidad

Pon siempre fecha de caducidad:

```text
Caducidad recomendada
   │
   ├── Proyecto puntual:    lo que dure el proyecto
   ├── Uso continuo:        90 días como referencia razonable
   └── Nunca:               «sin caducidad» solo si una
                              herramienta exige y no hay otra
                              forma (y anota la fecha en tu
                              gestor para revisarlo)
```

Una fecha de caducidad obliga a renovar y, de paso, a recordar que ese token existe.

### 4.5. Si un token se filtra

**Escenario:** pegaste un token en un repositorio público, en un log o en un issue.

```text
Respuesta ante token filtrado (actúa en minutos)
──────────────────────────────────────────────
1. Ir a Developer settings → Tokens
2. REVOCAR el token afectado de inmediato
3. Crear uno nuevo si aún lo necesitas
4. Revisar el registro de actividad de la cuenta
   (¿qué hizo alguien con el token mientras estuvo vivo?)
5. Si el token tenía amplios permisos, revisar repositorios
   y organización: commits extraños, releases, secretos
6. Corregir la fuga (borrar el commit NO basta: el token ya
   es conocido; revocar es la solución, no limpiar el código)
```

> **Advertencia:** borrar el archivo con el token filtrado no lo invalida. El token sigue siendo válido hasta que lo revoques. La revocación es la única solución real.

Y sobre «pero si hago force-push para borrarlo del historial»: la copia ya pudo ser clonada; además, reescribir historial en repositorios compartidos es dañino. **Revocar primero, siempre.**

### 4.6. Nunca en el código

```text
Lugares donde un token NO debe aparecer nunca
   │
   ├── Repositorio (ni público ni privado)
   ├── Historial de commits (incluso si lo borras después)
   ├── Issues y Pull Requests
   ├── Logs de CI/Actions
   ├── Pantallazos compartidos
   ├── Correos y mensajería
   └── Variables de entorno en repositorios de ejemplo
         (usa «TU_API_KEY_AQUI» o [REDACTADO] en documentos)
```

Los secretos reales viven en el gestor de secretos de la herramienta (GitHub Actions los tiene como *secrets*, tema de la sección 15).

---

## 5. Phishing y engaños dirigidos

### 5.1. Correos falsos

Los atacantes envían correos que imitan a GitHub:

```text
Señales típicas de phishing
   │
   ├── Urgencia: «tu cuenta se eliminará en 24 horas»
   ├── Amenaza: «detectamos actividad no autorizada»
   ├── Enlace a un dominio que NO es github.com
   ├── Remitente sospechoso (github@correo-raro.com)
   ├── Saludos genéricos («Estimado usuario»)
   └── Petición de credenciales o código 2FA
```

Regla infalible:

> **GitHub no te pide la contraseña ni códigos 2FA por correo. Ante cualquier duda, no pulses el enlace: escribe `github.com` a mano e inicia sesión allí.**

### 5.2. Sitios falsos de inicio de sesión

El ataque clásico: `github.com.login-verificar.xyz`. Dominios a comprobar:

```text
Cómo leer un dominio
──────────────────────────────────────────────
https://github.com/login
     └──► dominio real: github.com

https://github.com.login-verificar.xyz/login
     └──► dominio real: login-verificar.xyz   ← FALSO
```

El dominio real es lo que está **inmediatamente antes** de la primera barra después de `https://`. Comprueba eso siempre.

### 5.3. Enlaces sospechosos en issues y Pull Requests

También hay ingeniería social dentro de la propia plataforma:

```text
Patrones que deben hacerte desconfiar
   │
   ├── «Mira este error y prueba este script»
   ├── «Para ver la vista previa, ejecuta este comando»
   ├── «Necesito que pruebes esta extensión de VS Code»
   ├── «Verifica tu cuenta en este enlace»
   └── Adjuntos o repositorios con instrucciones de
       ejecución de código desconocido
```

Con un repositorio desconocido: **no ejecutes nada** hasta revisar el código. Ejecutar `curl … | bash` a ciegas es invitar al atacante a tu máquina.

### 5.4. Cómo verificar de forma auténtica

```text
Verificación segura
──────────────────────────────────────────────
1. No uses el enlace recibido
2. Abre github.com en una pestaña nueva (escribiendo la URL)
3. Inicia sesión con tu gestor de contraseñas
   (si el sitio es falso, el gestor no rellenará:
    ¡señal automática de sitio falso!)
4. Revisa dentro de la plataforma: notificaciones,
   ajustes de seguridad, correos de GitHub
5. Si es un aviso legítimo, aparecerá también dentro
```

El gestor de contraseñas es aquí un detector de phishing de primera categoría: **no autocompletar en un sitio falso es la primera línea de defensa**.

---

## 6. Alertas y revisiones de seguridad

### 6.1. Avisos de inicio de sesión

GitHub puede avisarte (correo) cuando se inicia sesión desde un dispositivo nuevo. Recomendado: **activado**.

```text
Flujo de alerta
──────────────────────────────────────────────
Dispositivo nuevo inicia sesión
        │
        ▼
Correo de aviso «Nuevo inicio de sesión»
        │
        ├── ¿Eras tú?  →  nada más
        └── ¿No?       →  protocolo de incidente (punto 3.4)
```

### 6.2. Notificaciones de seguridad de la cuenta

En la sección de seguridad verás el estado de los elementos básicos:

```text
Estado de seguridad (checklist)
   │
   ├── 2FA activado                  →  (capítulo siguiente)
   ├── Contraseña fuerte y única     →  (punto 2)
   ├── Correos verificados           →  (ya hecho)
   ├── Sesiones revisadas            →  (punto 3)
   ├── Claves SSH revisadas          →  (sección 07)
   └── Tokens revisados y con caducidad (punto 4)
```

### 6.3. Bitácora (log) de actividad

La cuenta tiene un registro de eventos (actividad reciente). Úsalo cuando dudes:

```text
Qué buscar en la bitácora
   │
   ├── Inicios de sesión
   ├── Cambios de contraseña o de correo
   ├── Creación/eliminación de tokens y claves
   ├── Acciones de repositorio (como administrador)
   └── Cualquier evento que no recuerdes haber hecho
       →  evento no reconocido = protocolo de incidente
```

En organizaciones, la **bitácora de auditoría** (sección 18) amplía esto a toda la organización y es una herramienta de administración, no solo personal.

### 6.4. Revisiones periódicas

```text
Cadencia recomendada
   │
   ├── Semanal (2 minutos):  campana y correo de seguridad
   ├── Mensual:              sesiones y actividad reciente
   └── Trimestral o al salir de un proyecto:
                             revocar tokens y claves que ya
                             no necesitas
```

---

## 7. Errores comunes con diagnóstico completo

### Error 1: Contraseña reutilizada de otro servicio

**Qué ocurrió:** la misma contraseña se usó en un foro que se filtró.

**Por qué:** comodidad; el gestor no se usó.

**Cómo comprobarlo:** verificar si el correo aparece en fugas conocidas (herramientas de divulgación de contraseñas); revisar inicios de sesión no reconocidos.

**Opciones:**
* Cambiar la contraseña y activar 2FA (mínimo).
* Usar un gestor para que nunca se repita.

**Riesgos:** con solo contraseña, la cuenta puede tomarla cualquier persona que tenga la combinación correo+contraseña.

**Solución:** contraseña única en gestor + 2FA (capítulo siguiente).

**Cómo se evita:** desde la creación de la cuenta, contraseña generada en gestor.

---

### Error 2: Token pegado en un repositorio

**Qué ocurrió:** se copió un token de ejemplo y se subió el archivo real.

**Por qué:** prisa y falta de separación entre «ejemplo» y «real».

**Cómo comprobarlo:** revisar el archivo y el historial; si está en un repositorio público, asumir que es conocido.

**Opciones:**
* Revocar ya (única solución efectiva).
* Limpiar el historial (no sustituye a revocar; complejo y arriesgado).

**Riesgos:** lectura/escritura según permisos del token, durante todo el tiempo que tarde en reaccionar.

**Solución:** revocar, crear token nuevo y, si la fuga fue pública, revisar actividad del token.

**Cómo se evita:** usar solo *secrets* de la plataforma, `TU_API_KEY_AQUI` en documentos, y revisar `git diff` antes de hacer push.

---

### Error 3: No revisar sesiones tras prestar el equipo

**Qué ocurrió:** se inició sesión en un equipo ajeno y se olvidó cerrar.

**Por qué:** distracción; no se consideró «equipo ajeno» un riesgo.

**Cómo comprobarlo:** Settings → Sessions: aparece el dispositivo.

**Opciones:**
* Cerrar esa sesión desde tu dispositivo.
* Cambiar contraseña por prudencia si el equipo ya no es tuyo.

**Riesgos:** acceso no supervisado mientras la sesión siga viva.

**Solución:** cierre remoto de sesión y, si corresponde, rotación de contraseña.

**Cómo se evita:** norma personal: iniciar sesión solo en dispositivos propios; si es ajeno, cerrar sesión antes de irte.

---

### Error 4: Phishing por «actividad sospechosa»

**Qué ocurrió:** llegó un correo urgente pidiendo iniciar sesión; se siguió el enlace.

**Por qué:** urgencia diseñada para que no pienses.

**Cómo comprobarlo:** mirar el dominio; abrir github.com manualmente y comprobar si hay alerta real; revisar cabeceras del correo (remitente real).

**Opciones:**
* Si no se introdujo nada: marcar como phishing y borrar.
* Si se introdujo la contraseña: cambiarla de inmediato, cerrar sesiones, revisar actividad.
* Si se introdujo un código 2FA: además, revisar la configuración 2FA y contactar con soporte si hubo acceso.

**Riesgos:** robo total de la cuenta en el peor caso.

**Solución:** protocolo de incidente (punto 3.4) + activar alertas.

**Cómo se evita:** nunca entrar por enlaces de correo; practicar la lectura de dominios; contar con gestor que no rellene en sitios falsos.

---

### Error 5: Creer que cambiar la contraseña «limpia» todo

**Qué ocurrió:** se cambió la contraseña tras una sospecha, pero un token viejo siguió activo.

**Por qué:** suponer que la contraseña es el único acceso.

**Cómo comprobarlo:** revisar tokens y claves: siguen ahí.

**Opciones:** revocar tokens, eliminar claves SSH, cerrar sesiones.

**Riesgos:** acceso residual no detectado.

**Solución:** checklist completa de incidente, no solo la contraseña.

**Cómo se evita:** conocer desde el principio los tres tipos de credencial (contraseña, token, clave SSH).

---

### Error 6: Tokens «eternos» y con exceso de permisos

**Qué ocurrió:** un token creado hace dos años para probar algo sigue vivo con permisos de administración.

**Por qué:** se creó rápido, sin fecha ni alcance mínimo.

**Cómo comprobarlo:** lista de tokens: fecha de creación, caducidad y permisos.

**Opciones:** revocar y recrear con alcance mínimo y caducidad.

**Riesgos:** superficie de ataque innecesaria; si se filtra, impacto máximo.

**Solución:** inventario y rotación.

**Cómo se evita:** regla: todo token nuevo nace con caducidad y permisos mínimos.

---

## 8. Práctica guiada

### Objetivo

Dejar la cuenta endurecida: contraseña gestionada, sesiones revisadas, tokens controlados y phishing reconocible.

### Paso 1: Contraseña

1. Si no usas gestor, instala uno.
2. Genera una contraseña nueva para GitHub y guárdala en el gestor.
3. Cámbiala en **Settings → Password and authentication**.
4. Marca la opción de cerrar otras sesiones si el contexto lo aconseja.

### Paso 2: Sesiones

1. Entra en **Settings → Sessions**.
2. Identifica cada sesión; cierra las desconocidas o antiguas.

### Paso 3: Tokens

1. Entra en **Developer settings → Personal access tokens**.
2. Lista todos los tokens.
3. Revoca los que no reconozcas o ya no uses.
4. A los que conserves: comprueba permisos mínimos y fecha de caducidad.

### Paso 4: Claves SSH (inventario)

1. Entra en **Settings → SSH and GPG keys**.
2. Revisa la lista; elimina claves de equipos antiguos.
   (Si aún no sabes qué es una clave SSH, deja la revisión
    para el capítulo correspondiente de la sección 07 y vuelve
    aquí: lo importante es no dejar claves de equipos ajenos.)

### Paso 5: Alertas

1. Comprueba que tienes activo el aviso de nuevos inicios de sesión.
2. Verifica que tu correo de seguridad llega a tu bandeja principal.

### Paso 6: Simulacro de phishing

1. Busca en tu bandeja un correo reciente de GitHub (notificaciones).
2. Comprueba el remitente real y el dominio del enlace (sin pulsarlo).
3. Practica: ¿serías capaz de distinguirlo de un falso?

### Checklist final

```text
Cuenta endurecida
   │
   ├── Contraseña única en gestor                    □
   ├── 2FA pendiente de activar (siguiente cap.)     □
   ├── Sesiones revisadas y saneadas                 □
   ├── Tokens inventariados con caducidad            □
   ├── Claves SSH de equipos ajenos eliminadas       □
   ├── Avisos de sesión nuevos activos               □
   └── Capacidad de detectar un correo falso         □
```

### Resultado esperado

La cuenta tiene defensa en profundidad: ni la contraseña sola basta para comprometerla, y las credenciales de programas están bajo control.

### Conclusión esperada

La seguridad no es un ajuste sino un hábito: credenciales únicas, privilegios mínimos, sesiones revisadas y desconfianza ante prisas y enlaces.

---

## 9. Nivel profesional

### 9.1. Tokens y secretos en pipelines

En proyectos profesionales, los tokens viven en los sistemas de secretos:

```text
Dónde guardan los secretos los equipos
   │
   ├── GitHub Actions → «Secrets» del repositorio u organización
   ├── Gestores dedicados (Vault y similares)
   ├── Variables cifradas del sistema de CI
   └── Nunca: en el repositorio, en los logs, en el código
```

Reglas profesionales:

* los secretos de CI tienen alcance mínimo (un token por proyecto);
* rotan periódicamente (no «cuando se filtre»);
* los logs de CI se revisan por si imprimen variables;
* los colaboradores externos no reciben secretos con alcance de organización entera.

### 9.2. Cuentas de servicio y bots

Para automatización se usan identidades no humanas:

```text
Cuenta humana vs. cuenta de servicio
   │
   ├── Humana:
   │      · tiene 2FA
   │      · recibe alertas
   │      · abandona la empresa y se desactiva
   │
   └── Servicio/bot:
         · token con caducidad y alcance mínimo
         · pertenece a la organización, no a una persona
         · sin 2FA (no hay persona) → compensar con
            control de permisos y rotación
```

La tendencia profesional actual es reducir el uso de cuentas personales para automatización (menos dependencias cuando alguien se marcha).

### 9.3. SSO y políticas organizativas

Cuando la organización impone SSO o 2FA obligatorio:

```text
Efectos en tu configuración
   │
   ├── La autenticación puede pasar por el proveedor corporativo
   ├── El 2FA puede estar obligado por política
   ├── Los tokens pueden requerir renovación frecuente
   └── Algunas opciones personales quedan subordinadas
       a la organización
```

### 9.4. Respuesta ante incidentes (plantilla)

```text
PLANTILLA DE RESPUESTA A COMPROMISO DE CUENTA
──────────────────────────────────────────────
1. Contener
   · Cambiar contraseña desde dispositivo seguro
   · Cerrar todas las sesiones
   · Revocar todos los tokens
   · Eliminar claves SSH no reconocidas

2. Investigar
   · Revisar bitácora de actividad
   · Buscar commits, releases o cambios extraños
   · Revisar correos y métodos de recuperación

3. Comunicar
   · Avisar al equipo si la cuenta tenía acceso a
     repositorios compartidos
   · Avisar a la organización (si aplica)

4. Recuperar
   · Restaurar lo alterado (ramas, configuraciones)
   · Renovar integraciones afectadas

5. Prevenir
   · Activar/verificar 2FA
   · Revisar políticas de tokens
   · Documentar lo aprendido
```

---

## 10. Resumen

En este capítulo aprendiste que:

* tu cuenta de GitHub es la llave maestra de tu código y de la confianza de tu equipo, y los ataques más comunes son automatizados: contraseñas reutilizadas, phishing y tokens filtrados;
* una contraseña robusta es larga, única y vive en un gestor; la unicidad es la defensa contra las filtraciones ajenas;
* cambiar la contraseña no invalida sesiones, tokens ni claves SSH: la respuesta completa incluye cerrar sesiones, revocar tokens y revisar claves;
* las sesiones se revisan en Settings → Sessions y el cierre remoto es tu primera herramienta ante la sospecha;
* los tokens son contraseñas para programas: nacen con alcance mínimo y caducidad, y su única solución ante una fuga es la revocación (borrar el archivo no sirve);
* el phishing se combate con hábitos: no entrar por enlaces, leer dominios y dejar que el gestor no rellene en sitios falsos;
* las alertas de nuevos inicios de sesión y la revisión periódica de la bitácora convierten la seguridad en control rutinario;
* a nivel profesional, los secretos viven en sistemas de secretos, rotan y se acotan por proyecto, y la respuesta ante incidentes sigue un orden: contener, investigar, comunicar, recuperar, prevenir.

La idea principal es:

> **La seguridad de la cuenta no depende de una contraseña buena, sino de varias capas: credenciales únicas, segundo factor, privilegios mínimos y desconfianza ante la urgencia.**

---

## Próximo paso

Ya sabes proteger la contraseña, las sesiones y los tokens.

El siguiente paso es la capa que más reduce el riesgo real: la autenticación en dos factores (2FA).

Continúa con:

[`05-autenticacion-en-dos-pasos.md`](05-autenticacion-en-dos-pasos.md)
