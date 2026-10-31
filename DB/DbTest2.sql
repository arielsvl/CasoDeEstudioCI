CREATE DATABASE SistemaAgricola;
GO

USE SistemaAgricola;
GO

-- 1. EMPRESA
CREATE TABLE Empresa (
    idempresa INT IDENTITY(1,1) PRIMARY KEY,
    codempresa VARCHAR(50) NOT NULL UNIQUE,
    empresa VARCHAR(150) NOT NULL,
    nit VARCHAR(20),
    direccion VARCHAR(250),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID()
);
GO

-- 2. CLIENTE
CREATE TABLE Cliente (
    idcliente INT IDENTITY(1,1) PRIMARY KEY,
    codcliente VARCHAR(50) NOT NULL UNIQUE,
    codlocalidad VARCHAR(50),
    cliente VARCHAR(150) NOT NULL,
    direccion VARCHAR(250),
    nit VARCHAR(20),
    grupo VARCHAR(50),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID(),
    clientelegal VARCHAR(150),
    contrato VARCHAR(50),
    codtipocliente VARCHAR(50),
    exterior BIT DEFAULT 0
);
GO

-- 3. EMPLEADO
CREATE TABLE Empleado (
    idempleado INT IDENTITY(1,1) PRIMARY KEY,
    codempleado VARCHAR(50) NOT NULL UNIQUE,
    codlocalidad VARCHAR(50),
    codpuesto VARCHAR(50),
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    cedula VARCHAR(30),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID()
);
GO

-- 4. USUARIO
CREATE TABLE Usuario (
    idusuario INT IDENTITY(1,1) PRIMARY KEY,
    login VARCHAR(100) NOT NULL UNIQUE,
    codlocalidad VARCHAR(50),
    codperfil VARCHAR(50),
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    cedula VARCHAR(30),
    correo VARCHAR(150),
    password VARCHAR(255),
    historial VARCHAR(MAX),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID(),
    bloqueado BIT DEFAULT 0,
    impresora VARCHAR(100),
    tipopapel VARCHAR(50)
);
GO

-- 5. PROVEEDOR
CREATE TABLE Proveedor (
    idproveedor INT IDENTITY(1,1) PRIMARY KEY,
    codproveedor VARCHAR(50) NOT NULL UNIQUE,
    codlocalidad VARCHAR(50),
    proveedor VARCHAR(150) NOT NULL,
    direccion VARCHAR(250),
    nit VARCHAR(20),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID(),
    proveedorlegal VARCHAR(150)
);
GO

-- 6. PRODUCTO
CREATE TABLE Producto (
    idproducto INT IDENTITY(1,1) PRIMARY KEY,
    codproducto VARCHAR(50) NOT NULL UNIQUE,
    codlocalidad VARCHAR(50),
    producto VARCHAR(150) NOT NULL,
    laboratorio VARCHAR(100),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID(),
    Abreviatura VARCHAR(30),
    DescAbreviatura VARCHAR(100),
    AplicaTaraFinMes BIT DEFAULT 0,
    AplicaTaraAutomatica BIT DEFAULT 0,
    Aplica_NoEnvio_Manual BIT DEFAULT 0,
    Restriccion_Vehiculo BIT DEFAULT 0
);
GO

-- 7. FINCA
CREATE TABLE Finca (
    idfinca INT IDENTITY(1,1) PRIMARY KEY,
    codempresa VARCHAR(50) NOT NULL,
    codfinca VARCHAR(50) NOT NULL,
    finca VARCHAR(150) NOT NULL,
    codempresaow VARCHAR(50),
    codfincaow VARCHAR(50),
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID(),

    CONSTRAINT UQ_Finca_Empresa_Codigo
        UNIQUE (codempresa, codfinca),

    CONSTRAINT FK_Finca_Empresa
        FOREIGN KEY (codempresa)
        REFERENCES Empresa(codempresa)
);
GO

