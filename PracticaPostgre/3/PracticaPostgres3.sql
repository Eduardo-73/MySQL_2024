CREATE TABLE empleados (
    idemp SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
	ape1 VARCHAR(100),
	ape2 VARCHAR(100),
    puesto VARCHAR(100)
);

CREATE TABLE gerentes (
    idgerente SERIAL PRIMARY KEY,
    departamento VARCHAR(100),
	idemple INT UNIQUE REFERENCES empleados(idemp) ON DELETE CASCADE
);

CREATE TABLE trabajadores (
   	idtrabajador SERIAL PRIMARY KEY,
    salario DECIMAL,
	idemple INT UNIQUE REFERENCES empleados(idemp) ON DELETE CASCADE
);
