select cal.data,
       to_number(to_char(cal.data, 'DD'))   dia,
       to_number(to_char(cal.data, 'MM'))   mes,
       to_number(to_char(cal.data, 'YY'))   "Ano(AA)",
       to_number(to_char(cal.data, 'YYYY')) "Ano(AAAA)",
       to_char(cal.data, 'day')             "Descr_Dia",
       to_char(cal.data, 'dy')              "Descr_Dia_Abrev",
       to_char(cal.data, 'Month')           "Descr_Mes",
       to_char(cal.data, 'Mon')             "Descr_Mes_Abrev",
       to_char(cal.data, 'dd month yyyy')   data_texto
  from (select (to_date(seq.mes || seq.ano, 'mm/yyyy') - 1) + seq.num data
          from (select result num,
                        -- Data Inicial
                       to_char((to_date('01/01/2022', 'dd/mm/yyyy')), 'mm')   mes,
                       to_char((to_date('01/01/2022', 'dd/mm/yyyy')), 'yyyy') ano
                  from(select level result,
                              (to_date('01/01/2022', 'dd/mm/yyyy') + rownum - 1) data
                         from dual
                      connect by level <= ((sysdate - to_date('01/01/2022', 'dd/mm/yyyy')) + 1)
                      )
               ) seq
       ) cal;