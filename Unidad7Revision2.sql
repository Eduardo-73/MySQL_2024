
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

drop procedure if exists mostrarResVali;  
delimiter $$
create procedure mostrarResVali
	(in codAlumno int)
begin 
	select materias.nommateria, tests.codtest, tests.descrip, count(preguntas.resvalida)
	from alumnos join matriculas 
			on alumnos.numexped = matriculas.numexped 
        join materias
			on matriculas.codmateria = materias.codmateria
		join tests
			on materias.codmateria = tests.codmateria
		join preguntas
			on tests.codtest = preguntas.codtest
		join respuestas
			on preguntas.numpreg = respuestas.numexped
	where alumnos.numexped = codAlumno
    group by tests.codtest
    having count(distinct respuestas.numrepeticion) > 1;
end $$
delimiter ;

call mostrarResVali(11);

drop view if exists mostrarResValiView;  
create view mostrarResValiView
	(numexped,resvalida,nommateria,codtest,descrip,numexped)
as
	select respuestas.numexped,count(resvalida), materias.nommateria, tests.codtest, tests.descrip
	from alumnos join matriculas 
			on alumnos.numexped = matriculas.numexped 
        join materias
			on matriculas.codmateria = materias.codmateria
		join tests
			on materias.codmateria = tests.codmateria
		join preguntas
			on tests.codtest = preguntas.codtest
		join respuestas
			on preguntas.numpreg = respuestas.numexped
	where numrepeticion in (select max(numrepeticion) from respuestas)
    group by tests.codtest
    having count(distinct respuestas.numrepeticion) > 1;

select * from mostrarResValiView;

select zonas.nomzona, count(reservas.fecanulacion) as efectivas,
			count(*) - count(fecanulacion) as anuladas,
				avg(reservas.numdiasestancia) as numdia
from reservas join casas 
		on reservas.codcasa = casas.codcasa
	join zonas
		on casas.codzona = zonas.numzona
group by zonas.nomzona
having numdia > 3;

/*
Queremos saber cuantas reservas se anulan por periodos de meses, estos es, cuantas
reservas se anulan un mes antes del inicio de estancia
cuantas reservas se anulan dos meses antes del inicio de estancia
*/

select datediff(feciniestancia, fecanulacion) div 30 as meses,
	count(codreserva) 
from reservas 
where fecanulacion is not null
group by meses
having meses < 3;



