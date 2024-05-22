drop procedure if exists crearFicheros;
delimiter $$
create procedure crearFicheros
	()
begin 
	declare nombreFichero varchar(120);
	declare nomEnti varchar(120);
	declare cod int;
	declare finCursor boolean default false;
    declare ficheroCur cursor for
    select distinct codEntidad, nomEntidad
    from entidades;
    declare continue handler for sqlstate '02000' set finCursor = true;
    open ficheroCur;
		fetch ficheroCur into cod, nomEnti;
		repeat
			
            set nombreFichero = concat('/var/lib/mysql-files/'
									, nomEnti, '.txt');
           
           set @fichero = concat('select *
								   from `', nomEnti, 
                                   '` into outfile \'', 
									nombreFichero, 
                                   '\' fields terminated by \',\' 
                                   lines terminated by \'\n\'');
                                    
            prepare banco from @fichero;
            execute banco;
            deallocate prepare banco;
            
		fetch ficheroCur into cod, nomEnti;
        until finCursor = true end repeat;		
    close ficheroCur;
end $$
delimiter ;
show variables like "secure_file_priv";
call crearFicheros();