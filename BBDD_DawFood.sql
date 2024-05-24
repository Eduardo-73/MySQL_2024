DROP DATABASE IF EXISTS dawfood;
CREATE DATABASE dawfood;

USE dawfood;

	DROP TABLE IF EXISTS tpv;
	CREATE TABLE tpv (
	  IdTpv int NOT NULL AUTO_INCREMENT,
	  fechaSistema date DEFAULT NULL,
	  direccion varchar(100) DEFAULT NULL,
	  contraseña varchar(6) NOT NULL,
	  horaSistema time DEFAULT NULL,
	  PRIMARY KEY (IdTpv)
	);


	DROP TABLE IF EXISTS ticket;
	CREATE TABLE ticket (
	  IdTicket int NOT NULL AUTO_INCREMENT,
	  codTransaccion varchar(100) NOT NULL,
	  fechaOperacion date DEFAULT NULL,
	  horaOperacion time DEFAULT NULL,
	  importeTotal decimal(5,2) DEFAULT NULL,
	  IdTpv int DEFAULT NULL,
		  PRIMARY KEY (IdTicket),
			KEY fk_ticket_tpv (IdTpv),
				CONSTRAINT fk_ticket_tpv 
					FOREIGN KEY (IdTpv) 
						REFERENCES tpv (IdTpv) ON UPDATE CASCADE
	);


	DROP TABLE IF EXISTS tipoproducto;
	CREATE TABLE tipoproducto (
	  IdTipoProducto int NOT NULL AUTO_INCREMENT,
	  nomCategoria enum('COMIDA','BEBIDA','POSTRE') NOT NULL,
	  descripcionCategoria varchar(100) DEFAULT NULL, -- si el enum es comida, este campo será pasta,ensaladas o carnes y asi con las demas categorias
	  PRIMARY KEY (IdTipoProducto)
	);


	DROP TABLE IF EXISTS productos;
	CREATE TABLE productos (
	  IdProducto int NOT NULL AUTO_INCREMENT,
	  precio decimal(5,2) DEFAULT NULL,
	  stock int DEFAULT NULL,
	  IVA ENUM ('DIEZ', 'VENTIUNO') DEFAULT NULL,
	  descripcion varchar(300) NOT NULL,
	  IdTipoProducto int DEFAULT NULL,
	  PRIMARY KEY (IdProducto),
	  KEY fk_productos_tipoproducto (IdTipoProducto),
	  CONSTRAINT fk_productos_tipoproducto 
		FOREIGN KEY (IdTipoProducto) 
		  REFERENCES tipoproducto (IdTipoProducto) ON UPDATE CASCADE
	) ;


	DROP TABLE IF EXISTS detalleventa;
	CREATE TABLE detalleventa (
	  cantidadProducto int DEFAULT NULL,
	  IdProducto int NOT NULL,
	  IdTicket int NOT NULL,
	  PRIMARY KEY (IdProducto,IdTicket),
	  KEY fk_detalleventa_ticket (IdTicket),
	  CONSTRAINT fk_detalleVenta_productos 
		FOREIGN KEY (IdProducto) 
		  REFERENCES productos (IdProducto) ON UPDATE CASCADE,
	  CONSTRAINT fk_detalleventa_ticket 
		FOREIGN KEY (IdTicket) 
		  REFERENCES ticket (IdTicket) ON UPDATE CASCADE
	);

INSERT INTO tipoproducto (nomCategoria, descripcionCategoria)
VALUES ('COMIDA', 'Ensalada'),
	   ('COMIDA', 'Pastas'),
       ('COMIDA', 'Carnes'),
       
       ('BEBIDA', 'Refrescos'),
	   ('BEBIDA', 'Vinos'),
       ('BEBIDA', 'Alcohol'),
       
       ('POSTRE', 'Tartas');
       
