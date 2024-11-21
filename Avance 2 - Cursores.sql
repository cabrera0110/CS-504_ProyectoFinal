-- Paquetes por cliente
DECLARE paquete_cursor CURSOR FOR 
SELECT IDPaquete, Descripcion 
FROM Paquete
WHERE IDCliente = :p_IDCliente;

-- Prealertas de paquetes
DECLARE prealerta_cursor CURSOR FOR 
SELECT IDPrealerta, Courier, FechaEnvio 
FROM Prealerta
WHERE EstadoPaquete = 'Pendiente';

-- Paquetes pendientes
DECLARE pendientes_cursor CURSOR FOR 
SELECT IDPaquete, Descripcion 
FROM Paquete
WHERE EstadoPaquete = 'Pendiente';

-- Facturas no pagadas
DECLARE factura_cursor CURSOR FOR 
SELECT IDFactura, MontoTotal, Fecha 
FROM Factura
WHERE EstadoPago = 'No Pagado';

-- Notificaciones de un paquete
DECLARE notificacion_cursor CURSOR FOR 
SELECT Mensaje, FechaNotificacion 
FROM Notificaciones
WHERE IDPaquete = :p_IDPaquete;

-- Clientes con paquetes entregados
DECLARE entregados_cursor CURSOR FOR 
SELECT NombreCliente, IDCliente 
FROM Cliente
JOIN Paquete ON Cliente.IDCliente = Paquete.IDCliente
WHERE Paquete.EstadoPaquete = 'Entregado';