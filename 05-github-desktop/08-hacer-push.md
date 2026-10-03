# Hacer push

## Introducción

Tus commits están seguros en tu equipo, pero en GitHub nadie los ve. **Push** («empujar») es el acto de enviar tus commits locales al repositorio remoto: subir tu trabajo a GitHub para que el mundo (o tu equipo) lo vea.

El push cierra el primer circuito completo del trabajo con Git: modificar → revisar → commit → push. A partir de ahí, tu copia local y el remoto están sincronizadas. Y con esa sincronización llegan las preguntas importantes: ¿qué pasa si alguien más hizo cambios?, ¿puedo subir sin más?, ¿qué pasa si el remoto va por delante? Estas últimas se responden con pull (capítulo 09) y con el conflicto potencial que ya deberías intuir.

En este capítulo aprenderás:

* qué hace exactamente un push;
* cómo se ejecuta en GitHub Desktop;
* el estado local vs. remoto y sus indicadores;
* qué pasa cuando el remoto tiene commits que tú no tienes (la negación del push);
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (equipos, ramas, protección).

---

## Mapa conceptual de este capítulo

```text
Hacer push
       │
       ├── 1. Qué es push
   │        ├── Definición
   │        ├── Qué se envía (y qué no)
   │        └── push vs. commit
   │
       ├── 2. Push desde GitHub Desktop
   │        ├── El botón Push origin
   │        ├── Estado antes y después
   │        └── Verificación en la web
   │
       ├── 3. Local y remoto sincronizados
   │        ├── Indicadores de estado
   │        └── Concepto de adelanto/retraso
   │
       ├── 4. Cuando el push es rechazado
   │        ├── Causa: el remoto va por delante
   │        ├── Solución: pull primero (adelanto)
   │        └── Qué NO hacer: force push
   │
       ├── 5. Permisos y rechazos de acceso
   │
       ├── 6. Errores comunes con diagnóstico completo
   │
       ├── 7. Práctica guiada
   │
       ├── 8. Nivel profesional
   │        ├── Trabajo en equipo sincronizado
   │        ├── Push a ramas y Pull Requests
   │        └── Force push: política
   │
       └── 9. Resumen y siguiente paso
```

---

## 1. Qué es push

### 1.1. Definición

**Push** envía los commits de tu rama local al mismo nombre en el repositorio remoto, actualizando el remoto hasta tu último commit local.

```text
Push
──────────────────────────────────────────────
TU EQUIPO (local)              GITHUB (remoto)
   │                               │
main: A─B─C─D ──── push ────► main: A─B─C─D
   (tú tienes D)                   (ahora también)

El remoto ACEPTA los commits nuevos
y mueve su rama main hasta D.
```

### 1.2. Qué se envía y qué no

```text
Qué viaja en el push
   │
   ├── los COMMITS que el remoto no tiene
   ├── sus mensajes, autores y fechas
   ├── los archivos de esos commits (los que cambiaron)
   └── las REFERENCIAS de ramas que actualizas

Qué NO viaja
   │
   ├── cambios sin commit (siguen en tu disco)
   ├── tu contraseña (se usa tu identidad de sesión/token)
   ├── configuración personal de tu equipo
   └── commits que ya el remoto tiene (son idénticos:
       no hay nada nuevo que enviar)
```

### 1.3. push vs. commit

```text
Concepto        Alcance            Efecto
──────────────────────────────────────────────────
commit          local              historial de TU equipo
push            local → remoto     historial de GITHUB

Un push puede llevar VARIOS commits
(si hiciste tres antes de subir, el push los envía a los tres)
```

### 1.4. Subida a qué rama

```text
El push actualiza la rama con el MISMO nombre:
   │
   ├── tu main local    →  remoto main
   ├── tu rama feature  →  remoto feature (se crea si no existe)
   │
   └── por eso el "commit a la rama equivocada"
       también provoca un "push a la rama equivocada"
```

---

## 2. Push desde GitHub Desktop

### 2.1. El botón

```text
GitHub Desktop (con commits locales pendientes)
   │
   ├── el botón principal muestra:
   │      "Push origin"   (o "Fetch origin" si ya está al día)
   │
   ├── también puede aparecer el contador:
   │      "1 local commit waiting to push"
   │
   └── menú: Repository → Push
```

### 2.2. Estados del botón (ciclo)

```text
Ciclo típico del botón de sincronización
──────────────────────────────────────────────
1. "Fetch origin"
      →  comprueba el estado (consulta a GitHub)
2. "Push origin"
      →  tienes commits locales sin subir
3. "Pull origin" (o "Pull origin N commits")
      →  el remoto tiene commits que tú no tienes
4. (tras sincronizar) "Fetch origin" otra vez

Fetch = preguntar al remoto qué hay (sin cambiar nada)
Push  = subir tus commits
Pull  = traer los commits del remoto (capítulo 09)
```

