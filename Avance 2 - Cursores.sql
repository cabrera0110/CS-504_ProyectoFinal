-- Paquetes por cliente
DECLARE 
    CURSOR paquetes_cliente_cursor IS
        SELECT p.IDPaquete, p.Descripcion 
        FROM Paquete p
        JOIN Casillero c ON p.IDCasillero = c.IDCasillero
        WHERE c.IDCliente = :p_IDCliente;

    v_IDPaquete Paquete.IDPaquete%TYPE;
    v_Descripcion Paquete.Descripcion%TYPE;
BEGIN
    OPEN paquetes_cliente_cursor;
    LOOP
        FETCH paquetes_cliente_cursor INTO v_IDPaquete, v_Descripcion;
        EXIT WHEN paquetes_cliente_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Paquete: ' || v_IDPaquete || ' - ' || v_Descripcion);
    END LOOP;
    CLOSE paquetes_cliente_cursor;
END;
/

-- Prealertas de paquetes
DECLARE 
    CURSOR prealertas_paquetes_cursor IS
        SELECT pa.IDPrealerta, pa.Courier, pa.FechaEnvio 
        FROM Prealerta pa
        JOIN Paquete p ON pa.IDPaquete = p.IDPaquete
        WHERE p.EstadoPaquete = 'Pendiente';

    v_IDPrealerta Prealerta.IDPrealerta%TYPE;
    v_Courier Prealerta.Courier%TYPE;
    v_FechaEnvio Prealerta.FechaEnvio%TYPE;
BEGIN
    OPEN prealertas_paquetes_cursor;
    LOOP
        FETCH prealertas_paquetes_cursor INTO v_IDPrealerta, v_Courier, v_FechaEnvio;
        EXIT WHEN prealertas_paquetes_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Prealerta: ' || v_IDPrealerta || ' - Courier: ' || v_Courier || ' - Fecha de Envío: ' || v_FechaEnvio);
    END LOOP;
    CLOSE prealertas_paquetes_cursor;
END;
/

-- Paquetes pendientes
DECLARE 
    CURSOR pendientes_cursor IS
        SELECT IDPaquete, Descripcion 
        FROM Paquete
        WHERE EstadoPaquete = 'Pendiente';

    v_IDPaquete Paquete.IDPaquete%TYPE;
    v_Descripcion Paquete.Descripcion%TYPE;
BEGIN
    OPEN pendientes_cursor;
    LOOP
        FETCH pendientes_cursor INTO v_IDPaquete, v_Descripcion;
        EXIT WHEN pendientes_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Paquete pendiente: ' || v_IDPaquete || ' - ' || v_Descripcion);
    END LOOP;
    CLOSE pendientes_cursor;
END;
/

-- Facturas no pagadas
DECLARE 
    CURSOR factura_cursor IS
        SELECT IDFactura, MontoTotal, Fecha 
        FROM Factura
        WHERE EstadoPago = 'No Pagado';

    v_IDFactura Factura.IDFactura%TYPE;
    v_MontoTotal Factura.MontoTotal%TYPE;
    v_Fecha Factura.Fecha%TYPE;
BEGIN
    OPEN factura_cursor;
    LOOP
        FETCH factura_cursor INTO v_IDFactura, v_MontoTotal, v_Fecha;
        EXIT WHEN factura_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Factura No Pagada: ' || v_IDFactura || ' - Monto: ' || v_MontoTotal || ' - Fecha: ' || v_Fecha);
    END LOOP;
    CLOSE factura_cursor;
END;
/

-- Notificaciones de un paquete
DECLARE 
    CURSOR notificacion_cursor IS
        SELECT Mensaje, FechaNotificacion 
        FROM Notificaciones
        WHERE IDPaquete = :p_IDPaquete;

    v_Mensaje Notificaciones.Mensaje%TYPE;
    v_FechaNotificacion Notificaciones.FechaNotificacion%TYPE;
BEGIN
    OPEN notificacion_cursor;
    LOOP
        FETCH notificacion_cursor INTO v_Mensaje, v_FechaNotificacion;
        EXIT WHEN notificacion_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Notificación: ' || v_Mensaje || ' - Fecha: ' || v_FechaNotificacion);
    END LOOP;
    CLOSE notificacion_cursor;
END;
/

-- Clientes con paquetes entregados
DECLARE 
    CURSOR clientes_entregados_cursor IS
        SELECT c.NombreCliente, c.IDCliente 
        FROM Cliente c
        JOIN Casillero ca ON c.IDCliente = ca.IDCliente
        JOIN Paquete p ON ca.IDCasillero = p.IDCasillero
        WHERE p.EstadoPaquete = 'Entregado';

    v_NombreCliente Cliente.NombreCliente%TYPE;
    v_IDCliente Cliente.IDCliente%TYPE;
BEGIN
    OPEN clientes_entregados_cursor;
    LOOP
        FETCH clientes_entregados_cursor INTO v_NombreCliente, v_IDCliente;
        EXIT WHEN clientes_entregados_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_NombreCliente || ' - ID: ' || v_IDCliente);
    END LOOP;
    CLOSE clientes_entregados_cursor;
END;
/
