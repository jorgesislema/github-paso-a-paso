# Organizaciones

## Introducción

Hasta ahora has trabajado con una cuenta individual. Pero el software real casi siempre se construye entre varias personas: equipos, empresas, asociaciones, comunidades de código abierto.

La **organización** es la estructura de GitHub para agrupar personas y proyectos bajo una identidad común. No es un usuario más: es un contenedor donde viven repositorios compartidos, equipos con permisos distintos, facturación centralizada y políticas de seguridad.

Entender la organización es entender cómo funciona el GitHub profesional: quién puede hacer qué, cómo se protege un proyecto de acceso abierto a todos, y qué implica pertenecer a una organización ajena.

En este capítulo aprenderás:

* qué es una organización y en qué se diferencia de una cuenta personal;
* para qué sirven las organizaciones;
* los roles fundamentales (propietario, miembro, colaborador exterior);
* cómo funciona la pertenencia (invitación, aceptación, salidas);
* la estructura de equipos y su relación con los permisos;
* las organizaciones del lado del código abierto (comunidades);
* qué ves cuando perteneces a una organización;
* errores comunes, práctica guiada y nivel profesional (roles de empresa, SSO y auditoría).

---

## Mapa conceptual de este capítulo

```text
Organizaciones
       │
       ├── 1. Qué es una organización
       │        ├── Definición
       │        ├── Cuenta personal vs. organización
       │        └── Para qué sirve
       │
       ├── 2. Conceptos fundamentales
       │        ├── Miembro vs. colaborador
       │        ├── Propietario vs. miembro
       │        ├── Equipos
       │        └── Repositorios de la organización
       │
       ├── 3. Crear una organización
       │
       ├── 4. Invitar personas y aceptar invitaciones
       │
       ├── 5. Equipos
       │        ├── Qué son
       │        ├── Permisos de equipo
       │        └── Ejemplos de estructura
       │
       ├── 6. Roles y permisos
       │        ├── Mapa de permisos
       │        ├── El principio de mínimo privilegio
       │        └── Colaboradores externos
       │
       ├── 7. Organizaciones de código abierto
       │        ├── Comunidad y gobernanza
       │        └── Cómo colaborar con una org ajena
       │
       ├── 8. La organización en tu día a día
       │
       ├── 9. Errores comunes con diagnóstico completo
       │
       ├── 10. Práctica guiada
       │
       ├── 11. Nivel profesional
       │        ├── Organizaciones de empresa
       │        ├── SSO y políticas
       │        ├── Bitácora de auditoría
       │        └── Facturación y planes
       │
       └── 12. Resumen y siguiente paso
```

---

## 1. Qué es una organización

### 1.1. Definición

Una **organización** es una entidad de GitHub que agrupa cuentas de usuarios bajo un nombre propio, con repositorios propios, equipos propios y una estructura de permisos administrada.

```text
Naturaleza de la organización
   │
   ├── Tiene nombre propio (ejemplo: mi-empresa, progreso-dev)
   │
   ├── No es una persona: no tiene «contraseña» humana;
   │   la controlan sus propietarios (humanos)
   │
   ├── Contiene:
   │      ├── Repositorios
   │      ├── Equipos
   │      ├── Miembros (cuentas personales)
   │      ├── Aplicaciones e integraciones
   │      └── Facturación y planes (si aplica)
   │
   └── Aparece como entidad distinta en la plataforma:
          github.com/mi-empresa
```

### 1.2. Cuenta personal vs. organización

```text
Comparación
─────────────────────────────────────────────────────────────
Cuenta personal              Organización
─────────────────────────────────────────────────────────────
Es una persona               Es un contenedor de equipo

Un propietario (tú)          Un o más propietarios

Sus repos son tuyos          Sus repos son de la organización

Colaboradores por invit.     Miembros con roles + equipos

No gestiona a otras          Gestiona personas y permisos
personas                        de otras

Perfil público individual    Perfil público de entidad

No tiene políticas           Puede exigir 2FA, SSO, etc.
de seguridad forzadas
```

