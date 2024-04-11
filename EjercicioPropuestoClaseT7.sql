use empresaclase;

alter table empleados
	add constraint controlNumEmpleados check (numem <= 1500
    
    ),
	change column numem numem  int check(numem <= 1500),
	-- modify column fecinem date check (date_add(fecnaem, interval 16 year) <= fecinem),
    modify column userem varchar(12);
    
delimiter $$
create trigger controlInseccionDatosEmpleados
	before insert on empleados
for each row
begin 
	if (date_add(new.fecnaem, interval 16 year) > new.fecinem) then 
		signal sqlstate '77777'
			set message_text = 'Error';
	end if;
	if exists(select * from empleados where userem = new.userem) then
		signal sqlstate '77777'
			set message_text = 'Error';
    end if;
end $$
delimiter ;

    
delimiter $$
create trigger controlActualizacionDatosEmpleados
	before insert on empleados
for each row
begin 
	if (new.fecinem <> old.fecinem and new.fecnaem <> old.fecnaem)
		and (date_add(new.fecnaem, interval 16 year) > new.fecinem) then 
		signal sqlstate '77777'
			set message_text = 'Error';
	end if;
	if exists(select * from empleados where userem = new.userem) then
		signal sqlstate '77777'
			set message_text = 'Error';
    end if;
end $$
delimiter ;