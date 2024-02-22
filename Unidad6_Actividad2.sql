-- 1
select *
from empleados join departamentos 
	on empleados.numde = departamentos.numde;

-- 2
select extelem, nomce
from empleados join departamentos 
	on empleados.numde = departamentos.numde join centros
		on departamentos.numce = centros.numce
where nomem = 'Juan' and ape1em = 'López';

-- 3
select concat_ws(' ', nomem, ape1em, ape2em) as Nombre
from empleados join departamentos
	on empleados.numde = departamentos.numde
where nomde = 'personal' or nomde = 'finanzas';

-- 4
select nomem
from dirigir join empleados
	on dirigir.numempdirec = empleados.numem join departamentos
		on empleados.numde = departamentos.numde
where nomde = 'personal';

-- 5
select nomde as Nombre, presude as Presupuesto
from departamentos join centros 
	on departamentos.numce = centros.numce
where ltrim(centros.nomce) = 'Sede Central';

-- 6 
select nomce
from centros join departamentos
	on centros.numce = departamentos.numce
where presude = 100000 or presude = 150000; 

-- 7
select distinct departamentos.nomde, empleados.extelem -- distinct se utilizan para que no salgan repetidos
from empleados join departamentos
	on empleados.numde = departamentos.numde
-- where departamentos.nomde = 'Finanzas';
order by departamentos.nomde;
-- limit 1 te hace un select del primer resultado
-- 8 
delimiter $$
create procedure ej8
	(depto varchar(120))
begin
	start transaction;
		select concat_ws(' ', nomem, ape1em, ape2em) as Nombre
		from empleados join dirigir
			on empleados.numem = dirigir.numempdirec join departamentos
				on dirigir.numdepto = departamentos.numde
		where departamentos.nomde = depto;
	commit;
end $$
delimiter ;

select departamentos.nomde,
	concat_ws(' ', nomem, ape1em, ape2em) as Nombre,
    dirigir.fecinidir, dirigir.fecfindir
from departamentos join dirigir
	on departamentos.numde = dirigir.numdepto join empleados
		on dirigir.numempdirec = empleados.numem
-- where departamentos.nomde = 'personal'
-- where dirigir.fecfindir is not null or dirigir.fecfindir >= curdate()
where ifnull(dirigir.fecfindir, curdate()) >= curdate()
order by departamentos.nomde, dirigir.fecinidir;

-- 9 



