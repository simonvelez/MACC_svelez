/*
	Ejercicios de query en UniversityDB
	19 feb 2024
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
