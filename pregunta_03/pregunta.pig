/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

line = LOAD 'data.tsv' AS (letter:CHARARRAY, date:CHARARRAY, value:INT);
result = FOREACH line GENERATE value;
sorted = ORDER result BY value ASC;
lim = LIMIT sorted 5;
STORE lim INTO 'output' USING PigStorage('\t');