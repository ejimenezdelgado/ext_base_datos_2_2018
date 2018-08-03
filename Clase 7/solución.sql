--1-Obtener una lista de todas las empleadas de los departamentos que empiecen por D y por E. La lista anterior debe contener informaci�n sobre --el n�mero de personal, nombre, apellido y n�mero de tel�fono.
SELECT
	nuempl,
	nombre,
	apellido,
	tlfn,
	nomdep 
FROM
	temple1
	INNER JOIN tdepar2 ON ( temple1.dept = tdepar2.numdep ) 
WHERE
	sexo = 'M' 
	AND ( tdepar2.nomdep LIKE'D%' OR tdepar2.nomdep LIKE'E%' );

--2-Obtener un listado de todos los empleados (nombre y apellido) que ganan m�s de 2000� al mes y que entraron en la compa��a despu�s del 1 de --Enero de 1975. Tambi�n se quiere la informaci�n correspondiente a su c�digo de trabajo y al n�mero de personal de sus directores.
SELECT
	nombre,
	apellido,
	codtra,
	numdirec 
FROM
	temple1
	INNER JOIN tdepar2 ON ( temple1.dept = tdepar2.numdep ) 
WHERE
	salario > 2000 
	AND feching > '01/01/1975';
--3-Obtener una lista con el apellido, n�mero de departamento y salario mensual de los empleados de los departamentos �A00�, �B01�, �C01� y --�D01�. La salida se quiere en orden descendente de salario dentro de cada departamento.
SELECT
	apellido,
	dept,
	salario 
FROM
	temple1 
WHERE
	dept IN ( 'A00', 'B01', 'C01', 'D01' ) 
ORDER BY
	dept,
	salario DESC;

--4-Se pide una lista que recupere el salario medio de cada departamento junto con el n�mero de empleados que tiene. El resultado no debe incluir --empleados que tengan un c�digo de trabajo mayor que 54, ni departamentos con menos de tres empleados. Se quiere ordenada por n�mero de --departamento.
SELECT
	salario,
	numempl 
FROM
	(
SELECT AVG
	( salario ) AS salario,
	COUNT ( * ) AS numempl,
	dept 
FROM
	temple1 
WHERE
	NOT codtra > 54 
GROUP BY
	dept 
	) AS RESULT 
WHERE
	NOT numempl < 3 
ORDER BY
	dept ASC;

--5-Seleccionar todos los empleados de los departamentos �D11� y �E11� cuyo--primer apellido empiece por S.
SELECT
	* 
FROM
	temple1 
WHERE
	dept IN ( 'D11', 'E11' ) 
	AND apellido LIKE'S%';

--6-Obtener el nombre, apellido y fecha de ingreso de los directores de departamento--ordenados por n�mero de personal.
SELECT
	nombre,
	apellido,
	feching 
FROM
	temple1 
WHERE
	CAST ( nuempl AS INT ) IN ( SELECT CAST ( numdirec AS INT ) FROM tdepar2 WHERE numdirec <> '' ) 
ORDER BY
	CAST ( nuempl AS INT );

--7-Obtener un listado de las mujeres de los departamentos que empiecen por D y por E cuyo--nivel de educaci�n sea superior a la media; en este --caso tambi�n ordenados por n�mero de--personal.
SELECT
	nuempl,
	nombre,
	apellido,
	tlfn,
	nomdep 
FROM
	temple1
	INNER JOIN tdepar2 ON ( temple1.dept = tdepar2.numdep ) 
WHERE
	sexo = 'M' 
	AND ( tdepar2.nomdep LIKE'D%' OR tdepar2.nomdep LIKE'E%' ) 
	AND niveduc > ( SELECT AVG ( niveduc ) FROM temple1 ) 
ORDER BY
	nuempl;

--8-Seleccionar todos los empleados cuyo nombre sea igual al de algunas personas del departamento D21 y cuyo c�digo de trabajo sea diferente de --todos los del E21 (la lista debe contener el n�mero de personal, nombre, apellido, departamento y c�digo de trabajo).
SELECT
	* 
FROM
	temple1 
WHERE
	nombre IN ( SELECT nombre FROM temple1 WHERE dept = 'D21' ) 
	AND codtra NOT IN ( SELECT codtra FROM temple1 WHERE dept = 'E21' ) 
	AND dept <> 'D21';

--9-Listar los empleados que no sean directores (la informaci�n que debe aparecer es--el n�mero de personal, apellido y departamento).
SELECT
	* 
FROM
	temple1 
WHERE
	CAST ( nuempl AS INT ) NOT IN ( SELECT CAST ( numdirec AS INT ) FROM tdepar2 WHERE numdirec <> '' ); 
--10-Seleccionar parejas de empleados (de sexo opuesto) que hayan nacido--el mismo d�a (con informaci�n acerca de apellido y fecha de nacimiento).
SELECT
	* 
FROM
	temple1 
WHERE
	fechnac = ( SELECT fechnac FROM temple1 WHERE sexo = 'M' INTERSECT SELECT fechnac FROM temple1 WHERE sexo = 'H' );

--11-Obtener un listado de todos los empleados que pertenecen al mismo--departamento que Tom�s Soler.
SELECT
	* 
FROM
	temple1 
WHERE
	dept = ( SELECT dept FROM temple1 WHERE nombre = 'Tom�s' AND apellido = 'Soler' );