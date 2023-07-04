## Ejercicios Update

-- Modificar la tabla de monodrogas para que el 40% de las monodrogas tengan como nombre comercial “Amoxidal Duo”.
UPDATE monodrogas
SET nombreComercial = 'Amoxidal Duo'
ORDER BY RAND()
LIMIT 40;

-- Actualización en la tabla "Transferencias" para modificar las fechas de ciertas transferencias relacionadas con el nombre comercial "Amoxidal Duo". La condición es que las transferencias deben tener una fecha anterior o igual a 15 días antes de la fecha actual.
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

-- Actualizar con valores numéricos aleatorios menores a 10000 la columna cantidad de toda la tabla de Stock Depósito.
UPDATE StockDeposito
SET cantidad = ROUND(RAND() * 10000);

-- Actualizar con valores numéricos aleatorios menores a 1000 la columna cantidad de toda la tabla de Stock Farmacia
UPDATE StockFarmacia
SET cantidad = ROUND(RAND() * 1000);

-- Actualizar el valor cantidad por 0 de 15 filas aleatorias de la tabla Stock Farmacia.
UPDATE StockFarmacia AS sf
JOIN (
  SELECT idFarmacia
  FROM StockFarmacia
  ORDER BY RAND()
  LIMIT 15
) AS subquery
ON sf.idFarmacia = subquery.idFarmacia
SET sf.cantidad = 0;

-- De la tabla Ingresos, actualizar la columna fechaIngreso de 20 entradas de tal forma que la fecha este en los últimos 30 días
UPDATE Ingresos
SET fechaIngreso = DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 30) DAY)
LIMIT 20;

-- Actualizar la dirección de una farmacia buscando el id de la Dirección con el código postal de la misma.
	UPDATE Farmacia
SET idDireccion = (
    SELECT idDireccion
    FROM Direccion
    WHERE codigoPostal = (
        SELECT codigoPostal
        FROM Ciudades
        WHERE nombre = 'Nueva York'
    )
)
WHERE idFarmacia = 1;
