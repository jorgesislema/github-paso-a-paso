# Autenticación en dos pasos

## Introducción

En el capítulo anterior quedó clara una verdad incómoda: la contraseña sola no basta. Si la contraseña se filtra (por reutilización, phishing o keylogger), quien la tiene entra con la misma legitimidad que tú.

La **autenticación en dos factores** (2FA) añade un segundo paso: además de saber algo (la contraseña), necesitas poseer algo (tu teléfono, una llave física o una aplicación). Aunque roben la contraseña, sin el segundo factor no entran.

Es la medida que más reduce el riesgo de robo de cuenta en la práctica, y por eso muchas organizaciones la hacen obligatoria para colaborar en sus repositorios.

En este capítulo aprenderás:

* qué es la autenticación multifactor y de dónde viene el nombre;
* los tres factores de autenticación;
* los métodos que ofrece GitHub (aplicación TOTP, llaves de seguridad, llaves de recuperación);
* cómo activar la 2FA paso a paso;
* cómo usar los códigos de recuperación y por qué guardarlos;
* cómo iniciar sesión con 2FA;
* cómo responder a la pérdida del dispositivo;
* errores comunes, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Autenticación en dos pasos (2FA)
       │
       ├── 1. Fundamento
       │        ├── Autenticación: ¿quién eres?
       │        ├── Factores: saber / poseer / ser
       │        ├── Qué es multifactor y qué no
       │        └── Por qué la contraseña sola no basta
       │
       ├── 2. Métodos que ofrece GitHub
       │        ├── Aplicación autenticadora (TOTP)
       │        ├── Llave de seguridad (FIDO2/WebAuthn)
       │        ├── Llaves de recuperación
       │        └── Código por SMS (limitado / no recomendado)
       │
       ├── 3. Activación paso a paso
       │        ├── Elegir método
       │        ├── Escanear el código QR
       │        ├── Verificar el primer código
       │        └── Descargar llaves de recuperación
       │
       ├── 4. El inicio de sesión con 2FA
       │
       ├── 5. Llaves de recuperación y dispositivos perdidos
       │
       ├── 6. 2FA en dispositivos móviles y apps
       │
       ├── 7. Errores comunes con diagnóstico completo
       │
       ├── 8. Práctica guiada
       │
       ├── 9. Nivel profesional
       │        ├── 2FA obligatoria en organizaciones
       │        ├── Llaves de seguridad en equipos
       │        └── Recuperación corporativa de cuentas
       │
       └── 10. Resumen y siguiente paso
```

---

## 1. Fundamento

### 1.1. Autenticación: ¿quién eres?

**Autenticación** es verificar la identidad. No es lo mismo que autorización (qué puedes hacer una vez dentro): la 2FA se ocupa de la primera.

```text
Autenticación vs. Autorización
──────────────────────────────────────────────
Autenticación (2FA):        «¿Eres tú?»
   → contraseña + segundo factor

Autorización (permisos):    «¿Qué puedes hacer aquí?»
   → roles, permisos de repositorio, organización
```

### 1.2. Los tres factores

Se habla de tres tipos de factor:

```text
Los tres factores
──────────────────────────────────────────────
1. SABER      algo que conoces
              contraseña, PIN, respuesta secreta

2. POSEER     algo que tienes
              teléfono con app, llave física, tarjeta

3. SER        algo que eres
              huella dactilar, rostro, voz
```

**2FA = dos factores distintos.** De ahí el nombre: dos pasos, y además de dos tipos diferentes.

### 1.3. Multifactor ≠ dos pasos con lo mismo

Aquí está la confusión más común:

```text
SÍ es multifactor:                  NO es multifactor:
─────────────────────────           ─────────────────────────
Contraseña + código de              Contraseña + pregunta
la app del teléfono                 secreta (ambas: algo
(una es saber, la otra              que SABES)
es poseer)

Contraseña + llave física            Código enviado al
(una es saber, la otra              mismo teléfono +
es poseer)                          contraseña (sigue
                                    siendo: poseer el
                                    teléfono + saber la
                                    contraseña... es
                                    multifactor de verdad,
                                    pero si el mismo
                                    canal recibe ambos,
                                    la seguridad baja)
