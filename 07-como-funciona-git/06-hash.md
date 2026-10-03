# Hash

## Introducción

El **hash** es la identidad de todo en Git: cada commit, cada versión de archivo (blob) y cada árbol de directorios tiene uno. No lo elige nadie: Git lo **calcula** a partir del contenido. Esa idea —identidad derivada de los datos— es la raíz de la inmutabilidad, la integridad y la colaboración concurrente de Git.

Cuando ves `a3f9c21` en el log, estás mirando la firma matemática de todo lo que ese commit contiene. Si cambia un solo byte de cualquier parte, el hash cambia: por eso Git detecta corrupciones, evita duplicados y sabe exactamente qué le falta a quién.

En este capítulo aprenderás:

* qué es un hash y qué es SHA-1 en Git (y las menciones a SHA-256);
* qué entra en el cálculo de un commit;
* propiedades: determinista, sensible al cambio, de longitud fija, no invertible;
* consecuencias prácticas: identidad, integridad, deduplicación, distribución;
* errores comunes con diagnóstico completo, práctica guiada y nivel profesional.

---

## Mapa conceptual de este capítulo

```text
Hash
       │
       ├── 1. Qué es
   │        ├── función resumen (digest)
   │        ├── SHA-1 en Git; mención SHA-256
   │        └── longitud fija: 40 hex (8 con -short)
   │
       ├── 2. Qué calcula Git
   │        ├── blob: contenido
   │        ├── árbol: nombres + modos + hashes
   │        └── commit: árbol + padre + autor + mensaje
   │
       ├── 3. Propiedades
   │        ├── determinista
   │        ├── sensible al cambio (avalancha)
   │        ├── no invertible
   │        └── longitud fija
   │
       ├── 4. Consecuencias prácticas
   │        ├── identidad y equivalencia
   │        ├── integridad (fsck, push)
   │        ├── deduplicación
   │        └── seguridad de la red
   │
       ├── 5. Errores comunes con diagnóstico completo
   │
       ├── 6. Práctica guiada
   │
       ├── 7. Nivel profesional
   │        ├── corrupción y detección
   │        ├── hashes cortos y colisiones
   │        └── futuro SHA-256
   │
       └── 8. Resumen y siguiente paso
```

---

## 1. Qué es

### 1.1. Función resumen (digest)

```text
entrada (cualquier tamaño)  →  función  →  salida fija
"El Quijote entero..."      →  SHA-1  →  40 caracteres hex

   │
   ├── la salida es un RESUMEN: representa al contenido
   ├── misma entrada → misma salida (siempre)
   └── entrada distinta → salida distinta (con probabilidad
       prácticamente 1)
```

### 1.2. SHA-1 en Git

```text
   │
   ├── Git usa históricamente SHA-1 (Secure Hash
   │   Algorithm 1) de 160 bits → 40 dígitos hexadecimales
   │
   ├── en la práctica se usan prefijos cortos: 7-12
   │   caracteres (a3f9c21) — suficientes para proyectos
   │
   └── Git prepara soporte para SHA-256 (y hay repos
       en esa modalidad); para la mayoría de equipos
       2026, SHA-1 sigue siendo lo estándar
```

### 1.3. Dónde aparecen los hashes

```bash
git log --oneline     # prefijos de commit
git ls-files -s       # hashes de blobs (staging)
```

```text
Tipo de objeto   Identificado por hash
──────────────────────────────────────────────
blob             una versión de un archivo
tree             un directorio (lista de nombres
                 + modos + hashes hijas)
commit           un instante (árbol + padres + mensaje)
etiqueta         un nombre fijo (tag) hacia un objeto
```

---

## 2. Qué calcula Git

### 2.1. Un blob

```text
entrada real (conceptual):
   "blob 123\0<contenido del archivo>"
   (tipo + tamaño + separador nulo + bytes)

→  hash del CONTENIDO puro (sin nombre ni ruta)
   ⇒ el mismo contenido en dos archivos/directorios
     produce el MISMO hash (base de la deduplicación)
```

### 2.2. Un árbol

```text
entrada: lista ordenada de entradas
   modo  nombre  hash
   100644 notas.md  a3f9…
   040000 docs      7b21…

→  un cambio en un hijo o en un nombre cambia
   el hash del árbol (y por tanto el del commit)
```

### 2.3. Un commit

```text
entrada (conceptual):
   tree    <hash del árbol raíz>
   parent  <hash del padre>
   author  María <…> 1759… +0200
   committer …

   <mensaje>

→  hash = huella de TODO eso junto
   ⇒ cambiar el mensaje, la fecha o un archivo
     cambia el hash del commit
```

```text
Regla de oro
   │
   ├── el hash identifica la INFORMACIÓN COMPLETA
   └── misma información ⇒ mismo hash, en cualquier
       máquina del mundo
```

---

## 3. Propiedades

### 3.1. Determinista

```text
misma entrada → mismo hash (siempre, en todas partes)
   │
   └── por eso dos personas pueden comparar hashes
       sin compartir archivos
```

### 3.2. Sensible al cambio (avalancha)

