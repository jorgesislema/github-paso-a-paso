# Secretos y credenciales

## Introducción

La seguridad de un repositorio empieza por una verdad incómoda: el código es visible y el historial es inmutable — cualquier credencial que entre ahí queda comprometida. Contraseñas, tokens, claves SSH y API keys tienen hogares propios; este capítulo los enumera, explica dónde vive cada uno y cómo se gestiona su ciclo de vida sin que termine nunca en un commit.

La regla fundamental: **un repositorio no debe convertirse accidentalmente en un lugar donde se publiquen secretos.**

---

## Mapa conceptual de este capítulo

```text
Secretos y credenciales
       │
       ├── 1. Catálogo: qué es cada cosa
       │   ├── 2. Dónde vive cada credencial
       │   ├── 3. Ciclo de vida: crear, usar, rotar
       │   ├── 4. SSH: claves de identidad
       │   └── 5. El historial: qué pasa si entró
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Catálogo: qué es cada cosa

```text
TIPO           QUÉ ES                    RIESGO TÍPICO
────────────────────────────────────────────────────────
Contraseña     clave de cuenta           reuse, phishing
PAT/token      acceso por API a cuenta   scope amplio,
               u organización            sin caducidad
Token de OAuth app  delegación a app     revocación
API key        acceso a servicio ext.    hardcodeada en
                                         código
Clave SSH      identidad git/SSH         sin passphrase,
                                         en disco
Secreto de     valor que CI necesita     en repo o log
Actions
Certificado   firma/provisión           expiración
(DTA/mención)
```

```text
   │
   ├── «no meterlo al repo» es el 90%; el otro 10%
   │   es rotación y alcance mínimo
   │
   └── todo token debería responder: ¿para qué,
       quién lo pidió, cuándo caduca, cómo se revoca
```

---

## 2. Dónde vive cada credencial

```text
LUGARES CORRECTOS:
   │
   ├── cuentas/organización → 2FA, revocación,
   │   alcance (scope) mínimo
   │
   ├── gestor de secretos (empresa) → vaults /
   │   secret managers de nube (mención: categoría)
   │
   ├── GitHub: repository/environment secrets
   │   (sección 19 cap. 04) para CI/CD
   │
   ├── Git local: ~/.ssh (claves), credential
   │   helpers (guardado del SO) — NO en el repo
   │
   └── entorno local: .env versionado NO (sección 13
       cap. 05)
```

```text
LUGARES INCORRECTOS (y por qué):
   │
   ├── el código (nunca — ni «temporal»)
   ├── el historial (irreversible sin purga)
   ├── issues/PRs/discusiones públicas (indexables)
   ├── artefactos y cachés de CI (descargables)
   └── logs (aunque haya enmascaramiento — cap. 04 de
       la sección 19)
```

```text
PRINCIPIO DE ALCANCE MÍNIMO:
   │
   ├── token solo con los permisos necesarios
   │   (read, repo concreto, entorno concreto)
   │
   ├── caducidad corta cuando la plataforma lo permite
   │
   └── un token por función (despliegue ≠ lectura)
```

---

## 3. Ciclo de vida: crear, usar, rotar

```text
CICLO
──────┬───────────────────────────────────────────────
 1. CREAR   · justificación escrita · scope mínimo
             · dueño asignado · fecha de rotación
 2. USAR    · solo donde vive (CI secret store /
             gestor) · sin imprimir en logs
 3. ROTAR   · calendario o tras sospecha · la
             antigua se revoca (no solo «se cambia»)
 4. REVOCAR · al baja de persona, fin de proyecto o
             incidente · verificar que dejó de valer
 5. AUDITAR · inventario trimestral: ¿sigue vivo?
             ¿de quién? ¿sigue necesitándose?
```

```text
ROTACIÓN POR INCIDENTE (flujo fijo — sección 13 cap.
05):
   │
   ├── rotar PRIMERO, purgar después
   ├── acotar: quién pudo verlo (logs, forks, tiempo)
   ├── limpiar historial si procede (filter-repo)
   └── post-mortem: qué control faltó
```

```bash
# revisión local de «¿qué credenciales tengo
# expuestas en este repo?» (además del escaneo
# automatizado — cap. 02):
git log -p --all -S "ghp_" --oneline   # búsqueda en
                                        # historial
```

---

## 4. SSH: claves de identidad

```text
QUÉ ES (en este contexto):
   │
   └── par de claves que identifica tu cuenta ante el
       servidor git: la privada es tuya y secreta; la
       pública la pegas en la cuenta
