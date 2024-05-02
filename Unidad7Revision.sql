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
		and preguntas.resvalida = respuestas.respuesta
        and respuestas.numrepeticion = (select max(r2.numrepeticion)
										from respuestas as r2
										where r2.numexped = codAlumno 
											and r2.codtest = respuestas.codtest
                                            and r2.numpreg = respuestas.numpreg)
    group by tests.codtest, materias.nommateria;
end $$
delimiter ;

drop view if exists vistaMostrarAlumno;
create view vistaMostrarAlumno
as
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
	where preguntas.resvalida = respuestas.respuesta
			and respuestas.numrepeticion = (select max(r2.numrepeticion)
											from respuestas as r2
											where r2.numexped = respuestas.numexped 
												and r2.codtest = respuestas.codtest
												and r2.numpreg = respuestas.numpreg)
    group by tests.codtest, materias.nommateria
    having count(*) > 1;
	
select * 
from vistaMostrarAlumno;