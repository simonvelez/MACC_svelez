CREATE TABLE clientes
(
id_cliente integer,
nombreCliente varchar(20),
numeroDocumento varchar(20),
direccion varchar(20),
PRIMARY KEY (id_cliente));

CREATE TABLE factura
(
"numFactura" varchar(10),
factura_id_cliente_fk integer,
"fechaFactura" date,
CONSTRAINT factura_pk PRIMARY KEY ("numFactura"),
CONSTRAINT factura_id_cliente_fk FOREIGN KEY (factura_id_cliente_fk) REFERENCES clientes (id_cliente) );

create table pagos
(
idPago integer,
pagos_num_factura_fk varchar(10),
fechaPago date,
valorPagado numeric(7,2),
tipoPago varchar(10),
constraint pagos_pk primary key (idPago),
constraint pagos_num_factura_fk foreign key (pagos_num_factura_fk) references factura ("numFactura")
);

create table Detalle
(
id_detalle smallint,
detalle_numfactura_fk varchar(10),
nombre_art varchar(10),
detalleArt varchar(10),
cantArt integer,
valorArt numeric(7,2),
constraint Detalle_pk primary key (id_detalle),
constraint detalle_numfactura_fk foreign key (detalle_numfactura_fk) references factura ("numFactura")
);

-- Insertar datos
insert into clientes (NombreCliente, NumeroDocumento, id_cliente, direccion) 
Values 
('Javier Casas', '25648421', 1, 'calle 34 Nr. 25-36'),
('Martin el pin', '48421256', 2, 'en chiquinquirá'),
('Alejandro', '84212564', 3, 'onde el loko'),
('Patas', '26484215', 4, 'sin dirección');


select * from clientes order by id_cliente;