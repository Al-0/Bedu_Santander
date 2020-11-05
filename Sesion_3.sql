-- Reto #1
-- SELECT nombre, apellido_paterno FROM empleado WHERE id_puesto IN (SELECT id_puesto FROM puesto WHERE salario < 100000); 
/*
SELECT id_empleado, min(cantidad), max(cantidad) FROM 
(SELECT id_empleado, clave, count(*) as cantidad FROM venta GROUP BY clave, id_empleado) as subconsulta
GROUP BY id_empleado ORDER BY id_empleado;
*/
-- SELECT clave as claves_con_articulos_mayores_a_5000, id_articulo FROM venta WHERE id_articulo IN (SELECT id_articulo FROM articulo WHERE precio > 5000);

-- Reto #2
-- SELECT clave, nombre, apellido_paterno FROM empleado AS e JOIN venta AS v ON e.id_empleado = v.id_empleado ORDER BY clave;
-- SELECT clave, nombre FROM venta AS v JOIN articulo AS a ON a.id_articulo = v.id_articulo ORDER BY clave;
-- SELECT clave, round(sum(precio), 2) as total FROM venta AS v JOIN articulo AS a ON v.id_articulo = a.id_articulo GROUP BY clave ORDER BY clave;

-- Reto #3
/*
CREATE VIEW Puestos_por_empleado_110 AS
(SELECT concat(e.nombre,' ', e.apellido_paterno) AS Empleado, p.nombre AS puesto FROM empleado AS e JOIN puesto AS p ON e.id_puesto = p.id_puesto);
SELECT * FROM Puestos_por_empleado_110;
*/
/*
CREATE VIEW venta_articulo_x_empleado_110 AS
(SELECT clave, concat(e.nombre,' ', e.apellido_paterno) AS Empleado, a.nombre AS Artículo 
FROM empleado AS e
JOIN venta AS v
ON e.id_empleado = v.id_empleado
JOIN articulo AS a
ON v.id_articulo = a.id_articulo ORDER BY clave);
SELECT * FROM venta_articulo_x_empleado_110;
*/
/*
CREATE VIEW Ventas_x_puesto_110 AS
(SELECT p.nombre as Puesto, count(*) AS ventas
FROM venta AS v JOIN empleado AS e ON v.id_empleado = e.id_empleado JOIN puesto AS p ON p.id_puesto = e.id_puesto
GROUP BY p.nombre ORDER BY ventas DESC);
SELECT * FROM Ventas_x_puesto_110 LIMIT 1;
*/