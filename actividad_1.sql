create database if not exists actividad_1;

use actividad_1;
/*
Empleados (pk[numempleado], extelefon, fecnacim, fecingreso, salario, comision, [numce, numde]*)
Departamento (pk[numdepto, numce*], presupuesto, nomdepto, [deptodepen, centrodepen]*)
Centros (pk[numcentros], nomcentro, dirección)
*/

create table if not exists centros
	(numce int,
    nomcentros varchar (60) not null,
    direccion varchar (120) null,
    constraint pk_centros primary key (numce)
    );

create table if not exists deptos
	(numdepto int,
    numce int, 
    presupuesto decimal (10,2),
    nomdepto varchar (60) not null,
    constraint pk_deptos primary key (numdepto, numce),
    constraint fk_deptos_centros foreign key (numce)
		references centros (numce) 
			on delete no action on update cascade
    );

create table if not exists empleados
	(numempleado int,
	numce int,
    numdepto int,
	extelefon char(3) null,
	fecnacim date null,
	fecingreso date null,
    numhiem tinyint unsigned,
	salario decimal (7,2),
	comision decimal (4, 2),
    nomem varchar (20) not null,
    ape1em varchar (20) not null,
    ape2em varchar (20) null,
	constraint pk_empleados primary key (numempleado),
    constraint fk_empleados_centros_depto foreign key (numce,numdepto)
		references deptos (numce, numdepto)
			on delete no action on update cascade
    );

create table if not exists dirigir
	(numemdir int,
    numdepto int,
    numce int,
    numem int,
    fecinidir date,
    fecfindir date null,
    constraint pk_dirigir primary key (numemdir,numdepto,numce,fecnidir),
    constraint fk_dir_empleados foreign key (numem)
		references empleados (numem) 
			on delete no action on update cascade,
	constraint fk_dir_deptos_centros foreign key (numce, numdepto)
		references deptos (numce, numdepto) 
			on delete no action on update cascade
    );
    
    
    
    