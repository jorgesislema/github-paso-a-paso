# Proyecto 2: diario digital

## Introducción

El Proyecto 2 eleva la apuesta: un **diario digital** — un sitio de entradas (posts) publicables por fechas — donde el contenido ES el repositorio. Aquí el código importa menos que el flujo de trabajo con textos: versionar escritura, usar ramas por entrada, documentar, usar issues como calendario editorial y practicar tu primer despliegue estático. Es el puente natural entre «sé usar Git» (Proyecto 1) y «sé trabajar como equipo» (Proyecto 4 en adelante).

---

## Mapa conceptual de este capítulo

```text
Proyecto 2: diario digital
       │
       ├── 1. Qué construyes y qué conceptos incorpora
       ├── 2. Requisitos del proyecto
       │   ├── 3. Estructura del contenido (el repo)
       │   └── 4. Flujo editorial con Git
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué construyes y qué conceptos incorpora

```text
EL PROYECTO:
   │
   ├── un repositorio con tu diario: entradas (markdown
   │   por fecha), índice (README) y una forma de verlo
   │   publicado (paso final: despliegue estático —
   │   sección 19/22)
   │
   └── 6–10 entradas escritas durante el proyecto —
       contenido real, no lorem ipsum
```

```text
CONCEPTOS NUEVOS (secciones 14, 16, 19):
   │
   ├── documentación como producto (sección 14)
   ├── issues como tareas editoriales (sección 16)
   ├── plantilla de entrada y convenciones (sección 18)
   ├── primer workflow: publicar el sitio (sección 19)
   └── despliegue = automatizar «lo publicado» (sección
       22 — primera cara visible de CI/CD)
```

```text
   │
   └── el aprendizaje central: CONTENIDO también se
       versiona — y el flujo editorial es un flujo de
       Git como cualquier otro (Error 1 si escribes
       «directo en producción»)
```

---

## 2. Requisitos del proyecto

```text
CONTENIDO:
   │
   ├── 6+ entradas con fecha en el nombre (convención
   │   elegida por ti y documentada)
   ├── índice (README o index) que liste las entradas
   └── plantilla de entrada (la copias al escribir una
       nueva — Error 2 si cada entrada tiene formato
       distinto: la plantilla es el estándar inicial)
```

```text
FLUJO (Git + GitHub):
   │
   ├── rama por entrada: `post/agregar-entrada-fecha`
   ├── al menos 1 entrada pasada por «revisión» (puedes
   │   ser tú de mañana: déjala 1 día y relee con ojo
   │   de revisor — Error 3 si auto-apuebas sin pausa)
   ├── issues editoriales: «tema pendiente», «corregir
   │   entrada 3» — y cierra al resolver (sección 16)
   └── historial limpio: una entrada = un merge (rastro
       visible)
```

```text
PUBLICACIÓN:
   │
   ├── el sitio se PUBLICA AUTOMÁTICAMENTE con un
   │   workflow (GitHub Pages o equivalente — sección
   │   19 cap. 01/04: el primer «ya está en línea»
   │   sin tocar nada)
   └── probar: ¿escribir → merge → publicado solo?
       (Error 4 si publicas a mano: no practicaste
       automatización)
```

```text
   │
   └── README del repo: qué es el diario, cómo se
       agrega una entrada, cómo se publica — la
       «documentación de contribuidor» aunque seas 1
```

---

## 3. Estructura del contenido (el repo)

```text
ESTRUCTURA SUGERIDA (la tuya puede variar, pero
documenta):
   │
   ├── README.md        → índice + cómo contribuir
   ├── plantilla/
   │     entrada.md     → plantilla a copiar
   ├── entradas/            → 2026-10-01-titulo.md …
   ├── sitio/ (si aplica)   → index, estilos
   └── .github/
         workflows/     → publicación automática
         PULL_REQUEST_TEMPLATE.md (opcional, sección 15)
```

```text
CONVENCIONES (escríbelas en el README):
   │
   ├── formato de nombre de archivo
   ├── campos de la plantilla (fecha, título, cuerpo)
   └── «qué significa publicado» (Error 5 si cada
       entrada decide a su manera: el diario deja de
       parecerse a sí mismo)
