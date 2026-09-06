-- ============================================================
-- VTDF103 — Informe Proyecto N°2 (Semana 12)
-- Caso 2: Plataforma de Gestión de Proyectos de Construcción
-- Script 01: Creación de base de datos y tablas (DDL)
-- Motor: SQLite 3
-- ============================================================
-- Este script elimina y recrea todas las tablas del esquema,
-- manteniendo el modelo original aprobado en la Fase 1.
-- ============================================================

-- ------------------------------------------------------------
-- Limpieza de objetos previos
-- ------------------------------------------------------------
DROP VIEW IF EXISTS vw_personal_terreno_activo;
DROP TABLE IF EXISTS Uso_Materiales;
DROP TABLE IF EXISTS Asignacion_Empleados;
DROP TABLE IF EXISTS Materiales;
DROP TABLE IF EXISTS Proveedores;
DROP TABLE IF EXISTS Etapas_Proyecto;
DROP TABLE IF EXISTS Proyectos_Residenciales;
DROP TABLE IF EXISTS Proyectos_Comerciales;
DROP TABLE IF EXISTS Proyectos;
DROP TABLE IF EXISTS Telefonos_Empleado;
DROP TABLE IF EXISTS Empleados;

-- ------------------------------------------------------------
-- 1. Empleados (entidad fuerte)
-- ------------------------------------------------------------
CREATE TABLE Empleados (
    rut TEXT PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    fecha_nacimiento TEXT NOT NULL,
    direccion TEXT NOT NULL,
    especialidad TEXT NOT NULL
        CHECK (especialidad IN ('Albañilería', 'Electricidad', 'Carpintería', 'Plomería', 'Ingeniería')),
    sueldo_hora REAL NOT NULL
        CHECK (sueldo_hora > 0)
);

-- ------------------------------------------------------------
-- 2. Teléfonos de Empleado (atributo multivaluado)
-- ------------------------------------------------------------
CREATE TABLE Telefonos_Empleado (
    id_telefono INTEGER PRIMARY KEY AUTOINCREMENT,
    rut_empleado TEXT NOT NULL,
    numero TEXT NOT NULL,
    FOREIGN KEY (rut_empleado) REFERENCES Empleados(rut)
        ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 3. Proyectos (superclase / entidad fuerte)
-- ------------------------------------------------------------
CREATE TABLE Proyectos (
    id_proyecto INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    latitud REAL NOT NULL,
    longitud REAL NOT NULL,
    precio_mts2 REAL NOT NULL
        CHECK (precio_mts2 > 0),
    estado TEXT NOT NULL
        CHECK (estado IN ('En ejecución', 'Finalizado')),
    fecha_inicio TEXT NOT NULL
);

-- ------------------------------------------------------------
-- 4. Proyectos Comerciales (subclase)
-- ------------------------------------------------------------
CREATE TABLE Proyectos_Comerciales (
    id_proyecto INTEGER PRIMARY KEY,
    tipo_negocio TEXT NOT NULL,
    num_colaboradores INTEGER NOT NULL
        CHECK (num_colaboradores > 0),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto)
        ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 5. Proyectos Residenciales (subclase)
-- ------------------------------------------------------------
CREATE TABLE Proyectos_Residenciales (
    id_proyecto INTEGER PRIMARY KEY,
    cantidad_viviendas INTEGER NOT NULL
        CHECK (cantidad_viviendas > 0),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto)
        ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 6. Etapas del Proyecto (entidad débil)
-- ------------------------------------------------------------
CREATE TABLE Etapas_Proyecto (
    id_etapa INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto INTEGER NOT NULL,
    nombre_etapa TEXT NOT NULL
        CHECK (nombre_etapa IN ('Planificación', 'Cimentación', 'Acabados')),
    estado_etapa TEXT NOT NULL
        CHECK (estado_etapa IN ('Pendiente', 'En progreso', 'Completada')),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto)
        ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 7. Proveedores (entidad fuerte)
-- ------------------------------------------------------------
CREATE TABLE Proveedores (
    rut_proveedor TEXT PRIMARY KEY,
    nombre TEXT NOT NULL,
    telefono TEXT NOT NULL,
    direccion TEXT NOT NULL
);

-- ------------------------------------------------------------
-- 8. Materiales (entidad fuerte)
-- ------------------------------------------------------------
CREATE TABLE Materiales (
    id_material INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_material TEXT NOT NULL,
    unidad_medida TEXT NOT NULL
);

-- ------------------------------------------------------------
-- 9. Asignación de Empleados a Proyectos (relación M:N con atributos)
-- ------------------------------------------------------------
CREATE TABLE Asignacion_Empleados (
    id_asignacion INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto INTEGER NOT NULL,
    rut_empleado TEXT NOT NULL,
    rol TEXT NOT NULL,
    horas_trabajadas INTEGER NOT NULL DEFAULT 0
        CHECK (horas_trabajadas >= 0),
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto)
        ON DELETE CASCADE,
    FOREIGN KEY (rut_empleado) REFERENCES Empleados(rut)
        ON DELETE CASCADE
);

-- ------------------------------------------------------------
-- 10. Uso de Materiales (relación M:N entre Proyecto, Material y Proveedor)
-- ------------------------------------------------------------
CREATE TABLE Uso_Materiales (
    id_uso INTEGER PRIMARY KEY AUTOINCREMENT,
    id_proyecto INTEGER NOT NULL,
    id_material INTEGER NOT NULL,
    rut_proveedor TEXT NOT NULL,
    cantidad REAL NOT NULL
        CHECK (cantidad > 0),
    costo_unitario REAL NOT NULL
        CHECK (costo_unitario > 0),
    fecha_registro TEXT NOT NULL,
    FOREIGN KEY (id_proyecto) REFERENCES Proyectos(id_proyecto)
        ON DELETE CASCADE,
    FOREIGN KEY (id_material) REFERENCES Materiales(id_material)
        ON DELETE CASCADE,
    FOREIGN KEY (rut_proveedor) REFERENCES Proveedores(rut_proveedor)
        ON DELETE CASCADE
);
