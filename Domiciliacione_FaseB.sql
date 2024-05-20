drop procedure tablaEntBancaria;
delimiter $$
create procedure tablaEntBancaria
	()
begin
    declare nomBancoEnt varchar(120);
    declare dirBancoEnt varchar(120);
    declare cpBancoEnt char(5);
    declare numCuentaBanco char(24);
	declare finCursor boolean default false;
	declare cursorBanco cursor for 
    select nomEntidad, dirEnvio, dirPostal, numCuenta
    from entidades join recibos
			on entidades.codEntidad = recibos.codEnt
		join clientes
			on recibos.codCli = clientes.codCliente
		join detalleplan
			on clientes.codCliente = detalleplan.codCli
	where detalleplan.estadoPlan = 'Activo';
    declare continue handler for sqlstate '02000' set finCursor = true;
    open cursorBanco;
		repeat
			fetch cursorBanco into nomBancoEnt, dirBancoEnt, cpBancoEnt, numCuentaBanco; 
            create temporary table banco 
				(
					codBanco int auto_increment,
                    nomBanco varchar(120),
                    dirBanco varchar(120),
                    cpBanco char(5),
                    numCuenta char(24)
                );
			insert into banco
				(nomBanco, dirBanco, dirBanco, numCuenta)
			values 
				(nomBancoEnt, dirBancoEnt, cpBancoEnt, numCuentaBanco);
        until finCursor = true end repeat;
    close cursorBanco;
    drop table if exists banco;
end $$
delimiter ;