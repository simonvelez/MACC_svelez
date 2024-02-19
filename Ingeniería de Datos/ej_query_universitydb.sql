/*
	Ejercicios de query en UniversityDB
	19 feb 2024
*/


-- Consultas anidadas: Selecc todos los cursos que se dictaron en fall 2009 y en spring 2010

select distinct course_id from section
where semester = 'Fall' and year = 2009 and course_id in
(select course_id from section
where semester = 'Spring'and year = 2010);