/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta en SQL.

   SELECT
       color
   FROM 
       u 
   WHERE 
       color 
   LIKE 'b%';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */

data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, name:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
colors = FOREACH data GENERATE color;
filter_color = FILTER colors BY (color matches '^[b].*');
STORE filter_color INTO 'output' USING PigStorage(',');
DUMP filter_color;