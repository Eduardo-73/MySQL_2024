use empresaclase;

-- 1º) 

select concat_ws('', empleados.nomem, empleados.ape1em, empleados.ape2em) as Nombre, 
	empleados.extelem as NumeroDePlanta
from empleados
where extelem not like 120;

use GBDturRural2015;

-- 2º)

select *
from clientes
where codpostalcli rlike '00[1-9]$';

-- 3º)

select *
from clientes
where codpostalcli rlike '00[1-9]$ | 01[1-9]$ | 02[1-9]$';

-- 4º) 

select *
from clientes
where correoelectronico rlike '%@%.(com|es|eu|net)$';

-- 5º)

select *
from clientes
where correoelectronico not rlike '%@%.(com|es|eu|net)$';