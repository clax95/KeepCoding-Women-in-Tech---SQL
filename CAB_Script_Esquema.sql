---Crear un esquema de trabajo
create schema practica_CAB authorization hzxmxmdt;

---Crear las tablas

---Tabla de grupos de marcas de coche
create table practica_CAB.parent_groups(
	id_group varchar(5) not null,  --PK
	name varchar(20) not null  --obligatorio
);

alter table practica_CAB.parent_groups
add constraint groups_PK primary key (id_group);

---Tabla de marcas de coche
create table practica_CAB.brands(
	id_brand varchar(5) not null,  --PK
	name varchar(20) not null,  --obligatorio
	id_group varchar(5) not null  --FK --> parent_groups
);

alter table practica_CAB.brands
add constraint brands_PK primary key (id_brand);

alter table practica_CAB.brands
add constraint brands_groups_FK foreign key (id_group)
references practica_CAB.parent_groups (id_group);

---Tabla de modelos de coche
create table practica_CAB.models(
	id_model varchar(5) not null,  --PK
	name varchar(20) not null,  --obligatorio
	id_brand varchar(5) not null  --FK --> brands
);

alter table practica_CAB.models
add constraint models_PK primary key (id_model);

alter table practica_CAB.models
add constraint models_brands_FK foreign key (id_brand)
references practica_CAB.brands (id_brand);

---Tabla de colores
create table practica_CAB.colours(
	id_colour varchar(5) not null,  --PK
	name varchar(20) not null  --obligatorio
);

alter table practica_CAB.colours
add constraint colours_PK primary key (id_colour);

---Tabla de coches
create table practica_CAB.cars(
	id_car varchar(10) not null,  --PK
	id_model varchar(5) not null,  --FK --> models
	id_colour varchar(5) not null,  --FK --> colours
	number_plate varchar(10) not null,  --obligatorio
	kms_total integer not null,  --obligatorio
	date_acquisition date not null,  --obligatorio
	description varchar(500) null  --no obligatorio
);

alter table practica_CAB.cars
add constraint cars_PK primary key (id_car);

alter table practica_CAB.cars
add constraint cars_models_FK foreign key (id_model)
references practica_CAB.models (id_model);

alter table practica_CAB.cars
add constraint cars_colours_FK foreign key (id_colour)
references practica_CAB.colours (id_colour);

---Tabla de monedas
create table practica_CAB.currencies(
	id_currency varchar(5) not null,  --PK
	name varchar(20) not null  --obligatorio
);

alter table practica_CAB.currencies
add constraint currencies_PK primary key (id_currency);

---Tabla de histórico de inspecciones
create table practica_CAB.inspections(
	id_car varchar(10) not null,  --PK, FK --> cars
	date_inspection date not null,  --PK
	kms_inspection integer not null,  --obligatorio
	cost_inspection decimal(10,2) not null,  --obligatorio
	id_currency varchar(5) not null,  --FK --> currencies
	description varchar(500) null  --no obligatorio
);

alter table practica_CAB.inspections
add constraint inspections_PK primary key (id_car, date_inspection);

alter table practica_CAB.inspections
add constraint inspections_cars_FK foreign key (id_car)
references practica_CAB.cars (id_car);

alter table practica_CAB.inspections
add constraint inspections_currencies_FK foreign key (id_currency)
references practica_CAB.currencies (id_currency);

---Tabla de compañías aseguradoras
create table practica_CAB.companies(
	id_company varchar(5) not null,  --PK
	name varchar(20) not null  --obligatorio
);

alter table practica_CAB.companies
add constraint companies_PK primary key (id_company);

---Tabla de histórico de seguros
create table practica_CAB.insurances(
	id_car varchar(10) not null,  --PK, FK --> cars
	date_register date not null,  --PK
	date_deregister date not null default '4000-01-01',  --obligatorio
	id_company varchar(5) not null,  --FK --> companies
	number_policy varchar(10) not null,  --obligatorio
	description varchar(500) null  --no obligatorio
);

alter table practica_CAB.insurances
add constraint insurances_PK primary key (id_car, date_register);

alter table practica_CAB.insurances
add constraint insurances_cars_FK foreign key (id_car)
references practica_CAB.cars (id_car);

alter table practica_CAB.insurances
add constraint insurances_companies_FK foreign key (id_company)
references practica_CAB.companies (id_company);


---Cargar los datos

---Tabla de grupos de marcas de coche
insert into practica_CAB.parent_groups
values('VOLK', 'Grupo Volkswagen');

insert into practica_CAB.parent_groups
values('PSA', 'Grupo PSA');

insert into practica_CAB.parent_groups
values('FORD', 'Grupo Ford');

insert into practica_CAB.parent_groups
values('HYUN', 'Grupo Hyundai');

