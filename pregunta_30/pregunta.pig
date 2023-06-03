/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- REGISTER /opt/pig/lib/piggybank.jar;
-- DEFINE GetWeekday org.apache.pig.piggybank.evaluation.datetime.GetWeekday();


data = LOAD 'data.csv' USING PigStorage(',') AS (item:INT, firstname:CHARARRAY, lastname:CHARARRAY, date:CHARARRAY,color:CHARARRAY, num:INT);
-- dates = FOREACH data GENERATE date;
date_format = FOREACH data GENERATE ToDate(date,'yyyy-MM-dd') AS date;
-- data = FOREACH data GENERATE ToString(date,'yyyy-MM-dd'), GetDay(date), ToString(date, 'EE');
-- DUMP data;
processed_date = FOREACH date_format {
        -- date_format = ToDate(date, 'yyyy-MM-dd', 'GMT');
        day_number = ToString(date, 'dd');
        day_short_num = ToString(date, 'd');
        day_short_letter = ToString(date, 'EEE');
        day_long_letter = ToString(date, 'EEEE');

        day_short_letter = CASE day_short_letter
                WHEN 'Mon' THEN 'Lun'
                WHEN 'Tue' THEN 'Mar'
                WHEN 'Wed' THEN 'Mié'
                WHEN 'Thu' THEN 'Jue'
                WHEN 'Fri' THEN 'Vie'
                WHEN 'Sat' THEN 'Sáb'
                WHEN 'Sun' THEN 'Dom'
                ELSE day_short_letter
        END;

        -- Traduce el nombre completo del día de la semana al español
        day_long_letter = CASE day_long_letter
                WHEN 'Monday' THEN 'Lunes'
                WHEN 'Tuesday' THEN 'Martes'
                WHEN 'Wednesday' THEN 'Miércoles'
                WHEN 'Thursday' THEN 'Jueves'
                WHEN 'Friday' THEN 'Viernes'
                WHEN 'Saturday' THEN 'Sábado'
                WHEN 'Sunday' THEN 'Domingo'
                ELSE day_long_letter
        END;

        

        GENERATE ToString(date, 'yyyy-MM-dd'), day_number, day_short_num, day_short_letter, day_long_letter;
}



DUMP processed_date;