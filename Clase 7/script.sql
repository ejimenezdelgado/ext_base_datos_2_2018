--Creación de las tablas
CREATE TABLE temple1 (
	nuempl CHAR(6) NOT NULL,
	nombre CHAR(12) NOT NULL,
	inicial CHAR(1) NOT NULL,
	apellido CHAR(15) NOT NULL,
	dept CHAR(3) NOT NULL,
	tlfn CHAR(4),
	feching  DATE NOT NULL,
	codtra SMALLINT NOT NULL,
	niveduc SMALLINT NOT NULL,
	sexo CHAR(1) NOT NULL,
	fechnac DATE  NOT NULL,
	salario DECIMAL(9,2) NOT NULL
 );

CREATE TABLE tdepar2 (
	numdep CHAR(3) NOT NULL,
	nomdep CHAR(36) NOT NULL,
	numdirec CHAR(6) NOT NULL
);