CREATE TABLE sucursal (
    sucursal_id SERIAL,
    nombre VARCHAR(80) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,

    CONSTRAINT pk_sucursal PRIMARY KEY (sucursal_id),
    CONSTRAINT uk_sucursal_nombre UNIQUE (nombre)
);

CREATE TABLE categoria (
    categoria_id SERIAL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    tarifa_diaria NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_categoria PRIMARY KEY (categoria_id),
    CONSTRAINT uk_categoria_nombre UNIQUE (nombre),
    CONSTRAINT ck_categoria_tarifa CHECK (tarifa_diaria > 0)
);

CREATE TABLE cliente (
    dni VARCHAR(15) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    licencia VARCHAR(20) NOT NULL,
    direccion VARCHAR(150),
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,

    CONSTRAINT pk_cliente PRIMARY KEY (dni),
    CONSTRAINT uk_cliente_correo UNIQUE (correo),
    CONSTRAINT uk_cliente_licencia UNIQUE (licencia)
);

CREATE TABLE seguro (
    seguro_id SERIAL,
    nombre VARCHAR(60) NOT NULL,
    cobertura VARCHAR(200) NOT NULL,
    costo_diario NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_seguro PRIMARY KEY (seguro_id),
    CONSTRAINT uk_seguro_nombre UNIQUE (nombre),
    CONSTRAINT ck_seguro_costo CHECK (costo_diario >= 0)
);

