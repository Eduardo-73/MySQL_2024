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
	where alumnos.numexped = 1 and preguntas.resvalida = respuestas.respuesta
    group by materias.nommateria, tests.codtest;