### 1.3. Para qué sirve

```text
Usos típicos de una organización
   │
   ├── Empresa o startup
   │      →  repositorios de producto bajo un techo,
   │         permisos por equipo, facturación central
   │
   ├── Equipo freelance o estudio
   │      →  proyectos de clientes separados, acceso
   │         controlado por colaborador
   │
   ├── Proyecto de código abierto
   │      →  identidad del proyecto, múltiples
   │         mantenedores, contribuciones externas
   │
   ├── Asociación o comunidad
   │      →  repositorios compartidos con gobernanza
   │
   └── Uso personal organizado
          →  algunos usuarios separan «proyectos serios»
             en una org propia (opcional)
```

### 1.4. Dónde empieza la diferencia práctica

```text
Si trabajas solo:
   cuenta personal = suficiente

Si otra persona:
   necesita acceso a TU repositorio
   →  puede ser COLABORADOR en tu cuenta
   →  o puede estar en una ORGANIZACIÓN con el repo dentro

Si sois varios:
   compartiendo varios repos y permisos
   →  organización casi siempre es la mejor opción
```

---

## 2. Conceptos fundamentales

Cinco términos que se confunden al principio. Distinguirlos es la base de todo lo demás.

### 2.1. Miembro vs. colaborador

```text
MIEMBRO de una organización
   │
   ├── Es una cuenta PERSONAL que pertenece a la organización
   ├── Tiene identidad propia (su usuario, su perfil)
   ├── Pertenece a equipos (o al menos a la org)
   └── Su pertenencia es administrable: invitación,
       equipos, salida

COLABORADOR de un repositorio
   │
   ├── Es una cuenta (personal o de org) con permisos
   │   sobre UN repositorio concreto
   ├── No implica pertenecer a nada
   └── Puede serlo alguien de fuera de tu organización
```

**Clave:** ser colaborador no te hace miembro de la organización. Puedes dar permisos de escritura a un freelance sobre un repositorio sin añadirlo a tu organización.

### 2.2. Propietario vs. miembro

```text
PROPIETARIO (owner)
   │
   ├── Control total de la organización:
   │      ├── crear/eliminar repositorios
   │      ├── gestionar miembros y equipos
   │      ├── asignar roles
   │      ├── ver y gestionar la facturación
   │      ├── integraciones y webhooks
   │      ├── políticas de seguridad (2FA, SSO)
   │      └── bitácora de auditoría
   │
   └── Debe ser pocos: es el nivel máximo de poder

MIEMBRO (member)
   │
   ├── Acceso según los equipos a los que pertenezca
   └── No gestiona la organización
```

> **Norma:** los propietarios deben ser el número mínimo imprescindible. El exceso de propietarios es exceso de llaves maestras.

### 2.3. Equipos

Los **equipos** agrupan miembros dentro de la organización y son el mecanismo principal para conceder permisos:

```text
Organización
   │
   ├── Equipo: Plataforma        →  acceso a repo X, Y
   ├── Equipo: Documentación     →  acceso de lectura a todo
   ├── Equipo: Mantenedores      →  administración de repo Z
   └── Equipo: Todos             →  lectura general
```

Veremos la estructura en detalle en el punto 5.

### 2.4. Repositorios de la organización

Los repos creados dentro de la organización **pertenecen a la organización**, no a quien los creó:

```text
Implicación clave
   │
   ├── Si la persona sale de la organización,
   │   el repositorio NO se va con ella
   │
   └── Este es el gran motivo profesional para usar orgs:
       la continuidad del proyecto no depende de una
       cuenta individual
```

---

## 3. Crear una organización

### 3.1. Procedimiento general

```text
Crear organización
──────────────────────────────────────────────
1. Menú de tu avatar → Settings (o el acceso vigente a
   creación de organizaciones)
2. Buscar la opción de crear organización nueva
3. Elegir un nombre (nombre de usuario de la organización:
   único en la plataforma)
4. Elegir plan (existen planes gratuitos con límites;
   ver capítulo 04)
5. Confirmar con tu cuenta personal
6. La organización queda creada con tú como propietario
```

