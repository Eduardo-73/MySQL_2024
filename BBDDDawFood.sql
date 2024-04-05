create database if not exists dawfood;

use dawfood;

-- drop table if exists TPVS; 
create table if not exists TPVS
	(
	);

-- drop table if exists Tickets
create table if not exists Tickets
	(
	id int,
    turno int,
    fecha date,
    hora datetime,
    precioTotal decimal(5,2),
    constraint pk_Tickets primary key (id)
    );
    
-- drop table if exists Productos
create table if not exists Productos
	(
    id int,
    descripcion varchar(120),
    codcat int,
    codsubcat int,
    precio decimal(5,2),
    codiva int,
    stock int,
    constraint pk_Productos primary key (id),
    
    );
    
-- drop table if exists Categorias
create table if not exists Categorias
	(
    );
    
-- drop table if exists Tip_Prod
create table if not exists Tip_Prod
	(
    );
    
