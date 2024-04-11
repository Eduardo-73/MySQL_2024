-- 1 
select empleados.numem, empleados.nomem, departamentos.nomde
from empleados straight_join departamentos on empleados.numde = departamentos.numde;

select empleados.numem, empleados.nomem, departamentos.nomde
from empleados straight_join departamentos on empleados.numde = departamentos.numde
where empleados.numde < 120;

select empleados.numem, empleados.nomem, departamentos.nomde
from empleados inner join departamentos on empleados.numde = departamentos.numde;

alter table empleados
	add index indiceEmpleados(numde);

