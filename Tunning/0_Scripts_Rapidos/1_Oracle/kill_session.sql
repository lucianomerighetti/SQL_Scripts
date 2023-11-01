create or replace PROCEDURE kill_session (pn_sid NUMBER, pn_serial NUMBER)
AS
   lv_user   VARCHAR2 (30);
BEGIN
   SELECT username
     INTO lv_user
     FROM v$session
    WHERE sid = pn_sid AND serial# = pn_serial;

   IF lv_user IS NOT NULL AND lv_user = USER and lv_user not in ('%UBR', '%ADM', 'UOLBR')
   THEN
      EXECUTE IMMEDIATE 'alter system disconnect session ''' || pn_sid || ',' || pn_serial || '''immediate';
    ELSE
      raise_application_error (-20000,'ERROR: Attempt to kill application users or others has been blocked.');
   END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
     raise_application_error (-20001,'ERROR: SID/Serial# not found');
END;