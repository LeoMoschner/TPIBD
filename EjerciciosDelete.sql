## Ejercicios Delete

-- Eliminar todos los registros de la tabla Farmaceuticos que no están asociados a ninguna ciudad
DELETE FROM Farmaceuticos
WHERE idFarmaceutico NOT IN (SELECT idFarmaceutico FROM Ciudades);

-- Eliminar todas las transferencias que no han sido completadas y cuya fecha de transferencia es anterior a una fecha específica.
DELETE FROM Transferencias
WHERE estado <> 'Completada' AND fecha < '2023-03-01';

-- Eliminar todas las líneas de transferencia asociadas a las transferencias eliminadas en el paso anterior
	DELETE FROM LineaTransferencia
WHERE idTransferencia NOT IN (SELECT idTransferencia FROM Transferencias);

-- Eliminar todos los medicamentos que no estén siendo comercializados por ningún laboratorio.
DELETE FROM Medicamentos
WHERE idMedicamento NOT IN (SELECT idMedicamento FROM LaboratorioComercializaMedicamento);

-- Eliminar todas las farmacias que no tengan empleados.
DELETE FROM Farmacia
WHERE idFarmacia NOT IN (
    SELECT DISTINCT idFarmacia
    FROM Empleados
);

-- Eliminar los medicamentos que no estén presentes en el stock de ninguna farmacia.
DELETE FROM Medicamentos
WHERE idMedicamento NOT IN (
    SELECT DISTINCT idMedicamento
    FROM StockFarmacia
);
