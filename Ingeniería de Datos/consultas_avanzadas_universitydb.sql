-- 20/03/24
-- función rank()

select id, name, dept_name, tot_cred, rank() over (order by tot_cred desc) as posicion from student;

select id, name, dept_name, tot_cred, rank() over (order by tot_cred asc) as posicion from student where dept_name = 'Accounting';

select id, name, dept_name, tot_cred, percent_rank() over (partition by dept_name order by tot_cred desc) as posicion
from student order by dept_name asc, posicion asc limit 20;

create table ventas(
	producto_id serial primary key,
	producto_nombre text,
	fecha_venta date,
	monto_venta numeric
);

INSERT INTO ventas (producto_nombre, fecha_venta,
monto_venta) VALUES
('Zapatos', '2023-01-01', 1000),
('Medias', '2023-01-02', 1200),
('Pantalon', '2023-01-01', 800),
('camisa', '2023-01-02', 950),
('Chaqueta', '2023-01-03', 1300),
('Zapatos', '2023-01-05', 1200),
('Medias', '2023-01-06', 700),
('Pantalon', '2023-01-05', 1800),
('camisa', '2023-01-06', 1950),
('Chaqueta', '2023-01-06', 300),
('Chaqueta', '2023-01-05', 400);

select *, rank() over (order by producto_nombre) as posicion, rank() over (order by monto_venta) as pos2 from ventas;

select id, name, dept_name, salary, rank() over (order by salary asc) as rango_salarial
from instructor;

select id, name, dept_name salary,
case
	when salary < 30000 then 'Rango Salarial 1: Menor a 30000'
	when salary >=30000 and salary <50000 then 'Rango Salarial 2: Entre 30000 y 50000'
	when salary >=50000 and salary <70000 then 'Rango Salarial 3: Entre 50000 y 70000'
	when salary >=70000 and salary <90000 then 'Rango Salarial 4: Entre 70000 y 90000'
	when salary >=90000 and salary <110000 then 'Rango Salarial 5: Entre 90000 y 110000'
	else 'Rango salarial 6: Mucha billuya'

end
from instructor order by salary asc;

