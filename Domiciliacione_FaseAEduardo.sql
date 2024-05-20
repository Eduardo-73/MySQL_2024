drop procedure generarRecibos;
delimiter $$
create procedure generarRecibos
	()
begin
	declare codRec int;
    declare fecRec date;
    declare pagadoRec boolean;
    declare codCliRec int;
    declare codEntRec int;
	declare numCuentaRec char(24);
    declare impRec decimal(5,2);
    declare finCursor boolean default false;
    declare cursorCli cursor for
		select codRecibo, fecRecibo, pagado, codCliente, codEnt, numCuenta, imp
        from clientes join detallePlan
				on clientes.codClientes = detallePlan.codCli
			join planProductos
				on detallePlan.codPPlan = planProductos.codPlan
		where estadoPlan = 'Activo';
	declare continue handler for sqlstate '02000' set finCursor = true;
    open cursorCli;
		repeat
			fetch cursorCli into codRec, fecRec, pagadoRec, codCliRec, codEntRec, numCuentaRec, impRec;
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