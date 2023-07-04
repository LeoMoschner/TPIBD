-- Informar el monto total de ventas por farmacia en el último trimestre ordenado en forma descendente.

SELECT f.idFarmacia, SUM(l.precioTotal) AS monto_total_ventas
FROM Farmacia f INNER JOIN Comprobantes c ON f.idFarmacia = c.idFarmacia INNER JOIN LineaComprobante l ON c.idComprobante = l.idComprobante
WHERE c.fecha >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY f.idFarmacia
ORDER BY monto_total_ventas DESC;