```

```bash
# creación conceptual (ed25519, la práctica actual):
ssh-keygen -t ed25519 -C "tu@correo"
# la privada: ~/.ssh/id_ed25519  (NUNCA en el repo)
# la pública: ~/.ssh/id_ed25519.pub → cuenta de GitHub
```

```text
BUENAS PRÁCTICAS:
   │
   ├── passphrase en la clave privada (o gestor de
   │   claves del SO)
   │
   ├── una clave por propósito/equipo; revocar al
   │   marcharse
   │
   ├── máquinas CI: claves efímeras o mejor OIDC/
   │   tokens de corta vida (sección 19/22)
   │
   └── añadir la pública SOLO en tu cuenta (nunca
       commitear la privada «para pruebas»)
```

```text
   │
   └── si la privada se subió: es un incidente de
       identidad → revocar/quitar clave de la cuenta
       Y evaluar alcance (cap. 5)
```

---

## 5. El historial: qué pasa si entró

```text
SEÑALES DE QUE ENTRÓ:
   │
   ├── secret scanning la marcó (cap. 02)
   ├── búsqueda manual en el log (punto 3)
   └── alguien lo reporta
```

```text
RESPUESTA (orden — sección 13 cap. 05):
   │
   ├── 1. ROTAR (siempre, aunque creas que «nadie lo
   │   vio»)
   ├── 2. acotar exposición: ¿repo público? ¿forks?
   │   ¿cuánto tiempo?
   ├── 3. purgar historial (filter-repo) si procede +
   │   reparto con aviso
   │   ├── 4. verificar: escaneo del historial limpio
   │   └── 5. post-mortem + control nuevo (push
   │       protection, hook, formación)
   │
   └── nunca: «borrar el archivo actual» y dar por
       cerrado (Error clásico — sección 13)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: API key hardcodeada «temporal»

**Qué ocurrió:** la clave quedó en el código «solo para probar» y entró al historial.

**Por qué:** atajo sin guardar en el sitio correcto.

**Cómo comprobarlo:** secret scanning / búsqueda (punto 3).

**Opciones:** rotar + seguir la respuesta del punto 5.

**Riesgos:** uso por terceros (automatizado).

**Solución:** el «temporal» no existe: vive en .env/CI secret store.

**Cómo se evita:** plantilla con .env.example + push protection (cap. 02).

---

### Error 2: token con scope completo

**Qué ocurrió:** un PAT de «lectura» en realidad tenía admin:org — y se filtró.

**Por qué:** se creó con todos los checkboxes para que funcionara ya.

**Cómo comprobarlo:** leer scopes del token en la cuenta.

**Opciones:** recrear con alcance mínimo; revocar el amplio.

**Riesgos:** blast radius enorme.

**Solución:** alcance mínimo y por función (punto 2).

**Cómo se evita:** revisión de tokens en la auditoría trimestral.

---

### Error 3: credenciales compartidas entre personas

**Qué ocurrió:** un token de deploy «del equipo» en un canal de chat y en la cabeza de cinco personas.

**Por qué:** se evitó la gestión individual.

**Cómo comprobarlo:** inventario: ¿de quién es? ¿quién lo conoce?

**Opciones:** migrar a secretos por environment con dueño; rotar; prohibir compartir por chat.

**Riesgos:** nadie puede revocar sin parar a todos; rotación imposible.

**Solución:** credencial = dueño único o environment controlado.

**Cómo se evita:** regla escrita de «no compartir tokens».

---

### Error 4: clave SSH sin passphrase en disco compartido

**Qué ocurrió:** la clave privada estaba sin cifrar en una máquina con varios usuarios.

**Por qué:** comodidad en la generación.

**Cómo comprobarlo:** pedir passphrase al usarla; revisar dónde vive.

**Opciones:** regenerar con passphrase; añadir a agente con caducidad; revocar la vieja en la cuenta.

**Riesgos:** identidad robada.

**Solución:** passphrase + una clave por propósito (punto 4).

**Cómo se evita:** checklist de alta de equipo.

---

### Error 5: secretos en issues/chats como «ayuda rápida»

**Qué ocurrió:** para pedir ayuda se pegó la config completa con credenciales en un hilo público.

**Por qué:** prisa por contexto.

**Cómo comprobarlo:** revisar antes de publicar; si ya se publicó: rotar + limpiar (editar si es posible).

**Riesgos:** indexación rápida (scrapers de secretos).

