# Cómo pedir ayuda

## Introducción

Aprender Git y GitHub no significa saberlo todo.

Incluso las personas con muchos años de experiencia encuentran problemas que nunca habían visto.

La diferencia entre una persona principiante y una persona con experiencia no consiste en que una nunca tiene problemas.

La diferencia está en **cómo enfrenta el problema**.

Una persona principiante puede decir:

> “Git no funciona.”

Una persona que está aprendiendo a diagnosticar puede decir:

> “Estoy en la rama `feature-login`, intenté hacer `git push`, Git rechazó la operación porque el repositorio remoto contiene cambios que no tengo localmente. Este es el mensaje completo y este era mi estado antes del comando.”

La segunda descripción permite investigar.

Por eso, aprender a pedir ayuda es una habilidad técnica.

---

# 1. Pedir ayuda también forma parte de programar

En tecnología nadie memoriza todas las respuestas.

Los profesionales consultan constantemente:

* documentación;
* manuales;
* ejemplos;
* repositorios;
* especificaciones;
* foros;
* comunidades;
* compañeros;
* herramientas de diagnóstico;
* inteligencia artificial.

La diferencia está en **cómo realizan la consulta**.

Una buena consulta reduce el tiempo necesario para encontrar una solución.

Una mala consulta puede producir muchas respuestas irrelevantes.

---

# 2. No existe ninguna vergüenza en preguntar

Una persona que está comenzando puede pensar:

> “Si pregunto esto, los demás pensarán que no sé nada.”

Esto puede impedir el aprendizaje.

Pero en tecnología existen miles de conceptos.

No es razonable esperar que una persona recuerde:

* todos los comandos;
* todas las opciones;
* todos los mensajes de error;
* todas las configuraciones;
* todas las diferencias entre versiones;
* todas las herramientas;
* todos los casos especiales.

Por eso:

> **Saber dónde buscar información es una competencia técnica.**

---

# 3. La primera pregunta no debe ser “¿qué comando uso?”

Antes de buscar un comando, intenta determinar:

> **¿Cuál es el problema que estoy intentando resolver?**

Por ejemplo:

Incorrecto:

> “¿Qué comando uso para arreglar Git?”

Mucho mejor:

> “Hice un commit local, pero ahora quiero modificar su mensaje porque todavía no lo he enviado al repositorio remoto.”

La segunda pregunta contiene un problema concreto.

---

# 4. La fórmula básica para pedir ayuda

Una buena consulta técnica normalmente contiene:

```text
Contexto
+
Objetivo
+
Qué hiciste
+
Qué esperabas
+
Qué ocurrió realmente
+
Mensaje de error
+
Estado actual
```

Podemos representarlo así:

```text
¿Dónde estoy?
      ↓
¿Qué quiero conseguir?
      ↓
¿Qué hice?
      ↓
¿Qué esperaba?
      ↓
¿Qué ocurrió?
      ↓
¿Qué mensaje apareció?
      ↓
¿Qué estado tengo ahora?
```

Esta estructura sirve para Git, programación, bases de datos, Linux, redes, IA y muchas otras áreas.

---

# 5. Contexto: explica dónde estás

El contexto permite entender el problema.

Por ejemplo:

> Estoy trabajando en un repositorio de práctica llamado `laboratorio-git`.

Eso es mejor que:

> “Git me da error.”

También puedes indicar:

```text
Sistema operativo: Windows
Herramienta: Git Bash
Repositorio: laboratorio-git
Rama: feature-prueba
```

No necesitas proporcionar información irrelevante.

El objetivo es proporcionar **el contexto que afecta al problema**.

---

# 6. Explica tu objetivo

Indica qué quieres conseguir.

Por ejemplo:

> Quiero enviar mi rama al repositorio remoto.

o:

> Quiero recuperar un archivo que eliminé accidentalmente.

o:

> Quiero deshacer el último commit sin perder los cambios de los archivos.

o:

> Quiero integrar mi rama con `main`.

El objetivo debe ser concreto.

---

# 7. Explica qué hiciste

No ocultes los pasos que realizaste.

Por ejemplo:

```text
Primero ejecuté:

git add .

Después:

git commit -m "Agregar formulario"

Finalmente:

git push
```

Si el problema apareció después de `git push`, esa información es importante.

