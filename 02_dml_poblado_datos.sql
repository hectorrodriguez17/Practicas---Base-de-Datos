INSERT INTO cliente
(dni,nombre,apellido,telefono, licencia ,direccion)
VALUES
(59945620,'Tulio','Perez',991234567,'LIC001','Arequipa'),
(69645328,'Luis','Quispe',991234567,'LIC010','Cayma'),
(49975626,'Sergio','Lopez',991234567,'LIC003','Paucarpata'),
(74145223,'Pablo','Torres',991234567,'LIC007','Hunter'),
(90441524,'Juan','Flores',991234567,'LIC020','Arequipa');

UPDATE cliente
SET direccion= 'Miraflores'
WHERE dni =49975626;

UPDATE cliente
SET telefono= '938294067'
WHERE nombre ='Tulio';

UPDATE cliente
SET apellido= '938294067'
WHERE licencia ='LIC010';

UPDATE cliente
SET nombre= 'barcobasurero'
WHERE direccion ='Hunter';

UPDATE cliente
SET licencia = 'LIC015'
WHERE nombre ='Juan';

INSERT INTO vendedor
(dni, nombre, aprellido, salario, bono, fecha_registro, correo, supervisor_dni)
VALUES
(87654321,'Carlos', 'Ramos',1800.50, 200.20, '2025-01-10', 'carlos1@gmail.com', NULL)
(76543218,'Rosa', 'Diaz',2000, 250, '2025-02-15', 'rosa2@gmail.com', 87654321)
(65432187,'Miguel', 'Soto',1900.50, 100.20, '2025-03-20', 'miguel3@gmail.com', 87654321)
(54321876,'Elena', 'Vargas',2100, 300.20, '2025-04-05', 'elena4@gmail.com', NULL)
(43218765,'Jorge', 'Castro',1850.50, 180.20, '2025-05-12', 'jorge5@gmail.com', NULL)

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

INSERT INTO carro
(placa, marca, modelo, estado, color, anio, capacidad)
VALUES
('ABC123', 'Toyota', 'Corolla', 'Corolla', 'disponible', 'Blanco', 2022, 5),
('DEF456', 'Hyundai', 'Accent', 'Accent', 'disponible', 'Negro', 2021, 5),
('GHI789', 'Kia', 'Rio', 'disponible', 'Rojo', 2023, 5),
('JKL321', 'Nissan', 'Versa', 'disponible' , 'Gris', 2022, 5),
('MNO654', 'Chevrolet', 'Tracker', 'disponible', 'Azul', 2024, 5),

UPDATE carro
SET color = 'Plata'
WHERE placa = 'ABC123';

UPDATE carro
SET estado = 'mantenimiento'
WHERE placa = 'DEF456';

UPDATE carro
SET color = 'Negro Metalizado'
WHERE plata = 'JKL321';

UPDATE carro
SET estado = 'alquilado'
WHERE placa = 'JKL321';

UPDATE carro
SET capacidad = 7
WHERE placa = 'MNO654'

INSERT INTO solicitud
(solicitud_id, telefono, tiempo_alquiler, precio, estado, fecha_solicitud, fecha_inicio, fecha_fin, cliente_dni, placa, vendedor_dni)
VALUES 
(1, 994959344, 5, 350.00, 'pendiente', '2025-03-05', '2025-03-07', '2025-03-10', 43245642, 'DEF354', 45438530),
(2, 937575123, 3, 240.00, 'aprobada', '2025-04-04', '2025-04-06', '2025-04-10', 90432456, 'EEF546', 57485356),
(3, 995349432, 7, 560.00, 'aprobada', '2025-05-05', '2025-05-07', '2025-05-09', 49322553, 'GGF893', 43009409),
(4, 985342435, 2, 180.00, 'pendiente', '2025-06-06', '2025-06-08', '2025-06-10', 45435655, 'EFA543', 45543323),
(5, 942323342, 10, 700.00, 'finalizado', '2025-07-07', '2025-07-09', '2025-07-11', 43245534, 'GTA678', 48651594);

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
SET vendedor_id = 43124532
WHERE solicitud_id = 4;

UPDATE solicitud
SET telefono = 903424520 
WHERE solicitud_id = 5;

INSERT INTO registro
(cliente_dni, solicitud_id, vendedor_dni, nombre, apellido)
VALUES
('12345678', 1, '87654321', 'Juan', 'Perez'),
('23456781', 2, '76543218', 'Maria', 'Lopez'),
('34567812', 3, '65432187', 'Pedro', 'Quispe'),
('45678123', 4, '54321876', 'Ana', 'Torres'),
('56781234', 5, '43218765', 'Luis', 'Flores');

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
WHERE solicitud = 5;
