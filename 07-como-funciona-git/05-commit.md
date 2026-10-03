# Commit

## Introducción

El **commit** es la unidad fundamental de Git: un registro completo que captura el estado de tus archivos seleccionados, con un mensaje que explica por qué. Cada commit es una instantánea del proyecto, ligada a sus anteriores mediante hashes —una cadena que hace el historial inmutable y verificable.

Ya has creado commits en las secciones 05 y 06 (cómo hacerlo). Ahora toca comprender **qué es** un commit en profundidad: qué contiene, cómo se identifica, qué lo conecta con el pasado y por qué «atómico» y «bien escrito» es una disciplina profesional.

En este capítulo aprenderás:

* la anatomía de un commit (contenido, autoría, fecha, padre, mensaje);
* el commit como instantánea, no como diferencia;
* el identificador hash y su cadena (hash → siguiente capítulo);
* qué comunica un buen mensaje y por qué importa;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (amend, firmas, commits como contrato).

---

## Mapa conceptual de este capítulo

```text
Commit
       │
       ├── 1. Qué es
   │        ├── instantánea con mensaje
   │        ├── unidad de historial
   │        └── identidad: hash
   │
       ├── 2. Anatomía
   │        ├── cabecera (hash, autor, fecha)
   │        ├── árbol (estado de archivos)
   │        ├── padre (conexión al pasado)
   │        └── mensaje (título + cuerpo)
   │
       ├── 3. Instantánea vs. diferencia
   │
       ├── 4. El mensaje: comunicación
   │        ├── convención (imperativo, estilo)
   │        └── por qué es para humanos y máquinas
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       ├── 7. Nivel profesional
   │        ├── amend y reescribir recién publicado
   │        ├── firmas y verificación
   │        └── el commit como contrato de revisión
   │
       └── 8. Resumen y siguiente paso
```

---

## 1. Qué es

### 1.1. Definición operativa

```text
Un commit es
──────────────────────────────────────────────
· el resultado de «fijar» el staging actual
· un objeto que contiene:
    - el estado (árbol) de TODOS los archivos rastreados
    - referencias a sus contenidos (blobs)
    - autor, fecha, mensaje
    - referencia a su padre (los anteriores)
· un nodo permanente de la historia: no se edita,
  se sustituye (y solo si nadie más lo usa)
```

### 1.2. Es la moneda del historial

```text
   │
   ├── «ya está commiteado» =  queda en la historia
   ├── git log es la lista de commits
   └── todo lo demás (ramas, PRs, releases) se apoya
       en commits: sin ellos, nada
```

---

## 2. Anatomía

### 2.1. Verlo completo

```bash
git show HEAD
```

```text
commit 7b21d04d8e3f... (40 hex — el hash)
Author: María López <maria@ejemplo.com>
Date:   Tue Sep 30 18:22:11 2026 +0200

    Añade ejercicios del capítulo 3

    Incluye cinco preguntas con respuestas.

─── lo que contiene ───
árbol (estado de archivos en ese instante)
padre (commit anterior)
diff vs. el padre (lo que cambió respecto a su antecesor)
```

### 2.2. Los cinco elementos

```text
Elemento       Papel
──────────────────────────────────────────────
Hash           identidad única del commit (cap. 06)
Autor/fecha    quién y cuándo (más committer: quién
               registró — se distingue en equipos)
Árbol          instantánea de TODOS los archivos
               rastreados (no solo los cambiados)
Padre          conexión al pasado; da orden y permite
               diffs
Mensaje        el porqué; único texto humano del objeto
```

### 2.3. El padre: la cadena

```text
A ← B ← C ← D   (HEAD apunta a D)

· C tiene padre B; B tiene padre A; A no tiene (raíz)
· sin padre no hay «antes», y sin antes no hay diff
· un commit con DOS padres = resultado de merge
    (sección 10)
· un commit con NINGUNO = raíz del repo
```

---

## 3. Instantánea vs. diferencia

### 3.1. Lo que crees vs. lo que Git guarda

```text
Intuición (falsa):     commit = «las líneas que cambié»
Realidad:              commit = TODO el estado del proyecto
                       en ese momento (seleccionado por
                       lo que estaba en el staging/index)

   │
   ├── Git guarda instantáneas, no listas de cambios
   ├── optimiza por debajo (sin cambios reutiliza el
   │   blob anterior: por eso no «infla» el repo)
   └── para ti se comporta como un fotograma completo
```

### 3.2. Consecuencias prácticas

```text
   │
   ├── puedes ver CUALQUIER versión del proyecto
   │   (checkout de un commit = proyecto completo de
   │   ese día)
   │
   ├── los diffs son DERIVADOS: Git compara dos
   │   instantáneas al pedirlos (diff, show, log -p)
   │
   └── por eso un commit enorme es barato en verdad,
       pero caro en REVISIÓN (no en espacio)
```

