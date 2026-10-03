# Ver los cambios

## Introducción

Antes de convertir tus cambios en historial hay un paso que separa a los usuarios cuidadosos de los apresurados: **revisar**. Ver los cambios es mirar exactamente qué vas a guardar: qué archivos, qué líneas, qué se añade y qué se quita.

En GitHub Desktop esta revisión tiene una pestaña propia, con la lista de archivos modificados y la vista de diferencia (diff). Aprender a leerla bien te protege de los tres grandes accidentes del trabajo diario: commitear algo que no querías, meter basura (archivos de prueba, secretos) y pasar por alto un error propio (una línea borrada sin querer).

En este capítulo aprenderás:

* a leer la pestaña de cambios de GitHub Desktop;
* a interpretar cada tipo de estado (M, A, D, R);
* a leer un diff línea a línea;
* a detectar cambios inesperados (reformateos, secretos, archivos de más);
* a comparar cambios antes y después de un commit;
* a descartar cambios con criterio (y sus riesgos);
* errores comunes, práctica guiada y nivel profesional (revisiones en equipo).

---

## Mapa conceptual de este capítulo

```text
Ver los cambios
       │
       ├── 1. La pestaña de cambios
       │        ├── Lista de archivos
       │        ├── Estados
       │        └── Dónde se ve
       │
       ├── 2. Leer el diff
   │        ├── Anatomía
   │        ├── Contexto
   │        └── Signado (+ / -)
   │
       ├── 3. Qué buscar en una revisión
   │        ├── Cambios no deseados
   │        ├── Secretos
   │        ├── Archivos de más
   │        └── Reformateos
   │
       ├── 4. Acciones sobre la revisión
   │        ├── Aceptar y seguir
   │        ├── Corregir y volver a mirar
   │        └── Descartar cambios (riesgo)
   │
       ├── 5. Cambios en comparación con el historial
   │
       ├── 6. Errores comunes con diagnóstico completo
   │
       ├── 7. Práctica guiada
   │
       ├── 8. Nivel profesional
   │        ├── Revisión por pares
   │        ├── Vistas ampliadas
   │        └── Reglas de equipo
   │
       └── 9. Resumen y siguiente paso
```

---

## 1. La pestaña de cambios

### 1.1. Dónde está

```text
GitHub Desktop (repositorio abierto)
   │
   ├── Pestaña superior: "Changes" (Cambios)
   │      →  lo que cambió desde el último commit
   │
   ├── Pestaña: "History" (Historial)
   │      →  commits ya hechos (lo estudiaste en la web;
   │         aquí aplica a tu repositorio local)
   │
   └── "Preview" (Vista previa) del commit: qué se
       enviará si pulsas Commit
```

### 1.2. Anatomía de la lista

```text
Vista "Changes"
──────────────────────────────────────────────
Changes (3)
   │
   ├──  M  README.md
   ├──  A  docs/nuevo.md
   └──  D  borrador.txt
   │
   ── Vista previa del archivo seleccionado ──
   (diff)
   │
   [ cuadro: descripción del commit ]
   [ botón: Commit to main ]
```

### 1.3. Los estados

```text
Letra  Significado        Qué pasó en el disco
──────────────────────────────────────────────────────
 M     Modified           Existe y cambió su contenido
 A     Added              Es nuevo (no estaba en el
                           último commit)
 D     Deleted            Existía y ya no está
 R     Renamed            Cambió de nombre
                           (a veces Desktop lo muestra
                            como D + A)
```

### 1.4. Contadores y selección

```text
Puntos útiles
   │
   ├── el encabezado indica CUÁNTOS cambios hay
   ├── cada archivo es seleccionable (muestra su diff)
   └── según la versión, puedes marcar/desmarcar archivos
       para incluirlos o excluirlos del próximo commit
       (si tu versión lo permite; si no, la división se
        hace con varias etapas o por terminal)
```

---

## 2. Leer el diff

### 2.1. Anatomía

```text
Diff de ejemplo
──────────────────────────────────────────────
@@ Archivo: README.md @@      (encabezado)

  # Mi proyecto                (sin marca = sin cambio)
- versi\u00f3n vieja               (rojo = quitado)
+ versi\u00f3n nueva               (verde = añadido)
  l\u00ednea que se queda         (sin marca)
```

### 2.2. Signos

```text
Signo      Significado
──────────────────────────────────────────────
+          La línea está en la NUEVA versión (se añade)
-          La línea estaba y desaparece (se quita)
sin signo  La línea es igual en ambas versiones (contexto)
```