-- 8. PIPA
CREATE TABLE Pipa (
    idpipa INT IDENTITY(1,1) PRIMARY KEY,
    codpipa VARCHAR(50) NOT NULL UNIQUE,
    codtransportista VARCHAR(50),
    codlocalidad VARCHAR(50),
    codtipovehiculo VARCHAR(50),
    numero VARCHAR(50),
    capacidad DECIMAL(18,2),
    especificacion VARCHAR(250),
    tara DECIMAL(18,2),
    ftara DATETIME2,
    rowguid UNIQUEIDENTIFIER DEFAULT NEWID(),
    unidadnegocio VARCHAR(100),
    activo BIT DEFAULT 1,
    Propio BIT DEFAULT 0,
    UT_UMT VARCHAR(50),
    Estado VARCHAR(50),
    PlacaNac VARCHAR(30),
    TiempoRestriccion INT
);
GO

-- 9. ENVIO
CREATE TABLE Envio (
    idenvio INT IDENTITY(1,1) PRIMARY KEY,

    codenvio VARCHAR(50) NOT NULL UNIQUE,
    noenvio VARCHAR(50),

    codestado VARCHAR(50),
    idtipodoc INT,
    idtipomov INT,
    codconvoy VARCHAR(50),

    codlocalidad VARCHAR(50),
    codcliente VARCHAR(50) NOT NULL,
    codproveedor VARCHAR(50),
    codempresa VARCHAR(50) NOT NULL,
    codfinca VARCHAR(50) NOT NULL,
    codlote VARCHAR(50),
    codtanque VARCHAR(50),

    codpipa VARCHAR(50),
    codcabezal VARCHAR(50),
    codpesador VARCHAR(50),
    codsupervisor VARCHAR(50),
    codpiloto VARCHAR(50),
    codagente VARCHAR(50),

    fecha DATETIME2 NOT NULL,
    fcierre DATETIME2,
    ftara DATETIME2,

    fbruto DECIMAL(18,2),
    ptara DECIMAL(18,2),
    pbruto DECIMAL(18,2),

    umt VARCHAR(30),
    umb VARCHAR(30),

    racimos INT,
    sacos INT,
    pacas INT,

    autorizacion VARCHAR(100),
    marchamo VARCHAR(100),
    candado VARCHAR(100),
    observacion VARCHAR(MAX),

    transferido BIT DEFAULT 0,

    codproducto VARCHAR(50) NOT NULL,
    codlaboratorista VARCHAR(50),
    flaboratorio DATETIME2,

    CONSTRAINT FK_Envio_Cliente
        FOREIGN KEY (codcliente)
        REFERENCES Cliente(codcliente),

    CONSTRAINT FK_Envio_Empresa
        FOREIGN KEY (codempresa)
        REFERENCES Empresa(codempresa),

    CONSTRAINT FK_Envio_Proveedor
        FOREIGN KEY (codproveedor)
        REFERENCES Proveedor(codproveedor),

    CONSTRAINT FK_Envio_Producto
        FOREIGN KEY (codproducto)
        REFERENCES Producto(codproducto),

    CONSTRAINT FK_Envio_Pipa
        FOREIGN KEY (codpipa)
        REFERENCES Pipa(codpipa),

    CONSTRAINT FK_Envio_Finca
        FOREIGN KEY (codempresa, codfinca)
        REFERENCES Finca(codempresa, codfinca),

    CONSTRAINT FK_Envio_Pesador
        FOREIGN KEY (codpesador)
        REFERENCES Empleado(codempleado),

    CONSTRAINT FK_Envio_Supervisor
        FOREIGN KEY (codsupervisor)
        REFERENCES Empleado(codempleado),

    CONSTRAINT FK_Envio_Piloto
        FOREIGN KEY (codpiloto)
        REFERENCES Empleado(codempleado),

    CONSTRAINT FK_Envio_Agente
        FOREIGN KEY (codagente)
        REFERENCES Empleado(codempleado)
);
GO