### 3.2. Decisiones al crearla

```text
Decisiones iniciales
   │
   ├── NOMBRE
   │      →  será la URL: github.com/nombre
   │      →  difícil de cambiar después; elige bien
   │         (consistencia con tu marca/empresa)
   │
   ├── PLAN
   │      →  empieza por el gratuito; sube si necesitas
   │         funciones o más privacidad
   │
   └── QUIÉN MÁS ES PROPIETARIO
          →  añade a la segunda persona de confianza
             desde el principio (evita bloqueos futuros)
```

> **Advertencia:** la organización dependiente de un solo propietario es un riesgo de continuidad (si esa persona pierde acceso, ¿quién administra?). En equipos, tener al menos dos propietarios es una práctica estándar.

---

## 4. Invitar personas y aceptar invitaciones

### 4.1. Flujo de invitación

```text
Invitación a una organización
──────────────────────────────────────────────
Propietario/administrador
   │
   1. Invita por nombre de usuario o correo
   │
   2. El invitado recibe notificación (correo + plataforma)
   │
   3. El invitado ACEPTA
   │         │
   │         ├── Acepta con su cuenta personal existente
   │         └── o crea cuenta si no tiene
   │
   4. Pasa a ser miembro
   │         │
   │         └── y se le asigna a equipos
   │             (o queda sin equipos = sin acceso útil)
   │
   ▼
Resultado: miembro con permisos según sus equipos
```

### 4.2. Puntos importantes

* **Aceptar es decisión del invitado:** nadie entra a la fuerza.
* **La invitación caduca:** si no se acepta en el tiempo establecido, caduca y hay que reenviarla.
* **Un correo solo puede estar en una organización** en algunos planes/modos de uso (la cuenta mantiene su identidad única).
* **Verifica que el invitado es la persona correcta:** invitar al usuario equivocado da acceso a alguien que no debía tenerlo (y se revoca desde la gestión de miembros).

### 4.3. Dar de baja a un miembro

```text
Baja de un miembro
──────────────────────────────────────────────
1. Administración de miembros → eliminar de la organización
2. Efectos:
   ├── Pierde acceso a repositorios privados de la org
   ├── Sigue en la plataforma con su cuenta personal
   ├── Lo que aportó (commits) permanece en el historial
   └── Si tenía claves SSH/tokens de la org: revisarlos
       (buen momento para rotar secretos compartidos)
```

---

## 5. Equipos

### 5.1. Qué es un equipo

Un **equipo** es un grupo de miembros dentro de la organización al que se le pueden asignar permisos sobre repositorios. Es la pieza que hace escalable la gestión: no das permisos persona a persona, sino equipo a repositorio.

```text
Sin equipos                        Con equipos
────────────────────               ────────────────────
Admin ajusta a María,              Se define:
admin ajusta a Juan,               Equipo Datos → repo A, B
admin ajusta a Lucía, ...          Equipo Web → repo C
(admin costante, errores)          Se añaden personas al equipo
                                   (un solo gesto por persona)
```

### 5.2. Permisos de equipo

Cada equipo recibe un nivel de acceso a cada repositorio:

```text
Niveles de acceso típicos (según la interfaz vigente)
   │
   ├── Lectura (Read)
   │      →  ver el código y los issues
   │
   ├── Escritura (Write)
   │      →  además: commits, ramas, issues, Pull Requests
   │
   ├── Mantiene (Maintain)
   │      →  además: configuración del repo sin llegar
   │         a lo más sensible
   │
   └── Administración (Admin)
          →  todo: ajustes, borrado, integraciones, webhooks
```

> **Principio de mínimo privilegio:** cada equipo recibe el nivel más bajo que le permite hacer su trabajo. «Administración para todos» elimina el control y multiplica el daño de un error o de una cuenta comprometida.

### 5.3. Ejemplo de estructura

