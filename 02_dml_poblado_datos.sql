--  =============================================================================
--  MÓDULO CLIENTE
--  Rregistro base de 5 clientes y actualzaciones de datos de contacto y direccion.
START TRANSACTION;

INSERT INTO cliente
(dni,nombre,apellido,telefono, licencia ,direccion)
VALUES
(59945620, 'Tulio', 'Perez', 991234567, 'LIC001', 'Arequipa'),
(69645328, 'Luis', 'Quispe', 987654321, 'LIC010', 'Cayma'),
(49975626, 'Sergio', 'Lopez', 976543210, 'LIC003', 'Paucarpata'),
(74145223, 'Pablo', 'Torres', 965432109, 'LIC007', 'Hunter'),
(90441524, 'Juan', 'Flores', 954321098, 'LIC020', 'Arequipa');

-- Actualización de dirección y teléfono de clientes
UPDATE cliente
SET direccion= 'Miraflores'
WHERE dni =49975626;

UPDATE cliente
SET telefono= '938294067'
WHERE nombre ='Tulio';

UPDATE cliente
SET apellido= 'Quispe Mamani'
WHERE licencia ='LIC010';

UPDATE cliente
SET direccion = 'Sachaca'
WHERE direccion ='Hunter';

UPDATE cliente
SET licencia = 'LIC015'
WHERE nombre ='Juan';

COMMIT; --Confirmación atómica: inserción e updates de la tabla cliente


--  =============================================================================
--  MÓDULO VENDEDOR
--  Registro de 5 vandedores y actualizaciones de datos laborales-
START TRANSACTION;

INSERT INTO vendedor
(dni, nombre, apellido, salario, bono, fecha_registro, correo, supervisor_dni)
VALUES
(87654321,'Carlos', 'Ramos',1800.50, 200.20, '2025-01-10', 'carlos1@gmail.com', NULL),
(76543218,'Rosa', 'Diaz',2000, 250, '2025-02-15', 'rosa2@gmail.com', 87654321),
(65432187,'Miguel', 'Soto',1900.50, 100.20, '2025-03-20', 'miguel3@gmail.com', 87654321),
(54321876,'Elena', 'Vargas',2100, 300.20, '2025-04-05', 'elena4@gmail.com', NULL),
(43218765,'Jorge', 'Castro',1850.50, 180.20, '2025-05-12', 'jorge5@gmail.com', NULL);

UPDATE vendedor
SET apellido='Rodriguez'
WHERE nombre='Carlos';

UPDATE vendedor
SET salario=1800
WHERE dni=76543218;

UPDATE vendedor
SET correo='miguel@gmail.com'
WHERE nombre='Miguel';

UPDATE vendedor
SET supervisor_dni=87654321
WHERE nombre='Elena';

UPDATE vendedor
SET fecha_registro='2025-05-21'
WHERE dni=43218765;

COMMIT; -- Confirmación atómica: gestión de datos del módulo vendedor


--  =============================================================================
--  MÓDULO CARRO
--  Alta de 5 vehículos y actualizaciones de estado y atributos.
START TRANSACTION;

INSERT INTO carro
(placa, marca, modelo, estado, color, anio, capacidad)
VALUES
('ABC123', 'Toyota', 'Corolla', 'disponible', 'Blanco', 2022, 5),
('DEF456', 'Hyundai', 'Accent', 'disponible', 'Negro', 2021, 5),
('GHI789', 'Kia', 'Rio', 'disponible', 'Rojo', 2023, 5),
('JKL321', 'Nissan', 'Versa', 'disponible' , 'Gris', 2022, 5),
('MNO654', 'Chevrolet', 'Tracker', 'disponible', 'Azul', 2024, 5);

-- Actualizaciones en la información del vehiculo
UPDATE carro
SET color = 'Plata'
WHERE placa = 'ABC123';

UPDATE carro
SET estado = 'mantenimiento'
WHERE placa = 'DEF456';

UPDATE carro
SET color = 'Negro Metalizado'
WHERE placa = 'JKL321';

UPDATE carro
SET estado = 'alquilado'
WHERE placa = 'JKL321';

UPDATE carro
SET capacidad = 7
WHERE placa = 'MNO654';

COMMIT; -- Confirmación atómica: mantenimiento del inventario vehicular


--  =============================================================================
--  MÓDULO SOLICITUD
--  Registro de 5 solicitudes  (conectadas con clientes, vendedores y autos válidos).
START TRANSACTION;

INSERT INTO solicitud
(solicitud_id, telefono, tiempo_alquiler, precio, estado, fecha_solicitud, fecha_inicio, fecha_fin, cliente_dni, placa, vendedor_dni)
VALUES
(1, 991234567, 5, 350.00, 'pendiente', '2025-03-05', '2025-03-07', '2025-03-10', 59945620, 'ABC123', 87654321),
(2, 987654321, 3, 240.00, 'aprobada',  '2025-04-04', '2025-04-06', '2025-04-10', 69645328, 'DEF456', 76543218),
(3, 976543210, 7, 560.00, 'aprobada',  '2025-05-05', '2025-05-07', '2025-05-09', 49975626, 'GHI789', 65432187),
(4, 965432109, 2, 180.00, 'pendiente', '2025-06-06', '2025-06-08', '2025-06-10', 74145223, 'JKL321', 54321876),
(5, 954321098, 10, 700.00, 'finalizado', '2025-07-07', '2025-07-09', '2025-07-11', 90441524, 'MNO654', 43218765);

-- Actualización de estado, precios y teléfonos en solicitudes
UPDATE solicitud
SET estado = 'aprobada'
WHERE solicitud_id = 1;

UPDATE solicitud
SET precio = 300.00
WHERE solicitud_id = 2;

UPDATE solicitud
SET fecha_fin= '2025-05-10'
WHERE solicitud_id = 3;

UPDATE solicitud
SET vendedor_dni = 43218765
WHERE solicitud_id = 4;

UPDATE solicitud
SET telefono = 903424520
WHERE solicitud_id = 5;

COMMIT; -- Confirmación atómica: procesamiento de solicitudes de alquiler


-- =============================================================================
-- MÓDULO REGISTRO
-- Registro de 5 contratos (vinculados a los DNI y solicitudes existentes).
START TRANSACTION;

INSERT INTO registro
(cliente_dni, solicitud_id, vendedor_dni, nombre, apellido)
VALUES
(59945620, 1, 87654321, 'Tulio', 'Perez'),
(69645328, 2, 76543218, 'Luis', 'Quispe'),
(49975626, 3, 65432187, 'Sergio', 'Lopez'),
(74145223, 4, 54321876, 'Pablo', 'Torres'),
(90441524, 5, 43218765, 'Juan', 'Flores');

-- Actualizaciones de apellidos completos en las fichas de registro
UPDATE registro
SET apellido = 'Perez Garcia'
WHERE solicitud_id = 1;

UPDATE registro
SET apellido = 'Lopez Beltzu'
WHERE solicitud_id = 2;

UPDATE registro
SET apellido = 'Quispe Medina'
WHERE solicitud_id = 3;

UPDATE registro
SET apellido = 'Torres Teran'
WHERE solicitud_id = 4;

UPDATE registro
SET apellido = 'Flores Palomino'
WHERE solicitud_id = 5;

COMMIT; -- Confirmación atómica: formalización de contratos e historial
