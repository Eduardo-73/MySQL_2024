-- 1
select * 
from empleados;

-- 2
select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as Nombre,
extelem
from empleados
where nomem = 'Juan' and ape1em = 'López';

-- 3
select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as NombreCompleto,
	numhiem as 'Nº hijos'
from empleados
where numhiem > 1;

-- 4
select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as NombreCompleto,
	numhiem as 'Nº hijos'
from empleados
where numhiem = 1 or numhiem = 3;

-- 5 
select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as Nombre,
	comisem
from empleados
where comisem is null;

-- 6 
select dirce
from centros
where ltrim(nomce) = 'SEDE CENTRAL';

-- 7
select nomde as Nombre
from departamentos
where presude > 6000;

-- 8
select nomde as Nombre
from departamentos
where presude > 6000 or presude = 6000;

-- 9 
select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as Nombre,
	fecinem
from empleados
where fecinem = date_sub(fecinem + 1 year());









