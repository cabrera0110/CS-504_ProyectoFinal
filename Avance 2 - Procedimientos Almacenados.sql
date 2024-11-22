-- Registrar un nuevo usuario
CREATE PROCEDURE SP_RegistrarUsuario(IN nombre VARCHAR(255), IN email VARCHAR(255), IN estado ENUM('activo', 'inactivo'))
BEGIN
    INSERT INTO Usuarios (nombre, email, fecha_registro, estado) 
    VALUES (nombre, email, NOW(), estado);
END;

-- Asignar rol a un usuario
CREATE PROCEDURE SP_AsignarRolUsuario(IN id_usuario INT, IN id_rol INT)
BEGIN
    INSERT INTO Usuarios_Roles (id_usuario, id_rol) 
    VALUES (id_usuario, id_rol);
END;

-- Eliminar usuario
CREATE PROCEDURE SP_EliminarUsuario(IN id_usuario INT)
BEGIN
    DELETE FROM Usuarios WHERE id_usuario = id_usuario;
END;

-- Registrar un nuevo producto
CREATE PROCEDURE SP_RegistrarProducto(IN nombre VARCHAR(255), IN descripcion TEXT, IN precio DECIMAL(10, 2), IN stock INT)
BEGIN
    INSERT INTO Productos (nombre, descripcion, precio, stock) 
    VALUES (nombre, descripcion, precio, stock);
END;

-- Actualizar stock de un producto
CREATE PROCEDURE SP_ActualizarStockProducto(IN id_producto INT, IN nuevo_stock INT)
BEGIN
    UPDATE Productos SET stock = nuevo_stock WHERE id_producto = id_producto;
END;

-- Eliminar producto
CREATE PROCEDURE SP_EliminarProducto(IN id_producto INT)
BEGIN
    DELETE FROM Productos WHERE id_producto = id_producto;
END;

-- Registrar una nueva venta
CREATE PROCEDURE SP_RegistrarVenta(IN id_usuario INT, IN id_producto INT, IN cantidad INT)
BEGIN
    INSERT INTO Ventas (id_usuario, id_producto, cantidad, fecha_venta) 
    VALUES (id_usuario, id_producto, cantidad, NOW());
END;

-- Registrar pago
CREATE PROCEDURE SP_RegistrarPago(IN id_venta INT, IN monto DECIMAL(10, 2), IN metodo_pago VARCHAR(50))
BEGIN
    INSERT INTO Pagos (id_venta, monto, fecha_pago, metodo_pago) 
    VALUES (id_venta, monto, NOW(), metodo_pago);
END;

-- Registrar devolución
CREATE PROCEDURE SP_RegistrarDevolucion(IN id_venta INT, IN motivo TEXT)
BEGIN
    INSERT INTO Devoluciones (id_venta, fecha_devolucion, motivo) 
    VALUES (id_venta, NOW(), motivo);
END;

-- Generar factura
CREATE PROCEDURE SP_GenerarFactura(IN id_venta INT)
BEGIN
    INSERT INTO Facturas (id_venta, total, fecha_emision) 
    VALUES (id_venta, (SELECT SUM(precio * cantidad) FROM Ventas WHERE id_venta = id_venta), NOW());
END;

-- Calcular descuento
CREATE PROCEDURE SP_CalcularDescuento(IN id_producto INT, IN porcentaje DECIMAL(5, 2))
BEGIN
    UPDATE Productos SET precio = precio * (1 - porcentaje / 100) WHERE id_producto = id_producto;
END;

-- Generar reporte de ventas
CREATE PROCEDURE SP_GenerarReporteVentas(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT * FROM Ventas WHERE fecha_venta BETWEEN fecha_inicio AND fecha_fin;
END;

-- Actualizar producto
CREATE PROCEDURE SP_ActualizarProducto(IN id_producto INT, IN nombre VARCHAR(255), IN descripcion TEXT, IN precio DECIMAL(10, 2))
BEGIN
    UPDATE Productos SET nombre = nombre, descripcion = descripcion, precio = precio WHERE id_producto = id_producto;
END;

-- Eliminar proveedor
CREATE PROCEDURE SP_EliminarProveedor(IN id_proveedor INT)
BEGIN
    DELETE FROM Proveedores WHERE id_proveedor = id_proveedor;
END;

-- Registrar categoría
CREATE PROCEDURE SP_RegistrarCategoria(IN nombre VARCHAR(255))
BEGIN
    INSERT INTO Categorias (nombre) VALUES (nombre);
END;

-- Asignar categoría a producto
CREATE PROCEDURE SP_AsignarCategoriaProducto(IN id_producto INT, IN id_categoria INT)
BEGIN
    INSERT INTO Productos_Categorias (id_producto, id_categoria) VALUES (id_producto, id_categoria);
END;

-- Eliminar categoría
CREATE PROCEDURE SP_EliminarCategoria(IN id_categoria INT)
BEGIN
    DELETE FROM Categorias WHERE id_categoria = id_categoria;
END;

-- Registrar evaluación
CREATE PROCEDURE SP_RegistrarEvaluacion(IN id_producto INT, IN id_cliente INT, IN puntuacion INT, IN comentarios TEXT)
BEGIN
    INSERT INTO Evaluaciones (id_producto, id_cliente, puntuacion, comentarios) 
    VALUES (id_producto, id_cliente, puntuacion, comentarios);
END;

-- Generar reporte de devoluciones
CREATE PROCEDURE SP_GenerarReporteDevoluciones(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT * FROM Devoluciones WHERE fecha_devolucion BETWEEN fecha_inicio AND fecha_fin;
END;

-- Actualizar envío
CREATE PROCEDURE SP_ActualizarEnvio(IN id_envio INT, IN fecha_envio DATE)
BEGIN
    UPDATE Envíos SET fecha_envio = fecha_envio WHERE id_envio = id_envio;
END;

--  Generar reporte de pedidos
CREATE PROCEDURE SP_GenerarReportePedidos(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    SELECT * FROM Pedidos WHERE fecha_pedido BETWEEN fecha_inicio AND fecha_fin;
END;

-- Registrar historial de edición
CREATE PROCEDURE SP_RegistrarHistorialEdicion(IN tabla VARCHAR(50), IN id_registro INT, IN usuario_edito INT)
BEGIN
    INSERT INTO Historial_Ediciones (tabla, id_registro, fecha_edicion, usuario_edito) 
    VALUES (tabla, id_registro, NOW(), usuario_edito);
END;

-- Actualizar estado de pedido
CREATE PROCEDURE SP_ActualizarEstadoPedido(IN id_pedido INT, IN estado VARCHAR(50))
BEGIN
    UPDATE Pedidos SET estado = estado WHERE id_pedido = id_pedido;
END;

-- Registrar notificación
CREATE PROCEDURE SP_RegistrarNotificacion(IN id_usuario INT, IN mensaje TEXT)
BEGIN
    INSERT INTO Notificaciones (id_usuario, mensaje, fecha_emision, estado) 
    VALUES (id_usuario, mensaje, NOW(), 'pendiente');
END;

-- Generar reporte de inventarios
CREATE PROCEDURE SP_GenerarReporteInventarios()
BEGIN
    SELECT * FROM Inventarios;
END;