**Solución:** placeholders siempre (TU_API_KEY_AQUI).

**Cómo se evita:** plantilla de pregunta con aviso (sección 16 cap. 05).

---

### Error 6: sin inventario (no se puede rotar lo que no se sabe)

**Qué ocurrió:** incidente y nadie sabe qué tokens existen ni dónde se usan.

**Por qué:** nunca hubo registro.

**Cómo comprobarlo:** intentar listar: ¿hay tabla? ¿dueños?

**Opciones:** construir inventario YA (creados, dueño, ámbito, rotación, uso); empezar por los de producción.

**Riesgos:** respuesta lenta en el peor momento.

**Solución:** inventario como parte de gobernanza (sección 18 cap. 06).

**Cómo se evita:** calendario de revisión (punto 3).

---

## 7. Práctica guiada

### Objetivo

Auditar credenciales de un proyecto de práctica y montar su gestión.

### Paso 1: inventario

```text
Tabla (hoja o docs/):
   │
   ├── credencial · tipo · dónde vive · dueño ·
   │   permisos · rotación · caducidad
   └── rellena con TODO lo que se te ocurra en el
       proyecto (PATs, SSH, keys externas, secretos
       de Actions)
```

### Paso 2: caza en el historial

```bash
git log --all -p -S "ghp_" --oneline
git log --all -p -S "AKIA" --oneline
git log --all -p -S "BEGIN PRIVATE KEY" --oneline
# (patrones de ejemplo; el escaneo real: cap. 02)
```

1. Si algo aparece: practica mentalmente la respuesta del punto 5 (rotar primero).

### Paso 3: alcance mínimo

1. Revisa un PAT real de tu cuenta: ¿qué scopes tiene? ¿los necesita todos?
2. Crea uno nuevo con el mínimo y anota la fecha de rotación.

### Paso 4: SSH

```bash
ssh-keygen -t ed25519 -C "practica@ejemplo"
# pública → cuenta; privada → NO subirla; passphrase
```

1. Comprueba que la privada no está en el repo (búsqueda).

### Paso 5: CI

1. Mueve cualquier valor sensible de un workflow a `secrets` por environment (sección 19 cap. 04).

### Paso 6: calendario

```text
Añade a la revisión trimestral:
   │
   ├── inventario actualizado
   ├── tokens caducos revocados
   ├── dueños confirmados
   └── resultados del escaneo (cap. 02)
```

### Resultado esperado

Inventario completo, alcances mínimos, SSH con passphrase y calendario de rotación.

### Conclusión esperada

La credencial segura es la que tiene hogar, dueño y fecha — el repo nunca es su hogar.

---

## 8. Nivel profesional + resumen

### 8.1. Programa de identidad y secretos

```text
   │
   ├── inventario + dueño + caducidad + rotación
   │   (calendario)
   │
   ├── alcance mínimo y secretos por environment;
   │   OIDC donde exista (sección 19/22)
   │
   ├── 2FA obligatorio (cap. 06 de esta sección)
   │
   ├── detección: secret scanning + push protection
   │   (cap. 02) + hooks locales (sección 13)
   │
   ├── respuesta: runbook de incidente (rotar →
   │   acotar → purgar → verificar)
   │
   └── métricas: secretos con rotación al día, tiempo
       de respuesta a incidentes
```

### 8.2. Resumen

En este capítulo aprendiste que:

* catálogo de credenciales (contraseñas, PATs, API keys, SSH, secretos de CI) y su hogar correcto (gestor/CI/credhelper — nunca el repo);
* ciclo de vida: crear con alcance mínimo y dueño, usar sin exponer, rotar en calendario y tras incidente, revocar al fin;
* SSH: clave ed25519 con passphrase, privada fuera del repo, revocación al marcharse;
* si entró al historial: rotar primero, acotar, purgar, verificar, post-mortem;
* los errores típicos (key temporal, scope amplio, compartir tokens, SSH sin passphrase, secretos en chats, sin inventario) se previenen con registro y disciplina;
* a nivel profesional: programa con métricas de rotación y respuesta.

La idea principal es:

> **Una credencial sin hogar, dueño y fecha de caducidad es un incidente esperando: guárdala donde corresponde, alcánzala al mínimo y rótala antes de que la roten por ti.**

---

## Próximo paso

Ya sabes dónde viven las credenciales.

Ahora la defensa automática: cómo la plataforma detecta secretos antes de que entren.

Continúa con:

[`02-secret-scanning-y-push-protection.md`](02-secret-scanning-y-push-protection.md)
