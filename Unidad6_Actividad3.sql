use empresaclase;
-- 1
delimiter $$
create procedure ej_1
	()
begin
	start transaction;
		select max(empleados.salarem) as Salario_Max
        from empleados
        group by nomem;
    commit;
end $$
delimiter ;

call ej_1();

-- 2
delimiter $$
create procedure ej_2
	()
begin
	start transaction;
		select min(empleados.salarem) as Salario_Min
        from empleados
        group by nomem;
    commit;
end $$
delimiter ;

call ej_2();

-- 3
delimiter $$
create procedure ej_3
	()
begin
	start transaction;
		select avg(empleados.salarem) as Salario_Medio
        from empleados
        group by nomem;
    commit;
end $$
delimiter ;

call ej_3();

-- 4
delimiter $$
create procedure ej_4
	()
begin
	start transaction;
		select departamentos.nomde as Nombre, 
        max(empleados.salarem) as Salario_Max, 
        min(empleados.salarem) as Salario_Min, 
        avg(empleados.salarem) as Salario_Medio
        from empleados join departamentos on 
			empleados.numde = departamentos.numde
		where nomde = 'organización'
        group by departamentos.nomde;
    commit;
end $$
delimiter ;

call ej_4();

-- 5 
delimiter $$
create procedure ej_5
	(in nombreDepto varchar(120))
begin
	start transaction;
		select departamentos.nomde as Nombre, 
        max(empleados.salarem) as Salario_Max, 
        min(empleados.salarem) as Salario_Min, 
        avg(empleados.salarem) as Salario_Medio
        from empleados join departamentos on 
			empleados.numde = departamentos.numde
		where nomde = nombreDepto
        group by departamentos.nomde;
    commit;
end $$
delimiter ;

call ej_5('organización');

-- 6 
delimiter $$
create procedure ej_6
	(in nombreDepto varchar(120))
begin
	start transaction;
		select departamentos.nomde as Nombre, sum(empleados.salarem) as Salario
        from empleados join departamentos on 
			empleados.numde = departamentos.numde
		where nomde = nombreDepto
        group by departamentos.nomde;
    commit;
end $$
delimiter ;

call ej_6('organización');

-- 7
delimiter $$
create procedure ej_7
	()
begin
	start transaction;
		select departamentos.nomde as Nombre, 
        sum(departamentos.depende) as Salario
        from empleados join departamentos on 
			empleados.numde = departamentos.numde
        group by departamentos.nomde;
    commit;
end $$
delimiter ;

call ej_7();

-- 8 
delimiter $$
create procedure ej_8
	()
begin
	start transaction;
		select departamentos.nomde as Nombre, 
        max(empleados.salarem) as Salario_Max, 
        min(empleados.salarem) as Salario_Min, 
        avg(empleados.salarem) as Salario_Medio
        from empleados join departamentos on 
			empleados.numde = departamentos.numde
        group by departamentos.nomde;
    commit;
end $$
delimiter ;

call ej_8();

-- 9 





