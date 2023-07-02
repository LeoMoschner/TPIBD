SELECT
    COUNT(DISTINCT CASE WHEN AfiCro.idAfiliado IS NULL THEN Afi.idAfiliado END) AS CantAfiliadosNoCronicos,
    COUNT(DISTINCT AfiCro.idAfiliado) AS CantAfiliadosCronicos
FROM Afiliados Afi
JOIN Comprobantes Com ON Afi.idAfiliado = Com.idAfiliado
JOIN Farmacia Far ON Com.idFarmacia = Far.idFarmacia
JOIN Direccion Dir ON Far.idDireccion = Dir.idDireccion
JOIN Ciudades Ciu ON Dir.codigoPostal = Ciu.codigoPostal
LEFT JOIN AfiliadoCronico AfiCro ON Afi.idAfiliado = AfiCro.idAfiliado
WHERE Ciu.nombre = "Resistencia" AND Com.fecha <= DATE_SUB(CURDATE(), INTERVAL 1 WEEK);


