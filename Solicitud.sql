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
  CONSTRAINT fk_solicitud_cliente
  FOREIGN KEY (cliente_dni)
  REFERENCES cliente(dni),

  CONSTRAINT fk_solicitud_carro
  FOREIGN KEY (placa)
  REFERENCES carro(placa),

  CONSTRAINT fk_solicitud_vendedor
  FOREIGN KEY (vendedor_dni)
  REFERENCES vendedor(dni)
  CONSTRAINT ck_solicitud_precio
  CHECK (precio >= 0),

  CONSTRAINT ck_solicitud_tiempo
  CHECK (tiempo_alquiler > 0)
  CONSTRAINT ck_solicitud_fechas
  CHECK (fecha_fin >= fecha_inicio AND 
          fecha_solicitud <= fecha_inicio)
  );
