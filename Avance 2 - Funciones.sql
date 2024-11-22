-- Obtener total de una venta
CREATE FUNCTION FN_ObtenerTotalVenta(id_venta INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(precio * cantidad) INTO total FROM Ventas WHERE id_venta = id_venta;
    RETURN total;
END;

-- Obtener precio de un producto
CREATE FUNCTION FN_ObtenerPrecioProducto(id_producto INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE precio DECIMAL(10, 2);
    SELECT precio INTO precio FROM Productos WHERE id_producto = id_producto;
    RETURN precio;
END;

-- Obtener total de devoluciones de un producto
CREATE FUNCTION FN_ObtenerTotalDevoluciones(id_producto INT) RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Devoluciones WHERE id_producto = id_producto;
    RETURN total;
END;

-- Obtener stock disponible de un producto
CREATE FUNCTION FN_ObtenerStockDisponible(id_producto INT) RETURNS INT
BEGIN
    DECLARE stock INT;
    SELECT stock INTO stock FROM Productos WHERE id_producto = id_producto;
    RETURN stock;
END;

-- Obtener promedio de evaluación de un producto
CREATE FUNCTION FN_ObtenerPromedioEvaluacion(id_producto INT) RETURNS DECIMAL(5, 2)
BEGIN
    DECLARE promedio DECIMAL(5, 2);
    SELECT AVG(puntuacion) INTO promedio FROM Evaluaciones WHERE id_producto = id_producto;
    RETURN promedio;
END;

-- Obtener monto de un pago
CREATE FUNCTION FN_ObtenerMontoPago(id_pago INT) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE monto DECIMAL(10, 2);
    SELECT monto INTO monto FROM Pagos WHERE id_pago = id_pago;
    RETURN monto;
END;

-- Obtener total de ventas en un rango de fechas
CREATE FUNCTION FN_ObtenerTotalVentasPorMes(fecha_inicio DATE, fecha_fin DATE) RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(precio * cantidad) INTO total FROM Ventas WHERE fecha_venta BETWEEN fecha_inicio AND fecha_fin;
    RETURN total;
END;

-- Obtener cliente más frecuente
CREATE FUNCTION FN_ObtenerClienteMasFrecuente() RETURNS INT
BEGIN
    DECLARE id_cliente INT;
    SELECT id_cliente INTO id_cliente FROM Pedidos GROUP BY id_cliente ORDER BY COUNT(*) DESC LIMIT 1;
    RETURN id_cliente;
END;

-- Obtener estado de un pedido
CREATE FUNCTION FN_ObtenerEstadoPedido(id_pedido INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE estado VARCHAR(50);
    SELECT estado INTO estado FROM Pedidos WHERE id_pedido = id_pedido;
    RETURN estado;
END;

-- Obtener historial de ediciones de un registro
CREATE FUNCTION FN_ObtenerHistorialEdiciones(id_registro INT, tabla VARCHAR(50)) RETURNS TEXT
BEGIN
    DECLARE historial TEXT;
    SELECT GROUP_CONCAT(fecha_edicion, ': ', usuario_edito) INTO historial FROM Historial_Ediciones 
    WHERE id_registro = id_registro AND tabla = tabla;
    RETURN historial;
END;

-- Obtener total de inventario
CREATE FUNCTION FN_ObtenerTotalInventario() RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT SUM(stock) INTO total FROM Inventarios;
    RETURN total;
END;

-- Obtener total de pagos realizados
CREATE FUNCTION FN_ObtenerTotalPagos() RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(monto) INTO total FROM Pagos;
    RETURN total;
END;

-- Obtener total de productos en una categoría
CREATE FUNCTION FN_ObtenerTotalProductosPorCategoria(id_categoria INT) RETURNS INT
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM Productos_Categorias WHERE id_categoria = id_categoria;
    RETURN total;
END;

-- Obtener nombre de un usuario por ID
CREATE FUNCTION FN_ObtenerNombreUsuario(id_usuario INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE nombre VARCHAR(255);
    SELECT nombre INTO nombre FROM Usuarios WHERE id_usuario = id_usuario;
    RETURN nombre;
END;

-- Obtener datos de un proveedor
CREATE FUNCTION FN_ObtenerDatosProveedor(id_proveedor INT) RETURNS TEXT
BEGIN
    DECLARE datos TEXT;
    SELECT nombre, telefono, direccion INTO datos FROM Proveedores WHERE id_proveedor = id_proveedor;
    RETURN datos;
END;
