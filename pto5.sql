SELECT Far.idFarmacia, COUNT(Tra.idTransferencia) AS CantTransferencias
FROM Farmacia Far
JOIN Transferencias Tra ON Far.idFarmacia = Tra.idFarmacia
WHERE Tra.estado = "pendiente"
GROUP BY (Far.idFarmacia)
ORDER BY (CantTransferencias) ASC;