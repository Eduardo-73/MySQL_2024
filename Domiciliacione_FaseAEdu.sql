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
            if datediff(fecRec,curdate()) < 35 then
				set impRec = (impRec / 30) * datediff(curdate(),fecRec);
            end if;
			insert into Recibos
				(codCli, pagado, fecRecibo, codEnt, numCuenta, importeFinal)
			values
				(codCliRec, null, curdate(), codEntRec, numCuentaRec, impRec);
        until finCursor = true end repeat;
    close cursorCli;
end $$
delimiter ;

call generarRecibos();