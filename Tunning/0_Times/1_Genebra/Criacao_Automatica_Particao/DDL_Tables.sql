drop table dbaad.cnab_content;
drop table dbaad.payment_release_event;
drop table dbaad.prepayment_installment;
drop table dbaad.settlement_installment;
drop table dbaad.transaction;
drop table dbaad.transaction_history;
drop table dbaad.transaction_installment;
drop table dbaad.transaction_installment_history;

CREATE TABLE dbaad.cnab_content
(
    idt_transaction_installment_history bigint NOT NULL,
    idt_transaction numeric(10,0) NOT NULL,
    ind_event smallint NOT NULL,
    dat_reference date NOT NULL,
    dat_escrow date,
    des_content text COLLATE pg_catalog."default" NOT NULL,
    dat_creation timestamp with time zone NOT NULL DEFAULT now(),
    dat_update timestamp with time zone NOT NULL DEFAULT now(),
    flg_active boolean NOT NULL DEFAULT true
) PARTITION BY RANGE (dat_reference) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.cnab_content
    OWNER to dbaad;


CREATE TABLE dbaad.payment_release_event
(
    idt_payment_release_event bigint,
    idt_payment_release_history_ps bigint NOT NULL,
    idt_payment_release_ps bigint NOT NULL,
    idt_fidc_authorization integer NOT NULL,
    idt_safepay_user numeric(10,0) NOT NULL,
    idt_transaction numeric(10,0) NOT NULL,
    ind_status character varying(40) COLLATE pg_catalog."default" NOT NULL,
    idt_update_reason character varying(40) COLLATE pg_catalog."default" NOT NULL,
    dat_update_ps timestamp with time zone NOT NULL DEFAULT now(),
    dat_creation timestamp with time zone NOT NULL DEFAULT now(),
    dat_update timestamp with time zone NOT NULL DEFAULT now(),
    flg_processed boolean NOT NULL DEFAULT false,
    dat_release timestamp with time zone,
    dat_released timestamp with time zone,
    ind_fidc_authorization_status character varying(1) COLLATE pg_catalog."default",
    ind_difference_of_amount_tag character varying(40) COLLATE pg_catalog."default",
    num_advance_cost numeric(10,2),
    num_release_amount numeric(10,2),
    num_installment smallint
) PARTITION BY RANGE (dat_update_ps) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.payment_release_event
    OWNER to dbaad;

CREATE TABLE dbaad.prepayment_installment
(
    idt_transaction_installment bigint NOT NULL,
    idt_prepayment integer NOT NULL,
    num_original_value numeric(18,2) NOT NULL,
    num_prepayment_value numeric(18,2) NOT NULL,
    num_tax numeric(10,4) NOT NULL,
    dat_partition date DEFAULT CURRENT_DATE
) PARTITION BY RANGE (dat_partition) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.prepayment_installment
    OWNER to dbaad;

CREATE TABLE dbaad.settlement_installment
(
    idt_transaction_installment bigint NOT NULL,
    idt_settlement integer,
    dat_settlement date NOT NULL,
    num_value numeric(18,2),
    flg_active boolean NOT NULL DEFAULT true,
    dat_creation timestamp with time zone NOT NULL DEFAULT now(),
    dat_update timestamp with time zone NOT NULL DEFAULT now(),
    flg_escrow_zero boolean NOT NULL DEFAULT false
) PARTITION BY RANGE (dat_settlement) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.settlement_installment
    OWNER to dbaad;

	
CREATE TABLE dbaad.transaction
(
    idt_transaction numeric(10,0) NOT NULL,
    idt_safepay_user numeric(10,0) NOT NULL,
    ind_status smallint NOT NULL DEFAULT 0,
    dat_escrow date NOT NULL,
    dat_creation timestamp with time zone NOT NULL DEFAULT now(),
    dat_creation_ps timestamp with time zone NOT NULL,
    dat_update timestamp with time zone NOT NULL DEFAULT now(),
    num_total_installments smallint NOT NULL,
    num_value numeric(18,2) NOT NULL,
    num_net_value numeric(18,2) NOT NULL,
    num_original_value numeric(18,2) NOT NULL,
    num_total_cost_value numeric(18,2) NOT NULL,
    num_negotiation_version smallint NOT NULL DEFAULT 0,
    cod_credit_card_brand smallint NOT NULL,
    cod_nsu character varying(20) COLLATE pg_catalog."default" NOT NULL,
    cod_safepay_transaction character varying(40) COLLATE pg_catalog."default" NOT NULL
) PARTITION BY RANGE (idt_transaction) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;	

ALTER TABLE dbaad.transaction
    OWNER to dbaad;
	
	
