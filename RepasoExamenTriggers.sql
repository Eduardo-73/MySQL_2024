delimiter $$
create trigger ejercicio
	before insert on detalleventa
for each row
begin
	declare cantidad int;
    
	select stock into cantidad
    from articulos
    where refart = new.refart;
    
    if cantidad < new.cant then 
		signal sqlstate '77777'
			set message_text = 'Error';
	end if;
end $$
delimiter ;

use CIRCO;

delimiter $$
create trigger ejercicio1
	before insert on animales
for each row
begin
	if (new.tipo = 'León' and new.anhos > 20) then
		signal sqlstate '77777'
			set message_text = 'Error';
    end if;
end $$
delimiter ;

delimiter $$
create trigger ejercicio2
	before insert on animales
for each row
begin
	DECLARE v_nifArtista char(9);	-- Por defecto null
    DECLARE v_temp int default 0;
    
    -- Buscamos el artista que cuida a menos animales
    SELECT nif_artista, COUNT(*) as num
    INTO v_nifArtista,v_temp
    FROM ANIMALES_ARTISTAS
    GROUP BY nif_artista
    ORDER BY num asc
    LIMIT 1;
    
    IF (v_nifArtista IS NULL) THEN	-- No hay. Buscamos el primer artista que no sea jefe
        SELECT nif
        INTO v_nifArtista
        FROM ARTISTAS
        WHERE nif NOT IN (SELECT nif_jefe
                          FROM ARTISTAS
                          WHERE nif_jefe IS NOT NULL)  /* Necesario xa que con valores nulos NOT IN devolve NULO */
        LIMIT 1;
    END IF;

    IF (v_nifArtista IS NULL) THEN -- Error. En este caso se mantendría el animal en la tabla ya que el trigger es AFTER. Se tendría que hacer el control donde se hace la orden INSERT sobre la tabla ANIMALES
        SIGNAL SQLSTATE '45000' SET message_text='No hay artistas para cuidar a animales';
    END IF;
    
    INSERT INTO ANIMALES_ARTISTAS (nombre_animal,nif_artista)
    VALUES (NEW.nombre, v_nifArtista);
end $$
delimiter ;

delimiter $$
create trigger ej3Insert 
	after insert on atracciones_dia
for each row
begin
	declare fecha date;
    
    select ifnull(fecha_inicio,curdate()) into fecha
    from atracciones
    where nombre = new.nombre_atraccion;
    
    update atracciones
		set fecha_inicio = fecha,
			ganancias = ifnull(ganancias, 0) + new.ganancias
	where nombre = new.nombre_atraccion;
end $$
delimiter ;

delimiter $$
create trigger ej3Update
	after update on atracciones
for each row
begin 
	update atracciones 
    set ganancias = ganancias + new.ganancias - old.ganancias
	where nombre = old.nombre_atraccion;
end $$
delimiter ;

delimiter $$
create trigger ej3Delete
	after delete on atracciones
for each row
begin 
	update atracciones
		set ganancias = ganancias - old.ganancias
    where nombre = old.nombre_atraccion;
end $$
delimiter ;

alter table atracciones
	add column contador int default 0;
    
delimiter $$
create trigger ej4Insert
	after insert on atracciones
for each row
begin
	update atracciones
		set contador = contador + 1
	where nombre = new.nombre_atraccion;
end $$
delimiter ;

delimiter $$
create trigger ej4Delete
	after delete on atracciones
for each row
begin
	update atracciones
		set contador = contador - 1
	where nombre = new.nombre_atraccion;
end $$
delimiter ;

delimiter $$
create trigger ej5
	before insert on pistas
for each row
begin 
	if new.aforo > 1000 or new.aforo < 10 then
		signal sqlstate '77777'
			set message_text = 'Error';
	end if;
end $$
delimiter ;

delimiter $$
create trigger ej5Mod
	before update on pistas
for each row
begin 
	if new.aforo > 1000 or new.aforo < 10 then
		signal sqlstate '77777'
			set message_text = 'Error';
	end if;
end $$
delimiter ;

delimiter $$
create trigger ej6
	before insert on artistas
for each row
begin 
	if ((select count(*) from artistas where nif = new.nif_jefe) = 0) then
		update artistas
			set new.nif_jefe = null
		where nif = new.nif;
	end if;
end $$
delimiter ;