```

Dicho con precisión: enviar la contraseña y el código **al mismo dispositivo** hace que perder ese dispositivo comprometa todo. Por eso los métodos recomendados separan canales: la app TOTP o la llave física no dependen del canal por donde llega el aviso.

### 1.4. Por qué la contraseña sola no basta

```text
Escenario sin 2FA
──────────────────────────────────────────────
Contraseña filtrada en otro servicio
        │
        ▼
Atacante la prueba en GitHub
        │
        ▼
Entra. Acceso total a tu cuenta.

Escenario con 2FA
──────────────────────────────────────────────
Contraseña filtrada
        │
        ▼
Atacante la prueba en GitHub
        │
        ▼
GitHub pide el segundo factor
        │
        ▼
No lo tiene ⇒ ACCESO BLOQUEADO
```

La 2FA convierte el robo de contraseña de «robo de cuenta» en «robo de un paso que ya no sirve».

### 1.5. Qué NO protege la 2FA

Para no confiar en más de lo que da:

```text
Límites de la 2FA
   │
   ├── No protege si el atacante te engaña para que
   │   introduzcas TÚ el código (phishing con 2FA:
   │   existe; las llaves FIDO2 lo resisten, ver punto 2.2)
   │
   ├── No protege sesiones ya iniciadas (si el atacante
   │   roba la sesión antes, la 2FA no reaparece)
   │
   └── No protege tokens ya emitidos (siguen vigentes
       hasta revocarlos)
```

---

## 2. Métodos que ofrece GitHub

### 2.1. Mapa de opciones

```text
Métodos de 2FA en GitHub
   │
   ├── APLICACIÓN AUTENTICADORA (TOTP)
   │      · App en el móvil genera un código de 6 dígitos
   │        que cambia cada 30 segundos
   │      · Ejemplos de apps: las que cumplen el estándar TOTP
   │        (puedes elegir la que prefieras)
   │      · Ventaja: funciona sin red (el código se calcula
   │        en el dispositivo)
   │      · Riesgo: si pierdes el móvil y no tienes códigos
   │        de recuperación, quedas fuera
   │
   ├── LLAVE DE SEGURIDAD (FIDO2 / WebAuthn)
   │      · Dispositivo físico (o passkey) que tú presionas
   │        al iniciar sesión
   │      · Ventaja máxima: resiste el phishing, porque el
   │        navegador verifica el dominio real
   │      · Riesgo: tenerla encima; se recomienda dos llaves
   │
   ├── LLAVES DE RECUPERACIÓN
   │      · Códigos de un solo uso descargables
   │      · No son 2FA: son el boleto de emergencia
   │      · Obligatorias prácticamente siempre
   │
   └── SMS (cuando está disponible)
          · Menos seguro que los anteriores (SIM swap)
          · Recomendación: usarlo como apoyo, no como
            método principal
```

### 2.2. Aplicación autenticadora (TOTP): cómo funciona

```text
Principio TOTP (simplificado)
──────────────────────────────────────────────
Al activar:
   App ◄──── QR ────► GitHub
   (ambas comparten un secreto inicial)

Después, cada 30 segundos:
   secreto + hora actual ──► código de 6 dígitos
   (misma fórmula en tu app y en GitHub)

Al iniciar sesión:
   escribes el código del momento
   → GitHub comprueba que coincide
```

Detalles prácticos:

* el código caduca en ~30 segundos: si expira, espera al siguiente;
* el reloj del dispositivo importa: un reloj muy desajustado genera códigos inválidos;
* el secreto está en el QR: **captura de pantalla del QR = copia de tu segundo factor**; escanea y no guardes el QR.

### 2.3. Llave de seguridad (FIDO2/WebAuthn)

```text
Inicio de sesión con llave física
──────────────────────────────────────────────
1. GitHub pide la llave
2. El navegador comprueba que la página es github.com REAL
3. Tú presionas el botón de la llave (+ biometría si aplica)
4. La llave firma un desafío específico de ese dominio
5. GitHub valida
```

Por qué resiste el phishing: la llave solo firma si el dominio es el correcto. En un sitio falso, aunque la página «parezca» GitHub, la llave no firmará (el navegador ve otro dominio). Ningún código pegado en un sitio falso funciona.

Recomendación profesional: tener **dos** llaves (principal + respaldo), porque perder la única es perder la cuenta.

### 2.4. Llaves de recuperación

Cada vez que activas 2FA, GitHub te ofrece un conjunto de **llaves de recuperación** (códigos de un solo uso).

```text
Llaves de recuperación
   │
   ├── Son: una lista de códigos de un solo uso
   ├── Sirven para: entrar si pierdes el segundo factor
   ├── Cada código: se usa UNA vez y deja de servir
   └── Guardado: fuera del ordenador que proteges
