-- Informar el top de las 5 farmacias que solicitaron mayores cantidades de amoxidal duo  en los últimos 15 dias. 

SELECT Far.idFarmacia, SUM(Lin.cantidadMedicamento) AS cantAmoxidal
FROM Farmacia Far
JOIN Transferencias Tra ON Far.idFarmacia = Tra.idFarmacia
JOIN LineaTransferencia Lin ON Tra.idTransferencia = Lin.idTransferencia
JOIN Medicamentos Med ON Lin.idMedicamento = Med.idMedicamento
JOIN MedicamentoTieneMD TMD ON Med.idMedicamento = TMD.idMedicamento
JOIN MonoDrogas MD ON TMD.nombreCientifico = MD.nombreCientifico
WHERE MD.nombreComercial = "Amoxidal Duo" AND Tra.fecha <= DATE_SUB(CURDATE(), INTERVAL 15 DAY)
GROUP BY (Far.idFarmacia)
ORDER BY (cantAmoxidal) DESC
LIMIT 5;