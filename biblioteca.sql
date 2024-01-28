create database if not exists biblioteca;

use biblioteca;

create table if not exists libros
(
	codlibro int,
    titulo varchar (60) not null,
    editorial varchar (25) null,
    autor varchar (40) not null,
    genero varchar (20) not null,
    paisautor varchar (20) null,
    numeropaginas int not null check(numeropaginas > 0),
    anoedicion varchar (5) null,
    precio float,
    constraint pk_libros primary key (codlibro)
);

create table if not exists usuarios
(
	codusuario int,
    nombre varchar (15) not null,
    apellido1 varchar (20) not null,
    apellido2 varchar (20) null,
    fechanacimiento date not null,
    dni varchar (12) null,
    domicilio varchar (50) not null,
    poblacion varchar (30) null,
    provincia varchar (20) null,
    constraint pk_usuario primary key (codusuario)
);

create table if not exists prestamos
(
	numeropedido int,
    librocodigo int not null,
    usuariocodigo  int not null,
    fechaprestamo datetime not null,
    fechamaximadevolucion datetime not null,
    fechadevolucion datetime not null,
    constraint pk_prestamos primary key (numeropedido),
		constraint fk_prestamos_libros foreign key (librocodigo)
			references libros (codlibro) on delete no action on update cascade, 
		constraint fk_prestamos_usuarios foreign key (usuariocodigo)
			references usuarios (codusuario) on delete no action on update cascade
);

alter table usuarios
	add column tfno_movil int not null;
    
alter table libros    
	drop column paisautor;
    
drop database if exists biblioteca;
