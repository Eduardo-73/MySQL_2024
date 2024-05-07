select zonas.nomzona, count(reservas.fecanulacion) as efectivas,
			count(*) - count(fecanulacion) as anuladas,
				avg(reservas.numdiasestancia) as numdia
from reservas join casas 
		on reservas.codcasa = casas.codcasa
	join zonas
		on casas.codzona = zonas.numzona
where zonas.numzona = 1
group by zonas.nomzona
having numdia > 3;