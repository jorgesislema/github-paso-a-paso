# CHANGELOG

Historial de cambios del contenido de **GitHub Paso a Paso**. Los cambios que afectan al material de estudio se registran aquí antes de commitearse; los cambios de infraestructura del repositorio (estructura, plantillas) también.

Formato: `[YYYY-MM-DD] versión — resumen`. De más reciente a menos reciente.

---

## [1.1] — 2026-10-03

### Proyectos (sección 27)

* **Nuevo:** Proyecto 3 «Recetario» (`27-proyectos-practicos/03-proyecto-3-recetario.md`): CRUD con control de versiones — la sección 27 pasa de 7 a 8 proyectos.
* Renumeración de la sección 27: 03→04 (web), 04→05 (python), 05→06 (datos), 06→07 (IA), 07→08 (colaborativo); se actualizaron todas las referencias cruzadas (mapas de proyectos, títulos de capítulos, enlaces de próximos pasos) y `27/README.md` (8 proyectos y su cadena de herencia).
* Ajuste de numeración en la sección 28: el diseño del proyecto final ahora cita correctamente el Proyecto 5, y su checklist intermedia el Proyecto 4.

### Calidad del contenido (auditoría de ortografía)

* Corrección de ~51 errores tipográficos en 25+ archivos (países/regiones, conceptos de Git y GitHub, comunidad), detectados por auditoría de ortografía (wordfreq + diccionario RAE) y revisión manual. Incluyen: «déclencheur»→«disparan», caracteres no latinos intrusos, «supersedee», «falsicia», «rideles»→«riesgos», y demás localizados por la auditoría.

### Diseño académico

* **Nuevo:** `00-orientacion/07-como-fue-disenado-este-curso.md` — el marco pedagógico del curso (andamiaje/espiral, worked examples, error-based learning, ABP, transferencia situada), sus decisiones de diseño y una propuesta de evaluación pre/post.
* **Nuevo:** bloques «Objetivos de aprendizaje», «Referencias» y «Autopreguntas de cierre» en los 30 README de sección (00–29), con verbos de dominio y fuentes canónicas por tema.
* **Nuevo:** `28-proyecto-final/07-rubrica-del-proyecto-final.md` — rúbrica pública de 6 dimensiones × 4 niveles, con temporalidad de uso (temprana / continua / autoevaluada) y errores comunes; enlazada desde `28/01` (diseño) y `28/06` (demostración).
* **Nuevo:** `recursos/sandboxes/` — cuatro entornos de práctica controlados (scripts PowerShell + docs) para las secciones 06, 08, 10 y 11; enlazados desde sus README y desde `recursos/README.md`.
* **Nuevo:** subsección de accesibilidad de diagramas en `00-orientacion/05-como-leer-los-ejemplos.md`.

### Gestión del contenido

* **Nuevo:** este `CHANGELOG.md` y línea de versión de contenido en el README raíz (1.1).
* Normalización estructural del `GLOSARIO.md` (entrada: definición / ejemplo / relacionados) y del `PREGUNTAS-FRECUENTES.md` (pregunta / respuesta / enlaces).

---

## [1.0] — estado base

* Recorrido completo 00 → 29: conceptos, Git local, ramas, remotos, colaboración, automatización (GitHub Actions), seguridad, arquitectura y proyecto final.
* Secciones de apoyo: `comunidad/`, `recursos/`, `EMPIEZA-AQUI.md`, `GLOSARIO.md`, `PREGUNTAS-FRECUENTES.md`, `CONTRIBUTING.md`.
* Contenido original sin auditoría de ortografía ni bloques de objetivos.
