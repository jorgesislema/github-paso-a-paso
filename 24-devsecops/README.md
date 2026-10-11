# 24 â€” DevSecOps

## Bienvenido a esta secciÃ³n

DespuÃ©s de construir el flujo (secciÃ³n 22) y la operaciÃ³n (secciÃ³n 23), aquÃ­ se integra la seguridad como parte del mismo proceso: no como departamento final, sino como puertas automÃ¡ticas repartidas por todo el camino. SAST y DAST como familias complementarias, la protecciÃ³n del pipeline como polÃ­tica de entrega, la cadena de suministro gobernada en cada PR, y un programa con mÃ©tricas y guiones que sobrevive a la prisa.

## En esta secciÃ³n estudiarÃ¡s

* DevSecOps y shift left: del tÃºnel al flujo, con roles claros;
* anÃ¡lisis estÃ¡tico (SAST) como familia: lenguaje, secretos, IaC, Dockerfiles;
* anÃ¡lisis dinÃ¡mico (DAST): la sonda de tu sistema en staging;
* seguridad de pipelines y despliegues: la lista maestra de controles;
* cadena de suministro en el flujo: adopciÃ³n, firma, verificaciÃ³n y guion de incidente;
* el programa mÃ­nimo: puertas, severidad, mÃ©tricas, respuesta y mejora.

## Objetivos de aprendizaje

Al terminar esta secciÃ³n serÃ¡s capaz de:

* explicar shift left y aplicarlo al flujo con roles definidos;
* aplicar SAST como familia (lenguaje, secretos, IaC, Dockerfiles) con polÃ­tica de bloqueo y backlog;
* aplicar DAST como sonda del sistema en staging, en su capa correcta;
* proteger el pipeline y el despliegue con la lista maestra de controles;
* gobernar la cadena de suministro en el flujo: adopciÃ³n, firma, verificaciÃ³n y guion de incidente;
* operar un programa mÃ­nimo: puertas, severidad, mÃ©tricas y mejora continua.

---

## Â¿QuÃ© aprenderÃ¡s en esta secciÃ³n?

1. [`01-devsecops-y-shift-left.md`](01-devsecops-y-shift-left.md) â€” el modelo y sus tres socios.
2. [`02-analisis-estatico-sast.md`](02-analisis-estatico-sast.md) â€” quÃ© bloquea, quÃ© backlog y cÃ³mo tunear.
3. [`03-analisis-dinamico-dast.md`](03-analisis-dinamico-dast.md) â€” probar lo corriendo, donde corresponde.
4. [`04-seguridad-de-pipelines-y-despliegues.md`](04-seguridad-de-pipelines-y-despliegues.md) â€” proteger la fÃ¡brica.
5. [`05-cadena-de-suministro-en-el-flujo.md`](05-cadena-de-suministro-en-el-flujo.md) â€” las cuatro puertas de la confianza.
6. [`06-programa-de-seguridad-y-metricas.md`](06-programa-de-seguridad-y-metricas.md) â€” el programa que permanece.

## CÃ³mo estudiar esta secciÃ³n

Esta secciÃ³n integra las 19 y 20: tenlas a mano como referencia. El cierre prÃ¡ctico es la polÃ­tica citable (tabla de puertas con severidad), dos mÃ©tricas con lÃ­nea base y un simulacro en calendario â€” si los tienes, el programa existe.

## Referencias

* OWASP DevSecOps Guide (PDF gratuito).
* Karp, S., Simeon, M. y Marco, P. â€” *The DevSecOps Handbook* (2021).
* NIST SSDF â€” Software Supply Chain Security Framework.
* DocumentaciÃ³n de herramientas: CodeQL (SAST) y OWASP ZAP (DAST).



## Checkpoint 24 â€” ComprobaciÃ³n obligatoria
1. Verificar que el mapa conceptual estÃ© presente y correctamente estructurado.
2. Confirmar que los flowchart de procesos principales estÃ©n convertidos a Mermaid.
3. Asegurarse de que las autopreguntas de cierre contengan entre 5 y 8 preguntas de comprensiÃ³n profunda.
4. Revisar que los ejercicios de transferencia estÃ©n presentes y describan una tarea concreta y verificable.
5. Confirmar que los comandos destructivos tengan la advertencia de riesgo correspondiente.
6. Validar que no se hayan superado las 700 lÃ­neas por archivo.
Si puedes hacerlo **sin mirar instrucciones**, el checkpoint estÃ¡ cerrado.


---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruÃ©balo con los capÃ­tulos de la secciÃ³n:

1. Â¿QuÃ© diferencia hay entre SAST y DAST y dÃ³nde aplica cada uno?
2. Un SAST te detecta 400 hallazgos: Â¿quÃ© haces para que el control no se vuelva ruido?
3. Â¿QuÃ© garantiza la firma de un artefacto?
4. Â¿CuÃ¡les son las cuatro puertas de la confianza en la cadena de suministro?

---

## PrÃ³ximo paso

Cuando termines los seis capÃ­tulos, continÃºa con la siguiente secciÃ³n:

[`../25-arquitectura-de-repositorios/`](../25-arquitectura-de-repositorios/)
