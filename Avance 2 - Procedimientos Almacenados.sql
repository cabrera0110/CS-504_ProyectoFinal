-- Procedimiento para registrar un nuevo cliente
CREATE PROCEDURE RegistrarCliente(
    IN _NombreCliente VARCHAR(100), 
    IN _DireccionCliente VARCHAR(255), 
    IN _TelefonoCliente VARCHAR(20), 
    IN _CorreoCliente VARCHAR(100)
)
BEGIN
    INSERT INTO Cliente (NombreCliente, DireccionCliente, TelefonoCliente, CorreoCliente)
    VALUES (_NombreCliente, _DireccionCliente, _TelefonoCliente, _CorreoCliente);
END;

-- Procedimiento para registrar un paquete
CREATE PROCEDURE RegistrarPaquete(
    IN _IDCliente INT, 
    IN _Descripcion VARCHAR(255), 
    IN _PesoPaquete DOUBLE, 
    IN _EstadoPaquete VARCHAR(30)
)
BEGIN
    INSERT INTO Paquete (IDCliente, Descripcion, PesoPaquete, EstadoPaquete, FechaRecepcion)
    VALUES (_IDCliente, _Descripcion, _PesoPaquete, _EstadoPaquete, NOW());
END;

-- Procedimiento para actualizar el estado de un paquete
CREATE PROCEDURE ActualizarEstadoPaquete(
    IN _IDPaquete INT, 
    IN _NuevoEstado VARCHAR(30)
)
BEGIN
    UPDATE Paquete SET EstadoPaquete = _NuevoEstado WHERE IDPaquete = _IDPaquete;
END;

-- Procedimiento para asignar una factura a un paquete
CREATE PROCEDURE AsignarFacturaAPaquete(
    IN _IDFactura INT, 
    IN _IDPaquete INT
)
BEGIN
    INSERT INTO Factura_Paquete (IDFactura, IDPaquete) VALUES (_IDFactura, _IDPaquete);
END;

-- Procedimiento para registrar una nueva factura
CREATE PROCEDURE RegistrarFactura(
    IN _IDCliente INT, 
    IN _MontoTotal DOUBLE, 
    IN _MetodoPago VARCHAR(30)
)
BEGIN
    INSERT INTO Factura (IDUsuario, MontoTotal, EstadoPago, MetodoPago, Fecha)
    VALUES (_IDCliente, _MontoTotal, 'Pendiente', _MetodoPago, NOW());
END;

-- Procedimiento para generar una prealerta para un paquete
CREATE PROCEDURE GenerarPrealerta(
    IN _IDPaquete INT, 
    IN _Courier VARCHAR(50), 
    IN _NumeroRastro VARCHAR(50), 
    IN _CostoTraida DOUBLE
)
BEGIN
    INSERT INTO Prealerta (IDPaquete, Courier, NumeroRastro, CostoTraida, FechaEnvio)
    VALUES (_IDPaquete, _Courier, _NumeroRastro, _CostoTraida, NOW());
END;

-- Procedimiento para registrar un casillero
CREATE PROCEDURE RegistrarCasillero(
    IN _IDCliente INT, 
    IN _DireccionCasillero VARCHAR(255)
)
BEGIN
    INSERT INTO Casillero (IDCliente, DireccionCasillero)
    VALUES (_IDCliente, _DireccionCasillero);
END;

-- Procedimiento para actualizar la fecha de entrega de un paquete
CREATE PROCEDURE ActualizarFechaEntregaPaquete(
    IN _IDPaquete INT, 
    IN _FechaEntrega DATE
)
BEGIN
    UPDATE Paquete SET FechaEntrega = _FechaEntrega WHERE IDPaquete = _IDPaquete;
END;

-- Procedimiento para notificar la entrega de un paquete
CREATE PROCEDURE NotificarEntrega(
    IN _IDPaquete INT, 
    IN _Mensaje VARCHAR(255)
)
BEGIN
    INSERT INTO Notificaciones (IDPaquete, Mensaje, FechaNotificacion)
    VALUES (_IDPaquete, _Mensaje, NOW());
END;

-- Procedimiento para actualizar el método de pago de una factura
CREATE PROCEDURE ActualizarMetodoPagoFactura(
    IN _IDFactura INT, 
    IN _MetodoPago VARCHAR(30)
)
BEGIN
    UPDATE Factura SET MetodoPago = _MetodoPago WHERE IDFactura = _IDFactura;
END;

-- Procedimiento para eliminar una factura
CREATE PROCEDURE EliminarFactura(
    IN _IDFactura INT
)
BEGIN
    DELETE FROM Factura WHERE IDFactura = _IDFactura;
END;

