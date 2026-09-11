-- CONSULTA 1 --

SELECT
    v.fecha_venta AS fecha,
    c.id_cliente AS identificacion_cliente,
    c.nombre AS cliente,
    c.ciudad,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v

INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente

INNER JOIN productos AS p
    ON v.id_producto = p.id_producto

INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria;
GO


-- CONSULTA 2 --

SELECT
    c.nombre,
    c.email,
    c.fecha
FROM clientes AS c

LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente

WHERE v.id_cliente IS NULL;

-- CONSULTA 3 --

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p

LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto

INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria

WHERE v.id_producto IS NULL;

-- CONSULTA 4 --

SELECT
    canal,
    SUM(total) AS total_ventas
FROM
(
    SELECT
        fecha_venta AS fecha,
        (cantidad * precio_unitario) AS total,
        'Periodo 1' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta AS fecha,
        (cantidad * precio_unitario) AS total,
        'Periodo 2' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS consolidado

GROUP BY canal;