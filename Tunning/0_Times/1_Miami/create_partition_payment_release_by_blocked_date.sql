create or replace function paymentschedule_adm.create_partition_payment_release_by_blocked_date(
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
		table_name := 'paymentschedule_adm.payment_release_by_blocked_date';

		for r in (select i::date from generate_series(start, stop, '1 day') i)
		loop
			partition_year := to_char(r, 'yyyy');
			partition_month := to_char(r, 'mm');
			partition_day := to_char(r, 'dd');
			partition_limit_date := to_char(r + '1 day'::interval,'yyyy-mm-dd');

			partition_name := 'prbd_' || partition_year || '_' || partition_month || '_' || partition_day;

			if not exists(select relname from pg_class where relname = partition_name) then
				execute 'create table ' || partition_name || ' partition of ' || table_name || ' for values from (''' || to_char(r,'yyyy-mm-dd') || ''') to (''' || partition_limit_date || ''') tablespace tsdpaymentschedule01;';
execute 'alter table ' || partition_name || ' add primary key (idt_payment_release, blocked_for_cip_payment_at) using index tablespace  tsipaymentschedule01;';

				execute 'create index index_' || partition_name || '_co on ' || partition_name || '(card_operator) tablespace tsipaymentschedule01;';

				execute 'create index index_' || partition_name || '_pm on ' || partition_name || '(payment_method) tablespace tsipaymentschedule01;';
				
				execute 'create index index_' || partition_name || '_st on ' || partition_name || '(status) tablespace tsipaymentschedule01;';				
				
                execute 'create index index_' || partition_name || '_su on ' || partition_name || '(idt_safepay_user) tablespace tsipaymentschedule01;';								
				
			end if;
		end loop;
	end;
$body$;

alter function paymentschedule_adm.create_partition_payment_release_by_blocked_date(date, date)
    owner to paymentschedule_adm;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_blocked_date(date, date) to public;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_blocked_date(date, date) to dmlexecubr;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_blocked_date(date, date) to paymentschedule_adm;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_blocked_date(date, date) to paymentscheduleapiubr;

grant execute on function paymentschedule_adm.create_partition_payment_release_by_blocked_date(date, date) to paymentscheduleworkerubr;

DO $$
DECLARE 
	start DATE;
	stop DATE;
BEGIN
		start := '2017-01-01'::DATE;
		stop := '2023-12-31'::DATE;

		PERFORM paymentschedule_adm.create_partition_payment_release_by_blocked_date(start, stop);
END $$;