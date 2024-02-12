create database "Tienda Rosarista"
with
owner = postgres
encoding = "UTF8"
connection limit = -1
is_template = false;

create table clientes
(
	id_cliente integer,
	nombreCliente varchar(40),
	numeroDocumento varchar(20),
	direccion varchar(30),
	telefono varchar(20),
	primary key (id_cliente)
);


create table factura
(
	numFactura varchar (10), 
	factura_id_cliente_fk integer, 
	fechafactura date,
	primary key (numFactura),
	foreign key (factura_id_cliente_fk) references clientes (id_cliente)
);

 create table pagos
 (
 	idPago integer,
	pagos_num_factura_fk varchar(10), 
	fechaPag date, 
	valorPagado numeric (10,2), 
	tipoPago varchar(20),
	primary key (idPago),
	foreign key (pagos_num_factura_fk) references factura (numFactura)
 );
 
 create table detalle
(
	id_Detalle integer, 
	detalle_numfactura_fk varchar(10), 
	nombreArt varchar(30), 
	colorArt varchar(30), 
	tallaArt varchar(3), 
	cantArt integer, 
	valor_uniArt numeric(10,2),
	primary key (id_Detalle),
	foreign key (detalle_numfactura_fk) references factura (numFactura)
);

insert into 
clientes( id_cliente, nombreCliente, numeroDocumento, direccion, telefono)
values
(1,'Javier Casas Salgado', '81487145','calle 3 #20-40','6015489763'),
(2, 'Luis Martinez Daza', '22623061','calle 4 #10-20','31820239026'),
(3,'Nubia Castiblanco Rodriguez','41380740', 'carrera 74 #2-33', '6014248612'),
(4, 'Maria Fernanda Gonzalez Pinto', '1012852324', 'transversal 80 #52-14', '3002605520'),
(5, 'Rodrigo Gomez Vargas', '79890532', 'calle 22c #26-82 sur', '3118524357'),
(6, 'Luckas lemons', '79420489','calle 3 #45-10','3112254896'),
(7, 'Jose Maria Lopez Herrera', '17189250','Calle 53 sur #36A-78','3187095432'),
(8,'JCS Instruments evaluation','900814922','carrera 7 # 62-40','6014770087'),
(9, 'Ins Trujillo Corporation','8605960478', 'Calle 127 # 15-32', '6016778005'),
(10,'Valenria Pulido Rincon', '52301980','carrera 121 #141-23','3167851235');
 
insert into factura (numFactura, factura_id_cliente_fk, fechafactura)
values
 ('FACT-01',1,'2023-06-03'),
 ('FACT-02', 2,'2023-06-03'),
 ('FACT-03',2,'2023-06-04'),
 ('FACT-04',9,'2023-06-08'),
 ('FACT-05',7,'2023-06-08'),
 ('FACT-06',4,'2023-06-10'),
 ('FACT-07',6,'2023-06-12'),
 ('FACT-08',3,'2023-06-15'),
 ('FACT-09',8,'2023-06-18'),
 ('FACT-10',5,'2023-06-23'),
 ('FACT-11',10,'2023-06-25'),
 ('FACT-12',10,'2023-06-25'),
 ('FACT-13',4,'2023-06-26'),
 ('FACT-14',7,'2023-06-26'),
 ('FACT-15',1,'2023-06-26'),
 ('FACT-16',6,'2023-06-30'),
 ('FACT-17',3,'2023-06-30'),
 ('FACT-18',8,'2023-06-30');
 

--alter table pagos alter column valorPagado type numeric (10,2);

 insert into
 pagos (idPago, pagos_num_factura_fk, fechaPag, valorPagado, tipoPago)
 values
 (1, 'FACT-01','2023-06-03',100000.00,'efectivo'),
 (2, 'FACT-02','2023-06-03',1800000.00,'efectivo'),
 (3,'FACT-03','2023-06-04', 93000.00,'efectivo'),
 (4, 'FACT-04','2023-06-08',250500.00,'Nequi'),
 (5,'FACT-05','2023-06-08', 1580000.00,'transferencia'),
 (6, 'FACT-06','2023-06-10', 50000.00,'efectivo'),
 (7,'FACT-07','2023-06-12',5800540.00,'Daviplata'),
 (8,'FACT-08','2023-07-15',1914600.00,'crédito'),
 (9,'FACT-09','2023-07-18',13774280.00,'crédito'),
 (10,'FACT-10','2023-06-23',778980.00,'Daviplata'),
 (11,'FACT-11','2023-06-25',150700.00,'efectivo'),
 (12,'FACT-12','2023-06-25',1875030.00,'Nequi'),
 (13,'FACT-13','2023-06-26',255720.00,'efectivo'),
 (14,'FACT-14','2023-06-26',1107800.00,'efectivo'),
 (15,'FACT-15','2023-06-26',820920.00,'Daviplata'),
 (16, 'FACT-16','2023-06-30',175000.00,'efectivo'),
 (17,'FACT-17','2023-06-30',755520.00,'Nequi'),
 (18,'FACT-18','2023-06-30',1806750.00,'transferencia');
 


