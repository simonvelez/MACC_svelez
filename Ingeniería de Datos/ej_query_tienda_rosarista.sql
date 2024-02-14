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
