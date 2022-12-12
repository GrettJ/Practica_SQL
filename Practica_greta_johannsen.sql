create schema flota2

create type color_ as enum('ROJO', 'AZUL', 'PLATA', 'BLANCO', 'NEGRO');
create type currency as enum('EURO', 'YEN', 'LIBRA ESTERLINA', 'DOLAR');

create table flota2.vehiculo(
	matricula varchar(10) primary key,
	modelo integer not null,
	color color_ not null,
	km_totales integer not null,
	dt_compra date not null,
	num_poliza integer not null,
	id_revision integer null
);

create table flota2.seguro(
	num_poliza integer primary key,
	aseguradora varchar(50) not null,
	poliza varchar(200) null
);

create table flota2.modelo(
	id_modelo serial primary key,
	marca varchar(100) not null,
	nombre varchar(100) not null
);

create table flota2.marca(
	nombre varchar(100) primary key,
	grupo varchar(150) null
);

create table flota2.grupo_marcas(
	grupo varchar(150) primary key,
	descripcion varchar(200) null
);

create table flota2.revisiones_vh(
	id_revision serial primary key,
	km_durante_revision integer not null,
	importe numeric(10,2) not null,
	id_moneda integer not null,
	fecha_revision date not null
);

create table flota2.exchange(
	id_moneda serial primary key,
	fecha date not null,
	cambio_a_eu numeric(100,10) not null,
	moneda currency not null default 'EURO'
);

alter table flota2.vehiculo
add constraint modelo_FK foreign key(modelo)
references flota2.modelo(id_modelo);

alter table flota2.vehiculo
add constraint num_poliza_FK foreign key(num_poliza)
references flota2.seguro(num_poliza);

alter table flota2.vehiculo
add constraint id_revision_FK foreign key(id_revision)
references flota2.revisiones_vh(id_revision);

alter table flota2.modelo
add constraint marca_FK foreign key(marca)
references flota2.marca(nombre);

alter table flota2.marca
add constraint grupo_FK foreign key(grupo)
references flota2.grupo_marcas(grupo);

alter table flota2.revisiones_vh
add constraint id_moneda_FK foreign key(id_moneda)
references flota2.exchange(id_moneda);

insert into flota2.seguro(num_poliza, aseguradora, poliza) values(2008444531,'MAPFRE','TERCEROS'),
(2008444532,'MAPFRE','TODO RIESGO'),
(2008444533,'MAPFRE','TODO RIESGO'),
(2008444534,'MAPFRE','TODO RIESGO CON FRANQUICIA'),
(2008444535,'ALIANZ','TERCEROS'),
(2008444536,'ALIANZ','TODO RIESGO'),
(2008444537,'ALIANZ','TODO RIESGO'),
(2008444538,'ALIANZ','TODO RIESGO'),
(2008444539,'AXXA','TODO RIESGO CON FRANQUICIA'),
(2008444540,'AXXA','TODO RIESGO CON FRANQUICIA');


insert into flota2.grupo_marcas(grupo, descripcion) values('FORD','FORD, LINCOLN'),
('STELLANTIS','PEUGEOT, CITROËN, DS Y OPEL/VAUXHALL ,FIAT, ALFA ROMEO, LANCIA, MASERATI, FERRARI, CHRYSLER, JEEP, RAM, DODGE'),
('GRUPO VOLKWAGEN','VOLKSWAGEN, AUDI, SEAT, SKODA, PORSCHE, CUPRA, LAMBORGHINI, BUGATTI Y BENTLEY.'),
('DAIMLER','MERCEDES, SMART'),
('HONDA','HONDA'),
('TOYOTA','TOYOTA, LEXUS, DAIHATSU'),
('GM','CHEVROLET, CADILLAC, BUICK, GMC, WULING MOTORS, BAOJUN Y HOLDEN '),
('BMW','BMW, MINI Y ROLLS-ROYCE'),
('HYUNDAI','HYUNDAI, KIA ');

insert into flota2.marca(nombre) values('MAZDA') ,('NISSAN');
insert into flota2.marca(nombre, grupo) values('FORD','FORD'),
('MERCEDES','DAIMLER'),
('HONDA','HONDA'),
('AUDI','GRUPO VOLKWAGEN'),
('BMW','BMW'),
('VOLKSWAGEN','GRUPO VOLKWAGEN');


