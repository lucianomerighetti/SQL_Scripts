select level id,
       (to_date('01/01/2022', 'dd/mm/yyyy') + rownum - 1) data
  from dual
connect by level <= ((sysdate - to_date('01/01/2022', 'dd/mm/yyyy')) + 1);