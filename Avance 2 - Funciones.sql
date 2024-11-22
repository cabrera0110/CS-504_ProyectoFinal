-- Obtener el estado de un paquete
CREATE FUNCTION fn_ObtenerEstadoPaquete(
    p_IDPaquete INT
)
RETURNS VARCHAR(30)
BEGIN
    DECLARE estado VARCHAR(30);
    SELECT EstadoPaquete INTO estado
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;
    RETURN estado;
END;

-- Calcular el total de paquetes de un cliente
CREATE FUNCTION fn_CalcularTotalPaquetesPorCliente(
    p_IDCliente INT
)
RETURNS INT
BEGIN
    DECLARE totalPaquetes INT;
    SELECT COUNT(*) INTO totalPaquetes
    FROM Paquete
    JOIN Casillero ON Paquete.IDCasillero = Casillero.IDCasillero
    WHERE Casillero.IDCliente = p_IDCliente;
    RETURN totalPaquetes;
END;

-- Obtener el valor declarado de un paquete
CREATE FUNCTION fn_ObtenerValorDeclarado(
    p_IDPaquete INT
)
RETURNS VARCHAR(30)
BEGIN
    DECLARE valor VARCHAR(30);
    SELECT ValorDeclarado INTO valor
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;
    RETURN valor;
END;

-- Calcular el peso total de los paquetes de un cliente
CREATE FUNCTION fn_CalcularPesoTotalPaquetes(
    p_IDCliente INT
)
RETURNS DOUBLE
BEGIN
    DECLARE pesoTotal DOUBLE;
    SELECT SUM(PesoPaquete) INTO pesoTotal
    FROM Paquete
    JOIN Casillero ON Paquete.IDCasillero = Casillero.IDCasillero
    WHERE Casillero.IDCliente = p_IDCliente;
    RETURN pesoTotal;
END;

-- Obtener el nombre de un cliente por su ID
CREATE FUNCTION fn_ObtenerNombreCliente(
    p_IDCliente INT
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT NombreCliente INTO nombre
    FROM Cliente
    WHERE IDCliente = p_IDCliente;
    RETURN nombre;
END;

-- Calcular el monto total de las facturas de un cliente
CREATE FUNCTION fn_CalcularMontoTotalFactura(
    p_IDCliente INT
)
RETURNS DOUBLE
BEGIN
    DECLARE total DOUBLE;
    SELECT SUM(MontoTotal) INTO total
    FROM Factura
    WHERE IDUsuario = p_IDCliente;
    RETURN total;
END;

-- Obtener el estado de pago de una factura
CREATE FUNCTION fn_ObtenerEstadoPagoFactura(
    p_IDFactura INT
)
RETURNS VARCHAR(30)
BEGIN
    DECLARE estado VARCHAR(30);
    SELECT EstadoPago INTO estado
    FROM Factura
    WHERE IDFactura = p_IDFactura;
    RETURN estado;
END;

-- Obtener el tipo de pago de una factura
CREATE FUNCTION fn_ObtenerMetodoPagoFactura(
    p_IDFactura INT
)
RETURNS VARCHAR(30)
BEGIN
    DECLARE metodoPago VARCHAR(30);
    SELECT MetodoPago INTO metodoPago
    FROM Factura
    WHERE IDFactura = p_IDFactura;
    RETURN metodoPago;
END;

-- Obtener el nombre del paquete por su ID
CREATE FUNCTION fn_ObtenerNombrePaquete(
    p_IDPaquete INT
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE nombre VARCHAR(100);
    SELECT Descripcion INTO nombre
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;
    RETURN nombre;
END;

-- Verificar si un paquete ya fue recibido
CREATE FUNCTION fn_VerificarPaqueteRecibido(
    p_IDPaquete INT
)
RETURNS BOOLEAN
BEGIN
    DECLARE recibido BOOLEAN;
    SELECT EstadoPaquete INTO recibido
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;
    IF (recibido = 'Recibido') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

-- Verificar si un cliente tiene un paquete con un valor superior a un monto dado
CREATE FUNCTION fn_VerificarPaqueteValor(
    p_IDCliente INT,
    p_ValorMaximo DOUBLE
)
RETURNS BOOLEAN
BEGIN
    DECLARE resultado BOOLEAN;
    SELECT CASE
        WHEN MAX(ValorDeclarado) > p_ValorMaximo THEN TRUE
        ELSE FALSE
    END INTO resultado
    FROM Paquete
    JOIN Casillero ON Paquete.IDCasillero = Casillero.IDCasillero
    WHERE Casillero.IDCliente = p_IDCliente;
    RETURN resultado;
END;

-- Obtener el ID del casillero de un cliente
CREATE FUNCTION fn_ObtenerIDCasillero(
    p_IDCliente INT
)
RETURNS INT
BEGIN
    DECLARE idCasillero INT;
    SELECT IDCasillero INTO idCasillero
    FROM Casillero
    WHERE IDCliente = p_IDCliente;
    RETURN idCasillero;
END;

-- Verificar si un paquete está en un estado específico
CREATE FUNCTION fn_VerificarEstadoPaquete(
    p_IDPaquete INT,
    p_Estado VARCHAR(30)
)
RETURNS BOOLEAN
BEGIN
    DECLARE estado VARCHAR(30);
    SELECT EstadoPaquete INTO estado
    FROM Paquete
    WHERE IDPaquete = p_IDPaquete;
    IF (estado = p_Estado) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

-- obtener la dirección de un casillero
CREATE FUNCTION fn_ObtenerDireccionCasillero(
    p_IDCasillero INT
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE direccion VARCHAR(100);
    SELECT DireccionCasillero INTO direccion
    FROM Casillero
    WHERE IDCasillero = p_IDCasillero;
    RETURN direccion;
END;
