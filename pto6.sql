SELECT SD.idMedicamento
FROM Depositos Dep
JOIN StockDeposito SD ON Dep.idDeposito = SD.idDeposito
WHERE SD.cantidad > 0 AND EXISTS(
	SELECT 1
    FROM StockFarmacia SF
    WHERE SF.idFarmacia = 33 -- <idFarmaciaDado>
    AND SF.idMedicamento = SD.idMedicamento
    AND SF.cantidad = 0
)
-- Que no exista ese medicamento en la farmacia dada