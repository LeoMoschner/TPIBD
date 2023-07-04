-- Listar los códigos y nombres de los medicamentos que fueron vendidos en todas las farmacias 

SELECT m.idMedicamento
FROM medicamentos m
WHERE NOT EXISTS (
  SELECT f.idFarmacia
  FROM farmacia f
  WHERE NOT EXISTS (
    SELECT l.idComprobante
    FROM lineacomprobante l INNER JOIN comprobantes c 
ON l.idComprobante = c.idComprobante
    WHERE l.idMedicamento = m.idMedicamento 
AND c.idFarmacia = f.idFarmacia
  )
);

