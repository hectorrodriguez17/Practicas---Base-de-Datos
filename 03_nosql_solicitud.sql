-- Entidades invlucradas en una solicitud de alquiler:
    -- cliente
    -- carro
    -- vendedor
    --solicitud
    -- solicitud_seguro
    -- pago

SELECT
    s.solicitud_id,
    s.estado AS estado_solicitud,
    s.fecha_inicio,
    s.fecha_fin,
    s.precio_total,
    c.dni AS cliente_dni,
    c.nombre AS cliente_nombre,
    c.apellido AS cliente_apellido,
    ca.placa,
    ca.marca,
    ca.modelo,
    v.nombre AS vendedor_nombre,
    p.metodo_pago,
    p.estado AS estado_pago
FROM solicitud s
INNER JOIN cliente c   ON s.cliente_dni  = c.dni
INNER JOIN carro ca    ON s.placa        = ca.placa
INNER JOIN vendedor v  ON s.vendedor_dni = v.dni
LEFT JOIN pago p       ON p.solicitud_id = s.solicitud_id;

--Diseño Nosql 
CREATE TABLE solicitud_doc (
    solicitud_id INT PRIMARY KEY,
    datos_solicitud JSONB NOT NULL
);

INSERT INTO solicitud_doc (solicitud_id, datos_solicitud)
VALUES (1,
    '{
      "codigo_solicitud": "SOL-2026-001",
      "tiempo_alquiler": 3,
      "precio_total": 350.00,
      "estado": "aprobada",
      "fechas": {
        "solicitud": "2026-03-05",
        "inicio": "2026-03-07",
        "fin": "2026-03-10"
      },
      "cliente": {
        "dni": "59945620",
        "nombre": "Tulio",
        "apellido": "Perez",
        "telefono": "991234567",
        "licencia": "LIC001"
      },
    "carro": {
        "placa": "ABC123",
        "marca": "Toyota",
        "modelo": "Corolla",
        "color": "Plata",
        "categoria": {
          "id": 2,
          "nombre": "Sedan",
          "tarifa_diaria": 120.00
        },
        "sucursal": {
          "id": 1,
          "nombre": "Sede Cercado"
        }
      },
      "vendedor": {
        "dni": "87654321",
        "nombre": "Carlos",
        "apellido": "Ramos",
        "sucursal_id": 1
      },
      "seguros": [
        {
          "seguro_id": 1,
          "nombre": "Cobertura Total",
          "costo_diario": 25.00,
          "subtotal": 75.00
        }
      ],
      "pagos": [
        {
          "pago_id": 101,
          "monto": 350.00,
          "metodo_pago": "tarjeta",
          "estado": "confirmado",
          "fecha_pago": "2025-03-05"
        }
      ]
    }'::jsonb
);


--SELECT
SELECT
    solicitud_id,
    datos_solicitud -> 'carro' AS objeto_carro_json,
    datos_solicitud ->> 'codigo_solicitud' AS codigo_solicitud,
    datos_solicitud ->> 'estado' AS estado_solicitud,
    datos_solicitud -> 'cliente' ->> 'nombre' AS cliente_nombre,
    datos_solicitud -> 'carro' ->> 'placa' AS placa,
    datos_solicitud -> 'carro' ->> 'color' AS color,
    datos_solicitud -> 'carro' -> 'categoria' ->> 'nombre' AS categoria,
    datos_solicitud -> 'carro' -> 'sucursal' ->> 'nombre' AS sucursal
FROM solicitud_doc
WHERE datos_solicitud -> 'carro' -> 'categoria' ->> 'nombre' = 'Sedan'
  AND datos_solicitud -> 'carro' -> 'sucursal' ->> 'nombre' = 'Sede Cercado';