insert into practica_CAB.parent_groups
values('TYTA', 'Grupo Toyota');

insert into practica_CAB.parent_groups
values('RNLT', 'Grupo Renault');

---Tabla de marcas de coche
insert into practica_CAB.brands
values('SEAT', 'Seat', 'VOLK');

insert into practica_CAB.brands
values('VW', 'Volkswagen', 'VOLK');

insert into practica_CAB.brands
values('SKO', 'Skoda', 'VOLK');

insert into practica_CAB.brands
values('OPEL', 'Opel', 'PSA');

insert into practica_CAB.brands
values('PGOT', 'Peugeot', 'PSA');

insert into practica_CAB.brands
values('FORD', 'Ford', 'FORD');

insert into practica_CAB.brands
values('KIA', 'Kia', 'HYUN');

insert into practica_CAB.brands
values('HYUN', 'Hyundai', 'HYUN');

insert into practica_CAB.brands
values('TYTA', 'Toyota', 'TYTA');

insert into practica_CAB.brands
values('RNLT', 'Renault', 'RNLT');

insert into practica_CAB.brands
values('DAC', 'Dacia', 'RNLT');

---Tabla de marcas de coche
insert into practica_CAB.models
values('IBI', 'Ibiza', 'SEAT');

insert into practica_CAB.models
values('LEON', 'León', 'SEAT');

insert into practica_CAB.models
values('POLO', 'Polo', 'VW');

insert into practica_CAB.models
values('GOLF', 'Golf', 'VW');

insert into practica_CAB.models
values('PASS', 'Passat', 'VW');

insert into practica_CAB.models
values('FAB', 'Fabia', 'SKO');

insert into practica_CAB.models
values('OCT', 'Octavia', 'SKO');

insert into practica_CAB.models
values('SCL', 'Scala', 'SKO');

insert into practica_CAB.models
values('COR', 'Corsa', 'OPEL');

insert into practica_CAB.models
values('AST', 'Astra', 'OPEL');

insert into practica_CAB.models
values('208', '208', 'PGOT');

insert into practica_CAB.models
values('308', '308', 'PGOT');

insert into practica_CAB.models
values('FIES', 'Fiesta', 'FORD');

insert into practica_CAB.models
values('FOCS', 'Focus', 'FORD');

insert into practica_CAB.models
values('PIC', 'Picanto', 'KIA');

insert into practica_CAB.models
values('RIO', 'Rio', 'KIA');

insert into practica_CAB.models
values('CEED', 'Ceed', 'KIA');

insert into practica_CAB.models
values('I20', 'i20', 'HYUN');

insert into practica_CAB.models
values('I30', 'i30', 'HYUN');

insert into practica_CAB.models
values('YAR', 'Yaris', 'TYTA');

insert into practica_CAB.models
values('CLIO', 'Clio', 'RNLT');

insert into practica_CAB.models
values('MEG', 'Megane', 'RNLT');

insert into practica_CAB.models
values('SAND', 'Sandero', 'DAC');

---Tabla de colores
insert into practica_CAB.colours
values('BLK', 'Negro');

insert into practica_CAB.colours
values('WHT', 'Blanco');

insert into practica_CAB.colours
values('GRY', 'Gris');

insert into practica_CAB.colours
values('RED', 'Rojo');

insert into practica_CAB.colours
values('BLU', 'Azul');

insert into practica_CAB.colours
values('GRN', 'Verde');

insert into practica_CAB.colours
values('YEW', 'Amarillo');

insert into practica_CAB.colours
values('ORG', 'Naranja');

insert into practica_CAB.colours
values('BRW', 'Marrón');

insert into practica_CAB.colours
values('PNK', 'Rosa');

---Tabla de compañías aseguradoras
insert into practica_CAB.companies
values('MAP', 'Mapfre');

insert into practica_CAB.companies
values('AXA', 'AXA');

insert into practica_CAB.companies
values('LIB', 'Liberty');

insert into practica_CAB.companies
values('MMT', 'MMT');

insert into practica_CAB.companies
values('GEN', 'Generali');

---Tabla de monedas
insert into practica_CAB.currencies
values('EUR', 'Euro');

insert into practica_CAB.currencies
values('USD', 'Dólar');

insert into practica_CAB.currencies
values('GBP', 'Libra');

---Tabla de coches
insert into practica_CAB.cars
values('00001', 'IBI', 'GRY', '2548GDT', 201285, '2008-04-01', ' ');

insert into practica_CAB.cars
values('00002', 'SAND', 'WHT', '6829DTT', 352208, '2005-11-01', ' ');

insert into practica_CAB.cars
values('00003', 'CLIO', 'RED', '3175MBB', 2005, '2022-09-01', ' ');

insert into practica_CAB.cars
values('00004', 'RIO', 'GRY', '1125LJV', 30258, '2020-09-01', ' ');

