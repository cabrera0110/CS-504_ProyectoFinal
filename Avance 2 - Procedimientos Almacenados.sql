-- Procedimiento para registrar un nuevo cliente
CREATE OR REPLACE PROCEDURE RegistrarCliente(
    NombreCliente IN VARCHAR2,
    DireccionCliente IN VARCHAR2,
    TelefonoCliente IN VARCHAR2,
    CorreoCliente IN VARCHAR2
)
AS
BEGIN
    INSERT INTO Cliente (NombreCliente, DireccionCliente, TelefonoCliente, CorreoCliente)
    VALUES (NombreCliente, DireccionCliente, TelefonoCliente, CorreoCliente);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar el cliente: ' || SQLERRM);
END;
/

-- Procedimiento para registrar un paquete
CREATE OR REPLACE PROCEDURE RegistrarPaquete(
    IDCliente IN NUMBER,
    Descripcion IN VARCHAR2,
    PesoPaquete IN NUMBER,
    EstadoPaquete IN VARCHAR2
)
AS
BEGIN
    INSERT INTO Paquete (IDCliente, Descripcion, PesoPaquete, EstadoPaquete, FechaRecepcion)
    VALUES (IDCliente, Descripcion, PesoPaquete, EstadoPaquete, SYSDATE);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar el paquete: ' || SQLERRM);
END;
/

-- Procedimiento para actualizar el estado de un paquete
CREATE OR REPLACE PROCEDURE ActualizarEstadoPaquete(
    P_IDPaquete IN NUMBER,
    NuevoEstado IN VARCHAR2
)
AS
BEGIN
    UPDATE Paquete
    SET EstadoPaquete = NuevoEstado
    WHERE IDPaquete = P_IDPaquete;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el paquete con ID: ' || P_IDPaquete);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Estado del paquete actualizado correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar el estado del paquete: ' || SQLERRM);
END;
/

-- Procedimiento para asignar una factura a un paquete
CREATE OR REPLACE PROCEDURE AsignarFacturaAPaquete(
    _IDFactura IN NUMBER,
    _IDPaquete IN NUMBER
)
AS
BEGIN
    INSERT INTO Factura_Paquete (IDFactura, IDPaquete)
    VALUES (_IDFactura, _IDPaquete);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al asignar la factura al paquete: ' || SQLERRM);
END;
/

-- Procedimiento para consultar paquetes por cliente
CREATE OR REPLACE PROCEDURE ConsultarPaquetesPorCliente(
    IDCliente IN NUMBER
)
AS
BEGIN
    FOR registro IN (
        SELECT IDPaquete, Descripcion, PesoPaquete, EstadoPaquete, FechaRecepcion
        FROM Paquete
        WHERE IDCliente = IDCliente
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID Paquete: ' || registro.IDPaquete || 
            ', Descripcion: ' || registro.Descripcion || 
            ', Peso: ' || registro.PesoPaquete || 
            ', Estado: ' || registro.EstadoPaquete || 
            ', Fecha Recepcion: ' || TO_CHAR(registro.FechaRecepcion, 'DD-MON-YYYY')
        );
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al consultar los paquetes del cliente: ' || SQLERRM);
END;
/

-- Procedimiento para registrar una nueva factura
CREATE OR REPLACE PROCEDURE RegistrarFactura(
    _IDCliente IN NUMBER, 
    _MontoTotal IN NUMBER, 
    _MetodoPago IN VARCHAR2
)
AS
BEGIN
    INSERT INTO Factura (IDUsuario, MontoTotal, EstadoPago, MetodoPago, Fecha)
    VALUES (_IDCliente, _MontoTotal, 'Pendiente', _MetodoPago, SYSDATE);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar la factura: ' || SQLERRM);
END;
/

-- Procedimiento para generar una prealerta para un paquete
CREATE OR REPLACE PROCEDURE GenerarPrealerta(
    _IDPaquete IN NUMBER, 
    _Courier IN VARCHAR2, 
    _NumeroRastro IN VARCHAR2, 
    _CostoTraida IN NUMBER
)
AS
BEGIN
    INSERT INTO Prealerta (IDPaquete, Courier, NumeroRastro, CostoTraida, FechaEnvio)
    VALUES (_IDPaquete, _Courier, _NumeroRastro, _CostoTraida, SYSDATE);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al generar la prealerta: ' || SQLERRM);
