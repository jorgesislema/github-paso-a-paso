# Push y pull

## Introducción

Manual de diagnóstico, capítulo 4: **la sincronización** — el momento en que tu historia local y el remoto se encuentran. Los escenarios: «hice push al repositorio equivocado», «me rechazaron el push», «no puedo hacer pull», «no puedo hacer push». Casi todos comparten una causa raíz: se ejecuta el comando ANTES de entender hacia dónde va y desde dónde sale. Este capítulo te da el mapa de decisiones.

---

## Mapa conceptual de este capítulo

```text
Push y pull
       │
       ├── 1. El mapa mental: dónde vive cada cosa
       ├── 2. Push al repositorio equivocado
       ├── 3. Push rechazado (rejected)
       │   ├── 4. No puedo hacer pull
       │   └── 5. No puedo hacer push
       │
       ├── 6. Errores comunes con diagnóstico completo
       ├── 7. Práctica guiada
       └── 8. Nivel profesional + resumen
```

---

## 1. El mapa mental: dónde vive cada cosa

```text
LOS TRES LUGARES (sección 03 — repaso):
   │
   ├── working tree / staging: TU máquina, TU rama
   ├── remoto (origin/<rama>): el servidor, rama común
   └── el navegador (GitHub): la INTERFAZ sobre el
       remoto — no es el remoto (Error 1 si confundes:
       «lo vi en la web» no significa «lo tengo local»)
```

```text
ANTES DE CADA PUSH/PULL — 4 PREGUNTAS:
   │
   ├── ¿a qué remoto? (`git remote -v`)
   ├── ¿a qué rama? (`git status -sb` — ¿ahead/behind?)
   ├── ¿qué commiteado / qué staged? (`git status`)
   └── ¿hay algo sin commitear que chocará?
       (`git log origin/<rama>..HEAD` y al revés)
```

```text
   │
   └── si no puedes responder las 4, NO ejecutes push
       ni pull (Error 2 prevención: 5 segundos de
       diagnóstico contra 30 minutos de limpieza)
```

---

## 2. Push al repositorio equivocado

```text
SÍNTOMA: subiste la rama/proyecto a un repo donde no
iba (Error 3 si abriste la URL equivocada en el
navegador: eso no empuja nada)
   │
   ├── PASO 1: NO entres en pánico ni hagas force
   │   (Error 4 si borras a ciegas: puedes borrar algo
   │   ajeno)
   │
   ├── PASO 2: ¿hay daño real? `git remote -v` y mira
   │   el historial del repo equivocado (¿qué ramas,
   │   qué commits aparecen?)
   │
   ├── PASO 3: si es contenido tuyo y privado → borrar
   │   ESA rama/ese push del repo equivocado con aviso
   │   a quien corresponda (sección 20 cap. 01: si hay
   │   datos sensibles, es incidente)
   │
   └── PASO 4: corregir la configuración local
       (`git remote set-url origin <url-correcta>`) y
       verificar `git remote -v` (Error 5 si no
       corriges la URL: el siguiente push se equivoca
       igual)
```

```text
CÓMO EVITARLO (Error 6):
   │
   ├── alias/README del proyecto con la URL correcta
   ├── `git remote -v` antes de cada push de un proyecto
   │   nuevo (Error 2 prevención)
   └── en monorepos/equipos: configuración remota
       revisada en PR (sección 15)
```

---

## 3. Push rechazado (rejected)

```text
MENSAJE CLÁSICO:
   ✗ [rejected] -> rama (fetch first / non-fast-forward)
```

```text
CAUSA:
   │
   ├── el remoto tiene commits que tú NO tienes: tu push
   │   sobrescribiría historia (Error 2 si lo
   │   fuerzas: pierdes los ajenos — sección 07 cap. 02)
   │
   └── NO es un fallo: es Git PROTEGIENDO (Error 3 si
       lo interpretas como «reparado»: lee el mensaje
       completo, casi siempre dice el paso exacto)
```

```text
SOLUCIÓN SEGURA:
   │
   ├── 1. `git pull --rebase origin <rama>` (Error 4 si
   │   eliges merge a ciegas: decide con criterio de la
   │   sección 07/15 — rebase tu trabajo encima del
   │   ajeno si no lo publicaste)
   │
   ├── 2. resolver conflictos si aparecen (Error 5 —
   │   capítulo 05 de esta sección)
   │
   ├── 3. reintentar `git push` (Error 6 si vuelve a
   │   rechazar: vuelve al paso 1 — ¿sigues sin
   │   sincronizar?)
   │
   └── 4. JAMÁS `--force` en rama compartida (sección
       07 — Error 7 si lo hiciste: la limpieza es
       problema de equipo)
```

