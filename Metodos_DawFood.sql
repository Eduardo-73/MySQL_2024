use dawFood;

drop trigger if exists controlStockDawFood; 
delimiter $$
create trigger controlStockDawFood
	after insert on detalles_tickets
for each row
begin 
		update productos
			set stock = stock - new.cantidad
		where id = new.codProd;
end $$
delimiter ;

drop trigger if exists actualizarProductosDawFood; 
delimiter $$
create trigger actualizarProductosDawFood
	before insert on detalles_tickets
for each row
begin 
	declare cant int;
    
    select stock into cant
    from productos
    where id = new.codProd;

	if new.cantidad > cant then 
		signal sqlstate '45000'
			set message_text = 'Error, no hay suficiente stock';
	end if;
end $$
delimiter ;

delimiter $$
create procedure generarRecibos
	()
begin
	declare contador int default 1;
    declare anioCli int;
    declare mesCli int;
    declare diaCli int;
    declare totalCli int;
    declare cursorCli cursor for
		select codCliente
        from clientes;
	set totalCli = (select * from Clientes);
    open cursorCli;
		repeat
			fetch cursorCli into codCLiente;
			insert into Recibos
				(codRecibo, codCli, fecRecibo, importeFinal)
			values
				();
        until contador = totalCli end repeat;
    close cursorCli;
end $$
delimiter ;
