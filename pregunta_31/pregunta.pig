/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',') AS (id: int, firstname: chararray, lastname: chararray, birthday: chararray, color: chararray, num: int);
years = FOREACH data GENERATE SUBSTRING(birthday, 0, 4) AS year;
grouped = GROUP years BY year;
countByYear = FOREACH grouped GENERATE group AS year, COUNT(years) AS count;
STORE countByYear INTO 'output' USING PigStorage(',');
DUMP countByYear;