---

## 4. No puedo hacer pull

```text
DIAGNÓSTICO EN 4 PASOS:
   │
   ├── 1. ¿autentica? `git ls-remote origin` → si falla:
   │   es acceso/token (Error 1 — sección 29 cap. 01)
   │
   ├── 2. ¿apunta bien el remoto? `git remote -v` (Error
   │   9: URL mal copiada = «repository not found»)
   │
   ├── 3. ¿está la rama? `git fetch origin` +
   │   `git branch -r` (Error 10 si pides una rama que
   │   no existe: «couldn't find remote ref»)
   │
   └── 4. ¿hay trabajo local que choca? `git status` →
       commitear o stashar ANTES del pull (Error 4 si
       haces pull con cambios sucios: Git se niega)
```

```text
PULL RECHAZADO POR DIVERGENCIA:
   │
   └── igual que el push rechazado: pull --rebase /
       merge con criterio, no force (Error 2 —
       punto 3)
```

---

## 5. No puedo hacer push

```text
DIAGNÓSTICO EN 5 PASOS:
   │
   ├── 1. ¿permisos? ¿es tu repo o ajeno? (Error 1 si
   │   eres lector: no puedes push — colabora con PR:
   │   sección 15/16)
   │
   ├── 2. ¿autentica? `git ls-remote origin` → si no:
   │   token/credencial (Error 1 — sección 29 cap. 01)
   │
   ├── 3. ¿está la rama protegida? (protegida = no
   │   directo; pasa por PR — si es tu repo, revisa la
   │   configuración de protección)
   │
   ├── 4. ¿rechazo por historia? (Error 3 punto 3 —
   │   pull --rebase)
   │
   └── 5. ¿error de tamaño/límites? (archivos grandes:
       Error 1 — Git LFS o respaldos, no el repo)
```

