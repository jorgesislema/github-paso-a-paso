# git log

## Introducción

Si `status` es la brújula del presente, **`git log`** es la ventana al pasado. El comando muestra la lista de commits de la rama actual: cada uno con su hash, autor, fecha y mensaje, en orden del más reciente al más antiguo.

Leer el log es la forma de entender qué ha pasado en tu proyecto, localizar cambios concretos, encontrar el commit del que parte una rama y comprobar que tus commits recientes son los que esperabas. Junto con `status` y `diff`, forma la trinidad de diagnóstico de Git.

En este capítulo aprenderás:

* a ejecutar `git log` y leer cada campo de la salida;
* a salir del paginador sin perderte;
* los filtros más útiles (`--oneline`, `--author`, `--grep`, fechas);
* a localizar commits concretos por hash;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional (logs para auditoría y bisect).

---

## Mapa conceptual de este capítulo

```text
git log
       │
       ├── 1. La salida básica
   │        ├── Cada campo
   │        └── Orden y alcance (rama actual)
   │
       ├── 2. El paginador (salir sin pánico)
   │
       ├── 3. Formas compactas
   │        ├── --oneline
   │        ├── --graph
   │        └── git log -n
   │
       ├── 4. Filtros
   │        ├── --author
   │        ├── --grep
   │        ├── --since / --until
   │        └── archivo concreto
   │
       ├── 5. Ver el contenido de un commit (mención)
   │
       ├── 6. Errores comunes con diagnóstico completo
   │
       ├── 7. Práctica guiada
   │
       ├── 8. Nivel profesional
   │        ├── Auditoría y trazabilidad
   │        ├── git log en guiones
   │        └── Encontrar el culpable (bisect)
   │
       └── 9. Resumen y siguiente paso
```

---

## 1. La salida básica

### 1.1. Ejecutar

```bash
git log
```

### 1.2. Anatomía de una entrada

```text
commit 9f1c2ab3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9
Author: María López <maria.id@users.noreply.github.com>
Date:   Tue Sep 30 18:22:11 2026 +0200

    Añade ejercicios del capítulo 3

    Incluye cinco preguntas con sus respuestas.
    Los enlaces apuntan a los capítulos 1 y 2.
```

```text
Campos
   │
   ├── commit + HASH completo (40 caracteres)
   │      →  identificador único; los 7 primeros bastan
   │         para la mayoría de usos
   │
   ├── Author: nombre + correo + (a veces) otras líneas
   │      →  quién hizo el commit (y su correo configurado)
   │
   ├── Date: fecha y hora exactas
   │      →  cuándo se hizo (zona horaria incluida)
   │
   └── Mensaje: título + cuerpo (con sangría)
          →  la parte humana: qué y por qué
```

### 1.3. Orden y alcance

```text
   │
   ├── Orden: del más reciente al más antiguo
   │
   ├── Alcance: la RAMA ACTUAL (su cadena de commits)
   │      →  si estás en main, ves main; en feature, feature
   │
   └── no ves: cambios sin commitear (eso es status)
              ni el remoto directamente (ese es otro ámbito)
```

---

## 2. El paginador (salir sin pánico)

### 2.1. Qué es

Si hay muchos commits, Git muestra la salida con un paginador (habitualmente `less`):

```text
Señales de que estás en el paginador:
   │
   ├── la salida se corta
   │   aparece algo como  :   (al pie, o vacío)
   └── los comandos «no funcionan» (tu terminal está en
       el paginador, no en el prompt de Git)
```

### 2.2. Cómo salir y navegar

```text
En less (paginador habitual)
   │
   ├── flechas o espacio  →  avanzar
   ├── b                  →  retroceder
   ├── q                  →  SALIR (lo importante)
   └── /texto              →  buscar dentro de la salida
```

> **Regla:** si no sabes dónde estás, pulsa `q`. Salir del paginador no rompe nada.

---

## 3. Formas compactas

### 3.1. --oneline

```bash
git log --oneline
```

```text
Salida:
   a3f9c21 Añade ejercicios del capítulo 3
   7b21d04 Actualiza notas tras la práctica
   1c88ef0 Añade tareas y notas de la práctica
   ...

Una línea por commit: hash corto + título.
La vista diaria.
```

### 3.2. Límite de cantidad

```bash
git log --oneline -n 5
```

Solo los 5 más recientes (útil para «¿qué pasó hoy?»).

### 3.3. --graph (visión de estructura)

```bash
git log --oneline --graph
```

