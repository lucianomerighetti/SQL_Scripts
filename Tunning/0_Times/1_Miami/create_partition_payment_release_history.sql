CREATE OR REPLACE FUNCTION paymentschedule_adm.create_partition_payment_release_history(
	)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
  table_name TEXT;
  partition_name TEXT;
  partition_min NUMERIC;
  partition_max NUMERIC;
  partition_limit NUMERIC[];
  r DATE;
 BEGIN

 table_name := 'paymentschedule_adm.payment_release_history';

  select 
     to_number(substring (x.relname from 4 for 10),'9999999999999999')
  from 		   
    (select pt.relname
    from pg_class base_tb 
    join pg_inherits i on i.inhparent = base_tb.oid 
    join pg_class pt on pt.oid = i.inhrelid
    where pt.relname like 'prh%'
	order by pt.relname desc limit 1) x
  INTO partition_limit;

 partition_min := 0;
 partition_max := 125000000;

 IF FOUND THEN
  partition_min := partition_limit[2];
  partition_max := partition_min + 125000000;
 END IF;
 
 partition_name :=  'prh_' || partition_max;
   
 IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname = partition_name) THEN
  EXECUTE 'CREATE TABLE ' || partition_name || ' PARTITION OF ' || table_name || ' FOR VALUES FROM (' || partition_min || ') TO (' || partition_max || ');';
  EXECUTE 'ALTER TABLE ' || partition_name || ' ADD PRIMARY KEY (idt_payment_release_history)  USING INDEX TABLESPACE tsdpaymentschedule01;';
  
  EXECUTE 'CREATE INDEX index_' || partition_name || ' ON ' || partition_name || '(idt_payment_release) TABLESPACE tsipaymentschedule01;';
 END IF;
  
 END;
$BODY$;

ALTER FUNCTION paymentschedule_adm.create_partition_payment_release_history()
    OWNER TO paymentschedule_adm;
	
DO $$
	DECLARE
		table_name TEXT;
		partition_name TEXT;
		partition_min NUMERIC;
		partition_max NUMERIC;
		partition_limit NUMERIC[];
		r DATE;
	BEGIN

		table_name := 'payment_release_history';
		r := '2021-06-26';
		PERFORM paymentschedule_adm.create_partition_payment_release_history();
		PERFORM paymentschedule_adm.create_partition_payment_release_history();
		PERFORM paymentschedule_adm.create_partition_payment_release_history();
		PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
        PERFORM paymentschedule_adm.create_partition_payment_release_history();
		
END $$;	