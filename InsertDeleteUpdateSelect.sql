USE `empresaclase`;
-- Insert
insert into centros
-- Es opcional pero es mejor ponerlo para 
(numce, nomce, dirce, codpostal)
value
(40, 'prueba1', 'dir prueba1', '29001'),
(50, 'prueba2', 'dir prueba2', '29002');

insert into centros
-- No te deja añadir los datos ya que faltan campos que estan prediseñados en not null, pero si por defectos estan en defauld algo o null si te deja
(numce, nomce, dirce)
value
(70, 'prueba3', 'dir prueba3');

-- Select te coge una parte de la base de codigo que quieres controlar
select * from centros;
-- show te muestra la difinicion de como se ha creado la tabla  
-- show create table centros;
-- show databases;
-- show tables;

/*
Hemos creado un departamentos (I+D) y para dirigirlos hemos contratado 
a Juan del Campo Gonzalez
*/

-- Primero el insert en departamentos
-- start transaction hasta que no haga un commit o un rollback no se guarda definitivamente

start transaction;
set @maxdeptos = (select max(numde) from departamentos) + 1;
insert into departamentos
	(numde, numce, presude, depende, nomde)
values
	(@maxdeptos, 10, 100000.00, 120, 'I+D');
select * from departamentos;

-- Segundo el insert en empelados
set @maxemple = (select max(numem) from empleados) + 1;
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem,salarem, comisem, numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
values
	(@maxemple, @maxdeptos, '123', '1980/11/3', curdate(), 3000, 10, null, 'Juan', 'del Campo', 'González', '01010101Q', 'juan', '1234');
select * from empleados;

-- Tercero el insert en dirigir
insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values
	(@maxdeptos, @maxemple, curdate(), null, 'F');
select * from dirigir;
commit;

-- Delete
delete from dirigir
where numdepto > 131 and fecinidir = curdate(); 

delete from empleados
where nomem = 'Juan' and ape1em = 'del Campo' and ape2em = 'González'; 

delete from departamentos
where numde > 131; 

-- Update
start transaction;
update departamentos
set presude = 115000,
	nomde = 'PUBLICIDAD'
where nomde = 'Publicidad';


