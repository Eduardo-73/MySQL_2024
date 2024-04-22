-- 21 
select extelem, count(nomem), round(avg(salarem))
from empleados
group by extelem;

-- 24
select nomem, cambiarIdiomaFecha(fecinem)
/*date_format(fecinem, 'El %d de %M de %Y')*/
from empleados join dirigir on
	empleados.numem = dirigir.numempdirec
where tipodir = 'F' 
order by nomem;

drop function if exists cambiarIdiomaFecha;
delimiter $$
create function cambiarIdiomaFecha
	(fecha date)
returns varchar(120)
deterministic 
begin
	declare fechaEspañol varchar(120);
    set fechaEspañol = concat_ws(' ', day(fecha), monthname(fecha), year(fecha)); 
    return fechaEspañol;
end $$
delimiter ;