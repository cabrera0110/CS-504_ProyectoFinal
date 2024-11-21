-- Función para calcular el total de una factura, incluyendo servicios adicionales
CREATE FUNCTION CalcularTotalFactura(IN _IDFactura INT)
RETURNS DOUBLE
BEGIN
    DECLARE TotalFactura DOUBLE;
    DECLARE ServiciosAdicionales DOUBLE;
    
    SELECT MontoTotal INTO TotalFactura FROM Factura WHERE IDFactura = _IDFactura;
    
    SELECT SUM(MontoServicio) INTO ServiciosAdicionales
    FROM ServicioAdicional WHERE IDFactura = _IDFactura;
    
    RETURN TotalFactura + ServiciosAdicionales;
END;

-- Función para obtener el estado de un paquete
CREATE FUNCTION ObtenerEstadoPaquete(IN _IDPaquete INT)
RETURNS VARCHAR(30)
BEGIN
    DECLARE EstadoPaquete VARCHAR(30);
    
    SELECT EstadoPaquete INTO EstadoPaquete FROM Paquete WHERE IDPaquete = _IDPaquete;
    
    RETURN EstadoPaquete;
END;

-- Función para obtener el total de pagos de un cliente
CREATE FUNCTION ObtenerTotalPagosCliente(IN _IDCliente INT)
RETURNS DOUBLE
BEGIN
    DECLARE TotalPagos DOUBLE;
    
    SELECT SUM(MontoPago) INTO TotalPagos
    FROM Pago WHERE IDCliente = _IDCliente;
    
    RETURN TotalPagos;
END;

-- Función para verificar si un paquete está entregado
CREATE FUNCTION VerificarPaqueteEntregado(IN _IDPaquete INT)
RETURNS BOOLEAN
BEGIN
    DECLARE Estado VARCHAR(30);
    
    SELECT EstadoPaquete INTO Estado FROM Paquete WHERE IDPaquete = _IDPaquete;
    
    IF Estado = 'Entregado' THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

-- Función para obtener el nombre del cliente que realizó una factura
CREATE FUNCTION ObtenerNombreClienteFactura(IN _IDFactura INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE NombreCliente VARCHAR(100);
    
    SELECT C.NombreCliente INTO NombreCliente
    FROM Factura F
    JOIN Cliente C ON F.IDUsuario = C.IDCliente
    WHERE F.IDFactura = _IDFactura;
    
    RETURN NombreCliente;
END;

-- Función para calcular el saldo pendiente de una factura
CREATE FUNCTION CalcularSaldoPendiente(IN _IDFactura INT)
RETURNS DOUBLE
BEGIN
    DECLARE Total DOUBLE;
    DECLARE Pagado DOUBLE;
    
    SELECT MontoTotal INTO Total FROM Factura WHERE IDFactura = _IDFactura;
    
    SELECT SUM(MontoPago) INTO Pagado FROM Pago WHERE IDFactura = _IDFactura;
    
    RETURN Total - Pagado;
END;

-- Función para obtener la fecha de entrega estimada de un paquete
CREATE FUNCTION ObtenerFechaEntregaEstimado(IN _IDPaquete INT)
RETURNS DATE
BEGIN
    DECLARE FechaEntrega DATE;
    
    SELECT FechaEntrega INTO FechaEntrega FROM Paquete WHERE IDPaquete = _IDPaquete;
    
    RETURN FechaEntrega;
END;

-- Función para verificar si un cliente tiene facturas pendientes
CREATE FUNCTION TieneFacturasPendientes(IN _IDCliente INT)
RETURNS BOOLEAN
BEGIN
    DECLARE EstadoPago VARCHAR(30);
    
    SELECT EstadoPago INTO EstadoPago
    FROM Factura
    WHERE IDUsuario = _IDCliente AND EstadoPago = 'Pendiente';
    
    IF EstadoPago IS NOT NULL THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

-- Función para calcular el monto total de los servicios adicionales de una factura
CREATE FUNCTION ObtenerTotalServiciosAdicionales(IN _IDFactura INT)
RETURNS DOUBLE
BEGIN
    DECLARE TotalAdicionales DOUBLE;
    
    SELECT SUM(MontoServicio) INTO TotalAdicionales
    FROM ServicioAdicional
    WHERE IDFactura = _IDFactura;
    
    RETURN TotalAdicionales;
END;

-- Función para obtener el monto total de las facturas de un cliente
CREATE FUNCTION ObtenerMontoTotalFacturasCliente(IN _IDCliente INT)
RETURNS DOUBLE
BEGIN
    DECLARE MontoTotal DOUBLE;
    
    SELECT SUM(MontoTotal) INTO MontoTotal
    FROM Factura
    WHERE IDUsuario = _IDCliente;
    
    RETURN MontoTotal;
END;

-- Función para obtener el número de prealertas de un paquete
CREATE FUNCTION ObtenerNumeroPrealertas(IN _IDPaquete INT)
RETURNS INT
BEGIN
    DECLARE NumeroPrealertas INT;
    
    SELECT COUNT(*) INTO NumeroPrealertas FROM Prealerta WHERE IDPaquete = _IDPaquete;
    
    RETURN NumeroPrealertas;
END;

-- Función para obtener el monto total de las entregas realizadas por un cliente
CREATE FUNCTION ObtenerTotalEntregasCliente(IN _IDCliente INT)
RETURNS DOUBLE
BEGIN
    DECLARE TotalEntregas DOUBLE;
    
    SELECT SUM(MontoTotal) INTO TotalEntregas
    FROM Factura F
    JOIN Paquete P ON F.IDFactura = P.IDFactura
    WHERE F.IDUsuario = _IDCliente AND P.EstadoPaquete = 'Entregado';
    
    RETURN TotalEntregas;
END;

-- Función para calcular el tiempo de envío de un paquete
CREATE FUNCTION CalcularTiempoEnvio(IN _IDPaquete INT)
RETURNS INT
BEGIN
    DECLARE TiempoEnvio INT;
    DECLARE FechaEnvio DATE;
    DECLARE FechaRecepcion DATE;
    
    SELECT FechaEnvio, FechaRecepcion INTO FechaEnvio, FechaRecepcion FROM Prealerta WHERE IDPaquete = _IDPaquete;
    
    SET TiempoEnvio = DATEDIFF(FechaRecepcion, FechaEnvio);
    
    RETURN TiempoEnvio;
END;

-- Función para obtener los paquetes asociados a un cliente
CREATE FUNCTION ObtenerPaquetesCliente(IN _IDCliente INT)
RETURNS TABLE
BEGIN
    RETURN SELECT P.IDPaquete, P.Descripcion, P.EstadoPaquete
    FROM Paquete P
    WHERE P.IDCliente = _IDCliente;
END;

-- Función para obtener la dirección del casillero de un cliente
CREATE FUNCTION ObtenerDireccionCasillero(IN _IDCliente INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE DireccionCasillero VARCHAR(100);
    
    SELECT DireccionCasillero INTO DireccionCasillero FROM Casillero WHERE IDCliente = _IDCliente;
    
    RETURN DireccionCasillero;
END;