```

> **Norma clave:** la llave de recuperación debe estar en un lugar físico o gestor distinto del equipo que puede ser robado. Una copia en el mismo equipo que se roba no es una copia.

---

## 3. Activación paso a paso

### 3.1. Ubicación en la interfaz

```text
Settings
   │
   └── Password and authentication   (o la sección vigente
          │                          de seguridad)
          ├── Two-factor authentication
          │      ├── Enable 2FA / Configurar
          │      ├── Método: app o llave
          │      └── Llaves de recuperación: descargar
          └── Sesiones y contraseña (capítulos previos)
```

### 3.2. Procedimiento con aplicación TOTP

1. Entra en **Settings → Password and authentication → Two-factor authentication**.
2. Pulsa **Enable two-factor authentication** (Configurar 2FA).
3. GitHub muestra un **código QR**.
4. Abre tu app autenticadora y escanea el QR.
5. La app muestra un código de 6 dígitos.
6. Ese código se escribe en GitHub para **verificar**.
7. GitHub ofrece las **llaves de recuperación**: descárgalas o cópialas.
8. Confirma haberlas guardado (GitHub exige confirmación).
9. La 2FA queda activa.

```text
Diagrama de la activación
──────────────────────────────────────────────
     GitHub (navegador)            App en el móvil
            │                            │
            │──── muestra QR ───────────►│ escanea
            │                            │ genera código
            │◄─── escribe el código ─────│
            │ verificado                 │
            │──── ofrece llaves de       │
            │      recuperación ──► guardas FUERA del móvil
            │ 2FA ACTIVA                 │
```

### 3.3. Procedimiento con llave de seguridad

1. Entra en la sección de 2FA.
2. Elige la opción de **llave de seguridad / passkey**.
3. El navegador pedirá insertar o tocar la llave.
4. Confirma con el gesto (presionar, biometría).
5. Guarda llaves de recuperación igualmente.
6. (Recomendado) Repite para registrar una segunda llave.

### 3.4. Qué hacer con los códigos de recuperación

```text
Guardado correcto de llaves de recuperación
──────────────────────────────────────────────
Opción A: impresas, en un lugar seguro físico
Opción B: archivo cifrado en el gestor de contraseñas
Opción C: bóveda de contraseñas con acceso controlado

NO:
   ✗  en un archivo «recuperacion.txt» del escritorio
   ✗  en la misma carpeta del equipo que proteges
   ✗  en capturas de pantalla en la nube sin cifrar
   ✗  en el repositorio (por supuesto)
```

---

## 4. El inicio de sesión con 2FA

### 4.1. Flujo normal

```text
Inicio de sesión con 2FA
──────────────────────────────────────────────
1. Usuario + contraseña
        │
        ▼
2. GitHub pide el segundo factor
        │
        ├── App TOTP: escribes el código de 6 dígitos
        ├── Llave: presionas la llave
        └── Emergencia: un código de recuperación (se agota)
        │
        ▼
3. Sesión iniciada
```

### 4.2. Dónde se pide (y dónde no)

```text
Situaciones en que se pide el segundo factor
   │
   ├── Inicio de sesión en el navegador
   ├── Acciones sensibles (dependiendo de la configuración:
   │   firmar con clave SSH, operaciones críticas)
   └── Nuevos dispositivos según la política

Situaciones en que NO se pide
   │
   ├── Mientras la sesión siga viva en el navegador
   ├── Uso de tokens (PAT) existentes
   └── Uso de claves SSH ya registradas
```

Ese último punto conecta con el capítulo anterior: **la 2FA protege el inicio de sesión, no las credenciales ya emitidas**. Por eso la respuesta ante compromiso incluye revocar tokens y claves.

### 4.3. «Mantener la sesión iniciada»

Puedes elegir no pedir el segundo factor en cada visita en ese dispositivo. La comodidad contra la seguridad:

```text
Con «no preguntar de nuevo» en este dispositivo:
   ├── Ventaja: no teclear código cada vez
   └── Riesgo: cualquier persona con acceso a ese
       dispositivo abierta la sesión pasa como tú
       →  válido en tu equipo personal; malo en
          equipos compartidos o públicos
