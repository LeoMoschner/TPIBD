-- Ejercicios Inserts

-- Insertar un nuevo medicamento con un precio mayor al promedio de los medicamentos.

INSERT INTO Medicamentos (idMedicamento, descripcion, presentacion, precio)
VALUES (1, 'Nuevo Medicamento', 'Tabletas', 
(SELECT AVG(precio) FROM Medicamentos) + 10);

-- Insertar una ciudad y relacionarla con un farmacéutico existente.
INSERT INTO Ciudades (codigoPostal, nombre, idFarmaceutico)
VALUES (12345, 'Ciudad A', 
(SELECT idFarmaceutico 
FROM Farmaceuticos 
WHERE nombre = 'Dejah' AND apellido = 'Harvey'
LIMIT 1));

-- Insertar una dirección  y relacionarla con una ciudad ya existente.
INSERT INTO Direccion (idDireccion, calle, numero, codigoPostal)
VALUES (1, 'Calle A', '123', 
(SELECT codigoPostal 
FROM Ciudades 
WHERE nombre = 'Ciudad A'
LIMIT 1));

-- Insertar un empleado y asignarlo a una farmacia existente.
INSERT INTO Empleados (cuit, nombre, apellido, fechaIngreso, idFarmacia)
VALUES (123456789, 'Pedro', 'Martínez', '2023-06-30', 
(SELECT idFarmacia 
FROM Farmacia 
WHERE idFarmacia = 1));

-- Insertar un nuevo ingreso en un depósito que no tenga ningún ingreso registrado.
INSERT INTO Ingresos (idDeposito, cuitLab, idIngreso, fechaIngreso, estado, cuitTransportista)
VALUES (100, 30567890123, 5001, '2023-07-01', 'Pendiente',
        (SELECT cuitTransportista 
         FROM Transportistas 
         WHERE cuitTransportista NOT IN (SELECT cuitTransportista FROM Ingresos)
         LIMIT 1)
);

-- Insertar un nuevo afiliado que tenga como descuento el promedio de descuento de los demás afiliados.
INSERT INTO Afiliados (idAfiliado, nombre, apellido, tipoDoc, documento, fechaNac, fechaIng, idDireccion, porcenDescuento)
VALUES (1, 'Nuevo Afiliado', 'Apellido', 'Tipo Doc', 'Documento', 'Fecha Nac', 'Fecha Ing', 1, 
(SELECT AVG(porcenDescuento) 
FROM Afiliados));
