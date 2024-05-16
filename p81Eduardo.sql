create database p81Eduardo;

use p81Eduardo;

create table if not exists Donantes 
(
	id_paciente int,
	nombre varchar(60),
    fechaNacimiento date,
    grupoSanguineo varchar(2),
    rh varchar(1),
    numeroDonaciones int,
    constraint pk_donantes primary key (id_paciente)
);