
create database if not exists compras;
/*drop database compras;*/
use compras; 

/*
Compradores()
*/

create table if not exists compradores
(
	cif_comprador varchar (11),
    nombre_social varchar (30),
    domicilio_social varchar (30) unique,
    localidad varchar (30),
    c_postal varchar (5),
    telefono varchar (9),
    constraint pk_compradores primary key (cif_comprador)
);

create table if not exists articulos
(
	referencia_articulo varchar (12),
    descripcion_articulo varchar (30),
    precio_unidad decimal (6,2),
    IVA int (2) check (IVA between 5 and 25),
    existencia_actuales int (5) default 0,
    constraint pk_articulos primary key (referencia_articulo)
);

create table if not exists facturas
(
	factura_no varchar (6),
    fecha_factura date default '2021-12-1',
    cif_cliente varchar (11),
    constraint pk_facturas primary key (factura_no)
);

create table if not exists lineas_facturas
(
	factura_no varchar (6),
    referencia_articulo varchar (12),
    unidades int (3),
    constraint pk_linas_facturas primary key (factura_no),
    constraint fk_lineas_facturas foreign key (factura_no)
		references facturas (factura_no) on delete no action on update cascade,
	constraint fk_lineas_articulos foreign key (referencia_articulo)
		references articulos (referencia_articulo) on delete no action on update cascade
);

alter table facturas
	add cod_oficina int;
    
alter table facturas
    add constraint fk_facturas_compradores foreign key (cif_cliente)
		references compradores (cif_comprador) on delete no action on update cascade;
    
alter table compradores 
	change c_postal codigo_postal varchar (5);

alter table facturas
	modify cod_oficina int check (cod_oficina between 1 and 1000);
    
