/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       firstname,
       color
   FROM 
       u 
   WHERE color = 'blue' AND firstname LIKE 'Z%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

*/
data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
firstname_color = FOREACH data GENERATE firstname, color;
filter_fname_color = FILTER firstname_color BY (color MATCHES 'blue') AND (firstname MATCHES '^[Z].*');
filters_condition = FOREACH filter_fname_color GENERATE CONCAT(firstname, ' ', color);
STORE filters_condition INTO 'output' USING PigStorage(',');
DUMP filters_condition;

