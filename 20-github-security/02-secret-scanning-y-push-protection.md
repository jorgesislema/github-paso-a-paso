# Secret scanning y push protection

## Introducción

Los humanos se equivocan; la defensa que funciona es la automática. GitHub escanea cada push y cada diff público buscando credenciales conocidas (PATs, API keys, claves privadas) y puede bloquear el envío antes de que el secreto entre en el historial. Este capítulo explica cómo funciona el escaneo, qué es la protección en el push, cómo actuar si se recibe una alerta y cómo complementar con controles locales.

---

## Mapa conceptual de este capítulo

```text
Secret scanning y push protection
       │
       ├── 1. Cómo escanea GitHub
       ├── 2. Push protection: bloquear antes del daño
       ├── 3. Alertas: qué hacer, cuándo y quién
       │   ├── 4. Escaneo propio y complementos
       │   └── 5. Mecanismos de revocación de plataformas
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. Cómo escanea GitHub

```text
DÓNDE SE MIRA:
   │
   ├── cada push al repo (y PRs)
   ├── diffs y contenidos de archivos
   └── — si está activado — el historial completo al
       activar (y releases)
```

```text
QUÉ SE BUSCA:
   │
   ├── patrones de proveedores conocidos (decenas de
   │   tipos: nubes, pagos, SAAS, mensajería)
   │
   ├── claves privadas (BEGIN … PRIVATE KEY)
   │
   └── formato genérico de alto secreto cuando
       proceda
```

```text
QUÉ NO HACE (realidad):
   │
   ├── no entiende tu secreto casero sin patrón
   ├── no sustituye rotación ni inventario (cap. 01)
   └── detecta ≠ remedia: quien recibe la alerta
       decide (punto 3)
```

```text
   │
   └── filosofía: el escaneo es la red; tus controles
       (higiene, CI, formación) son la prevención
```

---

## 2. Push protection: bloquear antes del daño

```text
PUSH PROTECTION:
   │
   ├── el push se RECHAZA si contiene un secreto
   │   detectado → ni entra al historial
   │
   ├── el error del push señala el archivo/patrón y
   │   cómo resolverlo (quitar y volver a enviar)
   │
   └── disponible según plan/configuración del repo u
       organización (activable en settings de
       seguridad)
```

```text
   │
   └── con push protection la respuesta «rotar»
       puede no ser necesaria (el secreto nunca se
       publicó) — pero conviene revisar por qué estaba
       ahí
```

```text
MOMENTO DE LA DEFENSA:
──────────────────────────────────────────────────────
ANTES del push:  hooks locales (punto 4) + revisión
EN el push:      push protection (bloquea)
DESPUÉS:         alerta de secret scanning → respuesta
                 (cap. 01 punto 5)
```

---

## 3. Alertas: qué hacer, cuándo y quién

```text
FLUJO DE UNA ALERTA:
   │
   ├── 1. asignar (dueño — generalmente seguridad o el
   │   que la detectó)
   │
   ├── 2. verificar: ¿es un secreto real? (¿prueba?
   │   ¿placeholder?)
   │   ├── falso positivo → marcarlo como tal
   │   └── real → 3. ROTAR en el proveedor (primero)
   │
   ├── 4. limpiar si ya está en el historial (cap. 01
   │   punto 5)
   │
   ├── 5. resolver la alerta en GitHub (verificación
   │   automática de revocación cuando el proveedor lo
   │   permite — plataformas socias)
   │
   └── 6. post-mortem: ¿qué control evita la
       repetición?
```

```text
TIEMPOS:
   │
   ├── secreto en repo público → horas (scrapers)
   ├── secreto en privado → días/semanas (no confiar)
   └── meta interna: rotar en < 1 hora desde la
       detección
```

```text
PERMISOS Y FLUJO:
   │
   ├── quién ve alertas: administradores + seguridad
   │   (según configuración)
   │
   └── en org: pipeline hacia el equipo de seguridad —
       alerta sin dueño = alerta olvidada (Error 6)
```

---

## 4. Escaneo propio y complementos

```text
NIVELES:
   │
   ├── plataforma: secret scanning + push protection
   │   (cap. 02 — este)
   │
   ├── git hooks locales (pre-commit): herramientas
   │   tipo «detectores de secretos» en el equipo —
   │   corren ANTES del commit (sección 13)
   │
   ├── CI: escaneo en cada PR (acción/step dedicado)
   │   → cubre ramas y submódulos
   │
   └── historial: escaneo puntual tras incidente o al
       activar (complementa al día a día)
