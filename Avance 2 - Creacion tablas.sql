-- Crear el esquema boxlyServicios
CREATE SCHEMA boxlyServicios;

-- Crear la tabla Cliente
CREATE TABLE Cliente (
    IDCliente int primary key not null,
    NombreCliente varchar(30) not null,
    CorreoCliente varchar(30) not null,
    TelefonoCliente varchar(30),
    DireccionCliente varchar(100),
    NumeroCasillero int
);

-- Crear la tabla Casillero
CREATE TABLE Casillero (
    IDCasillero int primary key not null,
    IDCliente int,
    DireccionCasillero varchar(100)
);

-- Crear la tabla Paquete
CREATE TABLE Paquete (
    IDPaquete int primary key not null,
    Descripcion varchar(50),
    ValorDeclarado varchar(30),
    PesoPaquete double,
    EstadoPaquete varchar(30),
    FechaRecepcion date,
    FechaEntrega date
);

-- Crear la tabla Prealerta
CREATE TABLE Prealerta (
    IDPrealerta int primary key not null,
    IDPaquete int,
    FechaEnvio date,
    Courier varchar(50),
    NumeroRastro int,
    CostoTraida double
);

-- Crear la tabla Factura
CREATE TABLE Factura (
    IDFactura int primary key not null,
    IDUsuario int,
    MontoTotal double,
    Fecha date,
    EstadoPago varchar(30),
    MetodoPago varchar(30)
);

-- Crear la tabla Notificaciones
CREATE TABLE Notificaciones (
    IDNotificacion int primary key not null auto_increment,
    IDPaquete int not null,
    Mensaje varchar(255) not null,
    FechaNotificacion datetime not null,
    foreign key (IDPaquete) references Paquete(IDPaquete)
);

-- Asignar la clave foránea FK_IDcliente a la tabla Casillero
ALTER TABLE casillero ADD CONSTRAINT FK_IDcliente foreign key (IDCliente) references Cliente(IDCliente);

-- Asignar la clave foránea FK_IDpaquete a la tabla Prealerta
ALTER TABLE prealerta ADD CONSTRAINT FK_IDpaquete foreign key (IDPaquete) references Paquete(IDPaquete);

-- Asignar la clave foránea FK_IDusuario a la tabla Factura
ALTER TABLE Factura ADD CONSTRAINT FK_IDusuario foreign key (IDUsuario) references Cliente(IDCliente);
