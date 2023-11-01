create or replace function paymentschedule_adm.create_partition_payment_release_by_history_date(
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
		table_name := 'paymentschedule_adm.payment_release_by_history_date';

		for r in (select i::date from generate_series(start, stop, '1 day') i)
		loop
			partition_year := to_char(r, 'yyyy');
			partition_month := to_char(r, 'mm');
			partition_day := to_char(r, 'dd');
			partition_limit_date := to_char(r + '1 day'::interval,'yyyy-mm-dd');

			partition_name := 'prhd_' || partition_year || '_' || partition_month || '_' || partition_day;

			if not exists(select relname from pg_class where relname = partition_name) then
				execute 'create table ' || partition_name || ' partition of ' || table_name || ' for values from (''' || to_char(r,'yyyy-mm-dd') || ''') to (''' || partition_limit_date || ''') tablespace tsdpaymentschedule01;';
execute 'alter table ' || partition_name || ' add primary key (idt_payment_release_history) using index tablespace  tsipaymentschedule01;';

				execute 'create index ix_' || partition_name || ' on ' || partition_name || '(create_dat) tablespace tsipaymentschedule01;';

			end if;
		end loop;
	end;
$body$;

alter function paymentschedule_adm.create_partition_payment_release_by_history_date(date, date)
    owner to paymentschedule_adm;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_history_date(date, date) to public;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_history_date(date, date) to dmlexecubr;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_history_date(date, date) to paymentschedule_adm;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_history_date(date, date) to paymentscheduleapiubr;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_history_date(date, date) to paymentscheduleworkerubr;

DO $$
DECLARE 
	start DATE;
	stop DATE;
BEGIN
		start := '2020-01-01'::DATE;
		stop := '2020-12-31'::DATE;

		PERFORM paymentschedule_adm.create_partition_payment_release_by_history_date(start, stop);
END $$;