drop database if exists dawPhone;

create database if not exists dawPhone;
use dawPhone;

drop table if exists Entidades;
create table if not exists Entidades 
(
	codEntidad int,
    nomEntidad varchar(60),
    dirEnvio varchar(120),
    dirPostal char(5),
    constraint pk_entidad primary key(codEntidad)
);

drop table if exists Clientes;
create table if not exists Clientes 
(
	codCliente int,
    codEnt int,
    nombre varchar(60),
    ape1cli varchar(60),
    ape2cli varchar(60),
    dni char(9),
    cuentaBancaria int,
    fechaNac date,
    fecAltaPlan date,
    correo varchar(120),
    constraint pk_cliente primary key (codCliente),
    constraint fk_cliente_enti foreign key (codEnt)
		references Entidades (codEntidad)
			on delete no action on update cascade
);

drop table if exists PlanProductos;
create table if not exists PlanProductos 
(
	codPlan int,
    nombrePlan varchar(120),
    importe decimal(5,2),
    constraint pk_planProd primary key (codPlan)
);

drop table if exists Recibos;
create table if not exists Recibos 
(
	codRecibo int auto_increment,
    codCli int,
    pagado boolean null,
    fecRecibo date,
    codEnt int,
    numCuenta char(16),
    importeFinal decimal(5,2),
    constraint pk_recibo primary key (codRecibo),
    constraint fk_recibo_Cli foreign key (codCli)
		references Clientes(codCliente)
			on delete no action on update cascade,
	constraint fk_recibo_Ent foreign key (codEnt)
		references Entidades(codEntidad)
			on delete no action on update cascade
);

drop table if exists DetallePlan;
create table if not exists DetallePlan 
(
	codCli int,
    codPProd int,
    estadoPlan varchar(60),
    fecBajaPlan date,
    fecAltaPlan date,
    constraint pk_detallesPlan primary key (codCli,codPProd),
    constraint fk_dp_cli foreign key(codCli)
		references Clientes(codCliente)
			on delete no action on update cascade,
	constraint fk_dp_pp foreign key(codPProd)
		references PlanProductos(codPlan)
			on delete no action on update cascade
);