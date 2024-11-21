-- Creación Tablas
CREATE SCHEMA boxlyServicios;
CREATE TABLE Cliente (IDCliente int primary key not null, NombreCliente varchar(30) not null, CorreoCliente varchar(30) not null, TelofonoCliente varchar(30), DireccionCliente varchar(100), NumeroCasillero int);
CREATE TABLE Casillero (IDCasillero int primary key not null, IDCliente int, DireccionCasillero varchar(100));
CREATE TABLE Paquete (IDPaquete int primary key not null, Descripcion varchar(50), ValorDeclarado varchar(30), PesoPaquete double, EstadoPaquete varchar(30), FechaRecepcion date, FechaEntrega date);
CREATE TABLE Prealerta (IDPrealerta int primary key not null, IDPaquete int, FechaEnvio date, Courier varchar(50), NumeroRastro int, CostoTraida double); 
CREATE TABLE Factura (IDFactura int primary key not null, IDUsuario int, MontoTotal double, Fecha date, EstadoPago varchar(30), MetodoPago varchar(30));

-- Asignacion de las foreign key
ALTER TABLE casillero ADD CONSTRAINT FK_IDcliente foreign key (IDCliente) references Cliente(IDCliente);
ALTER TABLE prealerta ADD CONSTRAINT FK_IDpaquete foreign key (IDPaquete) references Paquete(IDPaquete);
ALTER TABLE Factura ADD CONSTRAINT FK_IDusuario foreign key (IDUsuario) references Cliente(IDCliente);