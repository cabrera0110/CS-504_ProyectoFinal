-- Actualizar el estado del paquete al ser entregado
CREATE TRIGGER ActualizarEstadoPaqueteEntrega
AFTER UPDATE ON Paquete
FOR EACH ROW
BEGIN
    IF NEW.FechaEntrega IS NOT NULL THEN
        UPDATE Paquete SET EstadoPaquete = 'Entregado' WHERE IDPaquete = NEW.IDPaquete;
    END IF;
END;

-- Calcular el monto total de la factura
CREATE TRIGGER CalcularMontoFactura
AFTER INSERT ON Paquete
FOR EACH ROW
BEGIN
    DECLARE total DOUBLE;
    SELECT SUM(CAST(ValorDeclarado AS DOUBLE)) INTO total FROM Paquete WHERE IDFactura = NEW.IDFactura;
    UPDATE Factura SET MontoTotal = total WHERE IDFactura = NEW.IDFactura;
END;

-- Insertar una notificación cuando un paquete es recibido
CREATE TRIGGER InsertarNotificacionPaqueteRecibido
AFTER UPDATE ON Paquete
FOR EACH ROW
BEGIN
    IF NEW.EstadoPaquete = 'Recibido' THEN
        INSERT INTO Notificaciones (IDPaquete, Mensaje, FechaNotificacion) 
        VALUES (NEW.IDPaquete, 'Tu paquete ha sido recibido.', NOW());
    END IF;
END;

-- Verificar si un paquete tiene una prealerta
CREATE TRIGGER VerificarPrealertaPaquete
AFTER INSERT ON Paquete
FOR EACH ROW
BEGIN
    DECLARE prealertaExistente INT;
    SELECT COUNT(*) INTO prealertaExistente FROM Prealerta WHERE IDPaquete = NEW.IDPaquete;
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
