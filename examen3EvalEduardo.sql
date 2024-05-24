use scripdawphone;

-- P1
alter table clientes
	modify dniCli char(9) unique;
    
-- P2
create index consulta
	on clientes(idCliente, numCuentaCli);
    
-- P3
delimiter $$
create trigger numCuenta
	before insert on clientes
for each row
begin 
	if new.numCuentaCli not rlike '^[ES]' then 
		signal sqlstate '45000'
			set message_text = 'El número de cuenta debe empezar por ES';
    end if;
end $$
delimiter ;

-- P4
delimiter $$
create trigger planActivo
	before insert on planesclientes
for each row
begin
	declare planActivo tinyint(1);
    
    select Activo into planActivo
    from planesclientes
    where idCliente = new.idCliente;
    
    if  planActivo = 1 then
		signal sqlstate '45000'
			set message_text = 'Este cliente tiene un plan activo';
		update planesclientes
			set fecFinPlan = date_add(curdate(), interval -1 day)
		where idCliente = new.idCliente and Activo = 1; 
    end if; 
end $$
delimiter ;

-- P5

-- P6
drop event eventoComprobarCobro;
create event eventoComprobarCobro
on schedule
	every 1 month
    starts concat(year(current_date()), '-', month(current_date()), '-10 02:00:00') 
do
	call compruebaCobro();

show events;    

-- P7
select nombrePlan, count(*) as numClientes, 
	avg(datediff(fecFinPlan,fecIniPlan)) as mediaDias
from planes join planesclientes
	on planes.idPlan = planesclientes.idPlan
group by nombrePlan;

-- P8
drop procedure if exists numClientesPorPlan;
delimiter $$
create procedure numClientesPorPlan
	(in funt varchar(10))
begin
	set @plan = concat('select nombrePlan, count(*) as numClientes,',
						funt,'(datediff(fecFinPlan,fecIniPlan)) as mediaDias',
						' from planes join planesclientes
							on planes.idPlan = planesclientes.idPlan
						 group by nombrePlan;');
	prepare prep from @plan;
	execute prep;
	deallocate prepare prep;
end $$
delimiter ;

call numClientesPorPlan('max');

-- P9