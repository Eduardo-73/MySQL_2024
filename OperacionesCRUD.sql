-- Precedimientos de Departamentos 

delimiter $$
create procedure InsertarDepartamentos
	(in numeroCentro int, in presupuestoDepto int,
    in dependenciaDepto decimal(10,2), in nombreDepto varchar(60))
    
begin
	declare numeroDepto int;
    declare exit handler for SQLEXCEPTION
    rollback;
	start transaction;
		set numeroDepto = (select max(numde) from departamentos) + 1;
		insert into departamentos
			(numde, numce, presude, depende, nomde)
		values
			(numeroDepto, numeroCentro, presupuestoDepto, dependenciaDepto, nombreDepto);
	commit;
end $$
delimiter ;

delimiter $$
create procedure EliminarDepartamentos
	(in numeroDepto int)
    
begin
    declare exit handler for SQLEXCEPTION
    rollback;
	start transaction;
		delete from departamentos
		where numde = numeroDepto;
	commit;
end $$
delimiter ;

delimiter $$
create procedure ModificarDepartamentos
	(in numDepto int, in numCentros int, 
    in presuDepto int, in depenDepto decimal(10,2), in nombreDepto varchar(60))
begin
	start transaction;
		update departamentos
			set numde = numDepto,
				numce = numCentros,
				presude = presuDepto,
                depende = depenDepto,
                nomde = nombreDepto
		where numde = numDepto;
    commit;
end $$
delimiter ;

-- Procedimientos de Empleados 

delimiter $$
create procedure InsertarEmpleados
	(in extendionTLF char(3), in fecNacimiento date,
    in fecInicioEm date, in salarioEmp decimal(7,2),
    in comisionEmp decimal(7,2), in numHijosEmp tinyint,
    in nombreEmp varchar(20), in ape1Emp varchar(20),
    in ape2Emp varchar(20), in DNIEmp char(9),
    in userEmp char(9), in passeEmp char(9))
begin 
	declare numMaxEmp int;
    declare numMaxDepto int;
    declare exit handler for SQLEXCEPTION
    rollback;
	start transaction;
		set numMaxEmp = (select max(numem) from empleados) + 1;
        set numMaxDepto = (select max(numde) from departamentos) + 1;
		insert into empleados
			(numem, numde, extelem, fecnaem, fecinem, salarem, comisem, 
				numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
		values
			(numMaxEmp, numMaxDepto, extendionTLF, fecNacimiento, fecInicioEm, 
				salarioEmp, comisionEmp, numHijosEmp, nombreEmp, ape1Emp, ape2Emp,
					DNIEmp, userEmp, passeEmp);
    commit;
end $$
delimiter ;

delimiter $$
create procedure EliminarEmpleados
	(in numEmp int)
begin
	declare exit handler for sqlexception 
    rollback;
    start transaction;
		delete from empleados
        where numem = numEmp;
    commit;
end $$
delimiter ;

delimiter $$
create procedure ModificarEmpleados
	(in numEmp int, in numDepto int, in extendionTLF char(3), 
    in fecNacimiento date, in fecInicioEm date, in salarioEmp decimal(7,2),
    in comisionEmp decimal(7,2), in numHijosEmp tinyint,
    in nombreEmp varchar(20), in ape1Emp varchar(20),
    in ape2Emp varchar(20), in DNIEmp char(9),
    in userEmp char(9), in passeEmp char(9))
begin 
	declare exit handler for sqlexception 
    rollback;
	start transaction;
		update empleados
			set numem = numEmp,
				numde = numDepto,
                extelem = extendionTLF,
                fecnaem = fecNacimiento,
                fecinem = fecInicioEm,
                salarem = salarioEmp,
                comisem = comisionEmp,
                numhiem = numHijosEmp,
                nomem = nombreEmp,
                ape1em = ape1Emp,
                ape2em = ape2Emp,
                dniem = DNIEmp,
                userem = userEmp,
                passem = passeEmp
		where numem = numEmp;
    commit;
end $$
delimiter ;

-- Procedimientos para Dirigir

delimiter $$
create procedure InsertarDirigir
	(in fecInicioDir date, in fecFinDir date,
    in tipoDir char(1))
begin
	declare numDepto int;
    declare numEmpDir int;
	declare exit handler for sqlexception
    rollback;
	start transaction;
		set numDepto = (select max(numde) from departamentos);
        set numEmpDir = (select max(numem) from empleados);
        insert into dirigir
			(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
		values
			(numDepto, numEmpDir, fecInicioDir, fecFinDir, tipoDir);
    commit;
end $$
delimiter ;

delimiter $$
create procedure EliminarDirigir
	(in fecInicioDir date)
begin
	declare exit handler for sqlexception
	rollback;
	start transaction;
		delete from dirigir
        where fecinidir = fecInicioDir;
    commit;
end $$
delimiter ;

delimiter $$
create procedure ModificarDirigir
	(in numDepto int, in numEmpDir int,
    in fecInicioDir date, in fecFinDir date, in tipoDir char(1))
begin
	declare exit handler for sqlexception
	rollback;
	start transaction;
		update dirigir
			set numdepto = numDepto,
				numempdirec = numEmpDir,
                fecinidir = fecInicioDir,
                fecfindir = fecFinDir,
                tipodir = tipoDir
			where numdepto = numDepto and numempdirec = numEmpDir;
    commit;
end $$
delimiter ;





