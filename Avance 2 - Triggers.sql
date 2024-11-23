-- Actualizar el estado del paquete al ser entregado
CREATE TRIGGER ActualizarEstadoPaqueteEntrega
AFTER UPDATE ON Paquete
FOR EACH ROW
BEGIN
    IF NEW.FechaEntrega IS NOT NULL THEN
        SET NEW.EstadoPaquete = 'Entregado';
    END IF;
END;

-- Calcular el monto total de la factura
CREATE TRIGGER CalcularMontoFactura
AFTER INSERT ON Paquete
FOR EACH ROW
BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(ValorDeclarado) INTO total 
    FROM Paquete 
    WHERE IDCasillero = (SELECT IDCasillero FROM Paquete WHERE IDPaquete = NEW.IDPaquete);
    UPDATE Factura SET MontoTotal = total WHERE IDFactura = (SELECT IDFactura FROM Factura WHERE IDUsuario = (SELECT IDCliente FROM Casillero WHERE IDCasillero = NEW.IDCasillero));
END;

-- Insertar una notificación cuando un paquete es recibido
CREATE TRIGGER InsertarNotificacionPaqueteRecibido
AFTER UPDATE ON Paquete
FOR EACH ROW
BEGIN
    IF NEW.EstadoPaquete = 'Recibido' THEN
        INSERT INTO Notificaciones (IDPaquete, Mensaje, FechaNotificacion) 
        VALUES (NEW.IDPaquete, 'Tu paquete ha sido recibido.', CURRENT_DATE);
    END IF;
END;

-- Verificar si un paquete tiene una prealerta
CREATE TRIGGER VerificarPrealertaPaquete
AFTER INSERT ON Paquete
FOR EACH ROW
BEGIN
    DECLARE prealertaExistente INT;
    SELECT COUNT(*) INTO prealertaExistente 
    FROM Prealerta 
    WHERE IDPaquete = NEW.IDPaquete;
    IF prealertaExistente = 0 THEN
        UPDATE Paquete SET EstadoPaquete = 'Esperando Prealerta' WHERE IDPaquete = NEW.IDPaquete;
    END IF;
END;

-- Evitar facturación de un paquete sin pago
CREATE TRIGGER VerificarEstadoPagoFactura
BEFORE INSERT ON Factura
FOR EACH ROW
BEGIN
    IF NEW.EstadoPago != 'Pagado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede facturar sin pago realizado.';
    END IF;
END;