CREATE TABLE vendedor (
    dni VARCHAR(15) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    salario NUMERIC(10,2) NOT NULL,
    bono NUMERIC(10,2) NOT NULL DEFAULT 0,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE,
    correo VARCHAR(100) NOT NULL,
    supervisor_dni VARCHAR(15),
    sucursal_id INTEGER,

    CONSTRAINT pk_vendedor PRIMARY KEY (dni),
    CONSTRAINT uk_vendedor_correo UNIQUE (correo),
    CONSTRAINT fk_vendedor_supervisor FOREIGN KEY (supervisor_dni)
        REFERENCES vendedor(dni)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT fk_vendedor_sucursal FOREIGN KEY (sucursal_id)
        REFERENCES sucursal(sucursal_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT ck_vendedor_salario CHECK (salario >= 0),
    CONSTRAINT ck_vendedor_bono CHECK (bono >= 0),
    CONSTRAINT ck_vendedor_no_autosupervisor CHECK (supervisor_dni IS NULL OR supervisor_dni <> dni)
);

CREATE TABLE carro (
    placa VARCHAR(10) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    color VARCHAR(30) NOT NULL,
    anio INTEGER NOT NULL,
    capacidad INTEGER NOT NULL,
    kilometraje INTEGER NOT NULL DEFAULT 0,
    categoria_id INTEGER NOT NULL,
    sucursal_id INTEGER,

    CONSTRAINT pk_carro PRIMARY KEY (placa),
    CONSTRAINT fk_carro_categoria FOREIGN KEY (categoria_id)
        REFERENCES categoria(categoria_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_carro_sucursal FOREIGN KEY (sucursal_id)
        REFERENCES sucursal(sucursal_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT ck_carro_estado CHECK (estado IN ('disponible', 'alquilado', 'mantenimiento', 'inactivo')),
    CONSTRAINT ck_carro_anio CHECK (anio > 2000),
    CONSTRAINT ck_carro_capacidad CHECK (capacidad > 0),
    CONSTRAINT ck_carro_kilometraje CHECK (kilometraje >= 0)
);

CREATE TABLE solicitud (
    solicitud_id SERIAL,
    tiempo_alquiler INTEGER NOT NULL, 
    precio_total NUMERIC(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    fecha_solicitud DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    cliente_dni VARCHAR(15) NOT NULL,
    placa VARCHAR(10) NOT NULL,
    vendedor_dni VARCHAR(15),

    CONSTRAINT pk_solicitud PRIMARY KEY (solicitud_id),
    CONSTRAINT fk_solicitud_cliente FOREIGN KEY (cliente_dni)
        REFERENCES cliente(dni)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_carro FOREIGN KEY (placa)
        REFERENCES carro(placa)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_solicitud_vendedor FOREIGN KEY (vendedor_dni)
        REFERENCES vendedor(dni)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT ck_solicitud_tiempo CHECK (tiempo_alquiler > 0),
    CONSTRAINT ck_solicitud_precio CHECK (precio_total >= 0),
    CONSTRAINT ck_solicitud_estado CHECK (estado IN ('pendiente', 'confirmada', 'en_curso', 'finalizada', 'cancelada')),
    CONSTRAINT ck_solicitud_fechas CHECK (fecha_fin >= fecha_inicio AND fecha_solicitud <= fecha_inicio)
);

CREATE TABLE solicitud_seguro (
    solicitud_id INTEGER NOT NULL,
    seguro_id INTEGER NOT NULL,
    subtotal NUMERIC(10,2) NOT NULL,

    CONSTRAINT pk_solicitud_seguro PRIMARY KEY (solicitud_id, seguro_id),
    CONSTRAINT fk_solseg_solicitud FOREIGN KEY (solicitud_id)
        REFERENCES solicitud(solicitud_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_solseg_seguro FOREIGN KEY (seguro_id)
        REFERENCES seguro(seguro_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT ck_solseg_subtotal CHECK (subtotal >= 0)
);

CREATE TABLE registro (
    registro_id SERIAL,
    solicitud_id INTEGER NOT NULL,
    vendedor_dni VARCHAR(15),
    fecha_entrega TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion TIMESTAMP,
    kilometraje_inicial INTEGER NOT NULL,
    kilometraje_final INTEGER,
    combustible_entrega VARCHAR(20) NOT NULL,
    observaciones TEXT,

    CONSTRAINT pk_registro PRIMARY KEY (registro_id),
    CONSTRAINT uk_registro_solicitud UNIQUE (solicitud_id),
    CONSTRAINT fk_registro_solicitud FOREIGN KEY (solicitud_id)
        REFERENCES solicitud(solicitud_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_registro_vendedor FOREIGN KEY (vendedor_dni)
        REFERENCES vendedor(dni)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT ck_registro_km_inicial CHECK (kilometraje_inicial >= 0),
    CONSTRAINT ck_registro_km_final CHECK (kilometraje_final IS NULL OR kilometraje_final >= kilometraje_inicial),
    CONSTRAINT ck_registro_combustible CHECK (combustible_entrega IN ('vacio', 'un_cuarto', 'medio', 'tres_cuartos', 'lleno')),
    CONSTRAINT ck_registro_fechas CHECK (fecha_devolucion IS NULL OR fecha_devolucion >= fecha_entrega)
);

CREATE TABLE pago (
    pago_id SERIAL,
    solicitud_id INTEGER NOT NULL,
    monto NUMERIC(10,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'completado',
    fecha_pago TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    codigo_operacion VARCHAR(50),

    CONSTRAINT pk_pago PRIMARY KEY (pago_id),
    CONSTRAINT uk_pago_codigo UNIQUE (codigo_operacion),
    CONSTRAINT fk_pago_solicitud FOREIGN KEY (solicitud_id)
        REFERENCES solicitud(solicitud_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT ck_pago_monto CHECK (monto > 0),
    CONSTRAINT ck_pago_metodo CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia', 'yape_plin')),
    CONSTRAINT ck_pago_estado CHECK (estado IN ('pendiente', 'completado', 'reembolsado', 'fallido'))
);

CREATE TABLE mantenimiento (
    mantenimiento_id SERIAL,
    placa VARCHAR(10) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    costo NUMERIC(10,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,

    CONSTRAINT pk_mantenimiento PRIMARY KEY (mantenimiento_id),
    CONSTRAINT fk_mantenimiento_carro FOREIGN KEY (placa)
        REFERENCES carro(placa)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT ck_mantenimiento_tipo CHECK (tipo IN ('preventivo', 'correctivo', 'limpieza', 'inspeccion')),
    CONSTRAINT ck_mantenimiento_costo CHECK (costo >= 0),
    CONSTRAINT ck_mantenimiento_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE incidente (
    incidente_id SERIAL,
    registro_id INTEGER NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    descripcion VARCHAR(250) NOT NULL,
    monto_penalidad NUMERIC(10,2) NOT NULL,
    fecha_incidente DATE NOT NULL DEFAULT CURRENT_DATE,
    pagado BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_incidente PRIMARY KEY (incidente_id),
    CONSTRAINT fk_incidente_registro FOREIGN KEY (registro_id)
        REFERENCES registro(registro_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT ck_incidente_tipo CHECK (tipo IN ('danio', 'multa', 'retraso', 'robo', 'otro')),
    CONSTRAINT ck_incidente_penalidad CHECK (monto_penalidad >= 0)
);