```text
cambiar UN bit de entrada → hash completamente distinto
   │
   └── no existen «hash parecidos»: o son idénticos
       o son irreconocibles
```

### 3.3. No invertible

```text
del hash NO se puede recuperar el contenido
   │
   └── Git almacena contenido y calcula hash; no es
       «cifrado» (y por eso nunca subas secretos:
       solo consiguen estar versionados)
```

### 3.4. Longitud fija

```text
entrada gigante o minúscula → salida siempre 40 hex
   │
   └── facilita comparar, indexar y detectar
       corrupción tamaño a tamaño
```

---

## 4. Consecuencias prácticas

### 4.1. Identidad y equivalencia

```bash
git log --oneline
git show a3f9c21
```

```text
   │
   ├── el hash local ES el hash remoto: si el tuyo
   │   y el de tu compañera dicen a3f9c21, es el
   │   MISMO commit (no «uno parecido»)
   │
   └── por eso en errores push/remoto no hay duda de
       «qué commits me faltan»: se comparan identidades
```

### 4.2. Integridad

```text
   │
   ├── al clonar/push, Git verifica: recalcular ≠
   │   almacenado ⇒ corrupción detectada
   │
   ├── git fsck examina el repositorio completo
   │
   └── un historial alterado «a mano» cambia hashes de
       la cadena para adelante: se ve (y en foros
       públicos, la alteración posterior es difícil de
       esconder bien)
```

### 4.3. Deduplicación

```text
   │
   ├── mismo contenido = mismo blob → guardado una vez
   │   (un archivo de 10 MB tocado en 1 línea: el blob
   │   viejo y el nuevo; el resto se reutiliza)
   │
   └── por eso el repositorio no crece linealmente con
       cada commit
```

### 4.4. Transferencia segura (conceptual)

```text
   │
   ├── cliente y servidor hablan en hashes: «dame el
   │   objeto X» / «te doy X»; el cliente verifica
   │
   └── no hace falta confiar en la red: el resumen
       confirma la entrega
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: «No such object / bad revision» con un hash

**Qué ocurrió:** un hash no se reconoce.

**Por qué posibles:**
* está incompleto o mal copiado (guiones, espacios);
* es de otro repositorio;
* se copió de un log borroso (confundir dígitos);
* el objeto no se descargó aún (en clon parcial).

**Cómo comprobarlo:** copiar de `git log --oneline` de nuevo; `git cat-file -t <hash>` (devuelve el tipo si existe).

**Opciones:** usar el hash completo desde log/show; fetch si faltan objetos.

**Riesgos:** concluir «se perdió el commit» (casi nunca).

**Solución:** identidad exacta antes de ejecutar.

**Cómo se evita:** copiar-pegar de la salida, nunca a mano.

---

### Error 2: Esperar que dos personas tengan «el mismo hash» con contenido distinto

**Qué ocurrió:** comparamos «el commit X» de dos repos y «no coinciden».

**Por qué:** en un caso se copió contenido, no historia (o se recreó un commit con otra fecha/autor: los metadatos cambian ⇒ hash distinto).

**Cómo comprobarlo:** comparar con `git show` ambos: si el mensaje/fecha/árbol difieren, son distintos.

**Opciones:** en flujo correcto (push/pull), los hashes sí coinciden.

**Riesgos:** confusión en merges por «falsos iguales».

**Solución:** recordar: hash de INFORMACIÓN COMPLETA (metadatos incluidos).

**Cómo se evita:** trabajar por la vía normal de Git, no reconstruir historias a mano.

---

### Error 3: Hash troceado mal en comandos

**Qué ocurrió:** pegaste `a3f9c21` con la letra O en vez del cero, o cortaste con guion.

**Por qué:** ser humano en hexadecimal (a-f y 0-9).

**Cómo comprobarlo:** mensaje de Git.

**Opciones:** copiar de nuevo; usar el paginador del log para seleccionar.

**Riesgos:** pérdida de tiempo (mitigado).

**Solución:** siempre desde la salida de Git.

**Cómo se evita:** prefijos largos cuando hay duda (`--abbrev=12`).

---

### Error 4: Creer que el hash cifra o protege datos

**Qué ocurrió:** se pensó que con «estar con hash» un secreto está a salvo.

**Por qué:** confusión resumen ≠ cifrado.

**Cómo comprobarlo:** el contenido se almacena tal cual (se puede extraer con cat-file/show).

**Opciones:** rotar el secreto YA si se subió; sacarlo del historial con política de equipo (no con escondidas locales).

**Riesgos:** filtración real.

**Solución:** gitignore + higiene; nunca credenciales en el repo.

**Cómo se evita:** recordar: Git es un almacén de texto plano verificable.

---

### Error 5: Alters manuales en `.git` y cadena rota

**Qué ocurrió:** alguien editó algo dentro de `.git` o renombró objetos.

**Por qué:** tocar la base de datos a mano.

**Cómo comprobarlo:** `git fsck` reporta errores; comandos varios fallan.

**Opciones:**
* restaurar `.git` desde clon/backup (lo sano);
* en casos raros: `git gc`/repair con criterio (documentación oficial).

**Riesgos:** pérdida de integridad local.

**Solución:** no tocar nunca `.git` a mano.

**Cómo se evita:** conocimiento: `.git` es base de datos, no carpeta de trabajo.

---

### Error 6: Esperar hash «legibles» o secuenciales

**Qué ocurrió:** alguien esperaba que los hashes «sigan orden» (aumenten).

**Por qué:** son resultados de función, no contadores.

**Cómo comprobarlo:** dos commits seguidos con hashes sin relación.

**Opciones:** ninguna: es la naturaleza.

**Riesgos:** minúscula confusión al leer logs.

**Solución:** el orden lo da la cadena de padres (log), no el hash.

**Cómo se evita:** entender qué identifica cada campo.

---

## 6. Práctica guiada

### Objetivo

Ver hashes en acción: cómo cambian y qué representan.

### Paso 1: observa los objetos

```bash
git log --oneline -n 5
git cat-file -p HEAD
```

1. Anota el hash del HEAD y su `tree` y `parent`.
2. `git cat-file -t HEAD` → `commit`.

### Paso 2: cambia un byte y observa el efecto

1. Edita un archivo (un solo carácter).
2. `git add` + `git commit -m "Prueba de hash"`.
3. `git log --oneline -n 2`: ¿el hash nuevo es «parecido» al anterior? (No: avalancha.)

### Paso 3: mismo contenido, mismo blob

```bash
# crea copia de un archivo con contenido idéntico:
cp notas.md notas-copia.md
git add notas.md notas-copia.md
git ls-files -s
```

1. Localiza: ¿los dos archivos comparten el mismo hash de blob? (Sí: el contenido es el mismo.)
2. Cambia un carácter en la copia → `git add` → `ls-files -s`: ahora difieren.

### Paso 4: hash del commit depende del mensaje

```bash
# prepara el MISMO cambio y commitea en dos ramas
# con mensajes distintos (prueba breve)
git log --format="%H %s" -n 2
```

1. Los hashes difieren aunque el contenido fuera igual: el mensaje entra en la identidad.

### Paso 5: integridad

```bash
git fsck --no-progress
```

1. Sin errores = tu base de datos está sana.
2. (Si está en paquete o tarda: es normal en repos grandes.)

### Resultado esperado

Intuición directa: hash = huella de información completa; cambia con todo; identifica sin ambigüedad; verifica integridad.

### Conclusión esperada

El hash es lo que convierte al historial en una cadena verificable: nadie cambia «por debajo» sin que las huellas lo delaten.

---

## 7. Nivel profesional

### 7.1. Corrupción y detección

```text
Herramientas
──────────────────────────────────────────────
git fsck              →  revisión de integridad
git count-objects -vH →  tamaño/estadísticas
git verify-pack       →  inspección de empaquetados
(recuperación: desde remoto/backup — el remoto suele
 poder reponer cualquier objeto dañado)
