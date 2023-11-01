create or replace function paymentschedule_adm.create_partition_payment_release_by_release_date(
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
		table_name := 'paymentschedule_adm.payment_release_by_release_date';

		for r in (select i::date from generate_series(start, stop, '1 day') i)
		loop
			partition_year := to_char(r, 'yyyy');
			partition_month := to_char(r, 'mm');
			partition_day := to_char(r, 'dd');
			partition_limit_date := to_char(r + '1 day'::interval,'yyyy-mm-dd');

			partition_name := 'prrd_' || partition_year || '_' || partition_month || '_' || partition_day;

			if not exists(select relname from pg_class where relname = partition_name) then
				execute 'create table ' || partition_name || ' partition of ' || table_name || ' for values from (''' || to_char(r,'yyyy-mm-dd') || ''') to (''' || partition_limit_date || ''') tablespace tsdpaymentschedule01;';
execute 'alter table ' || partition_name || ' add primary key (idt_payment_release, release_at) using index tablespace  tsipaymentschedule01;';

				execute 'create index ' || partition_name || '_us_cd_pm_a_ix1 on ' || partition_name || '(idt_safepay_user,card_operator,payment_method,release_amount) tablespace tsipaymentschedule01 WHERE status = ''OPENED'';';

			end if;
		end loop;
	end;
$body$;

alter function paymentschedule_adm.create_partition_payment_release_by_release_date(date, date)
    owner to paymentschedule_adm;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_release_date(date, date) to public;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_release_date(date, date) to dmlexecubr;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_release_date(date, date) to paymentschedule_adm;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_release_date(date, date) to paymentscheduleapiubr;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_release_date(date, date) to paymentscheduleworkerubr;

DO $$
DECLARE 
	start DATE;
	stop DATE;
BEGIN
		start := '2017-01-01'::DATE;
		stop := '2023-12-31'::DATE;

		PERFORM paymentschedule_adm.create_partition_payment_release_by_release_date(start, stop);
END $$;