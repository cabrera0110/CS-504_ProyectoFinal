-- Obtener Paquetes por Cliente
CREATE PACKAGE PaqueteCliente AS
    PROCEDURE ObtenerPaquetes(p_IDCliente INT);
END PaqueteCliente;

-- Notificaciones de Paquete
CREATE PACKAGE NotificacionesPaquete AS
    PROCEDURE ObtenerNotificaciones(p_IDPaquete INT);
END NotificacionesPaquete;

-- Facturación
CREATE PACKAGE Facturacion AS
    PROCEDURE ObtenerMontoFactura(p_IDFactura INT);
END Facturacion;

-- Paquetes Pendientes
CREATE PACKAGE PaquetesPendientes AS
    PROCEDURE ObtenerPaquetesPendientesEntrega();
END PaquetesPendientes;

-- Clientes y Casilleros
CREATE PACKAGE ClienteCasillero AS
    PROCEDURE ObtenerCasilleroCliente(p_IDCliente INT);
END ClienteCasillero;

-- Prealertas
CREATE PACKAGE Prealertas AS
    PROCEDURE ObtenerEstadoPrealerta(p_IDPrealerta INT);
END Prealertas;

-- Clientes y Paquetes
CREATE PACKAGE ClientePaquete AS
    PROCEDURE ObtenerPaquetesDeCliente(p_IDCliente INT);
END ClientePaquete;

-- Estado de Pago
CREATE PACKAGE EstadoPago AS
    PROCEDURE ObtenerEstadoPagoFactura(p_IDFactura INT);
END EstadoPago;

-- Paquete Valor
CREATE PACKAGE PaqueteValor AS
    PROCEDURE ObtenerValorDeclaradoPaquete(p_IDPaquete INT);
END PaqueteValor;

-- Envío de Paquete
CREATE PACKAGE EnvioPaquete AS
    PROCEDURE ObtenerFechaRecepcionPaquete(p_IDPaquete INT);
END EnvioPaquete;