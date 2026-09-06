-- ============================================================
-- VTDF103 — Informe Proyecto N°2 (Semana 12)
-- Caso 2: Plataforma de Gestión de Proyectos de Construcción
-- Script 05: Procedimiento almacenado / consulta equivalente
-- Motor: SQLite 3
-- ============================================================

-- ------------------------------------------------------------
-- NOTA IMPORTANTE SOBRE SQLITE
-- ------------------------------------------------------------
-- SQLite no implementa procedimientos almacenados (STORED
-- PROCEDURES) como otros motores (PostgreSQL, MySQL o SQL
-- Server). Por esta razón, el requerimiento se resuelve con una
-- consulta parametrizada equivalente que cumple el mismo
-- objetivo: recibir un id_proyecto y retornar el presupuesto
-- total invertido en materiales hasta la fecha.
--
-- Si en el futuro se migra a PostgreSQL, la función equivalente
-- sería:
--
-- CREATE OR REPLACE FUNCTION sp_presupuesto_proyecto(p_id INT)
-- RETURNS TABLE (...) AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT P.id_proyecto, P.nombre,
--            COUNT(UM.id_uso),
--            COALESCE(SUM(UM.cantidad * UM.costo_unitario), 0)
--     FROM Proyectos P
--     LEFT JOIN Uso_Materiales UM ON P.id_proyecto = UM.id_proyecto
--     WHERE P.id_proyecto = p_id
--     GROUP BY P.id_proyecto, P.nombre;
-- END;
-- $$ LANGUAGE plpgsql;
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Consulta equivalente al procedimiento almacenado
-- Objetivo: Calcular el presupuesto total invertido en materiales
--           de un proyecto específico hasta la fecha.
-- Tablas involucradas: Proyectos, Uso_Materiales, Materiales
-- Función de grupo: SUM
-- Parámetro: id_proyecto (cambiar el valor 1 por el ID deseado)
-- Justificación: Agiliza la emisión de estados de pago y el
--                control de costos de una obra en particular.
-- ------------------------------------------------------------
SELECT
    P.id_proyecto,
    P.nombre AS nombre_proyecto,
    COUNT(UM.id_uso) AS cantidad_pedidos,
    COALESCE(SUM(UM.cantidad * UM.costo_unitario), 0) AS total_inversion_materiales
FROM Proyectos P
LEFT JOIN Uso_Materiales UM ON P.id_proyecto = UM.id_proyecto
LEFT JOIN Materiales M ON UM.id_material = M.id_material
WHERE P.id_proyecto = 1
GROUP BY P.id_proyecto, P.nombre;