```

### 7.2. Hashes cortos y colisiones

```text
   │
   ├── prefijos cortos: Git verifica colisión localmente
   │   y alarga automáticamente si hace falta
   │
   ├── colisión teórica SHA-1: la comunidad Git la
   │   trata con mitigaciones (objeto «literalmente
   │   seguro») y desplazamiento a SHA-256
   │
   └── en la práctica diaria: ninguna incidencia real
       para proyectos normales
```

### 7.3. SHA-256 (estado 2026)

```text
   │
   ├── Git soporta repositorios SHA-256 (formato de
   │   objetos nuevo, hash de 64 hex)
   │
   ├── migración: coordinada entre servidores y clientes;
   │   no se «cambia de golpe» un repo existente
   │
   └── entender SHA-1 hoy no se pierde: el MODELO
       (hash de contenido) es idéntico
```

---

## 8. Resumen

En este capítulo aprendiste que:

* el hash en Git es un resumen SHA-1 (40 hex; prefijos de 7-12 en uso) calculado del contenido completo de cada objeto;
* los tres tipos de objeto (blob, árbol, commit) se identifican por hash: el commit incluye árbol + padres + metadatos + mensaje;
* propiedades clave: determinista, sensible al cambio, no invertible y de longitud fija;
* consecuencias: identidad compartida entre máquinas, integridad verificable (`fsck`, transferencias), deduplicación de contenido y comunicación segura por resúmenes;
* los errores típicos (hash mal copiado, «mismo commit» reconstruido, creer que el hash cifra, tocar `.git`) se resuelven copiando identidades de la salida de Git y jamás manipulando la base de datos;
* a nivel profesional: detección de corrupción, prefijos cortos con colisiones cubiertas y la transición larga a SHA-256 sin cambiar el modelo conceptual.

La idea principal es:

> **En Git la identidad se demuestra, no se asigna: el hash es la huella matemática de la información, y esa huella sostiene todo —historial, distribución e integridad—.**

---

## Próximo paso

Cada commit se identifica por su hash… pero solo hay un sitio desde el que «miras» el historial.

Ese puntero se llama HEAD.

Continúa con:

[`07-head.md`](07-head.md)
