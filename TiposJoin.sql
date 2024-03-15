-- Numero de empleados de cada departamento (nombre de departamento)

select count(empleados.numem) as Numero, departamentos.nomde as Nombre
from empleados right join departamentos on
	empleados.numde = departamentos.numde
group by departamentos.numde;
