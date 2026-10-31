USE SistemaAgricola;
GO
-- 1. Top 10 de clientes que tienen mayor peso bruto generado por producto y por mes durante el año 2014
SELECT TOP 10
    c.cliente AS nombre_cliente,
    c.direccion,
    c.nit,
    p.producto AS nombre_producto,
    SUM(e.pbruto) AS pbruto,
    MONTH(e.fecha) AS mes,
    YEAR(e.fecha) AS anio
FROM Envio e
INNER JOIN Cliente c
    ON e.codcliente = c.codcliente
INNER JOIN Producto p
    ON e.codproducto = p.codproducto
WHERE e.fecha >= '20140101'
  AND e.fecha < '20150101'
GROUP BY
    c.cliente,
    c.direccion,
    c.nit,
    p.producto,
    YEAR(e.fecha),
    MONTH(e.fecha)
ORDER BY
    SUM(e.pbruto) DESC;

--2. Generar un detalle por finca del número[conteo] de transacciones[envios] mensuales
--durante el primer semestre del 2015, excluir aquellos conteos inferiores a 100, ordenar
--por finca.

SELECT
    f.finca AS nombre_finca,
    em.empresa AS nombre_empresa,
    COUNT(e.idenvio) AS total_transacciones,
    MONTH(e.fecha) AS mes,
    YEAR(e.fecha) AS anio
FROM Envio e
INNER JOIN Finca f
    ON e.codempresa = f.codempresa
   AND e.codfinca = f.codfinca
INNER JOIN Empresa em
    ON f.codempresa = em.codempresa
WHERE e.fecha >= '20150101'
  AND e.fecha < '20150701'
GROUP BY
    f.finca,
    em.empresa,
    YEAR(e.fecha),
    MONTH(e.fecha)
HAVING COUNT(e.idenvio) >= 100
ORDER BY
    f.finca ASC,
    YEAR(e.fecha),
    MONTH(e.fecha);