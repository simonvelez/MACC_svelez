-- Funciones
-- 15/03/23


/*
Ejemplos:
-- Crear función resta y suma
create function resta (oper1 integer, oper2 integer) returns int
as
$$
select oper1- oper2;
$$
language SQL

create function suma (int, int) returns int
as
$$
select $1 - $2;
$$
language SQL

-- Crear una función que permita actualizar el total de créditos, tomando como parámetros el nombre del estudiante y la
cantidad de crédito a guardar.

create function up_cred_student (nombre varchar, tot_cred numeric) returns integer as
$$
update student set tot_cred = up_cred_student.tot_cred
where name = nombre;
select 1;
$$
language sql

-- Crear una función que inserte los siguientes tres registros en la table estudiante:
'1111','Javier', 'History', 5;
'2222','Javier', 'History', 6;
'3333','Javier', 'History', 7;
create or replace function StudentTest () returns void
as
$$
Insert into student values ('1111','Javier', 'History', 5);
Insert into student values ('2222','Javier', 'History', 6);
Insert into student values ('3333','Javier', 'History', 7);
$$
language sql

*/



create table logs_student(
	id varchar(5),
	name varchar(20),
	tot_cred numeric(3)
);


create function reg_log_student() returns trigger
as
$$
begin
	insert into logs_student values
	(old.id,
	old.name,
	old.dept_name,
	old.tot_cred);
	return new;
end;
$$
Language plpgsql;

create or replace trigger trigger_student before update on student
for each row
execute function reg_log_student();

select * from student;

create or replace function reg_log_student() returns trigger
as
$$
declare
usuario varchar(20) := user;
fecha date := current_date;
hora time := current_time;
begin
	insert into logs_student values
	(new.id,
	new.name,
	new.dept_name,
	new.tot_cred,
	usuario,
	fecha,
	hora);
end
$$
language plpgsql;

-- Ejercicios:

-- 1. Crear func. que returno el num de créditos promedio de los estudiantes
--    en un dpto en particular
create or replace function prom_cred(varchar(20)) returns float
as
$$
begin
	return(select avg(tot_cred) from student where dept_name = $1);
end;
$$
language plpgsql;

select prom_cred('Comp. Sci.');

-- 2. Cree una función que devuelva el listado de estudiantes de un departamento dado
create or replace function estudiante_list(varchar(20)) returns table (nombre varchar(20))
as
$$
begin
	return query select name from student where dept_name = $1;
end;
$$
language plpgsql;

select estudiante_list('Comp. Sci.');