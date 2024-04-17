-- 1 
explain select empleados.numem, empleados.nomem, departamentos.nomde
from empleados straight_join departamentos on empleados.numde = departamentos.numde;

explain select empleados.numem, empleados.nomem, departamentos.nomde
from empleados straight_join departamentos on empleados.numde = departamentos.numde
where empleados.numde < 120;

explain select empleados.numem, empleados.nomem, departamentos.nomde
from empleados inner join departamentos on empleados.numde = departamentos.numde;

explain select empleados.numem, empleados.nomem, departamentos.nomde
from empleados join departamentos on empleados.numde = departamentos.numde;

-- 2 
explain select *
from empleados
where char_length(ape1em) > 4 
	and left(nomem, 3) = left('nombre' , 3);

-- 3
select  



