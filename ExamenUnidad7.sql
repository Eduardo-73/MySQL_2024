use GBDgestionaTests;

-- P.1
delimiter $$
create trigger ejP1
	before insert on tests
for each row 
begin 
	declare descripcion varchar(30);
    
    select descrip into descripcion
    from tests;
    
    if new.descrip = descripcion then
		signal sqlstate '77777'
			set message_text = 'Error, no pueden haber tests iguales';
    end if;
end $$
delimiter ;

-- P.2
create index buscarNombreMateria
	on materias(nommateria);
    
-- P.3 
delimiter $$
create trigger ej3
	before insert on preguntas
for each row 
begin
	if new.resvalida != 'A' or new.resvalida != 'B' or new.resvalida != 'C' then
		signal sqlstate '77777'
			set message_text = 'Error, la respuesta solo puede ser A,B o C';
    end if;
end $$
delimiter ;

-- P.5
delimiter $$
create procedure incrementaNotas()
begin
	update matriculas
	set nota = nota + 1
	where numexped in (select numexped
					   from respuestas
                       where respuestas.codmateria = matriculas.codmateria
					   group by numexped
					   having count(distinct codtest) >= 10);
end $$
delimiter ;

create event incrementarAño
on schedule
	every 1 year
    starts curdate() + interval 1 day
    ends '2024/6/20' + interval 10 year
do
	call incrementaNotas();
    
-- P.6
delimiter $$
create trigger ej6
	after update on matriculas
for each row
begin 
	if old.nota <> new.nota 
		and new.nota > 10 then
		signal sqlstate '77777'
			set message_text = 'Error, la nota es mayor que 10';
	end if;
end $$ 
delimiter ;

-- P.7
delimiter $$
create trigger ej7
	before insert on alumnos
for each row
begin
	if new.password not rlike '^[^0-9]([a-z]+)([=_?!]+)([0-9]+).{3,}' or
		new.email not rlike '@.*([.][a-z]{2,3})$' or
        new.telefono rlike '^[679][0-9]{3} [0-9]{3} [0-9]{3}'
        then
    begin
        signal sqlstate '77777' 
			set message_text = 'Error, no se cumplen los requisitos';
    end;
    end if;
end $$
delimiter ;

-- P.8
delimiter $$
create trigger ej8
	before insert on preguntas
for each row
begin
	if new.resa = new.resb 
		or new.resb = new.resc 
		or new.resa = new.resc then
	begin
		signal sqlstate '77777' 
			set message_text = 'Error, no puede haber dos respuestas iguales';
    end;
    end if;
end $$