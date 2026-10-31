USE SistemaAgricola;
GO
 
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
