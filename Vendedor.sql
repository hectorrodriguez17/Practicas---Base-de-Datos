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
  check (bono >=0),
  
);
