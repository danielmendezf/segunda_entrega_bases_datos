# Decisiones técnicas — Informe Proyecto N°2 (Semana 12)

**Asignatura:** VTDF103 — Bases de Datos  
**Caso:** Plataforma de Gestión de Proyectos de Construcción  
**Entrega:** Fase 2 (implementación SQL)  
**Fecha de elaboración:** 2026-09-01

> **Nota de transparencia:** Este documento y los scripts SQL asociados fueron elaborados con asistencia de IA generativa. Deben ser revisados, comprendidos y adaptados por el grupo antes de ser entregados como trabajo propio.

---

## 1. Decisiones generales

### 1.1 Respeto al modelo original de la Fase 1

El grupo obtuvo la nota máxima en la Fase 1 con el modelo presentado en `proyecto/mer.md` y `proyecto/modeloKimi.png`. Por esta razón, en esta segunda fase **no se aplicaron correcciones estructurales al modelo**: se mantuvieron las mismas entidades, atributos, relaciones y cardinalidades aprobadas. El objetivo fue transformar ese modelo directamente en un esquema relacional funcional en SQLite.

### 1.2 Uso de SQLite como motor

Se eligió **SQLite 3** porque:

- El script base (`proyecto/script2.sql`) fue construido y probado para SQLite.
- Es un motor ligero, portable y suficiente para demostrar el aprendizaje esperado de la unidad (AE3).
- No requiere instalación de un servidor de bases de datos, lo que facilita la ejecución y revisión del trabajo.

La principal limitación de SQLite —la ausencia de procedimientos almacenados— se documenta en la sección 4.

### 1.3 Separación de scripts

El script original contenía en un solo archivo el DDL, DML, consultas, procedimiento y vista. Siguiendo la indicación de separar las secciones, se dividió en seis archivos independientes:

| Archivo | Sección | Propósito |
|---------|---------|-----------|
| `01_ddl.sql` | DDL | Creación de tablas, claves y restricciones. |
| `02_datos.sql` | DML | Inserción de datos de prueba. |
| `03_consultas_filtros.sql` | DQL | Consultas con filtros y operadores lógicos. |
| `04_consultas_agrupamiento.sql` | DQL | Consultas con funciones de grupo y `HAVING`. |
| `05_procedimiento.sql` | DQL / SP | Consulta equivalente al procedimiento almacenado. |
| `06_vista.sql` | DDL | Creación de la vista. |

Esta separación facilita la revisión, la depuración y la reutilización de cada parte del trabajo.

---

## 2. Decisiones de modelado relacional

### 2.1 Especialización proyecto: residencial vs. comercial

Se mantuvo la especialización del modelo original mediante tres tablas:

- `Proyectos`: superclase con atributos comunes.
- `Proyectos_Comerciales`: subclase con `tipo_negocio` y `num_colaboradores`.
- `Proyectos_Residenciales`: subclase con `cantidad_viviendas`.

Esta opción (una tabla por subtipo) conserva fielmente el MERE original y evita valores nulos en atributos específicos.

### 2.2 Entidades débiles

- `Etapas_Proyecto` depende de `Proyectos`. Se usa `ON DELETE CASCADE` para que al eliminar un proyecto se eliminen sus etapas.
- `Telefonos_Empleado` es la transformación del atributo multivaluado *teléfonos* de `Empleados`.

### 2.3 Relaciones M:N

Todas las relaciones M:N se transformaron en tablas asociativas:

| Relación | Tabla resultante | Clave primaria |
|----------|------------------|----------------|
| EMPLEADO ↔ PROYECTO | `Asignacion_Empleados` | `id_asignacion` (surrogate) |
| PROYECTO ↔ MATERIAL ↔ PROVEEDOR | `Uso_Materiales` | `id_uso` (surrogate) |

Se usaron claves surrogate (`id_asignacion`, `id_uso`) para simplificar las referencias y mantener la coherencia con el script base.

### 2.4 Cálculo del sueldo

El sueldo del empleado se almacena directamente en `Empleados.sueldo_hora`. Esta decisión respeta el modelo original, donde el sueldo se calcula en base a la especialidad y las horas trabajadas. En una versión más normalizada podría separarse la tarifa por especialidad, pero ello implicaría modificar el modelo aprobado.