```text
Dibuja la forma de la historia (fusión de ramas):
   * a3f9c21 (HEAD -> main) Fusi\u00f3n de rama de correcciones
   |\
   | * 44d2aa1 Corrige enlaces rotos
   | * 9911b00 Reordena secciones
   * | 7b21d04 Actualiza notas
   |/

(claro cuando hay ramas; simple cuando hay una línea)
```

### 3.4. Resumen estadístico

```bash
git log --stat --oneline -n 3
```

Añade qué archivos cambió cada commit (con recuento de líneas). Punto medio entre «qué pasó» y «qué cambió».

---

## 4. Filtros

### 4.1. Por autor

```bash
git log --author="María"
```

Commits cuyo autor coincide (búsqueda parcial, no hace falta el correo completo).

### 4.2. Por texto del mensaje

```bash
git log --grep="corrección"
```

Commits cuyo mensaje contiene ese texto (como buscar en el historial).

### 4.3. Por fecha

```bash
git log --since="2026-09-01" --until="2026-10-01"
git log --since="2 weeks ago"
```

Ventana temporal: «¿qué pasó en septiembre?», «¿esta semana?».

### 4.4. Por archivo

```bash
git log --oneline -- notas.md
```

Solo los commits que tocaron ese archivo: el historial focalizado (equivalente a la pestaña History de la web).

### 4.5. Combinaciones

```bash
git log --oneline --author="María" --since="1 week ago"
```

Los filtros se acumulan: encuentros precisos.

---

## 5. Ver el contenido de un commit (mención)

```bash
git show a3f9c21
```

```text
Muestra UN commit completo:
   │
   ├── cabecera (hash, autor, fecha, mensaje)
   └── diff de lo que cambió

git log -p          →  el log con diffs (extenso)
git log --stat      →  el log con archivos afectados
```

(Detalle de `git show` en el capítulo 12; aquí queda la conexión.)

---

## 6. Errores comunes con diagnóstico completo

### Error 1: No poder salir de la salida

**Qué ocurrió:** `git log` y la terminal «no responde».

**Por qué:** estás en el paginador (less).

**Cómo comprobarlo:** carácter `:` o texto cortado al pie.

**Opciones:** pulsar `q`.

**Riesgos:** frustración; creer que Git falló.

**Solución:** `q` siempre sale.

**Cómo se evita:** conocer el paginador antes (punto 2).

---

### Error 2: Log «vacío» o sin los commits esperados

**Qué ocurrió:** no aparece el commit que buscabas.

**Por qué posibles:**
* estás en otra rama;
* filtro demasiado estrecho (--author/--grep/--since);
* el commit está en otra rama no fusionada;
* el commit no existe (se creó en otro repositorio).

**Cómo comprobarlo:**
* `git branch` para ver la rama;
* quitar filtros;
* `git log --all` (todas las ramas, ver punto 9);
* `git reflog` si buscas algo «perdido» (avanzado; sección 11).

**Opciones:** ajustar el alcance.

**Riesgos:** concluir «se borró» cuando estaba en otro sitio.

**Solución:** comprobar rama y filtros primero.

**Cómo se evita:** recordar que log es de la rama actual.

---

### Error 3: Salida interminable

**Qué ocurrió:** miles de líneas y no encuentras nada.

**Por qué:** log completo sin filtros en un repositorio activo.

**Cómo comprobarlo:** el volumen.

**Opciones:** `--oneline -n`, `--grep`, `--since`, rama concreta.

**Riesgos:** pérdida de tiempo.

**Solución:** filtros y vista compacta.

**Cómo se evita:** empezar siempre por `git log --oneline -n 10`.

---

### Error 4: Esperar ver el contenido de los archivos en el log

**Qué ocurrió:** se busca «qué tenía el archivo antes» en el log.

**Por qué:** log lista commits; el contenido se ve con `git show`/`git log -p` o abriendo el commit (browse).

**Cómo comprobarlo:** la salida no incluye diffs (a menos que lo pidas).

**Opciones:** `git log -p -- archivo` o `git show hash`.

**Riesgos:** frustración.

**Solución:** distinguir «lista de commits» de «contenido de commits».

**Cómo se evita:** memorizar qué hace cada comando (log=listar, show/ver diff).

---

### Error 5: Fechas que no coinciden con lo recordado

**Qué ocurrió:** «este commit es de septiembre» y la fecha dice otra.

**Por qué:** la fecha es la de creación del commit; a veces se confunde con la de fusión o con la fecha relativa aproximada de otra vista.

**Cómo comprobarlo:** fecha exacta en el log (con zona horaria).

**Opciones:** usar la fecha del log como fuente.

**Riesgos:** reportes imprecisos.

**Solución:** fechas exactas.

**Cómo se evita:** citar hash + fecha del log.

---

### Error 6: Copiar el hash completo mal

