# 24 — DevSecOps

## Bienvenido a esta sección

Después de construir el flujo (sección 22) y la operación (sección 23), aquí se integra la seguridad como parte del mismo proceso: no como departamento final, sino como puertas automáticas repartidas por todo el camino. SAST y DAST como familias complementarias, la protección del pipeline como política de entrega, la cadena de suministro gobernada en cada PR, y un programa con métricas y guiones que sobrevive a la prisa.

## En esta sección estudiarás

* DevSecOps y shift left: del túnel al flujo, con roles claros;
* análisis estático (SAST) como familia: lenguaje, secretos, IaC, Dockerfiles;
* análisis dinámico (DAST): la sonda de tu sistema en staging;
* seguridad de pipelines y despliegues: la lista maestra de controles;
* cadena de suministro en el flujo: adopción, firma, verificación y guion de incidente;
* el programa mínimo: puertas, severidad, métricas, respuesta y mejora.

## Objetivos de aprendizaje

Al terminar esta sección serás capaz de:

* explicar shift left y aplicarlo al flujo con roles definidos;
* aplicar SAST como familia (lenguaje, secretos, IaC, Dockerfiles) con política de bloqueo y backlog;
* aplicar DAST como sonda del sistema en staging, en su capa correcta;
* proteger el pipeline y el despliegue con la lista maestra de controles;
* gobernar la cadena de suministro en el flujo: adopción, firma, verificación y guion de incidente;
* operar un programa mínimo: puertas, severidad, métricas y mejora continua.

---

## ¿Qué aprenderás en esta sección?

1. [`01-devsecops-y-shift-left.md`](01-devsecops-y-shift-left.md) — el modelo y sus tres socios.
2. [`02-analisis-estatico-sast.md`](02-analisis-estatico-sast.md) — qué bloquea, qué backlog y cómo tunear.
3. [`03-analisis-dinamico-dast.md`](03-analisis-dinamico-dast.md) — probar lo corriendo, donde corresponde.
4. [`04-seguridad-de-pipelines-y-despliegues.md`](04-seguridad-de-pipelines-y-despliegues.md) — proteger la fábrica.
5. [`05-cadena-de-suministro-en-el-flujo.md`](05-cadena-de-suministro-en-el-flujo.md) — las cuatro puertas de la confianza.
6. [`06-programa-de-seguridad-y-metricas.md`](06-programa-de-seguridad-y-metricas.md) — el programa que permanece.

## Cómo estudiar esta sección

Esta sección integra las 19 y 20: tenlas a mano como referencia. El cierre práctico es la política citable (tabla de puertas con severidad), dos métricas con línea base y un simulacro en calendario — si los tienes, el programa existe.

## Referencias

* OWASP DevSecOps Guide (PDF gratuito).
* Karp, S., Simeon, M. y Marco, P. — *The DevSecOps Handbook* (2021).
* NIST SSDF — Software Supply Chain Security Framework.
* Documentación de herramientas: CodeQL (SAST) y OWASP ZAP (DAST).

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de la sección:

1. ¿Qué diferencia hay entre SAST y DAST y dónde aplica cada uno?
2. Un SAST te detecta 400 hallazgos: ¿qué haces para que el control no se vuelva ruido?
3. ¿Qué garantiza la firma de un artefacto?
4. ¿Cuáles son las cuatro puertas de la confianza en la cadena de suministro?

---

## Próximo paso

Cuando termines los seis capítulos, continúa con la siguiente sección:

[`../25-arquitectura-de-repositorios/`](../25-arquitectura-de-repositorios/)
