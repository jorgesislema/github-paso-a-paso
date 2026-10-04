# Cómo reportar un error

Encontrar un error en este repositorio también forma parte del aprendizaje.

Si algo está mal — un comando que no funciona, un diagrama confuso, un enlace roto, una errata, una explicación que no cuadra — puedes reportarlo. Este documento explica cómo hacerlo de forma que el error se entienda, se verifique y se corrija rápido.

---

## 1. Antes de reportar

```text
COMPRUEBA PRIMERO:
   │
   ├── 1. ¿Es un error del material o un error tuyo de
   │       ejecución? (revisa paso a paso el ejemplo)
   │
    ├── 2. ¿Está en la última versión del repositorio?
   │       (actualiza tu clon: git pull)
   │
   ├── 3. ¿Ya está reportado? (busca en Issues)
   │
   └── 4. ¿Depende de tu equipo? (Windows/macOS/Linux,
        versión de Git) — si es así, dilo desde el
       inicio: puede no ser un error del material
```

Un reporte de «esto no me funciona» sin contexto obliga a adivinar. Un reporte con contexto se arregla en minutos.

---

## 2. Qué información incluir

```text
PLANTILLA DE REPORTE
──────────────────────────────────────────────────────
[Descripción breve]  →  título de una línea

Qué ocurrió:
  qué ejemplo/comando/capítulo seguiste y qué pasó
  (copia el mensaje de error EXACTO, sin traducir ni
  recortar)

Dónde:
  sección y capítulo (p. ej. 10-git-conflictos /
   04-resolver-un-conflicto.md, «Error 3»)

Qué esperabas:
  el resultado descrito en el material

Pasos para reproducir:
  1. ...
  2. ...
  3. ...

Entorno (si aplica):
   sistema operativo, versión de git --version,
  terminal utilizada

Sugerencia (si tienes):
  cómo crees que debería decirlo o corregirse
```

---

## 3. Copiar el error sin manipular

```text
   │
   ├── copia el texto TAL CUAL aparece (mantén el
   │   idioma original de Git/GitHub)
   │
   ├── no lo resumas: «algo de permisos» no ayuda
   │
    └── SIEMPRE borra datos privados: nombres de usuario
       de tu empresa, rutas con tu identidad, tokens,
       contraseñas, direcciones internas
```

Ejemplo de mensaje de error bien copiado:

```text
 ! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs to 'https://...'
hint: Updates were rejected because the remote
hint: contains work that you do not have locally.
```

---

## 4. Dónde reportarlo

```text
Según el tipo:
   │
   ├── error del contenido (texto, código, diagrama)
   │   → Issue del repositorio
   │
   ├── vulnerabilidad de seguridad real
   │   → NO publiques detalles en un Issue público:
   │     consulta la sección de seguridad de
   │     CONTRIBUTING.md y usa el canal indicado allí
   │
   ├── pregunta de aprendizaje («no entiendo X»)
   │   → no es un error: pregunta según
   │     comunidad/como-pedir-ayuda.md
   │
   └── mejora de contenido («falta explicar Y»)
       → Issue de tipo «mejora» o discusión
```

---

## 5. Ejemplo de reporte bien hecho

```text
Título: Comando de ejemplo falla en Windows

Qué ocurrió:
En «05-git-stash», Paso 5, se sugiere:
    git stash push -m "..." -- src/estilos.css
En mi caso (Windows, PowerShell) el patrón no
encuentra el archivo.

Dónde: 11-git-deshacer-y-recuperar/05-git-stash.md,
«Paso 5».

Qué esperabas: que el archivo se guardara en el stash.

Pasos para reproducir:
1. git init demo && cd demo
2. crear src/estilos.css con contenido
3. git add . && git commit -m "base"
4. modificar src/estilos.css
5. git stash push -m "x" -- src/estilos.css

Entorno: Windows 11, PowerShell, git version 2.4x.x

Sugerencia: aclarar que el patrón depende de la ruta
exacta del archivo respecto al directorio actual.
```

---

## 6. Qué pasa después

```text
   │
   ├── el reporte se reproduce (o se pide
   │   confirmación con un dato más)
   │
   ├── se clasifica: error, errata, mejora
   │
   ├── se corrige con commit que referencia el Issue
   │
   └── si no se puede reproducir en tu entorno, se
        documenta la causa (a veces el «error» es una
       diferencia de entorno legítima — también es
       aprendizaje)
```

---

## 7. Errores comunes al reportar

### Error 1: reportar con solo «no funciona»

Sin pasos, sin entorno y sin mensaje exacto, el reporte no es reproducible. Aplica la plantilla del punto 2.

### Error 2: pegar capturas de terminal ilegibles

El texto copiado es buscable y verificable; la imagen pequeña no. Prefiere texto (las capturas solo como complemento).

### Error 3: publicar datos sensibles en un Issue público

Tokens, contraseñas o rutas internas en Issues quedan visibles (y a veces en el historial aunque los edites). Borra datos privados ANTES de publicar.

### Error 4: mezclar un error con una discusión de diseño

Un Issue = un tema. «Esto está mal y además propongo reescribir la sección entera» se divide en dos: corrección y propuesta.

### Error 5: no volver a comprobar tras la corrección

Si reportaste algo y se corrigió, verifica que tu duda quedó resuelta; si no, añade el detalle que faltaba en el mismo Issue.

---

## Resumen

Para reportar un error bien:

* comprueba que lo es (y que no está ya reportado);
* incluye dónde, qué pasó, qué esperabas, cómo reproducirlo y tu entorno;
* copia los mensajes exactos y borra datos privados;
* nunca publiques vulnerabilidades en Issues públicos;
* un tema por reporte.

La idea principal es:

> **Un buen reporte de error es un experimento reproducido: contexto, pasos, salida exacta — y nada de secretos.**

---

## Próximo paso

Si lo que necesitas es aprender a preguntar mientras estudias, consulta:

[`como-pedir-ayuda.md`](como-pedir-ayuda.md)

Y para saber cómo contribuir con mejoras al repositorio, consulta [`../CONTRIBUTING.md`](../CONTRIBUTING.md).
