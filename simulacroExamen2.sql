use gbdturrural2015;

-- P.1

start transaction;
	insert into clientes 
		(codcli, nomcli, ape1cli, ape2cli, dnicli, tlf_contacto,
        correoelectronico, dircli, pobcli, provcli, codpostalcli)
	values
		(899, 'Juan', 'del Campo', 'Sánchez', '07000001W',
        607000001, null, null, null, null, null);
	
    update reservas
		set codcliente = 899
	where codreserva = 4356;
commit;

-- P.2 

start transaction;
	delete from reservas
	where fecreserva = curdate() and codcliente = 456;
commit;

-- P.3
start transaction;
	update propietarios
		set tlf_contacto = 789000000,
			correoelectronico = 'dfg@gmail.com'
	where codpropietario = 789;
commit;

-- P.4
start transaction;
	delete from caracteristicas
	where numcaracter = 230 and numcaracter = 245;
commit;

-- P.5
update casas
	set preciobase = preciobase * 1.10
where numbanios = 3 and m2 = 200;