```text
   │
   └── orden SIEMPRE: ls-remote → status -sb →
       diagnóstico del mensaje → accionar (Error 2
       prevención)
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: empujar sin mirar remoto/rama

**Qué ocurrió:** push a la rama o repo que no era.

**Por qué:** sin las 4 preguntas (punto 1).

**Cómo comprobarlo:** `git remote -v` + `git log origin/<rama>..HEAD` — ¿qué salió?

**Opciones:** corregir URL con set-url; limpiar el destino con aviso (punto 2).

**Riesgos:** historial en el lugar equivocado, posible incidente.

**Solución:** diagnóstico previo (punto 1 Error 2).

**Cómo se evita:** checklist de 4 preguntas automática antes de cada push.

---

### Error 2: forzar en vez de sincronizar

**Qué ocurrió:** `push --force` para «arreglar» el rechazo; se borró trabajo ajeno.

**Por qué:** rechazo mal interpretado (punto 3).

**Cómo comprobarlo:** historial remoto: ¿desaparecieron commits?

**Opciones:** recuperar desde reflog/clones; trabajar con pull --rebase.

**Riesgos:** pérdida de trabajo de terceros.

**Solución:** nunca force en compartidas (punto 3 Error 7).

**Cómo se evita:** regla escrita (sección 07) + revisión de equipo.

---

### Error 3: leer solo la primera línea del error

**Qué ocurrió:** el mensaje ya decía la solución («fetch first») y se siguió intentando.

**Por qué:** diagnóstico superficial (punto 3 Error 3).

**Cómo comprobarlo:** vuelve a leer el mensaje completo ahora.

**Opciones:** seguir el paso exacto que sugiere Git.

**Riesgos:** repetir el mismo error en bucle.

**Solución:** leer → clasificar → actuar.

**Cómo se evita:** copiar el mensaje completo en tus notas de error.

---

### Error 4: pull con trabajo sucio sin commitear

**Qué ocurrió:** Git se negó a hacer checkout de la actualización porque modificabas archivos.

**Por qué:** orden incorrecto (punto 4 Error 4).

**Cómo comprobarlo:** `git status` — ¿hay modificados?

**Opciones:** commit o `git stash` → pull → retomar.

**Riesgos:** cambios mezclados sin querer o pull fallido.

**Solución:** estado limpio antes de pull (punto 4).

**Cómo se evita:** commit frecuente + stash de emergencia (Error 4).

---

### Error 5: pedir una rama que no existe

**Qué ocurrió:** `git pull origin nombre` con typo o rama borrada → «couldn't find remote ref».

**Por qué:** sin verificar ramas (punto 4 Error 5).

**Cómo comprobarlo:** `git fetch` + `git branch -r`.

**Opciones:** corregir el nombre o crear la rama.

**Riesgos:** repetir el typo en scripts.

**Solución:** listar antes de pedir.

**Cómo se evita:** autocompletar del shell y revisar spelling.

---

### Error 6: creer que «rechazado» es un fallo de red

**Qué ocurrió:** se reintentó el push muchas veces ignorando el motivo real.

**Por qué:** clasificación errónea (Error 3 — punto 3).

**Cómo comprobarlo:** ¿el mensaje era non-fast-forward o de autenticación? Son distintos.

**Opciones:** no-fast-forward → punto 3; auth → capítulo 01.

**Riesgos:** horas en el loop equivocado.

**Solución:** clasificar el tipo de rechazo.

**Cómo se evita:** vocabulario de mensajes (capítulo 06 de esta sección).

---

### Error 7: no corregir la URL tras un push erróneo

**Qué ocurrió:** se limpió el destino, pero la URL local seguía mal y volvió a pasar.

**Por qué:** corrección incompleta (punto 2 Error 7).

**Cómo comprobarlo:** `git remote -v` — ¿la URL es la correcta?

**Opciones:** `git remote set-url`.

**Riesgos:** repetición del incidente.

**Solución:** corregir la fuente (punto 2).

**Cómo se evita:** auditar remotes al abrir el proyecto.

---

## 7. Práctica guiada

### Objetivo

Vivir cada escenario de sincronización en un repositorio con un remoto de práctica (otro clon local hace de servidor).

### Paso 1: las 4 preguntas

1. Antes de cada paso: ejecuta `git remote -v`, `git status -sb`, `git status` y `git log origin/main..HEAD`. Anota las respuestas.

### Paso 2: push rechazado

1. En el «servidor» (clon 2) haz commit. En el clon 1 intenta push → lee el rechazo → `git pull --rebase` → push.

### Paso 3: pull con suciedad

1. Modifica un archivo sin commitear → intenta pull (lee el rechazo) → stash → pull → pop.

### Paso 4: remoto equivocado

1. Apunta origin a un repo falso → `git push` (falla o va donde no debe) → `git remote set-url` → verifica `git remote -v` → push correcto.

### Paso 5: auth simulada

1. Practica `git ls-remote origin` con URL mala: reconoce el error de acceso (Error 1 — sección 29 cap. 01).

### Paso 6: la regla personal

1. Escribe tu checklist de 4 preguntas en `docs/flujo.md` y úsala una semana.

### Resultado esperado

Push/pull rechazados resueltos correctamente, URL corregida y checklist en uso.

### Conclusión esperada

La sincronización deja de ser magia cuando la tratas como una conversación con reglas: preguntas primero, comando después — y cada rechazo se convierte en una instrucción que ya sabes seguir.

---

## 8. Nivel profesional + resumen

### 8.1. Sincronización en el trabajo real

```text
   │
   ├── pull --rebase para trabajo propio; merge para
   │   ramas compartidas (sección 07/15 — convención
   │   escrita)
   │
   ├── force-push prohibido en main y en ramas con PR
   │   abierto (sección 16/20 cap. 04: protección de
   │   ramas)
   │
   ├── autenticación con credenciales seguras/token de
   │   corta vida (sección 29 cap. 01 / 20 cap. 01)
   │
   └── métricas: fallos de push por semana, tiempo
       medio de sincronización, fuerzas por mes (cero —
       sección 20 cap. 06)
```

### 8.2. Resumen

En este capítulo aprendiste que:

* el mapa mental (local, remoto, interfaz) y las 4 preguntas evitan la mayoría de accidentes;
* push al repo equivocado: diagnóstico sin pánico, limpieza con aviso, corregir la URL;
* push rechazado: casi siempre historia divergente → pull --rebase → push; jamás force en compartido;
* pull que falla: acceso, URL, rama o suciedad — cuatro causas con su prueba;
* push que falla: permisos, autenticación, protección, divergencia o tamaño;
* los errores típicos (push ciego, force, mensaje a medias, suciedad, typo de rama, bucles de reintento, URL sin corregir) se previenen con el diagnóstico ordenado.

La idea principal es:

> **Un push o pull rechazado no es un error: es Git devolviéndote el control — la solución empieza leyendo el mensaje completo, nunca pulsando repetir.**

---

## Próximo paso

Sincronización bajo control.

Ahora los conflictos: qué son, por qué duelen y cómo se resuelven.

Continúa con:

[`05-conflictos-y-merge.md`](05-conflictos-y-merge.md)
