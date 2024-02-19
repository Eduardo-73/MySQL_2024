select numem as numero, nomem as nombre, upper(ape1em) as 'Primer Apellido',
	ifnull(ape2em, 'Hola') as primApellido, ifnull(numhiem, 0) as 'Nº de Hijos' -- ifnull(elemento, 'si es nulo pone algo por defecto o nada')
from empleados
order by ape1em asc, nomem desc; -- manera por defecto ascendente 
-- order by 3 asc, 2 desc; Por posición que ocupa en los elementos de la tabla 

select salarem as salario, salarem * 1.10 as 'Incremento 10%'
from empleados;

-- Utilización del concat() y concat_ws()
select concat(nomem, ' ',  ape1em, ' ', ifnull(ape2em, ' '))-- Si quiero modificar las cadenas tengo que utilizar concat
from empleados;

select concat_ws(' ', nomem, ape1em, ape2em) as NombreCompleto, numhiem
from empleados
where numde = 100 and numhiem > 1; -- enseñar solo los empleados que quiero en señar 

-- mostrar todos los empleados del depto 100 o del departamento 130 y que su salario sea mayor a 100

select *
from empleados
where  (numde = 100 or numde = 130) and salarem > 1000;