---

# 8. Explica qué esperabas

Esta parte es especialmente útil.

Por ejemplo:

> Esperaba que Git enviara mi commit al repositorio remoto.

Ahora puedes comparar:

```text
Esperaba
   ↓
push exitoso
```

con:

```text
Ocurrió
   ↓
push rechazado
```

La diferencia entre ambos estados ayuda a localizar el problema.

---

# 9. Copia el mensaje de error completo

Cuando Git muestra un error, evita escribir solamente:

> “Me salió un error de Git.”

Es mejor copiar el mensaje.

Por ejemplo:

```text
error: failed to push some refs to '...'
```

Si existen más líneas, proporciona también las líneas relevantes.

El mensaje puede contener información fundamental para diagnosticar el problema.

---

# 10. No cambies el mensaje de error

Si estás pidiendo ayuda, intenta copiarlo exactamente.

No hagas esto:

> Git dice que no puedo subir mis archivos.

Si el mensaje real contiene información técnica, es mejor proporcionarlo tal como aparece.

Por ejemplo:

```text
$ git push origin main
To ...
 ! [rejected]        main -> main (non-fast-forward)
error: failed to push some refs to '...'
hint: Updates were rejected because the tip of your current branch is behind
```

El texto adicional puede ser precisamente la pista necesaria.

---

# 11. Cuidado con los datos privados

Copiar un mensaje de error no significa publicar información confidencial.

Antes de compartirlo, revisa si contiene:

* contraseñas;
* tokens;
* API keys;
* claves privadas;
* direcciones privadas;
* información personal;
* nombres internos de servidores;
* rutas sensibles;
* información empresarial confidencial.

Nunca publiques secretos.

Por ejemplo, si aparece:

```text
API_KEY=abc123...
```

no debes copiarla públicamente.

Puedes reemplazarla por:

```text
API_KEY=[REDACTADA]
```

---

# 12. Proporciona los comandos utilizados

Cuando sea relevante, muestra los comandos.

Por ejemplo:

```bash
git status
git branch
git add .
git commit -m "Prueba"
git push
```

Esto permite reconstruir la secuencia de acciones.

En Git, el orden puede ser importante.

No es lo mismo:

```text
commit → pull → push
```

que:

```text
pull → commit → push
```

El estado del repositorio puede ser diferente.

---

# 13. Muestra el estado actual del repositorio

Cuando el problema sea de Git, una de las primeras herramientas de diagnóstico es:

```bash
git status
```

Puedes incluir su resultado.

Por ejemplo:

```text
On branch feature-login

Changes not staged for commit:
  modified:   login.py
```

Esto aporta mucha más información que decir:

> “Tengo problemas con mi rama.”

---

# 14. Utiliza `git log` para explicar el historial

Cuando el problema tenga relación con commits o ramas, puede ser útil mostrar:

```bash
git log --oneline --decorate --graph --all
```

Por ejemplo:

```text
* 91ab234 (HEAD -> feature-login) Agregar formulario
* 32cd876 Agregar validación
| * 88de321 (main) Actualizar documentación
|/
* 71aa123 Crear proyecto
```

Ahora otras personas pueden visualizar la situación.

No siempre necesitas proporcionar un historial enorme.

Puedes compartir solamente la cantidad necesaria para explicar el problema.

---

# 15. Utiliza `git diff` cuando el problema sea un cambio

Si quieres saber qué modificaste:

```bash
git diff
```

puede mostrar las diferencias.

Por ejemplo:

```diff
- contraseña = "1234"
+ contraseña = "abc"
```

Esto permite analizar exactamente qué cambió.

Si el problema está relacionado con cambios preparados para commit, también puede ser útil:

```bash
git diff --staged
```

---

# 16. Aprende a formular una pregunta técnica

Una buena pregunta puede seguir esta estructura:

```text
Contexto:
Estoy trabajando en...

Objetivo:
Quiero...

Pasos realizados:
1. ...
2. ...
3. ...

Esperaba:
...

Ocurrió:
...

Mensaje:
...

Estado actual:
...

Pregunta:
¿Cómo puedo resolverlo y por qué ocurrió?
```

Este formato es excelente para aprender.

---

# 17. Ejemplo de una mala pregunta

