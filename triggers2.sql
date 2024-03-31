delimiter $$
create trigger ej1
before insert on promociones
for each row
begin
	declare promoActiva int;
    set promoActiva = (
		select count(*)
		from promociones
        where fecinipromo <= date_add(new.fecinipromo, interval new.duracionpromo day)
			and fecinipromo >= new.fecinipromo);
	if promoActiva > 0 then
		signal sqlstate '45000'
			set message_text = 'Error';
	end if;
end $$
delimiter ;

delimiter $$
create trigger ej2
before insert on promociones
for each row
begin
	declare precio_hab decimal(10,2);
    set precio_hab = (
		select precioventa
		from promociones join catalogospromos on
			promociones.codpromo = catalogospromos.codpromo join articulos on
				catalogospromos.refart = articulos.refart
        where refart = new.codpromo);
	if articulos.precioventa < precio_hab then
		signal sqlstate '45000'
			set message_text = 'Error';
	end if;
end $$
delimiter ;

delimiter $$ 
create trigger ej3
after insert on articulos
for each row
begin
	declare puntos int default 0;
    set puntos = (select ptosparacli
				from catalogospromos
                where refart = new.refart); 
	update clientes
    set ptosacumulados = ptosacumulados + puntos
    where codcli = new.clientes.codcli;
end $$
delimiter ; 

alter table clientes
	add column usuario varchar(60),
    add column contraseña varchar(60);