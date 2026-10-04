# Proyecto 1: primer repositorio

## Introducción

La teoría se convierte en práctica con un primer proyecto completo: **un repositorio real que uses, con historial real, remoto real y hábitos reales**. Este capítulo es la consigna del Proyecto 1 de la etapa 27: no se trata de un ejercicio de laboratorio desechable, sino de tu primer repositorio de verdad — el sitio donde aplicarás todo lo de las secciones 02 a 07 sin rodeos.

---

## Mapa conceptual de este capítulo

```text
Proyecto 1: primer repositorio
       │
       ├── 1. Qué construyes y qué conceptos incorpora
       ├── 2. Requisitos (los que hará «real» al repo)
       │   ├── 3. Estructura y primeros pasos
       │   └── 4. Criterios de entrega (definition of done)
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes y qué conceptos incorpora

```text
EL PROYECTO (sencillo y tuyo):
   │
   ├── un repositorio con un pequeño programa o sitio
   │   que TÚ uses (lista de tareas, utilidad de
       escritorio, recetas, notas — algo que te sirva)
   │
   └── lo importante NO es el código: es el REPO
       funcionando de punta a punta
```

```text
CONCEPTOS NUEVOS QUE INCORPORA (secciones 02–07):
   │
   ├── repositorio, commit, historial (sección 02/03)
   ├── staging area, .gitignore, diff (sección 04)
   ├── rama, merge, primer flujo (sección 05/07)
   ├── remoto, push, pull, fetch (sección 06)
   └── README que explica el proyecto (sección 14 —
       lo esbozas aquí)
```

```text
   │
   └── si al terminar puedes responder «¿por qué este
       commit?» «¿qué hace esa rama?» «¿qué cambió en
       el remoto?» — el proyecto cumplió (Error 1 si
       solo «subiste archivos»: no es un repo, es un
       almacén — Error 4 sección 06 cap. 04)
```

---

## 2. Requisitos (los que harán «real» al repo)

```text
REQUISITOS OBLIGATORIOS:
   │
   ├── creado en tu cuenta (GitHub + local) — sección
   │   01/06
   ├── .gitignore adecuado al lenguaje ANTES del primer
   │   commit (sección 04)
   ├── historial con commits atómicos y mensajes con
   │   sentido (Error 2 si «primer commit» = 40
   │   archivos sin message; sección 06)
   ├── al menos 2 ramas con merge real (sección 05/07)
   ├── remoto sincronizado: push desde local, pull con
   │   cambios hechos en la web (sección 06)
   └── README: qué es, cómo se ejecuta, cómo
       contribuir a ELLO aunque seas uno (sección 14
       cap. 02)
```

```text
REQUISITOS OPCIONALES (recomendados):
   │
   ├── 2 issues reales (un «bug» encontrado y una
   │   «idea») (sección 16)
   └── etiquetas básicas (bug, enhancement) (sección 16
       cap. 04)
```

```text
   │
   └── requisito NO incluido: que el programa sea
       bonito o completo — el entregable es el REPO
       disciplinado (Error 3 si pasas el fin de semana
       en CSS y un solo commit)
```

---

## 3. Estructura y primeros pasos

```text
ORDEN RECOMENDADO (cada paso = commits):
   │
   ├── 1. crear repo remoto (privado si quieres) + clonar
   ├── 2. .gitignore + README inicial («en construcción»)
   ├── 3. código mínimo que funcione (1 commit por pieza
   │       con mensaje explicando)
   ├── 4. rama `feature/...` para el siguiente bloque +
   │       merge cuando esté (Error 4 si nunca rama: el
   │       repo de un solo día no practica)
   ├── 5. encontraste un bug → issue → rama `fix/...` →
   │       merge (el ciclo completo)
   └── 6. pull de un cambio hecho desde la web (edita
       README en GitHub) — enseña la doble dirección
