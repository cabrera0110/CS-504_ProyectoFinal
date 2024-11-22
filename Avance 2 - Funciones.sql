-- Obtener el estado de un paquete
CREATE OR REPLACE FUNCTION fn_ObtenerEstadoPaquete (
    p_IDPaquete INT
)
RETURN VARCHAR2
IS
    estado VARCHAR2(30);
BEGIN
    SELECT EstadoPaquete INTO estado
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;
    
    RETURN estado;
END;
/
-- Calcular el total de paquetes de un cliente
CREATE OR REPLACE FUNCTION fn_CalcularTotalPaquetesPorCliente (
    p_IDCliente INT
)
RETURN INT
IS
    totalPaquetes INT;
BEGIN
    SELECT COUNT(*) INTO totalPaquetes
    FROM Paquete
    JOIN Casillero ON Paquete.IDCasillero = Casillero.IDCasillero
    WHERE Casillero.IDCliente = p_IDCliente;

    RETURN totalPaquetes;
END;
/

-- Obtener el valor declarado de un paquete
CREATE OR REPLACE FUNCTION fn_ObtenerValorDeclarado (
    p_IDPaquete INT
)
RETURN VARCHAR2
IS
    valor VARCHAR2(30);
BEGIN
    SELECT ValorDeclarado INTO valor
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;

    RETURN valor;
END;
/

-- Calcular el peso total de los paquetes de un cliente
CREATE OR REPLACE FUNCTION fn_CalcularPesoTotalPaquetes (
    p_IDCliente INT
)
RETURN DOUBLE
IS
    pesoTotal DOUBLE;
BEGIN
    SELECT SUM(PesoPaquete) INTO pesoTotal
    FROM Paquete
    JOIN Casillero ON Paquete.IDCasillero = Casillero.IDCasillero
    WHERE Casillero.IDCliente = p_IDCliente;

    RETURN pesoTotal;
END;
/

-- Obtener el nombre de un cliente por su ID
CREATE OR REPLACE FUNCTION fn_ObtenerNombreCliente (
    p_IDCliente INT
)
RETURN VARCHAR2
IS
    nombre VARCHAR2(100);
BEGIN
    SELECT NombreCliente INTO nombre
    FROM Cliente
    WHERE IDCliente = p_IDCliente;

    RETURN nombre;
END;
/

-- Calcular el monto total de las facturas de un cliente
CREATE OR REPLACE FUNCTION fn_CalcularMontoTotalFactura (
    p_IDCliente INT
)
RETURN DOUBLE
IS
    total DOUBLE;
BEGIN
    SELECT SUM(MontoTotal) INTO total
    FROM Factura
    WHERE IDUsuario = p_IDCliente;

    RETURN total;
END;
/

-- Obtener el estado de pago de una factura
CREATE OR REPLACE FUNCTION fn_ObtenerEstadoPagoFactura (
    p_IDFactura INT
)
RETURN VARCHAR2
IS
    estado VARCHAR2(30);
BEGIN
    SELECT EstadoPago INTO estado
    FROM Factura
    WHERE IDFactura = p_IDFactura;

    RETURN estado;
END;
/

-- Obtener el tipo de pago de una factura
CREATE OR REPLACE FUNCTION fn_ObtenerMetodoPagoFactura (
    p_IDFactura INT
)
RETURN VARCHAR2
IS
    metodoPago VARCHAR2(30);
BEGIN
    SELECT MetodoPago INTO metodoPago
    FROM Factura
    WHERE IDFactura = p_IDFactura;

    RETURN metodoPago;
END;
/

-- Obtener el nombre del paquete por su ID
CREATE OR REPLACE FUNCTION fn_ObtenerNombrePaquete (
    p_IDPaquete INT
)
RETURN VARCHAR2
IS
    nombre VARCHAR2(100);
BEGIN
    SELECT Descripcion INTO nombre
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;

    RETURN nombre;
END;
/

-- Verificar si un paquete ya fue recibido
CREATE OR REPLACE FUNCTION fn_VerificarPaqueteRecibido (
    p_IDPaquete INT
)
RETURN BOOLEAN
IS
    recibido BOOLEAN;
BEGIN
    SELECT EstadoPaquete INTO recibido
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;

    IF (recibido = 'Recibido') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

-- Verificar si un cliente tiene un paquete con un valor superior a un monto dado
CREATE OR REPLACE FUNCTION fn_VerificarPaqueteValor (
    p_IDCliente INT,
    p_ValorMaximo DOUBLE
)
RETURN BOOLEAN
IS
    resultado BOOLEAN;
BEGIN
    SELECT CASE
        WHEN MAX(ValorDeclarado) > p_ValorMaximo THEN TRUE
        ELSE FALSE
    END INTO resultado
    FROM Paquete
    JOIN Casillero ON Paquete.IDCasillero = Casillero.IDCasillero
    WHERE Casillero.IDCliente = p_IDCliente;

    RETURN resultado;
END;
/

-- Obtener el ID del casillero de un cliente
CREATE OR REPLACE FUNCTION fn_ObtenerIDCasillero (
    p_IDCliente INT
)
RETURN INT
IS
    idCasillero INT;
BEGIN
    SELECT IDCasillero INTO idCasillero
    FROM Casillero
    WHERE IDCliente = p_IDCliente;

    RETURN idCasillero;
END;
/

-- Verificar si un paquete está en un estado específico
CREATE OR REPLACE FUNCTION fn_VerificarEstadoPaquete (
    p_IDPaquete INT,
    p_Estado VARCHAR2
)
RETURN BOOLEAN
IS
    estado VARCHAR2(30);
BEGIN
    SELECT EstadoPaquete INTO estado
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;

    IF (estado = p_Estado) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
/

-- Obtener la dirección de un casillero
CREATE OR REPLACE FUNCTION fn_ObtenerDireccionCasillero (
    p_IDCasillero INT
)
RETURN VARCHAR2
IS
    direccion VARCHAR2(100);
BEGIN
    SELECT DireccionCasillero INTO direccion
    FROM Casillero
    WHERE IDCasillero = p_IDCasillero;

    RETURN direccion;
END;
/