```text
Organización «progreso-dev»
   │
   ├── Equipo: Mantenedores (Admin sobre los repos centrales)
   │      └── 3 personas
   │
   ├── Equipo: Backend (Escritura sobre api, servicios)
   │      └── 5 personas
   │
   ├── Equipo: Frontend (Escritura sobre web, componentes)
   │      └── 4 personas
   │
   ├── Equipo: Documentación (Escritura sobre docs)
   │      └── 2 personas
   │
   └── Equipo: Colaboradores externos (Lectura sobre docs y
          repos abiertos)
          └── colaboradores puntuales
```

### 5.4. Equipos y visibilidad

```text
Visibilidad de los equipos
   │
   ├── Privado (por defecto recomendado):
   │      solo los miembros del equipo ven su membresía
   │      →  importante cuando los roles deben ser discretos
   │
   └── Visible:
         cualquiera en la organización ve quién está en el equipo
         →  útil para equipos públicos de comunidades
```

---

## 6. Roles y permisos

### 6.1. Mapa mental de permisos

```text
¿Quién puede qué?
──────────────────────────────────────────────
Acción                        Quién (típicamente)
──────────────────────────────────────────────
Leer repo privado             Miembro con equipo con acceso

Hacer push                    Equipo con Escritura o superior

Crear repositorios            Depende de la política; a menudo
                              cualquier miembro o solo ciertos
                              equipos

Fusionar Pull Requests        Equipo con Escritura/Mantiene
                              (y según reglas de protección)

Gestionar ramas protegidas    Administración/Mantiene según
                              configuración

Gestionar miembros            Propietarios o administradores
                              de la organización

Cambiar roles                 Propietarios

Ver facturación               Propietarios

Ver bitácora de auditoría     Propietarios (y roles dedicados
                              si existen)
```

### 6.2. La jerarquía de confianza

```text
Niveles de confianza en una organización
──────────────────────────────────────────────
Propietario
   →  todo, incluidas políticas y facturación
   →  número mínimo

Administrador de repo (o Mantiene/Admin en repos)
   →  control técnico de proyectos
   →  personas responsables de esos proyectos

Miembro con escritura
   →  contribuye código
   →  mayoría de un equipo de desarrollo

Miembro con lectura / colaborador
   →  participa en issues y revisión
   →  puede ser gente externa
```

### 6.3. Colaboradores externos

```text
Colaborador externo: casos típicos
   │
   ├── Freelance con acceso a UN repo de la org
   ├── Investigador invitado a un proyecto
   ├── Mentor que solo necesita leer
   └── Equipo aliado con acceso puntual

Cómo: se añade como colaborador del repositorio
(sin hacerlo miembro de la organización)
```

Ventaja: mínimo privilegio. Riesgo a vigilar: los externos con acceso prolongado «olvidan» que se van (revisar periódicamente).

---

## 7. Organizaciones de código abierto

### 7.1. La organización como casa del proyecto

Muchos proyectos abiertos famosos viven en organizaciones, no en cuentas personales:

```text
Motivos
   │
   ├── El proyecto no depende de una persona
   ├── Varios mantenedores con los mismos poderes
   ├── El nombre del proyecto es la identidad
   └── Continuidad si alguien se retira
```

### 7.2. Gobernanza

Una comunidad organiza su toma de decisiones:

```text
Elementos de gobernanza típicos
   │
   ├── Código de conducta
   ├── CONTRIBUTING (cómo contribuir)
   ├── Mantenedores y sus responsabilidades
   ├── Proceso de decisión (consenso, votación)
   └── Reglas de revisión (quién aprueba)
```

La sección 29 (participar en comunidades) y 17 (Pull Requests) abordan la contribución práctica; aquí nos quedamos con la estructura.

### 7.3. Colaborar con la organización ajena

```text
Qué NO haces:
   ├── no te autoinvitas
   └── no pides permisos de administración sin necesidad

Qué SÍ haces:
   ├── lees CONTRIBUTING
   ├── abres issues con respeto al formato
   ├── propones Pull Requests pequeñas y revisadas
   └── usas las vías públicas de la comunidad
```