```

```text
NOMBRES Y MENSAJES (tu primera disciplina):
   │
   ├── rama: `feature/agregar-busqueda` (descriptiva)
   ├── commit: «Agrega búsqueda por título» (imperativo,
   │   qué y por qué corto — sección 06 cap. 03)
   └── nada de «cambios», «wip», «más» (Error 5)
```

```text
   │
   └── verifica en la web: historial visible, ramas
       listadas, README renderizado — el repo EXISTE
       para otros (Error 6 si solo existe en tu disco)
```

---

## 4. Criterios de entrega (definition of done)

```text
CHECKLIST DEL PROYECTO 1:
   │
   ├── [ ] repo remoto + clon local sincronizados
   ├── [ ] .gitignore desde el inicio
   ├── [ ] ≥ 6 commits con mensajes descriptivos
   ├── [ ] ≥ 2 ramas con merge (rastro visible en
   │       historial)
   ├── [ ] al menos 1 pull desde la web
   ├── [ ] README con «qué es / cómo ejecutar»
   ├── [ ] 2 issues (uno cerrado con fix)
   └── [ ] puedes explicar TU historial en 2 minutos
           (Error 7 si nadie lo entiende — Error
           2 sección 01 de esta sección)
```

```text
   │
   └── con esto, el Proyecto 1 está ENTREGADO — no
       cuando el programa «quede fino» (Error 3)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: subir archivos sin trabajar en Git

**Qué ocurrió:** se arrastraron todos los archivos al repo web; nunca hubo `git` local ni historial.

**Por qué:** se confundió repo con almacén (punto 1).

**Cómo comprobarlo:** ¿hay historial con varios commits y ramas?

**Opciones:** clonar, rehacer el historial con commits atómicos (o empezar de nuevo con el checklist).

**Riesgos:** no practicaste nada de la sección 02–07.

**Solución:** el ciclo local→remoto completo (punto 3).

**Cómo se evita:** seguir el orden del punto 3.

---

### Error 2: commit gigante inicial

**Qué ocurrió:** un único commit con todo; imposible ver evolución ni revertir nada.

**Por qué:** sin staging ni atómica (sección 04).

**Cómo comprobarlo:** `git log --stat` — ¿un commit con todo?

**Opciones:** desde ahora: commits por pieza; el anterior se acepta como «inicio».

**Riesgos:** historial inútil para bisect/revert.

**Solución:** atómicos desde el día 1 (sección 06 cap. 01).

**Cómo se evita:** preguntarse «¿qué toca en este commit?» antes de agregar.

---

### Error 3: proyecto sin terminar por pulir código

**Qué ocurrió:** dos semanas «mejorando» el programa; el repo tiene 1 commit y cero prácticas.

**Por qué:** se priorizó producto sobre entregable (Error 3 punto 2).

**Cómo comprobarlo:** checklist del punto 4: ¿cuántas casillas?

**Opciones:** congelar el código «suficiente» y ejecutar el punto 3 completo.

**Riesgos:** entregable incompleto.

**Solución:** done = repo, no demo (punto 4).

**Cómo se evita:** el orden del punto 3 con límite de tiempo al código.

---

### Error 4: nunca se usó una rama

**Qué ocurrió:** todo en `main`; el «principio de ramas» se quedó en teoría.

**Por qué:** no se incluyó en el proyecto (punto 3).

**Cómo comprobarlo:** ¿cuántas ramas muestra el historial?

**Opciones:** coge el siguiente cambio y hazlo en `feature/...` con merge.

**Riesgos:** secciones 05/07 sin practicar.

**Solución:** rama real por bloque (punto 3).

**Cómo se evita:** requisito de entrega (punto 4).

---

### Error 5: mensajes sin significado

**Qué ocurrió:** «cambios», «más», «fix»… el historial no explica nada.

**Por qué:** sin convención (Error 5 punto 3).

**Cómo comprobarlo:** lee `git log --oneline` — ¿se entiende la historia?