```

---

## 5. Llaves de recuperación y dispositivos perdidos

### 5.1. Escenario: perdí el móvil

```text
Protocolo: móvil perdido o robado
──────────────────────────────────────────────
1. No entres en pánico: tienes las llaves de recuperación
2. Desde un dispositivo seguro, entra en GitHub con
   contraseña + UN código de recuperación
3. Ve a la configuración de seguridad
4. Añade la nueva app autenticadora (escanea un QR nuevo)
   o registra la nueva llave
5. Genera un NUEVO juego de llaves de recuperación
   (las viejas usadas/dejadas atrás se invalidan o quedan
   desactualizadas según procedimiento)
6. Descarta mentalmente los códigos ya gastados
```

### 5.2. Escenario: perdí el móvil Y las llaves

```text
Sin segundo factor ni códigos
──────────────────────────────────────────────
Opción 1: proceso de recuperación de cuenta de GitHub
   → proporcionar pruebas de propiedad
   → puede requerir tiempo y verificación
   → la identidad asociada a la cuenta importa
     (correo verificado, actividad, etc.)

Opción 2: si la cuenta pertenece a una organización,
   el administrador puede tener opciones de recuperación
   (sección 18)

Conclusión: POR ESO existen las llaves de recuperación
y POR ESO se guardan fuera del móvil
```

### 5.3. Escenario: cambias de teléfono

Migración ordenada (antes de dar de baja el antiguo):

```text
Migración de app TOTP
──────────────────────────────────────────────
1. Con el móvil nuevo a mano:
2. GitHub → seguridad → reconfigurar TOTP (QR nuevo)
3. Escanea con la app del móvil nuevo
4. Verifica con el código nuevo
5. Genera llaves de recuperación nuevas
6. Solo DESPUÉS elimina la app del móvil antiguo
```

Nunca al revés: primero queda el nuevo funcionando, luego se retira el viejo.

---

## 6. 2FA en dispositivos y apps

### 6.1. La app autenticadora como cartera de identidad

Tu app TOTP guarda los secretos de todos los servicios donde activaste 2FA. Implica responsabilidad:

```text
Cuidados con la app autenticadora
   │
   ├── Tiene copia de seguridad configurada? (según la app)
   ├── Si cambias de móvil, ¿migras los secretos?
   └── Si el móvil es tu único factor, ¿tienes códigos
       de recuperación aparte?
```

### 6.2. ¿Y el móvil como único factor?

Muchas personas solo tienen la app en el móvil. Es mejor que nada, pero el punto único de fallo es el dispositivo. Alternativas de refuerzo:

```text
Refuerzos
   │
   ├── Añadir una llave de seguridad (no depende del móvil)
   ├── Mantener las llaves de recuperación actualizadas
   └── Copia de seguridad del secreto según la app elegida
