-- Reto #1
/*
SELECT * from articulo WHERE nombre LIKE '%Pasta%';
SELECT * from articulo WHERE nombre LIKE '%Cannelloni%';
SELECT * from articulo WHERE nombre LIKE '%-%';
SELECT * from puesto WHERE nombre LIKE '%Designer%';
SELECT * from puesto WHERE nombre LIKE '%Developer%';
*/
-- Reto #2
/*
SELECT avg(salario) AS salario_promedio FROM puesto;
SELECT count(*) AS número_de_pastas FROM articulo WHERE nombre LIKE '%pasta%';
SELECT min(salario) AS salario_mínimo, max(salario) AS salario_máximo FROM puesto;
SELECT sum(salario) AS salario_de_los_últimos_5_agregados FROM (SELECT salario FROM puesto ORDER BY id_puesto DESC LIMIT 5) AS derived;
*/
-- Reto #3
/*
SELECT nombre,count(*) AS cantidad FROM puesto GROUP BY nombre;
SELECT nombre, sum(salario) AS total_por_puesto FROM puesto  GROUP BY nombre;
SELECT id_empleado, count(*) AS número_de_ventas_por_empleado FROM venta GROUP BY id_empleado;
SELECT id_articulo, count(*) AS número_de_ventas_por_artículo FROM venta GROUP BY id_articulo;
*/