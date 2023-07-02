SELECT l.idMedicamento, SUM(l.cantidad) AS total_ventas
FROM comprobantes c INNER JOIN lineacomprobante l ON c.idComprobante = l.idComprobante
GROUP BY l.idMedicamento
ORDER BY total_ventas DESC
LIMIT 10;
