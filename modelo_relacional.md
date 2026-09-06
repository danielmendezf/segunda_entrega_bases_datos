# Modelo Relacional — Entrega 2

El siguiente diagrama representa el esquema relacional implementado en SQLite 3, derivado del modelo Entidad-Relación aprobado en la Fase 1 (`proyecto/mer.md`).

```mermaid
erDiagram
    Empleados {
        TEXT rut PK
        TEXT nombre_completo
        TEXT email UK
        TEXT fecha_nacimiento
        TEXT direccion
        TEXT especialidad
        REAL sueldo_hora
    }

    Telefonos_Empleado {
        INTEGER id_telefono PK
        TEXT rut_empleado FK
        TEXT numero
    }

    Proyectos {
        INTEGER id_proyecto PK
        TEXT nombre
        REAL latitud
        REAL longitud
        REAL precio_mts2
        TEXT estado
        TEXT fecha_inicio
    }

    Proyectos_Comerciales {
        INTEGER id_proyecto PK,FK
        TEXT tipo_negocio
        INTEGER num_colaboradores
    }

    Proyectos_Residenciales {
        INTEGER id_proyecto PK,FK
        INTEGER cantidad_viviendas
    }

    Etapas_Proyecto {
        INTEGER id_etapa PK
        INTEGER id_proyecto FK
        TEXT nombre_etapa
        TEXT estado_etapa
    }

    Proveedores {
        TEXT rut_proveedor PK
        TEXT nombre
        TEXT telefono
        TEXT direccion
    }

    Materiales {
        INTEGER id_material PK
        TEXT nombre_material
        TEXT unidad_medida
    }

    Asignacion_Empleados {
        INTEGER id_asignacion PK
        INTEGER id_proyecto FK
        TEXT rut_empleado FK
        TEXT rol
        INTEGER horas_trabajadas
    }

    Uso_Materiales {
        INTEGER id_uso PK
        INTEGER id_proyecto FK
        INTEGER id_material FK
        TEXT rut_proveedor FK
        REAL cantidad
        REAL costo_unitario
        TEXT fecha_registro
    }

    Empleados ||--o{ Telefonos_Empleado : "posee"
    Proyectos ||--o{ Proyectos_Comerciales : "es"
    Proyectos ||--o{ Proyectos_Residenciales : "es"
    Proyectos ||--o{ Etapas_Proyecto : "tiene"
    Proyectos ||--o{ Asignacion_Empleados : "asigna"
    Empleados ||--o{ Asignacion_Empleados : "trabaja"
    Proyectos ||--o{ Uso_Materiales : "utiliza"
    Materiales ||--o{ Uso_Materiales : "es_usado"
    Proveedores ||--o{ Uso_Materiales : "suministra"
```

## Descripción de tablas

| Tabla | Tipo | Clave primaria | Claves foráneas | Observación |
|-------|------|----------------|-----------------|-------------|
| `Empleados` | Fuerte | `rut` | — | Atributo `email` con restricción `UNIQUE`. |
| `Telefonos_Empleado` | Débil / multivaluado | `id_telefono` | `rut_empleado` → `Empleados(rut)` | Transformación del atributo multivaluado *teléfonos*. |
| `Proyectos` | Fuerte / superclase | `id_proyecto` | — | Contiene el discriminador implícito `estado`. |
| `Proyectos_Comerciales` | Subclase | `id_proyecto` | `id_proyecto` → `Proyectos(id_proyecto)` | Especialización con atributos propios. |
| `Proyectos_Residenciales` | Subclase | `id_proyecto` | `id_proyecto` → `Proyectos(id_proyecto)` | Especialización con atributos propios. |
| `Etapas_Proyecto` | Débil | `id_etapa` | `id_proyecto` → `Proyectos(id_proyecto)` | No tiene sentido sin su proyecto. |
| `Proveedores` | Fuerte | `rut_proveedor` | — | — |
| `Materiales` | Fuerte | `id_material` | — | — |
| `Asignacion_Empleados` | Asociativa (M:N) | `id_asignacion` | `id_proyecto`, `rut_empleado` | Relación entre empleados y proyectos. |
| `Uso_Materiales` | Asociativa (M:N) | `id_uso` | `id_proyecto`, `id_material`, `rut_proveedor` | Relación entre proyectos, materiales y proveedores. |
