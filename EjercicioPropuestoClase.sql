/*
Para la BD de gestión de tests, busca código de tests y código de pregunta cuyo texto de pregunta se encuentre repetida
*/

drop view buscarCodigoPregunta;

create view buscarCodigoPregunta
	(codigoTest, codigoPreguta)
as
	select codtest, numpreg
    from 
    where 