CREATE TABLE dbaad.transaction_history
(
    idt_transaction_history bigint NOT NULL,
    idt_transaction numeric(10,0) NOT NULL,
    idt_safepay_user numeric(10,0) NOT NULL,
    ind_status smallint NOT NULL DEFAULT 0,
    dat_escrow date NOT NULL,
    dat_creation_ps timestamp with time zone NOT NULL,
    dat_update timestamp with time zone NOT NULL,
    num_total_installments smallint NOT NULL,
    num_value numeric(18,2) NOT NULL,
    num_net_value numeric(18,2) NOT NULL,
    num_original_value numeric(18,2) NOT NULL,
    num_negotiation_version smallint NOT NULL DEFAULT 0,
    cod_credit_card_brand smallint NOT NULL,
    cod_nsu character varying(20) COLLATE pg_catalog."default" NOT NULL,
    cod_safepay_transaction character varying(40) COLLATE pg_catalog."default" NOT NULL
) PARTITION BY RANGE (dat_creation_ps) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.transaction_history
    OWNER to dbaad;
	
CREATE TABLE dbaad.transaction_installment
(
    idt_transaction_installment bigint NOT NULL,
    idt_transaction numeric(10,0) NOT NULL,
    ind_settlement_status smallint NOT NULL DEFAULT 0,
    num_value numeric(18,2) NOT NULL,
    num_net_value numeric(18,2) NOT NULL,
    num_gross_revenue numeric(8,2) NOT NULL,
    num_installment smallint NOT NULL,
    cod_safepay_installment character varying(40) COLLATE pg_catalog."default",
    dat_settlement date NOT NULL,
    dat_creation timestamp with time zone NOT NULL DEFAULT now(),
    dat_update timestamp with time zone NOT NULL DEFAULT now(),
    num_version smallint DEFAULT 0
) PARTITION BY RANGE (dat_settlement) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.transaction_installment
    OWNER to dbaad;	
	
CREATE TABLE dbaad.transaction_installment_history
(
    idt_transaction_installment_history bigint NOT NULL,
    idt_transaction_installment bigint NOT NULL,
    idt_transaction numeric(10,0) NOT NULL,
    ind_settlement_status smallint NOT NULL DEFAULT '0'::smallint,
    num_value numeric(18,2) NOT NULL,
    num_net_value numeric(18,2) NOT NULL,
    num_installment smallint NOT NULL,
    num_gross_revenue numeric(8,2) NOT NULL,
    cod_safepay_installment character varying(40) COLLATE pg_catalog."default",
    dat_settlement date NOT NULL,
    dat_update timestamp with time zone NOT NULL,
    idt_user numeric(10,0),
    nam_user_name character varying(150) COLLATE pg_catalog."default",
    ind_user_type smallint,
    nam_user_document character varying(18) COLLATE pg_catalog."default",
    nam_user_address_street character varying(200) COLLATE pg_catalog."default",
    nam_user_postal_code character varying(10) COLLATE pg_catalog."default",
    dat_transaction_escrow date,
    num_transaction_total_installments smallint,
    num_transaction_value numeric(18,2),
    num_transaction_net_value numeric(18,2),
    num_transaction_negotiation_version smallint DEFAULT '0'::smallint,
    cod_transaction_credit_card_brand smallint,
    cod_transaction_nsu character varying(20) COLLATE pg_catalog."default",
    cod_transaction_safepay_transaction character varying(40) COLLATE pg_catalog."default",
    num_transaction_total_cost_value numeric(18,2),
    dat_transaction_creation_ps timestamp with time zone,
    dat_transaction_update timestamp with time zone,
    num_version smallint DEFAULT 0
) PARTITION BY RANGE (dat_update) 
WITH (
    OIDS = FALSE
)
TABLESPACE tsdfidc01;

ALTER TABLE dbaad.transaction_installment_history
    OWNER to dbaad;

	

DO $$
DECLARE 
	start DATE;
	stop DATE;
BEGIN
		start := '2020-05-21'::DATE;
		stop := '2020-05-22'::DATE;
-- dia
		PERFORM create_partition_cnab_content(start, stop);
		PERFORM create_partition_payment_release_event(start, stop);
		PERFORM create_partition_transaction_installment_history(start, stop);
		
END $$;

DO $$
DECLARE 
	start DATE;
	stop DATE;
BEGIN
		start := '2020-06-01'::DATE;
		stop := '2020-07-01'::DATE;

-- mes

        PERFORM create_partition_transaction_installment(start, stop);
		PERFORM create_partition_transaction_history(start, stop);
		PERFORM create_partition_settlement_installment(start, stop);
		PERFORM create_partition_prepayment_installment(start, stop);
		
END $$;


DO $$
	DECLARE
		table_name TEXT;
		partition_name TEXT;
		partition_min NUMERIC;
		partition_max NUMERIC;
		partition_limit NUMERIC[];
		r DATE;
	BEGIN

		table_name := 'transaction';
		r := '2020-05-21';

		PERFORM create_partition_transaction();
		
END $$;
