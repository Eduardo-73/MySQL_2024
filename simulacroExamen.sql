create database if not exists promociones;

use promociones;

/*
Promociones (PK[numpromo], despromo, fecpromo,numeven*, numtiend*, numart*)
Eventos (PK[numeven], deseven, fecinieven, fecfineven)
Tiendas (PK[numtiend], nomtiend)
Franquicias (PK[numfranq], desfranq, numteind*)
Propias (PK[numprop], desprop, numteind*)
Articulos (PK[numart], desart, precio, numcate*)
Categorias (PK[numcate], descate, nomcate)
Catalogo_Promos (PK[numcatepromo], precioarticulopromo, [numpromo*, numart*])
Aplican (PK[numapicar], desaplicar, [numteind*, numpromo*])
*/

create table if not exists categorias
	(numcateg int,
    descateg varchar (120),
    nomcateg varchar (60),
    constraint pk_categorias primary key (numcateg)
    );

create table if not exists eventos 
	(numevent int,
    desevent varchar(120),
    fecinievent date,
    fecfinevent date,
    constraint pk_event primary key (numevent)
    );
    
create table if not exists tiendas 
	(numtiend int,
    nomteind varchar(60),
    constraint pk_tienda primary key (numtiend)
	);

create table if not exists articulos 
	(numart int,
    desart varchar(120),
    precio decimal (5,2),
    numcateg int,
    constraint pk_articulos primary key (numart),
	constraint fk_art_categoria foreign key (numcateg)
		references categorias (numcateg) on delete no action on update cascade
    );
    
create table if not exists promociones 
	(numpromo int,
    despromo varchar(120),
    fecpromo date,
    numevent int,
    numtiend int,
    numart int,
    constraint pk_promo primary key (numpromo),
    constraint fk_promo_event foreign key (numevent)
		references eventos (numevent) on delete no action on update cascade,
	constraint fk_promo_tiend foreign key (numtiend)
		references tiendas (numtiend) on delete no action on update cascade,
	constraint fk_promo_art foreign key (numart)
		references articulos (numart) on delete no action on update cascade
	);

create table if not exists franquicias 
	(numfranq int,
    desfranq varchar(120),
    numtiend int,
    constraint pk_franquicias primary key (numfranq),
    constraint fk_franq_tienda foreign key (numtiend)
		references tiendas (numtiend) on delete no action on update cascade
	);
    
create table if not exists propias 
	(numprop int,
    desprop varchar(120),
    numtiend int,
    constraint pk_propias primary key (numprop),
    constraint fk_prop_tienda foreign key (numtiend)
		references tiendas (numtiend) on delete no action on update cascade
	);
    
create table if not exists catego_promos
    (numcatepromo int,
    precioarticulopromo decimal (5,2),
    numpromo int,
    numart int,
    constraint pk_catego_promos primary key (numcatepromo, numpromo, numart),
    constraint fk_catego_promo foreign key (numpromo)
		references promociones (numpromo) on delete no action on update cascade,
	constraint fk_catego_art foreign key (numart)
		references articulos (numart) on delete no action on update cascade
    );

create table if not exists aplican
    (numaplicar int,
    desaplicar varchar (120),
    numtiend int,
    numpromo int,
    constraint pk_aplican primary key (numaplicar, numtiend, numpromo),
    constraint fk_apli_promo foreign key (numpromo)
		references promociones (numpromo) on delete no action on update cascade,
	constraint fk_apli_tiend foreign key (numtiend)
		references tiendas (numtiend) on delete no action on update cascade
    );

    