END;
/

-- Procedimiento para registrar un casillero
CREATE OR REPLACE PROCEDURE RegistrarCasillero(
    _IDCliente IN NUMBER, 
    _DireccionCasillero IN VARCHAR2
)
AS
BEGIN
    INSERT INTO Casillero (IDCliente, DireccionCasillero)
    VALUES (_IDCliente, _DireccionCasillero);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al registrar el casillero: ' || SQLERRM);
END;
/

-- Procedimiento para actualizar la fecha de entrega de un paquete
CREATE OR REPLACE PROCEDURE ActualizarFechaEntregaPaquete(
    _IDPaquete IN NUMBER, 
    _FechaEntrega IN DATE
)
AS
BEGIN
    UPDATE Paquete 
    SET FechaEntrega = _FechaEntrega 
    WHERE IDPaquete = _IDPaquete;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el paquete con ID: ' || _IDPaquete);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Fecha de entrega actualizada correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar la fecha de entrega: ' || SQLERRM);
END;
/

-- Procedimiento para notificar la entrega de un paquete
CREATE OR REPLACE PROCEDURE NotificarEntrega(
    _IDPaquete IN NUMBER, 
    _Mensaje IN VARCHAR2
)
AS
BEGIN
    INSERT INTO Notificaciones (IDPaquete, Mensaje, FechaNotificacion)
    VALUES (_IDPaquete, _Mensaje, SYSDATE);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al notificar la entrega: ' || SQLERRM);
END;
/

-- Procedimiento para actualizar el método de pago de una factura
CREATE OR REPLACE PROCEDURE ActualizarMetodoPagoFactura(
    _IDFactura IN NUMBER, 
    _MetodoPago IN VARCHAR2
)
AS
BEGIN
    UPDATE Factura 
    SET MetodoPago = _MetodoPago 
    WHERE IDFactura = _IDFactura;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró la factura con ID: ' || _IDFactura);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Método de pago actualizado correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al actualizar el método de pago: ' || SQLERRM);
END;
/

-- Procedimiento para eliminar una factura
CREATE OR REPLACE PROCEDURE EliminarFactura(
    _IDFactura IN NUMBER
)
AS
BEGIN
    DELETE FROM Factura WHERE IDFactura = _IDFactura;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró la factura con ID: ' || _IDFactura);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Factura eliminada correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar la factura: ' || SQLERRM);
END;
/

-- Procedimiento para eliminar un paquete
CREATE OR REPLACE PROCEDURE EliminarPaquete(
    _IDPaquete IN NUMBER
)
AS
BEGIN
    DELETE FROM Paquete WHERE IDPaquete = _IDPaquete;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el paquete con ID: ' || _IDPaquete);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Paquete eliminado correctamente.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al eliminar el paquete: ' || SQLERRM);
END;
/

-- Procedimiento para verificar el estado de pago de una factura
CREATE OR REPLACE PROCEDURE VerificarPagoFactura(
    _IDFactura IN NUMBER
)
AS
    EstadoPago VARCHAR2(20);
BEGIN
    SELECT EstadoPago 
    INTO EstadoPago
    FROM Factura
    WHERE IDFactura = _IDFactura;

    IF EstadoPago = 'Pagado' THEN
        DBMS_OUTPUT.PUT_LINE('La factura ya está pagada.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('La factura está pendiente de pago.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al verificar el estado de pago de la factura: ' || SQLERRM);
END;
/

-- Procedimiento para realizar una consulta sobre la disponibilidad de un casillero
CREATE OR REPLACE PROCEDURE ConsultarDisponibilidadCasillero(
    _IDCliente IN NUMBER
)
AS
    Disponibilidad VARCHAR2(10);
BEGIN
    SELECT CASE
               WHEN EXISTS (SELECT 1 FROM Casillero WHERE IDCliente = _IDCliente) 
               THEN 'Disponible'
               ELSE 'No Disponible'
           END
    INTO Disponibilidad
    FROM dual;

    DBMS_OUTPUT.PUT_LINE('Disponibilidad del casillero: ' || Disponibilidad);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al verificar la disponibilidad del casillero: ' || SQLERRM);
END;
/
