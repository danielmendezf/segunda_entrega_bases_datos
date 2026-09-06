-- ============================================================
-- VTDF103 — Informe Proyecto N°2 (Semana 12)
-- Caso 2: Plataforma de Gestión de Proyectos de Construcción
-- Script 06: Vista con tres o más tablas, filtros y operadores
--            relacionales
-- Motor: SQLite 3
-- ============================================================

-- ------------------------------------------------------------
-- Vista: vw_personal_terreno_activo
-- Objetivo: Consolidar un panel de control de recursos humanos
--           que muestre qué personal está asignado a obras no
--           finalizadas.
-- Tablas involucradas: Empleados, Asignacion_Empleados, Proyectos
-- Filtro: estado <> 'Finalizado' AND horas_trabajadas > 0
-- Operadores relacionales: <>
-- Justificación: Evita escribir la consulta compleja cada vez
--                que el equipo de gestión necesita ver el
--                personal activo en terreno.
-- ------------------------------------------------------------
DROP VIEW IF EXISTS vw_personal_terreno_activo;

CREATE VIEW vw_personal_terreno_activo AS
SELECT
    E.rut,
    E.nombre_completo,
    E.especialidad,
    A.rol,
    A.horas_trabajadas,
    P.nombre AS proyecto_asignado,
    P.estado AS estado_proyecto
FROM Empleados E
INNER JOIN Asignacion_Empleados A ON E.rut = A.rut_empleado
INNER JOIN Proyectos P ON A.id_proyecto = P.id_proyecto
WHERE P.estado <> 'Finalizado'
  AND A.horas_trabajadas > 0;

-- Ejemplo de uso:
-- SELECT * FROM vw_personal_terreno_activo;
