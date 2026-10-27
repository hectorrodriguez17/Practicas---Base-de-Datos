CREATE TABLE carro(
  placa VARCHAR(10) NOT NULL,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  estado VARCHAR(15) NOT NULL,
  color VARCHAR(30) NOT NULL,
  anio YEAR NOT NULL,
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