```

---

## 7. Errores comunes con diagnóstico completo

### Error 1: Activar 2FA sin guardar los códigos de recuperación

**Qué ocurrió:** se pulsó «ya los guardé» sin guardarlos.

**Por qué:** prisa; el archivo «después lo hago».

**Cómo comprobarlo:** intentar localizar el archivo o impreso; si no existe, no están guardados.

**Opciones:**
* Generar un juego nuevo desde la configuración de seguridad (los antiguos se invalidan).
* A partir de ahí, guardarlos en gestor o en papel.

**Riesgos:** cualquier pérdida del móvil deja la cuenta fuera de alcance hasta un proceso largo de recuperación.

**Solución:** regenerar y guardar bien.

**Cómo se evita:** tratar la pantalla de códigos como una parte obligatoria del acto de activación.

---

### Error 2: Código TOTP que «no funciona»

**Qué ocurre:** la app da un código y GitHub lo rechaza.

**Por qué:** normalmente, reloj desajustado, código introducido cuando ya expiró, o app con un QR de otra cuenta.

**Cómo comprobarlo:**
* esperar a que el código cambie e introducir el recién generado;
* comprobar la hora automática del dispositivo;
* verificar que la entrada de la app corresponde a GitHub y a tu cuenta.

**Opciones:**
* corregir la sincronización horaria del dispositivo;
* si persiste, usar un código de recuperación y reconfigurar la app.

**Riesgos:** pánico innecesario que lleva a abandonar la 2FA.

**Solución:** primero reloj, luego código fresco, luego recuperación.

**Cómo se evita:** mantener hora automática activada en el dispositivo.

---

### Error 3: Activar 2FA en el último momento antes de un viaje

**Qué ocurre:** se activa sin comprobar accesos desde el extranjero (roaming sin datos, móvil sin batería).

**Por qué:** falta de planificación.

**Cómo comprobarlo:** ¿tienes códigos de recuperación accesibles sin el móvil?

**Opciones:** llevar llave de seguridad o códigos impresos.

**Riesgos:** quedar sin acceso a cuentas críticas durante el viaje.

**Solución:** plan de acceso: siempre llevar un segundo factor independiente del móvil.

**Cómo se evita:** hacer la activación completa (con plan de respaldo) en cuanto se empieza a usar la cuenta en serio.

---

### Error 4: Creer que la 2FA protege los tokens

**Qué ocurre:** se mantiene un token viejo «porque tengo 2FA».

**Por qué:** confundir capas.

**Cómo comprobarlo:** revisar tokens: siguen funcionando aunque la 2FA esté activa.

**Opciones:** revocar lo que ya no se usa.

**Riesgos:** acceso residual.

**Solución:** 2FA para el inicio de sesión; inventario de tokens para el resto.

**Cómo se evita:** entender el mapa de credenciales (contraseña, 2FA, tokens, claves SSH).

---

### Error 5: Escanear el QR desde una captura de pantalla antigua o compartida

**Qué ocurre:** el QR se guardó en una imagen compartida (chats, nube sin cifrar).

**Por qué:** comodidad.

**Cómo comprobarlo:** buscar capturas con QR; si existe, el secreto está expuesto.

**Opciones:** reconfigurar la 2FA (QR nuevo) y borrar la captura.

**Riesgos:** cualquiera con la imagen genera tus códigos.

**Solución:** reactivar con QR nuevo y tratar la imagen como credencial robada.

**Cómo se evita:** escanear en directo y no capturar.

---

### Error 6: Pulsar «confiar en este dispositivo» en equipos ajenos

**Qué ocurre:** se marcó «no pedir de nuevo» en un equipo compartido.

**Por qué:** prisa.

**Cómo comprobarlo:** revisar sesiones activas.

**Opciones:** cerrar sesión en ese equipo.

**Riesgos:** acceso sin segundo factor mientras la sesión dure.

**Solución:** cierre de sesión y, si procede, rotación de contraseña.

**Cómo se evita:** decidir por política: confianza solo en equipos propios.

---

## 8. Práctica guiada

### Objetivo

Activar la 2FA con un método sólido y dejar preparada la recuperación.

### Paso 1: Elegir el método

```text
Decisión
   │
   ├── ¿Tienes llave de seguridad?
   │      →  sí: actívala como principal + respaldo
   │      →  no: app TOTP como principal
   │
   ├── En ambos casos: llaves de recuperación obligatorias
   └── Añade al móvil la app TOTP aunque uses llave:
       es un respaldo adicional
```

### Paso 2: Activar

1. **Settings → Password and authentication → Two-factor authentication**.
2. Activa con el método elegido (puntos 3.2 o 3.3).
3. Espera a ver la pantalla de verificación y comprueba que tu método funciona.

### Paso 3: Guardar la recuperación

1. Descarga las llaves de recuperación.
2. Guárdalas en gestor o en papel, **fuera de este equipo**.
3. Marca la confirmación en GitHub.

### Paso 4: Verificación real

1. Cierra la sesión de GitHub.
2. Vuelve a iniciar sesión: te debe pedir el segundo factor.
3. Introduce un código / usa la llave.
4. Comprueba que entras.

### Paso 5: Prueba de recuperación (recomendada)

1. Con un código de recuperación, comprueba que te dejaría entrar.
2. Anota que ese código ya no sirve más (si probaste uno de un juego, regenera el juego o lleva la cuenta de cuáles quedan).

### Checklist final

```text
2FA bien instalada
   │
   ├── Método principal configurado              □
   ├── Segundo método o llave de respaldo        □
   ├── Llaves de recuperación guardadas FUERA    □
   │   del equipo y del móvil                        □
   ├── Inicio de sesión probado con 2FA          □
   └── Códigos TOTP: hora automática activada    □
