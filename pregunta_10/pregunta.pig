/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data =LOAD 'data.csv' USING PigStorage(',') AS (item:INT, name:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
last_name = FOREACH data GENERATE lastname, SIZE(lastname) AS num_letters;
num_letters_lastname = ORDER last_name BY num_letters DESC, lastname ASC;
top = LIMIT num_letters_lastname 5;
STORE top INTO 'output' USING PigStorage(',');
DUMP top;