```

```text
EJEMPLO DE PASO DE CI (conceptual — usa el detector
que elijas):
   │
   ├── step con action de detección de secretos
   ├── falla el job si encuentra algo
   └── solo lectura: no publica nada, solo reporta
```

```text
   │
   └── el combo práctico: hook local + CI + push
       protection + alertas con dueño
```

---

## 5. Mecanismos de revocación de plataformas

```text
CUANDO UN PROVEEDOR ES SOCIO:
   │
   ├── la plataforma detecta y puede notificar al
   │   proveedor (revoke) automáticamente
   │
   └── tu parte: seguir la alerta hasta «verificado
       revocado» y rotar igualmente por prudencia
```

```text
CUANDO NO LO ES:
   │
   ├── rotación manual en el panel del proveedor
   │
   └── documenta en el inventario (cap. 01) el enlace
       de revocación de cada tipo — en el incidente
       no hay tiempo de buscar menús
```

```text
   │
   └── regla: mientras no veas «revocado», el token
       sigue vivo aunque ya no esté en el repo
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: alertas silenciadas o resueltas sin rotar

**Qué ocurrió:** alguien marcó la alerta como resuelta tras borrar el archivo — el token siguió vivo.

**Por qué:** se confundió «resolver en GitHub» con «remediar».

**Cómo comprobarlo:** historial de alertas y si hubo rotación en el proveedor.

**Opciones:** rotar ahora + verificar revocación; reabrir práctica de auditoría.

**Riesgos:** acceso no detectado con tiempo de sobra.

**Solución:** rotar primero, alerta después (punto 3).

**Cómo se evita:** flujo escrito de alertas con checklist.

---

### Error 2: push protection desactivado

**Qué ocurrió:** el secreto entró al historial y se enteraron por una alerta (o por un tercero).

**Por qué:** la protección estaba off por defecto o se desactivó «para no molestar».

**Cómo comprobarlo:** settings de seguridad del repo/org.

**Opciones:** activar; corregir la causa de los bloqueos (los devs deben guardar secretos en su sitio).

**Riesgos:** prevención ausente (solo detección a posteriori).

**Solución:** activar la capa de bloqueo (punto 2).

**Cómo se evita:** incluir seguridad de plataforma en el checklist de repos (sección 18).

---

### Error 3: se bloquea el push y el equipo lo fuerza

**Qué ocurrió:** ante el bloqueo se sacó el secret del .gitignore para «commitar igual».

**Por qué:** se priorizó la velocidad sobre el control.

**Cómo comprobarlo:** intentos repetidos de push; historial.

**Opciones:** explicar: guardar en .env / CI secrets; si el push fue con bypass, incidente de proceso.

**Riesgos:** la defensa queda inútil.

**Solución:** el bloqueo se respeta; el secreto se muda (punto 2).

**Cómo se evita:** formación + plantillas (punto 4 de la sección 13).

---

### Error 4: solo confiar en el escaneo de la plataforma

**Qué ocurrió:** secretos caseros (sin patrón) entraron porque «GitHub los revisa».

**Por qué:** se sobredimensionó una herramienta.

**Cómo comprobarlo:** qué detecta y qué no (punto 1); revisar commits propios.

**Opciones:** añadir CI con detector y hook local; formación en qué es un secreto.

**Riesgos:** falsa seguridad.

**Solución:** defensa en capas (punto 4).

**Cómo se evita:** no depender de un solo control.

---

### Error 5: secretos en artefactos/ramas cerradas sin revisar

**Qué ocurrió:** el escaneo del push principal estaba bien, pero un artefacto de CI contenía un token.

**Por qué:** los artefactos no son «push» (punto 2: dónde se mira).

**Cómo comprobarlo:** inspección de artefactos (sección 19 cap. 05).

**Opciones:** rotar; restringir paths; escaneo en CI.

**Riesgos:** exposición «por la ventana trasera».

**Solución:** escaneo en CI también (punto 4).

**Cómo se evita:** checklist de artefactos.

---

### Error 6: alerta sin dueño ni SLA

