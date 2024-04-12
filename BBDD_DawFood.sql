create database dawfood;

use dawfood;

create table if not exists TPVS
(
    numSerie int not null,
    direccion varchar(120),
    fechaHora date,
    constraint pk_TPVS primary key (numSerie)
);

create table if not exists Categorias
(
	codCat int not null,
    tipoCat enum ('Comidas', 'Bebidas', 'Postres'),
    constraint pk_Categorias primary key(codCat)
);

create table if not exists Tipos_Productos
(
	codSubCat int not null,
    tipoSubCat enum ('Ensaladas', 'Carnes', 'Pescados', 'Refrescos', 'Alcohol',
				'Cafes', 'Postres'),
    codCat int,
    constraint pk_TP primary key (codSubCat),
    constraint fk_TP_Cat foreign key (codCat)
		references Categorias (codCat)
			on delete no action on update cascade
);

create table if not exists Tickets
(
    id int not null,
    turno int,
    fecha date,
    hora time,
    precioTotal decimal (5,2),
    codTPV int,
    constraint pk_Tickets primary key(id),
    constraint fk_Tickets_TPVS foreign key(codTPV)
		references TPVS (numSerie)
			on delete no action on update cascade
);

create table if not exists Productos
(
    id int not null,
    descripcion varchar(60),
    codCat int,
    precio decimal(5,2),
    iva enum ('VENTIUNO', 'DIEZ'),
	stock int,
    constraint pk_Productos primary key(id),
    constraint fk_Prod_Cat foreign key(codCat)
		references Categorias (codCat)
			on delete no action on update cascade
);

create table if not exists Detalles_Tickets
(
	cantidad int,
    codTickets int,
    codProd int,
    constraint pk_dT primary key (codTickets, codProd),
    constraint fk_dt_Tickets foreign key (codTickets)
		references Tickets (id)
			on delete no action on update cascade,
	constraint fk_dt_Prod foreign key (codProd)
		references Productos (id)
			on delete no action on update cascade
);
    