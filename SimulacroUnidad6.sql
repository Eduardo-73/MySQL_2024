-- P1
select *
from obras join salas on 
	obras.codsala = salas.codsala
where salas.codsala = 1 and salas.codsala = 3;

-- P2
select concat(obras.nombreobra, ' (', artistas.nomartista, ')') as Nombre,
		salas.nomsala as NombreSala, obras.valoracion as Valoracion
from obras join artistas on
	obras.codartista = artistas.codartista join salas on 
		salas.codsala = obras.codsala
order by Valoracion;

-- P3
delimiter $$
create procedure ej_3
	(in fecha1 date,
	in fecha2 date)
begin 
		start transaction;
			select concat(obras.nombreobra, ' (', restaurador.nomres, ')') as NombreObrasRestaurada
			from obras join restauraciones on
				obras.codobra = restauraciones.codobra join restaurador on
					restauraciones.codrestaurador = restaurador.codres
			where restauraciones.fecfinrest between fecha1 and fecha2;
        commit;
end $$
delimiter ;

call ej_3('2010/1/2','2010/4/2');

<<<<<<< HEAD
-- P4
drop procedure ej_4;
delimiter $$
create procedure ej_4
	(in nombreObra varchar(120))
begin
	start transaction;
		select ifnull(artistas.nomartista, 'obra anónima')
        from obras join artistas on
			obras.codartista = artistas.codartista
		where obras.nombreobra = trim(nombreObra);
    commit;
end $$
delimiter ;

call ej_4('El Guernica');
=======
-- 
>>>>>>> origin/main
