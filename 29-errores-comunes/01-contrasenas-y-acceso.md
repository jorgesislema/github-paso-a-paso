# Contraseñas y acceso

## Introducción

Esta sección es un **manual de diagnóstico**: situaciones reales, qué significa cada error y cómo salir. El capítulo 1 cubre el escenario más urgente de todos — **no puedo entrar**: contraseña olvidada, cuenta bloqueada, token inválido o segundo factor perdido. Aquí Git y GitHub se separan con claridad: la contraseña de GitHub es cosa de la plataforma; la contraseña de SSH/HTTPS de Git es cosa de tu máquina.

---

## Mapa conceptual de este capítulo

```text
Contraseñas y acceso
       │
       ├── 1. Olvidé mi contraseña de GitHub
       ├── 2. No me deja clonar/push (autenticación)
       │   ├── 3. Token o credencial inválida
       │   └── 4. Segundo factor inaccesible
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Olvidé mi contraseña de GitHub

```text
RUTA (la plataforma la resuelve):
   │
   ├── 1. «Forgot password» en el login → correo de
   │   recuperación (Error 1 si el correo también lo
   │   perdiste: ve al soporte de la plataforma con
   │   identificación — no hay atajo)
   ├── 2. restablece desde un dispositivo de confianza
   ├── 3. si tienes 2FA: pide código de recuperación o
   │   segundo factor (punto 4)
   └── 4. después de entrar: revisa sesiones activas y
       tokens (sección 08/20 — Error 2 si no lo revisas:
       la cuenta «rescatada» sigue abierta a lo viejo)
```

```text
   │
   └── esto NO afecta tu trabajo local: tus commits y
       ramas están en tu disco; solo pierdes ACCESO
       REMOTO hasta recuperar (Error 3 si crees que
       «se perdió el proyecto»: nada del repo local se
       borra por esto)
```

---

## 2. No me deja clonar/push (autenticación)

```text
DIAGNÓSTICO EN 3 PREGUNTAS:
   │
   ├── ¿el ERROR dice «authentication»/«Access denied»?
   │   → credencial (punto 3) — no es problema de Git
   │
   ├── ¿dice «Permission denied (publickey)»? → SSH:
   │   clave no registrada o agente sin llaves (Error 4
   │   si nunca configuraste SSH y estás probándolo: usa
   │   HTTPS con token — sección 06 cap. 05)
   │
   └── ¿solo FALLA UN REPO? → permisos de ese repo (punto
       Error 5 — eres lector, no escritor: sección 08
       cap. 04)
```

```text
PRUEBA RÁPIDA:
   │
   ├── `git ls-remote origin` → ¿autentica?
   └── con Git Credential Manager (Windows/macOS): el
       navegador se abre — si falla ahí, es cuenta/token,
       no Git (Error 3 prevención — sección 01:
       Git vs. GitHub)
```

---

## 3. Token o credencial inválida

```text
CUÁNDO PASA:
   │
   ├── expiró (Error 7 si tu token no tenía caducidad
   │   marcada: los tokens temporales mueren — sección 08
   │   cap. 06)
   ├── lo revocaste y sigues usándolo
   ├── scope insuficiente (Error 8 si el token es de
   │   solo lectura y haces push)
   └── lo escribiste mal al guardarlo en el gestor
```

```text
SOLUCIÓN:
   │
   ├── genera token NUEVO con permisos mínimos que
   │   necesites (sección 20 cap. 05)
   ├── guárdalo en el gestor de credenciales (NO en
   │   archivos del repo — sección 20 cap. 01)
   └── si el token viejo estaba en un archivo: ROTAR y
       limpiar (Error 9 si solo lo borraste del working
       tree: sigue en el historial — sección 20 cap. 01
       Error 1)
```

---

## 4. Segundo factor inaccesible

```text
ESCENARIO: perdiste el teléfono / app TOTP
   │
   ├── usa CÓDIGOS DE RECUPERACIÓN que guardaste al
   │   activar 2FA (Error 10 si no guardaste ninguno:
   │   es el error más común)
   │
   ├── sin códigos: proceso de recuperación de la
   │   plataforma (puede requerir espera/identificación)
   │
   └── LECCIÓN: guarda códigos de recuperación fuera
       del dispositivo principal (Error 10 prevención)