-- Creacion de los productos
INSERT INTO productos (precio, stock, IVA, descripcion, IdTipoProducto)
VALUES 
    (10.99, 50, 'DIEZ', 'Ensalada César', 1),
    (12.50, 40, 'DIEZ', 'Spaghetti Bolognese', 2),
    (15.00, 30, 'DIEZ', 'Filete de Ternera', 3),
    
    (2.50, 100, 'VENTIUNO', 'Coca Cola', 4),
    (18.00, 60, 'VENTIUNO', 'Vino Tinto', 5),
    (7.00, 80, 'VENTIUNO', 'Roncola', 6),
    
    (5.50, 20, 'DIEZ', 'Tarta de Queso', 7);SE dawfood;

	DROP TABLE IF EXISTS tpv;
	CREATE TABLE tpv (
	  IdTpv int NOT NULL AUTO_INCREMENT,
	  fechaSistema date DEFAULT NULL,
	  direccion varchar(100) DEFAULT NULL,
	  contraseña varchar(6) NOT NULL,
	  horaSistema time DEFAULT NULL,
	  PRIMARY KEY (IdTpv)
	);


	DROP TABLE IF EXISTS ticket;
	CREATE TABLE ticket (
	  IdTicket int NOT NULL AUTO_INCREMENT,
	  codTransaccion varchar(100) NOT NULL,
	  fechaOperacion date DEFAULT NULL,
	  horaOperacion time DEFAULT NULL,
	  importeTotal decimal(5,2) DEFAULT NULL,
	  IdTpv int DEFAULT NULL,
		  PRIMARY KEY (IdTicket),
			KEY fk_ticket_tpv (IdTpv),
				CONSTRAINT fk_ticket_tpv 
					FOREIGN KEY (IdTpv) 
						REFERENCES tpv (IdTpv) ON UPDATE CASCADE
	);


	DROP TABLE IF EXISTS tipoproducto;
	CREATE TABLE tipoproducto (
	  IdTipoProducto int NOT NULL AUTO_INCREMENT,
	  nomCategoria enum('COMIDA','BEBIDA','POSTRE') NOT NULL,
	  descripcionCategoria varchar(100) DEFAULT NULL, -- si el enum es comida, este campo será pasta,ensaladas o carnes y asi con las demas categorias
	  PRIMARY KEY (IdTipoProducto)
	);


	DROP TABLE IF EXISTS productos;
	CREATE TABLE productos (
	  IdProducto int NOT NULL AUTO_INCREMENT,
	  precio decimal(5,2) DEFAULT NULL,
	  stock int DEFAULT NULL,
	  IVA ENUM ('DIEZ', 'VENTIUNO') DEFAULT NULL,
	  descripcion varchar(300) NOT NULL,
	  IdTipoProducto int DEFAULT NULL,
	  PRIMARY KEY (IdProducto),
	  KEY fk_productos_tipoproducto (IdTipoProducto),
	  CONSTRAINT fk_productos_tipoproducto 
		FOREIGN KEY (IdTipoProducto) 
		  REFERENCES tipoproducto (IdTipoProducto) ON UPDATE CASCADE
	) ;


	DROP TABLE IF EXISTS detalleventa;
	CREATE TABLE detalleventa (
	  cantidadProducto int DEFAULT NULL,
	  IdProducto int NOT NULL,
	  IdTicket int NOT NULL,
	  PRIMARY KEY (IdProducto,IdTicket),
	  KEY fk_detalleventa_ticket (IdTicket),
	  CONSTRAINT fk_detalleVenta_productos 
		FOREIGN KEY (IdProducto) 
		  REFERENCES productos (IdProducto) ON UPDATE CASCADE,
	  CONSTRAINT fk_detalleventa_ticket 
		FOREIGN KEY (IdTicket) 
		  REFERENCES ticket (IdTicket) ON UPDATE CASCADE
	);

INSERT INTO tipoproducto (nomCategoria, descripcionCategoria)
VALUES ('COMIDA', 'Ensalada'),
	   ('COMIDA', 'Pastas'),
       ('COMIDA', 'Carnes'),
       
       ('BEBIDA', 'Refrescos'),
	   ('BEBIDA', 'Vinos'),
       ('BEBIDA', 'Alcohol'),
       
       ('POSTRE', 'Tartas');
       
-- Creacion de los productos
INSERT INTO productos (precio, stock, IVA, descripcion, IdTipoProducto)
VALUES 
    (10.99, 50, 'DIEZ', 'Ensalada César', 1),
    (12.50, 40, 'DIEZ', 'Spaghetti Bolognese', 2),
    (15.00, 30, 'DIEZ', 'Filete de Ternera', 3),
    
    (2.50, 100, 'VENTIUNO', 'Coca Cola', 4),
    (18.00, 60, 'VENTIUNO', 'Vino Tinto', 5),
    (7.00, 80, 'VENTIUNO', 'Roncola', 6),
    
    (5.50, 20, 'DIEZ', 'Tarta de Queso', 7);
