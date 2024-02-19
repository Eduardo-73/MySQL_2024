use gbdturrural2015;

-- P.1
start transaction;
	insert into reservas
		(codreserva, codcliente, codcasa, fecreserva, pagocuenta, feciniestancia, 
        numdiasestancia, fecanulacion, observaciones)
	value	
		(3501, 520, 315, curdate(), 100, '2024-8-5', 7, null, null);
commit;

-- P.2

start transaction;
	insert into caracteristicasdecasas
		(codcasa, codcaracter, tiene, observaciones)
	value	
		(350, 17, 1, 'Barbacoa'),
        (350, 3, 2, 'A/A'),
        (350, 5, 3, 'Calefacción');
commit;

-- P.3

start transaction;
	update reservas
		set fecanulacion = curdate()
	where codreserva = 2450;
    
	insert into devoluciones 
		(numdevol, codreserva, importedevol)
	values
		(226, 2450, 200);
commit;

-- P.4

start transaction;
	delete from casas
		where codcasa = 5640 and codcasa = 5641;

	delete from propietarios
		where codpropietario = 520;
commit;

-- P.5

start transaction;
	update casas
		set numhabit = 3,
			m2 = 200,
            minpersonas = 4,
            maxpersonas = 8
		where codcasa = 5789;
commit;