create table Resigstro
(
	id int,
    usuario varchar(100),
    tabla varchar(100),
    operacion varchar(10),
    datos_antiguos varchar(100),
	datos_nuevos varchar(100),
    fecha date,
    constraint pk_registros primary key (id)
);

-- Eventos
-- Habilita el planificador de eventos si no estÃ¡ habilitado
set global event_scheduler = ON;

-- Crea el evento
-- Habilita el planificador de eventos si no estÃ¡ habilitado
set global event_scheduler = ON;

-- Crea el evento
create event if not exists evento_1am
on schedule at '2024-03-22 01:00:00'
do call procedimientoBaseDato1am();

show events;
-- Migracio de eventos
-- PASO 2

-- Migrar datos de la base de datos de empresaClase a ventapromoscompleta

-- insertamos los datos de la tabla centros de la base de datos 
-- empresaclase en la tabla centros de la base de datos de ventapromoscompleta
insert into centros
	(numce,nomce,dirce,codpostal)
select empresaclase.centros.numce, empresaclase.centros.nomce, 
	empresaclase.centros.dirce, empresaclase.centros.codpostal
from empresaclase.centros;

-- insertamos los datos de la tabla departamentos de la base de datos 
-- empresaclase en la tabla departamentos de la base de datos de ventapromoscompleta
insert into departamentos
	(numde, numce, presude, depende, nomde)
select empresaclase.departamentos.numde, empresaclase.departamentos.numce, 
	empresaclase.departamentos.presude, empresaclase.departamentos.depende, 
    empresaclase.departamentos.nomde
from empresaclase.departamentos;

-- insertamos los datos de la tabla empleados de la base de datos 
-- empresaclase en la tabla empleados de la base de datos de ventapromoscompleta
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem, salarem, comisem, numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
select empresaclase.empleados.numem, empresaclase.empleados.numde, empresaclase.empleados.extelem, 
	empresaclase.empleados.fecnaem, empresaclase.empleados.fecinem, empresaclase.empleados.salarem,
    empresaclase.empleados.comisem, empresaclase.empleados.numhiem, empresaclase.empleados.nomem,
	empresaclase.empleados.ape1em, empresaclase.empleados.ape2em, empresaclase.empleados.dniem,
	empresaclase.empleados.userem, empresaclase.empleados.passem
from empresaclase.empleados;

-- insertamos los datos de la tabla dirigir de la base de datos 
-- empresaclase en la tabla dirigir de la base de datos de ventapromoscompleta
insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
select empresaclase.dirigir.numdepto, empresaclase.dirigir.numempdirec, empresaclase.dirigir.fecinidir,
	empresaclase.dirigir.fecfindir, empresaclase.dirigir.tipodir
from empresaclase.dirigir;


-- PASO 3

-- relacionamos la tabla entre vendedores y empleados
-- la foreign key irÃ¡ en vendedores
alter table vendedores
	add column numem int,
    add constraint fk_vendedores_empleados foreign key (numem) references empleados(numem) on delete no action on update cascade;
    
    
update vendedores join empleados on vendedores.nomvende = CONCAT(empleados.nomem, ' ', trim(empleados.ape1em))
set vendedores.numem = empleados.numem;

-- o puedes hacer lo siguiente

/*UPDATE vendedores 
SET vendedores.numem = (SELECT empleados.numem 
                        FROM empleados 
                        WHERE vendedores.nomvende = CONCAT(empleados.nomem, ' ', TRIM(empleados.ape1em)));
*/

-- PASO 4

alter table vendedores
	drop nomvende,
    drop fecincempresa;
    
-- Obtener los nombres y salarios de los empleados cuyo salario coincide 
-- con la comisión de algún otro o la suya propia.
select empleados.nomem as nombre, empleados.salarem as salario
from empleados
where salarem  = some (select empleados.comisem 
					from empleados);

/*
Obtener por orden alfabético los nombres de los empleados que trabajan en 
el mismo departamento que Pilar Gálvez o Dorotea Flor.
*/

select nomem
from empleados
where numde in (select empleados.numde
				from empleados join departamentos on
						empleados.numde = departamentos.numde
				where nomem = 'Pilar' or nomem = 'Dorotea')
order by nomem;

/*
Hallar el salario máximo y mínimo para cada grupo de empleados 
con igual número de hijos y que tienen al menos uno, 
y solo si hay más de un empleado en el grupo.
*/

select max(salarem), min(salarem)
from empleados
where numhiem in (select empleados.numhiem
					from empleados
                    group by numhiem
                    having count(*) > 1)
group by nomem;