---

## 4. El mensaje: comunicación

### 4.1. Estructura recomendada

```text
Título (resumen ≤ 50, imperativo)
(blank line)
Cuerpo opcional (qué y por qué, líneas ≤ 72)
```

```bash
git commit -m "Corrige cálculo de totales en facturas"
```

```text
Ejemplo con cuerpo (git commit sin -m abre el editor):
 Corrige cálculo de totales en facturas

 El subtotal no descuenta devoluciones anteriores.
 Ahora suma primero devoluciones y luego aplica IVA.
```

### 4.2. Qué comunica y a quién

```text
Mensajes malos              Mensajes buenos
──────────────────────────────────────────────────────
"fix", "cosas", "wip"       "Corrige acceso con 2FA
                             en Windows"
"actualiza"                 "Añade límite de intentos
                             de login"

   │
   ├── el mensaje es el «por qué» que NO está en el
   │   código: cuando el código cambie, el mensaje queda
   │
   ├── lo leen: compañeros en revisión, auditorías,
   │   tú mismo dentro de 6 meses
   │
   └── los bisect/log -S (sección 13) dependen de
       mensajes buscables: son datos, no adornos
```

### 4.3. Estilo

```text
   │
   ├── imperativo: «Añade», «Corrige», «Elimina»
   │   (como instrucciones: «aplicar este commit»)
   │
   ├── coherente con el equipo (CONTRIBUTING lo fija
   │   en proyectos serios)
   │
   └── convenciones comunes (mención): prefijos
       feat:/fix:/docs: en commits convencionales —
       útiles si el proyecto los usa; innecesarios si no
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: Commit con mensaje genérico o roto

**Qué ocurrió:** historial lleno de «cambio», «update», «fix fix».

**Por qué:** prisa o no saber que importa.

**Cómo comprobarlo:** `git log --oneline` en cualquier proyecto viejo.

**Opciones:**
* local no publicado: `git commit --amend` (con criterio);
* ya publicado: mensajes no se reescriben (poquito valor, mucho riesgo); se corrige la disciplina hacia delante.

**Riesgos:** historial que no se puede auditar ni bisectar bien.

**Solución:** ritual: redactar el mensaje como parte del commit.

**Cómo se evita:** plantillas de commit del equipo y hábito imperativo.

---

### Error 2: Creer que commit = respaldo

**Qué ocurrió:** «hice commit, por eso no pierdo nada»… pero no había push y el disco murió.

**Por qué:** commit es local.

**Cómo comprobarlo:** `git remote -v` vacío o push antiguo.

**Opciones:** push frecuente; backup de `.git`.

**Riesgos:** pérdida total del historial local.

**Solución:** commit + push (o al menos push diario).

**Cómo se evita:** tratar el remoto como backup desde el día uno.

---

### Error 3: Commit accidental en rama equivocada

**Qué ocurrió:** trabajabas en `main` (o en la rama de otro) y commiteaste un experimento.

**Por qué:** rama activa no revisada.

**Cómo comprobarlo:** `git status` / `git log`.

**Opciones:**
* sin publicar: mover el commit (cherry-pick o reset — secciones 08/11);
* publicado en rama protegida: revert o acuerdo de equipo.

**Riesgos:** historia compartida ensuciada.

**Solución:** status antes de commit (raíz 26) y ramas por tarea.

**Cómo se evita:** nunca trabajar directo en rama integrada.

---

### Error 4: Un commit con cinco temas

**Qué ocurrió:** la revisión no avanza; nadie sabe qué se aprobó.

**Por qué:** staging sin criterio (cap. 02 de esta sección).

**Cómo comprobarlo:** `git show --stat HEAD` → demasiados archivos/tipos de cambio.

**Opciones:**
* no publicado: reset suave + recommit por partes (sección 11);
* publicado: no partir ya; separar en commits siguientes cuando aplique.

**Riesgos:** bisect inútil; rollback imposible de «lo que falló».

**Solución:** un commit = una idea.

**Cómo se evita:** planear el reparto ANTES de commitear.

---

### Error 5: Commit vacío o de solo formato mezclado

**Qué ocurrió:** «el commit del reformato» incluye también cambios funcionales.

**Por qué:** dos temas en uno (formato vs. lógica).

**Cómo comprobarlo:** diff enorme con cambios «de todo».

**Opciones:** separar (no publicado) o no volver a mezclar.

**Riesgos:** revisiones imposibles; regresiones escondidas en ruido.

**Solución:** formato en su commit, lógica en la suya.

**Cómo se evita:** herramientas de formato en CI, no a mano (sección 21).

---

### Error 6: Commit «preparado» que nunca se hizo

**Qué ocurrió:** el equipo espera un cambio; tu staging lo tiene, pero no commiteaste (o no pusheaste).

**Por qué:** confundir preparado con guardado (cap. 02).

**Cómo comprobarlo:** status dice staged; log no crece; remoto no lo ve.

**Opciones:** commit y push.

**Riesgos:** pérdida de contexto (si se cierra la sesión y nadie lo ve).

**Solución:** finalizar el ciclo.

**Cómo se evita:** ritual completo add → diff → commit → push.

---

## 6. Práctica guiada

### Objetivo

Crear y auditar commits «de manual» y leer su anatomía completa.

### Paso 1: prepara un commit con cuerpo

1. Edita un archivo (un cambio real).
2. `git add <archivo>`
3. `git diff --staged` (revisa)
4. `git commit` (sin `-m`: se abre tu editor)
5. Escribe título y cuerpo; guarda y cierra.

### Paso 2: anatómalo

```bash
git show HEAD
git log --format=fuller -n 1
```

1. Localiza: hash, Author, Date, mensaje, diff.
2. `git cat-file -p HEAD` (opcional): mira la cabecera técnica (`tree`, `parent`, `author`).

### Paso 3: la cadena

```bash
git log --oneline
```

1. Traza la línea: cada commit «cuelga» del anterior.
2. Identifica la raíz (el primero).

### Paso 4: instantánea completa

```bash
git checkout <commit-antiguo>   # (o git restore --source…
                                #  si prefieres no moverte)