```text
Git no funciona.

¿Qué hago?
```

El problema es que faltan demasiados datos.

No sabemos:

* qué sistema operativo utilizas;
* qué repositorio;
* qué comando ejecutaste;
* qué querías hacer;
* qué ocurrió;
* qué mensaje apareció;
* cuál es el estado actual.

---

# 18. Ejemplo de una buena pregunta

```text
Estoy trabajando en un repositorio de práctica llamado
laboratorio-git.

Estoy en la rama feature-login.

Quiero enviar mi trabajo al repositorio remoto.

Ejecuté:

git add .
git commit -m "Agregar login"
git push origin feature-login

El commit se creó correctamente, pero el push fue rechazado.

Git mostró:

[pegar aquí el mensaje completo]

Antes de ejecutar el push, git status mostraba:

[pegar aquí el resultado]

Esperaba que la rama se enviara correctamente.

¿Qué significa este error y qué opciones tengo para resolverlo sin perder mis cambios?
```

Esta pregunta permite comenzar un diagnóstico real.

---

# 19. Preguntar “por qué” es mejor que pedir solamente una solución

Una respuesta que solamente diga:

```bash
git pull
```

puede solucionar temporalmente un problema.

Pero quizá no hayas aprendido nada.

Una pregunta mejor es:

> ¿Por qué Git rechazó el `push` y qué cambia exactamente cuando ejecuto `git pull`?

Ahora estás intentando comprender.

Esto genera conocimiento reutilizable.

---

# 20. Pregunta también por las alternativas

Git suele ofrecer varias formas de resolver una situación.

Por ejemplo, si una rama local y una rama remota han evolucionado de manera diferente, podrían existir diferentes estrategias.

Puedes preguntar:

> ¿Qué opciones tengo?

y después:

> ¿Qué ventajas y riesgos tiene cada una?

Esto es mucho más útil que pedir:

> “Dame el comando.”

---

# 21. Pregunta por las consecuencias

Especialmente con operaciones peligrosas.

Si alguien propone:

```bash
git reset --hard HEAD~1
```

no deberías ejecutarlo automáticamente.

Pregunta:

> ¿Qué cambios perdería con este comando?

También:

> ¿Afecta solamente mi repositorio local o también el remoto?

Y:

> ¿Existe una alternativa que conserve mis cambios?

Estas preguntas desarrollan criterio técnico.

---

# 22. Aprende a diferenciar solución y explicación

Supongamos que tienes este problema:

```text
git push
↓
rechazado
```

Puedes recibir una respuesta que diga:

```bash
git pull
git push
```

Eso podría funcionar en determinadas situaciones.

Pero una explicación completa debería ayudarte a entender:

```text
Repositorio local
      ↓
Repositorio remoto
      ↓
Las historias son diferentes
      ↓
Git no puede avanzar directamente
      ↓
Necesita integrar los cambios
      ↓
Se debe elegir una estrategia
```

La solución concreta depende del estado del repositorio y del flujo de trabajo.

---

# 23. Utiliza la documentación oficial

Antes de depender exclusivamente de una respuesta de terceros, aprende a consultar la documentación oficial.

Git dispone de documentación integrada.

Por ejemplo:

```bash
git help
```

También:

```bash
git help status
```

o:

```bash
git status --help
```

Estas herramientas permiten consultar información directamente desde Git.

---

# 24. Aprende a buscar

Una gran parte del trabajo técnico consiste en encontrar información.

Una búsqueda poco útil sería:

```text
Git no funciona
```

Una búsqueda mucho mejor sería:

```text
Git push rejected non-fast-forward explicación
```

O:

```text
Git recuperar archivo eliminado sin commit
```

O:

```text
Git diferencia restore revert reset
```

La búsqueda debe describir el problema técnico.

---

# 25. No confíes automáticamente en el primer resultado

Internet contiene:

* documentación oficial;
* respuestas correctas;
* respuestas antiguas;
* respuestas incompletas;
* respuestas específicas para una situación diferente;
* comandos peligrosos sin suficiente explicación;
* contenido generado automáticamente;
* tutoriales desactualizados.

Por eso debes comparar información.

Una buena estrategia es:

```text
Resultado encontrado
       ↓
¿Quién lo publicó?
       ↓
¿Es documentación oficial?
       ↓
¿La situación coincide con la mía?
       ↓
¿La información sigue siendo válida?
       ↓
¿Tiene riesgos?
       ↓
¿Comprendo el comando?
```

---

# 26. La documentación oficial y las experiencias de la comunidad cumplen funciones diferentes

La documentación oficial suele ser especialmente útil para:

* comportamiento de comandos;
* opciones;
* sintaxis;
* conceptos;
* configuración;
* características de una herramienta.

Las comunidades pueden ser útiles para:

* experiencias reales;
* casos poco habituales;
* soluciones prácticas;
* problemas específicos;
* diferentes enfoques.

No significa que una fuente comunitaria sea incorrecta.

Significa que debes entender **qué tipo de información estás leyendo**.

---

# 27. Cómo utilizar la inteligencia artificial para aprender

La inteligencia artificial puede ser un excelente tutor.

Pero la forma de preguntar determina mucho la calidad de la respuesta.

Una pregunta débil:

> “Arregla mi Git.”

Una pregunta mucho mejor:

> “Actúa como tutor de Git. Te voy a proporcionar el estado del repositorio y el mensaje de error. Primero explícame qué está ocurriendo. Después enumera las opciones de solución, indica los riesgos de cada una y solamente al final proporciona los comandos.”

Esto obliga a analizar antes de ejecutar.

---

# 28. Pide que la IA explique antes de dar comandos

Especialmente cuando estás aprendiendo.

Puedes utilizar esta estructura:

```text
Primero explica:
1. Qué ocurrió.
2. Por qué ocurrió.
3. Qué estado tiene actualmente Git.
4. Qué opciones existen.
5. Qué riesgos tiene cada opción.

Después proporciona:
6. Los comandos.
7. Qué debería observar después de cada comando.
```

Esto transforma a la IA de un generador de comandos en una herramienta de aprendizaje.

---

# 29. No pegues automáticamente comandos destructivos

Si una IA responde:

```bash
git reset --hard HEAD~1
```

no significa que debas ejecutarlo.

Primero pregunta:

> ¿Qué perderé si ejecuto este comando?

Después:

> ¿Existe una alternativa que conserve mis cambios?

Y finalmente:

> ¿Qué información necesitas para determinar cuál opción es adecuada?

Este comportamiento es especialmente importante cuando trabajas con repositorios reales.

---

# 30. Aprende a proporcionar un ejemplo mínimo

Cuando el problema sea complejo, intenta reducirlo.

Supongamos que tienes un proyecto con:

```text
proyecto/
├── src/
├── tests/
├── docs/
├── config/
├── datos/
└── cientos de archivos
```

No necesitas enviar todo.

Puedes construir un caso pequeño que reproduzca el problema.

Por ejemplo:

```text
laboratorio/
├── archivo-a.txt
└── archivo-b.txt
```

Después:

```text
Cambio A
↓
Commit
↓
Cambio B
↓
Comando
↓
Error
```

Esto se conoce como reducir el problema a un ejemplo mínimo.

Es una habilidad muy valiosa.

---

# 31. ¿Qué significa “reproducir el problema”?

Reproducir significa poder volver a provocar la misma situación.

Por ejemplo:

```text
Paso 1 → crear archivo
Paso 2 → commit
Paso 3 → crear rama
Paso 4 → modificar archivo
Paso 5 → merge
Paso 6 → aparece conflicto
```

Si puedes repetir el problema, puedes estudiarlo.

Esto permite:

* experimentar;
* probar soluciones;
* comparar alternativas;
* documentar el comportamiento.

---

# 32. Aprender a diagnosticar

Pedir ayuda no debería ser siempre el primer paso.

Primero puedes realizar una pequeña investigación.

Por ejemplo:

```text
Problema
   ↓
git status
   ↓
git diff
   ↓
git log
   ↓
Leer error
   ↓
Consultar documentación
   ↓
Intentar comprender
   ↓
Pedir ayuda si todavía es necesario
```

Esto no significa que debas resolver todo solo.

Significa que debes aportar información útil cuando solicites ayuda.

---

# 33. La pregunta “¿qué intentaste?” es importante

Cuando alguien te ayuda, probablemente te preguntará:

> “¿Qué intentaste?”

No es una crítica.

Es una pregunta de diagnóstico.