---

## 8. La organización en tu día a día

### 8.1. Cómo se ve al pertenecer

Cuando perteneces a una organización:

```text
En tu cuenta
   │
   ├── Puedes cambiar de contexto entre tu cuenta personal
   │   y las organizaciones (selector de contexto en la
   │   interfaz, normalmente en el menú de avatar o en la
   │   esquina superior)
   │
   ├── Tus repositorios y actividad se muestran según
   │   el contexto activo
   │
   └── Las invitaciones pendientes aparecen en notificaciones
```

### 8.2. Selector de contexto

```text
Selector de contexto (concepto)
──────────────────────────────────────────────
[ Tu cuenta ▾ ]   ← puedes elegir:
     │
     ├── tu-cuenta-personal
     ├── mi-empresa
     └── otra-org

Efecto:
   · la página de inicio muestra la actividad del contexto
   · la creación de repositorios se hace en ese contexto
   · los ajustes que ves corresponden al contexto elegido
```

> **Consejo práctico:** antes de crear un repositorio, comprueba en qué contexto estás. Una confusión frecuente al principio es crear en la organización un repo que se pretendía personal (o al revés). Se puede transferir después, pero evita el lío.

### 8.3. Tu actividad pública

Tu perfil personal muestra tu actividad pública global; la organización tiene su propio perfil con su actividad. Las contribuciones a repos de la org se reflejan en tu historial personal (es tu trabajo).

---

## 9. Errores comunes con diagnóstico completo

### Error 1: Demasiados propietarios

**Qué ocurrió:** para «facilitar», se dio propietario a todo el equipo inicial.

**Por qué:** desconocimiento del alcance (facturación, políticas, borrado).

**Cómo comprobarlo:** lista de miembros con rol de propietario.

**Opciones:**
* bajar a roles menores a quien no necesita todo el poder;
* dejar 2-3 propietarios activos.

**Riesgos:** cualquiera puede modificar políticas, gestionar facturación o eliminar repositorios; un error o una cuenta comprometida tiene alcance total.

**Solución:** propiedad mínima; roles específicos para el resto.

**Cómo se evita:** desde la creación, propiedad solo a quien la necesita.

---

### Error 2: Dar permisos de administración en repositorio a todo el equipo

**Qué ocurrió:** todos los devs con Admin en todos los repos «para no estorbar».

**Por qué:** prisa y evitar peticiones de permisos.

**Cómo comprobarlo:** revisar permisos por repositorio; comparar con las tareas reales de cada persona.

**Opciones:**
* ajustar por equipo (Escritura para desarrollo, Mantiene/Admin para responsables);
* usar ramas protegidas como red de seguridad (sección 13).

**Riesgos:** cualquiera puede borrar ramas, cambiar integraciones, en el peor caso eliminar el repo o introducir cambios sin revisión.

**Solución:** mínimo privilegio + protección de ramas.

**Cómo se evita:** mapear «qué hace cada equipo» antes de asignar permisos.

---

### Error 3: Invitar al usuario equivocado

**Qué ocurrió:** error de dedo o correo mal escrito; una cuenta ajena recibió acceso.

**Por qué:** falta de revisión antes de confirmar.

**Cómo comprobarlo:** lista de miembros recién invitados/aceptados.

**Opciones:**
* eliminar inmediatamente al miembro;
* revisar qué pudo ver (si aceptó y tenía acceso a repos privados, considerar rotación de secretos sensibles);
* registrar el incidente.

**Riesgos:** fuga de código privado.

**Solución:** baja inmediata + evaluación de exposición.

**Cómo se evita:** verificar nombre de usuario tres veces (el que invitas es el que entra).

---

### Error 4: Miembro sin equipos (y sin acceso) quejándose de que «no ve nada»

**Qué ocurrió:** se aceptó la invitación, pero no se añadió a ningún equipo.

**Por qué:** el flujo de invitación no incluyó la asignación de equipos.

