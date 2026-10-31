USE SistemaAgricola;
GO

INSERT INTO Empresa (codempresa, empresa, nit, direccion)
VALUES
('EMP001', 'Agroindustria del Norte', '1234567-1', 'Guatemala'),
('EMP002', 'Exportadora La Ceiba', '1234567-2', 'Escuintla'),
('EMP003', 'Agricola San Jose', '1234567-3', 'Santa Rosa'),
('EMP004', 'Agropecuaria El Valle', '1234567-4', 'Suchitepequez'),
('EMP005', 'Productos del Campo', '1234567-5', 'Retalhuleu'),
('EMP006', 'Agroexportadora Maya', '1234567-6', 'Izabal'),
('EMP007', 'Fincas Unidas', '1234567-7', 'Petén'),
('EMP008', 'Cultivos del Sur', '1234567-8', 'Jutiapa'),
('EMP009', 'Agroindustrial Central', '1234567-9', 'Chimaltenango'),
('EMP010', 'Exportaciones Verdes', '1234567-10', 'Alta Verapaz'),
('EMP011', 'Agricola Primavera', '1234567-11', 'Baja Verapaz'),
('EMP012', 'Campos Fertiles', '1234567-12', 'Quetzaltenango'),
('EMP013', 'Agropecuaria Oriental', '1234567-13', 'Zacapa'),
('EMP014', 'Finca Dorada', '1234567-14', 'Chiquimula'),
('EMP015', 'Corporacion Agricola', '1234567-15', 'San Marcos');
GO

INSERT INTO Cliente (codcliente, cliente, direccion, nit)
VALUES
('CLI001', 'Carlos Ramirez', 'Zona 1, Guatemala', '1111111-1'),
('CLI002', 'Maria Lopez', 'Zona 2, Guatemala', '1111111-2'),
('CLI003', 'Jose Hernandez', 'Escuintla', '1111111-3'),
('CLI004', 'Ana Morales', 'Santa Rosa', '1111111-4'),
('CLI005', 'Pedro Castillo', 'Suchitepequez', '1111111-5'),
('CLI006', 'Luis Gomez', 'Retalhuleu', '1111111-6'),
('CLI007', 'Sofia Perez', 'Izabal', '1111111-7'),
('CLI008', 'Miguel Torres', 'Petén', '1111111-8'),
('CLI009', 'Laura Diaz', 'Jutiapa', '1111111-9'),
('CLI010', 'Juan Flores', 'Chimaltenango', '1111111-10'),
('CLI011', 'Elena Garcia', 'Alta Verapaz', '1111111-11'),
('CLI012', 'Diego Reyes', 'Baja Verapaz', '1111111-12'),
('CLI013', 'Andrea Cruz', 'Quetzaltenango', '1111111-13'),
('CLI014', 'Roberto Mendez', 'Zacapa', '1111111-14'),
('CLI015', 'Patricia Santos', 'San Marcos', '1111111-15');
GO

INSERT INTO Producto (codproducto, producto, codlocalidad, laboratorio)
VALUES
('PROD001', 'Cafe', 'LOC001', 'LAB001'),
('PROD002', 'Caña de azucar', 'LOC002', 'LAB002'),
('PROD003', 'Banano', 'LOC003', 'LAB003'),
('PROD004', 'Cardamomo', 'LOC004', 'LAB004'),
('PROD005', 'Cacao', 'LOC005', 'LAB005'),
('PROD006', 'Maiz', 'LOC006', 'LAB006'),
('PROD007', 'Frijol', 'LOC007', 'LAB007'),
('PROD008', 'Arroz', 'LOC008', 'LAB008'),
('PROD009', 'Ajonjoli', 'LOC009', 'LAB009'),
('PROD010', 'Palma africana', 'LOC010', 'LAB010'),
('PROD011', 'Hule', 'LOC011', 'LAB011'),
('PROD012', 'Aguacate', 'LOC012', 'LAB012'),
('PROD013', 'Mango', 'LOC013', 'LAB013'),
('PROD014', 'Piña', 'LOC014', 'LAB014'),
('PROD015', 'Papaya', 'LOC015', 'LAB015');
GO

