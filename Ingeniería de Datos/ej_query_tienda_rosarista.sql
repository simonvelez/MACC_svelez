--14/02/23

--listado con un nombre del cliente y artículos relacionados con la fact #10

select numfactura, nombrecliente, nombreart 
from factura, clientes, detalle
where id_cliente = factura_id_cliente_fk and numfactura = detalle_numfactutra_fk and numfactura = 'FACT-10'; -- No corrigieron la base de datos

-- selecc el valor pagado y tipo de pago por el cliente Javier Casas Salgado

select valorpagado, tipopago
from clientes, factura, pagos
where id_cliente = factura_id_cliente_fk and numfactura = pagos_num_factura_fk and nombrecliente = 'Javier Casas Salgado';

-- selecc números de factura donde el cliente es Javier Casas Salgado

select nombrecliente, numfactura
from clientes, factura
where id_cliente = factura_id_cliente_fk and nombrecliente = 'Javier Casas Salgado';

-- Cambiar el nombre de 'factura_id_cliente_fk' por 'id_cliente' para poder hacer un natural join

alter table factura rename factura_id_cliente_fk to id_cliente;

select numfactura, nombrecliente
from factura natural join clientes
where factura.id_cliente = clientes.id_cliente;

-- Visualizar el número de factura, el nombre de cliente, la fecha de pago, el valor pagado y el tipo de pago usando natural join

select numfactura, nombrecliente, fechapag, valorpagado, tipopago
from factura natural join clientes natural join pagos
where numfactura =  pagos_num_factura_fk; -- no hay que comparar id_cliente porque se llaman igual


-- 16/02/24
-- Renombrando bainas largas

select C.nombrecliente, F.numfactura
from clientes as C, factura as F
where C. id_cliente = F.factura_id_cliente_fk;

-- Nombres que tengan go en alguna parte

select nombrecliente
from clientes
where nombrecliente like '%go%';

-- el / hace que salga el %
insert into clientes
values(11, 'Jav%as Pachon Hernandez', '123', 'en mi casita');

select nombrecliente
from clientes
where nombrecliente like 'Jav\%as%';

-- ando, ordenando, con un flow violento

select *
from clientes
order by nombrecliente asc;

-- Visualizar todos los atributos de tabla factura ordenados por id_cliente de manera descendente y la fecha de forma ascendente

select * from factura
order by factura_id_cliente_fk desc, fechafactura asc;

-- Operaciones entre conjuntos

(select distinct nombreart, colorart from detalle
where nombreart = 'camisa')
union
(select nombreart, colorart from detalle
where nombreart = 'jeans');

(select distinct nombreart, colorart from detalle
where nombreart = 'camisa')
except
(select nombreart, colorart from detalle
where colorart = 'blanco');

/* 
Funciones de agregación
(promedio: avg, mínimo: min, máximo: max, suma: sum, contador: count)
*/

select avg(valorpagado), id from pagos;

select sum(valorpagado) as total from pagos;

select count (distinct nombreart) from detalle;


-- Agregación con agrupamiento

select idpago, pagos_num_factura_fk, avg(valorpagado)
from pagos
group by idpago;

select idpago, pagos_num_factura_fk, avg(valorpagado) from pagos
group by idpago
having avg(valorpagado) > 500001