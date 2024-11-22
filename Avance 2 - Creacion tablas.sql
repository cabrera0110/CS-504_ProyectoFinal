-- Crear el esquema boxlyServicios
ALTER SESSION SET CONTAINER = XEPDB1;
CREATE USER boxlyServicios IDENTIFIED BY oracle123;
GRANT CONNECT, RESOURCE TO boxlyServicios;
ALTER SESSION SET CURRENT_SCHEMA = BOXLYSERVICIOS;

-- Crear la tabla Cliente
CREATE TABLE Cliente (
    IDCliente NUMBER PRIMARY KEY NOT NULL,
    NombreCliente VARCHAR2(30) NOT NULL,
    CorreoCliente VARCHAR2(30) NOT NULL,
    TelefonoCliente VARCHAR2(30),
    DireccionCliente VARCHAR2(100),
    NumeroCasillero NUMBER
);

-- Crear la tabla Casillero
CREATE TABLE Casillero (
    IDCasillero NUMBER PRIMARY KEY NOT NULL,
    IDCliente NUMBER,
    DireccionCasillero VARCHAR2(100)
);

-- Crear la tabla Paquete
CREATE TABLE Paquete (
    IDPaquete NUMBER PRIMARY KEY NOT NULL,
    IDCasillero NUMBER,
    Descripcion VARCHAR2(50),
    ValorDeclarado NUMBER(10, 2),
    PesoPaquete NUMBER(10, 2),
    EstadoPaquete VARCHAR2(30),
    FechaRecepcion DATE,
    FechaEntrega DATE
);

-- Crear la tabla Prealerta
CREATE TABLE Prealerta (
    IDPrealerta NUMBER PRIMARY KEY NOT NULL,
    IDPaquete NUMBER,
    FechaEnvio DATE,
    Courier VARCHAR2(50),
    NumeroRastro NUMBER,
    CostoTraida NUMBER(10, 2)
);

-- Crear la tabla Factura
CREATE TABLE Factura (
    IDFactura NUMBER PRIMARY KEY NOT NULL,
    IDUsuario NUMBER,
    MontoTotal NUMBER(10, 2),
    Fecha DATE,
    EstadoPago VARCHAR2(30),
    MetodoPago VARCHAR2(30)
);

-- Crear la tabla Notificaciones
CREATE TABLE Notificaciones (
    IDNotificacion NUMBER PRIMARY KEY NOT NULL,
    IDPaquete NUMBER NOT NULL,
    Mensaje VARCHAR2(255) NOT NULL,
    FechaNotificacion DATE NOT NULL
);

-- Asignar la clave foránea FK_IDcliente a la tabla Casillero
ALTER TABLE Casillero ADD CONSTRAINT FK_IDcliente FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCliente);

-- Asignar la clave foránea FK_IDpaquete a la tabla Prealerta
ALTER TABLE Prealerta ADD CONSTRAINT FK_IDpaquete FOREIGN KEY (IDPaquete) REFERENCES Paquete(IDPaquete);

-- Asignar la clave foránea FK_IDusuario a la tabla Factura
ALTER TABLE Factura ADD CONSTRAINT FK_IDusuario FOREIGN KEY (IDUsuario) REFERENCES Cliente(IDCliente);

-- Asignar la clave foránea FK_IDpaquete_Notificaciones a la tabla Notificaciones
ALTER TABLE Notificaciones ADD CONSTRAINT FK_IDpaquete_Notificaciones FOREIGN KEY (IDPaquete) REFERENCES Paquete(IDPaquete);

-- Asignar la clave foránea FK_IDCasillero a la tabla Paquete
ALTER TABLE Paquete ADD CONSTRAINT FK_IDCasillero FOREIGN KEY (IDCasillero) REFERENCES Casillero(IDCasillero);