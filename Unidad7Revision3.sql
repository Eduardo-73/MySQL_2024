select zonas.nomzona, count(reservas.fecanulacion) as anuladas,
	count(reservas.fecanulacion) as efectivas,
		avg(reservas.numdiasestancia) as numdia
from reservas join casas
		on reservas.codcasa = casas.codcasa 
    join zonas
		on casas.codzona = zonas.numzona
where fecanulacion is not null = codreserva 
	and fecanulacion is null = codreserva
group by zonas.numzona
having numdia > 3;
    