INSERT INTO cliente
(dni,nombre,apellido,telefono, licencia ,direccion)
VALUES
('59945620','Tulio','Perez','991234567','LIC001','Arequipa'),
('69645328','Luis','Quispe','991234567','LIC010','Cayma'),
('49975626','Sergio','Lopez','991234567','LIC003','Paucarpata'),
('74145223','Pablo','Torres','991234567','LIC007','Hunter'),
('90441524','Juan','Flores','991234567','LIC020','Arequipa');

UPDATE cliente
SET direccion= 'Miraflores'
WHERE dni ='49975626';
