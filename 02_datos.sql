-- ============================================================
-- Script 02: Inserción de datos de prueba (DML)
-- ============================================================

-- ------------------------------------------------------------
-- Empleados
-- ------------------------------------------------------------
INSERT INTO Empleados (rut, nombre_completo, email, fecha_nacimiento, direccion, especialidad, sueldo_hora) VALUES
('11111111-1', 'Juan Perez', 'juan.perez@emp.cl', '1985-05-12', 'Calle 1, Stgo', 'Albañilería', 5000),
('22222222-2', 'Maria Gonzalez', 'maria.g@emp.cl', '1990-08-22', 'Calle 2, Stgo', 'Electricidad', 6500),
('33333333-3', 'Pedro Silva', 'pedro.s@emp.cl', '1988-11-03', 'Calle 3, Stgo', 'Carpintería', 5500),
('44444444-4', 'Ana Rojas', 'ana.r@emp.cl', '1992-02-15', 'Calle 4, Stgo', 'Plomería', 6000),
('55555555-5', 'Luis Soto', 'luis.s@emp.cl', '1980-07-09', 'Calle 5, Stgo', 'Ingeniería', 12000),
('66666666-6', 'Carlos Vega', 'carlos.v@emp.cl', '1987-04-20', 'Calle 6, Stgo', 'Albañilería', 5000),
('77777777-7', 'Laura Castro', 'laura.c@emp.cl', '1995-10-11', 'Calle 7, Stgo', 'Electricidad', 6500),
('88888888-8', 'Diego Muñoz', 'diego.m@emp.cl', '1982-12-30', 'Calle 8, Stgo', 'Carpintería', 5500),
('99999999-9', 'Camila Diaz', 'camila.d@emp.cl', '1991-03-25', 'Calle 9, Stgo', 'Ingeniería', 12000),
('10101010-0', 'Jorge Ruiz', 'jorge.r@emp.cl', '1989-06-18', 'Calle 10, Stgo', 'Plomería', 6000),
('12121212-1', 'Fernanda Torres', 'fernanda.t@emp.cl', '1993-07-14', 'Calle 11, Stgo', 'Electricidad', 6500),
('13131313-2', 'Ricardo Lopez', 'ricardo.l@emp.cl', '1986-09-30', 'Calle 12, Stgo', 'Albañilería', 5000),
('14141414-3', 'Daniela Martinez', 'daniela.m@emp.cl', '1994-01-08', 'Calle 13, Stgo', 'Carpintería', 5500),
('15151515-4', 'Andres Herrera', 'andres.h@emp.cl', '1983-11-22', 'Calle 14, Stgo', 'Plomería', 6000),
('16161616-5', 'Paulina Navarro', 'paulina.n@emp.cl', '1990-04-17', 'Calle 15, Stgo', 'Ingeniería', 12000);

-- ------------------------------------------------------------
-- Teléfonos de Empleados (multivaluado)
-- ------------------------------------------------------------
INSERT INTO Telefonos_Empleado (rut_empleado, numero) VALUES
('11111111-1', '+56911111111'), ('11111111-1', '+56911111112'),
('22222222-2', '+56922222222'), ('22222222-2', '+56922222223'),
('33333333-3', '+56933333333'), ('33333333-3', '+56933333334'),
('44444444-4', '+56944444444'), ('44444444-4', '+56944444445'),
('55555555-5', '+56955555555'), ('55555555-5', '+56955555556'),
('66666666-6', '+56966666666'), ('66666666-6', '+56966666667'),
('77777777-7', '+56977777777'), ('77777777-7', '+56977777778'),
('88888888-8', '+56988888888'), ('88888888-8', '+56988888889'),
('99999999-9', '+56999999999'), ('99999999-9', '+56999999990'),
('10101010-0', '+56910101010'), ('10101010-0', '+56910101011'),
('12121212-1', '+56912121212'), ('12121212-1', '+56912121213'),
('13131313-2', '+56913131313'), ('13131313-2', '+56913131314'),
('14141414-3', '+56914141414'), ('14141414-3', '+56914141415'),
('15151515-4', '+56915151515'), ('15151515-4', '+56915151516'),
('16161616-5', '+56916161616'), ('16161616-5', '+56916161617');

