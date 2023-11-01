----------------------
-- cria tabela nova --	
----------------------


DROP TABLE if exists fidc_adm.transaction_new;

CREATE TABLE fidc_adm.transaction_new
(
    idt_transaction numeric(18,0) NOT NULL,
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

ALTER TABLE fidc_adm.transaction_new OWNER to fidc_adm;

GRANT SELECT ON TABLE fidc_adm.transaction_new TO ad;

GRANT SELECT ON TABLE fidc_adm.transaction_new TO ad_splunkubr;

GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE fidc_adm.transaction_new TO dmlexecubr;

GRANT ALL ON TABLE fidc_adm.transaction_new TO fidc_adm;

GRANT UPDATE, DELETE, SELECT, INSERT ON TABLE fidc_adm.transaction_new TO fidcubr;

GRANT SELECT ON TABLE fidc_adm.transaction_new TO manut_fidc_adm;

GRANT SELECT ON TABLE fidc_adm.transaction_new TO r_datagovernance;

GRANT SELECT ON TABLE fidc_adm.transaction_new TO smoreira;

COMMENT ON TABLE fidc_adm.transaction_new
    IS '[NOT_SECURITY_APPLY] Tabela particionada com informacoes da transacao';

COMMENT ON COLUMN fidc_adm.transaction_new.idt_transaction
    IS '[NOT_SECURITY_APPLY] Identificador da tabela';

COMMENT ON COLUMN fidc_adm.transaction_new.idt_safepay_user
    IS '[NOT_SECURITY_APPLY] Identificadordo usuario';

COMMENT ON COLUMN fidc_adm.transaction_new.ind_status
    IS '[NOT_SECURITY_APPLY] Coluna com o status da transaction';

COMMENT ON COLUMN fidc_adm.transaction_new.dat_escrow
    IS '[NOT_SECURITY_APPLY] Coluna com o dia em que o fidc liquida para o lojista';

COMMENT ON COLUMN fidc_adm.transaction_new.dat_creation
    IS '[NOT_SECURITY_APPLY] Data de criacao do evento';

COMMENT ON COLUMN fidc_adm.transaction_new.dat_creation_ps
    IS '[NOT_SECURITY_APPLY] Coluna com a data de criaca da transacao o pagseguro';

COMMENT ON COLUMN fidc_adm.transaction_new.dat_update
    IS '[NOT_SECURITY_APPLY] Data de atualizacao do evento';

COMMENT ON COLUMN fidc_adm.transaction_new.num_total_installments
    IS '[NOT_SECURITY_APPLY] Coluna com a quantidade de parcelas';

COMMENT ON COLUMN fidc_adm.transaction_new.num_value
    IS '[NOT_SECURITY_APPLY] Coluna para marcar se a transacao e escrow zero ou nao';

COMMENT ON COLUMN fidc_adm.transaction_new.num_net_value
    IS '[NOT_SECURITY_APPLY] Coluna com valor liquido da transaction';

COMMENT ON COLUMN fidc_adm.transaction_new.num_original_value
    IS '[NOT_SECURITY_APPLY] Coluna com valor da transction';

COMMENT ON COLUMN fidc_adm.transaction_new.num_total_cost_value
    IS '[NOT_SECURITY_APPLY] Coluna com o valor total da transaction';

COMMENT ON COLUMN fidc_adm.transaction_new.num_negotiation_version
    IS '[NOT_SECURITY_APPLY] Coluna de status de nascimento da transacao';

COMMENT ON COLUMN fidc_adm.transaction_new.cod_credit_card_brand
    IS '[NOT_SECURITY_APPLY] Coluna com o codigo bandeira cartao de credito';

COMMENT ON COLUMN fidc_adm.transaction_new.cod_nsu
    IS '[NOT_SECURITY_APPLY] Coluna com o codigo de autorizacao de bandeira';

COMMENT ON COLUMN fidc_adm.transaction_new.cod_safepay_transaction
    IS '[NOT_SECURITY_APPLY] Coluna com o codigo da transacao pagseguro';

-- Partitions SQL

CREATE TABLE fidc_adm.transaction_new_partition_0_1984000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('0') TO ('1984000000');

ALTER TABLE fidc_adm.transaction_new_partition_0_1984000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_1984000000_1990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('1984000000') TO ('1990000000');

ALTER TABLE fidc_adm.transaction_new_partition_1984000000_1990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_1990000000_2090000000 PARTITION OF fidc_adm.transaction_new  FOR VALUES FROM ('1990000000') TO ('2090000000');

ALTER TABLE fidc_adm.transaction_new_partition_1990000000_2090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2090000000_2190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2090000000') TO ('2190000000');

ALTER TABLE fidc_adm.transaction_new_partition_2090000000_2190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2190000000_2290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2190000000') TO ('2290000000');

ALTER TABLE fidc_adm.transaction_new_partition_2190000000_2290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2290000000_2300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2290000000') TO ('2300000000');

ALTER TABLE fidc_adm.transaction_new_partition_2290000000_2300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2300000000_2310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2300000000') TO ('2310000000');

ALTER TABLE fidc_adm.transaction_new_partition_2300000000_2310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2310000000_2320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2310000000') TO ('2320000000');

ALTER TABLE fidc_adm.transaction_new_partition_2310000000_2320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2320000000_2330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2320000000') TO ('2330000000');

ALTER TABLE fidc_adm.transaction_new_partition_2320000000_2330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2330000000_2340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2330000000') TO ('2340000000');

ALTER TABLE fidc_adm.transaction_new_partition_2330000000_2340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2340000000_2350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2340000000') TO ('2350000000');

ALTER TABLE fidc_adm.transaction_new_partition_2340000000_2350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2350000000_2360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2350000000') TO ('2360000000');

ALTER TABLE fidc_adm.transaction_new_partition_2350000000_2360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2360000000_2370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2360000000') TO ('2370000000');

ALTER TABLE fidc_adm.transaction_new_partition_2360000000_2370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2370000000_2380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2370000000') TO ('2380000000');

ALTER TABLE fidc_adm.transaction_new_partition_2370000000_2380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2380000000_2390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2380000000') TO ('2390000000');

ALTER TABLE fidc_adm.transaction_new_partition_2380000000_2390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2390000000_2400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2390000000') TO ('2400000000');

ALTER TABLE fidc_adm.transaction_new_partition_2390000000_2400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2400000000_2410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2400000000') TO ('2410000000');

ALTER TABLE fidc_adm.transaction_new_partition_2400000000_2410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2410000000_2420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2410000000') TO ('2420000000');

ALTER TABLE fidc_adm.transaction_new_partition_2410000000_2420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2420000000_2430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2420000000') TO ('2430000000');

ALTER TABLE fidc_adm.transaction_new_partition_2420000000_2430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2430000000_2440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2430000000') TO ('2440000000');

ALTER TABLE fidc_adm.transaction_new_partition_2430000000_2440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2440000000_2450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2440000000') TO ('2450000000');

ALTER TABLE fidc_adm.transaction_new_partition_2440000000_2450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2450000000_2460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2450000000') TO ('2460000000');

ALTER TABLE fidc_adm.transaction_new_partition_2450000000_2460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2460000000_2470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2460000000') TO ('2470000000');

ALTER TABLE fidc_adm.transaction_new_partition_2460000000_2470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2470000000_2480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2470000000') TO ('2480000000');

ALTER TABLE fidc_adm.transaction_new_partition_2470000000_2480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2480000000_2490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2480000000') TO ('2490000000');

ALTER TABLE fidc_adm.transaction_new_partition_2480000000_2490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2490000000_2500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2490000000') TO ('2500000000');

ALTER TABLE fidc_adm.transaction_new_partition_2490000000_2500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2500000000_2510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2500000000') TO ('2510000000');

ALTER TABLE fidc_adm.transaction_new_partition_2500000000_2510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2510000000_2520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2510000000') TO ('2520000000');

ALTER TABLE fidc_adm.transaction_new_partition_2510000000_2520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2520000000_2530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2520000000') TO ('2530000000');

ALTER TABLE fidc_adm.transaction_new_partition_2520000000_2530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2530000000_2540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2530000000') TO ('2540000000');

ALTER TABLE fidc_adm.transaction_new_partition_2530000000_2540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2540000000_2550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2540000000') TO ('2550000000');

ALTER TABLE fidc_adm.transaction_new_partition_2540000000_2550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2550000000_2560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2550000000') TO ('2560000000');

ALTER TABLE fidc_adm.transaction_new_partition_2550000000_2560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2560000000_2570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2560000000') TO ('2570000000');

ALTER TABLE fidc_adm.transaction_new_partition_2560000000_2570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2570000000_2580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2570000000') TO ('2580000000');

ALTER TABLE fidc_adm.transaction_new_partition_2570000000_2580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2580000000_2590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2580000000') TO ('2590000000');

ALTER TABLE fidc_adm.transaction_new_partition_2580000000_2590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2590000000_2600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2590000000') TO ('2600000000');

ALTER TABLE fidc_adm.transaction_new_partition_2590000000_2600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2600000000_2610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2600000000') TO ('2610000000');

ALTER TABLE fidc_adm.transaction_new_partition_2600000000_2610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2610000000_2620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2610000000') TO ('2620000000');

ALTER TABLE fidc_adm.transaction_new_partition_2610000000_2620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2620000000_2630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2620000000') TO ('2630000000');

ALTER TABLE fidc_adm.transaction_new_partition_2620000000_2630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2630000000_2640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2630000000') TO ('2640000000');

ALTER TABLE fidc_adm.transaction_new_partition_2630000000_2640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2640000000_2650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2640000000') TO ('2650000000');

ALTER TABLE fidc_adm.transaction_new_partition_2640000000_2650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2650000000_2660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2650000000') TO ('2660000000');

ALTER TABLE fidc_adm.transaction_new_partition_2650000000_2660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2660000000_2670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2660000000') TO ('2670000000');

ALTER TABLE fidc_adm.transaction_new_partition_2660000000_2670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2670000000_2680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2670000000') TO ('2680000000');

ALTER TABLE fidc_adm.transaction_new_partition_2670000000_2680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2680000000_2690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2680000000') TO ('2690000000');

ALTER TABLE fidc_adm.transaction_new_partition_2680000000_2690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2690000000_2700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2690000000') TO ('2700000000');

ALTER TABLE fidc_adm.transaction_new_partition_2690000000_2700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2700000000_2710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2700000000') TO ('2710000000');

ALTER TABLE fidc_adm.transaction_new_partition_2700000000_2710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2710000000_2720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2710000000') TO ('2720000000');

ALTER TABLE fidc_adm.transaction_new_partition_2710000000_2720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2720000000_2730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2720000000') TO ('2730000000');

ALTER TABLE fidc_adm.transaction_new_partition_2720000000_2730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2730000000_2740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2730000000') TO ('2740000000');

ALTER TABLE fidc_adm.transaction_new_partition_2730000000_2740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2740000000_2750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2740000000') TO ('2750000000');

ALTER TABLE fidc_adm.transaction_new_partition_2740000000_2750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2750000000_2760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2750000000') TO ('2760000000');

ALTER TABLE fidc_adm.transaction_new_partition_2750000000_2760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2760000000_2770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2760000000') TO ('2770000000');

ALTER TABLE fidc_adm.transaction_new_partition_2760000000_2770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2770000000_2780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2770000000') TO ('2780000000');

ALTER TABLE fidc_adm.transaction_new_partition_2770000000_2780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2780000000_2790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2780000000') TO ('2790000000');

ALTER TABLE fidc_adm.transaction_new_partition_2780000000_2790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2790000000_2800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2790000000') TO ('2800000000');

ALTER TABLE fidc_adm.transaction_new_partition_2790000000_2800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2800000000_2810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2800000000') TO ('2810000000');

ALTER TABLE fidc_adm.transaction_new_partition_2800000000_2810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2810000000_2820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2810000000') TO ('2820000000');

ALTER TABLE fidc_adm.transaction_new_partition_2810000000_2820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2820000000_2830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2820000000') TO ('2830000000');

ALTER TABLE fidc_adm.transaction_new_partition_2820000000_2830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2830000000_2840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2830000000') TO ('2840000000');

ALTER TABLE fidc_adm.transaction_new_partition_2830000000_2840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2840000000_2850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2840000000') TO ('2850000000');

ALTER TABLE fidc_adm.transaction_new_partition_2840000000_2850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2850000000_2860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2850000000') TO ('2860000000');

ALTER TABLE fidc_adm.transaction_new_partition_2850000000_2860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2860000000_2870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2860000000') TO ('2870000000');

ALTER TABLE fidc_adm.transaction_new_partition_2860000000_2870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2870000000_2880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2870000000') TO ('2880000000');

ALTER TABLE fidc_adm.transaction_new_partition_2870000000_2880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2880000000_2890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2880000000') TO ('2890000000');

ALTER TABLE fidc_adm.transaction_new_partition_2880000000_2890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2890000000_2900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2890000000') TO ('2900000000');

ALTER TABLE fidc_adm.transaction_new_partition_2890000000_2900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2900000000_2910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2900000000') TO ('2910000000');

ALTER TABLE fidc_adm.transaction_new_partition_2900000000_2910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2910000000_2920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2910000000') TO ('2920000000');

ALTER TABLE fidc_adm.transaction_new_partition_2910000000_2920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2920000000_2930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2920000000') TO ('2930000000');

ALTER TABLE fidc_adm.transaction_new_partition_2920000000_2930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2930000000_2940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2930000000') TO ('2940000000');

ALTER TABLE fidc_adm.transaction_new_partition_2930000000_2940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2940000000_2950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2940000000') TO ('2950000000');

ALTER TABLE fidc_adm.transaction_new_partition_2940000000_2950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2950000000_2960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2950000000') TO ('2960000000');

ALTER TABLE fidc_adm.transaction_new_partition_2950000000_2960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2960000000_2970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2960000000') TO ('2970000000');

ALTER TABLE fidc_adm.transaction_new_partition_2960000000_2970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2970000000_2980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2970000000') TO ('2980000000');

ALTER TABLE fidc_adm.transaction_new_partition_2970000000_2980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2980000000_2990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2980000000') TO ('2990000000');

ALTER TABLE fidc_adm.transaction_new_partition_2980000000_2990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_2990000000_3000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('2990000000') TO ('3000000000');

ALTER TABLE fidc_adm.transaction_new_partition_2990000000_3000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3000000000_3010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3000000000') TO ('3010000000');

ALTER TABLE fidc_adm.transaction_new_partition_3000000000_3010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3010000000_3020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3010000000') TO ('3020000000');

ALTER TABLE fidc_adm.transaction_new_partition_3010000000_3020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3020000000_3030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3020000000') TO ('3030000000');

ALTER TABLE fidc_adm.transaction_new_partition_3020000000_3030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3030000000_3040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3030000000') TO ('3040000000');

ALTER TABLE fidc_adm.transaction_new_partition_3030000000_3040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3040000000_3050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3040000000') TO ('3050000000');

ALTER TABLE fidc_adm.transaction_new_partition_3040000000_3050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3050000000_3060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3050000000') TO ('3060000000');

ALTER TABLE fidc_adm.transaction_new_partition_3050000000_3060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3060000000_3070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3060000000') TO ('3070000000');

ALTER TABLE fidc_adm.transaction_new_partition_3060000000_3070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3070000000_3080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3070000000') TO ('3080000000');

ALTER TABLE fidc_adm.transaction_new_partition_3070000000_3080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3080000000_3090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3080000000') TO ('3090000000');

ALTER TABLE fidc_adm.transaction_new_partition_3080000000_3090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3090000000_3100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3090000000') TO ('3100000000');

ALTER TABLE fidc_adm.transaction_new_partition_3090000000_3100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3100000000_3110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3100000000') TO ('3110000000');

ALTER TABLE fidc_adm.transaction_new_partition_3100000000_3110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3110000000_3120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3110000000') TO ('3120000000');

ALTER TABLE fidc_adm.transaction_new_partition_3110000000_3120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3120000000_3130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3120000000') TO ('3130000000');

ALTER TABLE fidc_adm.transaction_new_partition_3120000000_3130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3130000000_3140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3130000000') TO ('3140000000');

ALTER TABLE fidc_adm.transaction_new_partition_3130000000_3140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3140000000_3150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3140000000') TO ('3150000000');

ALTER TABLE fidc_adm.transaction_new_partition_3140000000_3150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3150000000_3160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3150000000') TO ('3160000000');

ALTER TABLE fidc_adm.transaction_new_partition_3150000000_3160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3160000000_3170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3160000000') TO ('3170000000');

ALTER TABLE fidc_adm.transaction_new_partition_3160000000_3170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3170000000_3180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3170000000') TO ('3180000000');

ALTER TABLE fidc_adm.transaction_new_partition_3170000000_3180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3180000000_3190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3180000000') TO ('3190000000');

ALTER TABLE fidc_adm.transaction_new_partition_3180000000_3190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3190000000_3200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3190000000') TO ('3200000000');

ALTER TABLE fidc_adm.transaction_new_partition_3190000000_3200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3200000000_3210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3200000000') TO ('3210000000');

ALTER TABLE fidc_adm.transaction_new_partition_3200000000_3210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3210000000_3220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3210000000') TO ('3220000000');

ALTER TABLE fidc_adm.transaction_new_partition_3210000000_3220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3220000000_3230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3220000000') TO ('3230000000');

ALTER TABLE fidc_adm.transaction_new_partition_3220000000_3230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3230000000_3240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3230000000') TO ('3240000000');

ALTER TABLE fidc_adm.transaction_new_partition_3230000000_3240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3240000000_3250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3240000000') TO ('3250000000');

ALTER TABLE fidc_adm.transaction_new_partition_3240000000_3250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3250000000_3260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3250000000') TO ('3260000000');

ALTER TABLE fidc_adm.transaction_new_partition_3250000000_3260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3260000000_3270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3260000000') TO ('3270000000');

ALTER TABLE fidc_adm.transaction_new_partition_3260000000_3270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3270000000_3280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3270000000') TO ('3280000000');

ALTER TABLE fidc_adm.transaction_new_partition_3270000000_3280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3280000000_3290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3280000000') TO ('3290000000');

ALTER TABLE fidc_adm.transaction_new_partition_3280000000_3290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3290000000_3300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3290000000') TO ('3300000000');

ALTER TABLE fidc_adm.transaction_new_partition_3290000000_3300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3300000000_3310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3300000000') TO ('3310000000');

ALTER TABLE fidc_adm.transaction_new_partition_3300000000_3310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3310000000_3320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3310000000') TO ('3320000000');

ALTER TABLE fidc_adm.transaction_new_partition_3310000000_3320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3320000000_3330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3320000000') TO ('3330000000');

ALTER TABLE fidc_adm.transaction_new_partition_3320000000_3330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3330000000_3340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3330000000') TO ('3340000000');

ALTER TABLE fidc_adm.transaction_new_partition_3330000000_3340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3340000000_3350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3340000000') TO ('3350000000');

ALTER TABLE fidc_adm.transaction_new_partition_3340000000_3350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3350000000_3360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3350000000') TO ('3360000000');

ALTER TABLE fidc_adm.transaction_new_partition_3350000000_3360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3360000000_3370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3360000000') TO ('3370000000');

ALTER TABLE fidc_adm.transaction_new_partition_3360000000_3370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3370000000_3380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3370000000') TO ('3380000000');

ALTER TABLE fidc_adm.transaction_new_partition_3370000000_3380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3380000000_3390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3380000000') TO ('3390000000');

ALTER TABLE fidc_adm.transaction_new_partition_3380000000_3390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3390000000_3400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3390000000') TO ('3400000000');

ALTER TABLE fidc_adm.transaction_new_partition_3390000000_3400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3400000000_3410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3400000000') TO ('3410000000');

ALTER TABLE fidc_adm.transaction_new_partition_3400000000_3410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3410000000_3420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3410000000') TO ('3420000000');

ALTER TABLE fidc_adm.transaction_new_partition_3410000000_3420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3420000000_3430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3420000000') TO ('3430000000');

ALTER TABLE fidc_adm.transaction_new_partition_3420000000_3430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3430000000_3440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3430000000') TO ('3440000000');

ALTER TABLE fidc_adm.transaction_new_partition_3430000000_3440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3440000000_3450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3440000000') TO ('3450000000');

ALTER TABLE fidc_adm.transaction_new_partition_3440000000_3450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3450000000_3460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3450000000') TO ('3460000000');

ALTER TABLE fidc_adm.transaction_new_partition_3450000000_3460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3460000000_3470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3460000000') TO ('3470000000');

ALTER TABLE fidc_adm.transaction_new_partition_3460000000_3470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3470000000_3480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3470000000') TO ('3480000000');

ALTER TABLE fidc_adm.transaction_new_partition_3470000000_3480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3480000000_3490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3480000000') TO ('3490000000');

ALTER TABLE fidc_adm.transaction_new_partition_3480000000_3490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3490000000_3500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3490000000') TO ('3500000000');

ALTER TABLE fidc_adm.transaction_new_partition_3490000000_3500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3500000000_3510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3500000000') TO ('3510000000');

ALTER TABLE fidc_adm.transaction_new_partition_3500000000_3510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3510000000_3520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3510000000') TO ('3520000000');

ALTER TABLE fidc_adm.transaction_new_partition_3510000000_3520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3520000000_3530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3520000000') TO ('3530000000');

ALTER TABLE fidc_adm.transaction_new_partition_3520000000_3530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3530000000_3540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3530000000') TO ('3540000000');

ALTER TABLE fidc_adm.transaction_new_partition_3530000000_3540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3540000000_3550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3540000000') TO ('3550000000');

ALTER TABLE fidc_adm.transaction_new_partition_3540000000_3550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3550000000_3560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3550000000') TO ('3560000000');

ALTER TABLE fidc_adm.transaction_new_partition_3550000000_3560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3560000000_3570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3560000000') TO ('3570000000');

ALTER TABLE fidc_adm.transaction_new_partition_3560000000_3570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3570000000_3580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3570000000') TO ('3580000000');

ALTER TABLE fidc_adm.transaction_new_partition_3570000000_3580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3580000000_3590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3580000000') TO ('3590000000');

ALTER TABLE fidc_adm.transaction_new_partition_3580000000_3590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3590000000_3600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3590000000') TO ('3600000000');

ALTER TABLE fidc_adm.transaction_new_partition_3590000000_3600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3600000000_3610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3600000000') TO ('3610000000');

ALTER TABLE fidc_adm.transaction_new_partition_3600000000_3610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3610000000_3620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3610000000') TO ('3620000000');

ALTER TABLE fidc_adm.transaction_new_partition_3610000000_3620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3620000000_3630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3620000000') TO ('3630000000');

ALTER TABLE fidc_adm.transaction_new_partition_3620000000_3630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3630000000_3640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3630000000') TO ('3640000000');

ALTER TABLE fidc_adm.transaction_new_partition_3630000000_3640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3640000000_3650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3640000000') TO ('3650000000');

ALTER TABLE fidc_adm.transaction_new_partition_3640000000_3650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3650000000_3660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3650000000') TO ('3660000000');

ALTER TABLE fidc_adm.transaction_new_partition_3650000000_3660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3660000000_3670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3660000000') TO ('3670000000');

ALTER TABLE fidc_adm.transaction_new_partition_3660000000_3670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3670000000_3680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3670000000') TO ('3680000000');

ALTER TABLE fidc_adm.transaction_new_partition_3670000000_3680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3680000000_3690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3680000000') TO ('3690000000');

ALTER TABLE fidc_adm.transaction_new_partition_3680000000_3690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3690000000_3700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3690000000') TO ('3700000000');

ALTER TABLE fidc_adm.transaction_new_partition_3690000000_3700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3700000000_3710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3700000000') TO ('3710000000');

ALTER TABLE fidc_adm.transaction_new_partition_3700000000_3710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3710000000_3720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3710000000') TO ('3720000000');

ALTER TABLE fidc_adm.transaction_new_partition_3710000000_3720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3720000000_3730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3720000000') TO ('3730000000');

ALTER TABLE fidc_adm.transaction_new_partition_3720000000_3730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3730000000_3740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3730000000') TO ('3740000000');

ALTER TABLE fidc_adm.transaction_new_partition_3730000000_3740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3740000000_3750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3740000000') TO ('3750000000');

ALTER TABLE fidc_adm.transaction_new_partition_3740000000_3750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3750000000_3760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3750000000') TO ('3760000000');

ALTER TABLE fidc_adm.transaction_new_partition_3750000000_3760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3760000000_3770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3760000000') TO ('3770000000');

ALTER TABLE fidc_adm.transaction_new_partition_3760000000_3770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3770000000_3780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3770000000') TO ('3780000000');

ALTER TABLE fidc_adm.transaction_new_partition_3770000000_3780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3780000000_3790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3780000000') TO ('3790000000');

ALTER TABLE fidc_adm.transaction_new_partition_3780000000_3790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3790000000_3800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3790000000') TO ('3800000000');

ALTER TABLE fidc_adm.transaction_new_partition_3790000000_3800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3800000000_3810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3800000000') TO ('3810000000');

ALTER TABLE fidc_adm.transaction_new_partition_3800000000_3810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3810000000_3820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3810000000') TO ('3820000000');

ALTER TABLE fidc_adm.transaction_new_partition_3810000000_3820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3820000000_3830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3820000000') TO ('3830000000');

ALTER TABLE fidc_adm.transaction_new_partition_3820000000_3830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3830000000_3840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3830000000') TO ('3840000000');

ALTER TABLE fidc_adm.transaction_new_partition_3830000000_3840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3840000000_3850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3840000000') TO ('3850000000');

ALTER TABLE fidc_adm.transaction_new_partition_3840000000_3850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3850000000_3860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3850000000') TO ('3860000000');

ALTER TABLE fidc_adm.transaction_new_partition_3850000000_3860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3860000000_3870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3860000000') TO ('3870000000');

ALTER TABLE fidc_adm.transaction_new_partition_3860000000_3870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3870000000_3880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3870000000') TO ('3880000000');

ALTER TABLE fidc_adm.transaction_new_partition_3870000000_3880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3880000000_3890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3880000000') TO ('3890000000');

ALTER TABLE fidc_adm.transaction_new_partition_3880000000_3890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3890000000_3900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3890000000') TO ('3900000000');

ALTER TABLE fidc_adm.transaction_new_partition_3890000000_3900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3900000000_3910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3900000000') TO ('3910000000');

ALTER TABLE fidc_adm.transaction_new_partition_3900000000_3910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3910000000_3920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3910000000') TO ('3920000000');

ALTER TABLE fidc_adm.transaction_new_partition_3910000000_3920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3920000000_3930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3920000000') TO ('3930000000');

ALTER TABLE fidc_adm.transaction_new_partition_3920000000_3930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3930000000_3940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3930000000') TO ('3940000000');

ALTER TABLE fidc_adm.transaction_new_partition_3930000000_3940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3940000000_3950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3940000000') TO ('3950000000');

ALTER TABLE fidc_adm.transaction_new_partition_3940000000_3950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3950000000_3960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3950000000') TO ('3960000000');

ALTER TABLE fidc_adm.transaction_new_partition_3950000000_3960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3960000000_3970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3960000000') TO ('3970000000');

ALTER TABLE fidc_adm.transaction_new_partition_3960000000_3970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3970000000_3980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3970000000') TO ('3980000000');

ALTER TABLE fidc_adm.transaction_new_partition_3970000000_3980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3980000000_3990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3980000000') TO ('3990000000');

ALTER TABLE fidc_adm.transaction_new_partition_3980000000_3990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_3990000000_4000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('3990000000') TO ('4000000000');

ALTER TABLE fidc_adm.transaction_new_partition_3990000000_4000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4000000000_4010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4000000000') TO ('4010000000');

ALTER TABLE fidc_adm.transaction_new_partition_4000000000_4010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4010000000_4020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4010000000') TO ('4020000000');

ALTER TABLE fidc_adm.transaction_new_partition_4010000000_4020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4020000000_4030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4020000000') TO ('4030000000');

ALTER TABLE fidc_adm.transaction_new_partition_4020000000_4030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4030000000_4040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4030000000') TO ('4040000000');

ALTER TABLE fidc_adm.transaction_new_partition_4030000000_4040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4040000000_4050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4040000000') TO ('4050000000');

ALTER TABLE fidc_adm.transaction_new_partition_4040000000_4050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4050000000_4060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4050000000') TO ('4060000000');

ALTER TABLE fidc_adm.transaction_new_partition_4050000000_4060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4060000000_4070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4060000000') TO ('4070000000');

ALTER TABLE fidc_adm.transaction_new_partition_4060000000_4070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4070000000_4080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4070000000') TO ('4080000000');

ALTER TABLE fidc_adm.transaction_new_partition_4070000000_4080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4080000000_4090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4080000000') TO ('4090000000');

ALTER TABLE fidc_adm.transaction_new_partition_4080000000_4090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4090000000_4100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4090000000') TO ('4100000000');

ALTER TABLE fidc_adm.transaction_new_partition_4090000000_4100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4100000000_4110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4100000000') TO ('4110000000');

ALTER TABLE fidc_adm.transaction_new_partition_4100000000_4110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4110000000_4120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4110000000') TO ('4120000000');

ALTER TABLE fidc_adm.transaction_new_partition_4110000000_4120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4120000000_4130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4120000000') TO ('4130000000');

ALTER TABLE fidc_adm.transaction_new_partition_4120000000_4130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4130000000_4140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4130000000') TO ('4140000000');

ALTER TABLE fidc_adm.transaction_new_partition_4130000000_4140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4140000000_4150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4140000000') TO ('4150000000');

ALTER TABLE fidc_adm.transaction_new_partition_4140000000_4150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4150000000_4160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4150000000') TO ('4160000000');

ALTER TABLE fidc_adm.transaction_new_partition_4150000000_4160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4160000000_4170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4160000000') TO ('4170000000');

ALTER TABLE fidc_adm.transaction_new_partition_4160000000_4170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4170000000_4180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4170000000') TO ('4180000000');

ALTER TABLE fidc_adm.transaction_new_partition_4170000000_4180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4180000000_4190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4180000000') TO ('4190000000');

ALTER TABLE fidc_adm.transaction_new_partition_4180000000_4190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4190000000_4200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4190000000') TO ('4200000000');

ALTER TABLE fidc_adm.transaction_new_partition_4190000000_4200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4200000000_4210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4200000000') TO ('4210000000');

ALTER TABLE fidc_adm.transaction_new_partition_4200000000_4210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4210000000_4220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4210000000') TO ('4220000000');

ALTER TABLE fidc_adm.transaction_new_partition_4210000000_4220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4220000000_4230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4220000000') TO ('4230000000');

ALTER TABLE fidc_adm.transaction_new_partition_4220000000_4230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4230000000_4240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4230000000') TO ('4240000000');

ALTER TABLE fidc_adm.transaction_new_partition_4230000000_4240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4240000000_4250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4240000000') TO ('4250000000');

ALTER TABLE fidc_adm.transaction_new_partition_4240000000_4250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4250000000_4260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4250000000') TO ('4260000000');

ALTER TABLE fidc_adm.transaction_new_partition_4250000000_4260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4260000000_4270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4260000000') TO ('4270000000');

ALTER TABLE fidc_adm.transaction_new_partition_4260000000_4270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4270000000_4280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4270000000') TO ('4280000000');

ALTER TABLE fidc_adm.transaction_new_partition_4270000000_4280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4280000000_4290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4280000000') TO ('4290000000');

ALTER TABLE fidc_adm.transaction_new_partition_4280000000_4290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4290000000_4300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4290000000') TO ('4300000000');

ALTER TABLE fidc_adm.transaction_new_partition_4290000000_4300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4300000000_4310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4300000000') TO ('4310000000');

ALTER TABLE fidc_adm.transaction_new_partition_4300000000_4310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4310000000_4320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4310000000') TO ('4320000000');

ALTER TABLE fidc_adm.transaction_new_partition_4310000000_4320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4320000000_4330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4320000000') TO ('4330000000');

ALTER TABLE fidc_adm.transaction_new_partition_4320000000_4330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4330000000_4340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4330000000') TO ('4340000000');

ALTER TABLE fidc_adm.transaction_new_partition_4330000000_4340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4340000000_4350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4340000000') TO ('4350000000');

ALTER TABLE fidc_adm.transaction_new_partition_4340000000_4350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4350000000_4360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4350000000') TO ('4360000000');

ALTER TABLE fidc_adm.transaction_new_partition_4350000000_4360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4360000000_4370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4360000000') TO ('4370000000');

ALTER TABLE fidc_adm.transaction_new_partition_4360000000_4370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4370000000_4380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4370000000') TO ('4380000000');

ALTER TABLE fidc_adm.transaction_new_partition_4370000000_4380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4380000000_4390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4380000000') TO ('4390000000');

ALTER TABLE fidc_adm.transaction_new_partition_4380000000_4390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4390000000_4400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4390000000') TO ('4400000000');

ALTER TABLE fidc_adm.transaction_new_partition_4390000000_4400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4400000000_4410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4400000000') TO ('4410000000');

ALTER TABLE fidc_adm.transaction_new_partition_4400000000_4410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4410000000_4420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4410000000') TO ('4420000000');

ALTER TABLE fidc_adm.transaction_new_partition_4410000000_4420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4420000000_4430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4420000000') TO ('4430000000');

ALTER TABLE fidc_adm.transaction_new_partition_4420000000_4430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4430000000_4440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4430000000') TO ('4440000000');

ALTER TABLE fidc_adm.transaction_new_partition_4430000000_4440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4440000000_4450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4440000000') TO ('4450000000');

ALTER TABLE fidc_adm.transaction_new_partition_4440000000_4450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4450000000_4460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4450000000') TO ('4460000000');

ALTER TABLE fidc_adm.transaction_new_partition_4450000000_4460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4460000000_4470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4460000000') TO ('4470000000');

ALTER TABLE fidc_adm.transaction_new_partition_4460000000_4470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4470000000_4480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4470000000') TO ('4480000000');

ALTER TABLE fidc_adm.transaction_new_partition_4470000000_4480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4480000000_4490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4480000000') TO ('4490000000');

ALTER TABLE fidc_adm.transaction_new_partition_4480000000_4490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4490000000_4500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4490000000') TO ('4500000000');

ALTER TABLE fidc_adm.transaction_new_partition_4490000000_4500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4500000000_4510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4500000000') TO ('4510000000');

ALTER TABLE fidc_adm.transaction_new_partition_4500000000_4510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4510000000_4520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4510000000') TO ('4520000000');

ALTER TABLE fidc_adm.transaction_new_partition_4510000000_4520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4520000000_4530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4520000000') TO ('4530000000');

ALTER TABLE fidc_adm.transaction_new_partition_4520000000_4530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4530000000_4540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4530000000') TO ('4540000000');

ALTER TABLE fidc_adm.transaction_new_partition_4530000000_4540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4540000000_4550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4540000000') TO ('4550000000');

ALTER TABLE fidc_adm.transaction_new_partition_4540000000_4550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4550000000_4560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4550000000') TO ('4560000000');

ALTER TABLE fidc_adm.transaction_new_partition_4550000000_4560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4560000000_4570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4560000000') TO ('4570000000');

ALTER TABLE fidc_adm.transaction_new_partition_4560000000_4570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4570000000_4580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4570000000') TO ('4580000000');

ALTER TABLE fidc_adm.transaction_new_partition_4570000000_4580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4580000000_4590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4580000000') TO ('4590000000');

ALTER TABLE fidc_adm.transaction_new_partition_4580000000_4590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4590000000_4600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4590000000') TO ('4600000000');

ALTER TABLE fidc_adm.transaction_new_partition_4590000000_4600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4600000000_4610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4600000000') TO ('4610000000');

ALTER TABLE fidc_adm.transaction_new_partition_4600000000_4610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4610000000_4620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4610000000') TO ('4620000000');

ALTER TABLE fidc_adm.transaction_new_partition_4610000000_4620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4620000000_4630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4620000000') TO ('4630000000');

ALTER TABLE fidc_adm.transaction_new_partition_4620000000_4630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4630000000_4640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4630000000') TO ('4640000000');

ALTER TABLE fidc_adm.transaction_new_partition_4630000000_4640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4640000000_4650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4640000000') TO ('4650000000');

ALTER TABLE fidc_adm.transaction_new_partition_4640000000_4650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4650000000_4660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4650000000') TO ('4660000000');

ALTER TABLE fidc_adm.transaction_new_partition_4650000000_4660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4660000000_4670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4660000000') TO ('4670000000');

ALTER TABLE fidc_adm.transaction_new_partition_4660000000_4670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4670000000_4680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4670000000') TO ('4680000000');

ALTER TABLE fidc_adm.transaction_new_partition_4670000000_4680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4680000000_4690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4680000000') TO ('4690000000');

ALTER TABLE fidc_adm.transaction_new_partition_4680000000_4690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4690000000_4700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4690000000') TO ('4700000000');

ALTER TABLE fidc_adm.transaction_new_partition_4690000000_4700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4700000000_4710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4700000000') TO ('4710000000');

ALTER TABLE fidc_adm.transaction_new_partition_4700000000_4710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4710000000_4720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4710000000') TO ('4720000000');

ALTER TABLE fidc_adm.transaction_new_partition_4710000000_4720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4720000000_4730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4720000000') TO ('4730000000');

ALTER TABLE fidc_adm.transaction_new_partition_4720000000_4730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4730000000_4740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4730000000') TO ('4740000000');

ALTER TABLE fidc_adm.transaction_new_partition_4730000000_4740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4740000000_4750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4740000000') TO ('4750000000');

ALTER TABLE fidc_adm.transaction_new_partition_4740000000_4750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4750000000_4760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4750000000') TO ('4760000000');

ALTER TABLE fidc_adm.transaction_new_partition_4750000000_4760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4760000000_4770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4760000000') TO ('4770000000');

ALTER TABLE fidc_adm.transaction_new_partition_4760000000_4770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4770000000_4780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4770000000') TO ('4780000000');

ALTER TABLE fidc_adm.transaction_new_partition_4770000000_4780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4780000000_4790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4780000000') TO ('4790000000');

ALTER TABLE fidc_adm.transaction_new_partition_4780000000_4790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4790000000_4800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4790000000') TO ('4800000000');

ALTER TABLE fidc_adm.transaction_new_partition_4790000000_4800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4800000000_4810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4800000000') TO ('4810000000');

ALTER TABLE fidc_adm.transaction_new_partition_4800000000_4810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4810000000_4820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4810000000') TO ('4820000000');

ALTER TABLE fidc_adm.transaction_new_partition_4810000000_4820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4820000000_4830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4820000000') TO ('4830000000');

ALTER TABLE fidc_adm.transaction_new_partition_4820000000_4830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4830000000_4840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4830000000') TO ('4840000000');

ALTER TABLE fidc_adm.transaction_new_partition_4830000000_4840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4840000000_4850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4840000000') TO ('4850000000');

ALTER TABLE fidc_adm.transaction_new_partition_4840000000_4850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4850000000_4860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4850000000') TO ('4860000000');

ALTER TABLE fidc_adm.transaction_new_partition_4850000000_4860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4860000000_4870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4860000000') TO ('4870000000');

ALTER TABLE fidc_adm.transaction_new_partition_4860000000_4870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4870000000_4880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4870000000') TO ('4880000000');

ALTER TABLE fidc_adm.transaction_new_partition_4870000000_4880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4880000000_4890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4880000000') TO ('4890000000');

ALTER TABLE fidc_adm.transaction_new_partition_4880000000_4890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4890000000_4900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4890000000') TO ('4900000000');

ALTER TABLE fidc_adm.transaction_new_partition_4890000000_4900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4900000000_4910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4900000000') TO ('4910000000');

ALTER TABLE fidc_adm.transaction_new_partition_4900000000_4910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4910000000_4920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4910000000') TO ('4920000000');

ALTER TABLE fidc_adm.transaction_new_partition_4910000000_4920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4920000000_4930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4920000000') TO ('4930000000');

ALTER TABLE fidc_adm.transaction_new_partition_4920000000_4930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4930000000_4940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4930000000') TO ('4940000000');

ALTER TABLE fidc_adm.transaction_new_partition_4930000000_4940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4940000000_4950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4940000000') TO ('4950000000');

ALTER TABLE fidc_adm.transaction_new_partition_4940000000_4950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4950000000_4960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4950000000') TO ('4960000000');

ALTER TABLE fidc_adm.transaction_new_partition_4950000000_4960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4960000000_4970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4960000000') TO ('4970000000');

ALTER TABLE fidc_adm.transaction_new_partition_4960000000_4970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4970000000_4980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4970000000') TO ('4980000000');

ALTER TABLE fidc_adm.transaction_new_partition_4970000000_4980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4980000000_4990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4980000000') TO ('4990000000');

ALTER TABLE fidc_adm.transaction_new_partition_4980000000_4990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_4990000000_5000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('4990000000') TO ('5000000000');

ALTER TABLE fidc_adm.transaction_new_partition_4990000000_5000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5000000000_5010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5000000000') TO ('5010000000');

ALTER TABLE fidc_adm.transaction_new_partition_5000000000_5010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5010000000_5020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5010000000') TO ('5020000000');

ALTER TABLE fidc_adm.transaction_new_partition_5010000000_5020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5020000000_5030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5020000000') TO ('5030000000');

ALTER TABLE fidc_adm.transaction_new_partition_5020000000_5030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5030000000_5040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5030000000') TO ('5040000000');

ALTER TABLE fidc_adm.transaction_new_partition_5030000000_5040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5040000000_5050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5040000000') TO ('5050000000');

ALTER TABLE fidc_adm.transaction_new_partition_5040000000_5050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5050000000_5060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5050000000') TO ('5060000000');

ALTER TABLE fidc_adm.transaction_new_partition_5050000000_5060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5060000000_5070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5060000000') TO ('5070000000');

ALTER TABLE fidc_adm.transaction_new_partition_5060000000_5070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5070000000_5080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5070000000') TO ('5080000000');

ALTER TABLE fidc_adm.transaction_new_partition_5070000000_5080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5080000000_5090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5080000000') TO ('5090000000');

ALTER TABLE fidc_adm.transaction_new_partition_5080000000_5090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5090000000_5100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5090000000') TO ('5100000000');

ALTER TABLE fidc_adm.transaction_new_partition_5090000000_5100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5100000000_5110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5100000000') TO ('5110000000');

ALTER TABLE fidc_adm.transaction_new_partition_5100000000_5110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5110000000_5120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5110000000') TO ('5120000000');

ALTER TABLE fidc_adm.transaction_new_partition_5110000000_5120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5120000000_5130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5120000000') TO ('5130000000');

ALTER TABLE fidc_adm.transaction_new_partition_5120000000_5130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5130000000_5140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5130000000') TO ('5140000000');

ALTER TABLE fidc_adm.transaction_new_partition_5130000000_5140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5140000000_5150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5140000000') TO ('5150000000');

ALTER TABLE fidc_adm.transaction_new_partition_5140000000_5150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5150000000_5160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5150000000') TO ('5160000000');

ALTER TABLE fidc_adm.transaction_new_partition_5150000000_5160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5160000000_5170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5160000000') TO ('5170000000');

ALTER TABLE fidc_adm.transaction_new_partition_5160000000_5170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5170000000_5180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5170000000') TO ('5180000000');

ALTER TABLE fidc_adm.transaction_new_partition_5170000000_5180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5180000000_5190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5180000000') TO ('5190000000');

ALTER TABLE fidc_adm.transaction_new_partition_5180000000_5190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5190000000_5200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5190000000') TO ('5200000000');

ALTER TABLE fidc_adm.transaction_new_partition_5190000000_5200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5200000000_5210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5200000000') TO ('5210000000');

ALTER TABLE fidc_adm.transaction_new_partition_5200000000_5210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5210000000_5220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5210000000') TO ('5220000000');

ALTER TABLE fidc_adm.transaction_new_partition_5210000000_5220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5220000000_5230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5220000000') TO ('5230000000');

ALTER TABLE fidc_adm.transaction_new_partition_5220000000_5230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5230000000_5240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5230000000') TO ('5240000000');

ALTER TABLE fidc_adm.transaction_new_partition_5230000000_5240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5240000000_5250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5240000000') TO ('5250000000');

ALTER TABLE fidc_adm.transaction_new_partition_5240000000_5250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5250000000_5260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5250000000') TO ('5260000000');

ALTER TABLE fidc_adm.transaction_new_partition_5250000000_5260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5260000000_5270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5260000000') TO ('5270000000');

ALTER TABLE fidc_adm.transaction_new_partition_5260000000_5270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5270000000_5280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5270000000') TO ('5280000000');

ALTER TABLE fidc_adm.transaction_new_partition_5270000000_5280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5280000000_5290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5280000000') TO ('5290000000');

ALTER TABLE fidc_adm.transaction_new_partition_5280000000_5290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5290000000_5300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5290000000') TO ('5300000000');

ALTER TABLE fidc_adm.transaction_new_partition_5290000000_5300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5300000000_5310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5300000000') TO ('5310000000');

ALTER TABLE fidc_adm.transaction_new_partition_5300000000_5310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5310000000_5320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5310000000') TO ('5320000000');

ALTER TABLE fidc_adm.transaction_new_partition_5310000000_5320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5320000000_5330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5320000000') TO ('5330000000');

ALTER TABLE fidc_adm.transaction_new_partition_5320000000_5330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5330000000_5340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5330000000') TO ('5340000000');

ALTER TABLE fidc_adm.transaction_new_partition_5330000000_5340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5340000000_5350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5340000000') TO ('5350000000');

ALTER TABLE fidc_adm.transaction_new_partition_5340000000_5350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5350000000_5360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5350000000') TO ('5360000000');

ALTER TABLE fidc_adm.transaction_new_partition_5350000000_5360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5360000000_5370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5360000000') TO ('5370000000');

ALTER TABLE fidc_adm.transaction_new_partition_5360000000_5370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5370000000_5380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5370000000') TO ('5380000000');

ALTER TABLE fidc_adm.transaction_new_partition_5370000000_5380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5380000000_5390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5380000000') TO ('5390000000');

ALTER TABLE fidc_adm.transaction_new_partition_5380000000_5390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5390000000_5400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5390000000') TO ('5400000000');

ALTER TABLE fidc_adm.transaction_new_partition_5390000000_5400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5400000000_5410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5400000000') TO ('5410000000');

ALTER TABLE fidc_adm.transaction_new_partition_5400000000_5410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5410000000_5420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5410000000') TO ('5420000000');

ALTER TABLE fidc_adm.transaction_new_partition_5410000000_5420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5420000000_5430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5420000000') TO ('5430000000');

ALTER TABLE fidc_adm.transaction_new_partition_5420000000_5430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5430000000_5440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5430000000') TO ('5440000000');

ALTER TABLE fidc_adm.transaction_new_partition_5430000000_5440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5440000000_5450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5440000000') TO ('5450000000');

ALTER TABLE fidc_adm.transaction_new_partition_5440000000_5450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5450000000_5460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5450000000') TO ('5460000000');

ALTER TABLE fidc_adm.transaction_new_partition_5450000000_5460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5460000000_5470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5460000000') TO ('5470000000');

ALTER TABLE fidc_adm.transaction_new_partition_5460000000_5470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5470000000_5480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5470000000') TO ('5480000000');

ALTER TABLE fidc_adm.transaction_new_partition_5470000000_5480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5480000000_5490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5480000000') TO ('5490000000');

ALTER TABLE fidc_adm.transaction_new_partition_5480000000_5490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5490000000_5500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5490000000') TO ('5500000000');

ALTER TABLE fidc_adm.transaction_new_partition_5490000000_5500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5500000000_5510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5500000000') TO ('5510000000');

ALTER TABLE fidc_adm.transaction_new_partition_5500000000_5510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5510000000_5520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5510000000') TO ('5520000000');

ALTER TABLE fidc_adm.transaction_new_partition_5510000000_5520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5520000000_5530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5520000000') TO ('5530000000');

ALTER TABLE fidc_adm.transaction_new_partition_5520000000_5530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5530000000_5540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5530000000') TO ('5540000000');

ALTER TABLE fidc_adm.transaction_new_partition_5530000000_5540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5540000000_5550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5540000000') TO ('5550000000');

ALTER TABLE fidc_adm.transaction_new_partition_5540000000_5550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5550000000_5560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5550000000') TO ('5560000000');

ALTER TABLE fidc_adm.transaction_new_partition_5550000000_5560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5560000000_5570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5560000000') TO ('5570000000');

ALTER TABLE fidc_adm.transaction_new_partition_5560000000_5570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5570000000_5580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5570000000') TO ('5580000000');

ALTER TABLE fidc_adm.transaction_new_partition_5570000000_5580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5580000000_5590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5580000000') TO ('5590000000');

ALTER TABLE fidc_adm.transaction_new_partition_5580000000_5590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5590000000_5600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5590000000') TO ('5600000000');

ALTER TABLE fidc_adm.transaction_new_partition_5590000000_5600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5600000000_5610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5600000000') TO ('5610000000');

ALTER TABLE fidc_adm.transaction_new_partition_5600000000_5610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5610000000_5620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5610000000') TO ('5620000000');

ALTER TABLE fidc_adm.transaction_new_partition_5610000000_5620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5620000000_5630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5620000000') TO ('5630000000');

ALTER TABLE fidc_adm.transaction_new_partition_5620000000_5630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5630000000_5640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5630000000') TO ('5640000000');

ALTER TABLE fidc_adm.transaction_new_partition_5630000000_5640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5640000000_5650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5640000000') TO ('5650000000');

ALTER TABLE fidc_adm.transaction_new_partition_5640000000_5650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5650000000_5660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5650000000') TO ('5660000000');

ALTER TABLE fidc_adm.transaction_new_partition_5650000000_5660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5660000000_5670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5660000000') TO ('5670000000');

ALTER TABLE fidc_adm.transaction_new_partition_5660000000_5670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5670000000_5680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5670000000') TO ('5680000000');

ALTER TABLE fidc_adm.transaction_new_partition_5670000000_5680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5680000000_5690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5680000000') TO ('5690000000');

ALTER TABLE fidc_adm.transaction_new_partition_5680000000_5690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5690000000_5700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5690000000') TO ('5700000000');

ALTER TABLE fidc_adm.transaction_new_partition_5690000000_5700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5700000000_5710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5700000000') TO ('5710000000');

ALTER TABLE fidc_adm.transaction_new_partition_5700000000_5710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5710000000_5720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5710000000') TO ('5720000000');

ALTER TABLE fidc_adm.transaction_new_partition_5710000000_5720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5720000000_5730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5720000000') TO ('5730000000');

ALTER TABLE fidc_adm.transaction_new_partition_5720000000_5730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5730000000_5740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5730000000') TO ('5740000000');

ALTER TABLE fidc_adm.transaction_new_partition_5730000000_5740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5740000000_5750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5740000000') TO ('5750000000');

ALTER TABLE fidc_adm.transaction_new_partition_5740000000_5750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5750000000_5760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5750000000') TO ('5760000000');

ALTER TABLE fidc_adm.transaction_new_partition_5750000000_5760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5760000000_5770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5760000000') TO ('5770000000');

ALTER TABLE fidc_adm.transaction_new_partition_5760000000_5770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5770000000_5780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5770000000') TO ('5780000000');

ALTER TABLE fidc_adm.transaction_new_partition_5770000000_5780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5780000000_5790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5780000000') TO ('5790000000');

ALTER TABLE fidc_adm.transaction_new_partition_5780000000_5790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5790000000_5800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5790000000') TO ('5800000000');

ALTER TABLE fidc_adm.transaction_new_partition_5790000000_5800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5800000000_5810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5800000000') TO ('5810000000');

ALTER TABLE fidc_adm.transaction_new_partition_5800000000_5810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5810000000_5820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5810000000') TO ('5820000000');

ALTER TABLE fidc_adm.transaction_new_partition_5810000000_5820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5820000000_5830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5820000000') TO ('5830000000');

ALTER TABLE fidc_adm.transaction_new_partition_5820000000_5830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5830000000_5840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5830000000') TO ('5840000000');

ALTER TABLE fidc_adm.transaction_new_partition_5830000000_5840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5840000000_5850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5840000000') TO ('5850000000');

ALTER TABLE fidc_adm.transaction_new_partition_5840000000_5850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5850000000_5860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5850000000') TO ('5860000000');

ALTER TABLE fidc_adm.transaction_new_partition_5850000000_5860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5860000000_5870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5860000000') TO ('5870000000');

ALTER TABLE fidc_adm.transaction_new_partition_5860000000_5870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5870000000_5880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5870000000') TO ('5880000000');

ALTER TABLE fidc_adm.transaction_new_partition_5870000000_5880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5880000000_5890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5880000000') TO ('5890000000');

ALTER TABLE fidc_adm.transaction_new_partition_5880000000_5890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5890000000_5900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5890000000') TO ('5900000000');

ALTER TABLE fidc_adm.transaction_new_partition_5890000000_5900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5900000000_5910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5900000000') TO ('5910000000');

ALTER TABLE fidc_adm.transaction_new_partition_5900000000_5910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5910000000_5920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5910000000') TO ('5920000000');

ALTER TABLE fidc_adm.transaction_new_partition_5910000000_5920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5920000000_5930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5920000000') TO ('5930000000');

ALTER TABLE fidc_adm.transaction_new_partition_5920000000_5930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5930000000_5940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5930000000') TO ('5940000000');

ALTER TABLE fidc_adm.transaction_new_partition_5930000000_5940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5940000000_5950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5940000000') TO ('5950000000');

ALTER TABLE fidc_adm.transaction_new_partition_5940000000_5950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5950000000_5960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5950000000') TO ('5960000000');

ALTER TABLE fidc_adm.transaction_new_partition_5950000000_5960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5960000000_5970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5960000000') TO ('5970000000');

ALTER TABLE fidc_adm.transaction_new_partition_5960000000_5970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5970000000_5980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5970000000') TO ('5980000000');

ALTER TABLE fidc_adm.transaction_new_partition_5970000000_5980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5980000000_5990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5980000000') TO ('5990000000');

ALTER TABLE fidc_adm.transaction_new_partition_5980000000_5990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_5990000000_6000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('5990000000') TO ('6000000000');

ALTER TABLE fidc_adm.transaction_new_partition_5990000000_6000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6000000000_6010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6000000000') TO ('6010000000');

ALTER TABLE fidc_adm.transaction_new_partition_6000000000_6010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6010000000_6020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6010000000') TO ('6020000000');

ALTER TABLE fidc_adm.transaction_new_partition_6010000000_6020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6020000000_6030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6020000000') TO ('6030000000');

ALTER TABLE fidc_adm.transaction_new_partition_6020000000_6030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6030000000_6040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6030000000') TO ('6040000000');

ALTER TABLE fidc_adm.transaction_new_partition_6030000000_6040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6040000000_6050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6040000000') TO ('6050000000');

ALTER TABLE fidc_adm.transaction_new_partition_6040000000_6050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6050000000_6060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6050000000') TO ('6060000000');

ALTER TABLE fidc_adm.transaction_new_partition_6050000000_6060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6060000000_6070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6060000000') TO ('6070000000');

ALTER TABLE fidc_adm.transaction_new_partition_6060000000_6070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6070000000_6080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6070000000') TO ('6080000000');

ALTER TABLE fidc_adm.transaction_new_partition_6070000000_6080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6080000000_6090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6080000000') TO ('6090000000');

ALTER TABLE fidc_adm.transaction_new_partition_6080000000_6090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6090000000_6100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6090000000') TO ('6100000000');

ALTER TABLE fidc_adm.transaction_new_partition_6090000000_6100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6100000000_6110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6100000000') TO ('6110000000');

ALTER TABLE fidc_adm.transaction_new_partition_6100000000_6110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6110000000_6120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6110000000') TO ('6120000000');

ALTER TABLE fidc_adm.transaction_new_partition_6110000000_6120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6120000000_6130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6120000000') TO ('6130000000');

ALTER TABLE fidc_adm.transaction_new_partition_6120000000_6130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6130000000_6140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6130000000') TO ('6140000000');

ALTER TABLE fidc_adm.transaction_new_partition_6130000000_6140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6140000000_6150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6140000000') TO ('6150000000');

ALTER TABLE fidc_adm.transaction_new_partition_6140000000_6150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6150000000_6160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6150000000') TO ('6160000000');

ALTER TABLE fidc_adm.transaction_new_partition_6150000000_6160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6160000000_6170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6160000000') TO ('6170000000');

ALTER TABLE fidc_adm.transaction_new_partition_6160000000_6170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6170000000_6180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6170000000') TO ('6180000000');

ALTER TABLE fidc_adm.transaction_new_partition_6170000000_6180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6180000000_6190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6180000000') TO ('6190000000');

ALTER TABLE fidc_adm.transaction_new_partition_6180000000_6190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6190000000_6200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6190000000') TO ('6200000000');

ALTER TABLE fidc_adm.transaction_new_partition_6190000000_6200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6200000000_6210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6200000000') TO ('6210000000');

ALTER TABLE fidc_adm.transaction_new_partition_6200000000_6210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6210000000_6220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6210000000') TO ('6220000000');

ALTER TABLE fidc_adm.transaction_new_partition_6210000000_6220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6220000000_6230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6220000000') TO ('6230000000');

ALTER TABLE fidc_adm.transaction_new_partition_6220000000_6230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6230000000_6240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6230000000') TO ('6240000000');

ALTER TABLE fidc_adm.transaction_new_partition_6230000000_6240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6240000000_6250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6240000000') TO ('6250000000');

ALTER TABLE fidc_adm.transaction_new_partition_6240000000_6250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6250000000_6260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6250000000') TO ('6260000000');

ALTER TABLE fidc_adm.transaction_new_partition_6250000000_6260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6260000000_6270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6260000000') TO ('6270000000');

ALTER TABLE fidc_adm.transaction_new_partition_6260000000_6270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6270000000_6280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6270000000') TO ('6280000000');

ALTER TABLE fidc_adm.transaction_new_partition_6270000000_6280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6280000000_6290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6280000000') TO ('6290000000');

ALTER TABLE fidc_adm.transaction_new_partition_6280000000_6290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6290000000_6300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6290000000') TO ('6300000000');

ALTER TABLE fidc_adm.transaction_new_partition_6290000000_6300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6300000000_6310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6300000000') TO ('6310000000');

ALTER TABLE fidc_adm.transaction_new_partition_6300000000_6310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6310000000_6320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6310000000') TO ('6320000000');

ALTER TABLE fidc_adm.transaction_new_partition_6310000000_6320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6320000000_6330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6320000000') TO ('6330000000');

ALTER TABLE fidc_adm.transaction_new_partition_6320000000_6330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6330000000_6340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6330000000') TO ('6340000000');

ALTER TABLE fidc_adm.transaction_new_partition_6330000000_6340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6340000000_6350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6340000000') TO ('6350000000');

ALTER TABLE fidc_adm.transaction_new_partition_6340000000_6350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6350000000_6360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6350000000') TO ('6360000000');

ALTER TABLE fidc_adm.transaction_new_partition_6350000000_6360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6360000000_6370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6360000000') TO ('6370000000');

ALTER TABLE fidc_adm.transaction_new_partition_6360000000_6370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6370000000_6380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6370000000') TO ('6380000000');

ALTER TABLE fidc_adm.transaction_new_partition_6370000000_6380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6380000000_6390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6380000000') TO ('6390000000');

ALTER TABLE fidc_adm.transaction_new_partition_6380000000_6390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6390000000_6400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6390000000') TO ('6400000000');

ALTER TABLE fidc_adm.transaction_new_partition_6390000000_6400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6400000000_6410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6400000000') TO ('6410000000');

ALTER TABLE fidc_adm.transaction_new_partition_6400000000_6410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6410000000_6420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6410000000') TO ('6420000000');

ALTER TABLE fidc_adm.transaction_new_partition_6410000000_6420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6420000000_6430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6420000000') TO ('6430000000');

ALTER TABLE fidc_adm.transaction_new_partition_6420000000_6430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6430000000_6440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6430000000') TO ('6440000000');

ALTER TABLE fidc_adm.transaction_new_partition_6430000000_6440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6440000000_6450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6440000000') TO ('6450000000');

ALTER TABLE fidc_adm.transaction_new_partition_6440000000_6450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6450000000_6460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6450000000') TO ('6460000000');

ALTER TABLE fidc_adm.transaction_new_partition_6450000000_6460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6460000000_6470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6460000000') TO ('6470000000');

ALTER TABLE fidc_adm.transaction_new_partition_6460000000_6470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6470000000_6480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6470000000') TO ('6480000000');

ALTER TABLE fidc_adm.transaction_new_partition_6470000000_6480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6480000000_6490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6480000000') TO ('6490000000');

ALTER TABLE fidc_adm.transaction_new_partition_6480000000_6490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6490000000_6500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6490000000') TO ('6500000000');

ALTER TABLE fidc_adm.transaction_new_partition_6490000000_6500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6500000000_6510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6500000000') TO ('6510000000');

ALTER TABLE fidc_adm.transaction_new_partition_6500000000_6510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6510000000_6520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6510000000') TO ('6520000000');

ALTER TABLE fidc_adm.transaction_new_partition_6510000000_6520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6520000000_6530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6520000000') TO ('6530000000');

ALTER TABLE fidc_adm.transaction_new_partition_6520000000_6530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6530000000_6540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6530000000') TO ('6540000000');

ALTER TABLE fidc_adm.transaction_new_partition_6530000000_6540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6540000000_6550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6540000000') TO ('6550000000');

ALTER TABLE fidc_adm.transaction_new_partition_6540000000_6550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6550000000_6560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6550000000') TO ('6560000000');

ALTER TABLE fidc_adm.transaction_new_partition_6550000000_6560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6560000000_6570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6560000000') TO ('6570000000');

ALTER TABLE fidc_adm.transaction_new_partition_6560000000_6570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6570000000_6580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6570000000') TO ('6580000000');

ALTER TABLE fidc_adm.transaction_new_partition_6570000000_6580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6580000000_6590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6580000000') TO ('6590000000');

ALTER TABLE fidc_adm.transaction_new_partition_6580000000_6590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6590000000_6600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6590000000') TO ('6600000000');

ALTER TABLE fidc_adm.transaction_new_partition_6590000000_6600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6600000000_6610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6600000000') TO ('6610000000');

ALTER TABLE fidc_adm.transaction_new_partition_6600000000_6610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6610000000_6620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6610000000') TO ('6620000000');

ALTER TABLE fidc_adm.transaction_new_partition_6610000000_6620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6620000000_6630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6620000000') TO ('6630000000');

ALTER TABLE fidc_adm.transaction_new_partition_6620000000_6630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6630000000_6640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6630000000') TO ('6640000000');

ALTER TABLE fidc_adm.transaction_new_partition_6630000000_6640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6640000000_6650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6640000000') TO ('6650000000');

ALTER TABLE fidc_adm.transaction_new_partition_6640000000_6650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6650000000_6660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6650000000') TO ('6660000000');

ALTER TABLE fidc_adm.transaction_new_partition_6650000000_6660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6660000000_6670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6660000000') TO ('6670000000');

ALTER TABLE fidc_adm.transaction_new_partition_6660000000_6670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6670000000_6680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6670000000') TO ('6680000000');

ALTER TABLE fidc_adm.transaction_new_partition_6670000000_6680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6680000000_6690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6680000000') TO ('6690000000');

ALTER TABLE fidc_adm.transaction_new_partition_6680000000_6690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6690000000_6700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6690000000') TO ('6700000000');

ALTER TABLE fidc_adm.transaction_new_partition_6690000000_6700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6700000000_6710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6700000000') TO ('6710000000');

ALTER TABLE fidc_adm.transaction_new_partition_6700000000_6710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6710000000_6720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6710000000') TO ('6720000000');

ALTER TABLE fidc_adm.transaction_new_partition_6710000000_6720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6720000000_6730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6720000000') TO ('6730000000');

ALTER TABLE fidc_adm.transaction_new_partition_6720000000_6730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6730000000_6740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6730000000') TO ('6740000000');

ALTER TABLE fidc_adm.transaction_new_partition_6730000000_6740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6740000000_6750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6740000000') TO ('6750000000');

ALTER TABLE fidc_adm.transaction_new_partition_6740000000_6750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6750000000_6760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6750000000') TO ('6760000000');

ALTER TABLE fidc_adm.transaction_new_partition_6750000000_6760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6760000000_6770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6760000000') TO ('6770000000');

ALTER TABLE fidc_adm.transaction_new_partition_6760000000_6770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6770000000_6780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6770000000') TO ('6780000000');

ALTER TABLE fidc_adm.transaction_new_partition_6770000000_6780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6780000000_6790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6780000000') TO ('6790000000');

ALTER TABLE fidc_adm.transaction_new_partition_6780000000_6790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6790000000_6800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6790000000') TO ('6800000000');

ALTER TABLE fidc_adm.transaction_new_partition_6790000000_6800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6800000000_6810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6800000000') TO ('6810000000');

ALTER TABLE fidc_adm.transaction_new_partition_6800000000_6810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6810000000_6820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6810000000') TO ('6820000000');

ALTER TABLE fidc_adm.transaction_new_partition_6810000000_6820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6820000000_6830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6820000000') TO ('6830000000');

ALTER TABLE fidc_adm.transaction_new_partition_6820000000_6830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6830000000_6840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6830000000') TO ('6840000000');

ALTER TABLE fidc_adm.transaction_new_partition_6830000000_6840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6840000000_6850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6840000000') TO ('6850000000');

ALTER TABLE fidc_adm.transaction_new_partition_6840000000_6850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6850000000_6860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6850000000') TO ('6860000000');

ALTER TABLE fidc_adm.transaction_new_partition_6850000000_6860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6860000000_6870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6860000000') TO ('6870000000');

ALTER TABLE fidc_adm.transaction_new_partition_6860000000_6870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6870000000_6880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6870000000') TO ('6880000000');

ALTER TABLE fidc_adm.transaction_new_partition_6870000000_6880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6880000000_6890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6880000000') TO ('6890000000');

ALTER TABLE fidc_adm.transaction_new_partition_6880000000_6890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6890000000_6900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6890000000') TO ('6900000000');

ALTER TABLE fidc_adm.transaction_new_partition_6890000000_6900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6900000000_6910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6900000000') TO ('6910000000');

ALTER TABLE fidc_adm.transaction_new_partition_6900000000_6910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6910000000_6920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6910000000') TO ('6920000000');

ALTER TABLE fidc_adm.transaction_new_partition_6910000000_6920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6920000000_6930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6920000000') TO ('6930000000');

ALTER TABLE fidc_adm.transaction_new_partition_6920000000_6930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6930000000_6940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6930000000') TO ('6940000000');

ALTER TABLE fidc_adm.transaction_new_partition_6930000000_6940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6940000000_6950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6940000000') TO ('6950000000');

ALTER TABLE fidc_adm.transaction_new_partition_6940000000_6950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6950000000_6960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6950000000') TO ('6960000000');

ALTER TABLE fidc_adm.transaction_new_partition_6950000000_6960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6960000000_6970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6960000000') TO ('6970000000');

ALTER TABLE fidc_adm.transaction_new_partition_6960000000_6970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6970000000_6980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6970000000') TO ('6980000000');

ALTER TABLE fidc_adm.transaction_new_partition_6970000000_6980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6980000000_6990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6980000000') TO ('6990000000');

ALTER TABLE fidc_adm.transaction_new_partition_6980000000_6990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_6990000000_7000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('6990000000') TO ('7000000000');

ALTER TABLE fidc_adm.transaction_new_partition_6990000000_7000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7000000000_7010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7000000000') TO ('7010000000');

ALTER TABLE fidc_adm.transaction_new_partition_7000000000_7010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7010000000_7020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7010000000') TO ('7020000000');

ALTER TABLE fidc_adm.transaction_new_partition_7010000000_7020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7020000000_7030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7020000000') TO ('7030000000');

ALTER TABLE fidc_adm.transaction_new_partition_7020000000_7030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7030000000_7040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7030000000') TO ('7040000000');

ALTER TABLE fidc_adm.transaction_new_partition_7030000000_7040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7040000000_7050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7040000000') TO ('7050000000');

ALTER TABLE fidc_adm.transaction_new_partition_7040000000_7050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7050000000_7060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7050000000') TO ('7060000000');

ALTER TABLE fidc_adm.transaction_new_partition_7050000000_7060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7060000000_7070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7060000000') TO ('7070000000');

ALTER TABLE fidc_adm.transaction_new_partition_7060000000_7070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7070000000_7080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7070000000') TO ('7080000000');

ALTER TABLE fidc_adm.transaction_new_partition_7070000000_7080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7080000000_7090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7080000000') TO ('7090000000');

ALTER TABLE fidc_adm.transaction_new_partition_7080000000_7090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7090000000_7100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7090000000') TO ('7100000000');

ALTER TABLE fidc_adm.transaction_new_partition_7090000000_7100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7100000000_7110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7100000000') TO ('7110000000');

ALTER TABLE fidc_adm.transaction_new_partition_7100000000_7110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7110000000_7120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7110000000') TO ('7120000000');

ALTER TABLE fidc_adm.transaction_new_partition_7110000000_7120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7120000000_7130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7120000000') TO ('7130000000');

ALTER TABLE fidc_adm.transaction_new_partition_7120000000_7130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7130000000_7140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7130000000') TO ('7140000000');

ALTER TABLE fidc_adm.transaction_new_partition_7130000000_7140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7140000000_7150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7140000000') TO ('7150000000');

ALTER TABLE fidc_adm.transaction_new_partition_7140000000_7150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7150000000_7160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7150000000') TO ('7160000000');

ALTER TABLE fidc_adm.transaction_new_partition_7150000000_7160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7160000000_7170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7160000000') TO ('7170000000');

ALTER TABLE fidc_adm.transaction_new_partition_7160000000_7170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7170000000_7180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7170000000') TO ('7180000000');

ALTER TABLE fidc_adm.transaction_new_partition_7170000000_7180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7180000000_7190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7180000000') TO ('7190000000');

ALTER TABLE fidc_adm.transaction_new_partition_7180000000_7190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7190000000_7200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7190000000') TO ('7200000000');

ALTER TABLE fidc_adm.transaction_new_partition_7190000000_7200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7200000000_7210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7200000000') TO ('7210000000');

ALTER TABLE fidc_adm.transaction_new_partition_7200000000_7210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7210000000_7220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7210000000') TO ('7220000000');

ALTER TABLE fidc_adm.transaction_new_partition_7210000000_7220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7220000000_7230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7220000000') TO ('7230000000');

ALTER TABLE fidc_adm.transaction_new_partition_7220000000_7230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7230000000_7240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7230000000') TO ('7240000000');

ALTER TABLE fidc_adm.transaction_new_partition_7230000000_7240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7240000000_7250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7240000000') TO ('7250000000');

ALTER TABLE fidc_adm.transaction_new_partition_7240000000_7250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7250000000_7260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7250000000') TO ('7260000000');

ALTER TABLE fidc_adm.transaction_new_partition_7250000000_7260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7260000000_7270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7260000000') TO ('7270000000');

ALTER TABLE fidc_adm.transaction_new_partition_7260000000_7270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7270000000_7280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7270000000') TO ('7280000000');

ALTER TABLE fidc_adm.transaction_new_partition_7270000000_7280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7280000000_7290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7280000000') TO ('7290000000');

ALTER TABLE fidc_adm.transaction_new_partition_7280000000_7290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7290000000_7300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7290000000') TO ('7300000000');

ALTER TABLE fidc_adm.transaction_new_partition_7290000000_7300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7300000000_7310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7300000000') TO ('7310000000');

ALTER TABLE fidc_adm.transaction_new_partition_7300000000_7310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7310000000_7320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7310000000') TO ('7320000000');

ALTER TABLE fidc_adm.transaction_new_partition_7310000000_7320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7320000000_7330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7320000000') TO ('7330000000');

ALTER TABLE fidc_adm.transaction_new_partition_7320000000_7330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7330000000_7340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7330000000') TO ('7340000000');

ALTER TABLE fidc_adm.transaction_new_partition_7330000000_7340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7340000000_7350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7340000000') TO ('7350000000');

ALTER TABLE fidc_adm.transaction_new_partition_7340000000_7350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7350000000_7360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7350000000') TO ('7360000000');

ALTER TABLE fidc_adm.transaction_new_partition_7350000000_7360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7360000000_7370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7360000000') TO ('7370000000');

ALTER TABLE fidc_adm.transaction_new_partition_7360000000_7370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7370000000_7380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7370000000') TO ('7380000000');

ALTER TABLE fidc_adm.transaction_new_partition_7370000000_7380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7380000000_7390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7380000000') TO ('7390000000');

ALTER TABLE fidc_adm.transaction_new_partition_7380000000_7390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7390000000_7400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7390000000') TO ('7400000000');

ALTER TABLE fidc_adm.transaction_new_partition_7390000000_7400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7400000000_7410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7400000000') TO ('7410000000');

ALTER TABLE fidc_adm.transaction_new_partition_7400000000_7410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7410000000_7420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7410000000') TO ('7420000000');

ALTER TABLE fidc_adm.transaction_new_partition_7410000000_7420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7420000000_7430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7420000000') TO ('7430000000');

ALTER TABLE fidc_adm.transaction_new_partition_7420000000_7430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7430000000_7440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7430000000') TO ('7440000000');

ALTER TABLE fidc_adm.transaction_new_partition_7430000000_7440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7440000000_7450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7440000000') TO ('7450000000');

ALTER TABLE fidc_adm.transaction_new_partition_7440000000_7450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7450000000_7460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7450000000') TO ('7460000000');

ALTER TABLE fidc_adm.transaction_new_partition_7450000000_7460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7460000000_7470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7460000000') TO ('7470000000');

ALTER TABLE fidc_adm.transaction_new_partition_7460000000_7470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7470000000_7480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7470000000') TO ('7480000000');

ALTER TABLE fidc_adm.transaction_new_partition_7470000000_7480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7480000000_7490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7480000000') TO ('7490000000');

ALTER TABLE fidc_adm.transaction_new_partition_7480000000_7490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7490000000_7500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7490000000') TO ('7500000000');

ALTER TABLE fidc_adm.transaction_new_partition_7490000000_7500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7500000000_7510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7500000000') TO ('7510000000');

ALTER TABLE fidc_adm.transaction_new_partition_7500000000_7510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7510000000_7520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7510000000') TO ('7520000000');

ALTER TABLE fidc_adm.transaction_new_partition_7510000000_7520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7520000000_7530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7520000000') TO ('7530000000');

ALTER TABLE fidc_adm.transaction_new_partition_7520000000_7530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7530000000_7540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7530000000') TO ('7540000000');

ALTER TABLE fidc_adm.transaction_new_partition_7530000000_7540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7540000000_7550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7540000000') TO ('7550000000');

ALTER TABLE fidc_adm.transaction_new_partition_7540000000_7550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7550000000_7560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7550000000') TO ('7560000000');

ALTER TABLE fidc_adm.transaction_new_partition_7550000000_7560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7560000000_7570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7560000000') TO ('7570000000');

ALTER TABLE fidc_adm.transaction_new_partition_7560000000_7570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7570000000_7580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7570000000') TO ('7580000000');

ALTER TABLE fidc_adm.transaction_new_partition_7570000000_7580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7580000000_7590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7580000000') TO ('7590000000');

ALTER TABLE fidc_adm.transaction_new_partition_7580000000_7590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7590000000_7600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7590000000') TO ('7600000000');

ALTER TABLE fidc_adm.transaction_new_partition_7590000000_7600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7600000000_7610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7600000000') TO ('7610000000');

ALTER TABLE fidc_adm.transaction_new_partition_7600000000_7610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7610000000_7620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7610000000') TO ('7620000000');

ALTER TABLE fidc_adm.transaction_new_partition_7610000000_7620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7620000000_7630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7620000000') TO ('7630000000');

ALTER TABLE fidc_adm.transaction_new_partition_7620000000_7630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7630000000_7640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7630000000') TO ('7640000000');

ALTER TABLE fidc_adm.transaction_new_partition_7630000000_7640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7640000000_7650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7640000000') TO ('7650000000');

ALTER TABLE fidc_adm.transaction_new_partition_7640000000_7650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7650000000_7660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7650000000') TO ('7660000000');

ALTER TABLE fidc_adm.transaction_new_partition_7650000000_7660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7660000000_7670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7660000000') TO ('7670000000');

ALTER TABLE fidc_adm.transaction_new_partition_7660000000_7670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7670000000_7680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7670000000') TO ('7680000000');

ALTER TABLE fidc_adm.transaction_new_partition_7670000000_7680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7680000000_7690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7680000000') TO ('7690000000');

ALTER TABLE fidc_adm.transaction_new_partition_7680000000_7690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7690000000_7700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7690000000') TO ('7700000000');

ALTER TABLE fidc_adm.transaction_new_partition_7690000000_7700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7700000000_7710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7700000000') TO ('7710000000');

ALTER TABLE fidc_adm.transaction_new_partition_7700000000_7710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7710000000_7720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7710000000') TO ('7720000000');

ALTER TABLE fidc_adm.transaction_new_partition_7710000000_7720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7720000000_7730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7720000000') TO ('7730000000');

ALTER TABLE fidc_adm.transaction_new_partition_7720000000_7730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7730000000_7740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7730000000') TO ('7740000000');

ALTER TABLE fidc_adm.transaction_new_partition_7730000000_7740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7740000000_7750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7740000000') TO ('7750000000');

ALTER TABLE fidc_adm.transaction_new_partition_7740000000_7750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7750000000_7760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7750000000') TO ('7760000000');

ALTER TABLE fidc_adm.transaction_new_partition_7750000000_7760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7760000000_7770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7760000000') TO ('7770000000');

ALTER TABLE fidc_adm.transaction_new_partition_7760000000_7770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7770000000_7780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7770000000') TO ('7780000000');

ALTER TABLE fidc_adm.transaction_new_partition_7770000000_7780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7780000000_7790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7780000000') TO ('7790000000');

ALTER TABLE fidc_adm.transaction_new_partition_7780000000_7790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7790000000_7800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7790000000') TO ('7800000000');

ALTER TABLE fidc_adm.transaction_new_partition_7790000000_7800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7800000000_7810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7800000000') TO ('7810000000');

ALTER TABLE fidc_adm.transaction_new_partition_7800000000_7810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7810000000_7820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7810000000') TO ('7820000000');

ALTER TABLE fidc_adm.transaction_new_partition_7810000000_7820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7820000000_7830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7820000000') TO ('7830000000');

ALTER TABLE fidc_adm.transaction_new_partition_7820000000_7830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7830000000_7840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7830000000') TO ('7840000000');

ALTER TABLE fidc_adm.transaction_new_partition_7830000000_7840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7840000000_7850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7840000000') TO ('7850000000');

ALTER TABLE fidc_adm.transaction_new_partition_7840000000_7850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7850000000_7860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7850000000') TO ('7860000000');

ALTER TABLE fidc_adm.transaction_new_partition_7850000000_7860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7860000000_7870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7860000000') TO ('7870000000');

ALTER TABLE fidc_adm.transaction_new_partition_7860000000_7870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7870000000_7880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7870000000') TO ('7880000000');

ALTER TABLE fidc_adm.transaction_new_partition_7870000000_7880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7880000000_7890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7880000000') TO ('7890000000');

ALTER TABLE fidc_adm.transaction_new_partition_7880000000_7890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7890000000_7900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7890000000') TO ('7900000000');

ALTER TABLE fidc_adm.transaction_new_partition_7890000000_7900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7900000000_7910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7900000000') TO ('7910000000');

ALTER TABLE fidc_adm.transaction_new_partition_7900000000_7910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7910000000_7920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7910000000') TO ('7920000000');

ALTER TABLE fidc_adm.transaction_new_partition_7910000000_7920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7920000000_7930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7920000000') TO ('7930000000');

ALTER TABLE fidc_adm.transaction_new_partition_7920000000_7930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7930000000_7940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7930000000') TO ('7940000000');

ALTER TABLE fidc_adm.transaction_new_partition_7930000000_7940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7940000000_7950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7940000000') TO ('7950000000');

ALTER TABLE fidc_adm.transaction_new_partition_7940000000_7950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7950000000_7960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7950000000') TO ('7960000000');

ALTER TABLE fidc_adm.transaction_new_partition_7950000000_7960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7960000000_7970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7960000000') TO ('7970000000');

ALTER TABLE fidc_adm.transaction_new_partition_7960000000_7970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7970000000_7980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7970000000') TO ('7980000000');

ALTER TABLE fidc_adm.transaction_new_partition_7970000000_7980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7980000000_7990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7980000000') TO ('7990000000');

ALTER TABLE fidc_adm.transaction_new_partition_7980000000_7990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_7990000000_8000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('7990000000') TO ('8000000000');

ALTER TABLE fidc_adm.transaction_new_partition_7990000000_8000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8000000000_8010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8000000000') TO ('8010000000');

ALTER TABLE fidc_adm.transaction_new_partition_8000000000_8010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8010000000_8020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8010000000') TO ('8020000000');

ALTER TABLE fidc_adm.transaction_new_partition_8010000000_8020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8020000000_8030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8020000000') TO ('8030000000');

ALTER TABLE fidc_adm.transaction_new_partition_8020000000_8030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8030000000_8040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8030000000') TO ('8040000000');

ALTER TABLE fidc_adm.transaction_new_partition_8030000000_8040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8040000000_8050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8040000000') TO ('8050000000');

ALTER TABLE fidc_adm.transaction_new_partition_8040000000_8050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8050000000_8060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8050000000') TO ('8060000000');

ALTER TABLE fidc_adm.transaction_new_partition_8050000000_8060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8060000000_8070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8060000000') TO ('8070000000');

ALTER TABLE fidc_adm.transaction_new_partition_8060000000_8070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8070000000_8080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8070000000') TO ('8080000000');

ALTER TABLE fidc_adm.transaction_new_partition_8070000000_8080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8080000000_8090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8080000000') TO ('8090000000');

ALTER TABLE fidc_adm.transaction_new_partition_8080000000_8090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8090000000_8100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8090000000') TO ('8100000000');

ALTER TABLE fidc_adm.transaction_new_partition_8090000000_8100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8100000000_8110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8100000000') TO ('8110000000');

ALTER TABLE fidc_adm.transaction_new_partition_8100000000_8110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8110000000_8120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8110000000') TO ('8120000000');

ALTER TABLE fidc_adm.transaction_new_partition_8110000000_8120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8120000000_8130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8120000000') TO ('8130000000');

ALTER TABLE fidc_adm.transaction_new_partition_8120000000_8130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8130000000_8140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8130000000') TO ('8140000000');

ALTER TABLE fidc_adm.transaction_new_partition_8130000000_8140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8140000000_8150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8140000000') TO ('8150000000');

ALTER TABLE fidc_adm.transaction_new_partition_8140000000_8150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8150000000_8160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8150000000') TO ('8160000000');

ALTER TABLE fidc_adm.transaction_new_partition_8150000000_8160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8160000000_8170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8160000000') TO ('8170000000');

ALTER TABLE fidc_adm.transaction_new_partition_8160000000_8170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8170000000_8180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8170000000') TO ('8180000000');

ALTER TABLE fidc_adm.transaction_new_partition_8170000000_8180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8180000000_8190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8180000000') TO ('8190000000');

ALTER TABLE fidc_adm.transaction_new_partition_8180000000_8190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8190000000_8200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8190000000') TO ('8200000000');

ALTER TABLE fidc_adm.transaction_new_partition_8190000000_8200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8200000000_8210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8200000000') TO ('8210000000');

ALTER TABLE fidc_adm.transaction_new_partition_8200000000_8210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8210000000_8220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8210000000') TO ('8220000000');

ALTER TABLE fidc_adm.transaction_new_partition_8210000000_8220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8220000000_8230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8220000000') TO ('8230000000');

ALTER TABLE fidc_adm.transaction_new_partition_8220000000_8230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8230000000_8240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8230000000') TO ('8240000000');

ALTER TABLE fidc_adm.transaction_new_partition_8230000000_8240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8240000000_8250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8240000000') TO ('8250000000');

ALTER TABLE fidc_adm.transaction_new_partition_8240000000_8250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8250000000_8260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8250000000') TO ('8260000000');

ALTER TABLE fidc_adm.transaction_new_partition_8250000000_8260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8260000000_8270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8260000000') TO ('8270000000');

ALTER TABLE fidc_adm.transaction_new_partition_8260000000_8270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8270000000_8280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8270000000') TO ('8280000000');

ALTER TABLE fidc_adm.transaction_new_partition_8270000000_8280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8280000000_8290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8280000000') TO ('8290000000');

ALTER TABLE fidc_adm.transaction_new_partition_8280000000_8290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8290000000_8300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8290000000') TO ('8300000000');

ALTER TABLE fidc_adm.transaction_new_partition_8290000000_8300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8300000000_8310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8300000000') TO ('8310000000');

ALTER TABLE fidc_adm.transaction_new_partition_8300000000_8310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8310000000_8320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8310000000') TO ('8320000000');

ALTER TABLE fidc_adm.transaction_new_partition_8310000000_8320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8320000000_8330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8320000000') TO ('8330000000');

ALTER TABLE fidc_adm.transaction_new_partition_8320000000_8330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8330000000_8340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8330000000') TO ('8340000000');

ALTER TABLE fidc_adm.transaction_new_partition_8330000000_8340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8340000000_8350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8340000000') TO ('8350000000');

ALTER TABLE fidc_adm.transaction_new_partition_8340000000_8350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8350000000_8360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8350000000') TO ('8360000000');

ALTER TABLE fidc_adm.transaction_new_partition_8350000000_8360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8360000000_8370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8360000000') TO ('8370000000');

ALTER TABLE fidc_adm.transaction_new_partition_8360000000_8370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8370000000_8380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8370000000') TO ('8380000000');

ALTER TABLE fidc_adm.transaction_new_partition_8370000000_8380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8380000000_8390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8380000000') TO ('8390000000');

ALTER TABLE fidc_adm.transaction_new_partition_8380000000_8390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8390000000_8400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8390000000') TO ('8400000000');

ALTER TABLE fidc_adm.transaction_new_partition_8390000000_8400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8400000000_8410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8400000000') TO ('8410000000');

ALTER TABLE fidc_adm.transaction_new_partition_8400000000_8410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8410000000_8420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8410000000') TO ('8420000000');

ALTER TABLE fidc_adm.transaction_new_partition_8410000000_8420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8420000000_8430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8420000000') TO ('8430000000');

ALTER TABLE fidc_adm.transaction_new_partition_8420000000_8430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8430000000_8440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8430000000') TO ('8440000000');

ALTER TABLE fidc_adm.transaction_new_partition_8430000000_8440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8440000000_8450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8440000000') TO ('8450000000');

ALTER TABLE fidc_adm.transaction_new_partition_8440000000_8450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8450000000_8460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8450000000') TO ('8460000000');

ALTER TABLE fidc_adm.transaction_new_partition_8450000000_8460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8460000000_8470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8460000000') TO ('8470000000');

ALTER TABLE fidc_adm.transaction_new_partition_8460000000_8470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8470000000_8480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8470000000') TO ('8480000000');

ALTER TABLE fidc_adm.transaction_new_partition_8470000000_8480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8480000000_8490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8480000000') TO ('8490000000');

ALTER TABLE fidc_adm.transaction_new_partition_8480000000_8490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8490000000_8500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8490000000') TO ('8500000000');

ALTER TABLE fidc_adm.transaction_new_partition_8490000000_8500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8500000000_8510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8500000000') TO ('8510000000');

ALTER TABLE fidc_adm.transaction_new_partition_8500000000_8510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8510000000_8520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8510000000') TO ('8520000000');

ALTER TABLE fidc_adm.transaction_new_partition_8510000000_8520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8520000000_8530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8520000000') TO ('8530000000');

ALTER TABLE fidc_adm.transaction_new_partition_8520000000_8530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8530000000_8540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8530000000') TO ('8540000000');

ALTER TABLE fidc_adm.transaction_new_partition_8530000000_8540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8540000000_8550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8540000000') TO ('8550000000');

ALTER TABLE fidc_adm.transaction_new_partition_8540000000_8550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8550000000_8560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8550000000') TO ('8560000000');

ALTER TABLE fidc_adm.transaction_new_partition_8550000000_8560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8560000000_8570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8560000000') TO ('8570000000');

ALTER TABLE fidc_adm.transaction_new_partition_8560000000_8570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8570000000_8580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8570000000') TO ('8580000000');

ALTER TABLE fidc_adm.transaction_new_partition_8570000000_8580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8580000000_8590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8580000000') TO ('8590000000');

ALTER TABLE fidc_adm.transaction_new_partition_8580000000_8590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8590000000_8600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8590000000') TO ('8600000000');

ALTER TABLE fidc_adm.transaction_new_partition_8590000000_8600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8600000000_8610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8600000000') TO ('8610000000');

ALTER TABLE fidc_adm.transaction_new_partition_8600000000_8610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8610000000_8620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8610000000') TO ('8620000000');

ALTER TABLE fidc_adm.transaction_new_partition_8610000000_8620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8620000000_8630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8620000000') TO ('8630000000');

ALTER TABLE fidc_adm.transaction_new_partition_8620000000_8630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8630000000_8640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8630000000') TO ('8640000000');

ALTER TABLE fidc_adm.transaction_new_partition_8630000000_8640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8640000000_8650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8640000000') TO ('8650000000');

ALTER TABLE fidc_adm.transaction_new_partition_8640000000_8650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8650000000_8660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8650000000') TO ('8660000000');

ALTER TABLE fidc_adm.transaction_new_partition_8650000000_8660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8660000000_8670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8660000000') TO ('8670000000');

ALTER TABLE fidc_adm.transaction_new_partition_8660000000_8670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8670000000_8680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8670000000') TO ('8680000000');

ALTER TABLE fidc_adm.transaction_new_partition_8670000000_8680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8680000000_8690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8680000000') TO ('8690000000');

ALTER TABLE fidc_adm.transaction_new_partition_8680000000_8690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8690000000_8700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8690000000') TO ('8700000000');

ALTER TABLE fidc_adm.transaction_new_partition_8690000000_8700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8700000000_8710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8700000000') TO ('8710000000');

ALTER TABLE fidc_adm.transaction_new_partition_8700000000_8710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8710000000_8720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8710000000') TO ('8720000000');

ALTER TABLE fidc_adm.transaction_new_partition_8710000000_8720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8720000000_8730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8720000000') TO ('8730000000');

ALTER TABLE fidc_adm.transaction_new_partition_8720000000_8730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8730000000_8740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8730000000') TO ('8740000000');

ALTER TABLE fidc_adm.transaction_new_partition_8730000000_8740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8740000000_8750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8740000000') TO ('8750000000');

ALTER TABLE fidc_adm.transaction_new_partition_8740000000_8750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8750000000_8760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8750000000') TO ('8760000000');

ALTER TABLE fidc_adm.transaction_new_partition_8750000000_8760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8760000000_8770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8760000000') TO ('8770000000');

ALTER TABLE fidc_adm.transaction_new_partition_8760000000_8770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8770000000_8780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8770000000') TO ('8780000000');

ALTER TABLE fidc_adm.transaction_new_partition_8770000000_8780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8780000000_8790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8780000000') TO ('8790000000');

ALTER TABLE fidc_adm.transaction_new_partition_8780000000_8790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8790000000_8800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8790000000') TO ('8800000000');

ALTER TABLE fidc_adm.transaction_new_partition_8790000000_8800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8800000000_8810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8800000000') TO ('8810000000');

ALTER TABLE fidc_adm.transaction_new_partition_8800000000_8810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8810000000_8820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8810000000') TO ('8820000000');

ALTER TABLE fidc_adm.transaction_new_partition_8810000000_8820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8820000000_8830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8820000000') TO ('8830000000');

ALTER TABLE fidc_adm.transaction_new_partition_8820000000_8830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8830000000_8840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8830000000') TO ('8840000000');

ALTER TABLE fidc_adm.transaction_new_partition_8830000000_8840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8840000000_8850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8840000000') TO ('8850000000');

ALTER TABLE fidc_adm.transaction_new_partition_8840000000_8850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8850000000_8860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8850000000') TO ('8860000000');

ALTER TABLE fidc_adm.transaction_new_partition_8850000000_8860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8860000000_8870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8860000000') TO ('8870000000');

ALTER TABLE fidc_adm.transaction_new_partition_8860000000_8870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8870000000_8880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8870000000') TO ('8880000000');

ALTER TABLE fidc_adm.transaction_new_partition_8870000000_8880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8880000000_8890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8880000000') TO ('8890000000');

ALTER TABLE fidc_adm.transaction_new_partition_8880000000_8890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8890000000_8900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8890000000') TO ('8900000000');

ALTER TABLE fidc_adm.transaction_new_partition_8890000000_8900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8900000000_8910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8900000000') TO ('8910000000');

ALTER TABLE fidc_adm.transaction_new_partition_8900000000_8910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8910000000_8920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8910000000') TO ('8920000000');

ALTER TABLE fidc_adm.transaction_new_partition_8910000000_8920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8920000000_8930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8920000000') TO ('8930000000');

ALTER TABLE fidc_adm.transaction_new_partition_8920000000_8930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8930000000_8940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8930000000') TO ('8940000000');

ALTER TABLE fidc_adm.transaction_new_partition_8930000000_8940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8940000000_8950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8940000000') TO ('8950000000');

ALTER TABLE fidc_adm.transaction_new_partition_8940000000_8950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8950000000_8960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8950000000') TO ('8960000000');

ALTER TABLE fidc_adm.transaction_new_partition_8950000000_8960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8960000000_8970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8960000000') TO ('8970000000');

ALTER TABLE fidc_adm.transaction_new_partition_8960000000_8970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8970000000_8980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8970000000') TO ('8980000000');

ALTER TABLE fidc_adm.transaction_new_partition_8970000000_8980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8980000000_8990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8980000000') TO ('8990000000');

ALTER TABLE fidc_adm.transaction_new_partition_8980000000_8990000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_8990000000_9000000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('8990000000') TO ('9000000000');

ALTER TABLE fidc_adm.transaction_new_partition_8990000000_9000000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9000000000_9010000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9000000000') TO ('9010000000');

ALTER TABLE fidc_adm.transaction_new_partition_9000000000_9010000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9010000000_9020000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9010000000') TO ('9020000000');

ALTER TABLE fidc_adm.transaction_new_partition_9010000000_9020000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9020000000_9030000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9020000000') TO ('9030000000');

ALTER TABLE fidc_adm.transaction_new_partition_9020000000_9030000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9030000000_9040000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9030000000') TO ('9040000000');

ALTER TABLE fidc_adm.transaction_new_partition_9030000000_9040000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9040000000_9050000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9040000000') TO ('9050000000');

ALTER TABLE fidc_adm.transaction_new_partition_9040000000_9050000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9050000000_9060000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9050000000') TO ('9060000000');

ALTER TABLE fidc_adm.transaction_new_partition_9050000000_9060000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9060000000_9070000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9060000000') TO ('9070000000');

ALTER TABLE fidc_adm.transaction_new_partition_9060000000_9070000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9070000000_9080000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9070000000') TO ('9080000000');

ALTER TABLE fidc_adm.transaction_new_partition_9070000000_9080000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9080000000_9090000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9080000000') TO ('9090000000');

ALTER TABLE fidc_adm.transaction_new_partition_9080000000_9090000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9090000000_9100000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9090000000') TO ('9100000000');

ALTER TABLE fidc_adm.transaction_new_partition_9090000000_9100000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9100000000_9110000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9100000000') TO ('9110000000');

ALTER TABLE fidc_adm.transaction_new_partition_9100000000_9110000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9110000000_9120000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9110000000') TO ('9120000000');

ALTER TABLE fidc_adm.transaction_new_partition_9110000000_9120000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9120000000_9130000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9120000000') TO ('9130000000');

ALTER TABLE fidc_adm.transaction_new_partition_9120000000_9130000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9130000000_9140000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9130000000') TO ('9140000000');

ALTER TABLE fidc_adm.transaction_new_partition_9130000000_9140000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9140000000_9150000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9140000000') TO ('9150000000');

ALTER TABLE fidc_adm.transaction_new_partition_9140000000_9150000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9150000000_9160000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9150000000') TO ('9160000000');

ALTER TABLE fidc_adm.transaction_new_partition_9150000000_9160000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9160000000_9170000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9160000000') TO ('9170000000');

ALTER TABLE fidc_adm.transaction_new_partition_9160000000_9170000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9170000000_9180000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9170000000') TO ('9180000000');

ALTER TABLE fidc_adm.transaction_new_partition_9170000000_9180000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9180000000_9190000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9180000000') TO ('9190000000');

ALTER TABLE fidc_adm.transaction_new_partition_9180000000_9190000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9190000000_9200000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9190000000') TO ('9200000000');

ALTER TABLE fidc_adm.transaction_new_partition_9190000000_9200000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9200000000_9210000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9200000000') TO ('9210000000');

ALTER TABLE fidc_adm.transaction_new_partition_9200000000_9210000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9210000000_9220000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9210000000') TO ('9220000000');

ALTER TABLE fidc_adm.transaction_new_partition_9210000000_9220000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9220000000_9230000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9220000000') TO ('9230000000');

ALTER TABLE fidc_adm.transaction_new_partition_9220000000_9230000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9230000000_9240000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9230000000') TO ('9240000000');

ALTER TABLE fidc_adm.transaction_new_partition_9230000000_9240000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9240000000_9250000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9240000000') TO ('9250000000');

ALTER TABLE fidc_adm.transaction_new_partition_9240000000_9250000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9250000000_9260000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9250000000') TO ('9260000000');

ALTER TABLE fidc_adm.transaction_new_partition_9250000000_9260000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9260000000_9270000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9260000000') TO ('9270000000');

ALTER TABLE fidc_adm.transaction_new_partition_9260000000_9270000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9270000000_9280000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9270000000') TO ('9280000000');

ALTER TABLE fidc_adm.transaction_new_partition_9270000000_9280000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9280000000_9290000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9280000000') TO ('9290000000');

ALTER TABLE fidc_adm.transaction_new_partition_9280000000_9290000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9290000000_9300000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9290000000') TO ('9300000000');

ALTER TABLE fidc_adm.transaction_new_partition_9290000000_9300000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9300000000_9310000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9300000000') TO ('9310000000');

ALTER TABLE fidc_adm.transaction_new_partition_9300000000_9310000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9310000000_9320000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9310000000') TO ('9320000000');

ALTER TABLE fidc_adm.transaction_new_partition_9310000000_9320000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9320000000_9330000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9320000000') TO ('9330000000');

ALTER TABLE fidc_adm.transaction_new_partition_9320000000_9330000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9330000000_9340000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9330000000') TO ('9340000000');

ALTER TABLE fidc_adm.transaction_new_partition_9330000000_9340000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9340000000_9350000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9340000000') TO ('9350000000');

ALTER TABLE fidc_adm.transaction_new_partition_9340000000_9350000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9350000000_9360000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9350000000') TO ('9360000000');

ALTER TABLE fidc_adm.transaction_new_partition_9350000000_9360000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9360000000_9370000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9360000000') TO ('9370000000');

ALTER TABLE fidc_adm.transaction_new_partition_9360000000_9370000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9370000000_9380000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9370000000') TO ('9380000000');

ALTER TABLE fidc_adm.transaction_new_partition_9370000000_9380000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9380000000_9390000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9380000000') TO ('9390000000');

ALTER TABLE fidc_adm.transaction_new_partition_9380000000_9390000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9390000000_9400000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9390000000') TO ('9400000000');

ALTER TABLE fidc_adm.transaction_new_partition_9390000000_9400000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9400000000_9410000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9400000000') TO ('9410000000');

ALTER TABLE fidc_adm.transaction_new_partition_9400000000_9410000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9410000000_9420000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9410000000') TO ('9420000000');

ALTER TABLE fidc_adm.transaction_new_partition_9410000000_9420000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9420000000_9430000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9420000000') TO ('9430000000');

ALTER TABLE fidc_adm.transaction_new_partition_9420000000_9430000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9430000000_9440000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9430000000') TO ('9440000000');

ALTER TABLE fidc_adm.transaction_new_partition_9430000000_9440000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9440000000_9450000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9440000000') TO ('9450000000');

ALTER TABLE fidc_adm.transaction_new_partition_9440000000_9450000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9450000000_9460000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9450000000') TO ('9460000000');

ALTER TABLE fidc_adm.transaction_new_partition_9450000000_9460000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9460000000_9470000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9460000000') TO ('9470000000');

ALTER TABLE fidc_adm.transaction_new_partition_9460000000_9470000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9470000000_9480000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9470000000') TO ('9480000000');

ALTER TABLE fidc_adm.transaction_new_partition_9470000000_9480000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9480000000_9490000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9480000000') TO ('9490000000');

ALTER TABLE fidc_adm.transaction_new_partition_9480000000_9490000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9490000000_9500000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9490000000') TO ('9500000000');

ALTER TABLE fidc_adm.transaction_new_partition_9490000000_9500000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9500000000_9510000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9500000000') TO ('9510000000');

ALTER TABLE fidc_adm.transaction_new_partition_9500000000_9510000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9510000000_9520000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9510000000') TO ('9520000000');

ALTER TABLE fidc_adm.transaction_new_partition_9510000000_9520000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9520000000_9530000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9520000000') TO ('9530000000');

ALTER TABLE fidc_adm.transaction_new_partition_9520000000_9530000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9530000000_9540000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9530000000') TO ('9540000000');

ALTER TABLE fidc_adm.transaction_new_partition_9530000000_9540000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9540000000_9550000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9540000000') TO ('9550000000');

ALTER TABLE fidc_adm.transaction_new_partition_9540000000_9550000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9550000000_9560000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9550000000') TO ('9560000000');

ALTER TABLE fidc_adm.transaction_new_partition_9550000000_9560000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9560000000_9570000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9560000000') TO ('9570000000');

ALTER TABLE fidc_adm.transaction_new_partition_9560000000_9570000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9570000000_9580000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9570000000') TO ('9580000000');

ALTER TABLE fidc_adm.transaction_new_partition_9570000000_9580000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9580000000_9590000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9580000000') TO ('9590000000');

ALTER TABLE fidc_adm.transaction_new_partition_9580000000_9590000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9590000000_9600000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9590000000') TO ('9600000000');

ALTER TABLE fidc_adm.transaction_new_partition_9590000000_9600000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9600000000_9610000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9600000000') TO ('9610000000');

ALTER TABLE fidc_adm.transaction_new_partition_9600000000_9610000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9610000000_9620000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9610000000') TO ('9620000000');

ALTER TABLE fidc_adm.transaction_new_partition_9610000000_9620000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9620000000_9630000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9620000000') TO ('9630000000');

ALTER TABLE fidc_adm.transaction_new_partition_9620000000_9630000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9630000000_9640000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9630000000') TO ('9640000000');

ALTER TABLE fidc_adm.transaction_new_partition_9630000000_9640000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9640000000_9650000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9640000000') TO ('9650000000');

ALTER TABLE fidc_adm.transaction_new_partition_9640000000_9650000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9650000000_9660000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9650000000') TO ('9660000000');

ALTER TABLE fidc_adm.transaction_new_partition_9650000000_9660000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9660000000_9670000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9660000000') TO ('9670000000');

ALTER TABLE fidc_adm.transaction_new_partition_9660000000_9670000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9670000000_9680000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9670000000') TO ('9680000000');

ALTER TABLE fidc_adm.transaction_new_partition_9670000000_9680000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9680000000_9690000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9680000000') TO ('9690000000');

ALTER TABLE fidc_adm.transaction_new_partition_9680000000_9690000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9690000000_9700000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9690000000') TO ('9700000000');

ALTER TABLE fidc_adm.transaction_new_partition_9690000000_9700000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9700000000_9710000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9700000000') TO ('9710000000');

ALTER TABLE fidc_adm.transaction_new_partition_9700000000_9710000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9710000000_9720000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9710000000') TO ('9720000000');

ALTER TABLE fidc_adm.transaction_new_partition_9710000000_9720000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9720000000_9730000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9720000000') TO ('9730000000');

ALTER TABLE fidc_adm.transaction_new_partition_9720000000_9730000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9730000000_9740000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9730000000') TO ('9740000000');

ALTER TABLE fidc_adm.transaction_new_partition_9730000000_9740000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9740000000_9750000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9740000000') TO ('9750000000');

ALTER TABLE fidc_adm.transaction_new_partition_9740000000_9750000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9750000000_9760000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9750000000') TO ('9760000000');

ALTER TABLE fidc_adm.transaction_new_partition_9750000000_9760000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9760000000_9770000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9760000000') TO ('9770000000');

ALTER TABLE fidc_adm.transaction_new_partition_9760000000_9770000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9770000000_9780000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9770000000') TO ('9780000000');

ALTER TABLE fidc_adm.transaction_new_partition_9770000000_9780000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9780000000_9790000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9780000000') TO ('9790000000');

ALTER TABLE fidc_adm.transaction_new_partition_9780000000_9790000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9790000000_9800000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9790000000') TO ('9800000000');

ALTER TABLE fidc_adm.transaction_new_partition_9790000000_9800000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9800000000_9810000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9800000000') TO ('9810000000');

ALTER TABLE fidc_adm.transaction_new_partition_9800000000_9810000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9810000000_9820000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9810000000') TO ('9820000000');

ALTER TABLE fidc_adm.transaction_new_partition_9810000000_9820000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9820000000_9830000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9820000000') TO ('9830000000');

ALTER TABLE fidc_adm.transaction_new_partition_9820000000_9830000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9830000000_9840000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9830000000') TO ('9840000000');

ALTER TABLE fidc_adm.transaction_new_partition_9830000000_9840000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9840000000_9850000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9840000000') TO ('9850000000');

ALTER TABLE fidc_adm.transaction_new_partition_9840000000_9850000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9850000000_9860000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9850000000') TO ('9860000000');

ALTER TABLE fidc_adm.transaction_new_partition_9850000000_9860000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9860000000_9870000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9860000000') TO ('9870000000');

ALTER TABLE fidc_adm.transaction_new_partition_9860000000_9870000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9870000000_9880000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9870000000') TO ('9880000000');

ALTER TABLE fidc_adm.transaction_new_partition_9870000000_9880000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9880000000_9890000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9880000000') TO ('9890000000');

ALTER TABLE fidc_adm.transaction_new_partition_9880000000_9890000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9890000000_9900000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9890000000') TO ('9900000000');

ALTER TABLE fidc_adm.transaction_new_partition_9890000000_9900000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9900000000_9910000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9900000000') TO ('9910000000');

ALTER TABLE fidc_adm.transaction_new_partition_9900000000_9910000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9910000000_9920000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9910000000') TO ('9920000000');

ALTER TABLE fidc_adm.transaction_new_partition_9910000000_9920000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9920000000_9930000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9920000000') TO ('9930000000');

ALTER TABLE fidc_adm.transaction_new_partition_9920000000_9930000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9930000000_9940000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9930000000') TO ('9940000000');

ALTER TABLE fidc_adm.transaction_new_partition_9930000000_9940000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9940000000_9950000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9940000000') TO ('9950000000');

ALTER TABLE fidc_adm.transaction_new_partition_9940000000_9950000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9950000000_9960000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9950000000') TO ('9960000000');

ALTER TABLE fidc_adm.transaction_new_partition_9950000000_9960000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9960000000_9970000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9960000000') TO ('9970000000');

ALTER TABLE fidc_adm.transaction_new_partition_9960000000_9970000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9970000000_9980000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9970000000') TO ('9980000000');

ALTER TABLE fidc_adm.transaction_new_partition_9970000000_9980000000 OWNER to fidc_adm;

CREATE TABLE fidc_adm.transaction_new_partition_9980000000_9990000000 PARTITION OF fidc_adm.transaction_new FOR VALUES FROM ('9980000000') TO ('9990000000');

ALTER TABLE fidc_adm.transaction_new_partition_9980000000_9990000000 OWNER to fidc_adm;
	

---------------------------------------------------
-- carrega os dados da tabela antiga para a nova --	
---------------------------------------------------
	
do $$ 
declare

  v_range_partition varchar(30) := null;  
  v_string_execute varchar(300) := null;  
  
begin 

     for v_range_partition in
       select substring(pt.relname from 23 for 50)
       from pg_class base_tb 
       join pg_inherits i on i.inhparent = base_tb.oid 
       join pg_class pt on pt.oid = i.inhrelid
	   join pg_stat_all_tables st on pt.oid = st.relid
       where  base_tb.relname = 'transaction' 
	   and (n_tup_ins = 0 and n_tup_upd = 0 and n_tup_del = 0)
       order by pt.relname	 
	   
	 loop
  
       raise notice 'Partition name: %',v_range_partition;
	 
	   v_string_execute := 'insert into fidc_adm.transaction_new_partition_' || v_range_partition || ' select * from fidc_adm.transaction_partition_'||v_range_partition;
	 
       --raise notice 'Sintaxe: %', v_string_execute;
		 
		execute v_string_execute;    

     end loop;	 	 
	   
END $$;	

----------------------------
-- cria PK da tabela nova --	
----------------------------

alter table transaction_new_partition_9980000000_9990000000 add constraint transaction_new_partition_9980000000_9990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9970000000_9980000000 add constraint transaction_new_partition_9970000000_9980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9960000000_9970000000 add constraint transaction_new_partition_9960000000_9970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9950000000_9960000000 add constraint transaction_new_partition_9950000000_9960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9940000000_9950000000 add constraint transaction_new_partition_9940000000_9950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9930000000_9940000000 add constraint transaction_new_partition_9930000000_9940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9920000000_9930000000 add constraint transaction_new_partition_9920000000_9930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9910000000_9920000000 add constraint transaction_new_partition_9910000000_9920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9900000000_9910000000 add constraint transaction_new_partition_9900000000_9910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9890000000_9900000000 add constraint transaction_new_partition_9890000000_9900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9880000000_9890000000 add constraint transaction_new_partition_9880000000_9890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9870000000_9880000000 add constraint transaction_new_partition_9870000000_9880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9860000000_9870000000 add constraint transaction_new_partition_9860000000_9870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9850000000_9860000000 add constraint transaction_new_partition_9850000000_9860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9840000000_9850000000 add constraint transaction_new_partition_9840000000_9850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9830000000_9840000000 add constraint transaction_new_partition_9830000000_9840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9820000000_9830000000 add constraint transaction_new_partition_9820000000_9830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9810000000_9820000000 add constraint transaction_new_partition_9810000000_9820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9800000000_9810000000 add constraint transaction_new_partition_9800000000_9810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9790000000_9800000000 add constraint transaction_new_partition_9790000000_9800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9780000000_9790000000 add constraint transaction_new_partition_9780000000_9790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9770000000_9780000000 add constraint transaction_new_partition_9770000000_9780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9760000000_9770000000 add constraint transaction_new_partition_9760000000_9770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9750000000_9760000000 add constraint transaction_new_partition_9750000000_9760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9740000000_9750000000 add constraint transaction_new_partition_9740000000_9750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9730000000_9740000000 add constraint transaction_new_partition_9730000000_9740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9720000000_9730000000 add constraint transaction_new_partition_9720000000_9730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9710000000_9720000000 add constraint transaction_new_partition_9710000000_9720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9700000000_9710000000 add constraint transaction_new_partition_9700000000_9710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9690000000_9700000000 add constraint transaction_new_partition_9690000000_9700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9680000000_9690000000 add constraint transaction_new_partition_9680000000_9690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9670000000_9680000000 add constraint transaction_new_partition_9670000000_9680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9660000000_9670000000 add constraint transaction_new_partition_9660000000_9670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9650000000_9660000000 add constraint transaction_new_partition_9650000000_9660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9640000000_9650000000 add constraint transaction_new_partition_9640000000_9650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9630000000_9640000000 add constraint transaction_new_partition_9630000000_9640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9620000000_9630000000 add constraint transaction_new_partition_9620000000_9630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9610000000_9620000000 add constraint transaction_new_partition_9610000000_9620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9600000000_9610000000 add constraint transaction_new_partition_9600000000_9610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9590000000_9600000000 add constraint transaction_new_partition_9590000000_9600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9580000000_9590000000 add constraint transaction_new_partition_9580000000_9590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9570000000_9580000000 add constraint transaction_new_partition_9570000000_9580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9560000000_9570000000 add constraint transaction_new_partition_9560000000_9570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9550000000_9560000000 add constraint transaction_new_partition_9550000000_9560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9540000000_9550000000 add constraint transaction_new_partition_9540000000_9550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9530000000_9540000000 add constraint transaction_new_partition_9530000000_9540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9520000000_9530000000 add constraint transaction_new_partition_9520000000_9530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9510000000_9520000000 add constraint transaction_new_partition_9510000000_9520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9500000000_9510000000 add constraint transaction_new_partition_9500000000_9510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9490000000_9500000000 add constraint transaction_new_partition_9490000000_9500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9480000000_9490000000 add constraint transaction_new_partition_9480000000_9490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9470000000_9480000000 add constraint transaction_new_partition_9470000000_9480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9460000000_9470000000 add constraint transaction_new_partition_9460000000_9470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9450000000_9460000000 add constraint transaction_new_partition_9450000000_9460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9440000000_9450000000 add constraint transaction_new_partition_9440000000_9450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9430000000_9440000000 add constraint transaction_new_partition_9430000000_9440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9420000000_9430000000 add constraint transaction_new_partition_9420000000_9430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9410000000_9420000000 add constraint transaction_new_partition_9410000000_9420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9400000000_9410000000 add constraint transaction_new_partition_9400000000_9410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9390000000_9400000000 add constraint transaction_new_partition_9390000000_9400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9380000000_9390000000 add constraint transaction_new_partition_9380000000_9390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9370000000_9380000000 add constraint transaction_new_partition_9370000000_9380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9360000000_9370000000 add constraint transaction_new_partition_9360000000_9370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9350000000_9360000000 add constraint transaction_new_partition_9350000000_9360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9340000000_9350000000 add constraint transaction_new_partition_9340000000_9350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9330000000_9340000000 add constraint transaction_new_partition_9330000000_9340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9320000000_9330000000 add constraint transaction_new_partition_9320000000_9330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9310000000_9320000000 add constraint transaction_new_partition_9310000000_9320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9300000000_9310000000 add constraint transaction_new_partition_9300000000_9310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9290000000_9300000000 add constraint transaction_new_partition_9290000000_9300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9280000000_9290000000 add constraint transaction_new_partition_9280000000_9290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9270000000_9280000000 add constraint transaction_new_partition_9270000000_9280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9260000000_9270000000 add constraint transaction_new_partition_9260000000_9270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9250000000_9260000000 add constraint transaction_new_partition_9250000000_9260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9240000000_9250000000 add constraint transaction_new_partition_9240000000_9250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9230000000_9240000000 add constraint transaction_new_partition_9230000000_9240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9220000000_9230000000 add constraint transaction_new_partition_9220000000_9230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9210000000_9220000000 add constraint transaction_new_partition_9210000000_9220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9200000000_9210000000 add constraint transaction_new_partition_9200000000_9210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9190000000_9200000000 add constraint transaction_new_partition_9190000000_9200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9180000000_9190000000 add constraint transaction_new_partition_9180000000_9190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9170000000_9180000000 add constraint transaction_new_partition_9170000000_9180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9160000000_9170000000 add constraint transaction_new_partition_9160000000_9170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9150000000_9160000000 add constraint transaction_new_partition_9150000000_9160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9140000000_9150000000 add constraint transaction_new_partition_9140000000_9150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9130000000_9140000000 add constraint transaction_new_partition_9130000000_9140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9120000000_9130000000 add constraint transaction_new_partition_9120000000_9130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9110000000_9120000000 add constraint transaction_new_partition_9110000000_9120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9100000000_9110000000 add constraint transaction_new_partition_9100000000_9110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9090000000_9100000000 add constraint transaction_new_partition_9090000000_9100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9080000000_9090000000 add constraint transaction_new_partition_9080000000_9090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9070000000_9080000000 add constraint transaction_new_partition_9070000000_9080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9060000000_9070000000 add constraint transaction_new_partition_9060000000_9070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9050000000_9060000000 add constraint transaction_new_partition_9050000000_9060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9040000000_9050000000 add constraint transaction_new_partition_9040000000_9050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9030000000_9040000000 add constraint transaction_new_partition_9030000000_9040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9020000000_9030000000 add constraint transaction_new_partition_9020000000_9030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9010000000_9020000000 add constraint transaction_new_partition_9010000000_9020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9000000000_9010000000 add constraint transaction_new_partition_9000000000_9010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8990000000_9000000000 add constraint transaction_new_partition_8990000000_9000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8980000000_8990000000 add constraint transaction_new_partition_8980000000_8990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8970000000_8980000000 add constraint transaction_new_partition_8970000000_8980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8960000000_8970000000 add constraint transaction_new_partition_8960000000_8970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8950000000_8960000000 add constraint transaction_new_partition_8950000000_8960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8940000000_8950000000 add constraint transaction_new_partition_8940000000_8950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8930000000_8940000000 add constraint transaction_new_partition_8930000000_8940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8920000000_8930000000 add constraint transaction_new_partition_8920000000_8930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8910000000_8920000000 add constraint transaction_new_partition_8910000000_8920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8900000000_8910000000 add constraint transaction_new_partition_8900000000_8910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8890000000_8900000000 add constraint transaction_new_partition_8890000000_8900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8880000000_8890000000 add constraint transaction_new_partition_8880000000_8890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8870000000_8880000000 add constraint transaction_new_partition_8870000000_8880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8860000000_8870000000 add constraint transaction_new_partition_8860000000_8870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8850000000_8860000000 add constraint transaction_new_partition_8850000000_8860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8840000000_8850000000 add constraint transaction_new_partition_8840000000_8850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8830000000_8840000000 add constraint transaction_new_partition_8830000000_8840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8820000000_8830000000 add constraint transaction_new_partition_8820000000_8830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8810000000_8820000000 add constraint transaction_new_partition_8810000000_8820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8800000000_8810000000 add constraint transaction_new_partition_8800000000_8810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8790000000_8800000000 add constraint transaction_new_partition_8790000000_8800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8780000000_8790000000 add constraint transaction_new_partition_8780000000_8790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8770000000_8780000000 add constraint transaction_new_partition_8770000000_8780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8760000000_8770000000 add constraint transaction_new_partition_8760000000_8770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8750000000_8760000000 add constraint transaction_new_partition_8750000000_8760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8740000000_8750000000 add constraint transaction_new_partition_8740000000_8750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8730000000_8740000000 add constraint transaction_new_partition_8730000000_8740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8720000000_8730000000 add constraint transaction_new_partition_8720000000_8730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8710000000_8720000000 add constraint transaction_new_partition_8710000000_8720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8700000000_8710000000 add constraint transaction_new_partition_8700000000_8710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8690000000_8700000000 add constraint transaction_new_partition_8690000000_8700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8680000000_8690000000 add constraint transaction_new_partition_8680000000_8690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8670000000_8680000000 add constraint transaction_new_partition_8670000000_8680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8660000000_8670000000 add constraint transaction_new_partition_8660000000_8670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8650000000_8660000000 add constraint transaction_new_partition_8650000000_8660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8640000000_8650000000 add constraint transaction_new_partition_8640000000_8650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8630000000_8640000000 add constraint transaction_new_partition_8630000000_8640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8620000000_8630000000 add constraint transaction_new_partition_8620000000_8630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8610000000_8620000000 add constraint transaction_new_partition_8610000000_8620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8600000000_8610000000 add constraint transaction_new_partition_8600000000_8610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8590000000_8600000000 add constraint transaction_new_partition_8590000000_8600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8580000000_8590000000 add constraint transaction_new_partition_8580000000_8590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8570000000_8580000000 add constraint transaction_new_partition_8570000000_8580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8560000000_8570000000 add constraint transaction_new_partition_8560000000_8570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8550000000_8560000000 add constraint transaction_new_partition_8550000000_8560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8540000000_8550000000 add constraint transaction_new_partition_8540000000_8550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8530000000_8540000000 add constraint transaction_new_partition_8530000000_8540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8520000000_8530000000 add constraint transaction_new_partition_8520000000_8530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8510000000_8520000000 add constraint transaction_new_partition_8510000000_8520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8500000000_8510000000 add constraint transaction_new_partition_8500000000_8510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8490000000_8500000000 add constraint transaction_new_partition_8490000000_8500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8480000000_8490000000 add constraint transaction_new_partition_8480000000_8490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8470000000_8480000000 add constraint transaction_new_partition_8470000000_8480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8460000000_8470000000 add constraint transaction_new_partition_8460000000_8470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8450000000_8460000000 add constraint transaction_new_partition_8450000000_8460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8440000000_8450000000 add constraint transaction_new_partition_8440000000_8450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8430000000_8440000000 add constraint transaction_new_partition_8430000000_8440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8420000000_8430000000 add constraint transaction_new_partition_8420000000_8430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8410000000_8420000000 add constraint transaction_new_partition_8410000000_8420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8400000000_8410000000 add constraint transaction_new_partition_8400000000_8410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8390000000_8400000000 add constraint transaction_new_partition_8390000000_8400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8380000000_8390000000 add constraint transaction_new_partition_8380000000_8390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8370000000_8380000000 add constraint transaction_new_partition_8370000000_8380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8360000000_8370000000 add constraint transaction_new_partition_8360000000_8370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8350000000_8360000000 add constraint transaction_new_partition_8350000000_8360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8340000000_8350000000 add constraint transaction_new_partition_8340000000_8350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8330000000_8340000000 add constraint transaction_new_partition_8330000000_8340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8320000000_8330000000 add constraint transaction_new_partition_8320000000_8330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8310000000_8320000000 add constraint transaction_new_partition_8310000000_8320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8300000000_8310000000 add constraint transaction_new_partition_8300000000_8310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8290000000_8300000000 add constraint transaction_new_partition_8290000000_8300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8280000000_8290000000 add constraint transaction_new_partition_8280000000_8290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8270000000_8280000000 add constraint transaction_new_partition_8270000000_8280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8260000000_8270000000 add constraint transaction_new_partition_8260000000_8270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8250000000_8260000000 add constraint transaction_new_partition_8250000000_8260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8240000000_8250000000 add constraint transaction_new_partition_8240000000_8250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8230000000_8240000000 add constraint transaction_new_partition_8230000000_8240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8220000000_8230000000 add constraint transaction_new_partition_8220000000_8230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8210000000_8220000000 add constraint transaction_new_partition_8210000000_8220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8200000000_8210000000 add constraint transaction_new_partition_8200000000_8210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8190000000_8200000000 add constraint transaction_new_partition_8190000000_8200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8180000000_8190000000 add constraint transaction_new_partition_8180000000_8190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8170000000_8180000000 add constraint transaction_new_partition_8170000000_8180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8160000000_8170000000 add constraint transaction_new_partition_8160000000_8170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8150000000_8160000000 add constraint transaction_new_partition_8150000000_8160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8140000000_8150000000 add constraint transaction_new_partition_8140000000_8150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8130000000_8140000000 add constraint transaction_new_partition_8130000000_8140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8120000000_8130000000 add constraint transaction_new_partition_8120000000_8130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8110000000_8120000000 add constraint transaction_new_partition_8110000000_8120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8100000000_8110000000 add constraint transaction_new_partition_8100000000_8110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8090000000_8100000000 add constraint transaction_new_partition_8090000000_8100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8080000000_8090000000 add constraint transaction_new_partition_8080000000_8090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8070000000_8080000000 add constraint transaction_new_partition_8070000000_8080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8060000000_8070000000 add constraint transaction_new_partition_8060000000_8070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8050000000_8060000000 add constraint transaction_new_partition_8050000000_8060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8040000000_8050000000 add constraint transaction_new_partition_8040000000_8050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8030000000_8040000000 add constraint transaction_new_partition_8030000000_8040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8020000000_8030000000 add constraint transaction_new_partition_8020000000_8030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8010000000_8020000000 add constraint transaction_new_partition_8010000000_8020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8000000000_8010000000 add constraint transaction_new_partition_8000000000_8010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7990000000_8000000000 add constraint transaction_new_partition_7990000000_8000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7980000000_7990000000 add constraint transaction_new_partition_7980000000_7990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7970000000_7980000000 add constraint transaction_new_partition_7970000000_7980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7960000000_7970000000 add constraint transaction_new_partition_7960000000_7970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7950000000_7960000000 add constraint transaction_new_partition_7950000000_7960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7940000000_7950000000 add constraint transaction_new_partition_7940000000_7950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7930000000_7940000000 add constraint transaction_new_partition_7930000000_7940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7920000000_7930000000 add constraint transaction_new_partition_7920000000_7930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7910000000_7920000000 add constraint transaction_new_partition_7910000000_7920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7900000000_7910000000 add constraint transaction_new_partition_7900000000_7910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7890000000_7900000000 add constraint transaction_new_partition_7890000000_7900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7880000000_7890000000 add constraint transaction_new_partition_7880000000_7890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7870000000_7880000000 add constraint transaction_new_partition_7870000000_7880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7860000000_7870000000 add constraint transaction_new_partition_7860000000_7870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7850000000_7860000000 add constraint transaction_new_partition_7850000000_7860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7840000000_7850000000 add constraint transaction_new_partition_7840000000_7850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7830000000_7840000000 add constraint transaction_new_partition_7830000000_7840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7820000000_7830000000 add constraint transaction_new_partition_7820000000_7830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7810000000_7820000000 add constraint transaction_new_partition_7810000000_7820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7800000000_7810000000 add constraint transaction_new_partition_7800000000_7810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7790000000_7800000000 add constraint transaction_new_partition_7790000000_7800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7780000000_7790000000 add constraint transaction_new_partition_7780000000_7790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7770000000_7780000000 add constraint transaction_new_partition_7770000000_7780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7760000000_7770000000 add constraint transaction_new_partition_7760000000_7770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7750000000_7760000000 add constraint transaction_new_partition_7750000000_7760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7740000000_7750000000 add constraint transaction_new_partition_7740000000_7750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7730000000_7740000000 add constraint transaction_new_partition_7730000000_7740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7720000000_7730000000 add constraint transaction_new_partition_7720000000_7730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7710000000_7720000000 add constraint transaction_new_partition_7710000000_7720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7700000000_7710000000 add constraint transaction_new_partition_7700000000_7710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7690000000_7700000000 add constraint transaction_new_partition_7690000000_7700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7680000000_7690000000 add constraint transaction_new_partition_7680000000_7690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7670000000_7680000000 add constraint transaction_new_partition_7670000000_7680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7660000000_7670000000 add constraint transaction_new_partition_7660000000_7670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7650000000_7660000000 add constraint transaction_new_partition_7650000000_7660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7640000000_7650000000 add constraint transaction_new_partition_7640000000_7650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7630000000_7640000000 add constraint transaction_new_partition_7630000000_7640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7620000000_7630000000 add constraint transaction_new_partition_7620000000_7630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7610000000_7620000000 add constraint transaction_new_partition_7610000000_7620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7600000000_7610000000 add constraint transaction_new_partition_7600000000_7610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7590000000_7600000000 add constraint transaction_new_partition_7590000000_7600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7580000000_7590000000 add constraint transaction_new_partition_7580000000_7590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7570000000_7580000000 add constraint transaction_new_partition_7570000000_7580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7560000000_7570000000 add constraint transaction_new_partition_7560000000_7570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7550000000_7560000000 add constraint transaction_new_partition_7550000000_7560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7540000000_7550000000 add constraint transaction_new_partition_7540000000_7550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7530000000_7540000000 add constraint transaction_new_partition_7530000000_7540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7520000000_7530000000 add constraint transaction_new_partition_7520000000_7530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7510000000_7520000000 add constraint transaction_new_partition_7510000000_7520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7500000000_7510000000 add constraint transaction_new_partition_7500000000_7510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7490000000_7500000000 add constraint transaction_new_partition_7490000000_7500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7480000000_7490000000 add constraint transaction_new_partition_7480000000_7490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7470000000_7480000000 add constraint transaction_new_partition_7470000000_7480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7460000000_7470000000 add constraint transaction_new_partition_7460000000_7470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7450000000_7460000000 add constraint transaction_new_partition_7450000000_7460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7440000000_7450000000 add constraint transaction_new_partition_7440000000_7450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7430000000_7440000000 add constraint transaction_new_partition_7430000000_7440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7420000000_7430000000 add constraint transaction_new_partition_7420000000_7430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7410000000_7420000000 add constraint transaction_new_partition_7410000000_7420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7400000000_7410000000 add constraint transaction_new_partition_7400000000_7410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7390000000_7400000000 add constraint transaction_new_partition_7390000000_7400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7380000000_7390000000 add constraint transaction_new_partition_7380000000_7390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7370000000_7380000000 add constraint transaction_new_partition_7370000000_7380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7360000000_7370000000 add constraint transaction_new_partition_7360000000_7370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7350000000_7360000000 add constraint transaction_new_partition_7350000000_7360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7340000000_7350000000 add constraint transaction_new_partition_7340000000_7350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7330000000_7340000000 add constraint transaction_new_partition_7330000000_7340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7320000000_7330000000 add constraint transaction_new_partition_7320000000_7330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7310000000_7320000000 add constraint transaction_new_partition_7310000000_7320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7300000000_7310000000 add constraint transaction_new_partition_7300000000_7310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7290000000_7300000000 add constraint transaction_new_partition_7290000000_7300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7280000000_7290000000 add constraint transaction_new_partition_7280000000_7290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7270000000_7280000000 add constraint transaction_new_partition_7270000000_7280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7260000000_7270000000 add constraint transaction_new_partition_7260000000_7270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7250000000_7260000000 add constraint transaction_new_partition_7250000000_7260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7240000000_7250000000 add constraint transaction_new_partition_7240000000_7250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7230000000_7240000000 add constraint transaction_new_partition_7230000000_7240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7220000000_7230000000 add constraint transaction_new_partition_7220000000_7230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7210000000_7220000000 add constraint transaction_new_partition_7210000000_7220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7200000000_7210000000 add constraint transaction_new_partition_7200000000_7210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7190000000_7200000000 add constraint transaction_new_partition_7190000000_7200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7180000000_7190000000 add constraint transaction_new_partition_7180000000_7190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7170000000_7180000000 add constraint transaction_new_partition_7170000000_7180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7160000000_7170000000 add constraint transaction_new_partition_7160000000_7170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7150000000_7160000000 add constraint transaction_new_partition_7150000000_7160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7140000000_7150000000 add constraint transaction_new_partition_7140000000_7150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7130000000_7140000000 add constraint transaction_new_partition_7130000000_7140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7120000000_7130000000 add constraint transaction_new_partition_7120000000_7130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7110000000_7120000000 add constraint transaction_new_partition_7110000000_7120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7100000000_7110000000 add constraint transaction_new_partition_7100000000_7110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7090000000_7100000000 add constraint transaction_new_partition_7090000000_7100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7080000000_7090000000 add constraint transaction_new_partition_7080000000_7090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7070000000_7080000000 add constraint transaction_new_partition_7070000000_7080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7060000000_7070000000 add constraint transaction_new_partition_7060000000_7070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7050000000_7060000000 add constraint transaction_new_partition_7050000000_7060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7040000000_7050000000 add constraint transaction_new_partition_7040000000_7050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7030000000_7040000000 add constraint transaction_new_partition_7030000000_7040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7020000000_7030000000 add constraint transaction_new_partition_7020000000_7030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7010000000_7020000000 add constraint transaction_new_partition_7010000000_7020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7000000000_7010000000 add constraint transaction_new_partition_7000000000_7010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6990000000_7000000000 add constraint transaction_new_partition_6990000000_7000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6980000000_6990000000 add constraint transaction_new_partition_6980000000_6990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6970000000_6980000000 add constraint transaction_new_partition_6970000000_6980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6960000000_6970000000 add constraint transaction_new_partition_6960000000_6970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6950000000_6960000000 add constraint transaction_new_partition_6950000000_6960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6940000000_6950000000 add constraint transaction_new_partition_6940000000_6950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6930000000_6940000000 add constraint transaction_new_partition_6930000000_6940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6920000000_6930000000 add constraint transaction_new_partition_6920000000_6930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6910000000_6920000000 add constraint transaction_new_partition_6910000000_6920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6900000000_6910000000 add constraint transaction_new_partition_6900000000_6910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6890000000_6900000000 add constraint transaction_new_partition_6890000000_6900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6880000000_6890000000 add constraint transaction_new_partition_6880000000_6890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6870000000_6880000000 add constraint transaction_new_partition_6870000000_6880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6860000000_6870000000 add constraint transaction_new_partition_6860000000_6870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6850000000_6860000000 add constraint transaction_new_partition_6850000000_6860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6840000000_6850000000 add constraint transaction_new_partition_6840000000_6850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6830000000_6840000000 add constraint transaction_new_partition_6830000000_6840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6820000000_6830000000 add constraint transaction_new_partition_6820000000_6830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6810000000_6820000000 add constraint transaction_new_partition_6810000000_6820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6800000000_6810000000 add constraint transaction_new_partition_6800000000_6810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6790000000_6800000000 add constraint transaction_new_partition_6790000000_6800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6780000000_6790000000 add constraint transaction_new_partition_6780000000_6790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6770000000_6780000000 add constraint transaction_new_partition_6770000000_6780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6760000000_6770000000 add constraint transaction_new_partition_6760000000_6770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6750000000_6760000000 add constraint transaction_new_partition_6750000000_6760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6740000000_6750000000 add constraint transaction_new_partition_6740000000_6750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6730000000_6740000000 add constraint transaction_new_partition_6730000000_6740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6720000000_6730000000 add constraint transaction_new_partition_6720000000_6730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6710000000_6720000000 add constraint transaction_new_partition_6710000000_6720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6700000000_6710000000 add constraint transaction_new_partition_6700000000_6710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6690000000_6700000000 add constraint transaction_new_partition_6690000000_6700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6680000000_6690000000 add constraint transaction_new_partition_6680000000_6690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6670000000_6680000000 add constraint transaction_new_partition_6670000000_6680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6660000000_6670000000 add constraint transaction_new_partition_6660000000_6670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6650000000_6660000000 add constraint transaction_new_partition_6650000000_6660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6640000000_6650000000 add constraint transaction_new_partition_6640000000_6650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6630000000_6640000000 add constraint transaction_new_partition_6630000000_6640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6620000000_6630000000 add constraint transaction_new_partition_6620000000_6630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6610000000_6620000000 add constraint transaction_new_partition_6610000000_6620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6600000000_6610000000 add constraint transaction_new_partition_6600000000_6610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6590000000_6600000000 add constraint transaction_new_partition_6590000000_6600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6580000000_6590000000 add constraint transaction_new_partition_6580000000_6590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6570000000_6580000000 add constraint transaction_new_partition_6570000000_6580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6560000000_6570000000 add constraint transaction_new_partition_6560000000_6570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6550000000_6560000000 add constraint transaction_new_partition_6550000000_6560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6540000000_6550000000 add constraint transaction_new_partition_6540000000_6550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6530000000_6540000000 add constraint transaction_new_partition_6530000000_6540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6520000000_6530000000 add constraint transaction_new_partition_6520000000_6530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6510000000_6520000000 add constraint transaction_new_partition_6510000000_6520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6500000000_6510000000 add constraint transaction_new_partition_6500000000_6510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6490000000_6500000000 add constraint transaction_new_partition_6490000000_6500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6480000000_6490000000 add constraint transaction_new_partition_6480000000_6490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6470000000_6480000000 add constraint transaction_new_partition_6470000000_6480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6460000000_6470000000 add constraint transaction_new_partition_6460000000_6470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6450000000_6460000000 add constraint transaction_new_partition_6450000000_6460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6440000000_6450000000 add constraint transaction_new_partition_6440000000_6450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6430000000_6440000000 add constraint transaction_new_partition_6430000000_6440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6420000000_6430000000 add constraint transaction_new_partition_6420000000_6430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6410000000_6420000000 add constraint transaction_new_partition_6410000000_6420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6400000000_6410000000 add constraint transaction_new_partition_6400000000_6410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6390000000_6400000000 add constraint transaction_new_partition_6390000000_6400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6380000000_6390000000 add constraint transaction_new_partition_6380000000_6390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6370000000_6380000000 add constraint transaction_new_partition_6370000000_6380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6360000000_6370000000 add constraint transaction_new_partition_6360000000_6370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6350000000_6360000000 add constraint transaction_new_partition_6350000000_6360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6340000000_6350000000 add constraint transaction_new_partition_6340000000_6350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6330000000_6340000000 add constraint transaction_new_partition_6330000000_6340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6320000000_6330000000 add constraint transaction_new_partition_6320000000_6330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6310000000_6320000000 add constraint transaction_new_partition_6310000000_6320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6300000000_6310000000 add constraint transaction_new_partition_6300000000_6310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6290000000_6300000000 add constraint transaction_new_partition_6290000000_6300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6280000000_6290000000 add constraint transaction_new_partition_6280000000_6290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6270000000_6280000000 add constraint transaction_new_partition_6270000000_6280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6260000000_6270000000 add constraint transaction_new_partition_6260000000_6270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6250000000_6260000000 add constraint transaction_new_partition_6250000000_6260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6240000000_6250000000 add constraint transaction_new_partition_6240000000_6250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6230000000_6240000000 add constraint transaction_new_partition_6230000000_6240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6220000000_6230000000 add constraint transaction_new_partition_6220000000_6230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6210000000_6220000000 add constraint transaction_new_partition_6210000000_6220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6200000000_6210000000 add constraint transaction_new_partition_6200000000_6210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6190000000_6200000000 add constraint transaction_new_partition_6190000000_6200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6180000000_6190000000 add constraint transaction_new_partition_6180000000_6190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6170000000_6180000000 add constraint transaction_new_partition_6170000000_6180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6160000000_6170000000 add constraint transaction_new_partition_6160000000_6170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6150000000_6160000000 add constraint transaction_new_partition_6150000000_6160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6140000000_6150000000 add constraint transaction_new_partition_6140000000_6150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6130000000_6140000000 add constraint transaction_new_partition_6130000000_6140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6120000000_6130000000 add constraint transaction_new_partition_6120000000_6130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6110000000_6120000000 add constraint transaction_new_partition_6110000000_6120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6100000000_6110000000 add constraint transaction_new_partition_6100000000_6110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6090000000_6100000000 add constraint transaction_new_partition_6090000000_6100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6080000000_6090000000 add constraint transaction_new_partition_6080000000_6090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6070000000_6080000000 add constraint transaction_new_partition_6070000000_6080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6060000000_6070000000 add constraint transaction_new_partition_6060000000_6070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6050000000_6060000000 add constraint transaction_new_partition_6050000000_6060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6040000000_6050000000 add constraint transaction_new_partition_6040000000_6050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6030000000_6040000000 add constraint transaction_new_partition_6030000000_6040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6020000000_6030000000 add constraint transaction_new_partition_6020000000_6030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6010000000_6020000000 add constraint transaction_new_partition_6010000000_6020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6000000000_6010000000 add constraint transaction_new_partition_6000000000_6010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5990000000_6000000000 add constraint transaction_new_partition_5990000000_6000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5980000000_5990000000 add constraint transaction_new_partition_5980000000_5990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5970000000_5980000000 add constraint transaction_new_partition_5970000000_5980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5960000000_5970000000 add constraint transaction_new_partition_5960000000_5970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5950000000_5960000000 add constraint transaction_new_partition_5950000000_5960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5940000000_5950000000 add constraint transaction_new_partition_5940000000_5950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5930000000_5940000000 add constraint transaction_new_partition_5930000000_5940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5920000000_5930000000 add constraint transaction_new_partition_5920000000_5930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5910000000_5920000000 add constraint transaction_new_partition_5910000000_5920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5900000000_5910000000 add constraint transaction_new_partition_5900000000_5910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5890000000_5900000000 add constraint transaction_new_partition_5890000000_5900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5880000000_5890000000 add constraint transaction_new_partition_5880000000_5890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5870000000_5880000000 add constraint transaction_new_partition_5870000000_5880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5860000000_5870000000 add constraint transaction_new_partition_5860000000_5870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5850000000_5860000000 add constraint transaction_new_partition_5850000000_5860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5840000000_5850000000 add constraint transaction_new_partition_5840000000_5850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5830000000_5840000000 add constraint transaction_new_partition_5830000000_5840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5820000000_5830000000 add constraint transaction_new_partition_5820000000_5830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5810000000_5820000000 add constraint transaction_new_partition_5810000000_5820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5800000000_5810000000 add constraint transaction_new_partition_5800000000_5810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5790000000_5800000000 add constraint transaction_new_partition_5790000000_5800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5780000000_5790000000 add constraint transaction_new_partition_5780000000_5790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5770000000_5780000000 add constraint transaction_new_partition_5770000000_5780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5760000000_5770000000 add constraint transaction_new_partition_5760000000_5770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5750000000_5760000000 add constraint transaction_new_partition_5750000000_5760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5740000000_5750000000 add constraint transaction_new_partition_5740000000_5750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5730000000_5740000000 add constraint transaction_new_partition_5730000000_5740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5720000000_5730000000 add constraint transaction_new_partition_5720000000_5730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5710000000_5720000000 add constraint transaction_new_partition_5710000000_5720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5700000000_5710000000 add constraint transaction_new_partition_5700000000_5710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5690000000_5700000000 add constraint transaction_new_partition_5690000000_5700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5680000000_5690000000 add constraint transaction_new_partition_5680000000_5690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5670000000_5680000000 add constraint transaction_new_partition_5670000000_5680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5660000000_5670000000 add constraint transaction_new_partition_5660000000_5670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5650000000_5660000000 add constraint transaction_new_partition_5650000000_5660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5640000000_5650000000 add constraint transaction_new_partition_5640000000_5650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5630000000_5640000000 add constraint transaction_new_partition_5630000000_5640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5620000000_5630000000 add constraint transaction_new_partition_5620000000_5630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5610000000_5620000000 add constraint transaction_new_partition_5610000000_5620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5600000000_5610000000 add constraint transaction_new_partition_5600000000_5610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5590000000_5600000000 add constraint transaction_new_partition_5590000000_5600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5580000000_5590000000 add constraint transaction_new_partition_5580000000_5590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5570000000_5580000000 add constraint transaction_new_partition_5570000000_5580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5560000000_5570000000 add constraint transaction_new_partition_5560000000_5570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5550000000_5560000000 add constraint transaction_new_partition_5550000000_5560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5540000000_5550000000 add constraint transaction_new_partition_5540000000_5550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5530000000_5540000000 add constraint transaction_new_partition_5530000000_5540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5520000000_5530000000 add constraint transaction_new_partition_5520000000_5530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5510000000_5520000000 add constraint transaction_new_partition_5510000000_5520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5500000000_5510000000 add constraint transaction_new_partition_5500000000_5510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5490000000_5500000000 add constraint transaction_new_partition_5490000000_5500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5480000000_5490000000 add constraint transaction_new_partition_5480000000_5490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5470000000_5480000000 add constraint transaction_new_partition_5470000000_5480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5460000000_5470000000 add constraint transaction_new_partition_5460000000_5470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5450000000_5460000000 add constraint transaction_new_partition_5450000000_5460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5440000000_5450000000 add constraint transaction_new_partition_5440000000_5450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5430000000_5440000000 add constraint transaction_new_partition_5430000000_5440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5420000000_5430000000 add constraint transaction_new_partition_5420000000_5430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5410000000_5420000000 add constraint transaction_new_partition_5410000000_5420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5400000000_5410000000 add constraint transaction_new_partition_5400000000_5410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5390000000_5400000000 add constraint transaction_new_partition_5390000000_5400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5380000000_5390000000 add constraint transaction_new_partition_5380000000_5390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5370000000_5380000000 add constraint transaction_new_partition_5370000000_5380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5360000000_5370000000 add constraint transaction_new_partition_5360000000_5370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5350000000_5360000000 add constraint transaction_new_partition_5350000000_5360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5340000000_5350000000 add constraint transaction_new_partition_5340000000_5350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5330000000_5340000000 add constraint transaction_new_partition_5330000000_5340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5320000000_5330000000 add constraint transaction_new_partition_5320000000_5330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5310000000_5320000000 add constraint transaction_new_partition_5310000000_5320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5300000000_5310000000 add constraint transaction_new_partition_5300000000_5310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5290000000_5300000000 add constraint transaction_new_partition_5290000000_5300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5280000000_5290000000 add constraint transaction_new_partition_5280000000_5290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5270000000_5280000000 add constraint transaction_new_partition_5270000000_5280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5260000000_5270000000 add constraint transaction_new_partition_5260000000_5270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5250000000_5260000000 add constraint transaction_new_partition_5250000000_5260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5240000000_5250000000 add constraint transaction_new_partition_5240000000_5250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5230000000_5240000000 add constraint transaction_new_partition_5230000000_5240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5220000000_5230000000 add constraint transaction_new_partition_5220000000_5230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5210000000_5220000000 add constraint transaction_new_partition_5210000000_5220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5200000000_5210000000 add constraint transaction_new_partition_5200000000_5210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5190000000_5200000000 add constraint transaction_new_partition_5190000000_5200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5180000000_5190000000 add constraint transaction_new_partition_5180000000_5190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5170000000_5180000000 add constraint transaction_new_partition_5170000000_5180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5160000000_5170000000 add constraint transaction_new_partition_5160000000_5170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5150000000_5160000000 add constraint transaction_new_partition_5150000000_5160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5140000000_5150000000 add constraint transaction_new_partition_5140000000_5150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5130000000_5140000000 add constraint transaction_new_partition_5130000000_5140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5120000000_5130000000 add constraint transaction_new_partition_5120000000_5130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5110000000_5120000000 add constraint transaction_new_partition_5110000000_5120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5100000000_5110000000 add constraint transaction_new_partition_5100000000_5110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5090000000_5100000000 add constraint transaction_new_partition_5090000000_5100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5080000000_5090000000 add constraint transaction_new_partition_5080000000_5090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5070000000_5080000000 add constraint transaction_new_partition_5070000000_5080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5060000000_5070000000 add constraint transaction_new_partition_5060000000_5070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5050000000_5060000000 add constraint transaction_new_partition_5050000000_5060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5040000000_5050000000 add constraint transaction_new_partition_5040000000_5050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5030000000_5040000000 add constraint transaction_new_partition_5030000000_5040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5020000000_5030000000 add constraint transaction_new_partition_5020000000_5030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5010000000_5020000000 add constraint transaction_new_partition_5010000000_5020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5000000000_5010000000 add constraint transaction_new_partition_5000000000_5010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4990000000_5000000000 add constraint transaction_new_partition_4990000000_5000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4980000000_4990000000 add constraint transaction_new_partition_4980000000_4990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4970000000_4980000000 add constraint transaction_new_partition_4970000000_4980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4960000000_4970000000 add constraint transaction_new_partition_4960000000_4970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4950000000_4960000000 add constraint transaction_new_partition_4950000000_4960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4940000000_4950000000 add constraint transaction_new_partition_4940000000_4950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4930000000_4940000000 add constraint transaction_new_partition_4930000000_4940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4920000000_4930000000 add constraint transaction_new_partition_4920000000_4930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4910000000_4920000000 add constraint transaction_new_partition_4910000000_4920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4900000000_4910000000 add constraint transaction_new_partition_4900000000_4910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4890000000_4900000000 add constraint transaction_new_partition_4890000000_4900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4880000000_4890000000 add constraint transaction_new_partition_4880000000_4890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4870000000_4880000000 add constraint transaction_new_partition_4870000000_4880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4860000000_4870000000 add constraint transaction_new_partition_4860000000_4870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4850000000_4860000000 add constraint transaction_new_partition_4850000000_4860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4840000000_4850000000 add constraint transaction_new_partition_4840000000_4850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4830000000_4840000000 add constraint transaction_new_partition_4830000000_4840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4820000000_4830000000 add constraint transaction_new_partition_4820000000_4830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4810000000_4820000000 add constraint transaction_new_partition_4810000000_4820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4800000000_4810000000 add constraint transaction_new_partition_4800000000_4810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4790000000_4800000000 add constraint transaction_new_partition_4790000000_4800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4780000000_4790000000 add constraint transaction_new_partition_4780000000_4790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4770000000_4780000000 add constraint transaction_new_partition_4770000000_4780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4760000000_4770000000 add constraint transaction_new_partition_4760000000_4770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4750000000_4760000000 add constraint transaction_new_partition_4750000000_4760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4740000000_4750000000 add constraint transaction_new_partition_4740000000_4750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4730000000_4740000000 add constraint transaction_new_partition_4730000000_4740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4720000000_4730000000 add constraint transaction_new_partition_4720000000_4730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4710000000_4720000000 add constraint transaction_new_partition_4710000000_4720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4700000000_4710000000 add constraint transaction_new_partition_4700000000_4710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4690000000_4700000000 add constraint transaction_new_partition_4690000000_4700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4680000000_4690000000 add constraint transaction_new_partition_4680000000_4690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4670000000_4680000000 add constraint transaction_new_partition_4670000000_4680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4660000000_4670000000 add constraint transaction_new_partition_4660000000_4670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4650000000_4660000000 add constraint transaction_new_partition_4650000000_4660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4640000000_4650000000 add constraint transaction_new_partition_4640000000_4650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4630000000_4640000000 add constraint transaction_new_partition_4630000000_4640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4620000000_4630000000 add constraint transaction_new_partition_4620000000_4630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4610000000_4620000000 add constraint transaction_new_partition_4610000000_4620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4600000000_4610000000 add constraint transaction_new_partition_4600000000_4610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4590000000_4600000000 add constraint transaction_new_partition_4590000000_4600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4580000000_4590000000 add constraint transaction_new_partition_4580000000_4590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4570000000_4580000000 add constraint transaction_new_partition_4570000000_4580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4560000000_4570000000 add constraint transaction_new_partition_4560000000_4570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4550000000_4560000000 add constraint transaction_new_partition_4550000000_4560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4540000000_4550000000 add constraint transaction_new_partition_4540000000_4550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4530000000_4540000000 add constraint transaction_new_partition_4530000000_4540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4520000000_4530000000 add constraint transaction_new_partition_4520000000_4530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4510000000_4520000000 add constraint transaction_new_partition_4510000000_4520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4500000000_4510000000 add constraint transaction_new_partition_4500000000_4510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4490000000_4500000000 add constraint transaction_new_partition_4490000000_4500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4480000000_4490000000 add constraint transaction_new_partition_4480000000_4490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4470000000_4480000000 add constraint transaction_new_partition_4470000000_4480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4460000000_4470000000 add constraint transaction_new_partition_4460000000_4470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4450000000_4460000000 add constraint transaction_new_partition_4450000000_4460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4440000000_4450000000 add constraint transaction_new_partition_4440000000_4450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4430000000_4440000000 add constraint transaction_new_partition_4430000000_4440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4420000000_4430000000 add constraint transaction_new_partition_4420000000_4430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4410000000_4420000000 add constraint transaction_new_partition_4410000000_4420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4400000000_4410000000 add constraint transaction_new_partition_4400000000_4410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4390000000_4400000000 add constraint transaction_new_partition_4390000000_4400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4380000000_4390000000 add constraint transaction_new_partition_4380000000_4390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4370000000_4380000000 add constraint transaction_new_partition_4370000000_4380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4360000000_4370000000 add constraint transaction_new_partition_4360000000_4370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4350000000_4360000000 add constraint transaction_new_partition_4350000000_4360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4340000000_4350000000 add constraint transaction_new_partition_4340000000_4350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4330000000_4340000000 add constraint transaction_new_partition_4330000000_4340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4320000000_4330000000 add constraint transaction_new_partition_4320000000_4330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4310000000_4320000000 add constraint transaction_new_partition_4310000000_4320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4300000000_4310000000 add constraint transaction_new_partition_4300000000_4310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4290000000_4300000000 add constraint transaction_new_partition_4290000000_4300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4280000000_4290000000 add constraint transaction_new_partition_4280000000_4290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4270000000_4280000000 add constraint transaction_new_partition_4270000000_4280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4260000000_4270000000 add constraint transaction_new_partition_4260000000_4270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4250000000_4260000000 add constraint transaction_new_partition_4250000000_4260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4240000000_4250000000 add constraint transaction_new_partition_4240000000_4250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4230000000_4240000000 add constraint transaction_new_partition_4230000000_4240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4220000000_4230000000 add constraint transaction_new_partition_4220000000_4230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4210000000_4220000000 add constraint transaction_new_partition_4210000000_4220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4200000000_4210000000 add constraint transaction_new_partition_4200000000_4210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4190000000_4200000000 add constraint transaction_new_partition_4190000000_4200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4180000000_4190000000 add constraint transaction_new_partition_4180000000_4190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4170000000_4180000000 add constraint transaction_new_partition_4170000000_4180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4160000000_4170000000 add constraint transaction_new_partition_4160000000_4170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4150000000_4160000000 add constraint transaction_new_partition_4150000000_4160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4140000000_4150000000 add constraint transaction_new_partition_4140000000_4150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4130000000_4140000000 add constraint transaction_new_partition_4130000000_4140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4120000000_4130000000 add constraint transaction_new_partition_4120000000_4130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4110000000_4120000000 add constraint transaction_new_partition_4110000000_4120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4100000000_4110000000 add constraint transaction_new_partition_4100000000_4110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4090000000_4100000000 add constraint transaction_new_partition_4090000000_4100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4080000000_4090000000 add constraint transaction_new_partition_4080000000_4090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4070000000_4080000000 add constraint transaction_new_partition_4070000000_4080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4060000000_4070000000 add constraint transaction_new_partition_4060000000_4070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4050000000_4060000000 add constraint transaction_new_partition_4050000000_4060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4040000000_4050000000 add constraint transaction_new_partition_4040000000_4050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4030000000_4040000000 add constraint transaction_new_partition_4030000000_4040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4020000000_4030000000 add constraint transaction_new_partition_4020000000_4030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4010000000_4020000000 add constraint transaction_new_partition_4010000000_4020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4000000000_4010000000 add constraint transaction_new_partition_4000000000_4010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3990000000_4000000000 add constraint transaction_new_partition_3990000000_4000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3980000000_3990000000 add constraint transaction_new_partition_3980000000_3990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3970000000_3980000000 add constraint transaction_new_partition_3970000000_3980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3960000000_3970000000 add constraint transaction_new_partition_3960000000_3970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3950000000_3960000000 add constraint transaction_new_partition_3950000000_3960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3940000000_3950000000 add constraint transaction_new_partition_3940000000_3950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3930000000_3940000000 add constraint transaction_new_partition_3930000000_3940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3920000000_3930000000 add constraint transaction_new_partition_3920000000_3930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3910000000_3920000000 add constraint transaction_new_partition_3910000000_3920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3900000000_3910000000 add constraint transaction_new_partition_3900000000_3910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3890000000_3900000000 add constraint transaction_new_partition_3890000000_3900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3880000000_3890000000 add constraint transaction_new_partition_3880000000_3890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3870000000_3880000000 add constraint transaction_new_partition_3870000000_3880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3860000000_3870000000 add constraint transaction_new_partition_3860000000_3870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3850000000_3860000000 add constraint transaction_new_partition_3850000000_3860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3840000000_3850000000 add constraint transaction_new_partition_3840000000_3850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3830000000_3840000000 add constraint transaction_new_partition_3830000000_3840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3820000000_3830000000 add constraint transaction_new_partition_3820000000_3830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3810000000_3820000000 add constraint transaction_new_partition_3810000000_3820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3800000000_3810000000 add constraint transaction_new_partition_3800000000_3810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3790000000_3800000000 add constraint transaction_new_partition_3790000000_3800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3780000000_3790000000 add constraint transaction_new_partition_3780000000_3790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3770000000_3780000000 add constraint transaction_new_partition_3770000000_3780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3760000000_3770000000 add constraint transaction_new_partition_3760000000_3770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3750000000_3760000000 add constraint transaction_new_partition_3750000000_3760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3740000000_3750000000 add constraint transaction_new_partition_3740000000_3750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3730000000_3740000000 add constraint transaction_new_partition_3730000000_3740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3720000000_3730000000 add constraint transaction_new_partition_3720000000_3730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3710000000_3720000000 add constraint transaction_new_partition_3710000000_3720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3700000000_3710000000 add constraint transaction_new_partition_3700000000_3710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3690000000_3700000000 add constraint transaction_new_partition_3690000000_3700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3680000000_3690000000 add constraint transaction_new_partition_3680000000_3690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3670000000_3680000000 add constraint transaction_new_partition_3670000000_3680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3660000000_3670000000 add constraint transaction_new_partition_3660000000_3670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3650000000_3660000000 add constraint transaction_new_partition_3650000000_3660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3640000000_3650000000 add constraint transaction_new_partition_3640000000_3650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3630000000_3640000000 add constraint transaction_new_partition_3630000000_3640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3620000000_3630000000 add constraint transaction_new_partition_3620000000_3630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3610000000_3620000000 add constraint transaction_new_partition_3610000000_3620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3600000000_3610000000 add constraint transaction_new_partition_3600000000_3610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3590000000_3600000000 add constraint transaction_new_partition_3590000000_3600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3580000000_3590000000 add constraint transaction_new_partition_3580000000_3590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3570000000_3580000000 add constraint transaction_new_partition_3570000000_3580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3560000000_3570000000 add constraint transaction_new_partition_3560000000_3570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3550000000_3560000000 add constraint transaction_new_partition_3550000000_3560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3540000000_3550000000 add constraint transaction_new_partition_3540000000_3550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3530000000_3540000000 add constraint transaction_new_partition_3530000000_3540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3520000000_3530000000 add constraint transaction_new_partition_3520000000_3530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3510000000_3520000000 add constraint transaction_new_partition_3510000000_3520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3500000000_3510000000 add constraint transaction_new_partition_3500000000_3510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3490000000_3500000000 add constraint transaction_new_partition_3490000000_3500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3480000000_3490000000 add constraint transaction_new_partition_3480000000_3490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3470000000_3480000000 add constraint transaction_new_partition_3470000000_3480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3460000000_3470000000 add constraint transaction_new_partition_3460000000_3470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3450000000_3460000000 add constraint transaction_new_partition_3450000000_3460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3440000000_3450000000 add constraint transaction_new_partition_3440000000_3450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3430000000_3440000000 add constraint transaction_new_partition_3430000000_3440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3420000000_3430000000 add constraint transaction_new_partition_3420000000_3430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3410000000_3420000000 add constraint transaction_new_partition_3410000000_3420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3400000000_3410000000 add constraint transaction_new_partition_3400000000_3410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3390000000_3400000000 add constraint transaction_new_partition_3390000000_3400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3380000000_3390000000 add constraint transaction_new_partition_3380000000_3390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3370000000_3380000000 add constraint transaction_new_partition_3370000000_3380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3360000000_3370000000 add constraint transaction_new_partition_3360000000_3370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3350000000_3360000000 add constraint transaction_new_partition_3350000000_3360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3340000000_3350000000 add constraint transaction_new_partition_3340000000_3350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3330000000_3340000000 add constraint transaction_new_partition_3330000000_3340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3320000000_3330000000 add constraint transaction_new_partition_3320000000_3330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3310000000_3320000000 add constraint transaction_new_partition_3310000000_3320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3300000000_3310000000 add constraint transaction_new_partition_3300000000_3310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3290000000_3300000000 add constraint transaction_new_partition_3290000000_3300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3280000000_3290000000 add constraint transaction_new_partition_3280000000_3290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3270000000_3280000000 add constraint transaction_new_partition_3270000000_3280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3260000000_3270000000 add constraint transaction_new_partition_3260000000_3270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3250000000_3260000000 add constraint transaction_new_partition_3250000000_3260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3240000000_3250000000 add constraint transaction_new_partition_3240000000_3250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3230000000_3240000000 add constraint transaction_new_partition_3230000000_3240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3220000000_3230000000 add constraint transaction_new_partition_3220000000_3230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3210000000_3220000000 add constraint transaction_new_partition_3210000000_3220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3200000000_3210000000 add constraint transaction_new_partition_3200000000_3210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3190000000_3200000000 add constraint transaction_new_partition_3190000000_3200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3180000000_3190000000 add constraint transaction_new_partition_3180000000_3190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3170000000_3180000000 add constraint transaction_new_partition_3170000000_3180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3160000000_3170000000 add constraint transaction_new_partition_3160000000_3170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3150000000_3160000000 add constraint transaction_new_partition_3150000000_3160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3140000000_3150000000 add constraint transaction_new_partition_3140000000_3150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3130000000_3140000000 add constraint transaction_new_partition_3130000000_3140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3120000000_3130000000 add constraint transaction_new_partition_3120000000_3130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3110000000_3120000000 add constraint transaction_new_partition_3110000000_3120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3100000000_3110000000 add constraint transaction_new_partition_3100000000_3110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3090000000_3100000000 add constraint transaction_new_partition_3090000000_3100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3080000000_3090000000 add constraint transaction_new_partition_3080000000_3090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3070000000_3080000000 add constraint transaction_new_partition_3070000000_3080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3060000000_3070000000 add constraint transaction_new_partition_3060000000_3070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3050000000_3060000000 add constraint transaction_new_partition_3050000000_3060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3040000000_3050000000 add constraint transaction_new_partition_3040000000_3050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3030000000_3040000000 add constraint transaction_new_partition_3030000000_3040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3020000000_3030000000 add constraint transaction_new_partition_3020000000_3030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3010000000_3020000000 add constraint transaction_new_partition_3010000000_3020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3000000000_3010000000 add constraint transaction_new_partition_3000000000_3010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2990000000_3000000000 add constraint transaction_new_partition_2990000000_3000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2980000000_2990000000 add constraint transaction_new_partition_2980000000_2990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2970000000_2980000000 add constraint transaction_new_partition_2970000000_2980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2960000000_2970000000 add constraint transaction_new_partition_2960000000_2970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2950000000_2960000000 add constraint transaction_new_partition_2950000000_2960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2940000000_2950000000 add constraint transaction_new_partition_2940000000_2950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2930000000_2940000000 add constraint transaction_new_partition_2930000000_2940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2920000000_2930000000 add constraint transaction_new_partition_2920000000_2930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2910000000_2920000000 add constraint transaction_new_partition_2910000000_2920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2900000000_2910000000 add constraint transaction_new_partition_2900000000_2910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2890000000_2900000000 add constraint transaction_new_partition_2890000000_2900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2880000000_2890000000 add constraint transaction_new_partition_2880000000_2890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2870000000_2880000000 add constraint transaction_new_partition_2870000000_2880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2860000000_2870000000 add constraint transaction_new_partition_2860000000_2870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2850000000_2860000000 add constraint transaction_new_partition_2850000000_2860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2840000000_2850000000 add constraint transaction_new_partition_2840000000_2850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2830000000_2840000000 add constraint transaction_new_partition_2830000000_2840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2820000000_2830000000 add constraint transaction_new_partition_2820000000_2830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2810000000_2820000000 add constraint transaction_new_partition_2810000000_2820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2800000000_2810000000 add constraint transaction_new_partition_2800000000_2810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2790000000_2800000000 add constraint transaction_new_partition_2790000000_2800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2780000000_2790000000 add constraint transaction_new_partition_2780000000_2790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2770000000_2780000000 add constraint transaction_new_partition_2770000000_2780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2760000000_2770000000 add constraint transaction_new_partition_2760000000_2770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2750000000_2760000000 add constraint transaction_new_partition_2750000000_2760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2740000000_2750000000 add constraint transaction_new_partition_2740000000_2750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2730000000_2740000000 add constraint transaction_new_partition_2730000000_2740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2720000000_2730000000 add constraint transaction_new_partition_2720000000_2730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2710000000_2720000000 add constraint transaction_new_partition_2710000000_2720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2700000000_2710000000 add constraint transaction_new_partition_2700000000_2710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2690000000_2700000000 add constraint transaction_new_partition_2690000000_2700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2680000000_2690000000 add constraint transaction_new_partition_2680000000_2690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2670000000_2680000000 add constraint transaction_new_partition_2670000000_2680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2660000000_2670000000 add constraint transaction_new_partition_2660000000_2670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2650000000_2660000000 add constraint transaction_new_partition_2650000000_2660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2640000000_2650000000 add constraint transaction_new_partition_2640000000_2650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2630000000_2640000000 add constraint transaction_new_partition_2630000000_2640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2620000000_2630000000 add constraint transaction_new_partition_2620000000_2630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2610000000_2620000000 add constraint transaction_new_partition_2610000000_2620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2600000000_2610000000 add constraint transaction_new_partition_2600000000_2610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2590000000_2600000000 add constraint transaction_new_partition_2590000000_2600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2580000000_2590000000 add constraint transaction_new_partition_2580000000_2590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2570000000_2580000000 add constraint transaction_new_partition_2570000000_2580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2560000000_2570000000 add constraint transaction_new_partition_2560000000_2570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2550000000_2560000000 add constraint transaction_new_partition_2550000000_2560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2540000000_2550000000 add constraint transaction_new_partition_2540000000_2550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2530000000_2540000000 add constraint transaction_new_partition_2530000000_2540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2520000000_2530000000 add constraint transaction_new_partition_2520000000_2530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2510000000_2520000000 add constraint transaction_new_partition_2510000000_2520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2500000000_2510000000 add constraint transaction_new_partition_2500000000_2510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2490000000_2500000000 add constraint transaction_new_partition_2490000000_2500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2480000000_2490000000 add constraint transaction_new_partition_2480000000_2490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2470000000_2480000000 add constraint transaction_new_partition_2470000000_2480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2460000000_2470000000 add constraint transaction_new_partition_2460000000_2470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2450000000_2460000000 add constraint transaction_new_partition_2450000000_2460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2440000000_2450000000 add constraint transaction_new_partition_2440000000_2450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2430000000_2440000000 add constraint transaction_new_partition_2430000000_2440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2420000000_2430000000 add constraint transaction_new_partition_2420000000_2430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2410000000_2420000000 add constraint transaction_new_partition_2410000000_2420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2400000000_2410000000 add constraint transaction_new_partition_2400000000_2410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2390000000_2400000000 add constraint transaction_new_partition_2390000000_2400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2380000000_2390000000 add constraint transaction_new_partition_2380000000_2390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2370000000_2380000000 add constraint transaction_new_partition_2370000000_2380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2360000000_2370000000 add constraint transaction_new_partition_2360000000_2370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2350000000_2360000000 add constraint transaction_new_partition_2350000000_2360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2340000000_2350000000 add constraint transaction_new_partition_2340000000_2350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2330000000_2340000000 add constraint transaction_new_partition_2330000000_2340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2320000000_2330000000 add constraint transaction_new_partition_2320000000_2330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2310000000_2320000000 add constraint transaction_new_partition_2310000000_2320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2300000000_2310000000 add constraint transaction_new_partition_2300000000_2310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2290000000_2300000000 add constraint transaction_new_partition_2290000000_2300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2190000000_2290000000 add constraint transaction_new_partition_2190000000_2290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2090000000_2190000000 add constraint transaction_new_partition_2090000000_2190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_1990000000_2090000000 add constraint transaction_new_partition_1990000000_2090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_1984000000_1990000000 add constraint transaction_new_partition_1984000000_1990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_0_1984000000 add constraint transaction_new_partition_0_1984000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;

----------------------------
-- cria PK da tabela nova --	
----------------------------

alter table transaction_new_partition_9980000000_9990000000 add constraint transaction_new_partition_9980000000_9990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9970000000_9980000000 add constraint transaction_new_partition_9970000000_9980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9960000000_9970000000 add constraint transaction_new_partition_9960000000_9970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9950000000_9960000000 add constraint transaction_new_partition_9950000000_9960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9940000000_9950000000 add constraint transaction_new_partition_9940000000_9950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9930000000_9940000000 add constraint transaction_new_partition_9930000000_9940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9920000000_9930000000 add constraint transaction_new_partition_9920000000_9930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9910000000_9920000000 add constraint transaction_new_partition_9910000000_9920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9900000000_9910000000 add constraint transaction_new_partition_9900000000_9910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9890000000_9900000000 add constraint transaction_new_partition_9890000000_9900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9880000000_9890000000 add constraint transaction_new_partition_9880000000_9890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9870000000_9880000000 add constraint transaction_new_partition_9870000000_9880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9860000000_9870000000 add constraint transaction_new_partition_9860000000_9870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9850000000_9860000000 add constraint transaction_new_partition_9850000000_9860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9840000000_9850000000 add constraint transaction_new_partition_9840000000_9850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9830000000_9840000000 add constraint transaction_new_partition_9830000000_9840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9820000000_9830000000 add constraint transaction_new_partition_9820000000_9830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9810000000_9820000000 add constraint transaction_new_partition_9810000000_9820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9800000000_9810000000 add constraint transaction_new_partition_9800000000_9810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9790000000_9800000000 add constraint transaction_new_partition_9790000000_9800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9780000000_9790000000 add constraint transaction_new_partition_9780000000_9790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9770000000_9780000000 add constraint transaction_new_partition_9770000000_9780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9760000000_9770000000 add constraint transaction_new_partition_9760000000_9770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9750000000_9760000000 add constraint transaction_new_partition_9750000000_9760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9740000000_9750000000 add constraint transaction_new_partition_9740000000_9750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9730000000_9740000000 add constraint transaction_new_partition_9730000000_9740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9720000000_9730000000 add constraint transaction_new_partition_9720000000_9730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9710000000_9720000000 add constraint transaction_new_partition_9710000000_9720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9700000000_9710000000 add constraint transaction_new_partition_9700000000_9710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9690000000_9700000000 add constraint transaction_new_partition_9690000000_9700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9680000000_9690000000 add constraint transaction_new_partition_9680000000_9690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9670000000_9680000000 add constraint transaction_new_partition_9670000000_9680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9660000000_9670000000 add constraint transaction_new_partition_9660000000_9670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9650000000_9660000000 add constraint transaction_new_partition_9650000000_9660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9640000000_9650000000 add constraint transaction_new_partition_9640000000_9650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9630000000_9640000000 add constraint transaction_new_partition_9630000000_9640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9620000000_9630000000 add constraint transaction_new_partition_9620000000_9630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9610000000_9620000000 add constraint transaction_new_partition_9610000000_9620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9600000000_9610000000 add constraint transaction_new_partition_9600000000_9610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9590000000_9600000000 add constraint transaction_new_partition_9590000000_9600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9580000000_9590000000 add constraint transaction_new_partition_9580000000_9590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9570000000_9580000000 add constraint transaction_new_partition_9570000000_9580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9560000000_9570000000 add constraint transaction_new_partition_9560000000_9570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9550000000_9560000000 add constraint transaction_new_partition_9550000000_9560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9540000000_9550000000 add constraint transaction_new_partition_9540000000_9550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9530000000_9540000000 add constraint transaction_new_partition_9530000000_9540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9520000000_9530000000 add constraint transaction_new_partition_9520000000_9530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9510000000_9520000000 add constraint transaction_new_partition_9510000000_9520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9500000000_9510000000 add constraint transaction_new_partition_9500000000_9510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9490000000_9500000000 add constraint transaction_new_partition_9490000000_9500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9480000000_9490000000 add constraint transaction_new_partition_9480000000_9490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9470000000_9480000000 add constraint transaction_new_partition_9470000000_9480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9460000000_9470000000 add constraint transaction_new_partition_9460000000_9470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9450000000_9460000000 add constraint transaction_new_partition_9450000000_9460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9440000000_9450000000 add constraint transaction_new_partition_9440000000_9450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9430000000_9440000000 add constraint transaction_new_partition_9430000000_9440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9420000000_9430000000 add constraint transaction_new_partition_9420000000_9430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9410000000_9420000000 add constraint transaction_new_partition_9410000000_9420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9400000000_9410000000 add constraint transaction_new_partition_9400000000_9410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9390000000_9400000000 add constraint transaction_new_partition_9390000000_9400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9380000000_9390000000 add constraint transaction_new_partition_9380000000_9390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9370000000_9380000000 add constraint transaction_new_partition_9370000000_9380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9360000000_9370000000 add constraint transaction_new_partition_9360000000_9370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9350000000_9360000000 add constraint transaction_new_partition_9350000000_9360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9340000000_9350000000 add constraint transaction_new_partition_9340000000_9350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9330000000_9340000000 add constraint transaction_new_partition_9330000000_9340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9320000000_9330000000 add constraint transaction_new_partition_9320000000_9330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9310000000_9320000000 add constraint transaction_new_partition_9310000000_9320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9300000000_9310000000 add constraint transaction_new_partition_9300000000_9310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9290000000_9300000000 add constraint transaction_new_partition_9290000000_9300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9280000000_9290000000 add constraint transaction_new_partition_9280000000_9290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9270000000_9280000000 add constraint transaction_new_partition_9270000000_9280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9260000000_9270000000 add constraint transaction_new_partition_9260000000_9270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9250000000_9260000000 add constraint transaction_new_partition_9250000000_9260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9240000000_9250000000 add constraint transaction_new_partition_9240000000_9250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9230000000_9240000000 add constraint transaction_new_partition_9230000000_9240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9220000000_9230000000 add constraint transaction_new_partition_9220000000_9230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9210000000_9220000000 add constraint transaction_new_partition_9210000000_9220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9200000000_9210000000 add constraint transaction_new_partition_9200000000_9210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9190000000_9200000000 add constraint transaction_new_partition_9190000000_9200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9180000000_9190000000 add constraint transaction_new_partition_9180000000_9190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9170000000_9180000000 add constraint transaction_new_partition_9170000000_9180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9160000000_9170000000 add constraint transaction_new_partition_9160000000_9170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9150000000_9160000000 add constraint transaction_new_partition_9150000000_9160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9140000000_9150000000 add constraint transaction_new_partition_9140000000_9150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9130000000_9140000000 add constraint transaction_new_partition_9130000000_9140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9120000000_9130000000 add constraint transaction_new_partition_9120000000_9130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9110000000_9120000000 add constraint transaction_new_partition_9110000000_9120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9100000000_9110000000 add constraint transaction_new_partition_9100000000_9110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9090000000_9100000000 add constraint transaction_new_partition_9090000000_9100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9080000000_9090000000 add constraint transaction_new_partition_9080000000_9090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9070000000_9080000000 add constraint transaction_new_partition_9070000000_9080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9060000000_9070000000 add constraint transaction_new_partition_9060000000_9070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9050000000_9060000000 add constraint transaction_new_partition_9050000000_9060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9040000000_9050000000 add constraint transaction_new_partition_9040000000_9050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9030000000_9040000000 add constraint transaction_new_partition_9030000000_9040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9020000000_9030000000 add constraint transaction_new_partition_9020000000_9030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9010000000_9020000000 add constraint transaction_new_partition_9010000000_9020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_9000000000_9010000000 add constraint transaction_new_partition_9000000000_9010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8990000000_9000000000 add constraint transaction_new_partition_8990000000_9000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8980000000_8990000000 add constraint transaction_new_partition_8980000000_8990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8970000000_8980000000 add constraint transaction_new_partition_8970000000_8980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8960000000_8970000000 add constraint transaction_new_partition_8960000000_8970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8950000000_8960000000 add constraint transaction_new_partition_8950000000_8960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8940000000_8950000000 add constraint transaction_new_partition_8940000000_8950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8930000000_8940000000 add constraint transaction_new_partition_8930000000_8940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8920000000_8930000000 add constraint transaction_new_partition_8920000000_8930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8910000000_8920000000 add constraint transaction_new_partition_8910000000_8920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8900000000_8910000000 add constraint transaction_new_partition_8900000000_8910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8890000000_8900000000 add constraint transaction_new_partition_8890000000_8900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8880000000_8890000000 add constraint transaction_new_partition_8880000000_8890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8870000000_8880000000 add constraint transaction_new_partition_8870000000_8880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8860000000_8870000000 add constraint transaction_new_partition_8860000000_8870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8850000000_8860000000 add constraint transaction_new_partition_8850000000_8860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8840000000_8850000000 add constraint transaction_new_partition_8840000000_8850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8830000000_8840000000 add constraint transaction_new_partition_8830000000_8840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8820000000_8830000000 add constraint transaction_new_partition_8820000000_8830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8810000000_8820000000 add constraint transaction_new_partition_8810000000_8820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8800000000_8810000000 add constraint transaction_new_partition_8800000000_8810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8790000000_8800000000 add constraint transaction_new_partition_8790000000_8800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8780000000_8790000000 add constraint transaction_new_partition_8780000000_8790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8770000000_8780000000 add constraint transaction_new_partition_8770000000_8780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8760000000_8770000000 add constraint transaction_new_partition_8760000000_8770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8750000000_8760000000 add constraint transaction_new_partition_8750000000_8760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8740000000_8750000000 add constraint transaction_new_partition_8740000000_8750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8730000000_8740000000 add constraint transaction_new_partition_8730000000_8740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8720000000_8730000000 add constraint transaction_new_partition_8720000000_8730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8710000000_8720000000 add constraint transaction_new_partition_8710000000_8720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8700000000_8710000000 add constraint transaction_new_partition_8700000000_8710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8690000000_8700000000 add constraint transaction_new_partition_8690000000_8700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8680000000_8690000000 add constraint transaction_new_partition_8680000000_8690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8670000000_8680000000 add constraint transaction_new_partition_8670000000_8680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8660000000_8670000000 add constraint transaction_new_partition_8660000000_8670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8650000000_8660000000 add constraint transaction_new_partition_8650000000_8660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8640000000_8650000000 add constraint transaction_new_partition_8640000000_8650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8630000000_8640000000 add constraint transaction_new_partition_8630000000_8640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8620000000_8630000000 add constraint transaction_new_partition_8620000000_8630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8610000000_8620000000 add constraint transaction_new_partition_8610000000_8620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8600000000_8610000000 add constraint transaction_new_partition_8600000000_8610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8590000000_8600000000 add constraint transaction_new_partition_8590000000_8600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8580000000_8590000000 add constraint transaction_new_partition_8580000000_8590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8570000000_8580000000 add constraint transaction_new_partition_8570000000_8580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8560000000_8570000000 add constraint transaction_new_partition_8560000000_8570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8550000000_8560000000 add constraint transaction_new_partition_8550000000_8560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8540000000_8550000000 add constraint transaction_new_partition_8540000000_8550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8530000000_8540000000 add constraint transaction_new_partition_8530000000_8540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8520000000_8530000000 add constraint transaction_new_partition_8520000000_8530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8510000000_8520000000 add constraint transaction_new_partition_8510000000_8520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8500000000_8510000000 add constraint transaction_new_partition_8500000000_8510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8490000000_8500000000 add constraint transaction_new_partition_8490000000_8500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8480000000_8490000000 add constraint transaction_new_partition_8480000000_8490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8470000000_8480000000 add constraint transaction_new_partition_8470000000_8480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8460000000_8470000000 add constraint transaction_new_partition_8460000000_8470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8450000000_8460000000 add constraint transaction_new_partition_8450000000_8460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8440000000_8450000000 add constraint transaction_new_partition_8440000000_8450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8430000000_8440000000 add constraint transaction_new_partition_8430000000_8440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8420000000_8430000000 add constraint transaction_new_partition_8420000000_8430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8410000000_8420000000 add constraint transaction_new_partition_8410000000_8420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8400000000_8410000000 add constraint transaction_new_partition_8400000000_8410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8390000000_8400000000 add constraint transaction_new_partition_8390000000_8400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8380000000_8390000000 add constraint transaction_new_partition_8380000000_8390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8370000000_8380000000 add constraint transaction_new_partition_8370000000_8380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8360000000_8370000000 add constraint transaction_new_partition_8360000000_8370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8350000000_8360000000 add constraint transaction_new_partition_8350000000_8360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8340000000_8350000000 add constraint transaction_new_partition_8340000000_8350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8330000000_8340000000 add constraint transaction_new_partition_8330000000_8340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8320000000_8330000000 add constraint transaction_new_partition_8320000000_8330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8310000000_8320000000 add constraint transaction_new_partition_8310000000_8320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8300000000_8310000000 add constraint transaction_new_partition_8300000000_8310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8290000000_8300000000 add constraint transaction_new_partition_8290000000_8300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8280000000_8290000000 add constraint transaction_new_partition_8280000000_8290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8270000000_8280000000 add constraint transaction_new_partition_8270000000_8280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8260000000_8270000000 add constraint transaction_new_partition_8260000000_8270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8250000000_8260000000 add constraint transaction_new_partition_8250000000_8260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8240000000_8250000000 add constraint transaction_new_partition_8240000000_8250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8230000000_8240000000 add constraint transaction_new_partition_8230000000_8240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8220000000_8230000000 add constraint transaction_new_partition_8220000000_8230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8210000000_8220000000 add constraint transaction_new_partition_8210000000_8220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8200000000_8210000000 add constraint transaction_new_partition_8200000000_8210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8190000000_8200000000 add constraint transaction_new_partition_8190000000_8200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8180000000_8190000000 add constraint transaction_new_partition_8180000000_8190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8170000000_8180000000 add constraint transaction_new_partition_8170000000_8180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8160000000_8170000000 add constraint transaction_new_partition_8160000000_8170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8150000000_8160000000 add constraint transaction_new_partition_8150000000_8160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8140000000_8150000000 add constraint transaction_new_partition_8140000000_8150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8130000000_8140000000 add constraint transaction_new_partition_8130000000_8140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8120000000_8130000000 add constraint transaction_new_partition_8120000000_8130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8110000000_8120000000 add constraint transaction_new_partition_8110000000_8120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8100000000_8110000000 add constraint transaction_new_partition_8100000000_8110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8090000000_8100000000 add constraint transaction_new_partition_8090000000_8100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8080000000_8090000000 add constraint transaction_new_partition_8080000000_8090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8070000000_8080000000 add constraint transaction_new_partition_8070000000_8080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8060000000_8070000000 add constraint transaction_new_partition_8060000000_8070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8050000000_8060000000 add constraint transaction_new_partition_8050000000_8060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8040000000_8050000000 add constraint transaction_new_partition_8040000000_8050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8030000000_8040000000 add constraint transaction_new_partition_8030000000_8040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8020000000_8030000000 add constraint transaction_new_partition_8020000000_8030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8010000000_8020000000 add constraint transaction_new_partition_8010000000_8020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_8000000000_8010000000 add constraint transaction_new_partition_8000000000_8010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7990000000_8000000000 add constraint transaction_new_partition_7990000000_8000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7980000000_7990000000 add constraint transaction_new_partition_7980000000_7990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7970000000_7980000000 add constraint transaction_new_partition_7970000000_7980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7960000000_7970000000 add constraint transaction_new_partition_7960000000_7970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7950000000_7960000000 add constraint transaction_new_partition_7950000000_7960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7940000000_7950000000 add constraint transaction_new_partition_7940000000_7950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7930000000_7940000000 add constraint transaction_new_partition_7930000000_7940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7920000000_7930000000 add constraint transaction_new_partition_7920000000_7930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7910000000_7920000000 add constraint transaction_new_partition_7910000000_7920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7900000000_7910000000 add constraint transaction_new_partition_7900000000_7910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7890000000_7900000000 add constraint transaction_new_partition_7890000000_7900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7880000000_7890000000 add constraint transaction_new_partition_7880000000_7890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7870000000_7880000000 add constraint transaction_new_partition_7870000000_7880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7860000000_7870000000 add constraint transaction_new_partition_7860000000_7870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7850000000_7860000000 add constraint transaction_new_partition_7850000000_7860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7840000000_7850000000 add constraint transaction_new_partition_7840000000_7850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7830000000_7840000000 add constraint transaction_new_partition_7830000000_7840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7820000000_7830000000 add constraint transaction_new_partition_7820000000_7830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7810000000_7820000000 add constraint transaction_new_partition_7810000000_7820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7800000000_7810000000 add constraint transaction_new_partition_7800000000_7810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7790000000_7800000000 add constraint transaction_new_partition_7790000000_7800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7780000000_7790000000 add constraint transaction_new_partition_7780000000_7790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7770000000_7780000000 add constraint transaction_new_partition_7770000000_7780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7760000000_7770000000 add constraint transaction_new_partition_7760000000_7770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7750000000_7760000000 add constraint transaction_new_partition_7750000000_7760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7740000000_7750000000 add constraint transaction_new_partition_7740000000_7750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7730000000_7740000000 add constraint transaction_new_partition_7730000000_7740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7720000000_7730000000 add constraint transaction_new_partition_7720000000_7730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7710000000_7720000000 add constraint transaction_new_partition_7710000000_7720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7700000000_7710000000 add constraint transaction_new_partition_7700000000_7710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7690000000_7700000000 add constraint transaction_new_partition_7690000000_7700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7680000000_7690000000 add constraint transaction_new_partition_7680000000_7690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7670000000_7680000000 add constraint transaction_new_partition_7670000000_7680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7660000000_7670000000 add constraint transaction_new_partition_7660000000_7670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7650000000_7660000000 add constraint transaction_new_partition_7650000000_7660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7640000000_7650000000 add constraint transaction_new_partition_7640000000_7650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7630000000_7640000000 add constraint transaction_new_partition_7630000000_7640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7620000000_7630000000 add constraint transaction_new_partition_7620000000_7630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7610000000_7620000000 add constraint transaction_new_partition_7610000000_7620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7600000000_7610000000 add constraint transaction_new_partition_7600000000_7610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7590000000_7600000000 add constraint transaction_new_partition_7590000000_7600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7580000000_7590000000 add constraint transaction_new_partition_7580000000_7590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7570000000_7580000000 add constraint transaction_new_partition_7570000000_7580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7560000000_7570000000 add constraint transaction_new_partition_7560000000_7570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7550000000_7560000000 add constraint transaction_new_partition_7550000000_7560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7540000000_7550000000 add constraint transaction_new_partition_7540000000_7550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7530000000_7540000000 add constraint transaction_new_partition_7530000000_7540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7520000000_7530000000 add constraint transaction_new_partition_7520000000_7530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7510000000_7520000000 add constraint transaction_new_partition_7510000000_7520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7500000000_7510000000 add constraint transaction_new_partition_7500000000_7510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7490000000_7500000000 add constraint transaction_new_partition_7490000000_7500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7480000000_7490000000 add constraint transaction_new_partition_7480000000_7490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7470000000_7480000000 add constraint transaction_new_partition_7470000000_7480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7460000000_7470000000 add constraint transaction_new_partition_7460000000_7470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7450000000_7460000000 add constraint transaction_new_partition_7450000000_7460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7440000000_7450000000 add constraint transaction_new_partition_7440000000_7450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7430000000_7440000000 add constraint transaction_new_partition_7430000000_7440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7420000000_7430000000 add constraint transaction_new_partition_7420000000_7430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7410000000_7420000000 add constraint transaction_new_partition_7410000000_7420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7400000000_7410000000 add constraint transaction_new_partition_7400000000_7410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7390000000_7400000000 add constraint transaction_new_partition_7390000000_7400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7380000000_7390000000 add constraint transaction_new_partition_7380000000_7390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7370000000_7380000000 add constraint transaction_new_partition_7370000000_7380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7360000000_7370000000 add constraint transaction_new_partition_7360000000_7370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7350000000_7360000000 add constraint transaction_new_partition_7350000000_7360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7340000000_7350000000 add constraint transaction_new_partition_7340000000_7350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7330000000_7340000000 add constraint transaction_new_partition_7330000000_7340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7320000000_7330000000 add constraint transaction_new_partition_7320000000_7330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7310000000_7320000000 add constraint transaction_new_partition_7310000000_7320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7300000000_7310000000 add constraint transaction_new_partition_7300000000_7310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7290000000_7300000000 add constraint transaction_new_partition_7290000000_7300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7280000000_7290000000 add constraint transaction_new_partition_7280000000_7290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7270000000_7280000000 add constraint transaction_new_partition_7270000000_7280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7260000000_7270000000 add constraint transaction_new_partition_7260000000_7270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7250000000_7260000000 add constraint transaction_new_partition_7250000000_7260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7240000000_7250000000 add constraint transaction_new_partition_7240000000_7250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7230000000_7240000000 add constraint transaction_new_partition_7230000000_7240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7220000000_7230000000 add constraint transaction_new_partition_7220000000_7230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7210000000_7220000000 add constraint transaction_new_partition_7210000000_7220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7200000000_7210000000 add constraint transaction_new_partition_7200000000_7210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7190000000_7200000000 add constraint transaction_new_partition_7190000000_7200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7180000000_7190000000 add constraint transaction_new_partition_7180000000_7190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7170000000_7180000000 add constraint transaction_new_partition_7170000000_7180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7160000000_7170000000 add constraint transaction_new_partition_7160000000_7170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7150000000_7160000000 add constraint transaction_new_partition_7150000000_7160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7140000000_7150000000 add constraint transaction_new_partition_7140000000_7150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7130000000_7140000000 add constraint transaction_new_partition_7130000000_7140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7120000000_7130000000 add constraint transaction_new_partition_7120000000_7130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7110000000_7120000000 add constraint transaction_new_partition_7110000000_7120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7100000000_7110000000 add constraint transaction_new_partition_7100000000_7110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7090000000_7100000000 add constraint transaction_new_partition_7090000000_7100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7080000000_7090000000 add constraint transaction_new_partition_7080000000_7090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7070000000_7080000000 add constraint transaction_new_partition_7070000000_7080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7060000000_7070000000 add constraint transaction_new_partition_7060000000_7070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7050000000_7060000000 add constraint transaction_new_partition_7050000000_7060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7040000000_7050000000 add constraint transaction_new_partition_7040000000_7050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7030000000_7040000000 add constraint transaction_new_partition_7030000000_7040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7020000000_7030000000 add constraint transaction_new_partition_7020000000_7030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7010000000_7020000000 add constraint transaction_new_partition_7010000000_7020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_7000000000_7010000000 add constraint transaction_new_partition_7000000000_7010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6990000000_7000000000 add constraint transaction_new_partition_6990000000_7000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6980000000_6990000000 add constraint transaction_new_partition_6980000000_6990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6970000000_6980000000 add constraint transaction_new_partition_6970000000_6980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6960000000_6970000000 add constraint transaction_new_partition_6960000000_6970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6950000000_6960000000 add constraint transaction_new_partition_6950000000_6960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6940000000_6950000000 add constraint transaction_new_partition_6940000000_6950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6930000000_6940000000 add constraint transaction_new_partition_6930000000_6940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6920000000_6930000000 add constraint transaction_new_partition_6920000000_6930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6910000000_6920000000 add constraint transaction_new_partition_6910000000_6920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6900000000_6910000000 add constraint transaction_new_partition_6900000000_6910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6890000000_6900000000 add constraint transaction_new_partition_6890000000_6900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6880000000_6890000000 add constraint transaction_new_partition_6880000000_6890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6870000000_6880000000 add constraint transaction_new_partition_6870000000_6880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6860000000_6870000000 add constraint transaction_new_partition_6860000000_6870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6850000000_6860000000 add constraint transaction_new_partition_6850000000_6860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6840000000_6850000000 add constraint transaction_new_partition_6840000000_6850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6830000000_6840000000 add constraint transaction_new_partition_6830000000_6840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6820000000_6830000000 add constraint transaction_new_partition_6820000000_6830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6810000000_6820000000 add constraint transaction_new_partition_6810000000_6820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6800000000_6810000000 add constraint transaction_new_partition_6800000000_6810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6790000000_6800000000 add constraint transaction_new_partition_6790000000_6800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6780000000_6790000000 add constraint transaction_new_partition_6780000000_6790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6770000000_6780000000 add constraint transaction_new_partition_6770000000_6780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6760000000_6770000000 add constraint transaction_new_partition_6760000000_6770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6750000000_6760000000 add constraint transaction_new_partition_6750000000_6760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6740000000_6750000000 add constraint transaction_new_partition_6740000000_6750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6730000000_6740000000 add constraint transaction_new_partition_6730000000_6740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6720000000_6730000000 add constraint transaction_new_partition_6720000000_6730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6710000000_6720000000 add constraint transaction_new_partition_6710000000_6720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6700000000_6710000000 add constraint transaction_new_partition_6700000000_6710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6690000000_6700000000 add constraint transaction_new_partition_6690000000_6700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6680000000_6690000000 add constraint transaction_new_partition_6680000000_6690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6670000000_6680000000 add constraint transaction_new_partition_6670000000_6680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6660000000_6670000000 add constraint transaction_new_partition_6660000000_6670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6650000000_6660000000 add constraint transaction_new_partition_6650000000_6660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6640000000_6650000000 add constraint transaction_new_partition_6640000000_6650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6630000000_6640000000 add constraint transaction_new_partition_6630000000_6640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6620000000_6630000000 add constraint transaction_new_partition_6620000000_6630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6610000000_6620000000 add constraint transaction_new_partition_6610000000_6620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6600000000_6610000000 add constraint transaction_new_partition_6600000000_6610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6590000000_6600000000 add constraint transaction_new_partition_6590000000_6600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6580000000_6590000000 add constraint transaction_new_partition_6580000000_6590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6570000000_6580000000 add constraint transaction_new_partition_6570000000_6580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6560000000_6570000000 add constraint transaction_new_partition_6560000000_6570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6550000000_6560000000 add constraint transaction_new_partition_6550000000_6560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6540000000_6550000000 add constraint transaction_new_partition_6540000000_6550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6530000000_6540000000 add constraint transaction_new_partition_6530000000_6540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6520000000_6530000000 add constraint transaction_new_partition_6520000000_6530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6510000000_6520000000 add constraint transaction_new_partition_6510000000_6520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6500000000_6510000000 add constraint transaction_new_partition_6500000000_6510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6490000000_6500000000 add constraint transaction_new_partition_6490000000_6500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6480000000_6490000000 add constraint transaction_new_partition_6480000000_6490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6470000000_6480000000 add constraint transaction_new_partition_6470000000_6480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6460000000_6470000000 add constraint transaction_new_partition_6460000000_6470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6450000000_6460000000 add constraint transaction_new_partition_6450000000_6460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6440000000_6450000000 add constraint transaction_new_partition_6440000000_6450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6430000000_6440000000 add constraint transaction_new_partition_6430000000_6440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6420000000_6430000000 add constraint transaction_new_partition_6420000000_6430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6410000000_6420000000 add constraint transaction_new_partition_6410000000_6420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6400000000_6410000000 add constraint transaction_new_partition_6400000000_6410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6390000000_6400000000 add constraint transaction_new_partition_6390000000_6400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6380000000_6390000000 add constraint transaction_new_partition_6380000000_6390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6370000000_6380000000 add constraint transaction_new_partition_6370000000_6380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6360000000_6370000000 add constraint transaction_new_partition_6360000000_6370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6350000000_6360000000 add constraint transaction_new_partition_6350000000_6360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6340000000_6350000000 add constraint transaction_new_partition_6340000000_6350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6330000000_6340000000 add constraint transaction_new_partition_6330000000_6340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6320000000_6330000000 add constraint transaction_new_partition_6320000000_6330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6310000000_6320000000 add constraint transaction_new_partition_6310000000_6320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6300000000_6310000000 add constraint transaction_new_partition_6300000000_6310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6290000000_6300000000 add constraint transaction_new_partition_6290000000_6300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6280000000_6290000000 add constraint transaction_new_partition_6280000000_6290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6270000000_6280000000 add constraint transaction_new_partition_6270000000_6280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6260000000_6270000000 add constraint transaction_new_partition_6260000000_6270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6250000000_6260000000 add constraint transaction_new_partition_6250000000_6260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6240000000_6250000000 add constraint transaction_new_partition_6240000000_6250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6230000000_6240000000 add constraint transaction_new_partition_6230000000_6240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6220000000_6230000000 add constraint transaction_new_partition_6220000000_6230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6210000000_6220000000 add constraint transaction_new_partition_6210000000_6220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6200000000_6210000000 add constraint transaction_new_partition_6200000000_6210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6190000000_6200000000 add constraint transaction_new_partition_6190000000_6200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6180000000_6190000000 add constraint transaction_new_partition_6180000000_6190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6170000000_6180000000 add constraint transaction_new_partition_6170000000_6180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6160000000_6170000000 add constraint transaction_new_partition_6160000000_6170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6150000000_6160000000 add constraint transaction_new_partition_6150000000_6160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6140000000_6150000000 add constraint transaction_new_partition_6140000000_6150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6130000000_6140000000 add constraint transaction_new_partition_6130000000_6140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6120000000_6130000000 add constraint transaction_new_partition_6120000000_6130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6110000000_6120000000 add constraint transaction_new_partition_6110000000_6120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6100000000_6110000000 add constraint transaction_new_partition_6100000000_6110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6090000000_6100000000 add constraint transaction_new_partition_6090000000_6100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6080000000_6090000000 add constraint transaction_new_partition_6080000000_6090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6070000000_6080000000 add constraint transaction_new_partition_6070000000_6080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6060000000_6070000000 add constraint transaction_new_partition_6060000000_6070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6050000000_6060000000 add constraint transaction_new_partition_6050000000_6060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6040000000_6050000000 add constraint transaction_new_partition_6040000000_6050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6030000000_6040000000 add constraint transaction_new_partition_6030000000_6040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6020000000_6030000000 add constraint transaction_new_partition_6020000000_6030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6010000000_6020000000 add constraint transaction_new_partition_6010000000_6020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_6000000000_6010000000 add constraint transaction_new_partition_6000000000_6010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5990000000_6000000000 add constraint transaction_new_partition_5990000000_6000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5980000000_5990000000 add constraint transaction_new_partition_5980000000_5990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5970000000_5980000000 add constraint transaction_new_partition_5970000000_5980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5960000000_5970000000 add constraint transaction_new_partition_5960000000_5970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5950000000_5960000000 add constraint transaction_new_partition_5950000000_5960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5940000000_5950000000 add constraint transaction_new_partition_5940000000_5950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5930000000_5940000000 add constraint transaction_new_partition_5930000000_5940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5920000000_5930000000 add constraint transaction_new_partition_5920000000_5930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5910000000_5920000000 add constraint transaction_new_partition_5910000000_5920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5900000000_5910000000 add constraint transaction_new_partition_5900000000_5910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5890000000_5900000000 add constraint transaction_new_partition_5890000000_5900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5880000000_5890000000 add constraint transaction_new_partition_5880000000_5890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5870000000_5880000000 add constraint transaction_new_partition_5870000000_5880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5860000000_5870000000 add constraint transaction_new_partition_5860000000_5870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5850000000_5860000000 add constraint transaction_new_partition_5850000000_5860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5840000000_5850000000 add constraint transaction_new_partition_5840000000_5850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5830000000_5840000000 add constraint transaction_new_partition_5830000000_5840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5820000000_5830000000 add constraint transaction_new_partition_5820000000_5830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5810000000_5820000000 add constraint transaction_new_partition_5810000000_5820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5800000000_5810000000 add constraint transaction_new_partition_5800000000_5810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5790000000_5800000000 add constraint transaction_new_partition_5790000000_5800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5780000000_5790000000 add constraint transaction_new_partition_5780000000_5790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5770000000_5780000000 add constraint transaction_new_partition_5770000000_5780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5760000000_5770000000 add constraint transaction_new_partition_5760000000_5770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5750000000_5760000000 add constraint transaction_new_partition_5750000000_5760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5740000000_5750000000 add constraint transaction_new_partition_5740000000_5750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5730000000_5740000000 add constraint transaction_new_partition_5730000000_5740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5720000000_5730000000 add constraint transaction_new_partition_5720000000_5730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5710000000_5720000000 add constraint transaction_new_partition_5710000000_5720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5700000000_5710000000 add constraint transaction_new_partition_5700000000_5710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5690000000_5700000000 add constraint transaction_new_partition_5690000000_5700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5680000000_5690000000 add constraint transaction_new_partition_5680000000_5690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5670000000_5680000000 add constraint transaction_new_partition_5670000000_5680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5660000000_5670000000 add constraint transaction_new_partition_5660000000_5670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5650000000_5660000000 add constraint transaction_new_partition_5650000000_5660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5640000000_5650000000 add constraint transaction_new_partition_5640000000_5650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5630000000_5640000000 add constraint transaction_new_partition_5630000000_5640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5620000000_5630000000 add constraint transaction_new_partition_5620000000_5630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5610000000_5620000000 add constraint transaction_new_partition_5610000000_5620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5600000000_5610000000 add constraint transaction_new_partition_5600000000_5610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5590000000_5600000000 add constraint transaction_new_partition_5590000000_5600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5580000000_5590000000 add constraint transaction_new_partition_5580000000_5590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5570000000_5580000000 add constraint transaction_new_partition_5570000000_5580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5560000000_5570000000 add constraint transaction_new_partition_5560000000_5570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5550000000_5560000000 add constraint transaction_new_partition_5550000000_5560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5540000000_5550000000 add constraint transaction_new_partition_5540000000_5550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5530000000_5540000000 add constraint transaction_new_partition_5530000000_5540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5520000000_5530000000 add constraint transaction_new_partition_5520000000_5530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5510000000_5520000000 add constraint transaction_new_partition_5510000000_5520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5500000000_5510000000 add constraint transaction_new_partition_5500000000_5510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5490000000_5500000000 add constraint transaction_new_partition_5490000000_5500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5480000000_5490000000 add constraint transaction_new_partition_5480000000_5490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5470000000_5480000000 add constraint transaction_new_partition_5470000000_5480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5460000000_5470000000 add constraint transaction_new_partition_5460000000_5470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5450000000_5460000000 add constraint transaction_new_partition_5450000000_5460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5440000000_5450000000 add constraint transaction_new_partition_5440000000_5450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5430000000_5440000000 add constraint transaction_new_partition_5430000000_5440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5420000000_5430000000 add constraint transaction_new_partition_5420000000_5430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5410000000_5420000000 add constraint transaction_new_partition_5410000000_5420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5400000000_5410000000 add constraint transaction_new_partition_5400000000_5410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5390000000_5400000000 add constraint transaction_new_partition_5390000000_5400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5380000000_5390000000 add constraint transaction_new_partition_5380000000_5390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5370000000_5380000000 add constraint transaction_new_partition_5370000000_5380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5360000000_5370000000 add constraint transaction_new_partition_5360000000_5370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5350000000_5360000000 add constraint transaction_new_partition_5350000000_5360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5340000000_5350000000 add constraint transaction_new_partition_5340000000_5350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5330000000_5340000000 add constraint transaction_new_partition_5330000000_5340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5320000000_5330000000 add constraint transaction_new_partition_5320000000_5330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5310000000_5320000000 add constraint transaction_new_partition_5310000000_5320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5300000000_5310000000 add constraint transaction_new_partition_5300000000_5310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5290000000_5300000000 add constraint transaction_new_partition_5290000000_5300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5280000000_5290000000 add constraint transaction_new_partition_5280000000_5290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5270000000_5280000000 add constraint transaction_new_partition_5270000000_5280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5260000000_5270000000 add constraint transaction_new_partition_5260000000_5270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5250000000_5260000000 add constraint transaction_new_partition_5250000000_5260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5240000000_5250000000 add constraint transaction_new_partition_5240000000_5250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5230000000_5240000000 add constraint transaction_new_partition_5230000000_5240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5220000000_5230000000 add constraint transaction_new_partition_5220000000_5230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5210000000_5220000000 add constraint transaction_new_partition_5210000000_5220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5200000000_5210000000 add constraint transaction_new_partition_5200000000_5210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5190000000_5200000000 add constraint transaction_new_partition_5190000000_5200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5180000000_5190000000 add constraint transaction_new_partition_5180000000_5190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5170000000_5180000000 add constraint transaction_new_partition_5170000000_5180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5160000000_5170000000 add constraint transaction_new_partition_5160000000_5170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5150000000_5160000000 add constraint transaction_new_partition_5150000000_5160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5140000000_5150000000 add constraint transaction_new_partition_5140000000_5150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5130000000_5140000000 add constraint transaction_new_partition_5130000000_5140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5120000000_5130000000 add constraint transaction_new_partition_5120000000_5130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5110000000_5120000000 add constraint transaction_new_partition_5110000000_5120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5100000000_5110000000 add constraint transaction_new_partition_5100000000_5110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5090000000_5100000000 add constraint transaction_new_partition_5090000000_5100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5080000000_5090000000 add constraint transaction_new_partition_5080000000_5090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5070000000_5080000000 add constraint transaction_new_partition_5070000000_5080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5060000000_5070000000 add constraint transaction_new_partition_5060000000_5070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5050000000_5060000000 add constraint transaction_new_partition_5050000000_5060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5040000000_5050000000 add constraint transaction_new_partition_5040000000_5050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5030000000_5040000000 add constraint transaction_new_partition_5030000000_5040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5020000000_5030000000 add constraint transaction_new_partition_5020000000_5030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5010000000_5020000000 add constraint transaction_new_partition_5010000000_5020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_5000000000_5010000000 add constraint transaction_new_partition_5000000000_5010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4990000000_5000000000 add constraint transaction_new_partition_4990000000_5000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4980000000_4990000000 add constraint transaction_new_partition_4980000000_4990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4970000000_4980000000 add constraint transaction_new_partition_4970000000_4980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4960000000_4970000000 add constraint transaction_new_partition_4960000000_4970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4950000000_4960000000 add constraint transaction_new_partition_4950000000_4960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4940000000_4950000000 add constraint transaction_new_partition_4940000000_4950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4930000000_4940000000 add constraint transaction_new_partition_4930000000_4940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4920000000_4930000000 add constraint transaction_new_partition_4920000000_4930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4910000000_4920000000 add constraint transaction_new_partition_4910000000_4920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4900000000_4910000000 add constraint transaction_new_partition_4900000000_4910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4890000000_4900000000 add constraint transaction_new_partition_4890000000_4900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4880000000_4890000000 add constraint transaction_new_partition_4880000000_4890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4870000000_4880000000 add constraint transaction_new_partition_4870000000_4880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4860000000_4870000000 add constraint transaction_new_partition_4860000000_4870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4850000000_4860000000 add constraint transaction_new_partition_4850000000_4860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4840000000_4850000000 add constraint transaction_new_partition_4840000000_4850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4830000000_4840000000 add constraint transaction_new_partition_4830000000_4840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4820000000_4830000000 add constraint transaction_new_partition_4820000000_4830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4810000000_4820000000 add constraint transaction_new_partition_4810000000_4820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4800000000_4810000000 add constraint transaction_new_partition_4800000000_4810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4790000000_4800000000 add constraint transaction_new_partition_4790000000_4800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4780000000_4790000000 add constraint transaction_new_partition_4780000000_4790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4770000000_4780000000 add constraint transaction_new_partition_4770000000_4780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4760000000_4770000000 add constraint transaction_new_partition_4760000000_4770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4750000000_4760000000 add constraint transaction_new_partition_4750000000_4760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4740000000_4750000000 add constraint transaction_new_partition_4740000000_4750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4730000000_4740000000 add constraint transaction_new_partition_4730000000_4740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4720000000_4730000000 add constraint transaction_new_partition_4720000000_4730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4710000000_4720000000 add constraint transaction_new_partition_4710000000_4720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4700000000_4710000000 add constraint transaction_new_partition_4700000000_4710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4690000000_4700000000 add constraint transaction_new_partition_4690000000_4700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4680000000_4690000000 add constraint transaction_new_partition_4680000000_4690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4670000000_4680000000 add constraint transaction_new_partition_4670000000_4680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4660000000_4670000000 add constraint transaction_new_partition_4660000000_4670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4650000000_4660000000 add constraint transaction_new_partition_4650000000_4660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4640000000_4650000000 add constraint transaction_new_partition_4640000000_4650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4630000000_4640000000 add constraint transaction_new_partition_4630000000_4640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4620000000_4630000000 add constraint transaction_new_partition_4620000000_4630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4610000000_4620000000 add constraint transaction_new_partition_4610000000_4620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4600000000_4610000000 add constraint transaction_new_partition_4600000000_4610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4590000000_4600000000 add constraint transaction_new_partition_4590000000_4600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4580000000_4590000000 add constraint transaction_new_partition_4580000000_4590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4570000000_4580000000 add constraint transaction_new_partition_4570000000_4580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4560000000_4570000000 add constraint transaction_new_partition_4560000000_4570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4550000000_4560000000 add constraint transaction_new_partition_4550000000_4560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4540000000_4550000000 add constraint transaction_new_partition_4540000000_4550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4530000000_4540000000 add constraint transaction_new_partition_4530000000_4540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4520000000_4530000000 add constraint transaction_new_partition_4520000000_4530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4510000000_4520000000 add constraint transaction_new_partition_4510000000_4520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4500000000_4510000000 add constraint transaction_new_partition_4500000000_4510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4490000000_4500000000 add constraint transaction_new_partition_4490000000_4500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4480000000_4490000000 add constraint transaction_new_partition_4480000000_4490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4470000000_4480000000 add constraint transaction_new_partition_4470000000_4480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4460000000_4470000000 add constraint transaction_new_partition_4460000000_4470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4450000000_4460000000 add constraint transaction_new_partition_4450000000_4460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4440000000_4450000000 add constraint transaction_new_partition_4440000000_4450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4430000000_4440000000 add constraint transaction_new_partition_4430000000_4440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4420000000_4430000000 add constraint transaction_new_partition_4420000000_4430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4410000000_4420000000 add constraint transaction_new_partition_4410000000_4420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4400000000_4410000000 add constraint transaction_new_partition_4400000000_4410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4390000000_4400000000 add constraint transaction_new_partition_4390000000_4400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4380000000_4390000000 add constraint transaction_new_partition_4380000000_4390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4370000000_4380000000 add constraint transaction_new_partition_4370000000_4380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4360000000_4370000000 add constraint transaction_new_partition_4360000000_4370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4350000000_4360000000 add constraint transaction_new_partition_4350000000_4360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4340000000_4350000000 add constraint transaction_new_partition_4340000000_4350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4330000000_4340000000 add constraint transaction_new_partition_4330000000_4340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4320000000_4330000000 add constraint transaction_new_partition_4320000000_4330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4310000000_4320000000 add constraint transaction_new_partition_4310000000_4320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4300000000_4310000000 add constraint transaction_new_partition_4300000000_4310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4290000000_4300000000 add constraint transaction_new_partition_4290000000_4300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4280000000_4290000000 add constraint transaction_new_partition_4280000000_4290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4270000000_4280000000 add constraint transaction_new_partition_4270000000_4280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4260000000_4270000000 add constraint transaction_new_partition_4260000000_4270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4250000000_4260000000 add constraint transaction_new_partition_4250000000_4260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4240000000_4250000000 add constraint transaction_new_partition_4240000000_4250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4230000000_4240000000 add constraint transaction_new_partition_4230000000_4240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4220000000_4230000000 add constraint transaction_new_partition_4220000000_4230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4210000000_4220000000 add constraint transaction_new_partition_4210000000_4220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4200000000_4210000000 add constraint transaction_new_partition_4200000000_4210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4190000000_4200000000 add constraint transaction_new_partition_4190000000_4200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4180000000_4190000000 add constraint transaction_new_partition_4180000000_4190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4170000000_4180000000 add constraint transaction_new_partition_4170000000_4180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4160000000_4170000000 add constraint transaction_new_partition_4160000000_4170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4150000000_4160000000 add constraint transaction_new_partition_4150000000_4160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4140000000_4150000000 add constraint transaction_new_partition_4140000000_4150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4130000000_4140000000 add constraint transaction_new_partition_4130000000_4140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4120000000_4130000000 add constraint transaction_new_partition_4120000000_4130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4110000000_4120000000 add constraint transaction_new_partition_4110000000_4120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4100000000_4110000000 add constraint transaction_new_partition_4100000000_4110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4090000000_4100000000 add constraint transaction_new_partition_4090000000_4100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4080000000_4090000000 add constraint transaction_new_partition_4080000000_4090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4070000000_4080000000 add constraint transaction_new_partition_4070000000_4080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4060000000_4070000000 add constraint transaction_new_partition_4060000000_4070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4050000000_4060000000 add constraint transaction_new_partition_4050000000_4060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4040000000_4050000000 add constraint transaction_new_partition_4040000000_4050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4030000000_4040000000 add constraint transaction_new_partition_4030000000_4040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4020000000_4030000000 add constraint transaction_new_partition_4020000000_4030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4010000000_4020000000 add constraint transaction_new_partition_4010000000_4020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_4000000000_4010000000 add constraint transaction_new_partition_4000000000_4010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3990000000_4000000000 add constraint transaction_new_partition_3990000000_4000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3980000000_3990000000 add constraint transaction_new_partition_3980000000_3990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3970000000_3980000000 add constraint transaction_new_partition_3970000000_3980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3960000000_3970000000 add constraint transaction_new_partition_3960000000_3970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3950000000_3960000000 add constraint transaction_new_partition_3950000000_3960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3940000000_3950000000 add constraint transaction_new_partition_3940000000_3950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3930000000_3940000000 add constraint transaction_new_partition_3930000000_3940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3920000000_3930000000 add constraint transaction_new_partition_3920000000_3930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3910000000_3920000000 add constraint transaction_new_partition_3910000000_3920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3900000000_3910000000 add constraint transaction_new_partition_3900000000_3910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3890000000_3900000000 add constraint transaction_new_partition_3890000000_3900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3880000000_3890000000 add constraint transaction_new_partition_3880000000_3890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3870000000_3880000000 add constraint transaction_new_partition_3870000000_3880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3860000000_3870000000 add constraint transaction_new_partition_3860000000_3870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3850000000_3860000000 add constraint transaction_new_partition_3850000000_3860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3840000000_3850000000 add constraint transaction_new_partition_3840000000_3850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3830000000_3840000000 add constraint transaction_new_partition_3830000000_3840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3820000000_3830000000 add constraint transaction_new_partition_3820000000_3830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3810000000_3820000000 add constraint transaction_new_partition_3810000000_3820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3800000000_3810000000 add constraint transaction_new_partition_3800000000_3810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3790000000_3800000000 add constraint transaction_new_partition_3790000000_3800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3780000000_3790000000 add constraint transaction_new_partition_3780000000_3790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3770000000_3780000000 add constraint transaction_new_partition_3770000000_3780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3760000000_3770000000 add constraint transaction_new_partition_3760000000_3770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3750000000_3760000000 add constraint transaction_new_partition_3750000000_3760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3740000000_3750000000 add constraint transaction_new_partition_3740000000_3750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3730000000_3740000000 add constraint transaction_new_partition_3730000000_3740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3720000000_3730000000 add constraint transaction_new_partition_3720000000_3730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3710000000_3720000000 add constraint transaction_new_partition_3710000000_3720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3700000000_3710000000 add constraint transaction_new_partition_3700000000_3710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3690000000_3700000000 add constraint transaction_new_partition_3690000000_3700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3680000000_3690000000 add constraint transaction_new_partition_3680000000_3690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3670000000_3680000000 add constraint transaction_new_partition_3670000000_3680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3660000000_3670000000 add constraint transaction_new_partition_3660000000_3670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3650000000_3660000000 add constraint transaction_new_partition_3650000000_3660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3640000000_3650000000 add constraint transaction_new_partition_3640000000_3650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3630000000_3640000000 add constraint transaction_new_partition_3630000000_3640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3620000000_3630000000 add constraint transaction_new_partition_3620000000_3630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3610000000_3620000000 add constraint transaction_new_partition_3610000000_3620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3600000000_3610000000 add constraint transaction_new_partition_3600000000_3610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3590000000_3600000000 add constraint transaction_new_partition_3590000000_3600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3580000000_3590000000 add constraint transaction_new_partition_3580000000_3590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3570000000_3580000000 add constraint transaction_new_partition_3570000000_3580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3560000000_3570000000 add constraint transaction_new_partition_3560000000_3570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3550000000_3560000000 add constraint transaction_new_partition_3550000000_3560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3540000000_3550000000 add constraint transaction_new_partition_3540000000_3550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3530000000_3540000000 add constraint transaction_new_partition_3530000000_3540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3520000000_3530000000 add constraint transaction_new_partition_3520000000_3530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3510000000_3520000000 add constraint transaction_new_partition_3510000000_3520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3500000000_3510000000 add constraint transaction_new_partition_3500000000_3510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3490000000_3500000000 add constraint transaction_new_partition_3490000000_3500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3480000000_3490000000 add constraint transaction_new_partition_3480000000_3490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3470000000_3480000000 add constraint transaction_new_partition_3470000000_3480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3460000000_3470000000 add constraint transaction_new_partition_3460000000_3470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3450000000_3460000000 add constraint transaction_new_partition_3450000000_3460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3440000000_3450000000 add constraint transaction_new_partition_3440000000_3450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3430000000_3440000000 add constraint transaction_new_partition_3430000000_3440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3420000000_3430000000 add constraint transaction_new_partition_3420000000_3430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3410000000_3420000000 add constraint transaction_new_partition_3410000000_3420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3400000000_3410000000 add constraint transaction_new_partition_3400000000_3410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3390000000_3400000000 add constraint transaction_new_partition_3390000000_3400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3380000000_3390000000 add constraint transaction_new_partition_3380000000_3390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3370000000_3380000000 add constraint transaction_new_partition_3370000000_3380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3360000000_3370000000 add constraint transaction_new_partition_3360000000_3370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3350000000_3360000000 add constraint transaction_new_partition_3350000000_3360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3340000000_3350000000 add constraint transaction_new_partition_3340000000_3350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3330000000_3340000000 add constraint transaction_new_partition_3330000000_3340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3320000000_3330000000 add constraint transaction_new_partition_3320000000_3330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3310000000_3320000000 add constraint transaction_new_partition_3310000000_3320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3300000000_3310000000 add constraint transaction_new_partition_3300000000_3310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3290000000_3300000000 add constraint transaction_new_partition_3290000000_3300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3280000000_3290000000 add constraint transaction_new_partition_3280000000_3290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3270000000_3280000000 add constraint transaction_new_partition_3270000000_3280000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3260000000_3270000000 add constraint transaction_new_partition_3260000000_3270000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3250000000_3260000000 add constraint transaction_new_partition_3250000000_3260000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3240000000_3250000000 add constraint transaction_new_partition_3240000000_3250000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3230000000_3240000000 add constraint transaction_new_partition_3230000000_3240000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3220000000_3230000000 add constraint transaction_new_partition_3220000000_3230000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3210000000_3220000000 add constraint transaction_new_partition_3210000000_3220000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3200000000_3210000000 add constraint transaction_new_partition_3200000000_3210000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3190000000_3200000000 add constraint transaction_new_partition_3190000000_3200000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3180000000_3190000000 add constraint transaction_new_partition_3180000000_3190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3170000000_3180000000 add constraint transaction_new_partition_3170000000_3180000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3160000000_3170000000 add constraint transaction_new_partition_3160000000_3170000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3150000000_3160000000 add constraint transaction_new_partition_3150000000_3160000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3140000000_3150000000 add constraint transaction_new_partition_3140000000_3150000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3130000000_3140000000 add constraint transaction_new_partition_3130000000_3140000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3120000000_3130000000 add constraint transaction_new_partition_3120000000_3130000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3110000000_3120000000 add constraint transaction_new_partition_3110000000_3120000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3100000000_3110000000 add constraint transaction_new_partition_3100000000_3110000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3090000000_3100000000 add constraint transaction_new_partition_3090000000_3100000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3080000000_3090000000 add constraint transaction_new_partition_3080000000_3090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3070000000_3080000000 add constraint transaction_new_partition_3070000000_3080000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3060000000_3070000000 add constraint transaction_new_partition_3060000000_3070000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3050000000_3060000000 add constraint transaction_new_partition_3050000000_3060000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3040000000_3050000000 add constraint transaction_new_partition_3040000000_3050000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3030000000_3040000000 add constraint transaction_new_partition_3030000000_3040000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3020000000_3030000000 add constraint transaction_new_partition_3020000000_3030000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3010000000_3020000000 add constraint transaction_new_partition_3010000000_3020000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_3000000000_3010000000 add constraint transaction_new_partition_3000000000_3010000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2990000000_3000000000 add constraint transaction_new_partition_2990000000_3000000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2980000000_2990000000 add constraint transaction_new_partition_2980000000_2990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2970000000_2980000000 add constraint transaction_new_partition_2970000000_2980000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2960000000_2970000000 add constraint transaction_new_partition_2960000000_2970000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2950000000_2960000000 add constraint transaction_new_partition_2950000000_2960000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2940000000_2950000000 add constraint transaction_new_partition_2940000000_2950000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2930000000_2940000000 add constraint transaction_new_partition_2930000000_2940000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2920000000_2930000000 add constraint transaction_new_partition_2920000000_2930000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2910000000_2920000000 add constraint transaction_new_partition_2910000000_2920000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2900000000_2910000000 add constraint transaction_new_partition_2900000000_2910000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2890000000_2900000000 add constraint transaction_new_partition_2890000000_2900000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2880000000_2890000000 add constraint transaction_new_partition_2880000000_2890000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2870000000_2880000000 add constraint transaction_new_partition_2870000000_2880000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2860000000_2870000000 add constraint transaction_new_partition_2860000000_2870000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2850000000_2860000000 add constraint transaction_new_partition_2850000000_2860000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2840000000_2850000000 add constraint transaction_new_partition_2840000000_2850000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2830000000_2840000000 add constraint transaction_new_partition_2830000000_2840000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2820000000_2830000000 add constraint transaction_new_partition_2820000000_2830000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2810000000_2820000000 add constraint transaction_new_partition_2810000000_2820000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2800000000_2810000000 add constraint transaction_new_partition_2800000000_2810000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2790000000_2800000000 add constraint transaction_new_partition_2790000000_2800000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2780000000_2790000000 add constraint transaction_new_partition_2780000000_2790000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2770000000_2780000000 add constraint transaction_new_partition_2770000000_2780000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2760000000_2770000000 add constraint transaction_new_partition_2760000000_2770000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2750000000_2760000000 add constraint transaction_new_partition_2750000000_2760000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2740000000_2750000000 add constraint transaction_new_partition_2740000000_2750000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2730000000_2740000000 add constraint transaction_new_partition_2730000000_2740000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2720000000_2730000000 add constraint transaction_new_partition_2720000000_2730000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2710000000_2720000000 add constraint transaction_new_partition_2710000000_2720000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2700000000_2710000000 add constraint transaction_new_partition_2700000000_2710000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2690000000_2700000000 add constraint transaction_new_partition_2690000000_2700000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2680000000_2690000000 add constraint transaction_new_partition_2680000000_2690000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2670000000_2680000000 add constraint transaction_new_partition_2670000000_2680000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2660000000_2670000000 add constraint transaction_new_partition_2660000000_2670000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2650000000_2660000000 add constraint transaction_new_partition_2650000000_2660000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2640000000_2650000000 add constraint transaction_new_partition_2640000000_2650000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2630000000_2640000000 add constraint transaction_new_partition_2630000000_2640000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2620000000_2630000000 add constraint transaction_new_partition_2620000000_2630000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2610000000_2620000000 add constraint transaction_new_partition_2610000000_2620000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2600000000_2610000000 add constraint transaction_new_partition_2600000000_2610000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2590000000_2600000000 add constraint transaction_new_partition_2590000000_2600000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2580000000_2590000000 add constraint transaction_new_partition_2580000000_2590000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2570000000_2580000000 add constraint transaction_new_partition_2570000000_2580000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2560000000_2570000000 add constraint transaction_new_partition_2560000000_2570000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2550000000_2560000000 add constraint transaction_new_partition_2550000000_2560000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2540000000_2550000000 add constraint transaction_new_partition_2540000000_2550000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2530000000_2540000000 add constraint transaction_new_partition_2530000000_2540000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2520000000_2530000000 add constraint transaction_new_partition_2520000000_2530000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2510000000_2520000000 add constraint transaction_new_partition_2510000000_2520000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2500000000_2510000000 add constraint transaction_new_partition_2500000000_2510000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2490000000_2500000000 add constraint transaction_new_partition_2490000000_2500000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2480000000_2490000000 add constraint transaction_new_partition_2480000000_2490000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2470000000_2480000000 add constraint transaction_new_partition_2470000000_2480000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2460000000_2470000000 add constraint transaction_new_partition_2460000000_2470000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2450000000_2460000000 add constraint transaction_new_partition_2450000000_2460000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2440000000_2450000000 add constraint transaction_new_partition_2440000000_2450000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2430000000_2440000000 add constraint transaction_new_partition_2430000000_2440000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2420000000_2430000000 add constraint transaction_new_partition_2420000000_2430000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2410000000_2420000000 add constraint transaction_new_partition_2410000000_2420000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2400000000_2410000000 add constraint transaction_new_partition_2400000000_2410000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2390000000_2400000000 add constraint transaction_new_partition_2390000000_2400000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2380000000_2390000000 add constraint transaction_new_partition_2380000000_2390000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2370000000_2380000000 add constraint transaction_new_partition_2370000000_2380000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2360000000_2370000000 add constraint transaction_new_partition_2360000000_2370000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2350000000_2360000000 add constraint transaction_new_partition_2350000000_2360000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2340000000_2350000000 add constraint transaction_new_partition_2340000000_2350000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2330000000_2340000000 add constraint transaction_new_partition_2330000000_2340000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2320000000_2330000000 add constraint transaction_new_partition_2320000000_2330000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2310000000_2320000000 add constraint transaction_new_partition_2310000000_2320000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2300000000_2310000000 add constraint transaction_new_partition_2300000000_2310000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2290000000_2300000000 add constraint transaction_new_partition_2290000000_2300000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2190000000_2290000000 add constraint transaction_new_partition_2190000000_2290000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_2090000000_2190000000 add constraint transaction_new_partition_2090000000_2190000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_1990000000_2090000000 add constraint transaction_new_partition_1990000000_2090000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_1984000000_1990000000 add constraint transaction_new_partition_1984000000_1990000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;
alter table transaction_new_partition_0_1984000000 add constraint transaction_new_partition_0_1984000000_pkey PRIMARY KEY (idt_transaction) USING INDEX TABLESPACE tsifidc01;

----------------------------------
-- cria indice 1 da tabela nova --	
----------------------------------

CREATE INDEX transaction_new_partition_9980000000_9990000000_dat_escrow  ON fidc_adm.transaction_new_partition_9980000000_9990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9970000000_9980000000_dat_escrow  ON fidc_adm.transaction_new_partition_9970000000_9980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9960000000_9970000000_dat_escrow  ON fidc_adm.transaction_new_partition_9960000000_9970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9950000000_9960000000_dat_escrow  ON fidc_adm.transaction_new_partition_9950000000_9960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9940000000_9950000000_dat_escrow  ON fidc_adm.transaction_new_partition_9940000000_9950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9930000000_9940000000_dat_escrow  ON fidc_adm.transaction_new_partition_9930000000_9940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9920000000_9930000000_dat_escrow  ON fidc_adm.transaction_new_partition_9920000000_9930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9910000000_9920000000_dat_escrow  ON fidc_adm.transaction_new_partition_9910000000_9920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9900000000_9910000000_dat_escrow  ON fidc_adm.transaction_new_partition_9900000000_9910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9890000000_9900000000_dat_escrow  ON fidc_adm.transaction_new_partition_9890000000_9900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9880000000_9890000000_dat_escrow  ON fidc_adm.transaction_new_partition_9880000000_9890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9870000000_9880000000_dat_escrow  ON fidc_adm.transaction_new_partition_9870000000_9880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9860000000_9870000000_dat_escrow  ON fidc_adm.transaction_new_partition_9860000000_9870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9850000000_9860000000_dat_escrow  ON fidc_adm.transaction_new_partition_9850000000_9860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9840000000_9850000000_dat_escrow  ON fidc_adm.transaction_new_partition_9840000000_9850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9830000000_9840000000_dat_escrow  ON fidc_adm.transaction_new_partition_9830000000_9840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9820000000_9830000000_dat_escrow  ON fidc_adm.transaction_new_partition_9820000000_9830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9810000000_9820000000_dat_escrow  ON fidc_adm.transaction_new_partition_9810000000_9820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9800000000_9810000000_dat_escrow  ON fidc_adm.transaction_new_partition_9800000000_9810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9790000000_9800000000_dat_escrow  ON fidc_adm.transaction_new_partition_9790000000_9800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9780000000_9790000000_dat_escrow  ON fidc_adm.transaction_new_partition_9780000000_9790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9770000000_9780000000_dat_escrow  ON fidc_adm.transaction_new_partition_9770000000_9780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9760000000_9770000000_dat_escrow  ON fidc_adm.transaction_new_partition_9760000000_9770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9750000000_9760000000_dat_escrow  ON fidc_adm.transaction_new_partition_9750000000_9760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9740000000_9750000000_dat_escrow  ON fidc_adm.transaction_new_partition_9740000000_9750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9730000000_9740000000_dat_escrow  ON fidc_adm.transaction_new_partition_9730000000_9740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9720000000_9730000000_dat_escrow  ON fidc_adm.transaction_new_partition_9720000000_9730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9710000000_9720000000_dat_escrow  ON fidc_adm.transaction_new_partition_9710000000_9720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9700000000_9710000000_dat_escrow  ON fidc_adm.transaction_new_partition_9700000000_9710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9690000000_9700000000_dat_escrow  ON fidc_adm.transaction_new_partition_9690000000_9700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9680000000_9690000000_dat_escrow  ON fidc_adm.transaction_new_partition_9680000000_9690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9670000000_9680000000_dat_escrow  ON fidc_adm.transaction_new_partition_9670000000_9680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9660000000_9670000000_dat_escrow  ON fidc_adm.transaction_new_partition_9660000000_9670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9650000000_9660000000_dat_escrow  ON fidc_adm.transaction_new_partition_9650000000_9660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9640000000_9650000000_dat_escrow  ON fidc_adm.transaction_new_partition_9640000000_9650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9630000000_9640000000_dat_escrow  ON fidc_adm.transaction_new_partition_9630000000_9640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9620000000_9630000000_dat_escrow  ON fidc_adm.transaction_new_partition_9620000000_9630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9610000000_9620000000_dat_escrow  ON fidc_adm.transaction_new_partition_9610000000_9620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9600000000_9610000000_dat_escrow  ON fidc_adm.transaction_new_partition_9600000000_9610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9590000000_9600000000_dat_escrow  ON fidc_adm.transaction_new_partition_9590000000_9600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9580000000_9590000000_dat_escrow  ON fidc_adm.transaction_new_partition_9580000000_9590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9570000000_9580000000_dat_escrow  ON fidc_adm.transaction_new_partition_9570000000_9580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9560000000_9570000000_dat_escrow  ON fidc_adm.transaction_new_partition_9560000000_9570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9550000000_9560000000_dat_escrow  ON fidc_adm.transaction_new_partition_9550000000_9560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9540000000_9550000000_dat_escrow  ON fidc_adm.transaction_new_partition_9540000000_9550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9530000000_9540000000_dat_escrow  ON fidc_adm.transaction_new_partition_9530000000_9540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9520000000_9530000000_dat_escrow  ON fidc_adm.transaction_new_partition_9520000000_9530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9510000000_9520000000_dat_escrow  ON fidc_adm.transaction_new_partition_9510000000_9520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9500000000_9510000000_dat_escrow  ON fidc_adm.transaction_new_partition_9500000000_9510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9490000000_9500000000_dat_escrow  ON fidc_adm.transaction_new_partition_9490000000_9500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9480000000_9490000000_dat_escrow  ON fidc_adm.transaction_new_partition_9480000000_9490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9470000000_9480000000_dat_escrow  ON fidc_adm.transaction_new_partition_9470000000_9480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9460000000_9470000000_dat_escrow  ON fidc_adm.transaction_new_partition_9460000000_9470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9450000000_9460000000_dat_escrow  ON fidc_adm.transaction_new_partition_9450000000_9460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9440000000_9450000000_dat_escrow  ON fidc_adm.transaction_new_partition_9440000000_9450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9430000000_9440000000_dat_escrow  ON fidc_adm.transaction_new_partition_9430000000_9440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9420000000_9430000000_dat_escrow  ON fidc_adm.transaction_new_partition_9420000000_9430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9410000000_9420000000_dat_escrow  ON fidc_adm.transaction_new_partition_9410000000_9420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9400000000_9410000000_dat_escrow  ON fidc_adm.transaction_new_partition_9400000000_9410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9390000000_9400000000_dat_escrow  ON fidc_adm.transaction_new_partition_9390000000_9400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9380000000_9390000000_dat_escrow  ON fidc_adm.transaction_new_partition_9380000000_9390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9370000000_9380000000_dat_escrow  ON fidc_adm.transaction_new_partition_9370000000_9380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9360000000_9370000000_dat_escrow  ON fidc_adm.transaction_new_partition_9360000000_9370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9350000000_9360000000_dat_escrow  ON fidc_adm.transaction_new_partition_9350000000_9360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9340000000_9350000000_dat_escrow  ON fidc_adm.transaction_new_partition_9340000000_9350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9330000000_9340000000_dat_escrow  ON fidc_adm.transaction_new_partition_9330000000_9340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9320000000_9330000000_dat_escrow  ON fidc_adm.transaction_new_partition_9320000000_9330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9310000000_9320000000_dat_escrow  ON fidc_adm.transaction_new_partition_9310000000_9320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9300000000_9310000000_dat_escrow  ON fidc_adm.transaction_new_partition_9300000000_9310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9290000000_9300000000_dat_escrow  ON fidc_adm.transaction_new_partition_9290000000_9300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9280000000_9290000000_dat_escrow  ON fidc_adm.transaction_new_partition_9280000000_9290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9270000000_9280000000_dat_escrow  ON fidc_adm.transaction_new_partition_9270000000_9280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9260000000_9270000000_dat_escrow  ON fidc_adm.transaction_new_partition_9260000000_9270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9250000000_9260000000_dat_escrow  ON fidc_adm.transaction_new_partition_9250000000_9260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9240000000_9250000000_dat_escrow  ON fidc_adm.transaction_new_partition_9240000000_9250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9230000000_9240000000_dat_escrow  ON fidc_adm.transaction_new_partition_9230000000_9240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9220000000_9230000000_dat_escrow  ON fidc_adm.transaction_new_partition_9220000000_9230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9210000000_9220000000_dat_escrow  ON fidc_adm.transaction_new_partition_9210000000_9220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9200000000_9210000000_dat_escrow  ON fidc_adm.transaction_new_partition_9200000000_9210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9190000000_9200000000_dat_escrow  ON fidc_adm.transaction_new_partition_9190000000_9200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9180000000_9190000000_dat_escrow  ON fidc_adm.transaction_new_partition_9180000000_9190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9170000000_9180000000_dat_escrow  ON fidc_adm.transaction_new_partition_9170000000_9180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9160000000_9170000000_dat_escrow  ON fidc_adm.transaction_new_partition_9160000000_9170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9150000000_9160000000_dat_escrow  ON fidc_adm.transaction_new_partition_9150000000_9160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9140000000_9150000000_dat_escrow  ON fidc_adm.transaction_new_partition_9140000000_9150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9130000000_9140000000_dat_escrow  ON fidc_adm.transaction_new_partition_9130000000_9140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9120000000_9130000000_dat_escrow  ON fidc_adm.transaction_new_partition_9120000000_9130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9110000000_9120000000_dat_escrow  ON fidc_adm.transaction_new_partition_9110000000_9120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9100000000_9110000000_dat_escrow  ON fidc_adm.transaction_new_partition_9100000000_9110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9090000000_9100000000_dat_escrow  ON fidc_adm.transaction_new_partition_9090000000_9100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9080000000_9090000000_dat_escrow  ON fidc_adm.transaction_new_partition_9080000000_9090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9070000000_9080000000_dat_escrow  ON fidc_adm.transaction_new_partition_9070000000_9080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9060000000_9070000000_dat_escrow  ON fidc_adm.transaction_new_partition_9060000000_9070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9050000000_9060000000_dat_escrow  ON fidc_adm.transaction_new_partition_9050000000_9060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9040000000_9050000000_dat_escrow  ON fidc_adm.transaction_new_partition_9040000000_9050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9030000000_9040000000_dat_escrow  ON fidc_adm.transaction_new_partition_9030000000_9040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9020000000_9030000000_dat_escrow  ON fidc_adm.transaction_new_partition_9020000000_9030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9010000000_9020000000_dat_escrow  ON fidc_adm.transaction_new_partition_9010000000_9020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_9000000000_9010000000_dat_escrow  ON fidc_adm.transaction_new_partition_9000000000_9010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8990000000_9000000000_dat_escrow  ON fidc_adm.transaction_new_partition_8990000000_9000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8980000000_8990000000_dat_escrow  ON fidc_adm.transaction_new_partition_8980000000_8990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8970000000_8980000000_dat_escrow  ON fidc_adm.transaction_new_partition_8970000000_8980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8960000000_8970000000_dat_escrow  ON fidc_adm.transaction_new_partition_8960000000_8970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8950000000_8960000000_dat_escrow  ON fidc_adm.transaction_new_partition_8950000000_8960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8940000000_8950000000_dat_escrow  ON fidc_adm.transaction_new_partition_8940000000_8950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8930000000_8940000000_dat_escrow  ON fidc_adm.transaction_new_partition_8930000000_8940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8920000000_8930000000_dat_escrow  ON fidc_adm.transaction_new_partition_8920000000_8930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8910000000_8920000000_dat_escrow  ON fidc_adm.transaction_new_partition_8910000000_8920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8900000000_8910000000_dat_escrow  ON fidc_adm.transaction_new_partition_8900000000_8910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8890000000_8900000000_dat_escrow  ON fidc_adm.transaction_new_partition_8890000000_8900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8880000000_8890000000_dat_escrow  ON fidc_adm.transaction_new_partition_8880000000_8890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8870000000_8880000000_dat_escrow  ON fidc_adm.transaction_new_partition_8870000000_8880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8860000000_8870000000_dat_escrow  ON fidc_adm.transaction_new_partition_8860000000_8870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8850000000_8860000000_dat_escrow  ON fidc_adm.transaction_new_partition_8850000000_8860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8840000000_8850000000_dat_escrow  ON fidc_adm.transaction_new_partition_8840000000_8850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8830000000_8840000000_dat_escrow  ON fidc_adm.transaction_new_partition_8830000000_8840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8820000000_8830000000_dat_escrow  ON fidc_adm.transaction_new_partition_8820000000_8830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8810000000_8820000000_dat_escrow  ON fidc_adm.transaction_new_partition_8810000000_8820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8800000000_8810000000_dat_escrow  ON fidc_adm.transaction_new_partition_8800000000_8810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8790000000_8800000000_dat_escrow  ON fidc_adm.transaction_new_partition_8790000000_8800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8780000000_8790000000_dat_escrow  ON fidc_adm.transaction_new_partition_8780000000_8790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8770000000_8780000000_dat_escrow  ON fidc_adm.transaction_new_partition_8770000000_8780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8760000000_8770000000_dat_escrow  ON fidc_adm.transaction_new_partition_8760000000_8770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8750000000_8760000000_dat_escrow  ON fidc_adm.transaction_new_partition_8750000000_8760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8740000000_8750000000_dat_escrow  ON fidc_adm.transaction_new_partition_8740000000_8750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8730000000_8740000000_dat_escrow  ON fidc_adm.transaction_new_partition_8730000000_8740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8720000000_8730000000_dat_escrow  ON fidc_adm.transaction_new_partition_8720000000_8730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8710000000_8720000000_dat_escrow  ON fidc_adm.transaction_new_partition_8710000000_8720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8700000000_8710000000_dat_escrow  ON fidc_adm.transaction_new_partition_8700000000_8710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8690000000_8700000000_dat_escrow  ON fidc_adm.transaction_new_partition_8690000000_8700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8680000000_8690000000_dat_escrow  ON fidc_adm.transaction_new_partition_8680000000_8690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8670000000_8680000000_dat_escrow  ON fidc_adm.transaction_new_partition_8670000000_8680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8660000000_8670000000_dat_escrow  ON fidc_adm.transaction_new_partition_8660000000_8670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8650000000_8660000000_dat_escrow  ON fidc_adm.transaction_new_partition_8650000000_8660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8640000000_8650000000_dat_escrow  ON fidc_adm.transaction_new_partition_8640000000_8650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8630000000_8640000000_dat_escrow  ON fidc_adm.transaction_new_partition_8630000000_8640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8620000000_8630000000_dat_escrow  ON fidc_adm.transaction_new_partition_8620000000_8630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8610000000_8620000000_dat_escrow  ON fidc_adm.transaction_new_partition_8610000000_8620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8600000000_8610000000_dat_escrow  ON fidc_adm.transaction_new_partition_8600000000_8610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8590000000_8600000000_dat_escrow  ON fidc_adm.transaction_new_partition_8590000000_8600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8580000000_8590000000_dat_escrow  ON fidc_adm.transaction_new_partition_8580000000_8590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8570000000_8580000000_dat_escrow  ON fidc_adm.transaction_new_partition_8570000000_8580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8560000000_8570000000_dat_escrow  ON fidc_adm.transaction_new_partition_8560000000_8570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8550000000_8560000000_dat_escrow  ON fidc_adm.transaction_new_partition_8550000000_8560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8540000000_8550000000_dat_escrow  ON fidc_adm.transaction_new_partition_8540000000_8550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8530000000_8540000000_dat_escrow  ON fidc_adm.transaction_new_partition_8530000000_8540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8520000000_8530000000_dat_escrow  ON fidc_adm.transaction_new_partition_8520000000_8530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8510000000_8520000000_dat_escrow  ON fidc_adm.transaction_new_partition_8510000000_8520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8500000000_8510000000_dat_escrow  ON fidc_adm.transaction_new_partition_8500000000_8510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8490000000_8500000000_dat_escrow  ON fidc_adm.transaction_new_partition_8490000000_8500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8480000000_8490000000_dat_escrow  ON fidc_adm.transaction_new_partition_8480000000_8490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8470000000_8480000000_dat_escrow  ON fidc_adm.transaction_new_partition_8470000000_8480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8460000000_8470000000_dat_escrow  ON fidc_adm.transaction_new_partition_8460000000_8470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8450000000_8460000000_dat_escrow  ON fidc_adm.transaction_new_partition_8450000000_8460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8440000000_8450000000_dat_escrow  ON fidc_adm.transaction_new_partition_8440000000_8450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8430000000_8440000000_dat_escrow  ON fidc_adm.transaction_new_partition_8430000000_8440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8420000000_8430000000_dat_escrow  ON fidc_adm.transaction_new_partition_8420000000_8430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8410000000_8420000000_dat_escrow  ON fidc_adm.transaction_new_partition_8410000000_8420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8400000000_8410000000_dat_escrow  ON fidc_adm.transaction_new_partition_8400000000_8410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8390000000_8400000000_dat_escrow  ON fidc_adm.transaction_new_partition_8390000000_8400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8380000000_8390000000_dat_escrow  ON fidc_adm.transaction_new_partition_8380000000_8390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8370000000_8380000000_dat_escrow  ON fidc_adm.transaction_new_partition_8370000000_8380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8360000000_8370000000_dat_escrow  ON fidc_adm.transaction_new_partition_8360000000_8370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8350000000_8360000000_dat_escrow  ON fidc_adm.transaction_new_partition_8350000000_8360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8340000000_8350000000_dat_escrow  ON fidc_adm.transaction_new_partition_8340000000_8350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8330000000_8340000000_dat_escrow  ON fidc_adm.transaction_new_partition_8330000000_8340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8320000000_8330000000_dat_escrow  ON fidc_adm.transaction_new_partition_8320000000_8330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8310000000_8320000000_dat_escrow  ON fidc_adm.transaction_new_partition_8310000000_8320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8300000000_8310000000_dat_escrow  ON fidc_adm.transaction_new_partition_8300000000_8310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8290000000_8300000000_dat_escrow  ON fidc_adm.transaction_new_partition_8290000000_8300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8280000000_8290000000_dat_escrow  ON fidc_adm.transaction_new_partition_8280000000_8290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8270000000_8280000000_dat_escrow  ON fidc_adm.transaction_new_partition_8270000000_8280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8260000000_8270000000_dat_escrow  ON fidc_adm.transaction_new_partition_8260000000_8270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8250000000_8260000000_dat_escrow  ON fidc_adm.transaction_new_partition_8250000000_8260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8240000000_8250000000_dat_escrow  ON fidc_adm.transaction_new_partition_8240000000_8250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8230000000_8240000000_dat_escrow  ON fidc_adm.transaction_new_partition_8230000000_8240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8220000000_8230000000_dat_escrow  ON fidc_adm.transaction_new_partition_8220000000_8230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8210000000_8220000000_dat_escrow  ON fidc_adm.transaction_new_partition_8210000000_8220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8200000000_8210000000_dat_escrow  ON fidc_adm.transaction_new_partition_8200000000_8210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8190000000_8200000000_dat_escrow  ON fidc_adm.transaction_new_partition_8190000000_8200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8180000000_8190000000_dat_escrow  ON fidc_adm.transaction_new_partition_8180000000_8190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8170000000_8180000000_dat_escrow  ON fidc_adm.transaction_new_partition_8170000000_8180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8160000000_8170000000_dat_escrow  ON fidc_adm.transaction_new_partition_8160000000_8170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8150000000_8160000000_dat_escrow  ON fidc_adm.transaction_new_partition_8150000000_8160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8140000000_8150000000_dat_escrow  ON fidc_adm.transaction_new_partition_8140000000_8150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8130000000_8140000000_dat_escrow  ON fidc_adm.transaction_new_partition_8130000000_8140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8120000000_8130000000_dat_escrow  ON fidc_adm.transaction_new_partition_8120000000_8130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8110000000_8120000000_dat_escrow  ON fidc_adm.transaction_new_partition_8110000000_8120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8100000000_8110000000_dat_escrow  ON fidc_adm.transaction_new_partition_8100000000_8110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8090000000_8100000000_dat_escrow  ON fidc_adm.transaction_new_partition_8090000000_8100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8080000000_8090000000_dat_escrow  ON fidc_adm.transaction_new_partition_8080000000_8090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8070000000_8080000000_dat_escrow  ON fidc_adm.transaction_new_partition_8070000000_8080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8060000000_8070000000_dat_escrow  ON fidc_adm.transaction_new_partition_8060000000_8070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8050000000_8060000000_dat_escrow  ON fidc_adm.transaction_new_partition_8050000000_8060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8040000000_8050000000_dat_escrow  ON fidc_adm.transaction_new_partition_8040000000_8050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8030000000_8040000000_dat_escrow  ON fidc_adm.transaction_new_partition_8030000000_8040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8020000000_8030000000_dat_escrow  ON fidc_adm.transaction_new_partition_8020000000_8030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8010000000_8020000000_dat_escrow  ON fidc_adm.transaction_new_partition_8010000000_8020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_8000000000_8010000000_dat_escrow  ON fidc_adm.transaction_new_partition_8000000000_8010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7990000000_8000000000_dat_escrow  ON fidc_adm.transaction_new_partition_7990000000_8000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7980000000_7990000000_dat_escrow  ON fidc_adm.transaction_new_partition_7980000000_7990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7970000000_7980000000_dat_escrow  ON fidc_adm.transaction_new_partition_7970000000_7980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7960000000_7970000000_dat_escrow  ON fidc_adm.transaction_new_partition_7960000000_7970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7950000000_7960000000_dat_escrow  ON fidc_adm.transaction_new_partition_7950000000_7960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7940000000_7950000000_dat_escrow  ON fidc_adm.transaction_new_partition_7940000000_7950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7930000000_7940000000_dat_escrow  ON fidc_adm.transaction_new_partition_7930000000_7940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7920000000_7930000000_dat_escrow  ON fidc_adm.transaction_new_partition_7920000000_7930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7910000000_7920000000_dat_escrow  ON fidc_adm.transaction_new_partition_7910000000_7920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7900000000_7910000000_dat_escrow  ON fidc_adm.transaction_new_partition_7900000000_7910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7890000000_7900000000_dat_escrow  ON fidc_adm.transaction_new_partition_7890000000_7900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7880000000_7890000000_dat_escrow  ON fidc_adm.transaction_new_partition_7880000000_7890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7870000000_7880000000_dat_escrow  ON fidc_adm.transaction_new_partition_7870000000_7880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7860000000_7870000000_dat_escrow  ON fidc_adm.transaction_new_partition_7860000000_7870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7850000000_7860000000_dat_escrow  ON fidc_adm.transaction_new_partition_7850000000_7860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7840000000_7850000000_dat_escrow  ON fidc_adm.transaction_new_partition_7840000000_7850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7830000000_7840000000_dat_escrow  ON fidc_adm.transaction_new_partition_7830000000_7840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7820000000_7830000000_dat_escrow  ON fidc_adm.transaction_new_partition_7820000000_7830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7810000000_7820000000_dat_escrow  ON fidc_adm.transaction_new_partition_7810000000_7820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7800000000_7810000000_dat_escrow  ON fidc_adm.transaction_new_partition_7800000000_7810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7790000000_7800000000_dat_escrow  ON fidc_adm.transaction_new_partition_7790000000_7800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7780000000_7790000000_dat_escrow  ON fidc_adm.transaction_new_partition_7780000000_7790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7770000000_7780000000_dat_escrow  ON fidc_adm.transaction_new_partition_7770000000_7780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7760000000_7770000000_dat_escrow  ON fidc_adm.transaction_new_partition_7760000000_7770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7750000000_7760000000_dat_escrow  ON fidc_adm.transaction_new_partition_7750000000_7760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7740000000_7750000000_dat_escrow  ON fidc_adm.transaction_new_partition_7740000000_7750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7730000000_7740000000_dat_escrow  ON fidc_adm.transaction_new_partition_7730000000_7740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7720000000_7730000000_dat_escrow  ON fidc_adm.transaction_new_partition_7720000000_7730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7710000000_7720000000_dat_escrow  ON fidc_adm.transaction_new_partition_7710000000_7720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7700000000_7710000000_dat_escrow  ON fidc_adm.transaction_new_partition_7700000000_7710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7690000000_7700000000_dat_escrow  ON fidc_adm.transaction_new_partition_7690000000_7700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7680000000_7690000000_dat_escrow  ON fidc_adm.transaction_new_partition_7680000000_7690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7670000000_7680000000_dat_escrow  ON fidc_adm.transaction_new_partition_7670000000_7680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7660000000_7670000000_dat_escrow  ON fidc_adm.transaction_new_partition_7660000000_7670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7650000000_7660000000_dat_escrow  ON fidc_adm.transaction_new_partition_7650000000_7660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7640000000_7650000000_dat_escrow  ON fidc_adm.transaction_new_partition_7640000000_7650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7630000000_7640000000_dat_escrow  ON fidc_adm.transaction_new_partition_7630000000_7640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7620000000_7630000000_dat_escrow  ON fidc_adm.transaction_new_partition_7620000000_7630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7610000000_7620000000_dat_escrow  ON fidc_adm.transaction_new_partition_7610000000_7620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7600000000_7610000000_dat_escrow  ON fidc_adm.transaction_new_partition_7600000000_7610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7590000000_7600000000_dat_escrow  ON fidc_adm.transaction_new_partition_7590000000_7600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7580000000_7590000000_dat_escrow  ON fidc_adm.transaction_new_partition_7580000000_7590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7570000000_7580000000_dat_escrow  ON fidc_adm.transaction_new_partition_7570000000_7580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7560000000_7570000000_dat_escrow  ON fidc_adm.transaction_new_partition_7560000000_7570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7550000000_7560000000_dat_escrow  ON fidc_adm.transaction_new_partition_7550000000_7560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7540000000_7550000000_dat_escrow  ON fidc_adm.transaction_new_partition_7540000000_7550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7530000000_7540000000_dat_escrow  ON fidc_adm.transaction_new_partition_7530000000_7540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7520000000_7530000000_dat_escrow  ON fidc_adm.transaction_new_partition_7520000000_7530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7510000000_7520000000_dat_escrow  ON fidc_adm.transaction_new_partition_7510000000_7520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7500000000_7510000000_dat_escrow  ON fidc_adm.transaction_new_partition_7500000000_7510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7490000000_7500000000_dat_escrow  ON fidc_adm.transaction_new_partition_7490000000_7500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7480000000_7490000000_dat_escrow  ON fidc_adm.transaction_new_partition_7480000000_7490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7470000000_7480000000_dat_escrow  ON fidc_adm.transaction_new_partition_7470000000_7480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7460000000_7470000000_dat_escrow  ON fidc_adm.transaction_new_partition_7460000000_7470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7450000000_7460000000_dat_escrow  ON fidc_adm.transaction_new_partition_7450000000_7460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7440000000_7450000000_dat_escrow  ON fidc_adm.transaction_new_partition_7440000000_7450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7430000000_7440000000_dat_escrow  ON fidc_adm.transaction_new_partition_7430000000_7440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7420000000_7430000000_dat_escrow  ON fidc_adm.transaction_new_partition_7420000000_7430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7410000000_7420000000_dat_escrow  ON fidc_adm.transaction_new_partition_7410000000_7420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7400000000_7410000000_dat_escrow  ON fidc_adm.transaction_new_partition_7400000000_7410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7390000000_7400000000_dat_escrow  ON fidc_adm.transaction_new_partition_7390000000_7400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7380000000_7390000000_dat_escrow  ON fidc_adm.transaction_new_partition_7380000000_7390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7370000000_7380000000_dat_escrow  ON fidc_adm.transaction_new_partition_7370000000_7380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7360000000_7370000000_dat_escrow  ON fidc_adm.transaction_new_partition_7360000000_7370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7350000000_7360000000_dat_escrow  ON fidc_adm.transaction_new_partition_7350000000_7360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7340000000_7350000000_dat_escrow  ON fidc_adm.transaction_new_partition_7340000000_7350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7330000000_7340000000_dat_escrow  ON fidc_adm.transaction_new_partition_7330000000_7340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7320000000_7330000000_dat_escrow  ON fidc_adm.transaction_new_partition_7320000000_7330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7310000000_7320000000_dat_escrow  ON fidc_adm.transaction_new_partition_7310000000_7320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7300000000_7310000000_dat_escrow  ON fidc_adm.transaction_new_partition_7300000000_7310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7290000000_7300000000_dat_escrow  ON fidc_adm.transaction_new_partition_7290000000_7300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7280000000_7290000000_dat_escrow  ON fidc_adm.transaction_new_partition_7280000000_7290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7270000000_7280000000_dat_escrow  ON fidc_adm.transaction_new_partition_7270000000_7280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7260000000_7270000000_dat_escrow  ON fidc_adm.transaction_new_partition_7260000000_7270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7250000000_7260000000_dat_escrow  ON fidc_adm.transaction_new_partition_7250000000_7260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7240000000_7250000000_dat_escrow  ON fidc_adm.transaction_new_partition_7240000000_7250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7230000000_7240000000_dat_escrow  ON fidc_adm.transaction_new_partition_7230000000_7240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7220000000_7230000000_dat_escrow  ON fidc_adm.transaction_new_partition_7220000000_7230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7210000000_7220000000_dat_escrow  ON fidc_adm.transaction_new_partition_7210000000_7220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7200000000_7210000000_dat_escrow  ON fidc_adm.transaction_new_partition_7200000000_7210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7190000000_7200000000_dat_escrow  ON fidc_adm.transaction_new_partition_7190000000_7200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7180000000_7190000000_dat_escrow  ON fidc_adm.transaction_new_partition_7180000000_7190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7170000000_7180000000_dat_escrow  ON fidc_adm.transaction_new_partition_7170000000_7180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7160000000_7170000000_dat_escrow  ON fidc_adm.transaction_new_partition_7160000000_7170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7150000000_7160000000_dat_escrow  ON fidc_adm.transaction_new_partition_7150000000_7160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7140000000_7150000000_dat_escrow  ON fidc_adm.transaction_new_partition_7140000000_7150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7130000000_7140000000_dat_escrow  ON fidc_adm.transaction_new_partition_7130000000_7140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7120000000_7130000000_dat_escrow  ON fidc_adm.transaction_new_partition_7120000000_7130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7110000000_7120000000_dat_escrow  ON fidc_adm.transaction_new_partition_7110000000_7120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7100000000_7110000000_dat_escrow  ON fidc_adm.transaction_new_partition_7100000000_7110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7090000000_7100000000_dat_escrow  ON fidc_adm.transaction_new_partition_7090000000_7100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7080000000_7090000000_dat_escrow  ON fidc_adm.transaction_new_partition_7080000000_7090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7070000000_7080000000_dat_escrow  ON fidc_adm.transaction_new_partition_7070000000_7080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7060000000_7070000000_dat_escrow  ON fidc_adm.transaction_new_partition_7060000000_7070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7050000000_7060000000_dat_escrow  ON fidc_adm.transaction_new_partition_7050000000_7060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7040000000_7050000000_dat_escrow  ON fidc_adm.transaction_new_partition_7040000000_7050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7030000000_7040000000_dat_escrow  ON fidc_adm.transaction_new_partition_7030000000_7040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7020000000_7030000000_dat_escrow  ON fidc_adm.transaction_new_partition_7020000000_7030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7010000000_7020000000_dat_escrow  ON fidc_adm.transaction_new_partition_7010000000_7020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_7000000000_7010000000_dat_escrow  ON fidc_adm.transaction_new_partition_7000000000_7010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6990000000_7000000000_dat_escrow  ON fidc_adm.transaction_new_partition_6990000000_7000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6980000000_6990000000_dat_escrow  ON fidc_adm.transaction_new_partition_6980000000_6990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6970000000_6980000000_dat_escrow  ON fidc_adm.transaction_new_partition_6970000000_6980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6960000000_6970000000_dat_escrow  ON fidc_adm.transaction_new_partition_6960000000_6970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6950000000_6960000000_dat_escrow  ON fidc_adm.transaction_new_partition_6950000000_6960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6940000000_6950000000_dat_escrow  ON fidc_adm.transaction_new_partition_6940000000_6950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6930000000_6940000000_dat_escrow  ON fidc_adm.transaction_new_partition_6930000000_6940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6920000000_6930000000_dat_escrow  ON fidc_adm.transaction_new_partition_6920000000_6930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6910000000_6920000000_dat_escrow  ON fidc_adm.transaction_new_partition_6910000000_6920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6900000000_6910000000_dat_escrow  ON fidc_adm.transaction_new_partition_6900000000_6910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6890000000_6900000000_dat_escrow  ON fidc_adm.transaction_new_partition_6890000000_6900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6880000000_6890000000_dat_escrow  ON fidc_adm.transaction_new_partition_6880000000_6890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6870000000_6880000000_dat_escrow  ON fidc_adm.transaction_new_partition_6870000000_6880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6860000000_6870000000_dat_escrow  ON fidc_adm.transaction_new_partition_6860000000_6870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6850000000_6860000000_dat_escrow  ON fidc_adm.transaction_new_partition_6850000000_6860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6840000000_6850000000_dat_escrow  ON fidc_adm.transaction_new_partition_6840000000_6850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6830000000_6840000000_dat_escrow  ON fidc_adm.transaction_new_partition_6830000000_6840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6820000000_6830000000_dat_escrow  ON fidc_adm.transaction_new_partition_6820000000_6830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6810000000_6820000000_dat_escrow  ON fidc_adm.transaction_new_partition_6810000000_6820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6800000000_6810000000_dat_escrow  ON fidc_adm.transaction_new_partition_6800000000_6810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6790000000_6800000000_dat_escrow  ON fidc_adm.transaction_new_partition_6790000000_6800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6780000000_6790000000_dat_escrow  ON fidc_adm.transaction_new_partition_6780000000_6790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6770000000_6780000000_dat_escrow  ON fidc_adm.transaction_new_partition_6770000000_6780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6760000000_6770000000_dat_escrow  ON fidc_adm.transaction_new_partition_6760000000_6770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6750000000_6760000000_dat_escrow  ON fidc_adm.transaction_new_partition_6750000000_6760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6740000000_6750000000_dat_escrow  ON fidc_adm.transaction_new_partition_6740000000_6750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6730000000_6740000000_dat_escrow  ON fidc_adm.transaction_new_partition_6730000000_6740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6720000000_6730000000_dat_escrow  ON fidc_adm.transaction_new_partition_6720000000_6730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6710000000_6720000000_dat_escrow  ON fidc_adm.transaction_new_partition_6710000000_6720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6700000000_6710000000_dat_escrow  ON fidc_adm.transaction_new_partition_6700000000_6710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6690000000_6700000000_dat_escrow  ON fidc_adm.transaction_new_partition_6690000000_6700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6680000000_6690000000_dat_escrow  ON fidc_adm.transaction_new_partition_6680000000_6690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6670000000_6680000000_dat_escrow  ON fidc_adm.transaction_new_partition_6670000000_6680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6660000000_6670000000_dat_escrow  ON fidc_adm.transaction_new_partition_6660000000_6670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6650000000_6660000000_dat_escrow  ON fidc_adm.transaction_new_partition_6650000000_6660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6640000000_6650000000_dat_escrow  ON fidc_adm.transaction_new_partition_6640000000_6650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6630000000_6640000000_dat_escrow  ON fidc_adm.transaction_new_partition_6630000000_6640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6620000000_6630000000_dat_escrow  ON fidc_adm.transaction_new_partition_6620000000_6630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6610000000_6620000000_dat_escrow  ON fidc_adm.transaction_new_partition_6610000000_6620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6600000000_6610000000_dat_escrow  ON fidc_adm.transaction_new_partition_6600000000_6610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6590000000_6600000000_dat_escrow  ON fidc_adm.transaction_new_partition_6590000000_6600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6580000000_6590000000_dat_escrow  ON fidc_adm.transaction_new_partition_6580000000_6590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6570000000_6580000000_dat_escrow  ON fidc_adm.transaction_new_partition_6570000000_6580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6560000000_6570000000_dat_escrow  ON fidc_adm.transaction_new_partition_6560000000_6570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6550000000_6560000000_dat_escrow  ON fidc_adm.transaction_new_partition_6550000000_6560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6540000000_6550000000_dat_escrow  ON fidc_adm.transaction_new_partition_6540000000_6550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6530000000_6540000000_dat_escrow  ON fidc_adm.transaction_new_partition_6530000000_6540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6520000000_6530000000_dat_escrow  ON fidc_adm.transaction_new_partition_6520000000_6530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6510000000_6520000000_dat_escrow  ON fidc_adm.transaction_new_partition_6510000000_6520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6500000000_6510000000_dat_escrow  ON fidc_adm.transaction_new_partition_6500000000_6510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6490000000_6500000000_dat_escrow  ON fidc_adm.transaction_new_partition_6490000000_6500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6480000000_6490000000_dat_escrow  ON fidc_adm.transaction_new_partition_6480000000_6490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6470000000_6480000000_dat_escrow  ON fidc_adm.transaction_new_partition_6470000000_6480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6460000000_6470000000_dat_escrow  ON fidc_adm.transaction_new_partition_6460000000_6470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6450000000_6460000000_dat_escrow  ON fidc_adm.transaction_new_partition_6450000000_6460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6440000000_6450000000_dat_escrow  ON fidc_adm.transaction_new_partition_6440000000_6450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6430000000_6440000000_dat_escrow  ON fidc_adm.transaction_new_partition_6430000000_6440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6420000000_6430000000_dat_escrow  ON fidc_adm.transaction_new_partition_6420000000_6430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6410000000_6420000000_dat_escrow  ON fidc_adm.transaction_new_partition_6410000000_6420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6400000000_6410000000_dat_escrow  ON fidc_adm.transaction_new_partition_6400000000_6410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6390000000_6400000000_dat_escrow  ON fidc_adm.transaction_new_partition_6390000000_6400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6380000000_6390000000_dat_escrow  ON fidc_adm.transaction_new_partition_6380000000_6390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6370000000_6380000000_dat_escrow  ON fidc_adm.transaction_new_partition_6370000000_6380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6360000000_6370000000_dat_escrow  ON fidc_adm.transaction_new_partition_6360000000_6370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6350000000_6360000000_dat_escrow  ON fidc_adm.transaction_new_partition_6350000000_6360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6340000000_6350000000_dat_escrow  ON fidc_adm.transaction_new_partition_6340000000_6350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6330000000_6340000000_dat_escrow  ON fidc_adm.transaction_new_partition_6330000000_6340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6320000000_6330000000_dat_escrow  ON fidc_adm.transaction_new_partition_6320000000_6330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6310000000_6320000000_dat_escrow  ON fidc_adm.transaction_new_partition_6310000000_6320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6300000000_6310000000_dat_escrow  ON fidc_adm.transaction_new_partition_6300000000_6310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6290000000_6300000000_dat_escrow  ON fidc_adm.transaction_new_partition_6290000000_6300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6280000000_6290000000_dat_escrow  ON fidc_adm.transaction_new_partition_6280000000_6290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6270000000_6280000000_dat_escrow  ON fidc_adm.transaction_new_partition_6270000000_6280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6260000000_6270000000_dat_escrow  ON fidc_adm.transaction_new_partition_6260000000_6270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6250000000_6260000000_dat_escrow  ON fidc_adm.transaction_new_partition_6250000000_6260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6240000000_6250000000_dat_escrow  ON fidc_adm.transaction_new_partition_6240000000_6250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6230000000_6240000000_dat_escrow  ON fidc_adm.transaction_new_partition_6230000000_6240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6220000000_6230000000_dat_escrow  ON fidc_adm.transaction_new_partition_6220000000_6230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6210000000_6220000000_dat_escrow  ON fidc_adm.transaction_new_partition_6210000000_6220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6200000000_6210000000_dat_escrow  ON fidc_adm.transaction_new_partition_6200000000_6210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6190000000_6200000000_dat_escrow  ON fidc_adm.transaction_new_partition_6190000000_6200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6180000000_6190000000_dat_escrow  ON fidc_adm.transaction_new_partition_6180000000_6190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6170000000_6180000000_dat_escrow  ON fidc_adm.transaction_new_partition_6170000000_6180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6160000000_6170000000_dat_escrow  ON fidc_adm.transaction_new_partition_6160000000_6170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6150000000_6160000000_dat_escrow  ON fidc_adm.transaction_new_partition_6150000000_6160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6140000000_6150000000_dat_escrow  ON fidc_adm.transaction_new_partition_6140000000_6150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6130000000_6140000000_dat_escrow  ON fidc_adm.transaction_new_partition_6130000000_6140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6120000000_6130000000_dat_escrow  ON fidc_adm.transaction_new_partition_6120000000_6130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6110000000_6120000000_dat_escrow  ON fidc_adm.transaction_new_partition_6110000000_6120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6100000000_6110000000_dat_escrow  ON fidc_adm.transaction_new_partition_6100000000_6110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6090000000_6100000000_dat_escrow  ON fidc_adm.transaction_new_partition_6090000000_6100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6080000000_6090000000_dat_escrow  ON fidc_adm.transaction_new_partition_6080000000_6090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6070000000_6080000000_dat_escrow  ON fidc_adm.transaction_new_partition_6070000000_6080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6060000000_6070000000_dat_escrow  ON fidc_adm.transaction_new_partition_6060000000_6070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6050000000_6060000000_dat_escrow  ON fidc_adm.transaction_new_partition_6050000000_6060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6040000000_6050000000_dat_escrow  ON fidc_adm.transaction_new_partition_6040000000_6050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6030000000_6040000000_dat_escrow  ON fidc_adm.transaction_new_partition_6030000000_6040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6020000000_6030000000_dat_escrow  ON fidc_adm.transaction_new_partition_6020000000_6030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6010000000_6020000000_dat_escrow  ON fidc_adm.transaction_new_partition_6010000000_6020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_6000000000_6010000000_dat_escrow  ON fidc_adm.transaction_new_partition_6000000000_6010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5990000000_6000000000_dat_escrow  ON fidc_adm.transaction_new_partition_5990000000_6000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5980000000_5990000000_dat_escrow  ON fidc_adm.transaction_new_partition_5980000000_5990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5970000000_5980000000_dat_escrow  ON fidc_adm.transaction_new_partition_5970000000_5980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5960000000_5970000000_dat_escrow  ON fidc_adm.transaction_new_partition_5960000000_5970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5950000000_5960000000_dat_escrow  ON fidc_adm.transaction_new_partition_5950000000_5960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5940000000_5950000000_dat_escrow  ON fidc_adm.transaction_new_partition_5940000000_5950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5930000000_5940000000_dat_escrow  ON fidc_adm.transaction_new_partition_5930000000_5940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5920000000_5930000000_dat_escrow  ON fidc_adm.transaction_new_partition_5920000000_5930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5910000000_5920000000_dat_escrow  ON fidc_adm.transaction_new_partition_5910000000_5920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5900000000_5910000000_dat_escrow  ON fidc_adm.transaction_new_partition_5900000000_5910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5890000000_5900000000_dat_escrow  ON fidc_adm.transaction_new_partition_5890000000_5900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5880000000_5890000000_dat_escrow  ON fidc_adm.transaction_new_partition_5880000000_5890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5870000000_5880000000_dat_escrow  ON fidc_adm.transaction_new_partition_5870000000_5880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5860000000_5870000000_dat_escrow  ON fidc_adm.transaction_new_partition_5860000000_5870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5850000000_5860000000_dat_escrow  ON fidc_adm.transaction_new_partition_5850000000_5860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5840000000_5850000000_dat_escrow  ON fidc_adm.transaction_new_partition_5840000000_5850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5830000000_5840000000_dat_escrow  ON fidc_adm.transaction_new_partition_5830000000_5840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5820000000_5830000000_dat_escrow  ON fidc_adm.transaction_new_partition_5820000000_5830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5810000000_5820000000_dat_escrow  ON fidc_adm.transaction_new_partition_5810000000_5820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5800000000_5810000000_dat_escrow  ON fidc_adm.transaction_new_partition_5800000000_5810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5790000000_5800000000_dat_escrow  ON fidc_adm.transaction_new_partition_5790000000_5800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5780000000_5790000000_dat_escrow  ON fidc_adm.transaction_new_partition_5780000000_5790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5770000000_5780000000_dat_escrow  ON fidc_adm.transaction_new_partition_5770000000_5780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5760000000_5770000000_dat_escrow  ON fidc_adm.transaction_new_partition_5760000000_5770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5750000000_5760000000_dat_escrow  ON fidc_adm.transaction_new_partition_5750000000_5760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5740000000_5750000000_dat_escrow  ON fidc_adm.transaction_new_partition_5740000000_5750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5730000000_5740000000_dat_escrow  ON fidc_adm.transaction_new_partition_5730000000_5740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5720000000_5730000000_dat_escrow  ON fidc_adm.transaction_new_partition_5720000000_5730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5710000000_5720000000_dat_escrow  ON fidc_adm.transaction_new_partition_5710000000_5720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5700000000_5710000000_dat_escrow  ON fidc_adm.transaction_new_partition_5700000000_5710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5690000000_5700000000_dat_escrow  ON fidc_adm.transaction_new_partition_5690000000_5700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5680000000_5690000000_dat_escrow  ON fidc_adm.transaction_new_partition_5680000000_5690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5670000000_5680000000_dat_escrow  ON fidc_adm.transaction_new_partition_5670000000_5680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5660000000_5670000000_dat_escrow  ON fidc_adm.transaction_new_partition_5660000000_5670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5650000000_5660000000_dat_escrow  ON fidc_adm.transaction_new_partition_5650000000_5660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5640000000_5650000000_dat_escrow  ON fidc_adm.transaction_new_partition_5640000000_5650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5630000000_5640000000_dat_escrow  ON fidc_adm.transaction_new_partition_5630000000_5640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5620000000_5630000000_dat_escrow  ON fidc_adm.transaction_new_partition_5620000000_5630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5610000000_5620000000_dat_escrow  ON fidc_adm.transaction_new_partition_5610000000_5620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5600000000_5610000000_dat_escrow  ON fidc_adm.transaction_new_partition_5600000000_5610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5590000000_5600000000_dat_escrow  ON fidc_adm.transaction_new_partition_5590000000_5600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5580000000_5590000000_dat_escrow  ON fidc_adm.transaction_new_partition_5580000000_5590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5570000000_5580000000_dat_escrow  ON fidc_adm.transaction_new_partition_5570000000_5580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5560000000_5570000000_dat_escrow  ON fidc_adm.transaction_new_partition_5560000000_5570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5550000000_5560000000_dat_escrow  ON fidc_adm.transaction_new_partition_5550000000_5560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5540000000_5550000000_dat_escrow  ON fidc_adm.transaction_new_partition_5540000000_5550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5530000000_5540000000_dat_escrow  ON fidc_adm.transaction_new_partition_5530000000_5540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5520000000_5530000000_dat_escrow  ON fidc_adm.transaction_new_partition_5520000000_5530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5510000000_5520000000_dat_escrow  ON fidc_adm.transaction_new_partition_5510000000_5520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5500000000_5510000000_dat_escrow  ON fidc_adm.transaction_new_partition_5500000000_5510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5490000000_5500000000_dat_escrow  ON fidc_adm.transaction_new_partition_5490000000_5500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5480000000_5490000000_dat_escrow  ON fidc_adm.transaction_new_partition_5480000000_5490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5470000000_5480000000_dat_escrow  ON fidc_adm.transaction_new_partition_5470000000_5480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5460000000_5470000000_dat_escrow  ON fidc_adm.transaction_new_partition_5460000000_5470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5450000000_5460000000_dat_escrow  ON fidc_adm.transaction_new_partition_5450000000_5460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5440000000_5450000000_dat_escrow  ON fidc_adm.transaction_new_partition_5440000000_5450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5430000000_5440000000_dat_escrow  ON fidc_adm.transaction_new_partition_5430000000_5440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5420000000_5430000000_dat_escrow  ON fidc_adm.transaction_new_partition_5420000000_5430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5410000000_5420000000_dat_escrow  ON fidc_adm.transaction_new_partition_5410000000_5420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5400000000_5410000000_dat_escrow  ON fidc_adm.transaction_new_partition_5400000000_5410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5390000000_5400000000_dat_escrow  ON fidc_adm.transaction_new_partition_5390000000_5400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5380000000_5390000000_dat_escrow  ON fidc_adm.transaction_new_partition_5380000000_5390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5370000000_5380000000_dat_escrow  ON fidc_adm.transaction_new_partition_5370000000_5380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5360000000_5370000000_dat_escrow  ON fidc_adm.transaction_new_partition_5360000000_5370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5350000000_5360000000_dat_escrow  ON fidc_adm.transaction_new_partition_5350000000_5360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5340000000_5350000000_dat_escrow  ON fidc_adm.transaction_new_partition_5340000000_5350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5330000000_5340000000_dat_escrow  ON fidc_adm.transaction_new_partition_5330000000_5340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5320000000_5330000000_dat_escrow  ON fidc_adm.transaction_new_partition_5320000000_5330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5310000000_5320000000_dat_escrow  ON fidc_adm.transaction_new_partition_5310000000_5320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5300000000_5310000000_dat_escrow  ON fidc_adm.transaction_new_partition_5300000000_5310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5290000000_5300000000_dat_escrow  ON fidc_adm.transaction_new_partition_5290000000_5300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5280000000_5290000000_dat_escrow  ON fidc_adm.transaction_new_partition_5280000000_5290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5270000000_5280000000_dat_escrow  ON fidc_adm.transaction_new_partition_5270000000_5280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5260000000_5270000000_dat_escrow  ON fidc_adm.transaction_new_partition_5260000000_5270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5250000000_5260000000_dat_escrow  ON fidc_adm.transaction_new_partition_5250000000_5260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5240000000_5250000000_dat_escrow  ON fidc_adm.transaction_new_partition_5240000000_5250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5230000000_5240000000_dat_escrow  ON fidc_adm.transaction_new_partition_5230000000_5240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5220000000_5230000000_dat_escrow  ON fidc_adm.transaction_new_partition_5220000000_5230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5210000000_5220000000_dat_escrow  ON fidc_adm.transaction_new_partition_5210000000_5220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5200000000_5210000000_dat_escrow  ON fidc_adm.transaction_new_partition_5200000000_5210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5190000000_5200000000_dat_escrow  ON fidc_adm.transaction_new_partition_5190000000_5200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5180000000_5190000000_dat_escrow  ON fidc_adm.transaction_new_partition_5180000000_5190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5170000000_5180000000_dat_escrow  ON fidc_adm.transaction_new_partition_5170000000_5180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5160000000_5170000000_dat_escrow  ON fidc_adm.transaction_new_partition_5160000000_5170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5150000000_5160000000_dat_escrow  ON fidc_adm.transaction_new_partition_5150000000_5160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5140000000_5150000000_dat_escrow  ON fidc_adm.transaction_new_partition_5140000000_5150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5130000000_5140000000_dat_escrow  ON fidc_adm.transaction_new_partition_5130000000_5140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5120000000_5130000000_dat_escrow  ON fidc_adm.transaction_new_partition_5120000000_5130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5110000000_5120000000_dat_escrow  ON fidc_adm.transaction_new_partition_5110000000_5120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5100000000_5110000000_dat_escrow  ON fidc_adm.transaction_new_partition_5100000000_5110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5090000000_5100000000_dat_escrow  ON fidc_adm.transaction_new_partition_5090000000_5100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5080000000_5090000000_dat_escrow  ON fidc_adm.transaction_new_partition_5080000000_5090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5070000000_5080000000_dat_escrow  ON fidc_adm.transaction_new_partition_5070000000_5080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5060000000_5070000000_dat_escrow  ON fidc_adm.transaction_new_partition_5060000000_5070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5050000000_5060000000_dat_escrow  ON fidc_adm.transaction_new_partition_5050000000_5060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5040000000_5050000000_dat_escrow  ON fidc_adm.transaction_new_partition_5040000000_5050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5030000000_5040000000_dat_escrow  ON fidc_adm.transaction_new_partition_5030000000_5040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5020000000_5030000000_dat_escrow  ON fidc_adm.transaction_new_partition_5020000000_5030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5010000000_5020000000_dat_escrow  ON fidc_adm.transaction_new_partition_5010000000_5020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_5000000000_5010000000_dat_escrow  ON fidc_adm.transaction_new_partition_5000000000_5010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4990000000_5000000000_dat_escrow  ON fidc_adm.transaction_new_partition_4990000000_5000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4980000000_4990000000_dat_escrow  ON fidc_adm.transaction_new_partition_4980000000_4990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4970000000_4980000000_dat_escrow  ON fidc_adm.transaction_new_partition_4970000000_4980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4960000000_4970000000_dat_escrow  ON fidc_adm.transaction_new_partition_4960000000_4970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4950000000_4960000000_dat_escrow  ON fidc_adm.transaction_new_partition_4950000000_4960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4940000000_4950000000_dat_escrow  ON fidc_adm.transaction_new_partition_4940000000_4950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4930000000_4940000000_dat_escrow  ON fidc_adm.transaction_new_partition_4930000000_4940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4920000000_4930000000_dat_escrow  ON fidc_adm.transaction_new_partition_4920000000_4930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4910000000_4920000000_dat_escrow  ON fidc_adm.transaction_new_partition_4910000000_4920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4900000000_4910000000_dat_escrow  ON fidc_adm.transaction_new_partition_4900000000_4910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4890000000_4900000000_dat_escrow  ON fidc_adm.transaction_new_partition_4890000000_4900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4880000000_4890000000_dat_escrow  ON fidc_adm.transaction_new_partition_4880000000_4890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4870000000_4880000000_dat_escrow  ON fidc_adm.transaction_new_partition_4870000000_4880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4860000000_4870000000_dat_escrow  ON fidc_adm.transaction_new_partition_4860000000_4870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4850000000_4860000000_dat_escrow  ON fidc_adm.transaction_new_partition_4850000000_4860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4840000000_4850000000_dat_escrow  ON fidc_adm.transaction_new_partition_4840000000_4850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4830000000_4840000000_dat_escrow  ON fidc_adm.transaction_new_partition_4830000000_4840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4820000000_4830000000_dat_escrow  ON fidc_adm.transaction_new_partition_4820000000_4830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4810000000_4820000000_dat_escrow  ON fidc_adm.transaction_new_partition_4810000000_4820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4800000000_4810000000_dat_escrow  ON fidc_adm.transaction_new_partition_4800000000_4810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4790000000_4800000000_dat_escrow  ON fidc_adm.transaction_new_partition_4790000000_4800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4780000000_4790000000_dat_escrow  ON fidc_adm.transaction_new_partition_4780000000_4790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4770000000_4780000000_dat_escrow  ON fidc_adm.transaction_new_partition_4770000000_4780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4760000000_4770000000_dat_escrow  ON fidc_adm.transaction_new_partition_4760000000_4770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4750000000_4760000000_dat_escrow  ON fidc_adm.transaction_new_partition_4750000000_4760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4740000000_4750000000_dat_escrow  ON fidc_adm.transaction_new_partition_4740000000_4750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4730000000_4740000000_dat_escrow  ON fidc_adm.transaction_new_partition_4730000000_4740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4720000000_4730000000_dat_escrow  ON fidc_adm.transaction_new_partition_4720000000_4730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4710000000_4720000000_dat_escrow  ON fidc_adm.transaction_new_partition_4710000000_4720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4700000000_4710000000_dat_escrow  ON fidc_adm.transaction_new_partition_4700000000_4710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4690000000_4700000000_dat_escrow  ON fidc_adm.transaction_new_partition_4690000000_4700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4680000000_4690000000_dat_escrow  ON fidc_adm.transaction_new_partition_4680000000_4690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4670000000_4680000000_dat_escrow  ON fidc_adm.transaction_new_partition_4670000000_4680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4660000000_4670000000_dat_escrow  ON fidc_adm.transaction_new_partition_4660000000_4670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4650000000_4660000000_dat_escrow  ON fidc_adm.transaction_new_partition_4650000000_4660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4640000000_4650000000_dat_escrow  ON fidc_adm.transaction_new_partition_4640000000_4650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4630000000_4640000000_dat_escrow  ON fidc_adm.transaction_new_partition_4630000000_4640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4620000000_4630000000_dat_escrow  ON fidc_adm.transaction_new_partition_4620000000_4630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4610000000_4620000000_dat_escrow  ON fidc_adm.transaction_new_partition_4610000000_4620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4600000000_4610000000_dat_escrow  ON fidc_adm.transaction_new_partition_4600000000_4610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4590000000_4600000000_dat_escrow  ON fidc_adm.transaction_new_partition_4590000000_4600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4580000000_4590000000_dat_escrow  ON fidc_adm.transaction_new_partition_4580000000_4590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4570000000_4580000000_dat_escrow  ON fidc_adm.transaction_new_partition_4570000000_4580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4560000000_4570000000_dat_escrow  ON fidc_adm.transaction_new_partition_4560000000_4570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4550000000_4560000000_dat_escrow  ON fidc_adm.transaction_new_partition_4550000000_4560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4540000000_4550000000_dat_escrow  ON fidc_adm.transaction_new_partition_4540000000_4550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4530000000_4540000000_dat_escrow  ON fidc_adm.transaction_new_partition_4530000000_4540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4520000000_4530000000_dat_escrow  ON fidc_adm.transaction_new_partition_4520000000_4530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4510000000_4520000000_dat_escrow  ON fidc_adm.transaction_new_partition_4510000000_4520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4500000000_4510000000_dat_escrow  ON fidc_adm.transaction_new_partition_4500000000_4510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4490000000_4500000000_dat_escrow  ON fidc_adm.transaction_new_partition_4490000000_4500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4480000000_4490000000_dat_escrow  ON fidc_adm.transaction_new_partition_4480000000_4490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4470000000_4480000000_dat_escrow  ON fidc_adm.transaction_new_partition_4470000000_4480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4460000000_4470000000_dat_escrow  ON fidc_adm.transaction_new_partition_4460000000_4470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4450000000_4460000000_dat_escrow  ON fidc_adm.transaction_new_partition_4450000000_4460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4440000000_4450000000_dat_escrow  ON fidc_adm.transaction_new_partition_4440000000_4450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4430000000_4440000000_dat_escrow  ON fidc_adm.transaction_new_partition_4430000000_4440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4420000000_4430000000_dat_escrow  ON fidc_adm.transaction_new_partition_4420000000_4430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4410000000_4420000000_dat_escrow  ON fidc_adm.transaction_new_partition_4410000000_4420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4400000000_4410000000_dat_escrow  ON fidc_adm.transaction_new_partition_4400000000_4410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4390000000_4400000000_dat_escrow  ON fidc_adm.transaction_new_partition_4390000000_4400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4380000000_4390000000_dat_escrow  ON fidc_adm.transaction_new_partition_4380000000_4390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4370000000_4380000000_dat_escrow  ON fidc_adm.transaction_new_partition_4370000000_4380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4360000000_4370000000_dat_escrow  ON fidc_adm.transaction_new_partition_4360000000_4370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4350000000_4360000000_dat_escrow  ON fidc_adm.transaction_new_partition_4350000000_4360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4340000000_4350000000_dat_escrow  ON fidc_adm.transaction_new_partition_4340000000_4350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4330000000_4340000000_dat_escrow  ON fidc_adm.transaction_new_partition_4330000000_4340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4320000000_4330000000_dat_escrow  ON fidc_adm.transaction_new_partition_4320000000_4330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4310000000_4320000000_dat_escrow  ON fidc_adm.transaction_new_partition_4310000000_4320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4300000000_4310000000_dat_escrow  ON fidc_adm.transaction_new_partition_4300000000_4310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4290000000_4300000000_dat_escrow  ON fidc_adm.transaction_new_partition_4290000000_4300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4280000000_4290000000_dat_escrow  ON fidc_adm.transaction_new_partition_4280000000_4290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4270000000_4280000000_dat_escrow  ON fidc_adm.transaction_new_partition_4270000000_4280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4260000000_4270000000_dat_escrow  ON fidc_adm.transaction_new_partition_4260000000_4270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4250000000_4260000000_dat_escrow  ON fidc_adm.transaction_new_partition_4250000000_4260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4240000000_4250000000_dat_escrow  ON fidc_adm.transaction_new_partition_4240000000_4250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4230000000_4240000000_dat_escrow  ON fidc_adm.transaction_new_partition_4230000000_4240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4220000000_4230000000_dat_escrow  ON fidc_adm.transaction_new_partition_4220000000_4230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4210000000_4220000000_dat_escrow  ON fidc_adm.transaction_new_partition_4210000000_4220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4200000000_4210000000_dat_escrow  ON fidc_adm.transaction_new_partition_4200000000_4210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4190000000_4200000000_dat_escrow  ON fidc_adm.transaction_new_partition_4190000000_4200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4180000000_4190000000_dat_escrow  ON fidc_adm.transaction_new_partition_4180000000_4190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4170000000_4180000000_dat_escrow  ON fidc_adm.transaction_new_partition_4170000000_4180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4160000000_4170000000_dat_escrow  ON fidc_adm.transaction_new_partition_4160000000_4170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4150000000_4160000000_dat_escrow  ON fidc_adm.transaction_new_partition_4150000000_4160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4140000000_4150000000_dat_escrow  ON fidc_adm.transaction_new_partition_4140000000_4150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4130000000_4140000000_dat_escrow  ON fidc_adm.transaction_new_partition_4130000000_4140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4120000000_4130000000_dat_escrow  ON fidc_adm.transaction_new_partition_4120000000_4130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4110000000_4120000000_dat_escrow  ON fidc_adm.transaction_new_partition_4110000000_4120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4100000000_4110000000_dat_escrow  ON fidc_adm.transaction_new_partition_4100000000_4110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4090000000_4100000000_dat_escrow  ON fidc_adm.transaction_new_partition_4090000000_4100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4080000000_4090000000_dat_escrow  ON fidc_adm.transaction_new_partition_4080000000_4090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4070000000_4080000000_dat_escrow  ON fidc_adm.transaction_new_partition_4070000000_4080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4060000000_4070000000_dat_escrow  ON fidc_adm.transaction_new_partition_4060000000_4070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4050000000_4060000000_dat_escrow  ON fidc_adm.transaction_new_partition_4050000000_4060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4040000000_4050000000_dat_escrow  ON fidc_adm.transaction_new_partition_4040000000_4050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4030000000_4040000000_dat_escrow  ON fidc_adm.transaction_new_partition_4030000000_4040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4020000000_4030000000_dat_escrow  ON fidc_adm.transaction_new_partition_4020000000_4030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4010000000_4020000000_dat_escrow  ON fidc_adm.transaction_new_partition_4010000000_4020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_4000000000_4010000000_dat_escrow  ON fidc_adm.transaction_new_partition_4000000000_4010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3990000000_4000000000_dat_escrow  ON fidc_adm.transaction_new_partition_3990000000_4000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3980000000_3990000000_dat_escrow  ON fidc_adm.transaction_new_partition_3980000000_3990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3970000000_3980000000_dat_escrow  ON fidc_adm.transaction_new_partition_3970000000_3980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3960000000_3970000000_dat_escrow  ON fidc_adm.transaction_new_partition_3960000000_3970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3950000000_3960000000_dat_escrow  ON fidc_adm.transaction_new_partition_3950000000_3960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3940000000_3950000000_dat_escrow  ON fidc_adm.transaction_new_partition_3940000000_3950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3930000000_3940000000_dat_escrow  ON fidc_adm.transaction_new_partition_3930000000_3940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3920000000_3930000000_dat_escrow  ON fidc_adm.transaction_new_partition_3920000000_3930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3910000000_3920000000_dat_escrow  ON fidc_adm.transaction_new_partition_3910000000_3920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3900000000_3910000000_dat_escrow  ON fidc_adm.transaction_new_partition_3900000000_3910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3890000000_3900000000_dat_escrow  ON fidc_adm.transaction_new_partition_3890000000_3900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3880000000_3890000000_dat_escrow  ON fidc_adm.transaction_new_partition_3880000000_3890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3870000000_3880000000_dat_escrow  ON fidc_adm.transaction_new_partition_3870000000_3880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3860000000_3870000000_dat_escrow  ON fidc_adm.transaction_new_partition_3860000000_3870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3850000000_3860000000_dat_escrow  ON fidc_adm.transaction_new_partition_3850000000_3860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3840000000_3850000000_dat_escrow  ON fidc_adm.transaction_new_partition_3840000000_3850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3830000000_3840000000_dat_escrow  ON fidc_adm.transaction_new_partition_3830000000_3840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3820000000_3830000000_dat_escrow  ON fidc_adm.transaction_new_partition_3820000000_3830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3810000000_3820000000_dat_escrow  ON fidc_adm.transaction_new_partition_3810000000_3820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3800000000_3810000000_dat_escrow  ON fidc_adm.transaction_new_partition_3800000000_3810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3790000000_3800000000_dat_escrow  ON fidc_adm.transaction_new_partition_3790000000_3800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3780000000_3790000000_dat_escrow  ON fidc_adm.transaction_new_partition_3780000000_3790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3770000000_3780000000_dat_escrow  ON fidc_adm.transaction_new_partition_3770000000_3780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3760000000_3770000000_dat_escrow  ON fidc_adm.transaction_new_partition_3760000000_3770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3750000000_3760000000_dat_escrow  ON fidc_adm.transaction_new_partition_3750000000_3760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3740000000_3750000000_dat_escrow  ON fidc_adm.transaction_new_partition_3740000000_3750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3730000000_3740000000_dat_escrow  ON fidc_adm.transaction_new_partition_3730000000_3740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3720000000_3730000000_dat_escrow  ON fidc_adm.transaction_new_partition_3720000000_3730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3710000000_3720000000_dat_escrow  ON fidc_adm.transaction_new_partition_3710000000_3720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3700000000_3710000000_dat_escrow  ON fidc_adm.transaction_new_partition_3700000000_3710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3690000000_3700000000_dat_escrow  ON fidc_adm.transaction_new_partition_3690000000_3700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3680000000_3690000000_dat_escrow  ON fidc_adm.transaction_new_partition_3680000000_3690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3670000000_3680000000_dat_escrow  ON fidc_adm.transaction_new_partition_3670000000_3680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3660000000_3670000000_dat_escrow  ON fidc_adm.transaction_new_partition_3660000000_3670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3650000000_3660000000_dat_escrow  ON fidc_adm.transaction_new_partition_3650000000_3660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3640000000_3650000000_dat_escrow  ON fidc_adm.transaction_new_partition_3640000000_3650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3630000000_3640000000_dat_escrow  ON fidc_adm.transaction_new_partition_3630000000_3640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3620000000_3630000000_dat_escrow  ON fidc_adm.transaction_new_partition_3620000000_3630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3610000000_3620000000_dat_escrow  ON fidc_adm.transaction_new_partition_3610000000_3620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3600000000_3610000000_dat_escrow  ON fidc_adm.transaction_new_partition_3600000000_3610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3590000000_3600000000_dat_escrow  ON fidc_adm.transaction_new_partition_3590000000_3600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3580000000_3590000000_dat_escrow  ON fidc_adm.transaction_new_partition_3580000000_3590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3570000000_3580000000_dat_escrow  ON fidc_adm.transaction_new_partition_3570000000_3580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3560000000_3570000000_dat_escrow  ON fidc_adm.transaction_new_partition_3560000000_3570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3550000000_3560000000_dat_escrow  ON fidc_adm.transaction_new_partition_3550000000_3560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3540000000_3550000000_dat_escrow  ON fidc_adm.transaction_new_partition_3540000000_3550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3530000000_3540000000_dat_escrow  ON fidc_adm.transaction_new_partition_3530000000_3540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3520000000_3530000000_dat_escrow  ON fidc_adm.transaction_new_partition_3520000000_3530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3510000000_3520000000_dat_escrow  ON fidc_adm.transaction_new_partition_3510000000_3520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3500000000_3510000000_dat_escrow  ON fidc_adm.transaction_new_partition_3500000000_3510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3490000000_3500000000_dat_escrow  ON fidc_adm.transaction_new_partition_3490000000_3500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3480000000_3490000000_dat_escrow  ON fidc_adm.transaction_new_partition_3480000000_3490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3470000000_3480000000_dat_escrow  ON fidc_adm.transaction_new_partition_3470000000_3480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3460000000_3470000000_dat_escrow  ON fidc_adm.transaction_new_partition_3460000000_3470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3450000000_3460000000_dat_escrow  ON fidc_adm.transaction_new_partition_3450000000_3460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3440000000_3450000000_dat_escrow  ON fidc_adm.transaction_new_partition_3440000000_3450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3430000000_3440000000_dat_escrow  ON fidc_adm.transaction_new_partition_3430000000_3440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3420000000_3430000000_dat_escrow  ON fidc_adm.transaction_new_partition_3420000000_3430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3410000000_3420000000_dat_escrow  ON fidc_adm.transaction_new_partition_3410000000_3420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3400000000_3410000000_dat_escrow  ON fidc_adm.transaction_new_partition_3400000000_3410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3390000000_3400000000_dat_escrow  ON fidc_adm.transaction_new_partition_3390000000_3400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3380000000_3390000000_dat_escrow  ON fidc_adm.transaction_new_partition_3380000000_3390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3370000000_3380000000_dat_escrow  ON fidc_adm.transaction_new_partition_3370000000_3380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3360000000_3370000000_dat_escrow  ON fidc_adm.transaction_new_partition_3360000000_3370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3350000000_3360000000_dat_escrow  ON fidc_adm.transaction_new_partition_3350000000_3360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3340000000_3350000000_dat_escrow  ON fidc_adm.transaction_new_partition_3340000000_3350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3330000000_3340000000_dat_escrow  ON fidc_adm.transaction_new_partition_3330000000_3340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3320000000_3330000000_dat_escrow  ON fidc_adm.transaction_new_partition_3320000000_3330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3310000000_3320000000_dat_escrow  ON fidc_adm.transaction_new_partition_3310000000_3320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3300000000_3310000000_dat_escrow  ON fidc_adm.transaction_new_partition_3300000000_3310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3290000000_3300000000_dat_escrow  ON fidc_adm.transaction_new_partition_3290000000_3300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3280000000_3290000000_dat_escrow  ON fidc_adm.transaction_new_partition_3280000000_3290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3270000000_3280000000_dat_escrow  ON fidc_adm.transaction_new_partition_3270000000_3280000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3260000000_3270000000_dat_escrow  ON fidc_adm.transaction_new_partition_3260000000_3270000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3250000000_3260000000_dat_escrow  ON fidc_adm.transaction_new_partition_3250000000_3260000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3240000000_3250000000_dat_escrow  ON fidc_adm.transaction_new_partition_3240000000_3250000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3230000000_3240000000_dat_escrow  ON fidc_adm.transaction_new_partition_3230000000_3240000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3220000000_3230000000_dat_escrow  ON fidc_adm.transaction_new_partition_3220000000_3230000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3210000000_3220000000_dat_escrow  ON fidc_adm.transaction_new_partition_3210000000_3220000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3200000000_3210000000_dat_escrow  ON fidc_adm.transaction_new_partition_3200000000_3210000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3190000000_3200000000_dat_escrow  ON fidc_adm.transaction_new_partition_3190000000_3200000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3180000000_3190000000_dat_escrow  ON fidc_adm.transaction_new_partition_3180000000_3190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3170000000_3180000000_dat_escrow  ON fidc_adm.transaction_new_partition_3170000000_3180000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3160000000_3170000000_dat_escrow  ON fidc_adm.transaction_new_partition_3160000000_3170000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3150000000_3160000000_dat_escrow  ON fidc_adm.transaction_new_partition_3150000000_3160000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3140000000_3150000000_dat_escrow  ON fidc_adm.transaction_new_partition_3140000000_3150000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3130000000_3140000000_dat_escrow  ON fidc_adm.transaction_new_partition_3130000000_3140000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3120000000_3130000000_dat_escrow  ON fidc_adm.transaction_new_partition_3120000000_3130000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3110000000_3120000000_dat_escrow  ON fidc_adm.transaction_new_partition_3110000000_3120000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3100000000_3110000000_dat_escrow  ON fidc_adm.transaction_new_partition_3100000000_3110000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3090000000_3100000000_dat_escrow  ON fidc_adm.transaction_new_partition_3090000000_3100000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3080000000_3090000000_dat_escrow  ON fidc_adm.transaction_new_partition_3080000000_3090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3070000000_3080000000_dat_escrow  ON fidc_adm.transaction_new_partition_3070000000_3080000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3060000000_3070000000_dat_escrow  ON fidc_adm.transaction_new_partition_3060000000_3070000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3050000000_3060000000_dat_escrow  ON fidc_adm.transaction_new_partition_3050000000_3060000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3040000000_3050000000_dat_escrow  ON fidc_adm.transaction_new_partition_3040000000_3050000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3030000000_3040000000_dat_escrow  ON fidc_adm.transaction_new_partition_3030000000_3040000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3020000000_3030000000_dat_escrow  ON fidc_adm.transaction_new_partition_3020000000_3030000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3010000000_3020000000_dat_escrow  ON fidc_adm.transaction_new_partition_3010000000_3020000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_3000000000_3010000000_dat_escrow  ON fidc_adm.transaction_new_partition_3000000000_3010000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2990000000_3000000000_dat_escrow  ON fidc_adm.transaction_new_partition_2990000000_3000000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2980000000_2990000000_dat_escrow  ON fidc_adm.transaction_new_partition_2980000000_2990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2970000000_2980000000_dat_escrow  ON fidc_adm.transaction_new_partition_2970000000_2980000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2960000000_2970000000_dat_escrow  ON fidc_adm.transaction_new_partition_2960000000_2970000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2950000000_2960000000_dat_escrow  ON fidc_adm.transaction_new_partition_2950000000_2960000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2940000000_2950000000_dat_escrow  ON fidc_adm.transaction_new_partition_2940000000_2950000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2930000000_2940000000_dat_escrow  ON fidc_adm.transaction_new_partition_2930000000_2940000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2920000000_2930000000_dat_escrow  ON fidc_adm.transaction_new_partition_2920000000_2930000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2910000000_2920000000_dat_escrow  ON fidc_adm.transaction_new_partition_2910000000_2920000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2900000000_2910000000_dat_escrow  ON fidc_adm.transaction_new_partition_2900000000_2910000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2890000000_2900000000_dat_escrow  ON fidc_adm.transaction_new_partition_2890000000_2900000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2880000000_2890000000_dat_escrow  ON fidc_adm.transaction_new_partition_2880000000_2890000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2870000000_2880000000_dat_escrow  ON fidc_adm.transaction_new_partition_2870000000_2880000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2860000000_2870000000_dat_escrow  ON fidc_adm.transaction_new_partition_2860000000_2870000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2850000000_2860000000_dat_escrow  ON fidc_adm.transaction_new_partition_2850000000_2860000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2840000000_2850000000_dat_escrow  ON fidc_adm.transaction_new_partition_2840000000_2850000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2830000000_2840000000_dat_escrow  ON fidc_adm.transaction_new_partition_2830000000_2840000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2820000000_2830000000_dat_escrow  ON fidc_adm.transaction_new_partition_2820000000_2830000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2810000000_2820000000_dat_escrow  ON fidc_adm.transaction_new_partition_2810000000_2820000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2800000000_2810000000_dat_escrow  ON fidc_adm.transaction_new_partition_2800000000_2810000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2790000000_2800000000_dat_escrow  ON fidc_adm.transaction_new_partition_2790000000_2800000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2780000000_2790000000_dat_escrow  ON fidc_adm.transaction_new_partition_2780000000_2790000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2770000000_2780000000_dat_escrow  ON fidc_adm.transaction_new_partition_2770000000_2780000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2760000000_2770000000_dat_escrow  ON fidc_adm.transaction_new_partition_2760000000_2770000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2750000000_2760000000_dat_escrow  ON fidc_adm.transaction_new_partition_2750000000_2760000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2740000000_2750000000_dat_escrow  ON fidc_adm.transaction_new_partition_2740000000_2750000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2730000000_2740000000_dat_escrow  ON fidc_adm.transaction_new_partition_2730000000_2740000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2720000000_2730000000_dat_escrow  ON fidc_adm.transaction_new_partition_2720000000_2730000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2710000000_2720000000_dat_escrow  ON fidc_adm.transaction_new_partition_2710000000_2720000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2700000000_2710000000_dat_escrow  ON fidc_adm.transaction_new_partition_2700000000_2710000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2690000000_2700000000_dat_escrow  ON fidc_adm.transaction_new_partition_2690000000_2700000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2680000000_2690000000_dat_escrow  ON fidc_adm.transaction_new_partition_2680000000_2690000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2670000000_2680000000_dat_escrow  ON fidc_adm.transaction_new_partition_2670000000_2680000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2660000000_2670000000_dat_escrow  ON fidc_adm.transaction_new_partition_2660000000_2670000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2650000000_2660000000_dat_escrow  ON fidc_adm.transaction_new_partition_2650000000_2660000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2640000000_2650000000_dat_escrow  ON fidc_adm.transaction_new_partition_2640000000_2650000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2630000000_2640000000_dat_escrow  ON fidc_adm.transaction_new_partition_2630000000_2640000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2620000000_2630000000_dat_escrow  ON fidc_adm.transaction_new_partition_2620000000_2630000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2610000000_2620000000_dat_escrow  ON fidc_adm.transaction_new_partition_2610000000_2620000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2600000000_2610000000_dat_escrow  ON fidc_adm.transaction_new_partition_2600000000_2610000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2590000000_2600000000_dat_escrow  ON fidc_adm.transaction_new_partition_2590000000_2600000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2580000000_2590000000_dat_escrow  ON fidc_adm.transaction_new_partition_2580000000_2590000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2570000000_2580000000_dat_escrow  ON fidc_adm.transaction_new_partition_2570000000_2580000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2560000000_2570000000_dat_escrow  ON fidc_adm.transaction_new_partition_2560000000_2570000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2550000000_2560000000_dat_escrow  ON fidc_adm.transaction_new_partition_2550000000_2560000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2540000000_2550000000_dat_escrow  ON fidc_adm.transaction_new_partition_2540000000_2550000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2530000000_2540000000_dat_escrow  ON fidc_adm.transaction_new_partition_2530000000_2540000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2520000000_2530000000_dat_escrow  ON fidc_adm.transaction_new_partition_2520000000_2530000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2510000000_2520000000_dat_escrow  ON fidc_adm.transaction_new_partition_2510000000_2520000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2500000000_2510000000_dat_escrow  ON fidc_adm.transaction_new_partition_2500000000_2510000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2490000000_2500000000_dat_escrow  ON fidc_adm.transaction_new_partition_2490000000_2500000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2480000000_2490000000_dat_escrow  ON fidc_adm.transaction_new_partition_2480000000_2490000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2470000000_2480000000_dat_escrow  ON fidc_adm.transaction_new_partition_2470000000_2480000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2460000000_2470000000_dat_escrow  ON fidc_adm.transaction_new_partition_2460000000_2470000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2450000000_2460000000_dat_escrow  ON fidc_adm.transaction_new_partition_2450000000_2460000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2440000000_2450000000_dat_escrow  ON fidc_adm.transaction_new_partition_2440000000_2450000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2430000000_2440000000_dat_escrow  ON fidc_adm.transaction_new_partition_2430000000_2440000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2420000000_2430000000_dat_escrow  ON fidc_adm.transaction_new_partition_2420000000_2430000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2410000000_2420000000_dat_escrow  ON fidc_adm.transaction_new_partition_2410000000_2420000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2400000000_2410000000_dat_escrow  ON fidc_adm.transaction_new_partition_2400000000_2410000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2390000000_2400000000_dat_escrow  ON fidc_adm.transaction_new_partition_2390000000_2400000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2380000000_2390000000_dat_escrow  ON fidc_adm.transaction_new_partition_2380000000_2390000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2370000000_2380000000_dat_escrow  ON fidc_adm.transaction_new_partition_2370000000_2380000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2360000000_2370000000_dat_escrow  ON fidc_adm.transaction_new_partition_2360000000_2370000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2350000000_2360000000_dat_escrow  ON fidc_adm.transaction_new_partition_2350000000_2360000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2340000000_2350000000_dat_escrow  ON fidc_adm.transaction_new_partition_2340000000_2350000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2330000000_2340000000_dat_escrow  ON fidc_adm.transaction_new_partition_2330000000_2340000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2320000000_2330000000_dat_escrow  ON fidc_adm.transaction_new_partition_2320000000_2330000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2310000000_2320000000_dat_escrow  ON fidc_adm.transaction_new_partition_2310000000_2320000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2300000000_2310000000_dat_escrow  ON fidc_adm.transaction_new_partition_2300000000_2310000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2290000000_2300000000_dat_escrow  ON fidc_adm.transaction_new_partition_2290000000_2300000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2190000000_2290000000_dat_escrow  ON fidc_adm.transaction_new_partition_2190000000_2290000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_2090000000_2190000000_dat_escrow  ON fidc_adm.transaction_new_partition_2090000000_2190000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_1990000000_2090000000_dat_escrow  ON fidc_adm.transaction_new_partition_1990000000_2090000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_1984000000_1990000000_dat_escrow  ON fidc_adm.transaction_new_partition_1984000000_1990000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;
CREATE INDEX transaction_new_partition_0_1984000000_dat_escrow  ON fidc_adm.transaction_new_partition_0_1984000000 USING btree (dat_escrow DESC NULLS FIRST) TABLESPACE tsifidc01;

----------------------------------
-- cria indice 2 da tabela nova --	
----------------------------------