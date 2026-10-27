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
};
  
