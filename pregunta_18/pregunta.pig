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
   WHERE color NOT IN ('blue','black');

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */

data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
filter_data = FILTER data BY NOT color IN ('blue','black');
color_name = FOREACH filter_data GENERATE firstname, color;
STORE color_name INTO 'output' USING PigStorage(',');
DUMP color_name;