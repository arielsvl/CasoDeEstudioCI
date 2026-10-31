USE SistemaServicios;
GO

BEGIN TRANSACTION;

-- =============================================
-- 1. CLIENTE (5 registros)
-- =============================================
INSERT INTO Cliente
(id, nombre, fecha_registro, direccion, correo, telefono,
 estado_cliente, motivo_bloqueo, fecha_bloqueo)
VALUES
('11111111-1111-1111-1111-111111111111', 'Carlos Ramirez', '2026-01-10', 'Zona 1, Ciudad de Guatemala', 'carlos@example.com', '55551001', 1, NULL, NULL),
('22222222-2222-2222-2222-222222222222', 'Maria Lopez', '2026-01-15', 'Zona 10, Ciudad de Guatemala', 'maria@example.com', '55551002', 1, NULL, NULL),
('33333333-3333-3333-3333-333333333333', 'Jose Hernandez', '2026-02-01', 'Mixco, Guatemala', 'jose@example.com', '55551003', 1, NULL, NULL),
('44444444-4444-4444-4444-444444444444', 'Ana Morales', '2026-02-10', 'Villa Nueva, Guatemala', 'ana@example.com', '55551004', 0, 'Factura pendiente de pago', '2026-10-01'),
('55555555-5555-5555-5555-555555555555', 'Luis Castillo', '2026-03-05', 'Zona 7, Ciudad de Guatemala', 'luis@example.com', '55551005', 1, NULL, NULL);

-- =============================================
-- 2. TIPOSERVICIO (5 registros)
-- =============================================
INSERT INTO TipoServicio (nombre_tipo, modalidad)
VALUES
('Internet residencial', 'Mensual'),
('Internet empresarial', 'Mensual'),
('Television por cable', 'Mensual'),
('Telefonia fija', 'Mensual'),
('Soporte tecnico', 'Por evento');

-- =============================================
-- 3. SERVICIO (5 registros)
-- =============================================
INSERT INTO Servicio
(id_cliente, id_tipo, costo_mensual, direccion_instalacion)
VALUES
('11111111-1111-1111-1111-111111111111', 1, 199.00, 'Zona 1, Ciudad de Guatemala'),
('22222222-2222-2222-2222-222222222222', 2, 450.00, 'Zona 10, Ciudad de Guatemala'),
('33333333-3333-3333-3333-333333333333', 3, 125.00, 'Mixco, Guatemala'),
('44444444-4444-4444-4444-444444444444', 4, 85.00, 'Villa Nueva, Guatemala'),
('55555555-5555-5555-5555-555555555555', 5, 150.00, 'Zona 7, Ciudad de Guatemala');

-- =============================================
-- 4. FACTURA (5 registros)
-- =============================================
INSERT INTO Factura
(id_cliente, serie, fecha_emision, total, id_fel)
VALUES
('11111111-1111-1111-1111-111111111111', 'A-0001', '2026-10-01', 199.00, NEWID()),
('22222222-2222-2222-2222-222222222222', 'A-0002', '2026-10-02', 450.00, NEWID()),
('33333333-3333-3333-3333-333333333333', 'A-0003', '2026-10-03', 125.00, NEWID()),
('44444444-4444-4444-4444-444444444444', 'A-0004', '2026-10-04', 85.00, NEWID()),
('55555555-5555-5555-5555-555555555555', 'A-0005', '2026-10-05', 150.00, NEWID());

-- =============================================
-- 5. DETALLEFACTURA (5 registros)
-- =============================================
INSERT INTO DetalleFactura
(id_factura, id_servicio, tipo_servicio, descuento_aplicado, subtotal)
VALUES
(1, 1, 'Internet residencial', 0.00, 199.00),
(2, 2, 'Internet empresarial', 50.00, 450.00),
(3, 3, 'Television por cable', 0.00, 125.00),
(4, 4, 'Telefonia fija', 10.00, 85.00),
(5, 5, 'Soporte tecnico', 0.00, 150.00);

-- =============================================
-- 6. DESCUENTO (5 registros)
-- =============================================
INSERT INTO Descuento
(nombre, tipo_descuento, porcentaje, estado, fecha_inicio, fecha_fin)
VALUES
('Descuento de bienvenida', 'Porcentaje', 10.00, 1, '2026-01-01', '2026-12-31'),
('Descuento empresarial', 'Porcentaje', 15.00, 1, '2026-01-01', '2026-12-31'),
('Promocion de verano', 'Porcentaje', 20.00, 1, '2026-03-01', '2026-09-30'),
('Descuento especial', 'Porcentaje', 5.00, 1, '2026-01-01', NULL),
('Promocion antigua', 'Porcentaje', 25.00, 0, '2025-01-01', '2025-12-31');

