-- 1
/*
Hallar el salario medio para cada grupo de empleados con 
igual comisión y para los que no la tengan, pero solo nos 
interesan aquellos grupos de comisión en los que haya más de un empleado.
*/

select comisem, avg(salarem)
from empleados
group by comisem
having count(*) >= 1;

-- 2
/*
Para cada extensión telefónica, hallar cuantos empleados la usan y 
el salario medio de éstos. Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados.
*/
select extelem, count(nomem), avg(salarem)
from empleados
group by extelem
having count(*) between 1 and 3;

-- 3
/*
Prepara un procedimiento que, dado un código de promoción obtenga un listado con el nombre de 
las categorías que tienen al menos dos productos incluidos en dicha promoción.
*/
drop procedure if exists ej3;
delimiter $$
create procedure ej3
	(in codPromo int)
begin
	select nomcat
    from categorias join articulos 
			on categorias.codcat = articulos.codcat 
		join catalogospromos 
			on articulos.refart = catalogospromos.refart
	where codpromo = codPromo
    group by nomcat
    having count(*) >= 2;
end $$
delimiter ;

call ej3(1);

-- 4
/*
Prepara un procedimiento que, dado un precio, obtenga un listado con el nombre 
de las categorías en las que el precio  medio de sus productos supera a dicho precio.
*/
drop procedure if exists ej4;
delimiter $$
create procedure ej4
	(in precio decimal(5,2))
begin
	select nomcat
    from categorias join articulos
		on categorias.codcat = articulos.codcat
	group by nomcat
    having avg(preciobase) > precio;
end $$
delimiter ;

call ej4(5.50);

-- 5
/*
Prepara un procedimiento que muestre el importe total de las ventas por meses de un año dado.
*/
drop procedure if exists ej5;
delimiter $$
create procedure ej5
	(in anio int)
begin
	select month(fecventa), sum(precioventa)
    from detalleventa join ventas 
		on detalleventa.codventa = ventas.codventa
	where year(fecventa) = anio
    group by month(fecventa);
end $$
delimiter ;

call ej5(2012);

-- 6
/*
Como el ejercicio anterior, pero ahora solo nos interesa mostrar aquellos meses en los que se ha superado a la media del año.
*/
drop procedure if exists ej6;
delimiter $$
create procedure ej6
	(in anio int)
begin 
	select month(fecventa), sum(precioventa)
    from detalleventa join ventas 
		on detalleventa.codventa = ventas.codventa
	where year(fecventa) = anio
    group by month(fecventa)
    having avg(precioventa) > (select avg(precioventa) 
								from detalleventa join ventas 
									on detalleventa.codventa = ventas.codventa
								where year(fecventa) = anio);
end $$
delimiter ;

call ej6(2012);
