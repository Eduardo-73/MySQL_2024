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

INSERT INTO gerentes
	(idemp, nombre, puesto, departamento)
VALUES
	('1','Antonio', 'Gerente', 'Ventas');

INSERT INTO trabajadores
	(idemp, nombre, puesto, salario)
VALUES
	('2', 'Paco', 'Trabajador', '3000.00');

CREATE RULE tipoEmple
AS
	ON INSERT TO empleados
		WHERE EXISTS
			(SELECT * 
			 FROM gerentes
			 WHERE gerentes.departamento = NEW.departamento)
	DO INSTEAD NOTHING;
