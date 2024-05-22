/*
Cuando se incluye un producto en una promoción, queremos controlar que su precio promocionado en ningún caso pueda ser mayor 
o igual al precio de venta habitual (precio fuera de promoción).  Si sucediera esto habrá que evitar que se añada dicho producto
 a la promoción y se avisará de lo sucedido mediante mensaje.
*/

delimiter $$
create trigger InsertarProdPromocion
	before insert on catalogospromos
for each row
begin 
	declare precioHabitual decimal(5,2);
    
    select precioventa into precioHabitual
    from articulos
    where precioventa = new.refart;
    
	if new.precioartpromo > precioHabitual then
		signal sqlstate '77777' 
			set message_text = 'No se puede añadir un precio superior o igual al precio habitual';
	end if;
end $$
delimiter ;

/*
También se nos ha pedido que controlemos lo anterior cuando se esté modificando el precio de un producto en una promoción. 
En este caso se permitirá la modificación pero se mantendrá el precio que tuviera previamente.
*/

delimiter $$
create trigger modificarPrecioProd
	before update on catalogospromos
for each row
begin
    if new.precioartpromo <> old.precioartpromo and
    new.precioartpromo > old.precioartpromo then
		set new.precioartpromo = old.precioartpromo;
		signal sqlstate '77777' 
			set message_text = 'No se puede añadir un precio superior o igual al precio habitual';
    end if;
end $$
delimiter ;

/*
Se ha elaborado un procedimiento “OptimizaCatalogosPromos”. 
Nos piden que hagamos lo que consideremos oportuno para que se ejecute cada semestre 
(2 trimestres) durante el próximo año. Para comenzar nos piden que lo dejemos preparado 
para que, desde hoy martes,  comience a ejecutarse el domingo a las 00.00h.
*/

create event eventoOptimizar
on schedule 
	every 2 month
    starts concat('2024-05-26 00:00:00')
    ends '2024-05-21' + interval 1 year
do 
		call OptimizaCatalogosPromos();

show events;

/*
Prepara un procedimiento que dado un alumno (su número de expediente) nos de un listado 
mostrando el número de respuestas válidas de dicho alumno por materia (nombre de materia) 
y test (código y descripción de test), vamos a utilizar las respuestas correspondientes a 
la última repetición de cada test y solo nos interesan los tests de los que haya más de 
una repetición, es decir, aquellos que el alumno haya hecho más de una vez. 
*/

drop procedure if exists resValidas;
delimiter $$
create procedure resValidas
	(in codigo int)
begin
	select materias.nommateria as materia, 
			tests.codtest as test, tests.descrip as descr,
				count(preguntas.resvalida) as validas
	from respuestas join preguntas
			on respuestas.numpreg = preguntas.numpreg
		join tests
			on preguntas.codtest = tests.codtest
		join materias
			on tests.codmateria = materias.codmateria
	where respuestas.numexped = codigo
    group by test
    having count(distinct respuestas.numrepeticion) > 1;
end $$
delimiter ;

call resValidas(1);

/*
Sobre la BD de Promociones prepara los triggers que consideres necesarios para que se lleve a cabo lo siguiente:
Cuando se hace una venta de un artículo, se debe comprobar si hasy suficiente stock del mismo, en caso contrario no se debe permitir que se produzca la venta.
Si se produce la venta, se debe reducir el stock del artículo en el número de unidades vendidas.
Si de dicho artículo quedan menos de 5 artículos, debemos hacer un pedido automático. Solo en el momento de que bajen a menos de 5 los artículos.
Nota.- Ten cuidado de que no se hagan muchos pedidos y que solo se hagan en el momento que baja a menos de 5 unidades el stock de un artículo y no en otro momento.
*/

delimiter $$
create trigger controlVentas
	before insert on detalleventa
for each row
begin 
	
    declare cantidad int;
    
	select stock into cantidad
    from articulos
    where refart = new.refart;
    
    if new.cant > cantidad then 
		signal sqlstate '45000' 
			set message_text = 'Error, la cantidad es mayor';
		elseif new.cant < cantidad then 
			update articulos
				set stock = stock - new.cant
			where refart = new.refart;
    end if;
end $$
delimiter ;
