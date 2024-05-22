drop procedure insertarDatosBancarios;
delimiter $$
create procedure insertarDatosBancarios
	()
begin
	declare nomEnti varchar(120);
	declare cod int;
	declare finCursor boolean default false;
    
	declare cursorBanco cursor for 
    select distinct codEntidad, nomEntidad
    from entidades;
    
    declare continue handler for sqlstate '02000' set finCursor = true;
    
    open cursorBanco;
		fetch cursorBanco into cod, nomEnti; 
		repeat 
            set @tabla = concat('insert into `',  nomEnti, 
				'` (idCliente, nombreCli, dniCli, numCuenta, importeRecibo)
					select c.codCliente, c.nombre, c.dni, c.cuentaBancaria, r.importeFinal
					from clientes c join recibos r
						on c.codCliente = r.codCli
					where c.codEnt = ', cod, ';');
			
            prepare banco from @tabla;
            execute banco;
            deallocate prepare banco;
            fetch cursorBanco into cod, nomEnti; 
        until finCursor = true end repeat;
    close cursorBanco;
end $$
delimiter ;

call insertarDatosBancarios();

select * from BancoA;