insert into practica_CAB.cars
values('00005', '208', 'GRN', '4458BPT', 112056, '2001-11-01', ' ');

insert into practica_CAB.cars
values('00006', 'OCT', 'BLU', '8966LMD', 50005, '2021-01-01', ' ');

insert into practica_CAB.cars
values('00007', 'FAB', 'BLU', '1278DGT', 253369, '2005-02-01', ' ');

insert into practica_CAB.cars
values('00008', 'FAB', 'BRW', '6897LMN', 22003, '2021-02-01', ' ');

insert into practica_CAB.cars
values('00009', 'POLO', 'RED', '4685FFT', 455057, '2006-09-01', ' ');

insert into practica_CAB.cars
values('00010', 'FAB', 'GRN', '2158FNY', 335088, '2007-04-01', ' ');

insert into practica_CAB.cars
values('00011', 'COR', 'WHT', '6982HWC', 300524, '2014-03-01', ' ');

insert into practica_CAB.cars
values('00012', '208', 'BLU', '8451GYV', 669806, '2010-09-01', ' ');

insert into practica_CAB.cars
values('00013', 'COR', 'GRN', '9654JBX', 39880, '2014-12-01', ' ');

insert into practica_CAB.cars
values('00014', 'FIES', 'YEW', '3256FVY', 885015, '2007-09-01', ' ');

insert into practica_CAB.cars
values('00015', '208', 'RED', '9996LDT', 30514, '2020-01-01', ' ');

insert into practica_CAB.cars
values('00016', 'IBI', 'BLK', '2655CDT', 751080, '2003-01-01', ' ');

insert into practica_CAB.cars
values('00017', 'GOLF', 'WHT', '0848HBN', 63668, '2011-01-01', ' ');

insert into practica_CAB.cars
values('00018', 'POLO', 'WHT', '3096LXT', 5000, '2022-01-01', ' ');

insert into practica_CAB.cars
values('00019', '308', 'GRY', '9630JSF', 18862, '2016-08-01', ' ');

insert into practica_CAB.cars
values('00020', 'CLIO', 'GRY', '0005GGG', 443081, '2008-07-01', ' ');

---Tabla histórico de inspecciones
insert into practica_CAB.inspections
values('00001', '2021-04-01', '18000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00002', '2019-06-01', '30000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00003', '2022-12-01', '2000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00004', '2022-09-01', '25000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00005', '2010-03-01', '50000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00005', '2020-03-01', '100000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00006', '2022-05-01', '50000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00007', '2010-05-01', '100000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00007', '2015-05-01', '200000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00007', '2022-05-01', '250000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00008', '2022-09-01', '20000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00009', '2011-08-01', '100000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00009', '2016-08-01', '200000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00009', '2021-08-01', '350000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00010', '2015-05-01', '200000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00011', '2018-09-01', '280000', '50', 'GBP', ' ');

insert into practica_CAB.inspections
values('00012', '2020-08-01', '600000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00013', '2018-07-01', '20000', '50', 'GBP', ' ');

insert into practica_CAB.inspections
values('00014', '2014-07-01', '400000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00014', '2022-07-01', '800000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00015', '2021-02-01', '25000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00016', '2010-02-01', '400000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00016', '2020-02-01', '700000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00017', '2018-09-01', '50000', '50', 'USD', ' ');

insert into practica_CAB.inspections
values('00018', '2022-12-01', '5000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00019', '2022-08-01', '15000', '50', 'EUR', ' ');

insert into practica_CAB.inspections
values('00020', '2015-05-01', '25000', '50', 'EUR', ' ');


---Tabla de histórico de seguros
insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00001', '2008-04-01', 'MAP', '22055');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00002', '2005-11-01', 'MAP', '80558');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00003', '2022-09-01', 'GEN', '15066');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00004', '2020-09-01', 'MAP', '808');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00005', '2001-11-01', 'LIB', '6088');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00006', '2021-01-01', 'LIB', '6080');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00007', '2005-02-01', 'LIB', '4818');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00008', '2021-02-01', 'MMT', '48408');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00009', '2006-09-01', 'GEN', '84949');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00010', '2007-04-01', 'MMT', '15048');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00011', '2014-03-01', 'GEN', '15168');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00012', '2010-09-01', 'AXA', '13548');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00013', '2014-12-01', 'AXA', '35186');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00014', '2007-09-01', 'AXA', '4680');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00015', '2020-01-01', 'AXA', '5108');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00016', '2003-01-01', 'GEN', '11888');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00017', '2011-01-01', 'MAP', '350');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00018', '2022-01-01', 'MAP', '408');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00019', '2016-08-01', 'GEN', '77');

insert into practica_CAB.insurances
(id_car, date_register, id_company, number_policy)
values('00020', '2008-07-01', 'LIB', '24');





