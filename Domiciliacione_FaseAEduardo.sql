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
	dec
    declare finCursor boolean default false;
    declare continue handler for sqlstate '02000' set finCursor = true;
    declare cursorCli cursor for
		select codRecibo, fecRecibo, pagado, codCliente, codEnt, numCuenta, imp
        from clientes join detallePlan
				on clientes.codClientes = detallePlan.codCli
			join planProductos
				on detallePlan.codPPlan = planProductos.codPlan
		where estadoPlan = 'Activo';
    
    open cursorCli;
		repeat
			fetch cursorCli into codRec, fecRec, pagadoRec, codCliRec, codEntRec, numCuentaRec, impRec;
            if datediff(fecRecido,curdate()) < 35 then
				set imp = (imp / 30) * datediff(curdate(),fec);
            end if;
			insert into Recibos
				(codCli, pagado, fecRecibo, importeFinal)
			values
				(codCliente, null, curdate(), imp);
        until finCursor = true end repeat;
    close cursorCli;
end $$
delimiter ;

call generarRecibos();