insert into flota2.modelo(id_modelo, nombre, marca) values (0003,'X-TRAIL','NISSAN'),
(0004,'MICRA','NISSAN'),
(0005,'FIESTA','FORD'),
(0006,'FOCUS','FORD'),
(0007,'EXPLORER','FORD'),
(0008,'ECOSPORT','FORD'),
(0009,'CX3','MAZDA'),
(0010,'CX5','MAZDA'),
(0011,'3','MAZDA'),
(0012,'6','MAZDA'),
(0013,'CLASE A','MERCEDES'),
(0014,'CLASE B','MERCEDES'),
(0015,'GLC','MERCEDES'),
(0016,'CLA','MERCEDES'),
(0017,'CIVIC','HONDA'),
(0018,'TT','AUDI'),
(0019,'A3','AUDI'),
(0020,'A4','AUDI'),
(0021,'A6','AUDI'),
(0022,'X1','BMW'),
(0023,'X2','BMW'),
(0024,'X3','BMW'),
(0025,'X5','BMW'),
(0026,'GOLF','VOLKSWAGEN'),
(0027,'PASSAT','VOLKSWAGEN'),
(0028,'TIGUAN','VOLKSWAGEN'),
(0029,'T-CROSS','VOLKSWAGEN');

insert into flota2.exchange(fecha, cambio_a_eu, moneda) values('2020-03-02', 1.0,'EURO'),
('2021-04-03' ,1,'EURO'),
('2022-09-01' ,1.01,'DOLAR'),
('2022-08-10' ,0.008,'YEN'),
('2021-09-15' ,0.89,'DOLAR'),
('2022-04-28' ,1,'EURO'),
('2021-11-12' ,1.4,'LIBRA ESTERLINA'),
('2020-10-10' ,0.0069,'YEN'),
('2019-12-17' ,0.0069,'YEN');

insert into flota2.revisiones_vh(fecha_revision, km_durante_revision, importe, id_moneda) values( '2020-12-20' ,50000 , 50 ,1),
('2021-10-17', 56631, 56, 5),
('2019-09-10', 94364, 40, 2),
('2019-10-06', 123698, 66, 8),
('2021-09-10', 70560, 75, 6),
('2020-06-01', 103640, 13000, 2),
('2022-11-11', 54200, 15000, 3),
('2022-10-11', 68400, 70, 1),
('2021-10-09', 45000, 50, 1);

insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra,num_poliza) values('1234ABC',0003,'ROJO',50000, '2020-03-08' ,2008444531);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra,num_poliza) values('2345ABC',0009,'PLATA',56631, '2019-10-08' ,2008444532);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra, id_revision, num_poliza) values('3456ABC',0015,'NEGRO',94364, '2018-05-10', 3 ,2008444533);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra,num_poliza) values('4567ABC',0005,'BLANCO',112354, '2021-05-14' ,2008444534);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra, id_revision, num_poliza) values('5678ABC',0010,'AZUL',21354, '2017-11-10', 05 ,2008444535);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra,num_poliza) values('6789ABC',0020,'ROJO',123698, '2022-11-12' ,2008444536);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra, id_revision, num_poliza) values('7890ABC',0023,'PLATA',70560, '2015-10-15', 7 ,2008444537);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra,num_poliza) values('0123ABC',0018,'NEGRO',103640, '2022-01-05' ,2008444538);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra,num_poliza) values('0234ABC',0013,'BLANCO',54200, '2020-02-20' ,2008444539);
insert into flota2.vehiculo(matricula, modelo, color, km_totales, dt_compra, id_revision, num_poliza) values('0345ABC',0019,'AZUL',68400, '2017-04-02', 1 ,2008444540);

select vh.dt_compra, 
	vh.matricula, vh.color, vh.km_totales, vh.num_poliza, s.aseguradora, md.nombre, mk.nombre, gm.grupo 
from flota2.vehiculo vh, 
	flota2.seguro s,
	flota2.modelo md, 
	flota2.marca mk left outer join flota2.grupo_marcas gm on mk.grupo = gm.grupo
where vh.modelo = md.id_modelo 
	and md.marca = mk.nombre 
	and vh.num_poliza = s.num_poliza;