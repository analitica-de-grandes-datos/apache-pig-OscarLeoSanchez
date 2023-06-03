/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT 
       REGEX_EXTRACT(birthday, '....-..-..', 2) 
   FROM 
       u;

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/


data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
-- filter_data = FILTER data BY date MATCHES '....-..-..';
birthday = FOREACH data GENERATE date as date;
result = FOREACH birthday GENERATE FLATTEN(STRSPLIT(date, '-')) ;
month =  FOREACH result GENERATE $1;
STORE month INTO 'output' USING PigStorage(',');
DUMP month;