**Opciones:** reescribir los últimos mensajes si aún no se compartieron (Error 5 sección 06 cap. 03); mantener convención a partir de ahora.

**Riesgos:** olvidar por qué se hizo cada cosa.

**Solución:** mensajes descriptivos (punto 3).

**Cómo se evita:** plantilla mental: «Agrega/Corrige + qué».

---

### Error 6: repo invisible para otros

**Qué ocurrió:** todo perfecto en local; la web quedó sin actualizar y el README no existía allí.

**Por qué:** sin sincronización ni verificación remota (punto 3).

**Cómo comprobarlo:** ¿el remoto refleja tu último commit? ¿README renderiza?

**Opciones:** push final + pull de prueba web.

**Riesgos:** creer sincronizado lo que no lo está.

**Solución:** doble verificación local/web (punto 3).

**Cómo se evita:** mirar el remoto al final de cada sesión.

---

## 6. Práctica guiada

### Objetivo

Entregar el Proyecto 1 completo con la checklist del punto 4.

### Paso 1: elige el tema

1. Algo que uses tú: lista de tareas, gastos, recetas, notas. Alcance: lo que hagas en 1–2 sesiones.

### Paso 2: monta el repo

1. Remoto + clon + `.gitignore` + README inicial (punto 3, pasos 1–2).

### Paso 3: programa por piezas

1. Código mínimo con 1 commit por pieza y mensajes con sentido (paso 3).

### Paso 4: practica ramas

1. Siguiente bloque en `feature/...` → merge → historial visible (paso 4).
2. Bug real → issue → `fix/...` → merge → cierra el issue (paso 5).

### Paso 5: practica doble dirección

1. Edita el README desde la web y haz `pull` (paso 6).

### Paso 6: entrega

```text
Checklist punto 4 completa → entrega
Explicación de 2 minutos de TU historial
   (guárdala: es la entrevista contigo mismo)
```

### Resultado esperado

Repo remoto vivo con historial explicable, ramas mergeadas, issues y README.

### Conclusión esperada

Un repositorio «real» no se parece a un almacén de archivos: se parece a una conversación escrita — cada commit cuenta qué pasó y por qué, y cualquiera puede seguir la historia.

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto a la vida real

```text
   │
   ├── en un trabajo, el Proyecto 1 es tu «ambiente de
   │   práctica»: la disciplina es idéntica, cambia la
   │   audiencia (sección 15/16)
   │
   ├── el README y los issues que practicaste aquí son
   │   el germen de la documentación (sección 14) y del
   │   trabajo con tareas (sección 16)
   │
   ├── lo que NO incluiste (CI, seguridad) llega en el
   │   Proyecto 4 — la progresión es deliberada
   │
   └── hábito clave a conservar: commits pequeños con
       mensaje que se lea en la retrospectiva
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el Proyecto 1 mide el repositorio, no el producto: historial, ramas, remoto y README;
* requisitos concretos (gitignore desde el inicio, commits atómicos, 2 ramas, pull web, issues) hacen «real» al repo;
* el orden importa: repo → base → código por piezas → ramas → bug → sincronización;
* la definition of done es la checklist del punto 4, no el pulido del programa;
* los errores típicos (archivos sin Git, commit gigante, pulir sin entregar, sin ramas, mensajes vacíos, remoto desincronizado) se previenen con el orden y la checklist;
* la progresión lleva este hábito a proyectos mayores sin cambiar de método.

La idea principal es:

> **Tu primer repositorio no se juzga por lo que contiene, sino por la historia que cuenta — y un historial que se entiende es la primera señal de que ya no eres un usuario de archivos, sino un desarrollador.**

---

## Próximo paso

Repo entregado.

Ahora el proyecto 2: un diario digital con trabajo de documentación, issues y colaboración ligera.

Continúa con:

[`02-proyecto-2-diario-digital.md`](02-proyecto-2-diario-digital.md)
