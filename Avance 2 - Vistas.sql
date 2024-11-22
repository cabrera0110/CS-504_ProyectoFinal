-- Obtener todos los detalles de los clientes y sus paquetes
CREATE VIEW vw_DetallesClientesPaquetes AS
SELECT c.IDCliente, c.NombreCliente, p.IDPaquete, p.Descripcion, p.ValorDeclarado, p.PesoPaquete, p.EstadoPaquete
FROM Cliente c
JOIN Casillero ca ON c.IDCliente = ca.IDCliente
JOIN Paquete p ON ca.IDCasillero = p.IDCasillero;

-- Obtener todas las facturas de un cliente junto con su estado de pago
CREATE VIEW vw_FacturasClientes AS
SELECT f.IDFactura, f.MontoTotal, f.Fecha, f.EstadoPago, f.MetodoPago, c.NombreCliente
FROM Factura f
JOIN Cliente c ON f.IDUsuario = c.IDCliente;

-- Obtener detalles de prealertas asociadas a paquetes
CREATE VIEW vw_PrealertasPaquetes AS
SELECT pa.IDPrealerta, pa.FechaEnvio, pa.Courier, pa.NumeroRastro, pa.CostoTraida, p.Descripcion AS PaqueteDescripcion
FROM Prealerta pa
JOIN Paquete p ON pa.IDPaquete = p.IDPaquete;

-- Obtener las notificaciones de los clientes
CREATE VIEW vw_NotificacionesClientes AS
SELECT n.IDNotificacion, n.Mensaje, n.Fecha, n.Leido, c.NombreCliente
FROM Notificaciones n
JOIN Paquete p ON n.IDPaquete = p.IDPaquete
JOIN Casillero c ON p.IDCasillero = c.IDCasillero;

-- Obtener todos los paquetes con su estado
CREATE VIEW vw_PaquetesConEstado AS
SELECT p.IDPaquete, p.Descripcion, p.EstadoPaquete
FROM Paquete p;

-- Obtener el resumen de todos los clientes y sus facturas
CREATE VIEW vw_ResumenClientesFacturas AS
SELECT c.IDCliente, c.NombreCliente, f.IDFactura, f.MontoTotal, f.EstadoPago
FROM Cliente c
JOIN Factura f ON c.IDCliente = f.IDUsuario;

-- Obtener el total de la factura de un cliente
CREATE VIEW vw_TotalFacturaCliente AS
SELECT c.IDCliente, c.NombreCliente, SUM(f.MontoTotal) AS TotalFactura
FROM Cliente c
JOIN Factura f ON c.IDCliente = f.IDUsuario
GROUP BY c.IDCliente;

-- Obtener la cantidad total de paquetes que ha recibido un cliente
CREATE VIEW vw_CantidadPaquetesCliente AS
SELECT c.IDCliente, c.NombreCliente, COUNT(p.IDPaquete) AS TotalPaquetes
FROM Cliente c
JOIN Casillero ca ON c.IDCliente = ca.IDCliente
JOIN Paquete p ON ca.IDCasillero = p.IDCasillero
GROUP BY c.IDCliente;

-- Obtener el estado de todos los paquetes por cliente
CREATE VIEW vw_EstadoPaquetesClientes AS
SELECT c.IDCliente, c.NombreCliente, p.EstadoPaquete
FROM Cliente c
JOIN Casillero ca ON c.IDCliente = ca.IDCliente
JOIN Paquete p ON ca.IDCasillero = p.IDCasillero;

-- Obtener las direcciones de casilleros
CREATE VIEW vw_DireccionesCasilleros AS
SELECT c.IDCliente, ca.DireccionCasillero
FROM Cliente c
JOIN Casillero ca ON c.IDCliente = ca.IDCliente;
