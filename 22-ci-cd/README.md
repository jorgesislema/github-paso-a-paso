# 22 — CI/CD

## Bienvenido a esta sección

Aquí Git se convierte en entrega: del commit a producción con verificación en cada paso. La integración continua pone el verde confiable; los pipelines convierten código en artefactos; las pruebas son las puertas; la entrega continua añade environments y gates; los artefactos viajan con identidad; y el rollback garantiza que ningún despliegue sea una calle sin salida.

## En esta sección estudiarás

* qué es integración continua de verdad — y qué no es;
* diseño de pipelines: etapas, builds reproducibles y artefactos entre jobs;
* pruebas automatizadas colocadas por puerta (PR, main, release), rápidas y fiables;
* entrega continua vs. despliegue continuo, environments, gates y estrategias de publicación;
* artefactos: versionado, inmutabilidad, registries y promoción;
* rollback: umbral, requisitos, ensayo y post-mortem.

## Objetivos de aprendizaje

Al terminar esta sección serás capaz de:

* diferenciar integración continua real de «subir todos los días»;
* diseñar pipelines con etapas, builds reproducibles y artefactos entre jobs;
* colocar pruebas automatizadas como puertas (PR, main, release) rápidas y fiables;
* aplicar entrega continua con environments, gates y estrategias de publicación;
* versionar artefactos con inmutabilidad y promoción entre entornos;
* planear un rollback con umbral, ensayo y post-mortem.

---

## ¿Qué aprenderás en esta sección?

1. [`01-integracion-continua.md`](01-integracion-continua.md) — del commit al verde y su cultura.
2. [`02-pipelines-y-builds.md`](02-pipelines-y-builds.md) — grafo de etapas y builds reproducibles.
3. [`03-pruebas-automatizadas-en-la-entrega.md`](03-pruebas-automatizadas-en-la-entrega.md) — qué corre y cuándo.
4. [`04-entrega-continua-y-despliegue-continuo.md`](04-entrega-continua-y-despliegue-continuo.md) — de verde a producción con gates.
5. [`05-artefactos-y-versionado.md`](05-artefactos-y-versionado.md) — identidad, registry y promoción.
6. [`06-rollback-y-recuperacion.md`](06-rollback-y-recuperacion.md) — el plan B ensayado.

## Cómo estudiar esta sección

Reconstruye tu cadena de entrega mientras lees: CI ordenado, artefacto identificado, staging con humo, gate de aprobación y un runbook de reversión ensayado. Cada capítulo asiente sobre el anterior — el cierre es una entrega real y su simulacro de rollback.

## Referencias

* Humble, J. y Farley, D. — *Continuous Delivery* (2010) — principios.
* DORA — DevOps Research and Assessment: métricas de flujo (dora.dev).
* GitHub Actions — documentación de CI (docs.github.com/actions).

---

## Autopreguntas de cierre

Sin mirar el material, responde mentalmente y luego compruébalo con los capítulos de la sección:

1. ¿Qué significa «CI verde» que no significa «me pasaron las pruebas en mi máquina»?
2. ¿Qué diferencia hay entre entrega continua y despliegue continuo?
3. ¿Qué hace que un build sea «reproducible»?
4. ¿Qué es una promoción de artefactos y para qué sirve?

---

## Próximo paso

Cuando termines los seis capítulos, continúa con la siguiente sección:

[`../23-devops/`](../23-devops/)
