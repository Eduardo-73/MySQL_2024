CREATE TABLE empleados (
    idemp SERIAL,
    nombre VARCHAR(100),
	ape1 VARCHAR(100),
	ape2 VARCHAR(100),
    puesto VARCHAR(100),
	CONSTRAINT pk_empleado PRIMARY KEY(idemp)
);

CREATE TABLE gerentes (
    idgerente SERIAL,
	nombre VARCHAR(100),
	ape1 VARCHAR(100),
	ape2 VARCHAR(100),
    departamento VARCHAR(100),
	CONSTRAINT pk_gerente PRIMARY KEY(idgerente),
	idemple INT REFERENCES empleados(idemp)
);

CREATE TABLE trabajadores (
   	idtrabajador SERIAL,
	nombre VARCHAR(100),
	ape1 VARCHAR(100),
	ape2 VARCHAR(100),
    salario DECIMAL,
	CONSTRAINT pk_trabajadores PRIMARY KEY(idtrabajador),
	idemple INT REFERENCES empleados(idemp)
);


INSERT INTO empleados
	(nombre, ape1, ape2, puesto)
VALUES
	('Antonio', 'Pérez', 'Montaña', 'Gerente');

INSERT INTO gerentes
	(nombre, ape1, ape2, departamento, idemple)
VALUES
	('Antonio',  'Pérez', 'Montaña', 'Ventas', '1');

select puesto from empleados where idemp = 1;