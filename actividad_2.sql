create database if not exists actividad_2;

use actividad_2;

/*
Profesores(PK[numprof, numdepto*], despacho, fecnacim, fecingreso, sueldo, nomprof)
Deptos(PK[numdepto], presupuesto, nomdepto, ubicacion)
Asignaturas(PK[numasigna], nomasigna, curso, [numprof, numdepto]*)
Impartir(PK[numimpartir, numprof, numasigna, anio_acad], grupo)
*/

create table if not exists deptos
	(numdepto int not null,
    presupuesto decimal (10,2),
    nomdepto varchar (60),
    ubicacion varchar (120),
    constraint pk_deptos primary key (numdepto)
    );
    
create table if not exists profesores
	(numprof int not null,
    numdepto int not null,
    despacho varchar (60),
    fecanacim date not null,
    fecingreso date not null,
    sueldo decimal (7,2),
    nomprof varchar (60),
    numjefe int not null,
    constraint pk_profesores primary key (numprof),
    constraint fk_prof_depto foreign key (numdepto)
		references deptos (numdepto) on delete no action on update cascade,
	constraint fk_prof_jefe foreign key (numjefe)
		references profesores (numprof) on delete no action on update cascade
    );
    
create table if not exists asignaturas
	(numasigna int not null,
    numdepto int not null,
    numprof int not null,
    nomasigna varchar (60),
    curso varchar (10),
    constraint pk_asignatura primary key (numasigna),
    constraint fk_asigna_prof_depto foreign key (numdepto, numprof)
		references profesores (numdepto, numprof)
			on delete no action on update cascade
    );
    
create table if not exists impartir
	(numprofimp int not null,
    numasigna int not null,
    numprof int not null,
    anio_acad date,
    grupo varchar (10),
    constraint pk_impartir primary key (numprofimp, numasigna, numprof, anio_acad),
    constraint fk_impar_asing foreign key (numasigna)
		references asignaturas (numasigna) on delete no action on update cascade,
	 constraint fk_impar_prof foreign key (numprof)
		references profesores (numprof) on delete no action on update cascade
    );
    
    alter table profesores
			drop numjefe,
        add cf_jefes int not null,
			drop foreign key fk_prof_jefe,
		add constraint fk_jefe foreign key (cf_jefes)
		references profesores (numprof) on delete no action on update cascade;
        