La respuesta puede revelar:

* el estado inicial;
* la secuencia de comandos;
* el punto donde apareció el problema;
* las modificaciones que ya hiciste;
* posibles causas.

Por eso debes informar honestamente qué hiciste.

---

# 34. No ocultes errores

Un error frecuente al pedir ayuda es omitir algo porque pensamos:

> “Esto seguramente no importa.”

Por ejemplo:

> “Antes ejecuté `git reset --hard`, pero después hice algunas cosas.”

Ese detalle puede ser fundamental.

Cuando solicites ayuda:

**explica todos los pasos relevantes.**

---

# 35. Cómo pedir ayuda en un equipo

En un entorno profesional, una pregunta puede tener esta estructura:

```text
Título:
Push rechazado después de actualizar la rama remota

Contexto:
Estoy trabajando en feature/login.

Objetivo:
Enviar los cambios al remoto.

Situación:
La rama remota recibió un commit que no tengo localmente.

Comando:
git push origin feature/login

Resultado:
[error]

Diagnóstico realizado:
git status
git log --oneline --decorate --graph --all

Pregunta:
¿Cuál es la estrategia recomendada para integrar
el cambio remoto sin perder mi trabajo local?
```

Esta estructura facilita la colaboración.

---

# 36. No conviertas una pregunta en una novela

Pedir buena información no significa escribir páginas innecesarias.

Una buena pregunta debe ser:

* completa;
* relevante;
* concreta;
* ordenada.

Evita información que no afecta al problema.

La habilidad consiste en proporcionar **suficiente contexto, pero no ruido**.

---

# 37. Cómo responder cuando alguien te pide ayuda

Esta habilidad también debes aprenderla.

Si alguien pregunta:

> “¿Cómo arreglo este error?”

No respondas inmediatamente con un comando.

Primero puedes preguntar:

> “¿Qué quieres conseguir?”

Después:

> “¿Qué comando ejecutaste?”

Y:

> “¿Qué muestra `git status`?”

Esto permite diagnosticar.

La enseñanza técnica no consiste únicamente en proporcionar respuestas.

Consiste en ayudar a la otra persona a comprender el problema.

---

# 38. La ayuda debe construir independencia

Una buena explicación debería dejar a la persona con más capacidad que antes.

No solamente:

```text
Problema
↓
Comando mágico
↓
Problema solucionado
```

Sino:

```text
Problema
↓
Diagnóstico
↓
Comprensión
↓
Opciones
↓
Decisión
↓
Solución
↓
Aprendizaje
```

El objetivo final es que la próxima vez la persona pueda reconocer el problema por sí misma.

---

# 39. Una plantilla para pedir ayuda con Git

Puedes utilizar esta plantilla:

````text
## Contexto

Estoy trabajando en:
[repositorio/proyecto]

Sistema operativo:
[Windows/macOS/Linux]

Herramienta:
[Git Bash/GitHub Desktop/terminal/otra]

Rama actual:
[nombre de rama]

## Objetivo

Quiero:
[describir objetivo]

## Qué hice

1. [comando]
2. [comando]
3. [comando]

## Qué esperaba

[resultado esperado]

## Qué ocurrió

[resultado real]

## Mensaje de error

```text
[pegar mensaje]
````

## Estado actual

```text
[pegar git status]
```

## Información adicional

[otros datos relevantes]

## Pregunta

¿Qué ocurrió, por qué ocurrió y cuáles son las formas
seguras de resolverlo?

````

Esta plantilla puede utilizarse con:

- un profesor;
- un compañero;
- una comunidad;
- un foro;
- documentación;
- una IA.

---

# 40. Cómo pedir ayuda cuando no entiendes un concepto

No todos los problemas son errores.

A veces simplemente no entiendes un concepto.

Por ejemplo:

> “No entiendo qué significa `HEAD`.”

Una buena pregunta podría ser:

> “Entiendo que Git utiliza `HEAD`, pero no comprendo qué representa exactamente. ¿Puedes explicarlo primero con una analogía sencilla y después mostrar cómo se relaciona con una rama y un commit?”

Eso permite adaptar la explicación a tu nivel.

---

# 41. Cómo pedir una explicación progresiva

Si un concepto es difícil, puedes pedir:

```text
Explícalo primero para una persona que nunca
ha utilizado Git.

