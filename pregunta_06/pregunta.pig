/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.tsv' AS (upper_letter:CHARARRAY, reg:CHARARRAY, list:CHARARRAY);
data2 = FOREACH data GENERATE FLATTEN(TOKENIZE(list, '[],#')) AS list_keys;
keys = FILTER data2 BY (list_keys MATCHES '[a-z]{3}');
keys_group = GROUP keys BY list_keys;
keys_count = FOREACH keys_group GENERATE group, COUNT(keys);
STORE keys_count INTO 'output' USING PigStorage(',');
DUMP keys_count;