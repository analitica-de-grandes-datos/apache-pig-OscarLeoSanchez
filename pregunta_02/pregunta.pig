/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<
*/

line = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, value:INT);
grouped = GROUP line BY letter;
order_data = FOREACH grouped {
     order_subgrouped =  ORDER line BY value;
     GENERATE FLATTEN(order_subgrouped);
}

STORE order_data INTO 'output' USING PigStorage(',');

DUMP order_data;