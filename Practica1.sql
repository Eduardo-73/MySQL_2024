-- 1
select datediff(feciniestancia,fecanulacion) div 30 as meses,
	count(fecanulacion) as fecAnu, count(feciniestancia) as fecIni
from reservas
where fecanulacion is not null
group by meses;

-- 2
select codreserva as cod, datediff(feciniestancia,fecanulacion) div 30 as meses,
	count(fecanulacion) as fecAnu, count(feciniestancia) as fecIni
from reservas
where fecanulacion is not null
group by cod;