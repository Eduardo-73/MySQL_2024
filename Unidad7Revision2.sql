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