### 2.3. Pasos

```text
Procedimiento
──────────────────────────────────────────────
1. Comprueba que la pestaña Changes está como esperas
2. Pulsa "Push origin"
3. Espera: progreso de subida (depende de tu red)
4. El botón vuelve a "Fetch origin" (o estado al día)
5. Indicador de commits pendientes: desaparece
```

### 2.4. Verificación en la web

```text
Comprobación definitiva
   │
   ├── abre github.com/tu-repo
   ├── refresca
   ├── la pestaña Commits muestra tu commit más reciente
   └── el archivo refleja el contenido nuevo

Si no cambia:
   · ¿pulsaste Push? (mirar Desktop)
   · ¿estás mirando la rama correcta en la web?
   · ¿hubo error en el push? (ver punto 4)
```

---

## 3. Local y remoto sincronizados

### 3.1. Los tres estados posibles

```text
Relación local ↔ remoto
──────────────────────────────────────────────
A. IGUALADOS
   local = remoto
   (no hay nada pendiente en ninguna dirección)

B. LOCAL ADELANTE
   local tiene commits que el remoto no
   →  toca PUSH

C. REMOTO ADELANTE
   remoto tiene commits que el local no
   →  toca PULL (capítulo siguiente)
```

### 3.2. Indicadores en Desktop

```text
Dónde mirar
   │
   ├── el botón principal (Push/Pull/Fetch)
   ├── el contador de commits locales pendientes
   ├── History: ¿tu último commit local está en GitHub?
   │   (comprobación manual)
   └── en repos con colaboradores: tras cada sesión,
       Fetch para ver si el remoto avanzó
```

### 3.3. El hábito de sincronización

```text
Rutina recomendada (equipo)
──────────────────────────────────────────────
Antes de empezar:
   1. Fetch (¿hay algo nuevo?)
   2. Si hay: Pull antes de editar (trabajas al día)

Al terminar:
   3. Revisar cambios → Commit
   4. Push
   5. Comprobar en la web si importa
```

Trabajar sin pull previo es la causa número uno de disgustos de sincronización (los verás en el capítulo 09).

---

## 4. Cuando el push es rechazado

### 4.1. La causa clásica: el remoto va por delante

```text
Situación
──────────────────────────────────────────────
Tu local:      A─B─C        (tú hiciste C)
Remoto:        A─B─D        (otro hizo D)

push de C
   │
   ▼
RECHAZADO: el remoto tiene D, que tú no tienes.
           Git se niega a perder el trabajo de D
```

Git nunca sobrescribe ciegamente el remoto: si divergieron, exige que resuelvas primero (traer D con pull).

### 4.2. El mensaje de error (idea general)

```text
Aproximación del mensaje
──────────────────────────────────────────────
"Fetch first" / "pull before push" / "non-fast-forward"

Significado: «el remoto avanzó; trae sus cambios antes
de subir los tuyos»
```

### 4.3. La solución correcta

```text
Protocolo
──────────────────────────────────────────────
1. Pull (trae los commits del remoto)
   │
   ├── si no hay conflicto: Git fusiona automáticamente
   │   y tu local queda al día + tus cambios encima
   │
   └── si hay conflicto: hay que resolverlo
       (sección 10; mientras tanto, NO force)
2. Revisa el resultado (History y cambios)
3. Push (ahora sí)
```

### 4.4. Qué NO hacer: force push

```text
git push --force  (o "Force push" en la interfaz)
──────────────────────────────────────────────
Qué hace: SOBRESCRIBE el remoto con tu versión,
          BORRANDO los commits que allí había
          (los que tú no tenías)

Cuándo es legítimo (muy poco):
   · tu propia rama personal que NADIE más usa
   · corregir historial en ramas privadas individuales

Cuándo es NEFASTO:
   · en ramas compartidas (main, ramas de equipo)
   →  destruye el trabajo de otros
   →  sus clones quedan descoordinados
   →  GitHub a veces lo bloquea por políticas
```

> **Regla de oro:** si el push es rechazado, la respuesta es PULL, nunca FORCE. El force-push es la «solución» que convierte un problema de 10 minutos en un incidente de equipo.

---

## 5. Permisos y rechazos de acceso

No todos los rechazos son por divergencia:

```text
Otras causas de push rechazado
   │
   ├── SIN PERMISOS
   │      →  no eres colaborador con escritura
   │      →  solución: permisos o Pull Request
   │
   ├── RAMA PROTEGIDA
   │      →  la política prohíbe subir directo a main
   │      →  solución: rama + PR (sección 17)
   │
   ├── 2FA / SSO de la organización
   │      →  la organización exige condiciones de acceso
   │      →  solución: cumplir la política (capítulos 03/05
   │         de la sección 03)
   │
   ├── SESIÓN/CREDENCIALES
   │      →  Desktop sin sesión válida o expirada
   │      →  solución: iniciar sesión de nuevo
   │
   └── TAMAÑO
          →  archivo demasiado grande
          →  solución: LFS o reducir (sección 04)
```

Ante cualquier rechazo: **lee el mensaje completo**. Distingue «divergencia» de «permisos» cambia por completo la solución.

---

## 6. Errores comunes con diagnóstico completo

### Error 1: Creer que push ya se hizo

**Qué ocurrió:** se commiteó y se fue a la web: nada nuevo.

**Por qué:** no se pulsó Push (o falló y no se miró).

**Cómo comprobarlo:** indicador de Desktop; estado del botón; web.

**Opciones:** pulsar Push.

**Riesgos:** «yo ya lo subí» falsificado.

**Solución:** el hábito de mirar el indicador.

**Cómo se evita:** flujo completo: cambios → commit → PUSH → verificar.

---

### Error 2: Push rechazado y force push por desesperación

**Qué ocurrió:** apareció el rechazo y se forzó la subida.

**Por qué:** prisa y no entender el mensaje.

**Cómo comprobarlo:** en el remoto, los commits de otros desaparecieron (si hubo daño); el historial se reescribió.

**Opciones (si ocurrió):**
* contactar de inmediato con el equipo;
* intentar recuperar los commits perdidos (existen en los clonos de otros, generalmente);
* aprender el protocolo pull → push.

**Riesgos:** pérdida de trabajo ajeno, descoordinación.

**Solución:** prevención: entender que «rechazado» siempre se resuelve con pull.

**Cómo se evita:** memorizar: **rechazo ⇒ pull, jamás force**.

---

### Error 3: Push a la rama equivocada

**Qué ocurrió:** el trabajo de `feature` subió a `main`.

**Por qué:** commit mal orientado (capítulo anterior) o rama mal elegida.

**Cómo comprobarlo:** History de `main` en la web.

**Opciones:**
* sin permiso directo: rama protegida lo habría impedido;
* si ocurrió: hablar con el equipo; revert en main y subir bien a su rama (según contexto).

**Riesgos:** cambios sin revisión en la principal.

**Solución:** revisar rama en commit Y en push.

**Cómo se evita:** mirar el nombre de la rama dos veces.

---

### Error 4: Push lento o fallido por red

**Qué ocurrió:** la subida se queda o da error de conexión.

**Por qué:** red inestable, proxy, tamaño grande.

**Cómo comprobarlo:** mensaje de error; progreso detenido.

**Opciones:**
* reintentar;
* verificar conexión y VPN corporativa;
* si es un archivo grande: replantear tamaño/LFS.

**Riesgos:** demora; en redes corporativas, posible configuración (nivel profesional).

**Solución:** según la causa: red, proxy o tamaño.

**Cómo se evita:** subir cambios frecuentes y pequeños (más fáciles de reintentar).

---

### Error 5: Subir sin querer trabajo a medio hacer

**Qué ocurrió:** se hizo push de un commit con el proyecto roto (a mitad de tarea).

**Por qué:** prisa o falta de costumbre de revisar.

**Cómo comprobarlo:** History/Web: el commit está.

**Opciones:**
* si es rama personal: continuar con el arreglo y push siguiente (el trabajo termina bien);
* si es main sin protección: valorar revert (raro) o arreglo inmediato;
* en equipo: comunicar («está roto hasta el siguiente commit») o revertir.

**Riesgos:** gente que clona un estado roto.

**Solución:** no subir a ramas compartidas hasta que el cambio al menos no rompa lo básico.

**Cómo se evita:** revisar + pruebas mínimas antes del push a ramas compartidas.

---

### Error 6: Confundir push con «guardar en la nube» general

**Qué ocurrió:** se espera que los archivos sin commitear también «suban» con el push.

**Por qué:** confundir niveles (guardar/commit/push).

**Cómo comprobarlo:** los archivos modificados siguen en la lista de cambios; la web no los muestra.

**Opciones:** commit primero, luego push.

**Riesgos:** sensación de pérdida (falsa: están en tu disco).

**Solución:** la cadena completa.

**Cómo se evita:** repasar los tres niveles (capítulo 05 de esta sección).

