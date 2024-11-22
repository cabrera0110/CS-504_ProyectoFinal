-- Vista de productos con su stock
CREATE VIEW VW_ProductosStock AS
SELECT id_producto, nombre, precio, stock FROM Productos;

-- Vista de ventas por cliente
CREATE VIEW VW_VentasPorCliente AS
SELECT v.id_usuario, u.nombre AS cliente, SUM(v.precio * v.cantidad) AS total_venta
FROM Ventas v
JOIN Usuarios u ON v.id_usuario = u.id_usuario
GROUP BY v.id_usuario;

-- Vista de productos en cada categoria
CREATE VIEW VW_ProductosPorCategoria AS
SELECT p.id_producto, p.nombre AS producto, c.nombre AS categoria
FROM Productos p
JOIN Productos_Categorias pc ON p.id_producto = pc.id_producto
JOIN Categorias c ON pc.id_categoria = c.id_categoria;

-- Vista de clientes que han hecho compras
CREATE VIEW VW_ClientesQueHanComprado AS
SELECT DISTINCT id_usuario FROM Ventas;

-- Vista de reportes de ventas por fecha
CREATE VIEW VW_ReportesVentas AS
SELECT id_venta, id_usuario, id_producto, cantidad, fecha_venta FROM Ventas;

-- Vista de historial de ediciones de registros
CREATE VIEW VW_HistorialEdiciones AS
SELECT * FROM Historial_Ediciones;

-- Vista de inventarios con nombres de productos
CREATE VIEW VW_InventariosConNombre AS
SELECT p.nombre, i.stock FROM Inventarios i
JOIN Productos p ON i.id_producto = p.id_producto;

-- Vista de total de pagos realizados por usuario
CREATE VIEW VW_TotalPagosPorUsuario AS
SELECT id_usuario, SUM(monto) AS total_pagos FROM Pagos GROUP BY id_usuario;

-- Vista de productos mas vendidos
CREATE VIEW VW_ProductosMasVendidos AS
SELECT p.nombre, SUM(v.cantidad) AS cantidad_vendida
FROM Ventas v
JOIN Productos p ON v.id_producto = p.id_producto
GROUP BY p.id_producto
ORDER BY cantidad_vendida DESC;

-- Vista de inventarios bajos (por ejemplo, stock menor a 10)
CREATE VIEW VW_InventariosBajos AS
SELECT p.nombre, i.stock
FROM Inventarios i
JOIN Productos p ON i.id_producto = p.id_producto
WHERE i.stock < 10;
