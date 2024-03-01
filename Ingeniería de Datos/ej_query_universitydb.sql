/*
	Ejercicios de query en UniversityDB
	26 feb 2024
*/


-- Consultas anidadas

-- Selecc todos los cursos que se dictaron en fall 2009 y en spring 2010

select distinct course_id from section
where semester = 'Fall' and year = 2009 and course_id in
(select course_id from section
where semester = 'Spring'and year = 2010);

-- Selec todos los cursos dictados en fall 2009 pero que no se hayan dictado en spring 2010

select distinct course_id from section
where semester = 'Fall' and year = 2009 and course_id not in
(select course_id from section
where semester = 'Spring'and year = 2010);

-- Nombres de los instructores que sean diferentes a Mozart y a Einstein

select name from instructor
where name not in ('Mozart', 'Einstein');

-- Encontrar el número de estudiantes distintos que hayan tomado con instructor con ID 10101

select count(distinct ID) from takes where (course_id, sec_id, semester, year) in
(select course_id, sec_id, semester, year from teaches where id = '10101');

-- Encontrar los nombres de todos los instructores cuyo salario es mayor que en al menos un instructor del depto de 'Comp. Sci'

select name from instructor
where salary > (select min(salary) from instructor where dept_name = 'Comp. Sci.');

select name from instructor
where salary > some (select salary -- Mejor y más corto usando some
from instructor where dept_name = 'Comp. Sci.');

-- 26/02/24

-- Encontrar los cursos de Biology y Comp. Sci. usando subconsultas
select * from course
where dept_name = 'Comp. Sci.'
or course_id in
(select course_id from course where dept_name = 'Biology');

-- Encontrar la suma de los créditos de los dptos de Biology y Comp. Sci.

select dept_name, sum(credits) from course
where dept_name = 'Comp. Sci.'
or course_id in
(select course_id from course where dept_name = 'Biology')
group by dept_name;

-- Consulta usando el comando in que traiga la suma de todos los créditos del dpto de Comp. Sci. menos los del curso de Image Processnig

select sum(credits) from course
where dept_name = 'Comp. Sci.'
and course_id not in
(select course_id from course where title = 'Image Processing');

-- Nombre de los estudiantes que hayan tomado el curso Intro. to Computer Science

select name from student where id in
(select id from takes where course_id in 
(select course_id from course where title = 'Intro. to Computer Science'));

-- encontrar el departamento con el mayor presupuesto

with max_budget(value) as (select max(budget) from department)
select dept_name, budget from department, max_budget
where department.budget = max_budget.value;

-- 1/03/23 

-- Vistas
create view instructores as 
(
	select name, dept_name from instructor
);

select * from instructores;

create table cuenta(
	numero varchar(3),
	cliente varchar(20),
	saldo numeric(10,2)
);

insert into cuenta
values
('AAA','Javier', 100000),
('BBB','Pedro', 60000);

select * from cuenta;

-- Sirve para hacer varios comandos a la vez
begin;
update cuenta set saldo = saldo - 20000
where numero = 'AAA';
update cuenta set saldo = saldo + 20000
where numero = 'BBB';
commit;
end;

-- Se pueden crear nuevos constraints
alter table student add
constraint nombre_unico unique(name);

select * from student;

insert into student values -- Falla por la nueva restricción
(25879, 'Chavez', 'Comp. Sci.', 20);

alter table section add
constraint value_semester
check (semester in ('Fall', 'Spring', 'Summer', 'Winter'));

insert into section values
('BIO-101', 2, 'spring', 2015, 'Watson', 120, 'D'); -- Falla por la nueva restricción

/*
	Ejercicios
*/

-- 1. Encontrar los títulos de los cursos que pertenezcan al depto con presupuesto de $100.000 y que tengan tres créditos (a. usando subconsultas. b. usando join)
-- a: Con subconsultas
select title from course where credits = 3 and dept_name in(
select dept_name from department where budget = 100000);
-- b: Con join
select title from course, department 
where course.dept_name = department.dept_name and credits = 3 and budget = 100000;

-- 2. Encontrar los Ids y nombres de todos los estudiantes que recibieron clase con el profesor Einstein
select name, id from student
where id in (
select id from takes where course_id in(
select course_id from teaches where id in(
select id from instructor where name = 'Einstein')));


-- 3. Crear una vista con los resultados anteriores (Punto 2)
create view einsteiniticos as 
(
	select name, id from student
	where id in (
	select id from takes where course_id in(
	select course_id from teaches where id in(
	select id from instructor where name = 'Einstein')))
);

-- 4. Insertar los estudiantes que tengan más de 100 créditos a la relación instructor con el mismo departamento y con un salario de 10000
insert into instructor (id, name, dept_name, salary)
(select id, name, dept_name, 10000 as salary from student where tot_cred > 100);
delete from instructor where salary = 10000;

