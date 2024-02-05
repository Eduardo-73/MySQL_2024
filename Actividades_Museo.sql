-- actividad 9
use actividad_4;
-- actividad 10
select * from empleados;
	start transaction;
insert into empleados
	(numemple, nomemple, ape1em, ape2em, fecnacimem, presuem, comisem, 
    extlfem, numhiem, edademple)
value 
	(1, 'Pedro', 'González', 'Sánchez', '1972/2/12', 1400,
    null, 940, 1, 40);

insert into empleados
	(numemple, nomemple, ape1em, ape2em, fecnacimem, presuem, comisem, 
    extlfem, numhiem, edademple)
value 
	(2, 'Juan', 'Torres', 'Campos', '1975/2/25', 1400,
    null, 940, 0, 43);
	commit;

-- actividad 11
	start transaction;
update empleados
	set nomemple = 'Carmen',
    ape1em = 'Gómez',
    ape2em = 'Pérez',
    extlfem = 0000000000001
where numemple = 1;
	commit;

-- actividad 12










