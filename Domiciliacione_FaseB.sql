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
end $$
delimiter ;

call tablaEntBancaria();

drop procedure generarRecibos;
delimiter $$
create procedure generarRecibos
	()
begin
    declare fecRec date;
    declare pagadoRec boolean;
    declare codCliRec int;
    declare codEntRec int;
	declare numCuentaRec char(24);
    declare impRec decimal(5,2);
    declare finCursor boolean default false;
    declare cursorCli cursor for
		select fecRecibo, pagado, Recibos.codCli, Recibos.codEnt, numCuenta, importeFinal
        from Recibos join Clientes 
				on Recibos.codCli = Clientes.codCliente
			join DetallePlan  
				on Clientes.codCliente = DetallePlan.codCli
			join PlanProductos
				on DetallePlan.codPProd = PlanProductos.codPlan
		where estadoPlan = 'Activo';
	declare continue handler for sqlstate '02000' set finCursor = true;
    open cursorCli;
		repeat
			fetch cursorCli into fecRec, pagadoRec, codCliRec, codEntRec, numCuentaRec, impRec;
            if datediff(fecRecido,curdate()) < 35 then
				set impRec = (impRec / 30) * datediff(curdate(),fecRec);
            end if;
			insert into Recibos
				(codCli, pagado, fecRecibo, codEnt, numCuenta, importeFinal)
			values
				(codCliente, null, curdate(), codEntRec, numCuentaRec, impRec);
        until finCursor = true end repeat;
    close cursorCli;
end $$
delimiter ;

call generarRecibos();

/*
La teoria de este tema
Caracteristucas de base de datos objeto relacionales
Bases de datos NoSql y big data
Practica es el tema 7 + having
*/