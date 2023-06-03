/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código en Pig para manipulación de fechas que genere la siguiente 
salida.

   1971-07-08,jul,07,7
   1974-05-23,may,05,5
   1973-04-22,abr,04,4
   1975-01-29,ene,01,1
   1974-07-03,jul,07,7
   1974-10-18,oct,10,10
   1970-10-05,oct,10,10
   1969-02-24,feb,02,2
   1974-10-17,oct,10,10
   1975-02-28,feb,02,2
   1969-12-07,dic,12,12
   1973-12-24,dic,12,12
   1970-08-27,ago,08,8
   1972-12-12,dic,12,12
   1970-07-01,jul,07,7
   1974-02-11,feb,02,2
   1973-04-01,abr,04,4
   1973-04-29,abr,04,4

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
dates = FOREACH data GENERATE date;

processed_data = FOREACH dates {
    -- Extrae el año, mes y día de la fecha
    year = GetYear(ToDate(date, 'yyyy-MM-dd'));
    date_format = ToDate(date, 'yyyy-MM-dd', 'GMT');
    month_name = ToString(date_format, 'MMM');
    month_number = ToString(date_format, 'MM');
    day = GetDay(ToDate(date, 'yyyy-MM-dd'));
    month_number_short = ToString(date_format, 'M');
--     day = GetDay(ToDate(date, 'yyyy-MM-dd'));
--     month = ToMonth(date, 'yyyy-MM-dd', 'GMT')
    month_name = CASE month_name
        WHEN 'Jan' THEN 'ene'
        WHEN 'Feb' THEN 'feb'
        WHEN 'Mar' THEN 'mar'
        WHEN 'Apr' THEN 'abr'
        WHEN 'May' THEN 'may'
        WHEN 'Jun' THEN 'jun'
        WHEN 'Jul' THEN 'jul'
        WHEN 'Aug' THEN 'ago'
        WHEN 'Sep' THEN 'sep'
        WHEN 'Oct' THEN 'oct'
        WHEN 'Nov' THEN 'nov'
        WHEN 'Dec' THEN 'dic'
        ELSE month_name
    END;


    -- Genera la salida requerida
    GENERATE date, LOWER(month_name), month_number, month_number_short;
}
STORE processed_data INTO 'output' USING PigStorage(',');

DUMP processed_data;