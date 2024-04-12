use dawFood;

delimiter $$
create trigger ControlUpdateDawFood
	before update on productos
for each row
begin 
	if new.stock > old.stock then 
		signal  sqlstate '777777'
			set message_text = 'Error'; 
    end if;
end $$
delimiter ;