-- Procedimiento para eliminar un paquete
CREATE PROCEDURE EliminarPaquete(
    IN _IDPaquete INT
)
BEGIN
    DELETE FROM Paquete WHERE IDPaquete = _IDPaquete;
END;

-- Procedimiento para eliminar una prealerta
CREATE PROCEDURE EliminarPrealerta(
    IN _IDPrealerta INT
)
BEGIN
    DELETE FROM Prealerta WHERE IDPrealerta = _IDPrealerta;
END;

-- Procedimiento para actualizar los datos de un cliente
CREATE PROCEDURE ActualizarCliente(
    IN _IDCliente INT, 
    IN _NuevoNombreCliente VARCHAR(100), 
    IN _NuevaDireccionCliente VARCHAR(255), 
    IN _NuevoTelefonoCliente VARCHAR(20), 
    IN _NuevoCorreoCliente VARCHAR(100)
)
BEGIN
    UPDATE Cliente 
    SET NombreCliente = _NuevoNombreCliente, 
        DireccionCliente = _NuevaDireccionCliente, 
        TelefonoCliente = _NuevoTelefonoCliente, 
        CorreoCliente = _NuevoCorreoCliente
    WHERE IDCliente = _IDCliente;
END;

-- 15: Procedimiento para verificar el pago de una factura
CREATE PROCEDURE VerificarPagoFactura(
    IN _IDFactura INT
)
BEGIN
    SELECT EstadoPago FROM Factura WHERE IDFactura = _IDFactura;
END;

-- Procedimiento para registrar una nota de crédito
CREATE PROCEDURE RegistrarNotaCredito(
    IN _IDFactura INT, 
    IN _MontoCredito DOUBLE
)
BEGIN
    INSERT INTO NotaCredito (IDFactura, MontoCredito, FechaCredito)
    VALUES (_IDFactura, _MontoCredito, NOW());
END;

-- Procedimiento para generar un reporte de facturación
CREATE PROCEDURE GenerarReporteFacturacion(
    IN _FechaInicio DATE, 
    IN _FechaFin DATE
)
BEGIN
    SELECT * FROM Factura WHERE Fecha BETWEEN _FechaInicio AND _FechaFin;
END;

-- Procedimiento para obtener los paquetes entregados
CREATE PROCEDURE PaquetesEntregados()
BEGIN
    SELECT * FROM Paquete WHERE EstadoPaquete = 'Entregado';
END;

-- Procedimiento para obtener el estado de todos los paquetes de un cliente
CREATE PROCEDURE ObtenerEstadoPaquetesCliente(
    IN _IDCliente INT
)
BEGIN
    SELECT EstadoPaquete FROM Paquete WHERE IDCliente = _IDCliente;
END;

-- Procedimiento para registrar el pago de una factura
CREATE PROCEDURE RegistrarPagoFactura(
    IN _IDFactura INT, 
    IN _MontoPago DOUBLE
)
BEGIN
    UPDATE Factura SET EstadoPago = 'Pagado', MontoPagado = _MontoPago 
    WHERE IDFactura = _IDFactura;
END;

-- Procedimiento para asignar un nuevo estado a una factura
CREATE PROCEDURE AsignarEstadoFactura(
    IN _IDFactura INT, 
    IN _NuevoEstado VARCHAR(30)
)
BEGIN
    UPDATE Factura SET EstadoPago = _NuevoEstado WHERE IDFactura = _IDFactura;
END;

-- Procedimiento para agregar un nuevo servicio adicional a una factura
CREATE PROCEDURE AgregarServicioAdicional(
    IN _IDFactura INT, 
    IN _DescripcionServicio VARCHAR(255), 
    IN _MontoServicio DOUBLE
)
BEGIN
    INSERT INTO ServicioAdicional (IDFactura, DescripcionServicio, MontoServicio)
    VALUES (_IDFactura, _DescripcionServicio, _MontoServicio);
END;

-- Procedimiento para actualizar el peso de un paquete
CREATE PROCEDURE ActualizarPesoPaquete(
    IN _IDPaquete INT, 
    IN _NuevoPeso DOUBLE
)
BEGIN
    UPDATE Paquete SET PesoPaquete = _NuevoPeso WHERE IDPaquete = _IDPaquete;
END;

-- Procedimiento para realizar una auditoría de los pagos
CREATE PROCEDURE RealizarAuditoriaPagos()
BEGIN
    SELECT * FROM Factura WHERE EstadoPago = 'Pagado';
END;

-- Procedimiento para eliminar un cliente
CREATE PROCEDURE EliminarCliente(
    IN _IDCliente INT
)
BEGIN
    DELETE FROM Cliente WHERE IDCliente = _IDCliente;
END;
