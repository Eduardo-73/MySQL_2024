insert into centros
	(numce, nomce, dirce, codpostal)
select empresaclase.centros.numce, empresaclase.centros.nomce, 
		empresaclase.centros.dirce, empresaclase.centros.codpostal
from empresaclase.centros;
        
insert into departamentos
	(numde, numce, presude, depende, nomde)
select empresaclase.departamentos.numde, empresaclase.departamentos.numce,
		empresaclase.departamentos.presude, empresaclase.departamentos.depende,
			empresaclase.departamentos.nomde
from empresaclase.departamentos;
    
insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
select empresaclase.dirigir.numdepto, empresaclase.dirigir.numempdirec, 
		empresaclase.dirigir.fecinidir, empresaclase.dirigir.fecfindir, 
			empresaclase.dirigir.tipodir
from empresaclase.dirigir;

insert into empleados
	(numem, numde, extelem, fecnaem, fecinem, salarem, comisem, 
		numhiem, nomem, ape1em, ape2em, dniem, userem, passem)
select empresaclase.empleados.numem, empresaclase.empleados.numde, empresaclase.empleados.extelem, 
		empresaclase.empleados.fecnaem, empresaclase.empleados.fecinem, empresaclase.empleados.salarem, 
			empresaclase.empleados.comisem, empresaclase.empleados.numhiem, empresaclase.empleados.nomem, 
				empresaclase.empleados.ape1em, empresaclase.empleados.ape2em, empresaclase.empleados.dniem, 
					empresaclase.empleados.userem, empresaclase.empleados.passem
from empresaclase.empleados;

alter table vendedores
	add column codem int,
    add constraint fk_vendedor_empleado foreign key (codem)
		references empleados (numem) 
			on delete no action on update cascade;

update vendedores
	set nomvende = 'Azucena Muñoz'
where nomvende = 'Maria';

update vendedores
	set nomvende = ' Mario Lasa'
where nomvende = 'Pedro';

update vendedores
	set nomvende = 'Cornelio Sanz'
where nomvende = 'Germán';

update vendedores 
	set nomvende = 'Julia Vargas'
where nomvende = 'Anaís';

update vendedores v join empleados e 
	on v.codem = e.numem
	set v.codem = e.numem
where v.codem is null;
	  
