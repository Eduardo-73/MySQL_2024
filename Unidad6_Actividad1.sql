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
where fecinem <= date_sub(curdate(), interval 1 year);

-- 10 

select concat_ws(' ', nomem, ape1em, ape2em) as Nombre
from empleados
where fecinem between date_sub(curdate(), interval 1 year) and 
	date_sub(curdate(), interval 3 year);


-- Procedimiento ej9 y ej10

delimiter $$
create procedure ej9
	(fecha date)
begin
	start transaction; 
		select concat_ws(' ', nomem, ape1em, ape2em) as Nombre
        from empleados
        where fecinem < fecha;
    commit;
end $$
delimiter ;

delimiter $$
create procedure ej10
	(fecha1 date, fecha2 date)
begin
	start transaction; 
		select concat_ws(' ', nomem, ape1em, ape2em) as Nombre
        from empleados
        where fecinem between fecha1 and fecha2;
    commit;
end $$
delimiter ;

call ej10('2021-2-21', '2023-2-21');

-- 11
delimiter $$
create procedure ej11_1
	()
begin
	start transaction; 
		select * 
		from empleados;
    commit;
end $$
delimiter ;

call ej11_1();

delimiter $$
create procedure ej11_2
	()
begin
	start transaction; 
		select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as Nombre,
		comisem
		from empleados
		where comisem is null;
    commit;
end $$
delimiter ;

call ej11_2();

-- 12
delimiter $$
create procedure ej12
	(nombre varchar(60), apellido varchar(60))
begin
	start transaction; 
		select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as Nombre,
		extelem
		from empleados
		where nomem = nombre and ape1em = apellido;
    commit;
end $$
delimiter ;

call ej12('Juan','López');

delimiter $$
create procedure ej12_out
	(nombre varchar(60), apellido varchar(60), out extension char(3))
begin
	start transaction; 
		set extension = (select extelem
		from empleados
		where nomem = nombre and ape1em = apellido);
    commit;
end $$
delimiter ;

call ej12_out('Juan', 'López', @extension);



-- 13 
delimiter $$
create procedure ej13_1
	(numHijo int)
begin
	start transaction; 
		select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as NombreCompleto,
		numhiem as 'Nº hijos'
		from empleados
		where numhiem > numHijo;
    commit;
end $$
delimiter ;

call ej13_1(3);

delimiter $$
create procedure ej13_2
	(numHijo1 int, numHijo2 int)
begin
	start transaction; 
		select concat(nomem, ' ', ape1em, ' ', ifnull(ape2em, '')) as NombreCompleto,
	numhiem as 'Nº hijos'
	from empleados
	where numhiem = numHijo1 or numhiem = numHijo2;
    commit;
end $$
delimiter ;

call ej13_2(3, 5);

-- 14

select nomde
from empleados join departamentos 
	on empleados.numde = departamentos.numde
where nomem = 'Juan' and ape1em = 'López'; 		

delimiter $$
create procedure ej14
	(nombreCentro varchar(120))
begin 
	start transaction;
		select dirce
		from centros
		where ltrim(nomce) = nombreCentro;
    commit;
end $$ 
delimiter ;




