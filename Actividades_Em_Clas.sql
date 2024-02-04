-- actividad 2
USE `empresaclase`;

-- actividad 3
-- select * from departamentos;
start transaction;
set @maxdepto = (select max(numde) from departamentos) + 1;
insert into departamentos
	(numde, numce, presude, depende, nomde)
value	
	(@maxdepto, 20, 15000, 100, 'Publicidad');

-- select * from empleados;
set @maxem = (select max(numem) from empleados) + 1; 
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem, salarem, 
    comisem, numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
value	
	(@maxem, @maxdepto, 930, '1967/6/12', curdate(), 2000, 150, 
    2, 'Rosa', 'del Campo', 'Floridos', '00000000A', null, null);

-- select * from dirigir;
insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
value	
	(@maxdepto, @maxem, curdate(), '2025/02/4', 'P');

select * from departamentos;
select * from empleados;
select * from dirigir;
rollback;

-- actividad 4
select * from centros;
start transaction;
update departamentos
	set numce = 10
where numde = 111;
rollback;

-- actividad 5
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem, salarem, 
    comisem, numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
values 
	(1001, 132, 940, '1972/2/12', curdate(), 1400, null, 1,
    'Pedro', 'González', 'Sánchez', null, null, null);

insert into empleados
	(numem, numde, extelem, fecnaem, fecinem, salarem, 
    comisem, numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
values 
	(1002, 131, 940, '1975/9/25', curdate(), 1400, null, 0, 
    'Juan', 'Torres', 'Campos', null, null, null);
    
-- actividad 6
delete from empleados
where numem = 120;

-- actividad 7
update empleados
	set extelem = 910,
		salarem = salarem * 1.10,
        numde = 120
where numem = 360;


















































