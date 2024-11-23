-- Obtener Paquetes por Cliente
CREATE OR REPLACE PACKAGE PaqueteCliente AS
    PROCEDURE ObtenerPaquetes(p_IDCliente INT);
END PaqueteCliente;

CREATE OR REPLACE PACKAGE BODY PaqueteCliente AS
    PROCEDURE ObtenerPaquetes(p_IDCliente INT) IS
    BEGIN
        FOR r IN (
            SELECT p.IDPaquete, p.Descripcion 
            FROM Paquete p
            JOIN Casillero c ON p.IDCasillero = c.IDCasillero
            WHERE c.IDCliente = p_IDCliente
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Paquete: ' || r.IDPaquete || ' - ' || r.Descripcion);
        END LOOP;
    END ObtenerPaquetes;
END PaqueteCliente;

-- Notificaciones de Paquete
CREATE OR REPLACE PACKAGE NotificacionesPaquete AS
    PROCEDURE ObtenerNotificaciones(p_IDPaquete INT);
END NotificacionesPaquete;

CREATE OR REPLACE PACKAGE BODY NotificacionesPaquete AS
    PROCEDURE ObtenerNotificaciones(p_IDPaquete INT) IS
    BEGIN
        FOR r IN (
            SELECT Mensaje, FechaNotificacion 
            FROM Notificaciones
            WHERE IDPaquete = p_IDPaquete
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Notificación: ' || r.Mensaje || ' - Fecha: ' || r.FechaNotificacion);
        END LOOP;
    END ObtenerNotificaciones;
END NotificacionesPaquete;

-- Facturación
CREATE OR REPLACE PACKAGE Facturacion AS
    PROCEDURE ObtenerMontoFactura(p_IDFactura INT);
END Facturacion;

CREATE OR REPLACE PACKAGE BODY Facturacion AS
    PROCEDURE ObtenerMontoFactura(p_IDFactura INT) IS
        v_MontoTotal NUMBER;
    BEGIN
        SELECT MontoTotal INTO v_MontoTotal
        FROM Factura
        WHERE IDFactura = p_IDFactura;
        DBMS_OUTPUT.PUT_LINE('Monto Total de la Factura: ' || v_MontoTotal);
    END ObtenerMontoFactura;
END Facturacion;

-- Paquetes Pendientes
CREATE OR REPLACE PACKAGE PaquetesPendientes AS
    PROCEDURE ObtenerPaquetesPendientesEntrega;
END PaquetesPendientes;

CREATE OR REPLACE PACKAGE BODY PaquetesPendientes AS
    PROCEDURE ObtenerPaquetesPendientesEntrega IS
    BEGIN
        FOR r IN (
            SELECT IDPaquete, Descripcion 
            FROM Paquete
            WHERE EstadoPaquete = 'Pendiente'
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Paquete Pendiente: ' || r.IDPaquete || ' - ' || r.Descripcion);
        END LOOP;
    END ObtenerPaquetesPendientesEntrega;
END PaquetesPendientes;

-- Clientes y Casilleros
CREATE OR REPLACE PACKAGE ClienteCasillero AS
    PROCEDURE ObtenerCasilleroCliente(p_IDCliente INT);
END ClienteCasillero;

CREATE OR REPLACE PACKAGE BODY ClienteCasillero AS
    PROCEDURE ObtenerCasilleroCliente(p_IDCliente INT) IS
    BEGIN
        FOR r IN (
            SELECT IDCasillero, DireccionCasillero 
            FROM Casillero
            WHERE IDCliente = p_IDCliente
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Casillero: ' || r.IDCasillero || ' - Dirección: ' || r.DireccionCasillero);
        END LOOP;
    END ObtenerCasilleroCliente;
END ClienteCasillero;

-- Prealertas
CREATE OR REPLACE PACKAGE Prealertas AS
    PROCEDURE ObtenerEstadoPrealerta(p_IDPrealerta INT);
END Prealertas;

CREATE OR REPLACE PACKAGE BODY Prealertas AS
    PROCEDURE ObtenerEstadoPrealerta(p_IDPrealerta INT) IS
        v_Courier VARCHAR2(50);
        v_FechaEnvio DATE;
        v_CostoTraida NUMBER(10, 2);
    BEGIN
        SELECT Courier, FechaEnvio, CostoTraida INTO v_Courier, v_FechaEnvio, v_CostoTraida
        FROM Prealerta
        WHERE IDPrealerta = p_IDPrealerta;
        DBMS_OUTPUT.PUT_LINE('Prealerta - Courier: ' || v_Courier || ', Fecha Envío: ' || v_FechaEnvio || ', Costo: ' || v_CostoTraida);
    END ObtenerEstadoPrealerta;
END Prealertas;

-- Clientes y Paquetes
CREATE OR REPLACE PACKAGE ClientePaquete AS
    PROCEDURE ObtenerPaquetesDeCliente(p_IDCliente INT);
END ClientePaquete;

CREATE OR REPLACE PACKAGE BODY ClientePaquete AS
    PROCEDURE ObtenerPaquetesDeCliente(p_IDCliente INT) IS
    BEGIN
        FOR r IN (
            SELECT p.IDPaquete, p.Descripcion 
            FROM Paquete p
            JOIN Casillero c ON p.IDCasillero = c.IDCasillero
            WHERE c.IDCliente = p_IDCliente
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Paquete: ' || r.IDPaquete || ' - ' || r.Descripcion);
        END LOOP;
    END ObtenerPaquetesDeCliente;
END ClientePaquete;

-- Estado de Pago
CREATE OR REPLACE PACKAGE EstadoPago AS
    PROCEDURE ObtenerEstadoPagoFactura(p_IDFactura INT);
END EstadoPago;

CREATE OR REPLACE PACKAGE BODY EstadoPago AS
    PROCEDURE ObtenerEstadoPagoFactura(p_IDFactura INT) IS
        v_EstadoPago VARCHAR2(30);
    BEGIN
        SELECT EstadoPago INTO v_EstadoPago
        FROM Factura
        WHERE IDFactura = p_IDFactura;
        DBMS_OUTPUT.PUT_LINE('Estado de Pago: ' || v_EstadoPago);
    END ObtenerEstadoPagoFactura;
END EstadoPago;

-- Paquete Valor
CREATE OR REPLACE PACKAGE PaqueteValor AS
    PROCEDURE ObtenerValorDeclaradoPaquete(p_IDPaquete INT);
END PaqueteValor;

CREATE OR REPLACE PACKAGE BODY PaqueteValor AS
    PROCEDURE ObtenerValorDeclaradoPaquete(p_IDPaquete INT) IS
        v_ValorDeclarado NUMBER(10, 2);
    BEGIN
        SELECT ValorDeclarado INTO v_ValorDeclarado
        FROM Paquete
        WHERE IDPaquete = p_IDPaquete;
        DBMS_OUTPUT.PUT_LINE('Valor Declarado del Paquete: ' || v_ValorDeclarado);
    END ObtenerValorDeclaradoPaquete;
END PaqueteValor;

-- Envío de Paquete
CREATE OR REPLACE PACKAGE EnvioPaquete AS
    PROCEDURE ObtenerFechaRecepcionPaquete(p_IDPaquete INT);
END EnvioPaquete;

CREATE OR REPLACE PACKAGE BODY EnvioPaquete AS
    PROCEDURE ObtenerFechaRecepcionPaquete(p_IDPaquete INT) IS
        v_FechaRecepcion DATE;
    BEGIN
        SELECT FechaRecepcion INTO v_FechaRecepcion
        FROM Paquete
        WHERE IDPaquete = p_IDPaquete;
        DBMS_OUTPUT.PUT_LINE('Fecha de Recepción del Paquete: ' || v_FechaRecepcion);
    END ObtenerFechaRecepcionPaquete;
END EnvioPaquete;
