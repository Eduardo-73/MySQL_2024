delimiter $$
create trigger ej_1
	before insert on ventas 
for each row
begin 
	declare stock_actual int;
    
	select stock into stock_actual
    from ventas join detalleventa on
		ventas.codventa = detalleventa.codventa join articulos on
			detalleventa.refart = articulos.refart
	where articulos.refart = new.articulos.refart;
    
    if stock_actual < new.detalleventa.cant then 
     signal sqlstate '77777'
        set message_text = 'No hay suficiente stock para realizar la venta.';
	end if;
end $$
delimiter ;

delimiter $$
create trigger ej_2
	after insert on ventas
for each row
begin
	declare unidadesVendidas int;
    
    select cant into unidadesVendidas
    from ventas join detalleventa on
		ventas.codventa = detalleventa.codventa join articulos on
			detalleventa.refart = articulos.refart
	where articulos.refart = new.articulos.refart;
    if new.articulos.stock < unidadesVendidas then 
		signal sqlstate '77777'
        set message_text = 'No hay suficiente stock para realizar la venta.';
	else 
		UPDATE articulos
        SET stock = stock - unidadesVendidas
        WHERE refart = NEW.articulos.refart;
    end if;
end $$
delimiter ;

delimiter $$
create trigger ej_3
	after insert on articulos
for each row
begin	
	if new.stock < 5 then
     insert into pedidos
		(codpedido, fecpedido, fecentrega, refart, cantidad)
	  value
		(new.pedidos.codpedido, curdate(), curdate(), new.pedidos.refart, 20);
	end if;
end $$
delimiter ;