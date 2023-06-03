/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname 
   FROM 
       u 
   WHERE 
       SUBSTRING(firstname, 0, 1) >= 'm';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
names_filter = FILTER data BY SUBSTRING(firstname, 0, 1) >= 'M';
-- names = FILTER data BY firstname MATCHES '[N-Z].*';
names = FOREACH names_filter GENERATE firstname;
-- sub_name = FOREACH data GENERATE FLATTEN(SUBSTRING(firstname, 0, 1))>'m';
-- result = FILTER name BY sub_name; > 'm';
-- sub_name = FOREACH name GENERATE FLATTEN(SUBSTRING(firstname, 0, 1)) as sub;
-- filtered_sub_name = FILTER name BY sub >= 'm';
STORE names INTO 'output' USING PigStorage(',');

DUMP names;