# Release y entrega

## Introducción

El Proyecto final necesita un final formal: **una release versionada, con notas y artefacto, que alguien pueda instalar o ejecutar sin preguntarte nada**. Este capítulo cierra el ciclo de entrega con las secciones 17 (versionado y releases) y 22 cap. 05/06 (artefactos, rollback): desde la decisión de qué versión toca hasta el changelog, la etiqueta, el artefacto publicado y la comprobación de que lo entregado funciona.

---

## Mapa conceptual de este capítulo

```text
Release y entrega
       │
       ├── 1. Qué es una «entrega» en este proyecto
       ├── 2. Versionado y changelog
       │   ├── 3. El artefacto (y qué lo hace confiable)
       │   └── 4. La release en la plataforma
       │
       ├── 5. Errores comunes con diagnóstico completo
       ├── 6. Práctica guiada
       └── 7. Nivel profesional + resumen
```

---

## 1. Qué es una «entrega» en este proyecto

```text
ENTREGA = el estado del repo que demuestra el flujo
COMPLETO (sección 28 — lista de la etapa):
   │
   ├── tag de versión sobre un main verde (checks
   │   pasados)
   ├── changelog que un no-autor entiende
   ├── artefacto/instalación que funciona en limpio
   ├── release publicada en la plataforma con notas
   └── evidencia: el último despliegue o ejecución
       coincide con la versión (Error 1 si la versión
       «producción» no está en ninguna etiqueta)
```

```text
   │
   └── la entrega es el ÚLTIMO PR del proyecto, no un
       apéndice: se decide con el mismo rigor (Error 2
       si se hace «la noche anterior a entregar»)
```

---

## 2. Versionado y changelog

```text
SEMVER APLICADO (sección 17 cap. 05):
   │
   ├── 0.x.y mientras el proyecto es joven (0.1.0 =
   │   primera entrega completa; ¡dilo en el README)
   │
   ├── patch (0.1.1): arreglo sin cambios de uso
   ├── minor (0.2.0): agregas funcionalidad compatible
   └── major (1.0.0): dices que el proyecto «es serio»
       — Error 3 si saltas a 1.0.0 por estética
```

```text
CHANGELOG (Error 4 si es un reflejo de commits):
   │
   ├── organizado por tipo: agregado · cambiado ·
   │   corregido (categoría: elige y sé consistente)
   ├── escrito para QUIEN USA, no para quien programa
   │   (sección 14 — notas de release: sección 17 cap.
   │   06)
   └── enlace al PR/issue de cada entrada (trazabilidad)
```

```text
   │
   └── la prueba: un usuario casual entiende «qué
       nuevo tiene 0.2.0 respecto a 0.1.0» sin leer
       código (Error 8 — sección
       26 cap. 02: notas que se leen)
```

---

## 3. El artefacto (y qué lo hace confiable)

```text
ARTEFACTO (sección 22 cap. 05):
   │
   ├── lo que el usuario final baja/ejecuta: paquete,
   │   binario, imagen, sitio compilado — según tu
   │   proyecto
   │
   ├── lo genera el PIPELINE desde el tag (Error 5 si
   │   sale de tu disco: no es reproducible — Error 5
   │   sección 04 cap. 27)
   │
   └── identificación: versión en el artefacto + desde
       qué commit (Error 6 si nadie sabe de qué commit
       viene un binario)
```

```text
COMPROBACIÓN DE LA ENTREGA (Error 7 si se omite):
   │
   ├── 1. clonar/instalar EN LIMPIO con el README
   ├── 2. ejecutar el humo: ejemplo principal funciona
   ├── 3. pruebas de la versión entregada pasan
   └── 4. registrar: fecha, versión, quién verificó
```

```text
   │
   └── «probar en limpio antes de publicar» es el mismo
       criterio del README (Error 2 sección 03 cap. 28)
       — aquí con más consecuencias
```

---

## 4. La release en la plataforma

```text
EL PASO A PASO (sección 17 cap. 06 + 22 cap. 06):
   │
   ├── 1. main verde (últimos checks OK)
   ├── 2. changelog actualizado en el mismo PR de release
   ├── 3. tag `v0.1.0` → la plataforma genera la release
   │       con notas (Error 8 si no hay notas: el tag
   │       solo no comunica)
   ├── 4. artefacto publicado (automático, ligado al tag)
   ├── 5. release marcada como «latest» si aplica
   └── 6. README actualizado: versión actual + enlace a
       la release (Error 9 si el README sigue diciendo
       otra cosa)
```

