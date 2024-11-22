-- Insertar un cliente
CREATE PROCEDURE sp_InsertarCliente(
    IN p_NombreCliente VARCHAR(30),
    IN p_CorreoCliente VARCHAR(30),
    IN p_TelefonoCliente VARCHAR(30),
    IN p_DireccionCliente VARCHAR(100),
    IN p_NumeroCasillero INT
)
BEGIN
    INSERT INTO Cliente (NombreCliente, CorreoCliente, TelefonoCliente, DireccionCliente, NumeroCasillero)
    VALUES (p_NombreCliente, p_CorreoCliente, p_TelefonoCliente, p_DireccionCliente, p_NumeroCasillero);
END;

-- Actualizar los datos de un cliente
CREATE PROCEDURE sp_ActualizarCliente(
    IN p_IDCliente INT,
    IN p_NombreCliente VARCHAR(30),
    IN p_CorreoCliente VARCHAR(30),
    IN p_TelefonoCliente VARCHAR(30),
    IN p_DireccionCliente VARCHAR(100),
    IN p_NumeroCasillero INT
)
BEGIN
    UPDATE Cliente
    SET NombreCliente = p_NombreCliente,
        CorreoCliente = p_CorreoCliente,
        TelefonoCliente = p_TelefonoCliente,
        DireccionCliente = p_DireccionCliente,
        NumeroCasillero = p_NumeroCasillero
    WHERE IDCliente = p_IDCliente;
END;

-- Eliminar un cliente
CREATE PROCEDURE sp_EliminarCliente(
    IN p_IDCliente INT
)
BEGIN
    DELETE FROM Cliente WHERE IDCliente = p_IDCliente;
END;

-- Almacenar para obtener todos los paquetes de un cliente
CREATE PROCEDURE sp_ObtenerPaquetesPorCliente(
    IN p_IDCliente INT
)
BEGIN
    SELECT p.IDPaquete, p.Descripcion, p.ValorDeclarado, p.PesoPaquete, p.EstadoPaquete, p.FechaRecepcion, p.FechaEntrega
    FROM Paquete p
    JOIN Casillero c ON p.IDCliente = c.IDCliente
    WHERE c.IDCliente = p_IDCliente;
END;

-- Insertar un casillero
CREATE PROCEDURE sp_InsertarCasillero(
    IN p_IDCliente INT,
    IN p_DireccionCasillero VARCHAR(100)
)
BEGIN
    INSERT INTO Casillero (IDCliente, DireccionCasillero)
    VALUES (p_IDCliente, p_DireccionCasillero);
END;

-- Obtener los detalles de un paquete
CREATE PROCEDURE sp_ObtenerPaqueteDetalle(
    IN p_IDPaquete INT
)
BEGIN
    SELECT * FROM Paquete WHERE IDPaquete = p_IDPaquete;
END;

-- Actualizar el estado de un paquete
CREATE PROCEDURE sp_ActualizarEstadoPaquete(
    IN p_IDPaquete INT,
    IN p_NuevoEstado VARCHAR(30)
)
BEGIN
    UPDATE Paquete
    SET EstadoPaquete = p_NuevoEstado
    WHERE IDPaquete = p_IDPaquete;
END;

-- Obtener todas las facturas de un cliente
CREATE PROCEDURE sp_ObtenerFacturasPorCliente(
    IN p_IDCliente INT
)
BEGIN
    SELECT f.IDFactura, f.MontoTotal, f.Fecha, f.EstadoPago, f.MetodoPago
    FROM Factura f
    WHERE f.IDUsuario = p_IDCliente;
END;

-- Insertar una factura
CREATE PROCEDURE sp_InsertarFactura(
    IN p_IDUsuario INT,
    IN p_MontoTotal DOUBLE,
    IN p_Fecha DATE,
    IN p_EstadoPago VARCHAR(30),
    IN p_MetodoPago VARCHAR(30)
)
BEGIN
    INSERT INTO Factura (IDUsuario, MontoTotal, Fecha, EstadoPago, MetodoPago)
    VALUES (p_IDUsuario, p_MontoTotal, p_Fecha, p_EstadoPago, p_MetodoPago);
