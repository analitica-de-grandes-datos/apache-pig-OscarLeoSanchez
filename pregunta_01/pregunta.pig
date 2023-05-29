/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

-- Cargar el archivo data.tsv
data = LOAD 'data.tsv' USING PigStorage('\t') AS (letra: chararray, fecha: chararray, cantidad: int);

-- Agrupar los registros por letra y contar la cantidad de registros por letra
registros_por_letra = FOREACH (GROUP data BY letra) GENERATE group AS letra, COUNT(data) AS cantidad_registros;

-- Generar una cadena de texto con los resultados separados por comas
resultados = FOREACH registros_por_letra GENERATE CONCAT(letra, ',', (chararray)cantidad_registros) AS resultado;

-- Escribir los resultados en el archivo de salida
STORE resultados INTO 'output' USING PigStorage(',');

-- Mostrar los resultados en la consola (opcional)
DUMP resultados;

