--• Inserte el tipo de servicio OCIO.
INSERT INTO tipo_servicio 
            (nombre_servicio) 
VALUES      ( 'Ocio' ); 

SELECT * 
FROM   tipo_servicio;

--• De de alta una reserva de la habitación 101 para el cliente 12345 para las noches del 2 al 4 de julio de 2009. El código de la reserva es autonumérico.
INSERT INTO reserva_habitacion 
            (fecha_entrada, 
             fecha_salida, 
             iva, 
             num_habitacion, 
             cliente) 
VALUES      ( '02-07-2009', 
              '04-07-2009', 
              0.16, 
              101, 
              '12345');

 --Actualizaciones 
--• Actualice el teléfono del cliente 12345. Su nuevo número es 123456789.
SELECT * 
FROM   cliente
WHERE  identificacion='12345';

UPDATE cliente
SET    telefono='123456789' 
WHERE  identificacion='12345';
--• Actualice el precio de los servicios incrementándolos en un 2%.
UPDATE servicio 
SET    precio=precio+precio*0.02 

SELECT *,precio::numeric 
FROM   servicio;

--Borrados 
--• Borre la reserva de la habitación 101 realizada anteriormente.
DELETE
FROM   reserva_habitacion
WHERE  id_reserva=8

DELETE 
FROM   reserva_habitacion 
WHERE  cliente='12345'
AND    fecha_entrada='02-07-2009' 
AND    num_habitacion=101 

--• Borre los tipos de servicio que no tienen servicios definidos.
DELETE 
FROM   tipo_servicio 
WHERE  nombre_servicio NOT IN 
       ( 
              SELECT nombre_servicio 
              FROM   servicio
        );
        
SELECT * 
FROM   tipo_servicio 

-- CONSULTAS 
-- • Crea una vista que devuelva los clientes cuyo apellido incluya la sílaba “le” ordenados por su identificador.
SELECT   *
FROM     cliente 
WHERE    apellido1 LIKE '%le%' 
ORDER BY identificacion;

-- • Crea una consulta que devuelva los clientes, ordenados por su primer apellido, que tengan alguna observación anotada.
SELECT   *
FROM     cliente 
WHERE    observaciones IS NOT NULL    
ORDER BY apellido1;       

--• Crea una consulta que devuelva los servicios cuyo precio supere los 5 dolares ordenados por su código de servicio.
SELECT   *
FROM     servicio 
WHERE    (precio::NUMERIC>5) 
ORDER BY id_servicio; 

-- • Cree una consulta que devuelva las habitaciones reservadas para el día 24 de marzo de 2009.
SELECT num_habitacion
FROM   reserva_habitacion 
WHERE  '24/03/2009' BETWEEN fecha_entrada AND fecha_salida;

-- • Cree una consulta que devuelva los clientes procedentes de España y Francia.
SELECT * 
FROM   cliente 
WHERE  pais IN ('España', 
                'Francia');
                
-- • Crea una consulta que devuelva los clientes que han utilizado el servicio de comedor.
SELECT servicio.nombre_servicio, 
       servicio.iva, 
       servicio.fecha, 
       cliente.nombre, 
       cliente.apellido1, 
       gastos.id_servicio AS servicio 
FROM   servicio 
       JOIN gastos 
               ON servicio.id_servicio = gastos.id_servicio 
       JOIN reserva_habitacion 
               ON gastos.id_reserva = reserva_habitacion.id_reserva 
       JOIN cliente 
               ON reserva_habitacion.cliente = cliente.identificacion              
WHERE  ( servicio.nombre_servicio = 'Comedor' ) 

SELECT servicio.nombre_servicio, 
       servicio.iva, 
       servicio.fecha, 
       cliente.nombre, 
       cliente.apellido1, 
       gastos.id_servicio AS servicio
FROM   servicio, 
       gastos, 
       reserva_habitacion, 
       cliente 
WHERE  ( servicio.nombre_servicio = 'Comedor' ) 
       AND servicio.id_servicio = gastos.id_servicio 
       AND gastos.id_reserva = reserva_habitacion.id_reserva 
       AND    reserva_habitacion.cliente = cliente.identificacion;

--• Crea una consulta que devuelva las características de cada habitación reservada.
SELECT t.*, 
       h.num_habitacion 
FROM   habitacion h, 
       tipo_habitacion t, 
       reserva_habitacion r 
WHERE  h.num_habitacion = r.num_habitacion 
AND    h.tipo_habitacion = t.categoria;

-- • Cree una consulta que devuelva los precios de los distintos tipos de habitación por temporada.
SELECT     precio_habitacion.tipo_habitacion,
           precio_habitacion.precio::NUMERIC, 
           temporada.fecha_inicio, 
           temporada.fecha_final, 
           temporada.tipo 
FROM       precio_habitacion 
JOIN 	   temporada 
ON         precio_habitacion.temporada = temporada.temporada;

--• Cree una consulta que devuelva todos los clientes, y 
--de aquellos que han realizado
-- alguna reserva en marzo, indicar el nº de reserva.
SELECT c.*, 
       r.id_reserva 
FROM   cliente c 
       LEFT JOIN reserva_habitacion r 
              ON c.identificacion = r.cliente 
                 AND fecha_entrada BETWEEN '01-03-2009' AND '30-03-2009';