---

## 7. Práctica guiada

### Objetivo

Publicar tus commits locales y aprender a leer el estado de sincronización.

### Paso 1: estado inicial

1. Asegúrate de tener 1-3 commits locales de la práctica anterior.
2. Observa el botón: debería indicar push pendiente.

### Paso 2: push

1. Pulsa **Push origin**.
2. Espera a que termine.
3. Comprueba: desaparece el contador; el botón pasa a «Fetch origin».

### Paso 3: verificación web

1. Abre GitHub en el navegador.
2. Refresca: tus commits y archivos están.
3. Comprueba la pestaña Commits: los mensajes son los tuyos.

### Paso 4: simulacro de estado

1. En la web, haz un pequeño cambio (edición directa en un archivo).
2. En Desktop, pulsa **Fetch origin**.
3. Observa: el botón pasa a indicar pull (el remoto avanzó).
4. NO hagas pull todavía (reservalo para el capítulo 09). Vuelve a dejar el repo local como estaba: si la web quedó con un cambio que no quieres conservar, deshazlo en la web (commit de reversión) o déjalo y afronta el pull en el próximo capítulo (ambas opciones son válidas para aprender).

### Paso 5: confirmación conceptual

Responde:
1. ¿Qué hizo exactamente el push? → envió mis commits al remoto.
2. ¿Subió archivos sin commit? → no.
3. ¿Qué haría si el push me rechaza? → pull primero; jamás force.

### Resultado esperado

Remoto sincronizado con tu trabajo y capacidad de leer los indicadores de estado.

### Conclusión esperada

El push es el puente: sube exactamente los commits, ni un archivo suelto más. Leer el estado local/remoto correctamente es la mitad de no tener problemas en equipo.

---

## 8. Nivel profesional

### 8.1. Trabajo en equipo sincronizado

```text
Rutina de equipo madura
──────────────────────────────────────────────
Antes de editar:   Fetch (+ Pull si hay novedades)
Durante:           commits pequeños y atómicos
Al publicar:       Push de la rama correspondiente
Si rechaza:        Pull → resolver si hay conflicto → Push
Nunca:             Force en ramas compartidas
```

### 8.2. Push a ramas y Pull Requests

En el flujo profesional, casi nunca se empuja a `main`:

```text
Flujo estándar
──────────────────────────────────────────────
1. Crear rama (capítulo 10)
2. Trabajar: commit(s)
3. Push de MI rama (se crea en el remoto)
4. Abrir Pull Request (sección 17)
5. Revisión y fusión
6. Pull local para actualizarse
```

El push a rama personal es seguro y bajo riesgo: es tu espacio.

### 8.3. Force push: política de equipos

```text
Equipos definen reglas como:
   │
   ├── prohibido en main y ramas compartidas
   ├── permitido (con avisos) en ramas personales
   ├── a veces bloqueado técnicamente por protección
   └── excepciones: mantenimiento coordinado, con aviso
```

### 8.4. Auditoría del remoto

```text
Para saber quién subió qué:
   │
   ├── pestaña Commits del remoto (autor + fecha)
   ├── bitácora de la organización (eventos administrativos)
   └── políticas que exigen verificación/firma de commits
```

---

## 9. Resumen

En este capítulo aprendiste que:

* el push envía tus commits locales al remoto con el mismo nombre de rama; no sube archivos sin commitear ni tu configuración;
* desde GitHub Desktop, el botón cicla entre Fetch (preguntar), Push (subir) y Pull (traer);
* los tres estados de sincronización son: igualados, local adelantado (push) y remoto adelantado (pull);
* un push rechazado casi siempre significa que el remoto avanzó: la solución es pull, revisar y volver a push;
* el force-push sobrescribe el remoto y destruye trabajo ajeno: está prohibido en ramas compartidas;
* los rechazos también pueden deberse a permisos, ramas protegidas, políticas de organización, credenciales o tamaño: leer el mensaje es imprescindible;
* la rutina profesional es fetch/pull antes de empezar y push al terminar, siempre en la rama correcta;
* el hábito de verificar en la web cierra el circuito sin malentendidos.

La idea principal es:

> **El push es un acuerdo entre dos copias: sube exactamente lo que tú decidiste y respeta lo que el remoto ya tiene. Ante cualquier rechazo, la respuesta es dialogar con el remoto (pull), no borrar su memoria (force).**

---

## Próximo paso

Ya sabes subir tu trabajo.

El siguiente paso es lo contrario: traer el trabajo de los demás con el pull, y entender cuándo aparecen los conflictos.

Continúa con:

[`09-hacer-pull.md`](09-hacer-pull.md)