```

```text
   │
   └── esta estructura es tu primer «estándar de
       repositorio» — el mismo oficio que después
       aplicarás a proyectos grandes (sección 25/26)
```

---

## 4. Flujo editorial con Git

```text
EL CICLO DE UNA ENTRADA (practícalo 6 veces):
   │
   ├── 1. issue: «entrar tema X» (planifica — sección
   │   16)
   ├── 2. rama desde la base actual: `post/...`
   ├── 3. escribe usando la plantilla (commit con
   │   mensaje: «Agrega entrada: título»)
   ├── 4. pulir: revisión propia con distancia o PR si
   │   tienes «segundo lector» (sección 15)
   ├── 5. merge a la rama principal
   └── 6. el workflow publica → verifica en el sitio →
       cierra el issue (Error 6 si el issue queda
       abierto: el ciclo no se cerró)
```

```text
   │
   └── variación recomendada: 1–2 entradas hechas
       desde la EDICIÓN WEB de GitHub (ramas + PR
       desde la interfaz) — practicas el flujo sin
       terminal (sección 10)
```

```text
   │
   └── con 6 ciclos completos, el flujo se vuelve
       hábito — y eso es exactamente lo que entrega el
       Proyecto 2
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: escribir directo en la rama principal

**Qué ocurrió:** entradas publicadas sin rama ni revisión; una con error se vio en línea.

**Por qué:** se saltó el flujo (punto 4).

**Cómo comprobarlo:** ¿las entradas aparecen en historial vía merge o como commits directos?

**Opciones:** rehacer el flujo con las entradas restantes; corregir la errónea con rama `fix/`.

**Riesgos:** producción = borrador (Error 4 sección 01 cap. 19).

**Solución:** ciclo completo (punto 4).

**Cómo se evita:** la regla «todo por rama» en el README del repo.

---

### Error 2: sin plantilla (formatos distintos)

**Qué ocurrió:** cada entrada tenía campos y estilos distintos; el índice no pudo generarse.

**Por qué:** estándar ausente (punto 2 Error 2).

**Cómo comprobarlo:** abre 3 entradas: ¿estructura idéntica?

**Opciones:** crear plantilla y unificar las existentes (commit dedicado).

**Riesgos:** el sitio deja de escalar.

**Solución:** plantilla copiable (punto 2).

**Cómo se evita:** «¿dónde está la plantilla?» en la checklist de entrega.

---

### Error 3: auto-aprobar sin pausa

**Qué ocurrió:** lo publicado tenía las erratas que solo ven al día siguiente.

**Por qué:** revisión instantánea (Error 3 punto 2).

**Cómo comprobarlo:** tiempo entre «última edición» y «merge».

**Opciones:** pausa obligada (horas) antes de merge; leer en voz alta; si hay segundo lector, PR real.

**Riesgos:** calidad de borrador inmediato.

**Solución:** distancia como revisor (punto 2/4).

**Cómo se evita:** el «commit final» de cada entrada siempre al día siguiente.

---

### Error 4: publicar a mano

**Qué ocurrió:** cada entrada exigía subir archivos al hosting; nadie lo hizo 3 semanas.

**Por qué:** sin automatización (punto 2 Error 4).

**Cómo comprobarlo:** ¿qué proceso publica hoy? ¿lo haces tú?

**Opciones:** workflow de publicación (sección 19 cap. 01/04) — prueba con un cambio trivial.

**Riesgos:** el proyecto muere con la fricción.

**Solución:** publicación automática (punto 2).

**Cómo se evita:** presupuesto: el workflow existe desde la semana 1 (aunque publique solo el README).

---

### Error 5: convenciones improvisadas

**Qué ocurrió:** nombres de archivo, fechas y campos cambiaron «por urgencia»; el índice quedó desordenado.

**Por qué:** convención sin escribir (punto 3).

**Cómo comprobarlo:** ¿README documenta el formato? ¿se cumple en todo?

