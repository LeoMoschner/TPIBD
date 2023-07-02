-- Para que el medicamento 1 sea vendido por todas las farmacias
INSERT INTO lineaComprobante (idComprobante, idMedicamento)
SELECT DISTINCT c.idComprobante, 1
FROM comprobantes c
CROSS JOIN farmacia f
WHERE NOT EXISTS (
   SELECT 1
   FROM lineaComprobante lc
   WHERE lc.idComprobante = c.idComprobante
     AND lc.idMedicamento = 1
);

-- Cambiarle el nombre a una ciudad a Resistencia

UPDATE Ciudades SET nombre = "Resistencia" WHERE codigoPostal = 174;

-- Cambia algunas transferencias que involucren Amoxidal duo para que sean realizadas en los ultimos 15 dias
UPDATE Transferencias
SET fecha = DATE_SUB(CURDATE(), INTERVAL 15 DAY)
WHERE idTransferencia IN (
    SELECT * FROM (
        SELECT Tra.idTransferencia
        FROM Farmacia Far
        JOIN Transferencias Tra ON Far.idFarmacia = Tra.idFarmacia
        JOIN LineaTransferencia Lin ON Tra.idTransferencia = Lin.idTransferencia
        JOIN Medicamentos Med ON Lin.idMedicamento = Med.idMedicamento
        JOIN MedicamentoTieneMD TMD ON Med.idMedicamento = TMD.idMedicamento
        JOIN MonoDrogas MD ON TMD.nombreCientifico = MD.nombreCientifico
        WHERE MD.nombreComercial = "Amoxidal Duo" AND Tra.fecha <= DATE_SUB(CURDATE(), INTERVAL 15 DAY)
    ) AS subquery
);