**Cómo comprobarlo:** ficha del miembro → equipos (vacío).

**Opciones:** añadirlo al equipo correcto.

**Riesgos:** confusión y pérdida de tiempo (o, peor, que lo arregle alguien con permisos demasiado amplios «para que funcione»).

**Solución:** flujo estándar: invitar → aceptar → asignar equipo → verificar acceso.

**Cómo se evita:** checklist de incorporación (ya vista en el capítulo de configuración).

---

### Error 5: Colaborador externo olvidado

**Qué ocurrió:** un freelance terminó el proyecto pero mantiene acceso.

**Por qué:** no hubo proceso de baja.

**Cómo comprobarlo:** revisión trimestral de colaboradores por repositorio.

**Opciones:** retirar el acceso; rotar secretos si el proyecto es sensible.

**Riesgos:** acceso no autorizado a largo plazo.

**Solución:** baja y revisión.

**Cómo se evita:** anotar el acceso con fecha de revisión al concederlo.

---

### Error 6: Pertenecer a una organización con políticas y no entender por qué «falta» una opción

**Qué ocurrió:** un miembro no encuentra la opción de X en Settings.

**Por qué:** la organización tiene políticas que limitan (SSO, 2FA, permisos).

**Cómo comprobarlo:** consultar con el administrador de la organización; revisar políticas.

**Opciones:** pedir excepción o adaptar el flujo.

**Riesgos:** forzar atajos que violan la política.

**Solución:** entender que la organización manda sobre ciertos ajustes personales.

**Cómo se evita:** al entrar en una org, preguntar sus reglas (2FA, SSO, ramas, despliegues).

---

## 10. Práctica guiada

### Objetivo

Crear una organización, montar una estructura básica de equipos y gestionar una invitación completa.

### Paso 1: Crear la organización

1. Abre el menú de tu avatar y busca la opción de crear organización.
2. Elige nombre (será tu URL) y plan inicial.
3. Termina la creación; comprueba que eres propietario.

### Paso 2: Estructura inicial

1. Crea 2-3 equipos con nombres claros (ejemplo: Desarrollo, Documentación).
2. Asigna visibilidad privada por defecto.
3. Crea un repositorio privado de prueba en la organización.

### Paso 3: Invitación

1. Invita a una segunda cuenta que controle (puedes usar otra tuya o la de un compañero).
2. Acepta la invitación desde esa cuenta.
3. Añade a esa cuenta al equipo Desarrollo con permiso de Escritura.

### Paso 4: Verificación de permisos

Desde la cuenta invitada:

1. Abre el repositorio de la organización.
2. Comprueba que puede leer y hacer push (si tiene escritura).
3. Comprueba que NO ve ajustes que no le corresponden.

### Paso 5: Simulacro de baja

1. Retira al miembro (o baja el permiso).
2. Comprueba que pierde el acceso.
3. Reintegra: invita de nuevo y reasigna el equipo.

### Checklist final

```text
Organización operativa
   │
   ├── Nombre y URL correctos                     □
   ├── Al menos 2 propietarios (si hay equipo)    □
   ├── Equipos creados con permisos mínimos       □
   ├── Invitación completa (invitar→aceptar→equipo) □
   ├── Verificación de acceso desde la otra       □
   │   cuenta                                     □
   └── Prueba de baja superada                    □
```

### Resultado esperado

Una organización funcional con estructura de equipos y un ciclo completo de incorporación y baja comprendido.

### Conclusión esperada

La organización es el mecanismo que separa el proyecto de las personas: los repos viven en la entidad, los permisos se dan por equipo y las altas/bajas son gestiones, no terremotos.

---

## 11. Nivel profesional

### 11.1. Organizaciones de empresa

En una empresa, la organización deja de ser «un grupo» y pasa a ser infraestructura:

```text
Componentes de una org de empresa
   │
   ├── Estructura de equipos reflejando la organización real
   │      →  plataforma, backend, frontend, datos, seguridad...
   │
   ├── Permisos alineados con responsabilidades
   │      →  y no con «quien pregunta primero»
   │
   ├── Repositorios con propietarios claros
   │      →  quién responde por cada proyecto
   │
   ├── Política de colaboradores externos con caducidad
   │
   └── Integraciones revisadas (apps con permisos)
```

