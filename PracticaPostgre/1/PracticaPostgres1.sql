CREATE TABLE empleados (
    idemp SERIAL,
    nombre VARCHAR(100) ,
    puesto VARCHAR(100),
	CONSTRAINT pk_empleado PRIMARY KEY(idemp)
);

CREATE TABLE gerentes (
    idgerente SERIAL,
    departamento VARCHAR(100),
	CONSTRAINT pk_gerente PRIMARY KEY(idgerente)
)INHERITS(empleados);

CREATE TABLE trabajadores (
    idtrabajador SERIAL,
    salario DECIMAL,
	CONSTRAINT pk_trabajadores PRIMARY KEY(idtrabajador)
)INHERITS(empleados);

CREATE RULE tipoEmpl
AS
	ON INSERT TO empleados
	DO INSTEAD NOTHING;

CREATE RULE gerent
AS
	ON INSERT TO gerentes
		WHERE EXISTS
			(SELECT * 
			 FROM trabajadores
			 WHERE trabajadores.idemp = NEW.idemp)
	DO ALSO NOTHING;

CREATE RULE trabaj
AS
	ON INSERT TO trabajadores
		WHERE EXISTS
			(SELECT * 
			 FROM gerentes
			 WHERE gerentes.idemp = NEW.idemp)
	DO ALSO NOTHING;

INSERT INTO gerentes
	(idemp, nombre, puesto, departamento)
		values
	('1', 'Pepe', 'gerente', 'i+d');

insert into trabajadores
	(idemp, nombre, puesto, salario)
		values
	('1', 'Pepe', 'gerente', '3000.00');