**Qué ocurrió:** cientos de alertas abiertas; nadie sabe cuáles son reales.

**Por qué:** no hubo asignación ni métrica.

**Cómo comprobarlo:** nº de alertas abiertas y su antigüedad.

**Opciones:** dueño + SLA (punto 3); cerrar falsos positivos con criterio documentado.

**Riesgos:** ruido → se ignoran las reales.

**Solución:** flujo con dueño y tiempo (punto 3).

**Cómo se evita:** revisión mensual de seguridad (sección 18/24).

---

## 7. Práctica guiada

### Objetivo

Activar y vivir el flujo completo de detección en un repo de práctica.

### Paso 1: activa defensas

1. Settings → seguridad: secret scanning y push protection (según tu plan).
2. Anota si tu plan no los ofrece: lo compensas con CI + hook (paso 3).

### Paso 2: simulación controlada

```text
   │
   ├── crea un archivo con un PAT de prueba de un
   │   proveedor soportado (un token YA revocado o
   │   inventado con formato válido)
   ├── intenta hacer push (o déjalo en un PR si
   │   probamos solo detección)
   └── observa: ¿bloqueo con mensaje? ¿alerta?
```

1. Documenta el mensaje exacto que vio el equipo (lo usarás en el playbook).

### Paso 3: escaneo propio

```yaml
# esquema de paso en tu workflow de CI:
# - name: Escaneo de secretos
#   uses: <detector-elegido>@<versión-fijada>
#   con: { tu configuración }
```

1. Elige un detector (de código abierto o el que ofrezca tu plan), fíjalo (sección 19 cap. 05) y hazlo fallar el job si hay hallazgo.

### Paso 4: hook local (opcional pero recomendable)

```text
   │
   ├── en la plantilla del equipo: hook pre-commit que
   │   ejecute el detector
   └── sección 13: hooks no versionados por defecto →
       instalar con script (sección 06 cap. 05)
```

### Paso 5: playbook de alerta

```markdown
## Alerta de secreto
1. Asignar (dueño) — inmediato
2. ¿Real? → ROTAR en el proveedor (enlace en
   docs/rotacion.md)
3. ¿En historial? → purga (guía) + aviso
4. Resolver en GitHub con verificación
5. Post-mortem en < 24 h
```

### Paso 6: métrica

1. Anota: nº alertas abiertas y tiempo medio a rotación (aunque empiece en 0 — la métrica existe).

### Resultado esperado

Defensas activadas, simulación documentada, detector en CI y playbook de alertas.

### Conclusión esperada

Detectar es bueno; bloquear es mejor; y rotar con dueño y tiempo es obligatorio — los tres, juntos.

---

## 8. Nivel profesional + resumen

### 8.1. Detección a escala

```text
   │
   ├── org: push protection + secret scanning en TODOS
   │   los repos (plantilla de repo — sección 18)
   │
   ├── CI con detector fijado en la plantilla base
   │
   ├── alertas → canal del equipo de seguridad con SLA
   │
   ├── proveedores socios → revocación verificada;
   │   resto → enlaces de revocación en el inventario
   │
   ├── métricas: alertas abiertas, tiempo medio de
   │   rotación, bloqueos de push
   │
   └── combinación con Dependabot/CodeQL (caps. 03/04)
       en el panel de seguridad del repo
```

### 8.2. Resumen

En este capítulo aprendiste que:

* el escaneo mira cada push/diff con patrones de proveedores y claves privadas — detecta, no remedia;
* push protection bloquea el secreto ANTES de entrar al historial;
* una alerta real: asignar → verificar → ROTAR → limpiar → resolver con verificación → post-mortem;
* complementar con CI, hooks locales y escaneo de historial/incidentes;
* los errores típicos (resolver sin rotar, protección off, forzar el push, confianza ciega, huecos en artefactos, alertas sin dueño) se previenen con flujo escrito;
* a nivel profesional: defensa en capas con métricas.

La idea principal es:

> **La red que importa bloquea el secreto antes del commit; la que llega tarde solo convierte una detección en un incidente — y aun así, la respuesta empieza siempre por rotar.**

---

## Próximo paso

Ya tienes la capa de credenciales automatizada.

La siguiente defensa: las dependencias que instalas.

Continúa con:

[`03-dependabot-y-dependencias.md`](03-dependabot-y-dependencias.md)