### 11.2. SSO y políticas

Las organizaciones avanzadas gestionan el acceso con identidad corporativa:

```text
Controles típicos de una organización empresarial
   │
   ├── SSO obligatorio (el acceso pasa por el proveedor)
   ├── 2FA obligatorio para todos los miembros
   ├── Restricciones de sesión y dispositivo
   ├── Límites de tokens y claves SSH
   ├── Políticas de despliegue (entornos protegidos)
   └── Aprobaciones requeridas para ciertas acciones
```

Si algo «no se puede» en tu cuenta, a menudo es una política de la organización, no un fallo.

### 11.3. Bitácora de auditoría

La organización dispone de un registro de eventos administrativos:

```text
Qué registra la bitácora de auditoría
   │
   ├── Altas y bajas de miembros
   ├── Cambios de rol y permisos
   ├── Creación/eliminación de repositorios
   ├── Cambios en políticas de seguridad
   ├── Acciones de integraciones
   └── Eventos de SSO y accesos

Uso profesional:
   · investigación de incidentes
   · cumplimiento y auditorías internas
   · detección de cambios inesperados
```

### 11.4. Facturación y planes

La organización puede tener planes de pago (más privacidad, más capacidad, soporte). Aspectos profesionales:

```text
Gestión de facturación
   │
   ├── Solo propietarios (y roles dedicados si existen)
   ├── Revisiones periódica de miembros y asientos
   ├── Cuidado con licencias «fantasma» de gente que se fue
   └── Consumo de Actions y almacenamiento bajo vigilancia
```

(El capítulo 04 de esta sección detalla planes y límites.)

### 11.5. Transferencias y desorganización

Errores organizativos típicos en empresas:

```text
Señales de alarma
   │
   ├── Equipos con nombres históricos que ya no significan nada
   ├── Personas con permisos de su antiguo rol tras moverse
   ├── «Super-equipos» con todo
   └── Colaboradores externos sin fecha de revisión

Respuesta: revisión trimestral de permisos
   →  pasar lista: ¿sigue esta persona aquí?
   →  ¿sigue necesitando ESTE nivel?
```

---

## 12. Resumen

En este capítulo aprendiste que:

* la organización es el contenedor de GitHub para equipos y proyectos: tiene nombre propio, repositorios propios y gestiona personas y permisos;
* se diferencia de la cuenta personal en que el trabajo vive en la entidad, no en la persona, lo que da continuidad al proyecto;
* miembro y colaborador no son lo mismo: el miembro pertenece a la organización; el colaborador tiene permisos sobre un repositorio concreto, sin necesidad de pertenecer;
* los propietarios tienen poder total y deben ser el número mínimo imprescindible;
* los equipos son la herramienta de gestión: agrupan personas y reciben permisos por repositorio (lectura, escritura, mantiene, administración);
* el principio de mínimo privilegio gobierna toda asignación de permisos;
* las invitaciones las acepta el invitado, caducan y la baja debe revisar accesos residuales (tokens, claves, secretos);
* en comunidades de código abierto, la organización da continuidad al proyecto más allá de las personas;
* el selector de contexto evita crear repositorios en el lugar equivocado;
* a nivel empresarial se suman SSO, políticas, bitácora de auditoría y gestión de facturación.

La idea principal es:

> **La organización separa el proyecto de las personas: los repositorios viven en la entidad, los permisos se dan por equipo y las personas entran y salen sin llevarse el trabajo.**

---

## Próximo paso

Has completado la sección «Tu cuenta de GitHub»: creaste la cuenta, configuraste la perfil, ajustaste la configuración básica, endureciste la seguridad con 2FA y aprendiste a trabajar en equipo con organizaciones.

Continúa con el índice de la sección para revisar el recorrido:

[`README.md`](README.md)
