drop database if exists actividad_3;

create database if not exists actividad_3;

use actividad_3;

/*
Categorias (Pk[numcat], nomcategor, proveedor)
Productos (Pk[refprod, codcat*], descrips, precio, fecingreso, salario, comision, numhijos,
nomemp)
Ventas (Pk[codventas], fecventas, cliente)
Lin_Ventas (Pk[numlin_venta, cantidad, numprod*, numcat*])
*/

create table if not exists categorias
(
		numcat int,
        nomcategor varchar (120),
        proveedor varchar (60),
        constraint pk_categorias primary key (numcat)
);

create table if not exists productos
(
		refprod int,
        descripc varchar (120),
        precio decimal (5,2),
        numcat int,
        fecingreso date,
        salario decimal (7,2),
        comision decimal (5,2),
        numhijos int,
        nomemp varchar (60),
        constraint pk_productos primary key (refprod, numcat),
        constraint fk_prod_catego foreign key (numcat)
			references categorias (numcat) on delete no action on update cascade
);

create table if not exists ventas
(
		codventa int,
        fecventas date,
        cliente varchar (60),
        constraint pk_ventas primary key (codventa)
);

create table if not exists lin_ventas 
(
	numlin_venta int,
    cantidad int,
    refprod int,
    numcat int,
    constraint pk_lin_ventas primary key (numlin_venta, cantidad, refprod, numcat),
    constraint fk_lin_ventas_prod_catego foreign key (refprod, numcat)
			references productos (refprod, numcat) on delete no action on update cascade
);

alter table productos
	drop foreign key fk_prod_catego,
    add constraint fk_prodcatego foreign key (numcat)
		references categorias (numcat) on delete cascade on update cascade;
    
    