-- ------------------------------------------------------------
-- Proyectos (superclase)
-- ------------------------------------------------------------
INSERT INTO Proyectos (nombre, latitud, longitud, precio_mts2, estado, fecha_inicio) VALUES
('Torre Centro', -33.4372, -70.6506, 85000.00, 'En ejecución', '2023-01-15'),
('Condominio Sur', -33.5123, -70.5891, 75000.00, 'Finalizado', '2022-03-10'),
('Mall Plaza Este', -33.4561, -70.5342, 120000.00, 'En ejecución', '2023-06-20'),
('Edificio Bicentenario', -33.4411, -70.6622, 90000.00, 'En ejecución', '2023-08-05'),
('Residencial Los Alpes', -33.3981, -70.5671, 95000.00, 'En ejecución', '2023-11-12'),
('Centro Logistico Norte', -33.3512, -70.7103, 65000.00, 'Finalizado', '2021-02-18'),
('Oficinas El Golf', -33.4156, -70.5983, 150000.00, 'En ejecución', '2023-09-01'),
('Villas del Parque', -33.4891, -70.6124, 70000.00, 'Finalizado', '2020-10-15'),
('Strip Center Maipu', -33.5098, -70.7521, 110000.00, 'En ejecución', '2024-01-10'),
('Departamentos Providencia', -33.4281, -70.6111, 130000.00, 'En ejecución', '2024-02-20'),
('Hotel Costanera', -33.4215, -70.6055, 180000.00, 'En ejecución', '2024-03-05'),
('Bodega Industrial Quilicura', -33.3678, -70.7344, 55000.00, 'Finalizado', '2022-07-12'),
('Local Comercial La Florida', -33.5234, -70.5912, 95000.00, 'En ejecución', '2024-04-18'),
('Nave Distribución Pudahuel', -33.4389, -70.7456, 72000.00, 'En ejecución', '2024-05-22'),
('Edificio Corporativo Las Condes', -33.4087, -70.5698, 210000.00, 'Finalizado', '2023-02-28'),
('Conjunto Habitacional Norte', -33.3812, -70.6789, 82000.00, 'En ejecución', '2024-06-10'),
('Casas del Valle', -33.4789, -70.6234, 68000.00, 'Finalizado', '2022-11-03'),
('Residencial El Cielo', -33.3567, -70.7123, 105000.00, 'En ejecución', '2024-07-15'),
('Población Los Aromos', -33.4956, -70.6543, 74000.00, 'En ejecución', '2024-08-01'),
('Condominio Alto Maipo', -33.4123, -70.6890, 115000.00, 'Finalizado', '2023-10-20');

-- ------------------------------------------------------------
-- Proyectos Comerciales (subclase) -- 10 registros
-- ------------------------------------------------------------
INSERT INTO Proyectos_Comerciales (id_proyecto, tipo_negocio, num_colaboradores) VALUES
(1, 'Oficinas Mixtas', 150),
(3, 'Retail', 500),
(6, 'Logística', 200),
(7, 'Oficinas Premium', 300),
(9, 'Comercio Local', 80),
(11, 'Hotel', 250),
(12, 'Bodega Industrial', 120),
(13, 'Local Comercial', 45),
(14, 'Nave Distribución', 180),
(15, 'Corporativo', 400);

-- ------------------------------------------------------------
-- Proyectos Residenciales (subclase) -- 10 registros
-- ------------------------------------------------------------
INSERT INTO Proyectos_Residenciales (id_proyecto, cantidad_viviendas) VALUES
(2, 120),
(4, 85),
(5, 200),
(8, 50),
(10, 150),
(16, 95),
(17, 70),
(18, 180),
(19, 110),
(20, 140);

