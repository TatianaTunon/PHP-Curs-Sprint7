
-- provincia
INSERT INTO `pizzeria`.`TR-Provincia` (`idTRProvincia`, `Nom`) VALUES ('08', 'Barcelona');
INSERT INTO `pizzeria`.`TR-Provincia` (`idTRProvincia`, `Nom`) VALUES ('43', 'Tarragona');

-- Localitat
INSERT INTO `pizzeria`.`TR-Localitat` (`idTRLocalitat`, `Nom`, `TR-Provincia_idTRProvincia`) VALUES ('01', 'Roda de Berà', '43');
INSERT INTO `pizzeria`.`TR-Localitat` (`idTRLocalitat`, `Nom`, `TR-Provincia_idTRProvincia`) VALUES ('02', 'Hospitalet de Llobregat', '08');


-- Tipus pizza
INSERT INTO `pizzeria`.`TR-TiposPizza` (`idTRTiposPizza`, `Nom`, `Categoria`) VALUES ('1', 'Oferta mes', '1');
INSERT INTO `pizzeria`.`TR-TiposPizza` (`idTRTiposPizza`, `Nom`, `Categoria`) VALUES ('2', 'Especials', '2');

-- repartidor

INSERT INTO `pizzeria`.`T-repartidor` (`idTrepartidor`, `Nom`, `Cognom`, `NIF`, `Teléfono`) 
VALUES ( '1', 'Carmen', 'Condesa' , '97302819J' , '677893472' );
INSERT INTO `pizzeria`.`T-repartidor` (`idTrepartidor`, `Nom`, `Cognom`, `NIF`, `Teléfono`) 
VALUES ('2', 'Juan', 'Alvarez', '97840276M', '678936728');
INSERT INTO `pizzeria`.`T-repartidor` (`idTrepartidor`, `Nom`, `Cognom`, `NIF`, `Teléfono`) 
VALUES ('3', 'Juan', 'Gomez', '87935674D', '656589899');

-- clientes
INSERT INTO `pizzeria`.`T-Clientes` (`idT-Clientes`, `Nom`, `Apellidos`, `Adreça`, `Codi Postal`, `Teléfono`, `TR-Localitat_idTRLocalitat`) 
VALUES ('1', 'Laura', 'Alvarez', 'Villarroel 58, 6-1', '08015', '678936555', '1');
INSERT INTO `pizzeria`.`T-Clientes` (`idT-Clientes`, `Nom`, `Apellidos`, `Adreça`, `Codi Postal`, `Teléfono`, `TR-Localitat_idTRLocalitat`) 
VALUES ('2', 'Celia', 'Manso', 'Plaza del diamante 15, 3-2\n', '08011', '689345922', '1');

-- Botigues
INSERT INTO `pizzeria`.`T-Botigues` (`idTBotigues`, `Adreça`, `Codi Postal`, `TR-Localitat_idTRLocalitat`) 
VALUES ('1', 'Plaza Catalunya 7', '08006', '1');
INSERT INTO `pizzeria`.`T-Botigues` (`idTBotigues`, `Adreça`, `Codi Postal`, `TR-Localitat_idTRLocalitat`) 
VALUES ('2', 'Plaza España 17', '08016', '2');

-- Comandes
INSERT INTO `pizzeria`.`T-Comandes` (`idT-Comandes`, `Fecha`, `Entrega`, `T-Clientes_idT-Clientes`, `T-Botigues_idTBotigues`, `T-repartidor_idTrepartidor`) 
VALUES ('1', '2021-02-06', 'Domicili', '1', '1', '1');
INSERT INTO `pizzeria`.`T-Comandes` (`idT-Comandes`, `Fecha`, `Entrega`, `T-Clientes_idT-Clientes`, `T-Botigues_idTBotigues`, `T-repartidor_idTrepartidor`) 
VALUES ('2', '2021-02-06', 'Domicili', '2', '1', '2');
INSERT INTO `pizzeria`.`T-Comandes` (`idT-Comandes`, `Fecha`, `Entrega`, `T-Clientes_idT-Clientes`, `T-Botigues_idTBotigues`) 
VALUES ('3', '2021-01-27', 'Recollir en botiga', '2', '1');

-- Productor
INSERT INTO `pizzeria`.`TR-Productos` (`idTRProductos`, `T-Comandes_idT-Comandes`, `Total_preu`, `q_pizza`, `q_hamb`, `q_beguda`) 
VALUES ('1', '1', '25.60', '1', '1', '1');
INSERT INTO `pizzeria`.`TR-Productos` (`idTRProductos`, `T-Comandes_idT-Comandes`, `Total_preu`, `q_pizza`, `q_hamb`, `q_beguda`) 
VALUES ('2', '2', '30.25', '2', '0', '1');

-- Consultes
-- Comandes amb el nom del repartidor.
SELECT  `T-Comandes`.`idT-Comandes`,
    `T-Comandes`.`Fecha`,
    `T-Comandes`.`Entrega`,
 `T-repartidor`.`idTrepartidor`,
    `T-repartidor`.`Nom`,
    `T-repartidor`.`Cognom`
FROM `pizzeria`.`T-repartidor`, `pizzeria`.`T-Comandes`
WHERE
 `T-repartidor`.`idTrepartidor` =  `T-Comandes`.`T-repartidor_idTrepartidor`;

 -- Comandes amb el tipus de producte.
 SELECT `T-Comandes`.`idT-Comandes`,
    `T-Comandes`.`Fecha`,
    `T-Comandes`.`Entrega`,
 `TR-Productos`.`idTRProductos`,
    `TR-Productos`.`Total_preu`,
    `TR-Productos`.`q_pizza`,
    `TR-Productos`.`q_hamb`,
    `TR-Productos`.`q_beguda`
FROM `pizzeria`.`TR-Productos`,  `pizzeria`.`T-Comandes`
WHERE `TR-Productos`.`T-Comandes_idT-Comandes` = `T-Comandes`.`idT-Comandes`;