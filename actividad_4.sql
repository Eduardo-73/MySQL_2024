/*
Tipo_Obras(PK[numtipoobra])
Artistas(PK[numart])
Obras(PK[numobras], numtipoobras*, numart*, numestilos*, numsalas*)
Estilos(PK[numestilos])
Salas(PK[numsalas])
Restauradores(PK[numres], numem*)
Seguridad(PK[numseguridad], numsala*, numem*)
Empleados(PK[numem])
Restauraciones(PK[numrestauraciones, numobras*, numrestauradores*, fecinirest*])
*/
/*drop database actividad_4;*/
create database if not exists actividad_4;

use actividad_4;

create table if not exists tipoObras
	(numtipoObra int not null,
    constraint pk_tipoObras primary key (numtipoObra)
    );

create table if not exists artistas
	(numart int not null,
    constraint pk_artistas primary key (numart)
    );
    
create table if not exists salas
	(numsala int not null,
    constraint pk_salas primary key (numsala)
    );
    
create table if not exists estilos
	(numestilo int not null,
    constraint pk_estilos primary key (numestilo)
    );
    
create table if not exists obras
	(numobra int,
    numtipoObra int,
    numart int,
    numsala int,
    numestilo int,
    constraint pk_obras primary key (numobra),
    constraint fk_obra_tipoObra foreign key (numtipoObra)
		references tipoObras (numtipoObra) on delete no action on update cascade,
	constraint fk_obra_art foreign key (numart)
		references artistas (numart) on delete no action on update cascade,
	constraint fk_obra_salas foreign key (numsala)
		references salas (numsala) on delete no action on update cascade,
	constraint fk_obra_estilo foreign key (numestilo)
		references estilos (numestilo) on delete no action on update cascade
    );

create table if not exists empleados
	(numemple int,
    nomemple varchar(60),
    edademple int,
    constraint pk_empleado primary key (numemple)
    );
    
create table if not exists restauradores
	(numrestaurador int,
    numobra int,
    numemple int,
    constraint pk_restauradores primary key (numrestaurador),
    constraint fk_resta_obra foreign key (numobra)
		references obras (numobra) on delete no action on update cascade,
	constraint fk_resta_emple foreign key (numemple)
		references empleados (numemple) on delete no action on update cascade 
    );

create table if not exists seguridad
	(numseguridad int,
    numsala int,
    numemple int,
    constraint pk_seguridad primary key (numseguridad),
    constraint fk_seguridad_sala foreign key (numsala)
		references salas (numsala) on delete no action on update cascade,
	constraint fk_seguridad_emp foreign key (numemple)
		references empleados (numemple) on delete no action on update cascade
    );

create table if not exists restauraciones
	(numrestauraciones int,
    numobra int,
    numrestaurador int,
    fecinirest date,
    fecfinrest date,
    observaciones varchar(120),
    constraint pk_restauraciones primary key (numrestauraciones, numobra, numrestaurador, fecinirest),
    constraint fk_rest_obra_rest foreign key (numrestaurador)
		references restauradores (numrestaurador) on delete no action on update cascade,
	constraint fk_rest_obra_obra foreign key (numobra)
		references obras (numobra) on delete no action on update cascade
    );
    
    
    
    