-- ------------------------------------------------------------
-- Etapas del Proyecto (entidad débil)
-- ------------------------------------------------------------
INSERT INTO Etapas_Proyecto (id_proyecto, nombre_etapa, estado_etapa) VALUES
(1, 'Planificación', 'Completada'), (1, 'Cimentación', 'En progreso'),
(2, 'Acabados', 'Completada'),
(3, 'Planificación', 'Completada'), (3, 'Cimentación', 'Completada'), (3, 'Acabados', 'En progreso'),
(4, 'Planificación', 'En progreso'),
(5, 'Cimentación', 'Pendiente'),
(6, 'Acabados', 'Completada'),
(7, 'Cimentación', 'En progreso'),
(8, 'Planificación', 'Completada'), (8, 'Acabados', 'Completada'),
(9, 'Planificación', 'En progreso'),
(10, 'Cimentación', 'Pendiente'),
(11, 'Planificación', 'Completada'), (11, 'Cimentación', 'En progreso'),
(12, 'Acabados', 'Completada'),
(13, 'Planificación', 'En progreso'),
(14, 'Cimentación', 'Pendiente'),
(15, 'Acabados', 'Completada'),
(16, 'Planificación', 'Completada'), (16, 'Cimentación', 'En progreso'),
(17, 'Acabados', 'Completada'),
(18, 'Planificación', 'En progreso'),
(19, 'Cimentación', 'Pendiente'),
(20, 'Acabados', 'Completada');

-- ------------------------------------------------------------
-- Proveedores
-- ------------------------------------------------------------
INSERT INTO Proveedores (rut_proveedor, nombre, telefono, direccion) VALUES
('70000000-1', 'Cementos Bío Bío', '+56220000001', 'Av. Central 100'),
('71000000-2', 'AceroCAP', '+56220000002', 'Parque Industrial 20'),
('72000000-3', 'Sodimac Constructor', '+56220000003', 'Ruta 5 Sur Km 10'),
('73000000-4', 'Easy Constructor', '+56220000004', 'Av. Norte 500'),
('74000000-5', 'Maderas Arauco', '+56220000005', 'Sector Forestal 1'),
('75000000-6', 'Pinturas Ceresita', '+56220000006', 'Av. Quilicura 900'),
('76000000-7', 'Electrónica Veto', '+56220000007', 'San Diego 1000'),
('77000000-8', 'Cerámicas Cordillera', '+56220000008', 'Lampa 400'),
('78000000-9', 'Ferretería Orellana', '+56220000009', 'Macul 300'),
('79000000-0', 'Áridos del Maipo', '+56220000010', 'San Bernardo 200'),
('80000000-1', 'Hormigones del Pacífico', '+56220000011', 'Av. Argentina 2500'),
('81000000-2', 'Drywall Chile', '+56220000012', 'Av. La Florida 9200'),
('82000000-3', 'Iluminación LED Pro', '+56220000013', 'Av. Irarrázaval 3456'),
('83000000-4', 'Grifería Moderna', '+56220000014', 'Av. Vicuña Mackenna 7800'),
('84000000-5', 'Pisos y Acabados', '+56220000015', 'Av. Las Condes 11200');

-- ------------------------------------------------------------
-- Materiales
-- ------------------------------------------------------------
INSERT INTO Materiales (nombre_material, unidad_medida) VALUES
('Cemento Melón', 'Saco 25kg'),
('Fierro Estriado 12mm', 'Tira 6m'),
('Ladrillo Princesa', 'Unidad'),
('Arena Gruesa', 'M3'),
('Pintura Latex Blanco', 'Tineta 20L'),
('Cable Cobre 2.5mm', 'Rollo 100m'),
('Madera Pino 2x4', 'Pieza 3.2m'),
('Cerámica 40x40', 'Caja 2m2'),
('Tubería PVC 110mm', 'Tira 6m'),
('Clavos 3 pulgadas', 'Caja 1kg'),
('Hormigón Premezclado', 'M3'),
('Placa Drywall', 'Unidad'),
('Luminaria LED', 'Unidad'),
('Grifería Estándar', 'Unidad'),
('Piso Flotante', 'Caja 2m2');