```

```text
   │
   └── para Git esto solo afecta LOGIN: una vez dentro,
       genera token/clave nueva y sigue (punto 3)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «olvidé la contraseña» y el correo también está perdido

**Qué ocurrió:** sin acceso al correo de recuperación.

**Por qué:** dependencia de un solo canal de recuperación.

**Cómo comprobarlo:** ¿puedes entrar a ese correo desde otro sitio?

**Opciones:** recuperación del correo primero; luego la plataforma; soporte con identificación si hace falta.

**Riesgos:** perder el correo = perder el punto de entrada a todo lo demás.

**Solución:** recuperar el canal de correo (punto 1).

**Cómo se evita:** correo con recuperación configurada y códigos de 2FA guardados fuera del teléfono.

---

### Error 2: cuenta rescatada sin revisar sesiones

**Qué ocurrió:** recuperada la contraseña, sesiones y tokens viejos siguieron activos.

**Por qué:** no se revisó nada tras recuperar (punto 1 Error 2).

**Cómo comprobarlo:** lista de sesiones activas y tokens personales.

**Opciones:** cerrar sesiones, revocar tokens, activar 2FA si no estaba.

**Riesgos:** el incidente original (¿robo?) sigue abierto.

**Solución:** higiene post-recuperación (punto 1).

**Cómo se evita:** checklist de recuperación (punto 1).

---

### Error 3: creer que el proyecto se perdió

**Qué ocurrió:** pánico: «no entro a GitHub, se fue todo».

**Por qué:** confundir acceso remoto con el repositorio (punto 1 Error 3).

**Cómo comprobarlo:** `git log` en local — todo está ahí.

**Opciones:** recuperar acceso; el trabajo local no se toca.

**Riesgos:** pánico que lleva a acciones arriesgadas (recrear repo, reescribir).

**Solución:** saber qué vive dónde (Error 3 prevención — sección 01: Git vs. GitHub).

**Cómo se evita:** clonar en máquinas/cuentas con respaldo (sección 08/22).

---

### Error 4: probar SSH sin haberlo configurado

**Qué ocurrió:** «Permission denied (publickey)» en un repo que siempre usaste por HTTPS.

**Por qué:** cambio de método sin setup (Error 4 punto 2).

**Cómo comprobarlo:** `ssh -T git@github.com` — ¿autentica?

**Opciones:** generar clave, añadirla a la cuenta; o volver a HTTPS con token (punto 3).

**Riesgos:** horas perdidas creyendo que «Git se rompió».

**Solución:** elegir un método y configurarlo (sección 06 cap. 05).

**Cómo se evita:** documentar tu método en tu entorno (README personal).

---

### Error 5: permisos de un solo repositorio

**Qué ocurrió:** push a un repo: «Permission denied»; a los demás, normal.

**Por qué:** eres lector en ese repo (Error 5 punto 2).

**Cómo comprobarlo:** ajustes del repo: ¿tu rol?

**Opciones:** pedir escritura al dueño (sección 16) o trabajar por PR desde tu fork.

**Riesgos:** soluciones globales (cambiar toda la configuración) para un caso local.

**Solución:** rol correcto en ese ámbito (sección 08 cap. 04).

**Cómo se evita:** saber tu rol antes de empezar (issue de acceso al entrar a un equipo).

---

### Error 6: token expirado o con scope insuficiente

**Qué ocurrió:** ayer funcionaba, hoy «Repository not found» o «Write access denied».

**Por qué:** token muerto o de permisos cortos (punto 3).

**Cómo comprobarlo:** generar token nuevo, probar con `git ls-remote`.

**Opciones:** renovar con permisos mínimos necesarios; actualizar gestor de credenciales.

**Riesgos:** tokens «de todo» para arreglar un fallo (Error 8 sección 20 cap. 05).

**Solución:** token nuevo y mínimo (punto 3).

**Cómo se evita:** inventario y rotación de tokens (sección 20 cap. 01).

---

### Error 7: token que estaba en un archivo del repo

**Qué ocurrió:** al «limpiar» un token descubriste que quedó en commits viejos.

**Por qué:** solo se borró del árbol actual (punto 3 Error 9).

**Cómo comprobarlo:** buscar en historial; secret scanning (sección 20 cap. 02).