```

1. Tu carpeta muestra el proyecto COMPLETO de ese momento.
2. Vuelve: `git checkout <rama>` (sección 08 lo formaliza).

### Paso 5: mensaje ante revisor

1. Relee tus últimos 3 mensajes con ojo crítico:
   * ¿dicen el porqué?
   * ¿un desconocido entendería el cambio?
2. Corrige el último si es local (amend) o anota la mejora.

### Resultado esperado

Un commit con mensaje completo y la capacidad de explicar cada campo que Git te mostró en `show`.

### Conclusión esperada

El commit no es «subir archivos»: es firmar un instante del proyecto con tu nombre, una fecha y una explicación. El hash lo identifica; el mensaje lo hace comprensible.

---

## 7. Nivel profesional

### 7.1. `--amend` con criterio

```bash
git commit --amend        # añade lo nuevo al ÚLTIMO commit
```

```text
Reglas
   │
   ├── SOLO si el commit NO está publicado
   ├── cambia su hash (es «otro» commit para quien
   │   ya lo vio)
   └── publicado + fuerza = rompe a los demás
       (push --force con piloto en la sección 17)
```

### 7.2. Firmas y verificación

```text
   │
   ├── commit -S → firma GPG/SSH; GitHub muestra
   │   «Verified»
   │
   ├── en equipos con requisitos de auditoría: la
   │   firma certifica autoría
   │
   └── tags firmados: releases creíbles (sección 19)
```

### 7.3. El commit como contrato de revisión

```text
Cultura de commits en equipos maduros
──────────────────────────────────────────────
· atómico        →  se aprueba o se rechaza de una vez
· mensaje fiel   →  el revisor entiende sin preguntar
· sin basura     →  sin archivos generados ni secretos
· verificable    →  CI pasa en cada commit (sección 21)

El historial es el registro de decisiones del proyecto:
trátalo como documentación viva, no como vertedero.
```

---

## 8. Resumen

En este capítulo aprendiste que:

* un commit es un objeto con identidad (hash), autoría, fecha, árbol (instantánea de archivos), padre (conexión al pasado) y mensaje;
* Git guarda instantáneas completas, no listas de cambios; los diffs se derivan al pedirlos;
* la cadena de padres da orden al historial y permite recuperar cualquier versión; un commit con dos padres es un merge;
* el mensaje es el único texto humano: título imperativo conciso + cuerpo con el porqué; alimenta revisiones, auditorías y `git bisect`;
* los errores típicos (mensajes genéricos, commit en rama equivocada, commits polivalentes, confundir respaldo con commit) se evitan con disciplina de staging y empujones frecuentes;
* a nivel profesional: `--amend` solo sin publicar, firmas donde importe, y el commit tratado como contrato de revisión.

La idea principal es:

> **Un commit es una firma legible sobre un instante del proyecto: identidad en el hash, intención en el mensaje, verdad en la cadena de padres.**

---

## Próximo paso

Has visto que cada commit se identifica con un hash.

En el siguiente capítulo: qué es ese hash, de qué se alimenta y por qué hace a Git verificable e inmutable.

Continúa con:

[`06-hash.md`](06-hash.md)
