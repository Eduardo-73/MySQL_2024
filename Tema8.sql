-- tabla temporal
create temporary table mitabla
	(id int,
    descripcion varchar(20),
    constraint pk_tablaTemporal primary key(id));

show create table mitabla;

select * from mitabla;

select numem, nomem
from empleados;

-- cursor
delimiter $$
declare numeroEmp int;
declare nombreEmp varchar(20);
declare miCursor cursor for
	select numem, nomem
    from empleados;

open miCursor;

fetch miCursor into numeroEmp, nombreEmp;
fetch miCursor into numeroEmp, nombreEmp;
delimiter ;



 