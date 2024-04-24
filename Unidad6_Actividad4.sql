-- 21 
select extelem, count(nomem), round(avg(salarem))
from empleados
group by extelem;

-- 24
select nomem, concat('El ', day(fecinem), ' de ', cambiarIdiomaFecha(month(fecinem)), 
							' de ', year(fecinem))
/*date_format(fecinem, 'El %d de %M de %Y')*/
from empleados join dirigir on
	empleados.numem = dirigir.numempdirec
where tipodir = 'F' 
order by nomem;

drop function if exists cambiarIdiomaFecha;
delimiter $$
create function cambiarIdiomaFecha
	(fecha int)
returns varchar(120)
deterministic 
begin
	declare fechaEspaniol varchar(120);
    set fechaEspaniol = 
		case fechaEspaniol
			when 1 then 'enero'
            when 2 then 'Febrero'
            when 3 then 'Marzo'
            when 4 then 'Abril'
            when 5 then 'Mayo'
            when 6 then 'Junio'
            when 7 then 'Julio'
            when 8 then 'Agosto'
            when 9 then 'Septiembre'
            when 10 then 'Octubre'
            when 11 then 'Noviembre'
            when 12 then 'Diciembre'
		else
			'Error'
		end;
    return fechaEspaniol;
end $$
delimiter ;

-- 22
select departamentos.nomde as nombre, count(distinct extelem) 
from empleados join departamentos on
	empleados.numde = departamentos.numde
group by nombre
having avg(salarem) > (select avg(salarem)
						from empleados);