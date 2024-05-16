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