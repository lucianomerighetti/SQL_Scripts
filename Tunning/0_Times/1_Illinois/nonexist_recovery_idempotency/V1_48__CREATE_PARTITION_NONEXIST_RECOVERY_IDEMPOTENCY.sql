create or replace function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(
	start date,
	stop date)
    returns void
    language 'plpgsql'
    cost 100
    volatile parallel unsafe
as $body$
declare
		table_name text;
		partition_year text;
		partition_month text;
		partition_day text;
		partition_name text;
		partition_limit_date text;

		r date;
	begin
		table_name := 'cip_liquidator_adm.nonexist_recovery_idempotency';

		for r in (select i::date from generate_series(start, stop, '1 day') i)
		loop
			partition_year := to_char(r, 'yyyy');
			partition_month := to_char(r, 'mm');
			partition_day := to_char(r, 'dd');
			partition_limit_date := to_char(r + '1 day'::interval,'yyyy-mm-dd');

			partition_name := 'nri_' || partition_year || '_' || partition_month || '_' || partition_day;

			if not exists(select relname from pg_class where relname = partition_name) then
				execute 'create table ' || partition_name || ' partition of ' || table_name || ' for values from (''' || to_char(r,'yyyy-mm-dd') || ''') to (''' || partition_limit_date || ''') tablespace tsdcipliquidator01;';

                execute 'alter table ' || partition_name || ' add primary key (cod_nonexist_recovery_idempotency) using index tablespace  tsicipliquidator01;';


			end if;
		end loop;
	end;
$body$;

alter function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(date, date)
    owner to cip_liquidator_adm;

grant execute on function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(date, date) to public;

grant execute on function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(date, date) to dmlexecubr;

grant execute on function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(date, date) to cip_liquidator_adm;

grant execute on function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(date, date) to paymentscheduleapiubr;

grant execute on function cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(date, date) to paymentscheduleworkerubr;

DO $$
DECLARE 
	start DATE;
	stop DATE;
BEGIN
		start := '2023-01-01'::DATE;
		stop := '2023-12-31'::DATE;

		PERFORM cip_liquidator_adm.create_partition_nonexist_recovery_idempotency(start, stop);
END $$;