**Qué ocurrió:** `git show <hash>` falla al pegar el hash.

**Por qué:** copia incompleta, con espacios o caracteres de más.

**Cómo comprobarlo:** el mensaje de error («ambiguous argument» o similar).

**Opciones:**
* copiar los 7 primeros caracteres (suelen bastar);
* o el hash completo, limpio.

**Riesgos:** ninguno (solo corrección).

**Solución:** hashes cortos bien copiados.

**Cómo se evita:** seleccionar desde la salida con cuidado.

---

## 7. Práctica guiada

### Objetivo

Leer tu historial con criterio: formato, filtros y localización.

### Paso 1: log completo

```bash
git log
```

1. Identifica: hash, autor, fecha, título, cuerpo.
2. Sal con `q`.

### Paso 2: vista diaria

```bash
git log --oneline -n 10
```

1. ¿Cuántos commits ves?
2. Localiza el primero que hiciste en la práctica.

### Paso 3: estructura

```bash
git log --oneline --graph --all
```

1. ¿Hay ramas? (si las creaste en la sección 05, verás su forma).
2. Sal con `q`.

### Paso 4: filtro por archivo

```bash
git log --oneline -- README.md
```

1. ¿Qué commits tocaron el README?

### Paso 5: filtro por texto

```bash
git log --grep="práctica"
```

1. ¿Aparece tu commit de prácticas?

### Paso 6: filtro por fecha

```bash
git log --oneline --since="1 week ago"
```

1. ¿Coincide con tu actividad reciente?

### Paso 7: localizar y mostrar

1. Copia el hash corto de un commit.
2. `git show <hash>` → observa cabecera y diff.
3. `q` para salir.

### Resultado esperado

Capacidad de responder «¿qué pasó, cuándo, quién y dónde está el commit?» usando log con filtros.

### Conclusión esperada

`git log` es la memoria consultable del proyecto: con formato compacto para mirar de un vistazo y filtros para buscar con precisión.

---

## 8. Nivel profesional

### 8.1. Auditoría y trazabilidad

```text
Preguntas de auditoría y su comando
──────────────────────────────────────────────
¿Quién cambió X y cuándo?     git log -- archivo
¿Qué hizo María este mes?     git log --author="..." --since=...
¿Qué decía el commit Y?       git show <hash>
¿Cuándo entró la función Z?   git log -S"nombre" (búsqueda
                              de adición/eliminación, avanzado)
```

### 8.2. git log en guiones

```bash
git log --format="%h %an %ad %s" --date=short
```

```text
Formato personalizado para MÁQUINAS:
   %h  hash corto
   %an autor
   %ad fecha
   %s  título

combine con --pretty=... o --format=... y greps de sistema
para generar reportes automáticos.
```

### 8.3. Encontrar el culpable (bisect)

Cuando algo se rompió y no sabes en qué commit:

```text
Búsqueda binaria (idea)
   │
   ├── Git te lleva a un commit del medio
   ├── tú dices: ¿bueno o malo?
   ├── Git acota la mitad del rango
   └── en pocos pasos localizas el commit exacto
       (comando: git bisect — se menciona en la
        sección 11/temas de recuperación)
```

### 8.4. Límites del log

```text
Lo que el log NO te da solo
   │
   ├── el estado actual de archivos (→ status/diff)
   ├── los cambios sin commitear (→ status)
   ├── el detalle de un commit (→ show)
   └── la diferencia entre dos puntos (→ git diff a..b)
```

---

## 9. Resumen

En este capítulo aprendiste que:

* `git log` lista los commits de la rama actual, del más reciente al más antiguo, con hash, autor, fecha y mensaje;
* la salida pasa por un paginador (`less`): `q` sale, flechas navegan;
* `--oneline` da la vista compacta diaria; `--graph` muestra la estructura de ramas; `-n` limita cantidad;
* los filtros (`--author`, `--grep`, `--since/--until`, ruta de archivo) convierten el log en una herramienta de búsqueda;
* `git show <hash>` abre un commit con su diff (conexión con el capítulo 12);
* los errores típicos (paginador, rama equivocada, filtros excesivos, buscando contenido en la lista) se resuelven entendiendo el alcance de cada comando;
* a nivel profesional, el log alimenta la auditoría, los reportes con formato personalizado y la búsqueda de commits con `bisect`.

La idea principal es:

> **`git log` es la memoria del proyecto en forma de lista: compacta para mirar, filtrada para buscar y completa para entender cada decisión que el historial registra.**

---

## Próximo paso

Ya sabes leer la historia.

El siguiente paso es comparar: ver exactamente qué cambió con `git diff`.

Continúa con:

[`11-git-diff.md`](11-git-diff.md)
