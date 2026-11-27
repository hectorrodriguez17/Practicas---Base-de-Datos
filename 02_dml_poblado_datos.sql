INSERT INTO sucursal (sucursal_id, nombre, direccion, ciudad, telefono) -- Insert para la tabla sucursal respetando los datos solicitados en la tabla
VALUES
(1, 'Sede Cercado', 'Av. Ejercito 105', 'Arequipa', '054214589'),
(2, 'Sede Cayma', 'Av. Cayma 412', 'Arequipa', '054258963'),
(3, 'Sede Yanahuara', 'Calle Misti 210', 'Arequipa', '054274125'),
(4, 'Sede Cerro Colorado', 'Av. Aviacion 850', 'Arequipa', '054312547'),
(5, 'Sede Bustamante', 'Av. Dolores 320', 'Arequipa', '054425874');

--Updates de los datos ya existentes de la tabla sucrusal usando Where y accediendo directamente desde la llave primaria
UPDATE sucursal
SET telefono = '054219999'
WHERE sucursal_id = 1;

UPDATE sucursal
SET direccion = 'Av. Cayma 500'
WHERE sucursal_id = 2;

UPDATE sucursal
SET nombre = 'Sede Yanahuara Plaza'
WHERE sucursal_id = 3;

UPDATE sucursal
SET telefono = '054318888'
WHERE sucursal_id = 4;

UPDATE sucursal
SET direccion = 'Av. Dolores 415'
WHERE sucursal_id = 5;

INSERT INTO cliente (dni, nombre, apellido, telefono, correo, licencia, direccion, fecha_registro) -- Insert para la tabla cliente respetando los datos solicitados en la tabla
VALUES
('59945620', 'Tulio', 'Perez', '991234567', 'tulio@gmail.com', 'LIC001', 'Arequipa', '2025-01-15'),
('69645328', 'Luis', 'Quispe', '987654321', 'luis@gmail.com', 'LIC010', 'Cayma', '2025-02-10'),
('49975626', 'Sergio', 'Lopez', '976543210', 'sergio@gmail.com', 'LIC003', 'Paucarpata', '2025-03-01'),
('74145223', 'Pablo', 'Torres', '965432109', 'pablo@gmail.com', 'LIC007', 'Hunter', '2025-04-12'),
('90441524', 'Juan', 'Flores', '954321098', 'juan@gmail.com', 'LIC020', 'Arequipa', '2025-05-20');

-- Updates de los datos ya existentes en la tabla cliente usando Where y usando distitnos valores para poder actualizar los datos donde se desea (como dni, nombre, licencia, etc)
UPDATE cliente
SET direccion = 'Miraflores'
WHERE dni = '49975626';

UPDATE cliente
SET telefono = '938294067'
WHERE nombre = 'Tulio';

UPDATE cliente
SET apellido = 'Quispe Mamani'
WHERE licencia = 'LIC010';

UPDATE cliente
SET direccion = 'Sachaca'
WHERE direccion = 'Hunter';

UPDATE cliente
SET licencia = 'LIC015'
WHERE nombre = 'Juan';

INSERT INTO vendedor (dni, nombre, apellido, salario, bono, fecha_registro, correo, supervisor_dni, sucursal_id)
VALUES
('87654321', 'Carlos', 'Ramos', 1800.50, 200.20, '2025-01-10', 'carlos1@gmail.com', NULL, 1),
('76543218', 'Rosa', 'Diaz', 2000.00, 250.00, '2025-02-15', 'rosa2@gmail.com', '87654321', 1),
('65432187', 'Miguel', 'Soto', 1900.50, 100.20, '2025-03-20', 'miguel3@gmail.com', '87654321', 2),
('54321876', 'Elena', 'Vargas', 2100.00, 300.20, '2025-04-05', 'elena4@gmail.com', NULL, 3),
('43218765', 'Jorge', 'Castro', 1850.50, 180.20, '2025-05-12', 'jorge5@gmail.com', NULL, 4);

UPDATE vendedor
SET apellido = 'Rodriguez'
WHERE nombre = 'Carlos';

UPDATE vendedor
SET salario = 1800.00
WHERE dni = '76543218';

UPDATE vendedor
SET correo = 'miguel@gmail.com'
WHERE nombre = 'Miguel';

UPDATE vendedor
SET supervisor_dni = '87654321'
WHERE nombre = 'Elena';

UPDATE vendedor
SET fecha_registro = '2025-05-21'
WHERE dni = '43218765';

INSERT INTO carro (placa, marca, modelo, estado, color, anio, capacidad, kilometraje, categoria_id, sucursal_id)
VALUES
('ABC123', 'Toyota', 'Corolla', 'disponible', 'Blanco', 2022, 5, 15000, 2, 1),
('DEF456', 'Hyundai', 'Accent', 'disponible', 'Negro', 2021, 5, 28000, 1, 1),
('GHI789', 'Kia', 'Rio', 'disponible', 'Rojo', 2023, 5, 9500, 1, 2),
('JKL321', 'Nissan', 'Versa', 'disponible', 'Gris', 2022, 5, 19200, 2, 3),
('MNO654', 'Chevrolet', 'Tracker', 'disponible', 'Azul', 2024, 5, 5000, 3, 4);

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

INSERT INTO solicitud (solicitud_id, tiempo_alquiler, precio_total, estado, fecha_solicitud, fecha_inicio, fecha_fin, cliente_dni, placa, vendedor_dni)
VALUES
(1, 3, 350.00, 'pendiente', '2025-03-05', '2025-03-07', '2025-03-10', '59945620', 'ABC123', '87654321'),
(2, 4, 240.00, 'aprobada', '2025-04-04', '2025-04-06', '2025-04-10', '69645328', 'DEF456', '76543218'),
(3, 2, 560.00, 'aprobada', '2025-05-05', '2025-05-07', '2025-05-09', '49975626', 'GHI789', '65432187'),
(4, 2, 180.00, 'pendiente', '2025-06-06', '2025-06-08', '2025-06-10', '74145223', 'JKL321', '54321876'),
(5, 2, 700.00, 'finalizada', '2025-07-07', '2025-07-09', '2025-07-11', '90441524', 'MNO654', '43218765');

UPDATE solicitud
SET estado = 'aprobada'
WHERE solicitud_id = 1;

UPDATE solicitud
SET precio_total = 300.00
WHERE solicitud_id = 2;

UPDATE solicitud
SET fecha_fin = '2025-05-10'
WHERE solicitud_id = 3;

UPDATE solicitud
SET vendedor_dni = '43218765'
WHERE solicitud_id = 4;

UPDATE solicitud
SET estado = 'completada'
WHERE solicitud_id = 5;
