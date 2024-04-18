use empresa;
/* EJERCICIO 1 */
/*
explain select empleados.numem, empleados.nomem, departamentos.nomde
from empleados inner join departamentos on empleados.numde = departamentos.numde

where empleados.numde < 120;
*/
/* No hay diferencia en cuanto a eficiencia cuando usamos straight_join el hecho de usar where sobre empleados.
en los dos casos leemos 35 filas de empleados por 1 de departamentos.
Sin embargo, cuando usamos inner join, sin where se preveen 8 * 2 lecturas y con where 4 * 2
EN ESTE CASO INNER JOIN ES MÁS EFICIENTE.
HARÍAMOS BUEN USO DE STRAIGHT_JOIN CON LA SIGUIENTE CLAUSULA FROM:
from departamentos straight_join empleados on empleados.numde = departamentos.numde
OJO EN EL ORDEN DE LAS TABLAS.

*/

/* CREAMOS EL ÍNDICE */
/*
create index para_numdepto on empleados (numde)
*/
/* En lugar de 8* 2 lecturas, sin where o 4*2 lecturas, con where. Reducimos a 8* 1 y 4 * 1 */

/* ELIMINAMOS LOS ÍNDICES */
-- drop index para_numdepto on empleados;
/* MENSAJE ==> no se puede borrar este índice porque esta involucrado en una foreign key
POR TANTO ==> 1º eliminar la foreign key y después el índice 
eliminar también la clave primaria e ir probando con EXPLAIN añadiendo una a una las claves e índices
*/
/* para comprobar los nombres de las claves (primaria y foránea) */
-- show create table empleados; 
/* para comprobar los índices de la tabla */
-- show index from empleados;
/* alter table empleados
    drop foreign key fk_empleados_deptos;
    
    .....

*/

/* EJERCICIO 2 */
-- antes de crear el índice hacer una consulta :
/*
explain
select * 
from clientes
where ape1cli = 'perez';
*/
/* el numero de filas previstas para visitar es el número de clientes que exista en la tabla */

/*
create index nombres_cli 
on clientes(ape1cli(4), ape2cli(4), nomcli(3));
*/
-- show index from clientes;
-- volvemos a hacer la consulta: SE REDUCE EL NÚMERO DE FILAS PREVISTAS PARA ENCONTRAR RESULTADO

/* EJERCICIO 3 */
/*
explain SELECT *
FROM CLIENTES
 WHERE nomcli = 'pepe' and ape1cli ='perez' and ape2cli = 'gomez';
-- WHERE ape1cli ='perez' and ape2cli = 'gomez' and nomcli = 'pepe';
*/
/* Aparentemente el resultado es igual con las dos opciones de WHERE.
en cualquier caso si, cuando crezca el número de clientes empeora la situación
podremos forzar a que la consulta no utilice el índice:
*/
/*
explain
SELECT *
FROM CLIENTES ignore index (nombres_cli)
 WHERE nomcli = 'pepe' and ape1cli ='perez' and ape2cli = 'gomez';
*/
/* EJERCICIO 4 */
/*
CREATE INDEX para_presupuesto 
    ON departamentos(presude ASC)
*/
-- SHOW INDEX FROM departamentos;

/* EJERCICIO 5 */

/*
select nomde, presude
from departamentos IGNORE INDEX (para_presupuesto)
order by presude DESC;
*/

/* EJERCICIO 7 */
/*
explain
select departamentos.nomde, count(*)
from departamentos inner join empleados on empleados.numde = departamentos.numde
group by departamentos.nomde;
*/
/* hay que crear una tabla temporal, ordenarla y después usar where y el índice de clave foránea */


/* EJERCICIO 8 */

/*
create index para_nomdepto
    on departamentos(nomde);

*/
/* AHORA NO NECESITAMOS LA TABLA TEMPORAL NI LA ORDENACIÓN Y REDUCIMOS TAMBIÉN LAS FILAS */

/* EJERCICIO 9 */
/*
CREATE INDEX fecha_ingreso
    ON empleados(fecinem);
*/


/* EJERCICIO 10 */

-- SHOW INDEX FROM empleados;

/* EJERCICIO 11 */
/*explain
SELECT ape1em + ', ' + nomem
FROM empleados
WHERE year(fecinem) <= 1980 and numem < 200;

*/
/* utiliza el índice primary key porque la cardinalidad es menor y porque es "UNIQUE" */

/* EJERCICIO 12 */
/*explain
SELECT ape1em + ', ' + nomem
FROM empleados force index (fecha_ingreso)
WHERE year(fecinem) <= 1980 and numem < 200;
*/
-- La mejor opción es la elegida por el sistema.

