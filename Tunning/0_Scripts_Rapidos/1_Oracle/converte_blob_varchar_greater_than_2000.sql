create or replace function F_CONVERT_BLOB_VARCHAR(B BLOB)
return clob is
  c clob;
  n number;
begin
  if (b is null) then
    return null;
  end if;
  if (length(b)=0) then
    return empty_clob();
  end if;
  dbms_lob.createtemporary(c,true);
  n:=1;
  while (n+32767<=length(b)) loop
    dbms_lob.writeappend(c,32767,utl_raw.cast_to_varchar2(dbms_lob.substr(b,32767,n)));
    n:=n+32767;
  end loop;
  dbms_lob.writeappend(c,length(b)-n+1,utl_raw.cast_to_varchar2(dbms_lob.substr(b,length(b)-n+1,n)));
  return c;
end;

set echo on
set timing on
set serveroutput on
alter session set NLS_NUMERIC_CHARACTERS = '.,';

declare   

v_json_varchar2_orign varchar2(32767);
v_json_varchar2_new varchar2(32767);
v_json_raw_new RAW(32767);

CURSOR receivables_outbox IS
  SELECT o.IDT_RECEIVABLE_UNIT_OUTBOX,
         TO_CHAR(o.IDT_RECEIVABLE_UNIT_OUTBOX) AS ID,
         o.JSN_METADATA,
         o.COD_OUTBOX_EVENT as COD_OUTBOX_EVENT_ORIGN,
         tmp.COD_OUTBOX_EVENT AS COD_OUTBOX_EVENT_NEW,
         o.DAT_CREATION
         FROM RECEIVABLES_ADM.RECEIVABLE_UNIT_OUTBOX o 
  JOIN SMOREIRA.TMP_IDS_NOT_REPLICATED tmp 
  ON tmp.ID = o.IDT_RECEIVABLE_UNIT_OUTBOX
  WHERE o.IDT_RECEIVABLE_UNIT_OUTBOX IN (SELECT tmp1.ID FROM SMOREIRA.TMP_IDS_NOT_REPLICATED tmp1 WHERE tmp1.COD_OUTBOX_EVENT IS NOT NULL AND tmp1.ID > 1 ORDER BY ID ASC FETCH FIRST 3000 ROWS ONLY)
  AND DBMS_LOB.GETLENGTH(o.JSN_METADATA) >= 2000;

begin

FOR r IN receivables_outbox LOOP
  
  v_json_varchar2_orign := F_CONVERT_BLOB_VARCHAR(r.JSN_METADATA);
  
  v_json_varchar2_new := REPLACE(v_json_varchar2_orign, r.COD_OUTBOX_EVENT_ORIGN ,r.COD_OUTBOX_EVENT_NEW);

  v_json_raw_new := UTL_RAW.CAST_TO_RAW(v_json_varchar2_new);
  
  UPDATE SMOREIRA.TMP_IDS_NOT_REPLICATED
  SET JSON = v_json_raw_new
  WHERE ID = r.ID;
  
  COMMIT;
  
END LOOP;

exception
when OTHERS then
rollback;
dbms_output.put_line('[ERRO]: ' || to_char(SQLERRM) || CHR(10) || to_char(dbms_utility.format_error_backtrace));
dbms_output.put_line('--------------------------------');
end;
/


SELECT /* outbox-receivable-unit-changed-query */ IDT_RECEIVABLE_UNIT_OUTBOX,
       TO_CHAR(IDT_RECEIVABLE_UNIT_OUTBOX) AS ID,
       TMP.JSON AS JSON,
       DAT_CREATION
FROM RECEIVABLES_ADM.RECEIVABLE_UNIT_OUTBOX o 
JOIN SMOREIRA.TMP_IDS_NOT_REPLICATED tmp ON tmp.ID = o.IDT_RECEIVABLE_UNIT_OUTBOX
WHERE o.IDT_RECEIVABLE_UNIT_OUTBOX IN (SELECT ID FROM SMOREIRA.TMP_IDS_NOT_REPLICATED tmp WHERE COD_OUTBOX_EVENT IS NOT NULL AND tmp.ID > ? ORDER BY ID ASC FETCH FIRST 3000 ROWS ONLY)
  AND DBMS_LOB.GETLENGTH(o.JSN_METADATA) >= 2000
ORDER BY 1 ASC --