### 2.3. El contexto importa

Los diff muestran unas líneas de alrededor para ubicarte:

```text
Por qué ver contexto
   │
   ├── entiendes DÓNDE está el cambio dentro del archivo
   ├── detectas si el cambio «toca» zonas vecinas
   └── un diff sin contexto parece magia; con contexto,
       es una historia
```

### 2.4. Diff por archivo vs. global

```text
Revisión recomendada
──────────────────────────────────────────────
1. Mira la LISTA completa: ¿todos los archivos son
   los que esperabas?
2. Abre cada archivo y lee su diff
3. No te saltes el archivo «raro» (el de configuración,
   el nuevo, el borrado): ahí suelen estar los problemas
4. Al final, vuelve a la lista: ¿sigue todo correcto?
```

---

## 3. Qué buscar en una revisión

### 3.1. Cambios no deseados en archivos que no tocabas

```text
Señal: aparece un archivo que no tocaste
   │
   ├── Posibles causas:
   │      · el editor reformató (saltos de línea/espacios)
   │      · un proceso generó/archivó archivos
   │      · arrastraste algo sin querer
   │
   ├── Acción: abrir el diff y decidir:
   │      · si es ruido → descartarlo o arreglar el editor
   │      · si es legítimo → entenderlo y commitearlo
   │         (si merece mensaje propio, mejor en su commit)
```

### 3.2. Secretos y datos sensibles

```text
Checklist anti-secretos (10 segundos)
──────────────────────────────────────────────
[ ] Aparece un .env con valores reales?        → NO commitear
[ ] Veo tokens, claves, contraseñas en diffs?   → NO commitear
[ ] Datos personales de terceros?               → NO commitear
[ ] Rutas absolutas de mi equipo (C:\Users\...) → revisar

Ante la duda: no commitees; revisa después con calma.
```

### 3.3. Archivos de más

```text
Basura típica en la lista
   │
   ├── archivos de prueba (prueba.txt, temp, test123)
   ├── copias de seguridad (informe - copia.md)
   ├── artefactos del sistema (.DS_Store, Thumbs.db)
   └── archivos gigantes (¿de dónde salió?)
```

### 3.4. Reformateos masivos

```text
Señal: diff de 300 líneas para un cambio de 2
   │
   ├── causa típica: saltos de línea o espacios finales
   ├── comprobación: si todas las líneas tienen +/- pero
   │   el texto «es igual», es ruido de formato
   └── decisión: arreglar la configuración y revertir
       el ruido (deshacer en editor y volver a guardar),
       o si el proyecto ya lo espera, asumirlo en commit
       aparte (nunca mezclado con cambios reales)
```

---

## 4. Acciones sobre la revisión

### 4.1. Aceptar y seguir

Si todo está correcto: pasas al capítulo 07 (commit). La revisión termina bien cuando puedes resumir en una frase qué hace tu cambio.

### 4.2. Corregir y volver a mirar

```text
Ciclo de corrección
──────────────────────────────────────────────
revisas → encuentras un problema → vuelves al editor
   → corriges → GUARDAS → vuelves a Desktop
   → la lista se actualiza → revisas OTRA VEZ
```

La segunda mirada es la que casi nunca se hace y la que evita los errores.

### 4.3. Descartar cambios (con cuidado)

Desktop permite descartar cambios (Discard):

```text
Discard = borrar el cambio local SIN commitearlo
──────────────────────────────────────────────
   │
   ├── El archivo vuelve al estado del último commit
   ├── NO se puede deshacer (a menos que el contenido
   │   exista en otro sitio: otro commit, tu editor
   │   con copia, etc.)
   │
   ├── Cuándo es legítimo:
   │      · cambio de prueba que no quieres
   │      · ruido de formato que vas a repetir bien
   │      · cambio que hiciste por error en la carpeta
   │
   └── Cuándo NO: «tengo prisa y lo descarto todo»
          →  puedes tirar horas de trabajo
```

> **Advertencia:** «Discard all changes» es una de las acciones más destructivas del flujo diario. Deshacer no existe. Antes de pulsarlo, lee la lista entera.

### 4.4. Guardar trabajo ajeneno momento

Si quieres conservar cambios sin commitearlos aún (por ejemplo, cambiando de tarea), la herramienta profesional es el **stash** (guardar temporal en un sitio aparte), que verás en la sección 11. Por ahora: si no quieres commitear, simplemente no lo hagas, pero no descartes.

---

## 5. Cambios en comparación con el historial

### 5.1. Los cambios vs. el último commit

