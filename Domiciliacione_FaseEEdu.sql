drop event sacarRecibobanco;
delimiter $$
create event sacarRecibobanco
on schedule
	every 1 month
    starts concat(year(current_date()), '-', month(current_date()), '-05 05:00:00') 
do
	begin
		call generarRecibos();
		call tablaEntBancaria();
		call insertarDatosBancarios();
		call crearFicheros();
    end $$
delimiter ;

show events;