-- ------------------------------------------------------------
-- Asignación de Empleados a Proyectos (M:N con atributos)
-- ------------------------------------------------------------
INSERT INTO Asignacion_Empleados (id_proyecto, rut_empleado, rol, horas_trabajadas) VALUES
(1, '55555555-5', 'Jefe de Obra', 160),
(1, '11111111-1', 'Maestro Primera', 120),
(2, '22222222-2', 'Instalador', 200),
(3, '99999999-9', 'Supervisor Eléctrico', 150),
(3, '77777777-7', 'Ayudante', 100),
(4, '33333333-3', 'Maestro Carpintero', 80),
(5, '44444444-4', 'Jefe de Redes', 90),
(6, '66666666-6', 'Maestro Obra Gruesa', 220),
(7, '88888888-8', 'Carpintero Terminaciones', 110),
(1, '10101010-0', 'Plomero', 85),
(11, '16161616-5', 'Jefe de Obra', 175),
(11, '12121212-1', 'Electricista Jefe', 140),
(12, '13131313-2', 'Maestro Albañil', 190),
(13, '14141414-3', 'Carpintero', 95),
(14, '15151515-4', 'Plomero Jefe', 130),
(15, '55555555-5', 'Ingeniero Residente', 210),
(16, '66666666-6', 'Capataz', 155),
(17, '77777777-7', 'Electricista', 120),
(18, '88888888-8', 'Carpintero', 105),
(19, '99999999-9', 'Supervisor', 145),
(20, '10101010-0', 'Plomero', 115);

-- ------------------------------------------------------------
-- Uso de Materiales (M:N con atributos)
-- ------------------------------------------------------------
INSERT INTO Uso_Materiales (id_proyecto, id_material, rut_proveedor, cantidad, costo_unitario, fecha_registro) VALUES
(1, 1, '70000000-1', 500, 4500.00, '2023-02-01'),
(1, 2, '71000000-2', 1000, 6000.00, '2023-02-15'),
(2, 5, '75000000-6', 50, 35000.00, '2022-10-10'),
(3, 6, '76000000-7', 200, 45000.00, '2023-07-15'),
(3, 8, '77000000-8', 300, 12000.00, '2023-11-20'),
(4, 3, '72000000-3', 5000, 350.00, '2023-08-10'),
(5, 4, '79000000-0', 100, 15000.00, '2023-11-15'),
(6, 7, '74000000-5', 400, 3200.00, '2021-05-20'),
(7, 9, '73000000-4', 150, 8500.00, '2023-09-15'),
(8, 10, '78000000-9', 20, 2500.00, '2020-11-01'),
(11, 11, '80000000-1', 120, 75000.00, '2024-03-20'),
(11, 12, '81000000-2', 300, 15000.00, '2024-04-05'),
(12, 13, '82000000-3', 80, 45000.00, '2022-08-14'),
(13, 14, '83000000-4', 60, 38000.00, '2024-05-10'),
(14, 15, '84000000-5', 200, 22000.00, '2024-06-25'),
(15, 1, '70000000-1', 800, 4600.00, '2023-04-12'),
(16, 2, '71000000-2', 600, 6100.00, '2024-07-01'),
(17, 5, '75000000-6', 40, 36000.00, '2022-12-18'),
(18, 6, '76000000-7', 250, 46000.00, '2024-08-20'),
(19, 8, '77000000-8', 150, 12500.00, '2024-09-05'),
(20, 9, '73000000-4', 180, 8600.00, '2023-11-30');
