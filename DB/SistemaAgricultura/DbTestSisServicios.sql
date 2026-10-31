CREATE DATABASE SistemaServicios;
GO

USE SistemaServicios;
GO

-- =============================================
-- 1. CLIENTE
-- =============================================
CREATE TABLE Cliente (
    id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    nombre VARCHAR(150) NOT NULL,
    fecha_registro DATE NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    estado_cliente BIT NOT NULL DEFAULT 1,
    motivo_bloqueo VARCHAR(250) NULL,
    fecha_bloqueo DATETIME NULL,

    CONSTRAINT PK_Cliente PRIMARY KEY (id)
);
GO

-- =============================================
-- 2. TIPOS DE SERVICIO
-- =============================================
CREATE TABLE TipoServicio (
    id INT IDENTITY(1,1) NOT NULL,
    nombre_tipo VARCHAR(100) NOT NULL,
    modalidad VARCHAR(50) NOT NULL,

    CONSTRAINT PK_TipoServicio PRIMARY KEY (id)
);
GO

-- =============================================
-- 3. SERVICIO
-- =============================================
CREATE TABLE Servicio (
    id BIGINT IDENTITY(1,1) NOT NULL,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    id_tipo INT NOT NULL,
    costo_mensual DECIMAL(10,2) NOT NULL,
    direccion_instalacion VARCHAR(250) NOT NULL,

    CONSTRAINT PK_Servicio PRIMARY KEY (id),

    CONSTRAINT FK_Servicio_Cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id),

    CONSTRAINT FK_Servicio_TipoServicio
        FOREIGN KEY (id_tipo)
        REFERENCES TipoServicio(id),

    CONSTRAINT CK_Servicio_Costo
        CHECK (costo_mensual >= 0)
);
GO

-- =============================================
-- 4. FACTURA
-- =============================================
CREATE TABLE Factura (
    id BIGINT IDENTITY(1,1) NOT NULL,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    serie VARCHAR(20) NOT NULL,
    fecha_emision DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    id_fel UNIQUEIDENTIFIER NULL,

    CONSTRAINT PK_Factura PRIMARY KEY (id),

    CONSTRAINT FK_Factura_Cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id),

    CONSTRAINT CK_Factura_Total
        CHECK (total >= 0)
);
GO

-- =============================================
-- 5. DETALLE DE FACTURA
-- =============================================
CREATE TABLE DetalleFactura (
    id BIGINT IDENTITY(1,1) NOT NULL,
    id_factura BIGINT NOT NULL,
    id_servicio BIGINT NOT NULL,
    tipo_servicio VARCHAR(100) NOT NULL,
    descuento_aplicado DECIMAL(10,2) NOT NULL DEFAULT 0,
    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_DetalleFactura PRIMARY KEY (id),

    CONSTRAINT FK_DetalleFactura_Factura
        FOREIGN KEY (id_factura)
        REFERENCES Factura(id),

    CONSTRAINT FK_DetalleFactura_Servicio
        FOREIGN KEY (id_servicio)
        REFERENCES Servicio(id),

    CONSTRAINT CK_DetalleFactura_Descuento
        CHECK (descuento_aplicado >= 0),

    CONSTRAINT CK_DetalleFactura_Subtotal
        CHECK (subtotal >= 0)
);
GO

-- =============================================
-- 6. DESCUENTO
-- =============================================
CREATE TABLE Descuento (
    id INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo_descuento VARCHAR(50) NOT NULL,
    porcentaje DECIMAL(5,2) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,

    CONSTRAINT PK_Descuento PRIMARY KEY (id),

    CONSTRAINT CK_Descuento_Porcentaje
        CHECK (porcentaje >= 0 AND porcentaje <= 100),

    CONSTRAINT CK_Descuento_Fechas
        CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);
GO

-- =============================================
-- 7. DETALLE DESCUENTO
-- Tabla intermedia entre DetalleFactura y Descuento
-- =============================================
CREATE TABLE DetalleDescuento (
    id_detalle_descuento BIGINT NOT NULL,
    id_descuento INT NOT NULL,
    monto_aplicado DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_DetalleDescuento
        PRIMARY KEY (id_detalle_descuento, id_descuento),

    CONSTRAINT FK_DetalleDescuento_DetalleFactura
        FOREIGN KEY (id_detalle_descuento)
        REFERENCES DetalleFactura(id),

    CONSTRAINT FK_DetalleDescuento_Descuento
        FOREIGN KEY (id_descuento)
        REFERENCES Descuento(id),

    CONSTRAINT CK_DetalleDescuento_Monto
        CHECK (monto_aplicado >= 0)
);
GO

-- =============================================
-- 8. PAGO
-- =============================================
CREATE TABLE Pago (
    id BIGINT IDENTITY(1,1) NOT NULL,
    id_cliente UNIQUEIDENTIFIER NOT NULL,
    id_factura BIGINT NOT NULL,
    fecha_pago DATETIME NOT NULL,
    costo_mensual DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL,
    referencia VARCHAR(100) NULL,

    CONSTRAINT PK_Pago PRIMARY KEY (id),

    CONSTRAINT FK_Pago_Cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Cliente(id),

    CONSTRAINT FK_Pago_Factura
        FOREIGN KEY (id_factura)
        REFERENCES Factura(id),

    CONSTRAINT CK_Pago_Costo
        CHECK (costo_mensual >= 0)
);
GO

-- =============================================
-- 9. EMPLEADO
-- =============================================
CREATE TABLE Empleado (
    id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    dpi CHAR(13) NOT NULL,
    puesto VARCHAR(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(150) NOT NULL,
    estado BIT NOT NULL DEFAULT 1,

    CONSTRAINT PK_Empleado PRIMARY KEY (id),

    CONSTRAINT UQ_Empleado_DPI UNIQUE (dpi),

    CONSTRAINT CK_Empleado_Salario
        CHECK (salario_base >= 0)
);
GO

-- =============================================
-- 10. NOMINA
-- =============================================
CREATE TABLE Nomina (
    id BIGINT IDENTITY(1,1) NOT NULL,
    id_empleado UNIQUEIDENTIFIER NOT NULL,
    fecha_pago DATE NOT NULL,
    nomina_a_pagar DECIMAL(10,2) NOT NULL,
    pasivo_laboral DECIMAL(10,2) NOT NULL,
    cuota_igss DECIMAL(10,2) NOT NULL,
    retencion_isr DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_Nomina PRIMARY KEY (id),

    CONSTRAINT FK_Nomina_Empleado
        FOREIGN KEY (id_empleado)
        REFERENCES Empleado(id),

    CONSTRAINT CK_Nomina_Valores
        CHECK (
            nomina_a_pagar >= 0
            AND pasivo_laboral >= 0
            AND cuota_igss >= 0
            AND retencion_isr >= 0
        )
);
GO