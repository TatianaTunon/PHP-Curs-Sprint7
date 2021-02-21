-- PROVEIDORES:

INSERT INTO ‘scculampolla’.’T-Proveidor’ (`NIF`, ‘Nom’, ‘Adreça’, ‘Ciutat’, ‘Codi Postal’, ‘Pais’ , ‘Telefono’)
VALUES 
('87935674D', 'Juan Gomez', 'Rio Sella, 89-1a', 'Madrid', '15690', 'España', '656589899');

INSERT INTO ‘scculampolla’.’T-Proveidor’ (`NIF`, ‘Nom’, ‘Adreça’, ‘Ciutat’, ‘Codi Postal’, ‘Pais’ , ‘Telefono’)
VALUES 
( '97302819J', 'Carmen Condesa', 'Ramblas 149, bj', 'Girona' , '08990', 'España', ‘677893472');

INSERT INTO `scculampolla`.`T-Proveidor` (`NIF`, `Nom`, `Adreça`, `Ciutat`, `Codi Postal`, `Pais`, `Telefono`) 
VALUES 
('97840276M', 'Juan Alvarez', 'Plaza Espanya 19, bj', 'Girona', '08890', 'España', ‘678936728’);


-- VENDEDORES:

INSERT INTO `scculampolla`.`TR-Vendedor` (`NIF`, `Nom`, `Tienda`, `Telefono`) 
VALUES 
('98736478P', 'Gerard Pio', 'Centro Comercial', ‘999777999’);

INSERT INTO `scculampolla`.`TR-Vendedor` (`NIF`, `Nom`, `Tienda`, `Telefono`) 
VALUES 
('09098724L', ‘Ana Gutierrez', 'Centro Comercial', ‘987564123’);

-- CLIENTES:

INSERT INTO `scculampolla`.`T-Clients` (`NIF`, `Nom`, `Adreça`, `Codi Postal`, `Teléfono`, `Email`, `Fecha Registro`, `T-Recomanat_idClients`, `TR-Vendedor_idTRVendedor`) 
VALUES ('87640276M', 'Laura Alvarez', 'Villarroel 58, 6-1', '08015', '678936555', 'laura@gmail.com', '2010-11-09', '', '09098724L');

INSERT INTO `scculampolla`.`T-Clients` (`NIF`, `Nom`, `Adreça`, `Teléfono`, `Email`, `Fecha Registro`, `TR-Vendedor_idTRVendedor`) VALUES ('77641276C', 'Celia Manso', 'Plaza del diamante 15, 3-2\n', '345922515', 'celia@gmail.com', '2012-04-17', ‘09098724L');





-- MARCAS:

INSERT INTO `scculampolla’.’TR-Marcas’ (‘idMarcas’, ’Nom Marca’, ’T-Proveidor_NIF’) 
VALUES 
(‘1’, ’Rayban', ‘87935674D');

INSERT INTO `scculampolla`.`TR-Marcas` (`idMarcas`, `Nom Marca`, `T-Proveidor_NIF`) 
VALUES 
('2', 'Chanel', ‘87935674D');

INSERT INTO `scculampolla`.`TR-Marcas` (`idMarcas`, `Nom Marca`, `T-Proveidor_NIF`) 
VALUES 
('3', 'Diorl', ‘97302819J');

INSERT INTO `scculampolla`.`TR-Marcas` (`idMarcas`, `Nom Marca`, `T-Proveidor_NIF`) 
VALUES 
('4', 'Arnette', ‘97302819J');

INSERT INTO `scculampolla`.`TR-Marcas` (`idMarcas`, `Nom Marca`, `T-Proveidor_NIF`) 
VALUES 
('5', 'Gucci', ‘97302819J');



-- TIPO MONTURAS:

INSERT INTO `scculampolla`.`TR-TipoMontura` ( 'Tipo' )
VALUES 
(‘Flotante’);

INSERT INTO `scculampolla`.`TR-TipoMontura` (`Tipo`) 
VALUES 
(‘Pasta');

INSERT INTO `scculampolla`.`TR-TipoMontura` (`Tipo`) 
VALUES (‘Metálica');

INSERT INTO `scculampolla`.`T-Ulleres` 
(`Código`, `Grad_Ull_Dret` ,`Grad_Ull_Esquerra`,`Color montura` ,`Color vidre_U_D` ,
`Color_vidre_U_E` ,`Preu` ,
  `Vendedor`,
  `TR-Marcas_idMarcas` ,`TR-TipoMontura_idMonturas`,`T-Ventas_idVentas` ,`T-Ventas_T-Clients_NIF` ,
  `T-Ventas_TR-Vendedor_NIF`
)
VALUES 
('1','10,5','11,2','Blau','Blau','Blau',150,'98736478P',6,2,1,
'77641276C','98736478P');

INSERT INTO `scculampolla`.`T-Ulleres` 
(`Código`, `Grad_Ull_Dret` ,`Grad_Ull_Esquerra`,`Color montura` ,`Color vidre_U_D` ,
`Color_vidre_U_E` ,`Preu` ,
  `Vendedor`,
  `TR-Marcas_idMarcas` ,`TR-TipoMontura_idMonturas`,`T-Ventas_idVentas` ,`T-Ventas_T-Clients_NIF` ,
  `T-Ventas_TR-Vendedor_NIF`
)
VALUES 
('2','2,5','2,2','Vermell','Gris','Gris',150,'98736478P',6,2,1,
'77641276C','98736478P');




-- CONSULTAS:

-- Lista de ventas de cada vendedor
SELECT  `Vendedor`.`Nom`, `T-Clients`.`NIF`, `T-Clients`.`Nom` 
FROM `scculampolla`.`Vendedor`, `scculampolla`.`T-Clients` 
WHERE `T-Clients`.`TR-Vendedor_idTRVendedor` = `Vendedor`.`NIF`;
-- Lista de marca i su proveedor.
SELECT  `TR-Marcas`.`Nom Marca`, `T-Proveidor`.`Nom`, `T-Proveidor`.`Ciutat`
FROM `scculampolla`.`TR-Marcas`, `scculampolla`.`T-Proveidor`
WHERE 
    `TR-Marcas`.`T-Proveidor_NIF`= `T-Proveidor`.`NIF`;