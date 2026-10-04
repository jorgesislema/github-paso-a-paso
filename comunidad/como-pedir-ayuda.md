# Cómo pedir ayuda

Pedir ayuda bien es una habilidad técnica. Este documento es la guía práctica y breve: la fórmula, la plantilla y los criterios. La versión completa, con los cincuenta y cuatro apartados y ejercicios, está en [`../00-orientacion/04-como-pedir-ayuda.md`](../00-orientacion/04-como-pedir-ayuda.md).

---

## 1. La fórmula en una línea

```text
Contexto + objetivo + lo que hiciste + lo que esperabas
+ lo que pasó (mensaje exacto) + estado actual
+ pregunta concreta
```

Una pregunta sin contexto obliga a la otra persona a adivinar. Con contexto, la mitad de las veces la respuesta aparece al escribirlo.

---

## 2. Antes de preguntar (dos minutos)

```text
   │
   ├── 1. ¿Está en el material? (busca en el capítulo,
   │       el glosario y el índice)
   │
   ├── 2. ¿Puedo reproducirlo? (si no lo reproduces,
   │       no lo entiendes todavía)
   │
   ├── 3. ¿Qué dice git status / git log? (el estado
   │       manda, no el recuerdo)
   │
   └── 4. ¿Qué intenté ya? (incluirlo evita que te
       repitan lo que ya hiciste)
```

---

## 3. La plantilla

```text
CONTEXTO
Estoy en la etapa X, capítulo Y. Rama: Z.
Repositorio: práctica / proyecto (indicar cuál).

OBJETIVO
Quiero conseguir: ...

QUÉ HICE
1. ...
2. ...

QUÉ ESPERABA
Que ocurriera: ...

QUÉ OCURRIÓ
Paso real (lo que pasó en su lugar).

MENSAJE DE ERROR
[copiar EXACTO, sin traducir, sin recortar]

ESTADO ACTUAL
git status → ...
(commits recientes con git log --oneline -n 5)

PREGUNTA
¿Por qué ... / ¿cuál es la diferencia entre ... /
¿qué compruebo primero?
```

---

## 4. Ejemplo malo y ejemplo bueno

```text
MALO:
«me sale un error al hacer push, ¿cómo lo arreglo?»
   → sin estado, sin mensaje, sin contexto: obliga a
     adivinar

BUENO:
«Estoy en 09-git-remoto, práctica de push. Al hacer
`git push origin main` recibo:

 ! [rejected]  main -> main (non-fast-forward)

Esperaba subir mi commit. `git status -sb` dice
main...origin/main [ahead 1] y antes hice un commit
nuevo encima de uno que ya había subido. ¿Qué pasó
aquí y cuál es la opción más segura para subirlo?»
   → reproducible, con estado, con pregunta concreta
```

---

## 5. Preguntar «por qué», no solo «qué comando»

```text
   │
   ├── «¿qué comando uso?» te da UNA ejecución
   │
   └── «¿por qué este comando y no el otro?» te da
       criterio para los próximos veinte casos
```

Y cuando recibas la respuesta, añade: ¿qué pasaría si hago lo contrario? Esa segunda pregunta es donde vive el aprendizaje.

---

## 6. Dónde preguntar

```text
   │
   ├── dudas del material de ESTE repositorio → Issue
   │   de tipo pregunta o el canal indicado en
   │   CONTRIBUTING.md
   │
   ├── errores del material → comunidad/
   │   como-reportar-un-error.md
   │
   ├── problemas con GIT en general → comunidad
   │   oficial / foros / Stack Overflow con el formato
   │   completo
   │
   └── en equipo de trabajo → el canal del equipo con
       la misma plantilla (contexto incluido)
```

---

## 7. Cuidado con los datos privados

Antes de publicar cualquier mensaje o log:

```text
   │
   ├── tokens, contraseñas, claves SSH        → nunca
   ├── nombres de usuario/repositorios
   │   internos de tu empresa                 → borra
   ├── rutas con tu identidad                 → acorta
   └── URLs con credenciales incrustadas      → borra
```

Si algo ya se publicó: revoca la credencial (rotate) primero; después limpia el texto.

---

## 8. Cuando te ayudan a ti, responde después

```text
Cierra el círculo:
   │
   ├── di qué fue lo que resolvió el problema
   │
   └── si era un error del material, reporta la
       mejora (como-reportar-un-error.md)
```

Las respuebas «ya lo arreglé, gracias» sin decir qué funcionó obligan al siguiente atascado a repetir toda la investigación.

---

## 9. Cuando TÚ ayudas a otro

```text
   │
   ├── pide los datos que faltan (plantilla) antes de
   │   dar comandos
   │
   ├── explica primero el porqué; el comando después
   │
   ├── no des comandos destructivos sin avisar de los
   │   riesgos
   │
   └── la buena ayuda produce independencia: al final,
       la persona debe poder explicarlo sin ti
```

---

## Resumen

* dos minutos de diagnóstico propio antes de preguntar;
* plantilla completa: contexto, objetivo, pasos, esperado, real, mensaje exacto, estado, pregunta;
* copia los errores tal cual y borra datos privados;
* pregunta «por qué», no solo «qué»;
* cierra el círculo: cuenta qué funcionó y reporta errores del material.

La idea principal es:

> **Pedir ayuda bien es entregar a otra persona todo lo que tú necesitarías para resolverlo: estado, pasos y salida exacta — la pregunta llega al final.**

---

## Próximo paso

Guía aplicada:

* [`como-reportar-un-error.md`](como-reportar-un-error.md) — si encontraste un fallo en el material.
* [`../00-orientacion/04-como-pedir-ayuda.md`](../00-orientacion/04-como-pedir-ayuda.md) — la versión completa con ejercicios.
