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