**Opciones:** definir + unificar en un commit de estandarización.

**Riesgos:** fragmentación creciente.

**Solución:** convenciones escritas (punto 3).

**Cómo se evita:** revisarlas al añadir cada entrada.

---

### Error 6: ciclo sin cerrar

**Qué ocurrió:** issues de 8 temas; ninguno cerrado aunque 3 estaban publicados.

**Por qué:** no se cerró al mergear (punto 4 paso 6).

**Cómo comprobarlo:** lista de issues abiertos vs. entradas publicadas.

**Opciones:** cerrar los resueltos con enlace a la entrada; hábito: cierra en el mismo PR.

**Riesgos:** tablero que miente (Error 2 sección 16 cap. 05).

**Solución:** cierre en el mismo ciclo (punto 4).

**Cómo se evita:** checklist: merge + publicación + issue cerrado.

---

## 6. Práctica guiada

### Objetivo

Entregar un diario publicado automáticamente con 6 entradas siguiendo el ciclo editorial.

### Paso 1: estructura

1. Repo + estructura del punto 3 + plantilla + convenciones en README.

### Paso 2: automatiza

1. Workflow de publicación (sección 19 cap. 01/04): ¿commit a main → sitio actualizado? Verifica.

### Paso 3: el ciclo ×6

```text
issue → rama → plantilla → commit → pausa →
revisión → merge → publicado → issue cerrado
```

1. Ejecútalo 6 veces. Al menos 1 hecho desde la web (punto 4 variación).

### Paso 4: revisa el conjunto

1. Índice completo, entradas homogéneas, sitio publicado, issues cerrados.

### Paso 5: entrega

```text
Checklist:
   [ ] 6+ entradas con plantilla
   [ ] publicación automática funcionando
   [ ] issues cerrados con enlace
   [ ] README: qué es / cómo agregar / cómo publica
   [ ] historial: entradas vía merge con mensajes
```

### Resultado esperado

Diario publicado con flujo editorial completo y automatización funcionando sin intervención manual.

### Conclusión esperada

Cuando escribir, versionar y publicar se convierte en un ciclo de tres movimientos, has internalizado el verdadero tema del curso: el flujo, no la herramienta.

---

## 7. Nivel profesional + resumen

### 7.1. De este proyecto a la vida real

```text
   │
   ├── el «diario» es la versión amable de un CMS o
   │   blog de equipo: el flujo editorial es idéntico
   │   al de documentación de producto (sección 14)
   │
   ├── plantilla + convención = tu primer estándar de
   │   repositorio (sección 25 cap. 03/25 — gobernanza
   │   en miniatura)
   │
   ├── la publicación automática es tu primer pipeline:
   │   el Proyecto 4 lo hace formal con checks (sección
   │   19/22)
   │
   └── si un día escribes con más gente: CODEOWNERS y
       protección de main del Proyecto colaborativo
       cierran el círculo (sección 16 cap. 06)
```

### 7.2. Resumen

En este capítulo aprendiste que:

* el contenido también se versiona: plantilla, convenciones e índice son estándar;
* el ciclo editorial (issue → rama → plantilla → revisión con pausa → merge → publicación → cierre) se practica 6 veces hasta ser hábito;
* la publicación automática es la primera cara visible de CI/CD: commit → publicado, sin manos;
* README que documenta el flujo es parte del entregable;
* los errores típicos (directo en main, formatos variados, auto-aprobación instantánea, publicar a mano, convenciones improvisadas, issues sin cerrar) se previenen con plantilla y ciclo;
* la progresión lleva este flujo al Proyecto 4, ya con equipo y checks.

La idea principal es:

> **Un diario digital enseña que cualquier trabajo — incluso escribir — mejora cuando tiene plantilla, revisión con distancia y una publicación que ocurre sola: el contenido es solo otro artefacto del flujo.**

---

## Próximo paso

Tu diario se publica solo.

Ahora el Proyecto 3: recetario — una colección con estructura que se verifica sola.

Continúa con:

[`03-proyecto-3-recetario.md`](03-proyecto-3-recetario.md)
