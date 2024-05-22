drop procedure tablaEntBancaria;
delimiter $$
create procedure tablaEntBancaria
	()
begin
	declare nombreEnt varchar(120);
	declare finCursor boolean default false;
    
	declare cursorBanco cursor for 
    select distinct nomEntidad
    from entidades;
    
    declare continue handler for sqlstate '02000' set finCursor = true;
    
    open cursorBanco;
		fetch cursorBanco into nombreEnt; 
		repeat
			set nombreEnt = trim(nombreEnt);
            if nombreEnt is not null then 
				set @tabla = concat('create temporary table if not exists `', nombreEnt ,
										'` ( 
											idCliente int,
											nombreCli varchar(120),
											dniCli char(9),
											numCuenta char(24),
											importeRecibo decimal(10,2),
											primary key (idCliente)
                                            );' );
				prepare nombreBanco from @tabla;
				execute nombreBanco;
				deallocate prepare nombreBanco;
            end if;
            fetch cursorBanco into nombreEnt; 
        until finCursor = true end repeat;
    close cursorBanco;
end $$
delimiter ;

call tablaEntBancaria();

describe BancoA;

/*
La teoria de este tema
Caracteristucas de base de datos objeto relacionales
Bases de datos NoSql y big data
Practica es el tema 7 + having
*/