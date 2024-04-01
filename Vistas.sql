/*
create view vEmpleados;
	(numEmple, nombreEmpleados, )
*/
-- view La utilizamos para ver una parte de las columnas
drop view vPromo;
create view vPromo
	(numArt, nomArt, precio)
as 
	select articulos.refart, articulos.nomart, catalogospromos.precioartpromo
    from articulos join catalogospromos on
		articulos.refart = catalogospromos.refart join promociones on
			catalogospromos.codpromo = promociones.codpromo
    where curdate() between promociones.fecinipromo and date_add(promociones.fecinipromo, interval promociones.duracionpromo day)

union 
	
    select articulos.refart, articulos.nomart, articulos.precioventa
    from articulos
	where refart not in (select catalogospromos.refart
    from catalogospromos join promociones on
			catalogospromos.codpromo = promociones.codpromo
    where curdate() between promociones.fecinipromo and date_add(promociones.fecinipromo, interval promociones.duracionpromo day));
    
select precio 
from vPromo
where numArt = 'c1_01';

select *
from articulos 
where preciobase > some (select preciobase
						from articulos
                        where codcat = 1);

select *
from articulos 
where preciobase >= any (select preciobase
						from articulos
                        where codcat = 1);

select *
from articulos 
where preciobase >= all (select preciobase
						from articulos
                        where codcat = 1);

select *
from articulos
-- where preciobase in es lo mismo
where preciobase = any (select preciobase
						from articulos
                        where codcat = 1);