-- =============================================
-- 7. DETALLEDESCUENTO (5 registros)
-- =============================================
INSERT INTO DetalleDescuento
(id_detalle_descuento, id_descuento, monto_aplicado)
VALUES
(1, 1, 19.90),
(2, 2, 50.00),
(3, 3, 25.00),
(4, 4, 10.00),
(5, 5, 37.50);

-- =============================================
-- 8. PAGO (5 registros)
-- =============================================
INSERT INTO Pago
(id_cliente, id_factura, fecha_pago, costo_mensual, metodo_pago, referencia)
VALUES
('11111111-1111-1111-1111-111111111111', 1, '2026-10-05', 199.00, 'Transferencia', 'TRX-10001'),
('22222222-2222-2222-2222-222222222222', 2, '2026-10-06', 450.00, 'Tarjeta', 'TRX-10002'),
('33333333-3333-3333-3333-333333333333', 3, '2026-10-07', 125.00, 'Efectivo', 'REC-10003'),
('44444444-4444-4444-4444-444444444444', 4, '2026-10-08', 85.00, 'Transferencia', 'TRX-10004'),
('55555555-5555-5555-5555-555555555555', 5, '2026-10-09', 150.00, 'Tarjeta', 'TRX-10005');

-- =============================================
-- 9. EMPLEADO (5 registros)
-- =============================================
INSERT INTO Empleado
(id, nombres, apellidos, dpi, puesto, fecha_contratacion,
 salario_base, telefono, correo, estado)
VALUES
('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', 'Pedro', 'Gomez', '1234567890101', 'Gerente', '2023-01-15', 12000.00, '55552001', 'pedro@example.com', 1),
('BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', 'Sofia', 'Perez', '1234567890102', 'Contadora', '2023-06-01', 8500.00, '55552002', 'sofia@example.com', 1),
('CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', 'Diego', 'Ramirez', '1234567890103', 'Tecnico', '2024-02-10', 6000.00, '55552003', 'diego@example.com', 1),
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', 'Laura', 'Mendez', '1234567890104', 'Recursos Humanos', '2024-05-20', 7500.00, '55552004', 'laura@example.com', 1),
('EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', 'Andres', 'Castro', '1234567890105', 'Soporte tecnico', '2025-01-05', 5500.00, '55552005', 'andres@example.com', 1);

-- =============================================
-- 10. NOMINA (5 registros)
-- =============================================
INSERT INTO Nomina
(id_empleado, fecha_pago, nomina_a_pagar, pasivo_laboral, cuota_igss, retencion_isr)
VALUES
('AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA', '2026-10-30', 12000.00, 1200.00, 581.40, 500.00),
('BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB', '2026-10-30', 8500.00, 850.00, 411.83, 200.00),
('CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC', '2026-10-30', 6000.00, 600.00, 290.40, 0.00),
('DDDDDDDD-DDDD-DDDD-DDDD-DDDDDDDDDDDD', '2026-10-30', 7500.00, 750.00, 363.00, 100.00),
('EEEEEEEE-EEEE-EEEE-EEEE-EEEEEEEEEEEE', '2026-10-30', 5500.00, 550.00, 266.20, 0.00);

COMMIT TRANSACTION;
GO

-- =============================================
-- VERIFICAR LOS REGISTROS
-- =============================================
SELECT 'Cliente' AS Tabla, COUNT(*) AS Total FROM Cliente
UNION ALL SELECT 'TipoServicio', COUNT(*) FROM TipoServicio
UNION ALL SELECT 'Servicio', COUNT(*) FROM Servicio
UNION ALL SELECT 'Factura', COUNT(*) FROM Factura
UNION ALL SELECT 'DetalleFactura', COUNT(*) FROM DetalleFactura
UNION ALL SELECT 'Descuento', COUNT(*) FROM Descuento
UNION ALL SELECT 'DetalleDescuento', COUNT(*) FROM DetalleDescuento
UNION ALL SELECT 'Pago', COUNT(*) FROM Pago
UNION ALL SELECT 'Empleado', COUNT(*) FROM Empleado
UNION ALL SELECT 'Nomina', COUNT(*) FROM Nomina;
GO