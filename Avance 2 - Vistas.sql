-- Vista para obtener todos los paquetes entregados
CREATE VIEW VistaPaquetesEntregados AS
SELECT IDPaquete, Descripcion, PesoPaquete, EstadoPaquete, FechaRecepcion, FechaEntrega
FROM Paquete
WHERE EstadoPaquete = 'Entregado';

-- Vista para obtener información detallada de las facturas y su estado
CREATE VIEW VistaFacturas AS
SELECT F.IDFactura, F.MontoTotal, F.EstadoPago, F.Fecha, C.NombreCliente
FROM Factura F
JOIN Cliente C ON F.IDUsuario = C.IDCliente;

-- Vista para obtener todos los clientes con sus respectivos paquetes
CREATE VIEW VistaClientesPaquetes AS
SELECT C.IDCliente, C.NombreCliente, P.IDPaquete, P.Descripcion, P.EstadoPaquete
FROM Cliente C
JOIN Paquete P ON C.IDCliente = P.IDCliente;

-- Vista para obtener los detalles de las prealertas
CREATE VIEW VistaPrealertas AS
SELECT P.IDPrealerta, P.IDPaquete, P.Courier, P.NumeroRastro, P.CostoTraida, P.FechaEnvio
FROM Prealerta P;

-- Vista para obtener el historial de pagos de una factura
CREATE VIEW VistaHistorialPagos AS
SELECT FP.IDFactura, FP.MontoPago, FP.FechaPago, F.EstadoPago
FROM Factura_Pago FP
JOIN Factura F ON FP.IDFactura = F.IDFactura;

-- Vista para obtener la información de las notas de crédito
CREATE VIEW VistaNotasCredito AS
SELECT NC.IDNotaCredito, NC.IDFactura, NC.MontoCredito, NC.FechaCredito
FROM NotaCredito NC;

-- Vista para ver los paquetes en tránsito
CREATE VIEW VistaPaquetesTransito AS
SELECT IDPaquete, Descripcion, EstadoPaquete, FechaRecepcion
FROM Paquete
WHERE EstadoPaquete = 'En tránsito';

-- Vista para obtener un resumen de los pagos por cliente
CREATE VIEW VistaResumenPagosCliente AS
SELECT C.IDCliente, C.NombreCliente, SUM(F.MontoTotal) AS TotalPagado
FROM Factura F
JOIN Cliente C ON F.IDUsuario = C.IDCliente
WHERE F.EstadoPago = 'Pagado'
GROUP BY C.IDCliente;

-- Vista para obtener el estado de todos los paquetes de un cliente
CREATE VIEW VistaEstadoPaquetesCliente AS
SELECT C.IDCliente, C.NombreCliente, P.EstadoPaquete
FROM Cliente C
JOIN Paquete P ON C.IDCliente = P.IDCliente;

-- Vista para obtener los servicios adicionales registrados para las facturas
CREATE VIEW VistaServiciosAdicionales AS
SELECT SA.IDFactura, SA.DescripcionServicio, SA.MontoServicio
FROM ServicioAdicional SA;