**Opciones:** rotar YA + plan de limpieza de historia si procede (Error 1 — sección 20 cap. 01).

**Riesgos:** exposición permanente.

**Solución:** rotación primero, historia después (sección 20 cap. 01).

**Cómo se evita:** push protection desde el día 1 (sección 20 cap. 02).

---

### Error 8: sin códigos de recuperación de 2FA

**Qué ocurrió:** móvil perdido y códigos nunca guardados.

**Por qué:** sin respaldo del segundo factor (punto 4).

**Cómo comprobarlo:** ¿guardaste los códigos en algún sitio que no sea el teléfono?

**Opciones:** recuperación formal de la plataforma (lenta); identificación si la piden.

**Riesgos:** bloqueo prolongado de cuenta.

**Solución:** códigos de recuperación guardados fuera (punto 4).

**Cómo se evita:** checklist de seguridad personal: códigos + 2FA + correo de respaldo.

---

## 6. Práctica guiada

### Objetivo

Que tu acceso sea recuperable y tus credenciales mínimas — antes de que lo necesites.

### Paso 1: prueba de recuperación

1. ¿Sabes dónde están: códigos de 2FA, correo de recuperación, tokens vigentes? Escríbelo.

### Paso 2: revisión

1. Sesiones activas + tokens personales: ¿cuáles usas? Revoca el resto.

### Paso 3: método de Git

```text
Tu método: HTTPS+token / SSH
   │
   └── `git ls-remote origin` → ¿autentica ahora?
```

### Paso 4: credenciales mínimas

1. Regenera tu token con el mínimo que necesites y guárdalo en el gestor (punto 3).

### Paso 5: acceso por repo

1. En un repo donde trabajes: ¿cuál es tu rol? (punto 2 Error 5). Si es lector, pide escritura o trabaja por fork+PR.

### Paso 6: respaldo del canal

1. Códigos de 2FA guardados en papel/gestor fuera del teléfono.

### Resultado esperado

Acceso verificado con método único claro, credenciales mínimas rotadas y recuperación preparada.

### Conclusión esperada

«Olvidé la contraseña» deja de ser una crisis cuando la recuperación, los códigos y los tokens mínimos estaban pensados de antemano — el acceso es parte del diseño de tu entorno, no de la suerte.

---

## 7. Nivel profesional + resumen

### 7.1. Acceso en un entorno de trabajo

```text
   │
   ├── en empresa: el acceso lo da el ADMINISTRADOR
   │   (SSO/centralizado) — aquí aprendiste a
   │   diagnosticarlo, allí a pedirlo con el vocabulario
   │   correcto (sección 08/16)
   │
   ├── tokens con caducidad y mínimo privilegio es la
   │   política real de cualquier organización (sección
   │   20)
   │
   ├── la separación «plataforma vs. Git» te permite
   │   diagnosticar en 3 preguntas (Error 1 prevención
   │   — sección 01)
   │
   └── métrica personal: ¿puede tu equipo recuperar el
       acceso en < 1 hora si desaparece TU configuración?
       (bus factor — sección 23 cap. 06)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* contraseña de GitHub → recuperación de plataforma; credencial de Git → gestor/clave en tu máquina;
* el diagnóstico de autenticación son 3 preguntas: ¿dice auth? ¿dice publickey? ¿es solo un repo?;
* tokens: nuevos, mínimos, en el gestor — y si tocaron un archivo, se rotan y se mira el historial;
* 2FA exige códigos de recuperación fuera del dispositivo principal;
* los errores típicos (correo perdido, sesiones sin revisar, pánico de pérdida, SSH sin setup, rol local, token muerto, token en historial, códigos ausentes) se previenen con preparación;
* a nivel profesional: acceso centralizado, tokens con política y respaldo contra bus factor.

La idea principal es:

> **Los problemas de acceso se resuelven en minutos cuando sabes qué capa falla — plataforma, credencial o permiso — y en días cuando hay que descubrirlo bajo presión: la preparación es la diferencia.**

---

## Próximo paso

Acceso resuelto.

Ahora los problemas del historial: commits equivocados, resets y commits perdidos.

Continúa con:

[`02-commits-y-historial.md`](02-commits-y-historial.md)