```

### Resultado esperado

Entrar a tu cuenta requiere dos factores, y tienes una vía de recuperación probada y guardada en lugar seguro.

### Conclusión esperada

La 2FA no es un trámite: es la barrera que convierte una contraseña filtrada en un intento fallido. Y su valor depende por completo de tener la recuperación resuelta antes de necesitarla.

---

## 9. Nivel profesional

### 9.1. 2FA obligatoria en organizaciones

Las organizaciones pueden exigir 2FA a sus miembros:

```text
2FA obligatoria en una organización
   │
   ├── Efecto: para colaborar, tu cuenta debe tener 2FA
   ├── Si la desactivas: puedes perder el acceso a la org
   └── En organizaciones Enterprise, suele venir con
       políticas de sesión y dispositivos
```

Implicación profesional: no desactives la 2FA «para probar algo»; primero habla con el administrador.

### 9.2. Llaves de seguridad en equipos

En equipos con riesgo elevado (infraestructura, pagos, código sensible), la recomendación es uniformizar:

```text
Política de llaves típica (equipo exigente)
   │
   ├── Cada persona: 2 llaves FIDO2 (principal + respaldo)
   ├── Registro de ambas en la cuenta
   ├── Uso de passkeys donde la plataforma lo permita
   ├── Llaves de recuperación custodiadas
   └── Revisión trimestral de métodos de acceso
```

La passkey (credencial sin contraseña que se sincroniza entre tus dispositivos) combina factor «poseer» con biometría; cuando la plataforma la soporta, es una vía cómoda con buena seguridad. Evalúa su custodia (dónde vive la copia sincronizada) antes de adoptarla como único método.

### 9.3. Recuperación corporativa de cuentas

Cuando una cuenta con acceso a repositorios de empresa queda bloqueada:

```text
Vías de recuperación en organización
   │
   ├── La organización puede requerir ciertos métodos
   ├── Existen procesos de reposición de miembros
   ├── El administrador puede revocar accesos mientras
   │   se resuelve (contención)
   └── La lección: nunca dejemos una cuenta corporativa
       con un único factor personal inrecuperable
```

### 9.4. 2FA y automatización

Los flujos automáticos no usan 2FA; usan secretos. Por eso la disciplina de secretos (capítulo anterior y sección 15) es el «2FA» de la automatización: mínimos permisos, rotación y control de acceso a los propios secretos.

---

## 10. Resumen

En este capítulo aprendiste que:

* la autenticación verifica identidad, y la 2FA exige dos factores de tipos distintos: algo que sabes y algo que posees (o eres);
* «dos pasos» con el mismo canal o dos secretos que sabes no es multifactor de verdad;
* GitHub ofrece aplicación TOTP (código cada 30 segundos), llaves de seguridad FIDO2 (resistentes al phishing) y llaves de recuperación (boleto de emergencia);
* la activación tiene tres tiempos: configurar el método, verificarlo y guardar las llaves de recuperación fuera del equipo;
* el QR de activación es una credencial: escanear y no guardar la imagen;
* los códigos TOTP dependen del reloj del dispositivo y caducan en segundos;
* la 2FA protege el inicio de sesión, no los tokens ni las claves ya emitidos: la respuesta ante compromiso incluye revocarlos;
* perder el móvil es un incidente resoluble con llaves de recuperación; perder ambos es un problema largo: por eso se guardan en sitios distintos;
* en el nivel profesional, la 2FA puede ser obligatoria por organización y las llaves físicas son la respuesta en equipos de alto riesgo.

La idea principal es:

> **La 2FA convierte la contraseña filtrada en un intento fallido. Su verdadero valor aparece cuando la pierdes: por eso la recuperación se prepara antes de necesitarla.**

---

## Próximo paso

Tu cuenta está protegida en capas.

El siguiente paso es entender las organizaciones: cómo se trabaja en equipo bajo una misma identidad, roles y permisos.

Continúa con:

[`06-organizaciones.md`](06-organizaciones.md)
