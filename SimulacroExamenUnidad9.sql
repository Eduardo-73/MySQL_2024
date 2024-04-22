-- P.1.
/*
Queremos saber el importe de las ventas de artículos a cada uno de nuestros clientes 
(muestra el nombre). Queremos que cada cliente se muestre una sola vez y 
que aquellos a los que hayamos vendido más se muestren primero.
*/
select clientes.nomcli, sum(precioventa)
from clientes join ventas on 
	clientes.codcli = ventas.codcli join detalleventa on
		ventas.codventa = detalleventa.codventa
group by clientes.codcli
order by sum(precioventa);

-- P.2.
/*
Muestra un listado de todos los artículos vendidos, queremos mostrar la descripción del artículo 
y entre paréntesis la descripción de la categoría a la que pertenecen y la fecha de la venta con 
el formato “march - 2016, 1 (tuesday)”. Haz que se muestren todos los artículos de la misma categoría juntos.
*/

select desart, concat_ws('', nomart, descat), date_format(fecventa, '%M - %y, %d (%W)') 
from articulos join categorias 
		on articulos.codcat = categorias.codcat 
			join detalleventa 
		on articulos.refart = detalleventa.refart 
			join ventas 
		on ventas.codventa = detalleventa.codventa
group by categorias.descat;

-- P.3.
/*
Obtener el precio medio de los artículos de cada promoción (muestra la descripción de la promoción) del año 2012. 
(Se usará en el ejercicio 7).
*/
select avg(precioartpromo)
from articulos join catalogospromos
		on articulos.refart = catalogospromos.refart
	join promociones	
		on catalogospromos.codpromo = promociones.codpromo
where year(fecinipromo) = 2012
group by promociones.codpromo;

/*
 (1,25 ptos.) Prepara una rutina que muestre un listado de artículos, su referencia, su nombre y la categoría que no hayan estado en ninguna promoción que haya empezado en este año.
(1,25 ptos.) Queremos asignar una contraseña a nuestros clientes para la APP de la cadena, prepara una rutuina que dado un dni y un teléfono, nos devueltva la contraseña inicial que estará formada por: la inicial del nombre, los números correspondientes a las posiciones 3ª, 4ª Y 5ª del dni y el número de caracteres de su nombre completo. Asegúrate que el nombre no lleva espacios a izquierda ni derecha.
 (1,25 ptos.) Sabemos que de nuestros vendedores almacenamos en nomvende su nombre y su primer apellido y su segundo apellido, no hay vendedores con nombres ni apellidos compuestos. Obten su contraseña formada por la inicial del nombre, las 3 primeras letras del primer apellido y las 3 primeras letras del segundo apellido. 
(1,25 pto). Queremos saber las promociones que comiencen en el mes actual y para las que la media de los precios de los artículos de dichas promociones coincidan con alguna de las de un año determinado (utiliza el ejercicio P3. Tendrás que hacer alguna modificación).
(1,5 ptos.) Obtén un listado de artículos (referencia y nombre) cuyo precio venta sin promocionar sea el mismo que el que han tenido en alguna promoción.

*/