/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT  
       firstname,
       SUBSTRING_INDEX(firstname, 'a', 1)
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
name = FOREACH data GENERATE firstname AS firstname;
sub_name = FOREACH name GENERATE FLATTEN(SUBSTRING(firstname, 0, INDEXOF(firstname, 'a'))) AS sub;

result = FOREACH sub_name GENERATE (sub IS NULL ? -1 : SIZE(sub));
STORE result INTO 'output' USING PigStorage(',');

DUMP result;