```text
Pregunta que responde la pestaña Changes:
   «¿QUÉ difiere de la instantánea más reciente?»

   último commit ──► tu disco actual
                     (la diferencia = cambios pendientes)
```

### 5.2. Tras el commit, los cambios desaparecen

```text
Al hacer commit:
   │
   ├── los cambios pasan de "pendientes" a "historial"
   ├── la lista de cambios queda vacía
   └── si sigues viendo cambios: quedó algo fuera
       (bien: puede ser intencionado; revisa)
```

### 5.3. Comparar con el remoto (sin pull)

```text
A veces quieres saber: «¿mi local está al día con GitHub?»
   │
   ├── la acción Fetch/Pull lo comprueba (capítulo 09)
   └── mientras tanto, la lista Changes solo habla de
       TU trabajo pendiente, no del estado del remoto
```

---

## 6. Errores comunes con diagnóstico completo

### Error 1: Commitear sin revisar el diff

**Qué ocurrió:** entró un archivo de prueba o se borró una línea importante sin verlo.

**Por qué:** saltarse la revisión.

**Cómo comprobarlo:** abrir el commit reciente en History y leer su diff.

**Opciones:**
* si es reciente y tuyo: corregir con otro commit (añadiendo lo que faltó o quitando lo que sobró);
* si hay prisa en equipo: comunicarlo.

**Riesgos:** historial con basura; errores al producción.

**Solución:** commit de corrección (nunca borrar el pasado).

**Cómo se evita:** regla: la revisión es parte del trabajo, no un trámite.

---

### Error 2: Descartar sin querer (Discard all)

**Qué ocurrió:** pulsación errónea; horas de trabajo desaparecieron.

**Por qué:** el botón quedó a un clic; prisa.

**Cómo comprobarlo:** la lista de cambios se vacía y los archivos vuelven atrás.

**Opciones:**
* buscar el contenido en otra parte (correo, copia, editor con historial propio);
* en algunos editores con «local history» puedes recuperar el texto;
* Git no lo tiene guardado (no era commit): esto es lo que duele.

**Riesgos:** pérdida real de trabajo.

**Solución:** recuperación desde copias externas si las hay; si no, rehacer.

**Cómo se evita:** nunca pulsar Discard con la lista sin leer; trabajar con commits frecuentes para que poco trabajo esté «en el aire».

---

### Error 3: Creer que la lista vacía significa «todo subido»

**Qué ocurrió:** cambios vacíos en Desktop, pero el equipo no ve nada nuevo en GitHub.

**Por qué:** se hizo commit local, pero no push (o se confundió con push).

**Cómo comprobarlo:** History muestra el commit local; GitHub (remoto) no lo tiene aún.

**Opciones:** hacer push (capítulo 08).

**Riesgos:** creer que «ya está» y que otro no lo ve.

**Solución:** recordar la cadena local → commit → push → remoto.

**Cómo se evita:** comprobar en GitHub si la duda es «¿ya subió?».

---

### Error 4: Revisar solo el primer archivo

**Qué ocurrió:** tres archivos modificados, se revisó uno y se commitearon los tres.

**Por qué:** fatiga o prisa.

**Cómo comprobarlo:** el commit contiene cambios que no miraste.

**Opciones:** leer ahora el diff completo y corregir si hace falta.

**Riesgos:** los problemas viven en los archivos que no miraste.

**Solución:** protocolo: lista completa → cada diff → conclusión.

**Cómo se evita:** no existe «revisión parcial»: o revisas todo o asumes el riesgo conscientemente.

---

### Error 5: No notar un archivo borrado

**Qué ocurrió:** apareció una D (Deleted) de un archivo que no recordabas borrar.

**Por qué:** acción accidental en el explorador (o un limpiador automático).

**Cómo comprobarlo:** la lista; el diff muestra el archivo completo en rojo.

**Opciones:**
* si no debía borrarse: restaurarlo (deshacer en explorador, o copiar del historial) y no commitear el borrado;
* si era correcto: commitear con mensaje claro («Elimina X porque Y»).

**Riesgos:** perderlo del proyecto sin querer.

**Solución:** decidir conscientemente.

**Cómo se evita:** revisar siempre las D con atención.

---

### Error 6: Comparar «a ojo» con GitHub sin refrescar

**Qué ocurrió:** se hizo push, se abre la web y «no cambió».

**Por qué:** navegador con caché o pestaña vieja.

**Cómo comprobarlo:** refrescar (F5); mirar el commit más reciente.

**Opciones:** recargar; si el push falló, verlo en Desktop (estado de sincronización).