---

## 3. Decisiones de implementación en SQL

### 3.1 Tipos de datos

| Tipo SQLite | Uso |
|-------------|-----|
| `INTEGER PRIMARY KEY AUTOINCREMENT` | Claves surrogate (`id_proyecto`, `id_material`, `id_etapa`, etc.). |
| `TEXT` | RUT, nombres, correos, direcciones, teléfonos y dominios cerrados. |
| `REAL` | Coordenadas, precios, cantidades, costos y sueldos. |
| `TEXT` (formato ISO `YYYY-MM-DD`) | Fechas. SQLite no tiene tipo DATE nativo. |

### 3.2 Restricciones

- Claves primarias en todas las tablas.
- Claves foráneas con `ON DELETE CASCADE` en entidades débiles y relaciones dependientes.
- Restricciones `CHECK` para garantizar dominios cerrados (`estado`, `especialidad`, `nombre_etapa`, `estado_etapa`).
- Restricción `UNIQUE` sobre el correo de empleados.

### 3.3 Datos de prueba

Se partió de los datos originales del script base y se ampliaron para cumplir con el requisito de **al menos 10 registros por tabla**. En particular, se agregaron proyectos adicionales para que las tablas de subtipos `Proyectos_Comerciales` y `Proyectos_Residenciales` contengan 10 registros cada una. Los datos fueron generados de forma coherente: cada asignación y uso de material corresponde a proyectos, empleados, materiales y proveedores existentes.

---

## 4. Consideraciones sobre el procedimiento almacenado

### 4.1 Limitación de SQLite

SQLite **no soporta procedimientos almacenados** (`STORED PROCEDURES`). Por esta razón, el requerimiento de la rúbrica se resolvió con una **consulta parametrizada equivalente** que:

- Recibe un `id_proyecto` (mediante la cláusula `WHERE`).
- Involucra tres tablas: `Proyectos`, `Uso_Materiales` y `Materiales`.
- Usa la función de grupo `SUM`.
- Retorna el presupuesto total invertido en materiales del proyecto.

### 4.2 Consulta equivalente

La consulta se encuentra en `05_procedimiento.sql` y puede adaptarse a PostgreSQL/MySQL como una función o procedimiento almacenado real si el docente lo solicita.

---

## 5. Justificación de consultas, vista y procedimiento

### 5.1 Consultas con filtros y operaciones lógicas (`03_consultas_filtros.sql`)

1. **Ingenieros en proyectos en ejecución.** Usa `Empleados`, `Asignacion_Empleados` y `Proyectos`. Filtra por especialidad y estado del proyecto.
2. **Materiales en proyectos comerciales grandes.** Usa `Uso_Materiales`, `Materiales`, `Proveedores`, `Proyectos_Comerciales` y `Proyectos`. Filtra por número de colaboradores y costo unitario.
3. **Etapas pendientes o en progreso en residenciales.** Usa `Proyectos`, `Proyectos_Residenciales` y `Etapas_Proyecto`. Filtra por estado de etapa y ordena por fecha.

### 5.2 Consultas con funciones de grupo y `HAVING` (`04_consultas_agrupamiento.sql`)

1. **Materiales más utilizados desde 2023.** Usa `SUM` y `COUNT` con filtro de fecha.
2. **Empleados en más de un proyecto.** Usa `COUNT(DISTINCT ...)` y `HAVING > 1`.
3. **Proveedores con facturación superior a $1.000.000.** Usa `SUM(cantidad * costo_unitario)` en `HAVING`.

### 5.3 Vista (`06_vista.sql`)

`vw_personal_terreno_activo` resume el personal asignado a obras no finalizadas. Filtra con el operador relacional `<>` sobre `estado` y une tres tablas.

---

## 6. Limitaciones y próximos pasos

- SQLite no permite procedimientos almacenados. Si el docente exige su uso, se recomienda migrar el esquema a PostgreSQL o MySQL, manteniendo la misma estructura de tablas.
- El cálculo del presupuesto actual solo considera costos de materiales. Para incluir mano de obra, se podría extender la consulta con la tabla `Asignacion_Empleados` y `Empleados.sueldo_hora`.
