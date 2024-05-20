drop procedure if exists crearFicheros;
delimiter $$
create procedure crearFicheros
	()
begin 
	declare finCursor boolean default false;
    declare fichero cursor for
    select distinct codEntidad, nomEntidad, dirEnvio, dirPostal
    from entidades;
    declare continue handler for sqlstate '02000' set finCursor = true;
    open fichero;
		
    close fichero;
end $$
delimiter ;