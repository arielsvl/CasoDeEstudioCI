USE SistemaServicios;

CREATE OR ALTER PROCEDURE sp_CalcularDescuentoPaquete
    @IdCliente UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TieneCable BIT = 0;
    DECLARE @TieneInternet BIT = 0;
    DECLARE @Subtotal DECIMAL(10,2) = 0;
    DECLARE @Descuento DECIMAL(10,2) = 0;

    SELECT
        @Subtotal = COALESCE(SUM(s.costo_mensual), 0),
        @TieneCable = MAX(
            CASE WHEN LOWER(t.nombre_tipo) LIKE '%cable%'
                 THEN 1 ELSE 0 END
        ),
        @TieneInternet = MAX(
            CASE WHEN LOWER(t.nombre_tipo) LIKE '%internet%'
                 THEN 1 ELSE 0 END
        )
    FROM Servicio s
    INNER JOIN TipoServicio t ON t.id = s.id_tipo
    WHERE s.id_cliente = @IdCliente;

    IF @TieneCable = 1 AND @TieneInternet = 1
        SET @Descuento = @Subtotal * 0.10;

    SELECT
        @Subtotal AS subtotal,
        @Descuento AS descuento,
        @Subtotal - @Descuento AS total_mensual;
END;

SELECT
    SCHEMA_NAME(schema_id) AS esquema,
    name AS procedimiento
FROM sys.procedures
ORDER BY esquema, procedimiento;

EXEC sp_helptext 'sp_CalcularDescuentoPaquete';