CREATE TABLE sucursal (
    sucursal_id INT NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,

    CONSTRAINT pk_sucursal PRIMARY KEY (sucursal_id)
);

CREATE TABLE categoria (
    categoria_id INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    tarifa_diaria NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_categoria PRIMARY KEY (categoria_id),
    CONSTRAINT ck_categoria_tarifa CHECK (tarifa_diaria > 0)
);

CREATE TABLE cliente (
    dni VARCHAR(8) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100),
    licencia VARCHAR(20) NOT NULL,
    direccion VARCHAR(100),
    fecha_registro DATE NOT NULL,

    CONSTRAINT pk_cliente PRIMARY KEY (dni)
);

CREATE TABLE seguro (
    seguro_id INT NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    cobertura VARCHAR(200) NOT NULL,
    costo_diario NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_seguro PRIMARY KEY (seguro_id),
    CONSTRAINT ck_seguro_costo CHECK (costo_diario >= 0)
);

CREATE TABLE vendedor (
    dni VARCHAR(8) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    salario NUMERIC(10,2) NOT NULL,
    bono NUMERIC(10,2) NOT NULL DEFAULT 0,
    fecha_registro DATE NOT NULL,
    correo VARCHAR(100),
    supervisor_dni VARCHAR(8),
    sucursal_id INT,

    CONSTRAINT pk_vendedor PRIMARY KEY (dni),
    CONSTRAINT fk_vendedor_supervisor FOREIGN KEY (supervisor_dni)
        REFERENCES vendedor(dni),
    CONSTRAINT fk_vendedor_sucursal FOREIGN KEY (sucursal_id)
        REFERENCES sucursal(sucursal_id),
    CONSTRAINT ck_vendedor_salario CHECK (salario >= 0),
    CONSTRAINT ck_vendedor_bono CHECK (bono >= 0),
    CONSTRAINT ck_vendedor_supervisor CHECK (supervisor_dni IS NULL OR supervisor_dni <> dni)
);

CREATE TABLE carro (
    placa VARCHAR(10) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    color VARCHAR(30) NOT NULL,
    anio INT NOT NULL,
    capacidad INT,
    kilometraje INT NOT NULL,
    categoria_id INT NOT NULL,
    sucursal_id INT,

    CONSTRAINT pk_carro PRIMARY KEY (placa),
    CONSTRAINT fk_carro_categoria FOREIGN KEY (categoria_id)
        REFERENCES categoria(categoria_id),
    CONSTRAINT fk_carro_sucursal FOREIGN KEY (sucursal_id)
        REFERENCES sucursal(sucursal_id)
);

CREATE TABLE solicitud (
    solicitud_id INT NOT NULL,
    tiempo_alquiler INT NOT NULL,
    precio_total NUMERIC(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    cliente_dni VARCHAR(8) NOT NULL,
    placa VARCHAR(10) NOT NULL,
    vendedor_dni VARCHAR(8) NOT NULL,

    CONSTRAINT pk_solicitud PRIMARY KEY (solicitud_id),
    CONSTRAINT fk_solicitud_cliente FOREIGN KEY (cliente_dni)
        REFERENCES cliente(dni),
    CONSTRAINT fk_solicitud_carro FOREIGN KEY (placa)
        REFERENCES carro(placa),
    CONSTRAINT fk_solicitud_vendedor FOREIGN KEY (vendedor_dni)
        REFERENCES vendedor(dni),
    CONSTRAINT ck_solicitud_tiempo CHECK (tiempo_alquiler > 0),
    CONSTRAINT ck_solicitud_precio CHECK (precio_total >= 0),
    CONSTRAINT ck_solicitud_fechas CHECK (fecha_fin >= fecha_inicio AND fecha_solicitud <= fecha_inicio)
);

CREATE TABLE solicitud_seguro (
    solicitud_id INT NOT NULL,
    seguro_id INT NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_solicitud_seguro PRIMARY KEY (solicitud_id, seguro_id),
    CONSTRAINT fk_solseg_solicitud FOREIGN KEY (solicitud_id)
        REFERENCES solicitud(solicitud_id),
    CONSTRAINT fk_solseg_seguro FOREIGN KEY (seguro_id)
        REFERENCES seguro(seguro_id),
    CONSTRAINT ck_solseg_subtotal CHECK (subtotal >= 0)
);

CREATE TABLE registro (
    registro_id INT NOT NULL,
    solicitud_id INT NOT NULL,
    vendedor_dni VARCHAR(8) NOT NULL,
    fecha_entrega DATE NOT NULL,
    fecha_devolucion DATE,
    kilometraje_inicial INT NOT NULL,
    kilometraje_final INT,
    observaciones VARCHAR(250),

    CONSTRAINT pk_registro PRIMARY KEY (registro_id),
    CONSTRAINT uk_registro_solicitud UNIQUE (solicitud_id),
    CONSTRAINT fk_registro_solicitud FOREIGN KEY (solicitud_id)
        REFERENCES solicitud(solicitud_id),
    CONSTRAINT fk_registro_vendedor FOREIGN KEY (vendedor_dni)
        REFERENCES vendedor(dni),
    CONSTRAINT ck_registro_km_inicial CHECK (kilometraje_inicial >= 0),
    CONSTRAINT ck_registro_km_final CHECK (kilometraje_final IS NULL OR kilometraje_final >= kilometraje_inicial),
    CONSTRAINT ck_registro_fechas CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_entrega)
);

CREATE TABLE pago (
    pago_id INT NOT NULL,
    solicitud_id INT NOT NULL,
    monto NUMERIC(10,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_pago DATE NOT NULL,

    CONSTRAINT pk_pago PRIMARY KEY (pago_id),
    CONSTRAINT fk_pago_solicitud FOREIGN KEY (solicitud_id)
        REFERENCES solicitud(solicitud_id),
    CONSTRAINT ck_pago_monto CHECK (monto > 0)
);

CREATE TABLE mantenimiento (
    mantenimiento_id INT NOT NULL,
    placa VARCHAR(10) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    costo NUMERIC(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,

    CONSTRAINT pk_mantenimiento PRIMARY KEY (mantenimiento_id),
    CONSTRAINT fk_mantenimiento_carro FOREIGN KEY (placa)
        REFERENCES carro(placa),
    CONSTRAINT ck_mantenimiento_costo CHECK (costo >= 0),
    CONSTRAINT ck_mantenimiento_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE incidente (
    incidente_id INT NOT NULL,
    registro_id INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    monto_penalidad NUMERIC(10,2) NOT NULL,
    fecha_incidente DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,

    CONSTRAINT pk_incidente PRIMARY KEY (incidente_id),
    CONSTRAINT fk_incidente_registro FOREIGN KEY (registro_id)
        REFERENCES registro(registro_id),
    CONSTRAINT ck_incidente_penalidad CHECK (monto_penalidad >= 0)
);
