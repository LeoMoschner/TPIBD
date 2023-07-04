-- Mostrar el ranking de los diez medicamentos con mayor cantidad de ventas en todas las farmacias de la cadena. 
SELECT l.idMedicamento, SUM(l.cantidad) AS total_ventas
FROM lineacomprobante l
GROUP BY l.idMedicamento
ORDER BY total_ventas DESC
LIMIT 10;
