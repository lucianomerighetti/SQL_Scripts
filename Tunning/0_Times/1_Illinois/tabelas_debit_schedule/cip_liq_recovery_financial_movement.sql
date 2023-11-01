-- Table: cip_liquidator_adm.recovery_financial_movement

-- DROP TABLE cip_liquidator_adm.recovery_financial_movement;

CREATE TABLE cip_liquidator_adm.recovery_financial_movement
(
    cod_recovery_financial_movement uuid NOT NULL,
    cod_reference uuid NOT NULL,
    idt_percentual_recovery bigint,
    idt_chargeback_recovery bigint,
    num_recovered_amount numeric(10,2) NOT NULL,
    dat_creation timestamp without time zone NOT NULL,
    dat_update timestamp without time zone NOT NULL,
    idt_safepay_debtor bigint NOT NULL,
    idt_financial_account_debt_type bigint NOT NULL,
    jsn_payload text COLLATE pg_catalog."default",
    ind_status character varying(20) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    CONSTRAINT recovery_financial_movement_pkey PRIMARY KEY (cod_recovery_financial_movement)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE cip_liquidator_adm.recovery_financial_movement
    OWNER to cip_liquidator_adm;

GRANT ALL ON TABLE cip_liquidator_adm.recovery_financial_movement TO cip_liquidator_adm;

GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE cip_liquidator_adm.recovery_financial_movement TO cip_liquidatorapiubr;

GRANT INSERT, DELETE, UPDATE, SELECT ON TABLE cip_liquidator_adm.recovery_financial_movement TO dmlexecubr;

GRANT SELECT ON TABLE cip_liquidator_adm.recovery_financial_movement TO igoncalves;

GRANT SELECT ON TABLE cip_liquidator_adm.recovery_financial_movement TO manut_cip_liquidator_adm;

GRANT SELECT ON TABLE cip_liquidator_adm.recovery_financial_movement TO r_datagovernance;

GRANT SELECT ON TABLE cip_liquidator_adm.recovery_financial_movement TO r_kafkacipliquidator;

GRANT SELECT ON TABLE cip_liquidator_adm.recovery_financial_movement TO smoreira;

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.cod_recovery_financial_movement
    IS '[NOT_SECURITY_APPLY] [PK] Codigo de recuperacao de movimentacao financeira';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.cod_reference
    IS '[NOT_SECURITY_APPLY] Codigo de referencia da transação (cod_safepay_transaction';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.idt_percentual_recovery
    IS '[NOT_SECURITY_APPLY] Identificador do percentual de recuperacao';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.idt_chargeback_recovery
    IS '[NOT_SECURITY_APPLY] Identificador do chargeback de recuperacao';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.num_recovered_amount
    IS '[NOT_SECURITY_APPLY] Valor recuperado';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.dat_creation
    IS '[NOT_SECURITY_APPLY] Data de Criacao';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.dat_update
    IS '[NOT_SECURITY_APPLY] Data de Atualizacao';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.idt_safepay_debtor
    IS '[NOT_SECURITY_APPLY] Identificador do usuario devedor';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.idt_financial_account_debt_type
    IS '[NOT_SECURITY_APPLY] Identificador do tipo de conta de debito';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.jsn_payload
    IS '[NOT_SECURITY_APPLY] JSON do Payload';

COMMENT ON COLUMN cip_liquidator_adm.recovery_financial_movement.ind_status
    IS '[NOT_SECURITY_APPLY] Indicador de Status da movimentacao';

-- Index: idx_recovery_financial_codref

-- DROP INDEX cip_liquidator_adm.idx_recovery_financial_codref;

CREATE INDEX idx_recovery_financial_codref
    ON cip_liquidator_adm.recovery_financial_movement USING btree
    (cod_reference ASC NULLS LAST)
    TABLESPACE tsdcipliquidator01;


-- Index: recovery_financial_movement_idx02

-- DROP INDEX cip_liquidator_adm.recovery_financial_movement_idx02;

CREATE INDEX recovery_financial_movement_idx02
    ON cip_liquidator_adm.recovery_financial_movement USING btree
    (dat_creation ASC NULLS LAST)
    TABLESPACE tsicipliquidator01;


-- Index: recovery_financial_movement_idx03

-- DROP INDEX cip_liquidator_adm.recovery_financial_movement_idx03;

CREATE INDEX recovery_financial_movement_idx03
    ON cip_liquidator_adm.recovery_financial_movement USING btree
    (dat_update ASC NULLS LAST)
    TABLESPACE tsicipliquidator01;


-- Index: recovery_financial_movement_idx04

-- DROP INDEX cip_liquidator_adm.recovery_financial_movement_idx04;

CREATE INDEX recovery_financial_movement_idx04
    ON cip_liquidator_adm.recovery_financial_movement USING btree
    (idt_percentual_recovery ASC NULLS LAST)
    TABLESPACE tsicipliquidator01;