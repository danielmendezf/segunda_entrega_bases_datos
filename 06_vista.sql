-- ============================================================
-- Script 06: Vista con tres o más tablas, filtros y operadores
--            relacionales
-- ============================================================

-- ------------------------------------------------------------
-- Vista: vw_personal_terreno_activo
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