/* EJERCICIO 13 */
/*
explain
select empleados.ape1em, empleados.ape2em, empleados.nomem, departamentos.nomde
from empleados inner join departamentos 
    on empleados.numde = departamentos.numde;
*/
/* EJERCICIO 14 */
/*
explain
select ape1em, ape2em, nomem
from empleados
where salarem >=1.5*(select salarem
                    from empleados
                    where nomem = 'Claudia' and ape1em= 'Fierro')
order by ape1em, ape2em, nomem;
*/

/* EJERCICIO 15 */
/*
explain
select nomce
from centros
where exists(select numce from centros where dirce like '%atocha%');
*/

/* EJERCICIO 16 */
/*
explain
select ape1em, ape2em, nomem
from empleados
where salarem > all (select salarem from empleados where numde =121);
*/

/* EJERCICIO 17 */

-- show index from departamentos;
/*
Ejecutando esta instrucción veremos que existe un índice sobre el nombre del departamento.
Para priorizar las actualizaciones de los nombres de departamento frente a las consultas
lo mejor sería eliminar el índice sobre el nombre del departamento:
*/
-- drop index para_nomdepto on departamentos;


/* EJERCICIO 18 */

/* Si decidiéramos no eliminar el índice, deberíamos acumular las actualizaciones de los nombres
de departamentos y hacerlas por la noche o en fin de semana, ...
*/

/* EJERCICIO 22 */
-- show create table dirigir;
/* vemos que la clave primaria está formada por 3 campos.
podríamos solucionarlo creando un campo idDir que sería la primary key
/*
alter table dirigir
add column idDir int;
*/
-- asignar valores a la nueva columna
-- borrar la primary key
-- nuestra nueva columna será primary key

/* EJERCICIO 23 */

-- ver ejercicio 34

/* EJERCICIO 24 */

-- debemos aumentar el tamaño de las variables que controlan el tamaño de las tablas temporales y el de los buffers de caché.


/* EJERCICIO 25 */
/* Cargar previamente los índices de las tablas en cuestión en CACHÉ sería la mejor opción 
   el inconveniente es que estas tablas son InnoDB, por lo que no podremos hacerlo */

/*
LOAD INDEX INTO CACHE empleados;
LOAD INDEX INTO CACHE departamentos;
*/

/* EJERCICIO 26 */
/* CACHÉ DE CONSULTAS ==> contiene la propia consulta y el resultado de la vez que al ejecutarse
se guardó en caché. Si volvemos a ejecutar una consulta, se comprueba si es igual byte a byte el
texto de la instrucción, si es así se devuelve el resultado que ha sido guardado en caché.
BUFFER CACHÉ ==>  Contiene los índices de las consultas más utilizadas.

/* EJERCICIO 27 */
/* LAS ORDENACIONES Y AGRUPACIONES necesitan usar tablas temporales, si son muy grandes se harán en disco
SOLUCIÓN ==> aumentar la variable que controla el tamaño máximo de las tablas temporales creadas en memoria:
valor mínimo entre max_heap_table_size y tmp_table_size */

-- Ver los valores de las variables
--  show variables like '%table_size';
-- Asignar un valor algo mayor:
-- set max_heap_table_size = 20000000;
-- comprobar de nuevo los valores
-- show variables like '%table_size';

/* EJERCICIO 28 */
/* Ninguno, debe estar desactivada. Ya que la caché de consultas interesa solo cuando hay pocas modificaciones y
las consultas no son sencillas.
*/

/* EJERCICIO 29 */
/* Activar la CACHÉ de CONSULTAS */

/* EJERCICIO 30 */
/* Aumentar el tamaño de la variable query_cache_limit */

/* EJERCICIO 31 */
/* Podemos aumentar el buffer de caché hasta el máximo recomendado (80% de la memoria física) 
   Suponiendo que el servidor es dedicado. Como el motor de almacenamiento es InnoDB, la variable
   que debemos modificar es innodb_buffer_pool size
   Comprobar el valor actual (show) e incrementar, no sobrepasando nunca el 80% de la memoria física.
*/

/* EJERCICIO 32 */
/* Igual que antes solo que la variable a modificar es key_buffer_size */

/* EJERCICIO 33 */
/* OPTIMIZE TABLE empleados, departamentos, .... */

/* EJERCICIO 34 */

/* asignar mediante el administrador de workbench o en el archivo my.ini en [mysqld] los siguientes valores a las variables:
innodb_data_home_dir = /nombre_subcarpeta

innodb_data_file_path = ibdata1:1000M; ibdata2:1000M:autoextend

*/

/* EJERCICIO 35 */
/* deshabilitaremos las variables unique_checks” y “foreign_key_checks”
después de la carga de datos, debemos asegurarnos de que se habilitan estas variables
*/
/* EJERCICIO 36 */
/*
flush tables;
*/
/* EJERCICIO 37 */
/*
sort_buffer_size, join_buffer_size
*/