--CONSULTA 1--
USE ventas_tech_db
SELECT 
MONTH (fecha_venta) as 'Mes',
SUM (cantidad*precio_unitario) as 'Total Facturado',
COUNT (id_venta) as 'Cantidad de Pedidos',
AVG (cantidad*precio_unitario) as 'Ticket Promedio'
FROM ventas
GROUP BY MONTH (fecha_venta)
ORDER BY MONTH (fecha_venta)

--CONSULTA 2--
USE ventas_tech_db
SELECT
TOP (5) id_producto,
SUM (cantidad*precio_unitario) as 'Total Facturado',
SUM (cantidad) as 'Total Unidades'
FROM ventas
GROUP BY id_producto 
ORDER BY SUM (cantidad*precio_unitario) DESC

--CONSULTA 3--
Use ventas_tech_db
SELECT id_cliente,
SUM (cantidad*precio_unitario) as 'Total Facturado',
COUNT (*) as 'Cantidad de Pedidos'
FROM ventas
GROUP BY id_cliente 
HAVING COUNT(*) > 1

--CONSULTA 4--
USE ventas_tech_db
SELECT
MONTH(fecha_venta) AS 'Mes',
SUM(cantidad * precio_unitario) AS 'Total Facturado',
CASE WHEN SUM(cantidad * precio_unitario) > (
SELECT AVG(Total_Mensual)
FROM (
SELECT SUM(cantidad * precio_unitario) AS Total_Mensual
FROM ventas
GROUP BY MONTH(fecha_venta)
) AS Promedios
)
THEN 'Por encima'
ELSE 'Por debajo'
END AS 'Comparación'
FROM ventas
GROUP BY MONTH(fecha_venta)

--COMENTARIOS DE ANALISIS--
-- El producto 1 fue el que más se facturó.--
-- El total facturado en el mes de marzo fue de $6444.--
-- En el mes de marzo se facturó por debajo del promedio mensual.--
-- El cliente que más gastó fue el 1.--