END;

-- Actualizar el estado de pago de una factura
CREATE PROCEDURE sp_ActualizarEstadoPagoFactura(
    IN p_IDFactura INT,
    IN p_EstadoPago VARCHAR(30)
)
BEGIN
    UPDATE Factura
    SET EstadoPago = p_EstadoPago
    WHERE IDFactura = p_IDFactura;
END;

-- Insertar una prealerta
CREATE PROCEDURE sp_InsertarPrealerta(
    IN p_IDPaquete INT,
    IN p_FechaEnvio DATE,
    IN p_Courier VARCHAR(50),
    IN p_NumeroRastro INT,
    IN p_CostoTraida DOUBLE
)
BEGIN
    INSERT INTO Prealerta (IDPaquete, FechaEnvio, Courier, NumeroRastro, CostoTraida)
    VALUES (p_IDPaquete, p_FechaEnvio, p_Courier, p_NumeroRastro, p_CostoTraida);
END;

-- Obtener una notificación por ID
CREATE PROCEDURE sp_ObtenerNotificacion(
    IN p_IDNotificacion INT
)
BEGIN
    SELECT * FROM Notificaciones WHERE IDNotificacion = p_IDNotificacion;
END;

-- Obtener todas las notificaciones de un paquete
CREATE PROCEDURE sp_ObtenerNotificacionesPorPaquete(
    IN p_IDPaquete INT
)
BEGIN
    SELECT * FROM Notificaciones WHERE IDPaquete = p_IDPaquete;
END;

-- Eliminar una notificación
CREATE PROCEDURE sp_EliminarNotificacion(
    IN p_IDNotificacion INT
)
BEGIN
    DELETE FROM Notificaciones WHERE IDNotificacion = p_IDNotificacion;
END;

-- Eliminar un paquete
CREATE PROCEDURE sp_EliminarPaquete(
    IN p_IDPaquete INT
)
BEGIN
    DELETE FROM Paquete WHERE IDPaquete = p_IDPaquete;
END;

-- Eliminar una prealerta
CREATE PROCEDURE sp_EliminarPrealerta(
    IN p_IDPrealerta INT
)
BEGIN
    DELETE FROM Prealerta WHERE IDPrealerta = p_IDPrealerta;
END;

-- Obtener la cantidad de paquetes en un casillero
CREATE PROCEDURE sp_ObtenerCantidadPaquetesEnCasillero(
    IN p_IDCasillero INT
)
BEGIN
    SELECT COUNT(*) 
    FROM Paquete
    WHERE IDCasillero = p_IDCasillero;
END;

-- Obtener todos los clientes
CREATE PROCEDURE sp_ObtenerClientes()
BEGIN
    SELECT * FROM Cliente;
END;

-- Obtener todos los casilleros
CREATE PROCEDURE sp_ObtenerCasilleros()
BEGIN
    SELECT * FROM Casillero;
END;

-- Obtener todas las facturas
CREATE PROCEDURE sp_ObtenerFacturas()
BEGIN
    SELECT * FROM Factura;
END;

-- Obtener todas las prealertas
CREATE PROCEDURE sp_ObtenerPrealertas()
BEGIN
    SELECT * FROM Prealerta;
END;

-- Obtener todas las notificaciones
CREATE PROCEDURE sp_ObtenerNotificaciones()
BEGIN
    SELECT * FROM Notificaciones;
END;

-- Obtener el total de la factura de un cliente
CREATE PROCEDURE sp_ObtenerTotalFacturaCliente(
    IN p_IDCliente INT
)
BEGIN
    SELECT SUM(MontoTotal) AS TotalFactura
    FROM Factura
    WHERE IDUsuario = p_IDCliente;
END;