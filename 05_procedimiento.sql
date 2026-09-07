-- ============================================================
-- Script 05: Procedimiento almacenado / consulta equivalente
-- ============================================================
-- Procedimiento para postgresql
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
-- Consulta para sqlite
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