```text
SI HAY DESPLIEGUE (sección 22 cap. 04):
   │
   └── la release activa el despliegue (o el despliegue
       usa el artefacto de la release) — y queda su
       run/historial (cap. 04 de esta sección)
```

```text
   │
   └── reversa presente: «si esta release falla, vuelvo
       a v0.1.0 (o re-empliego el artefacto anterior)» —
       escrito (sección 22 cap. 06 Error 7 — el
       Error 7 de este capítulo)
```

---

## 5. Errores comunes con diagnóstico completo

### Error 1: versión que no está en ninguna parte

**Qué ocurrió:** «entregamos la 0.2» pero no había tag ni release; el artefacto no correspondía.

**Por qué:** entrega sin versionado formal (punto 1).

**Cómo comprobarlo:** ¿existe tag + release + artefacto para la versión dada?

**Opciones:** crear la evidencia ahora desde el commit correcto.

**Riesgos:** confusión total en la evaluación.

**Solución:** entrega completa (punto 1).

**Cómo se evita:** checklist del punto 6.

---

### Error 2: release de última hora

**Qué ocurrió:** se tagueó la noche de entrega con el changelog improvisado y un check rojo «que ya lo vi yo».

**Por qué:** sin proceso (punto 1 Error 2).

**Cómo comprobarlo:** ¿la release pasó por main verde y checklist?

**Opciones:** repetir el proceso con calma sobre el commit correcto (si el tag está mal, nueva versión; no reuses etiquetas).

**Riesgos:** la entrega arranca con una mentira en el historial.

**Solución:** release como PR (Error 1 sección 02 cap. 26 — proceso, no evento).

**Cómo se evita:** «release» en el plan con su día propio.

---

### Error 3: 1.0.0 por estética

**Qué ocurrió:** se etiquetó 1.0.0 «para que se vea terminado»; el README y el cambio seguían inestables.

**Por qué:** semver malinterpretada (punto 2).

**Cómo comprobarlo:** ¿qué garantiza la 1.0.0? ¿estabilidad de uso documentada?

**Opciones:** 0.1.0/0.2.0 con honestidad; reservar 1.0.0 para cuando lo prometas.

**Riesgos:** promesa incumplida.

**Solución:** versión según madurez real (punto 2).

**Cómo se evita:** criterio semver escrito en CONTRIBUTING.

---

### Error 4: changelog automático sin editar

**Qué ocurrió:** el changelog era una lista de commits internos ilegible para quien usara el proyecto.

**Por qué:** sin cúpula editorial (punto 2 Error 4).

**Cómo comprobarlo:** léelo como usuario: ¿se entiende sin Git?

**Opciones:** reescribir agrupando por «qué cambia para ti».

**Riesgos:** las notas nadie las lee (Error 4 del punto 2).

**Solución:** escrito para quien usa (punto 2).

**Cómo se evita:** redactar las notas en el PR de release, no con script crudo.

---

### Error 5: artefacto de la máquina del autor

**Qué ocurrió:** el ejecutable «de entrega» se compiló en local y era distinto al del CI.

**Por qué:** artefacto manual (punto 3).

**Cómo comprobarlo:** ¿el artefacto lo bajó alguien desde el run del tag?

**Opciones:** publicar solo artefacto del pipeline; regenerar y sustituir si procede.

**Riesgos:** «¿qué hay exactamente en esta entrega?» sin respuesta.

**Solución:** pipeline desde el tag (punto 3).

**Cómo se evita:** criterio: artefacto ≠ disco local (Error 5 sección 04 cap. 27).

---

### Error 6: binario sin procedencia

**Qué ocurrió:** un archivo ejecutable sin versión ni commit asociado.

**Por qué:** sin identificación (punto 3 Error 6).

**Cómo comprobarlo:** ¿el artefacto dice su versión y commit?

**Opciones:** inyectar versión/commit en la build; documentar el procedimiento.

**Riesgos:** imposible depurar lo entregado.

**Solución:** procedencia visible (punto 3).

**Cómo se evita:** el paso de build lo incluye por defecto.

---

### Error 7: publicar sin probar en limpio

**Qué ocurrió:** la release salió con una instalación rota que solo se detectó al intentar usarla.

**Por qué:** sin verificación (punto 3 Error 7).

**Cómo comprobarlo:** ¿alguien probó el artefacto limpio ANTES de publicar?

**Opciones:** arreglar, nueva versión; practicar la verificación como paso fijo.

**Riesgos:** primera impresión destruida.

**Solución:** humo en limpio (punto 3).