insert into
detalle (id_Detalle, detalle_numfactura_fk, nombreArt, colorArt, tallaArt, cantArt, valor_uniArt)
values
(1,'FACT-01','camisa','blanco','M',2,50000),
(2,'FACT-02','camisa','azul','S',2,50000),
(3,'FACT-02','jeans','azul','30',2,70000),
(4,'FACT-02','camisa','azul','M',3,50000),
(5,'FACT-02','jeans','azul','32',3,70000),
(6,'FACT-02','camisa','azul','L',2,50000),
(7, 'FACT-02','jeans','34','M',2,70000),
(8,'FACT-02','botas','negra','38',2,137142),
(9,'FACT-02','botas','negra','39',3,137142),
(10,'FACT-02','botas','negra','40',2,137142),
(11,'FACT-03','guante industrial','amarillo','L',3,10115),
(12,'FACT-03','guante poliuretano','blanco','L',3,15040),
(13,'FACT-03','tapabocas N95','blanco','U',5,3500),
(14, 'FACT-04','overol 5 bolsillos','negro','L',2,110780),
(15,'FACT-04','mascara de silicona','verde','U',1,28940),
(16,'FACT-05','casco de seguridad','amarillo', 'U',4,38710),
(17,'FACT-05','mascara de carbono','negro','U',4,52780),
(18,'FACT-05','arnes 4 argollas','naranja','U',4,148500),
(19,'FACT-05','arnes 4 argollas reata','ocre','U',4,155010),
(20,'FACT-06','camisa','blanco','M',1,50000),
(21,'FACT-07','camisa','azul','L',5,50000),
(22,'FACT-07','camisa','azul','M',5,50000),
(23,'FACT-07','botas','negro','39',5,137142),
(24, 'FACT-07','botas','negro','40',5,137142),
(25,'FACT-07','jeans','azul','32',5,70000),
(26, 'FACT-07','jeans','azul','34',3,70000),
(27,'FACT-07','jeans','azul','30',2,70000),
(28, 'FACT-07','medias','azul','U',10,10000),
(29,'FACT-07','overol 5 bolsillos','negro','L',10,110780),
(30,'FACT-07','overol 5 bolsillos','negro','M',5,110780 ),
(31,'FACT-07','delantal tela amarillo','amarillo','U',10,8900),
(32,'FACT-07','guante industrial','amarillo','U',10,10115),
(33,'FACT-07','casco de seguridad','amarillo','U',10,38710),
(34,'FACT-07','tapabocas N95','blanco','U',20,3500),
(35,'FACT-07','chaleco reflectivo','verde','U',10,22000),
(36,'FACT-07','protector auditivo','azul','U',20,15000),
(37,'FACT-07','gafas industrial','blanco','U',20,15000),
(38,'FACT-08','guante poliuretano','blanco','U',25,15040),
(39,'FACT-08','mascara de carbono','negro','U',15,52780),
(40,'FACT-08','mascara de silicona','verde','U',15,28960),
(41,'FACT-08','tapabocas N95','blanco','U',25,3500),
(42,'FACT-08','protector auditivo','azul','U',15,15000),
(43,'FACT-09','camisa','blanco','M',10,50000),
(44,'FACT-09','camisa','azul','L',5,50000),
(45,'FACT-09','botas','negro','39',10,137142),
(46,'FACT-09','botas','negro','40',3,137142),
(47,'FACT-09','botas','negro','38',2,137142),
(48,'FACT-09','jeans','azul','32',10,70000),
(49,'FACT-09','jeans','azul','34',3,70000),
(50,'FACT-09','jeans','azul','30',2,70000),
(51,'FACT-09','overol 5 bolsillos','negro','L',10,110780),
(52,'FACT-09','overol 5 bolsillos','negro','M',10,110780),
(53,'FACT-09','overol antifluidos','blanco','U',20,68750),
(54,'FACT-09','delantal industrial','cafe','U',20,15070),
(55,'FACT-09','guante industrial','amarillo','L',20,10115),
(56,'FACT-09','guante poliuretano','blanco','L',20,15040),
(57,'FACT-09','casco de seguridad','amarillo','U',20,38710),
(58,'FACT-09','mascara de carbono','negro','U',20,52780),
(59,'FACT-09','mascara de silicona','verde','U',20,28960),
(60, 'FACT-09','chaleco reflectivo','verde','U',10,22000),
(61, 'FACT-09','chaleco naranja','naranja','U',10,33000),
(62, 'FACT-09','protectior auditivo','azul','U',20,15000),
(63, 'FACT-09','arnes 4 argollas','naranja','U',8,148500),
(64, 'FACT-09','arnes 4 argollas reata','ocre','U',5,155010),
(65, 'FACT-09','gafas industrial','blanco','U',20,15000),
(66,'FACT-10','overol antifluidos','blanco','U',1,68750),
(67,'FACT-10','guante industrial','amarillo','L',2,10115),
(68,'FACT-10','chaleco reflectivo','verde','U',12,22000),
(69,'FACT-10','chaleco naranja','naranja','U',12,33000),
(70,'FACT-10','protectior auditivo','azul','U',2,15000),
(71,'FACT-11','delantal industrial','cafe','U',10,15070),
(72,'FACT-12','camisa','blanco','M',3,50000),
(73,'FACT-12','camisa','azul','L',3,50000),
(74,'FACT-12','botas','negro','39',2,137142),
(75,'FACT-12','botas','negro','40',2,137142),
(76,'FACT-12','botas','negro','38',2,137142),
(77,'FACT-12','jeans','azul','32',2,70000),
(78,'FACT-12','jeans','azul','34',2,70000),
(79,'FACT-12','jeans','azul','30',2,70000),
(80,'FACT-12','overol 5 bolsillos','negro','L',1,110780),
(81,'FACT-12','overol 5 bolsillos','negro','M',2,110780),
(82,'FACT-13','mascara de carbono','negro','U',3,52780),
(83,'FACT-13','mascara de silicona','verde','U',3,28960), 
(84,'FACT-13','tapabocas N95','blanco','U',3,3500),
(85,'FACT-14','overol 5 bolsillos','negro','L',6,110780),
(86,'FACT-14','overol 5 bolsillos','negro','M',4,110780),
(87,'FACT-15','jeans','azul','32',3,70000),
(88,'FACT-15','overol antifluidos','blanco','U',3,68750),
(89,'FACT-15','delantal industrial','cafe','U',3,15070), 
(90,'FACT-15','guante poliuretano','blanco','L',3,150400),
(91,'FACT-15','mascara de carbono','negro','U',3,52780),
(92,'FACT-15','chaleco reflectivo','verde','U',3,22000),
(93,'FACT-15','protectior auditivo','azul','U',3,15000),
(94,'FACT-15','gafas industrial','blanco','U',3,15000),
(95,'FACT-16','tapabocas N95','blanco','U',50,3500),
(96,'FACT-17','arnes 4 argollas','naranja','U',3,148500),
(97,'FACT-17','arnes 4 argollas reata','ocre','U',2,155010),
(98,'FACT-18','casco de seguridad','amarillo','U',15,38710),
(99,'FACT-18','mascara de carbono','negro','U',15,52780),
(100,'FACT-18','mascara de silicona','verde','U',15,28960);


-- Ejercicios

select * from pagos;

select nombrecliente, direccion 
from clientes 
where nombrecliente = 'Luis Martinez Daza' or nombrecliente = 'Luckas lemons';

update clientes
set direccion = 'calle 3 #45-10'
where nombrecliente = 'Luckas lemons';

update clientes
set direccion = (select direccion 
	from clientes 
	where nombrecliente = 'Luis Martinez Daza')
where nombrecliente = 'Luckas lemons';

select  distinct direccion from clientes; -- Selecciona los registros no-repetidos
select  distinct * from clientes;


select nombreart, cantart, valor_uniart, cantart * valor_uniart as acumulado 
from detalle
where cantart * valor_uniart > 15000 ;

select * from detalle where nombreart = 'jeans';

select nombreart, valor_uniart, valor_uniart * 1.08 as aumentado -- Muestra el valor aumentado en un 8%
from detalle;


