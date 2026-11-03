CREATE TABLE cliente(
  dni VARCHAR(8) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  licencia VARCHAR(20) NOT NULL,
  direccion VARCHAR(50),

  CONSTRAINT pk_cliente
    PRIMARY KEY (dni)
);

CREATE TABLE Vendedor(
dni VARCHAR(8) NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
salario NUMERIC(10,2) NOT NULL,
bono NUMERIC(10,2) NOT NULL,
fecha_registro DATE NOT NULL,
correo VARCHAR(100),
supervisor_dni VARCHAR(8),

CONSTRAINT PK_Vendedor
  PRIMARY KEY (dni),

CONSTRAINT CK_Vendedor_salario
  check (salario >=0),
  
  CONSTRAINT CK_Vendedor_bono
  check (bono >=0)
  
);

CREATE TABLE carro(
  placa VARCHAR(10) NOT NULL,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  estado VARCHAR(15) NOT NULL,
  color VARCHAR(30) NOT NULL,
  anio INT NOT NULL,
  capacidad INT,

  CONSTRAINT pk_carro
    PRIMARY KEY (placa),
  CONSTRAINT ck_carro_estado
    CHECK (estado IN('disponible','alquilado')),
  CONSTRAINT ck_carro_anio
    CHECK (anio > 2000),
  CONSTRAINT ck_carro_capacidad
    CHECK (capacidad  IS NULL OR  capacidad > 0)
);


Create Table solicitud(
  solicitud_id INT NOT NULL,
  telefono VARCHAR(15) NOT NULL,
  tiempo_alquiler NUMERIC(10,2) NOT NULL,
  precio NUMERIC(10,2) NOT NULL,
  estado VARCHAR(20) NOT NULL,
  fecha_solicitud DATE NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  cliente_dni VARCHAR(8) NOT NULL,
  placa VARCHAR(10) NOT NULL,
  vendedor_dni VARCHAR(8) NOT NULL,

CONSTRAINT pk_solicitud
    PRIMARY KEY (solicitud_id),

  CONSTRAINT fk_solicitud_cliente
  FOREIGN KEY (cliente_dni)
  REFERENCES cliente(dni),

  CONSTRAINT fk_solicitud_carro
  FOREIGN KEY (placa)
  REFERENCES carro(placa),

  CONSTRAINT fk_solicitud_vendedor
  FOREIGN KEY (vendedor_dni)
  REFERENCES vendedor(dni),
  CONSTRAINT ck_solicitud_precio
  CHECK (precio >= 0),

  CONSTRAINT ck_solicitud_tiempo
  CHECK (tiempo_alquiler > 0),

  CONSTRAINT ck_solicitud_fechas
  CHECK (fecha_fin >= fecha_inicio AND 
          fecha_solicitud <= fecha_inicio)
  );

CREATE TABLE registro(
  registro_id SERIAL NOT NULL,
  cliente_dni VARCHAR(8) NOT NULL,
  solicitud_id INTEGER NOT NULL,
  vendedor_dni VARCHAR(8) NOT NULL,
  nombre VARCHAR(50),
  apellido VARCHAR(50),

  CONSTRAINT pk_registro
    PRIMARY KEY (registro_id),
  
  CONSTRAINT fk_registro_cliente
     FOREIGN KEY (cliente_dni)
     REFERENCES cliente(dni),

  CONSTRAINT fk_registro_solicitud
      FOREIGN KEY (solicitud_id)
      REFERENCES solicitud(solicitud_id),

  CONSTRAINT fk_registro_vendedor
      FOREIGN KEY (vendedor_dni)
      REFERENCES vendedor(dni),

  CONSTRAINT uk_registro_solicitud
      UNIQUE(solicitud_id)
);
  