Después explícalo técnicamente.

Finalmente muestra cómo se utiliza en un proyecto real.
````

Esta estrategia es especialmente útil para conceptos como:

* `HEAD`;
* staging area;
* rebase;
* cherry-pick;
* reflog;
* hooks;
* ramas remotas;
* CI/CD;
* GitHub Actions;
* DevOps.

---

# 42. No tengas miedo de decir “no entiendo”

Una frase muy útil es:

> “No entiendo este paso.”

Después especifica:

> “Entiendo hasta aquí, pero no comprendo qué ocurre después de `git add`.”

Esto permite localizar exactamente dónde está la dificultad.

Aprender no consiste en fingir que entiendes.

Consiste en identificar qué parte todavía no comprendes.

---

# 43. Cómo saber si realmente entendiste una respuesta

Después de recibir una explicación, intenta responder:

1. ¿Qué ocurrió?
2. ¿Por qué ocurrió?
3. ¿Qué estado tenía Git?
4. ¿Qué comando solucionó el problema?
5. ¿Por qué ese comando?
6. ¿Qué alternativas existían?
7. ¿Qué riesgos tenía cada alternativa?
8. ¿Qué aprendí para la próxima vez?

Si no puedes responderlas, quizá solamente copiaste una solución.

---

# 44. Explica la solución con tus propias palabras

Una técnica excelente consiste en cerrar el ciclo enseñando.

Por ejemplo:

> “El `push` fue rechazado porque el remoto tenía commits que mi rama local no tenía. Primero debo integrar esos cambios de acuerdo con la estrategia del proyecto y después volver a enviar mi rama.”

Si puedes explicarlo sin copiar la respuesta original, probablemente has aprendido algo.

---

# 45. El ciclo profesional de resolución de problemas

A medida que avances, utiliza este ciclo:

```text
1. Observar
      ↓
2. Reproducir
      ↓
3. Recopilar información
      ↓
4. Formular hipótesis
      ↓
5. Consultar documentación
      ↓
6. Probar de forma controlada
      ↓
7. Comparar resultados
      ↓
8. Elegir solución
      ↓
9. Verificar
      ↓
10. Documentar
```

Este método no pertenece exclusivamente a Git.

Es una forma general de resolver problemas técnicos.

---

# 46. El error también es documentación

Un mensaje de error puede enseñarte cómo funciona una herramienta.

Por ejemplo:

```text
error: Your local changes would be overwritten...
```

no es simplemente una barrera.

También te está diciendo que Git detecta cambios locales que podrían ser sobrescritos.

Puedes preguntarte:

> ¿Qué estado debe existir para que Git produzca este mensaje?

Esa pregunta convierte un error en una lección.

---

# 47. No dependas de una única fuente

Cuando una respuesta sea importante, compara fuentes.

Por ejemplo:

```text
Documentación oficial
        +
Documentación del proyecto
        +
Experiencia de comunidad
        +
Experimentación controlada
        +
Análisis propio
```

Esto es especialmente importante en temas como:

* seguridad;
* reescritura de historial;
* autenticación;
* tokens;
* CI/CD;
* permisos;
* despliegues;
* automatización.

---

# 48. Aprende a distinguir “funciona” de “es correcto”

Un comando puede solucionar un problema inmediato y aun así no ser apropiado para el flujo de trabajo.

Por ejemplo:

> “Este comando hizo que funcionara.”

No necesariamente significa:

> “Esta era la estrategia correcta.”

En un proyecto profesional debes considerar:

* historial;
* colaboración;
* seguridad;
* automatización;
* trazabilidad;
* políticas del equipo;
* impacto sobre otras personas.

Por eso una buena pregunta es:

> **“¿Funciona?”**

pero una pregunta todavía mejor es:

> **“¿Por qué funciona y cuáles son sus consecuencias?”**

---

# 49. Diez preguntas que debes aprender a hacer

Cuando tengas un problema técnico, intenta formular algunas de estas preguntas:

