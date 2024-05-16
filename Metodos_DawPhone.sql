-- drop index busquedaClientes on Clientes;
create index busquedaClientes
	on Clientes (codEnt);
    
-- drop procedure GenerarFicheroCobro;
delimiter $$
create procedure GenerarFicheroCobro
	()
begin
	declare codReciboTemp int;
    declare codCliTemp int;
    declare importeTemp decimal(5,2);
	declare contador int default 1;
	declare totalcli int;
	select count(*) into totalcli 
	from Clientes;
    drop temporary table if exists ficheroCobro;
    create temporary table ficheroCobro
		(
			codCobro int,
            codCli int,
            importe decimal(5,2),
            constraint pk_cobro primary key(codCobro)
        );
	insert ficheroCobro
		(codCobro, codCli, importe)
	select codRecibo, codCli, importeFinal
	from recibos
	where pagado = false;
    begin
		declare cursor1 cursor for 
			select codCobro, codCli, importe 
			from ficheroCobro;
		open cursor1;
			repeat
				fetch cursor1 into codReciboTemp, codCliTemp, importeTemp;
					set contador = contador + 1;
            until contador > totalcli end repeat;
            select codReciboTemp, codCliTemp, importeTemp;
        close cursor1;
	end;
end $$
delimiter ;

-- drop event recibosMensuales;
create event recibosMensuales
on schedule
		every 1 month
    starts timestamp(current_date + interval 5 day + interval 2 hour)
do
	call GenerarFicheroCobro();

-- drop procedure FicherosBancarios;
delimiter $$
create procedure FicherosBancarios()
begin
    declare entBanc int;
    declare importe decimal(10, 2);
    declare cursorBanco cursor for
        select codEntidad 
        from Entidades;
        declare totalcli int;
	select count(*) into totalcli 
	from Clientes;
    begin
		declare contador int default 1;
		declare continue handler for not found
		open cursorBanco;
		repeat
			fetch cursorBanco into entBanc;
        drop temporary table if exists TempBanco;
        create temporary table if not exists TempBanco AS
        select r.codCli, r.importeFinal
        from Recibos r
        inner join Clientes c on r.codCli = c.codCliente
        where c.codEnt = entBanc;
        
		until contador > totalcli end repeat;
		close cursorBanco;
    end;
end $$
delimiter ;

call FicherosBancarios();