**Cómo se evita:** checklist con paso de instalación limpio.

---

### Error 8: tag sin notas

**Qué ocurrió:** la release existía pero «v0.1.0» no decía nada: cero notas.

**Por qué:** paso omitido (punto 4).

**Cómo comprobarlo:** abre la release en la plataforma: ¿notas?

**Opciones:** editar con el changelog del punto 2.

**Riesgos:** el historial de versiones no comunica.

**Solución:** notas siempre (punto 4).

**Cómo se evita:** checklist del punto 6 incluye notas.

---

### Error 9: README desincronizado de la versión

**Qué ocurrió:** el README documentaba comandos de la versión anterior tras la entrega.

**Por qué:** README fuera del PR de release (punto 4).

**Cómo comprobarlo:** ¿README dice 0.1.0 cuando hay 0.2.0?

**Opciones:** sincronizar en el mismo PR de release.

**Riesgos:** usuarios siguiendo instrucciones viejas.

**Solución:** README en el ciclo de release (punto 4).

**Cómo se evita:** el PR de release incluye README + changelog.

---

## 6. Práctica guiada

### Objetivo

Ejecutar la entrega del Proyecto final: versión, notas, artefacto y verificación en limpio.

### Paso 1: pre-release

```text
[ ] main verde (checks OK)
[ ] changelog redactado para usuarios
[ ] README sincronizado
[ ] reversa escrita (vuelvo a ____ si falla)
```

### Paso 2: versiona

1. Decide la versión con semver honesta (punto 2). PR de release con changelog + README.

### Paso 3: etiqueta y publica

1. Tag `vX.Y.Z` desde main verde → release en plataforma con notas → artefacto del pipeline (punto 4).

### Paso 4: verifica en limpio

1. Clonar/instalar en otra carpeta con el README literal (punto 3). Ejecuta el humo. Registra fecha/versión/verificador.

### Paso 5: si hay despliegue

1. Comprueba que el run de despliegue corresponde a la versión y que la reversa está a un comando (punto 4).

### Paso 6: entrega

```text
Checklist final del capítulo:
   [ ] tag + release + notas + artefacto del pipeline
   [ ] instalación en limpio verificada (evidencia)
   [ ] README y changelog en la versión entregada
   [ ] reversa escrita
   [ ] historial de deploys/ejecución coincide con la
       versión
```

### Resultado esperado

Release publicada con notas y artefacto reproducible, verificada en limpio y documentada.

### Conclusión esperada

La entrega no es el momento de «cerrar y rezar»: es el último ciclo de un proceso que ya funcionó seis veces — versión, notas, artefacto y verificación, con su reversa a mano.

---

## 7. Nivel profesional + resumen

### 7.1. Releases como oficio

```text
   │
   ├── el patrón (main verde → changelog → tag →
   │   artefacto → notas → verificación) es idéntico al
   │   de cualquier equipo (sección 17/26 cap. 02)
   │
   ├── procedencia de artefactos (versión + commit) es
   │   la base de trazabilidad que la sección 24 cap. 05
   │   lleva a la cadena de suministro
   │
   ├── «latest + notas + README sincronizado» = el
   │   mínimo que un usuario espera de un proyecto
   │   público (sección 18)
   │
   └── métricas de la defensa: nº de releases, tiempo
       desde el último PR hasta la release, verificaciones
       en limpio realizadas
```

### 7.2. Resumen

En este capítulo aprendiste que:

* la entrega = tag sobre main verde + changelog de usuario + artefacto del pipeline + release con notas + verificación en limpio + reversa escrita;
* semver honesta: 0.x mientras madura; 1.0.0 es una promesa, no un maquillaje;
* el changelog se redacta para quien usa, con enlaces de trazabilidad;
* la procedencia (versión y commit del artefacto) hace confiable lo entregado;
* los errores típicos (versión fantasma, release de última hora, 1.0.0 decorativo, changelog crudo, artefacto local, binario sin origen, publicar sin probar, tag sin notas, README viejo) se previenen con checklist;
* el ciclo de release queda documentado como parte del entregable.

La idea principal es:

> **Una release es una promesa verificable: dice qué versión es, qué cambió, cómo se obtiene y cómo se deshace — y todo eso tiene que poder comprobarse sin la persona que la publicó.**

---

## Próximo paso

Release publicada y verificada.

Ahora el capítulo final: demostrar el proyecto completo con evidencias.

Continúa con:

[`06-demostracion-y-evaluacion-final.md`](06-demostracion-y-evaluacion-final.md)