1. **¿Qué ocurrió exactamente?**
2. **¿Por qué ocurrió?**
3. **¿Qué estado tiene actualmente el sistema?**
4. **¿Qué esperaba que ocurriera?**
5. **¿Qué información falta para diagnosticarlo?**
6. **¿Qué alternativas existen?**
7. **¿Qué riesgos tiene cada alternativa?**
8. **¿Puedo reproducir el problema?**
9. **¿Cómo verifico que la solución funcionó?**
10. **¿Qué aprendí para evitar el problema en el futuro?**

Estas preguntas son mucho más valiosas que memorizar una lista interminable de comandos.

---

# 50. Ejercicio práctico

Vamos a construir una situación deliberadamente.

## Paso 1

Crea un repositorio de práctica.

```text
laboratorio-preguntas
```

## Paso 2

Crea:

```text
archivo.txt
```

con:

```text
Versión 1
```

## Paso 3

Haz un commit.

```bash
git add archivo.txt
git commit -m "Agregar archivo de prueba"
```

## Paso 4

Modifica el archivo.

```text
Versión 2
```

## Paso 5

Ejecuta:

```bash
git status
```

y:

```bash
git diff
```

## Paso 6

Ahora imagina que no sabes qué hacer.

En lugar de preguntar:

> “¿Cómo deshago esto?”

construye una pregunta completa utilizando la plantilla de este capítulo.

---

# 51. Segundo ejercicio: diagnostica sin preguntar inmediatamente

Provoca un problema sencillo en tu laboratorio.

Después:

1. Ejecuta `git status`.
2. Observa el resultado.
3. Ejecuta `git diff`.
4. Lee cualquier mensaje de Git.
5. Describe el problema por escrito.
6. Formula una hipótesis.
7. Consulta la documentación.
8. Solo después pide ayuda si todavía la necesitas.

Esto entrena una habilidad fundamental:

> **Investigar antes de reaccionar.**

---

# 52. Tercer ejercicio: pregunta a una IA

Proporciona a una IA:

```text
1. Contexto
2. Objetivo
3. Comandos ejecutados
4. Resultado esperado
5. Resultado real
6. Mensaje de error
7. git status
```

Después solicita:

```text
No me des inmediatamente el comando.

Primero explica:

1. Qué ocurrió.
2. Por qué ocurrió.
3. Qué estado tiene Git.
4. Qué alternativas existen.
5. Qué riesgos tiene cada alternativa.

Después proporciona una solución paso a paso.
```

Finalmente, intenta explicar tú mismo la solución.

---

# 53. Lo que debes recordar

Pedir ayuda no es simplemente decir:

> “Tengo un problema.”

Pedir ayuda técnicamente significa proporcionar suficiente información para que otra persona pueda comprender la situación.

Recuerda:

```text
Contexto
   ↓
Objetivo
   ↓
Acciones realizadas
   ↓
Resultado esperado
   ↓
Resultado real
   ↓
Mensaje de error
   ↓
Estado actual
   ↓
Pregunta concreta
```

Y recuerda otra idea fundamental:

> **No busques únicamente una respuesta. Busca comprender el problema.**

---

# 54. El objetivo final

Al principio quizá necesites ayuda para:

```text
¿Qué es Git?
```

Después:

```text
¿Por qué aparece este error?
```

Más adelante:

```text
¿Qué estrategia debería utilizar?
```

Y finalmente podrás llegar a preguntas como:

```text
¿Qué estrategia de ramas,
integración y automatización
es adecuada para este proyecto?
```

Ese cambio representa crecimiento técnico.

El objetivo de este repositorio no es convertirte en una persona que memoriza comandos.

Es ayudarte a desarrollar la capacidad de:

```text
Entender
   ↓
Investigar
   ↓
Experimentar
   ↓
Diagnosticar
   ↓
Preguntar
   ↓
Evaluar
   ↓
Decidir
   ↓
Aplicar
   ↓
Explicar
```

Una persona profesional no es aquella que nunca necesita ayuda.

Es aquella que sabe **cuándo pedirla, cómo buscarla, cómo proporcionar información útil y cómo transformar la respuesta en conocimiento propio**.

---

## Próximo paso

Ya conocemos tres habilidades fundamentales para comenzar este recorrido:

```text
No tener miedo de experimentar
            ↓
Saber estudiar y practicar
            ↓
Saber pedir ayuda
```

Ahora podemos comenzar a construir las bases técnicas necesarias para utilizar Git y GitHub con seguridad y comprensión.