INSERT INTO Finca (codempresa, codfinca, finca)
VALUES
('EMP001', 'FIN001', 'Finca El Paraiso'),
('EMP002', 'FIN002', 'Finca La Esperanza'),
('EMP003', 'FIN003', 'Finca San Jose'),
('EMP004', 'FIN004', 'Finca El Valle'),
('EMP005', 'FIN005', 'Finca Las Flores'),
('EMP006', 'FIN006', 'Finca El Rosario'),
('EMP007', 'FIN007', 'Finca Los Pinos'),
('EMP008', 'FIN008', 'Finca El Carmen'),
('EMP009', 'FIN009', 'Finca La Union'),
('EMP010', 'FIN010', 'Finca Primavera'),
('EMP011', 'FIN011', 'Finca El Retiro'),
('EMP012', 'FIN012', 'Finca Santa Maria'),
('EMP013', 'FIN013', 'Finca El Progreso'),
('EMP014', 'FIN014', 'Finca El Horizonte'),
('EMP015', 'FIN015', 'Finca Los Laureles');
GO

INSERT INTO Envio (
    codenvio,
    codcliente,
    codempresa,
    codfinca,
    codproducto,
    fecha,
    pbruto
)
VALUES
('ENV001', 'CLI001', 'EMP001', 'FIN001', 'PROD001', '20140115', 1500.00),
('ENV002', 'CLI002', 'EMP002', 'FIN002', 'PROD002', '20140210', 2500.00),
('ENV003', 'CLI003', 'EMP003', 'FIN003', 'PROD003', '20140312', 3500.00),
('ENV004', 'CLI004', 'EMP004', 'FIN004', 'PROD004', '20140418', 4500.00),
('ENV005', 'CLI005', 'EMP005', 'FIN005', 'PROD005', '20140520', 5500.00),
('ENV006', 'CLI006', 'EMP006', 'FIN006', 'PROD006', '20140615', 6500.00),
('ENV007', 'CLI007', 'EMP007', 'FIN007', 'PROD007', '20140710', 7500.00),
('ENV008', 'CLI008', 'EMP008', 'FIN008', 'PROD008', '20140812', 8500.00),
('ENV009', 'CLI009', 'EMP009', 'FIN009', 'PROD009', '20140918', 9500.00),
('ENV010', 'CLI010', 'EMP010', 'FIN010', 'PROD010', '20141020', 10500.00),
('ENV011', 'CLI011', 'EMP011', 'FIN011', 'PROD011', '20141115', 11500.00),
('ENV012', 'CLI012', 'EMP012', 'FIN012', 'PROD012', '20141210', 12500.00),
('ENV013', 'CLI001', 'EMP001', 'FIN001', 'PROD001', '20150115', 1800.00),
('ENV014', 'CLI001', 'EMP001', 'FIN001', 'PROD001', '20150215', 2200.00),
('ENV015', 'CLI001', 'EMP001', 'FIN001', 'PROD001', '20150315', 3000.00);
GO

DECLARE @i INT = 1;
DECLARE @mes INT = 1;
DECLARE @dia INT;

WHILE @mes <= 6
BEGIN
    SET @i = 1;

    WHILE @i <= 100
    BEGIN
        SET @dia = ((@i - 1) % 28) + 1;

        INSERT INTO Envio (
            codenvio,
            codcliente,
            codempresa,
            codfinca,
            codproducto,
            fecha,
            pbruto
        )
        VALUES (
            CONCAT(
                'GEN',
                RIGHT('000000' + CAST(
                    ((@mes - 1) * 100 + @i)
                    AS VARCHAR(6)
                ), 6)
            ),
            'CLI001',
            'EMP001',
            'FIN001',
            'PROD001',
            DATEFROMPARTS(2015, @mes, @dia),
            1000.00 + @i
        );

        SET @i = @i + 1;
    END;

    SET @mes = @mes + 1;
END;
GO

SELECT * FROM Envio;