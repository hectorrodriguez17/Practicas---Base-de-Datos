SELECT
  s.solicitud_id,
  s.estado AS estado_solicitud,
  s.fecha_inicio,
  s_fecha_fin,
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
INNER JOIN cliente c ON s.cliente_dni = c.dni
INNER JOIN carro ca ON s.place = ca.placa
INNER JOIN vendedor v ON s.vendedor_dni = v.dni
LEFT JOIN pago p ON p.solicitud_id = s.solicitud_id;
