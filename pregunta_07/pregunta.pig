/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
data = LOAD 'data.tsv' AS (letters:CHARARRAY, dict_letters:BAG{t: TUPLE()}, map_letters:MAP[]);
conunt_bag = FOREACH data GENERATE letters, COUNT(dict_letters), SIZE(map_letters);
count_bag_order = ORDER conunt_bag BY letters, $1, $2;
STORE count_bag_order INTO 'output' USING PigStorage(',');

DUMP count_bag_order;


-- docker run --rm -it --name pig -p 50070:50070 -p 8088:8088 -p 8888:8888 -v "$PWD":/workspace jdvelasq/pig:0.17.0