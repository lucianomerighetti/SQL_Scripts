   SELECT sql_id,
   child_number,
   NAME,
   position,
   datatype,
   datatype_string,
   max_length,
   was_captured,
   last_captured,
   value_string,
   ANYDATA.ACCESSTIMESTAMP(VALUE_ANYDATA)
   FROM gv$sql_bind_capture c
   WHERE c.SQL_ID = '2cg6husnypwr8';   