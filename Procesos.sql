/*
Procedimiento para insertar datos en la tabla centros
drop procedure if exists InsertarCentros;
delimiter $$
create procedure InsertarCentros
	(in nombreCentros varchar(60),
    in dirCentros varchar(60))
begin
	declare nuevoCentro int;
    declare exit handler for SQLEXCEPTION 
    (Exit sale del proceso; Continue sigue a la siguiente línea del código)  
rollback;
	start transaction
set nuevoCentro = (select centros max(numce) from centros) + 1;
insert into centros 
	(numce,nomce, dirce)
values
	(nuevoCentro, nombreCentros, dirCentros);
	commit;
end $$
delimiter ;
*/
/*
Procedimiento que devuelve algun dato
drop procedure if exists InsertarCentros;
delimiter $$
create procedure InsertarCentros
	(in nombreCentros varchar(60),
    in dirCentros varchar(60),
    out valorDevuelto int)
begin
	declare nuevoCentro int;
    declare exit handler for SQLEXCEPTION
rollback;
	set valorDevuelto = -1;
	start transaction
set nuevoCentro = (select centros max(numce) from centros) + 1;
insert into centros 
	(numce,nomce, dirce)
values
	(nuevoCentro, nombreCentros, dirCentros);
	commit;
    set valorDevuelto = 1;
end $$
delimiter ;
*/

-- Para llamar a los precesos 
-- call InsertarCentros('nombre prueba', 'dir Prueba', @Resulado);
-- Al utilizar un out para probar que funciona nuestro preceso lo hacemos con una variable aux utilizando el @
-- Dentro de los procesos siempre utilizamos variable declaradas por nosotros utilizando declare