**Riesgos:** preocupación inútil.

**Solución:** refrescar y comprobar el estado de push.

**Cómo se evita:** mirar el indicador de Desktop (subido/no subido) antes que el navegador.

---

## 7. Práctica guiada

### Objetivo

Practicar la revisión completa de cambios: detectar un problema intencionalmente colocado.

### Paso 1: preparar cambios

En tu repositorio de práctica:

1. Modifica `README.md` correctamente (añade una sección).
2. Crea un archivo `basura.tmp` (texto cualquiera).
3. Borra sin querer una línea de `notas.md`.

### Paso 2: revisar la lista

1. Abre la pestaña Changes.
2. Identifica: 1 Modified, 1 Added, 1 Deleted... (según lo que hayas hecho).
3. Pregunta: ¿qué esperaba ver? ¿coincide?

### Paso 3: leer cada diff

1. `README.md`: confirma que solo cambió tu sección.
2. `basura.tmp`: detecta que NO debe entrar.
3. `notas.md`: detecta el borrado accidental.

### Paso 4: corregir

1. Borra `basura.tmp` del disco (o exclúyelo si tu versión permite marcar archivos).
2. Restaura la línea perdida en `notas.md` (editor → guardar).
3. Vuelve a Desktop: la lista refleja los cambios de la corrección.
4. Revisa OTRA VEZ: ahora solo queda lo correcto.

### Paso 5: el momento de la verdad (sin commitear aún)

1. Comprueba que la lista queda exactamente como quieres.
2. NO pulses Commit todavía: este capítulo termina en la revisión.

### Resultado esperado

Una lista de cambios limpia, con capacidad para detectar archivos ajenos y ediciones accidentales.

### Conclusión esperada

La revisión no es burocracia: es la última puerta donde puedes evitar que un error tuyo entre en el historial para siempre.

---

## 8. Nivel profesional

### 8.1. Revisión por pares (antes del PR)

```text
Flujo profesional
──────────────────────────────────────────────
1. Reviso MI diff (como en este capítulo)
2. Hago commit(s) coherentes
3. Push a mi rama
4. Abro Pull Request
5. OTRO revisa SU vista del diff en GitHub
6. Comentarios y correcciones (commits nuevos)
7. Fusión
```

La revisión propia (este capítulo) es la previa; la ajena llega con el PR (sección 17). Ninguna sustituye a la otra.

### 8.2. Vistas y herramientas ampliadas

```text
Cuando el diff de Desktop se queda corto
   │
   ├── comparar commits concretos en la web
   ├── abrir el repositorio en un editor con vista diff
   │   (muchos editores tienen visor de diferencias)
   ├── herramientas gráficas dedicadas a diff/merge
   │   (se usan en conflictos; sección 10)
   └── en revisión de PR: anotar líneas concretas
```

### 8.3. Reglas de equipo de revisión

```text
Checklist que algunos equipos usan
──────────────────────────────────────────────
[ ] El diff hace UNA cosa
[ ] Mensajes de commit explican el porqué
[ ] Sin secretos ni datos personales
[ ] Sin archivos generados o de prueba
[ ] Sin cambios de formato mezclados
[ ] Pruebas/docs actualizados si el cambio lo exige
[ ] Archivos borrados: justificados
```

---

## 9. Resumen

En este capítulo aprendiste que:

* la pestaña de cambios de GitHub Desktop lista los archivos alterados desde el último commit, con estados M, A, D y R;
* el diff se lee con signos: `+` añadido, `-` quitado, sin marca = contexto;
* la revisión sigue un orden: lista completa, diff de cada archivo, segunda mirada;
* los cuatro peligros a detectar: cambios no deseados, secretos, archivos de más y reformateos masivos;
* descartar cambios es destructivo e irreversible: se usa con criterio, nunca con prisa;
* lista vacía ≠ subido: el commit es local hasta el push;
* los errores típicos se diagnostican abriendo el commit o la lista y comparando con la intención;
* a nivel profesional, la revisión propia precede a la revisión ajena del Pull Request, y ambas usan checklists para no depender de la memoria.

La idea principal es:

> **Revisar es convertir «creo que cambié lo que quería» en «sé exactamente qué voy a guardar». Ese acto de certeza es lo que hace confiable al historial.**

---

## Próximo paso

Ya sabes leer tus cambios con criterio.

El siguiente paso es confirmarlos: hacer el commit desde GitHub Desktop.

Continúa con:

[`07-hacer-un-commit.md`](07-hacer-un-commit.md)
