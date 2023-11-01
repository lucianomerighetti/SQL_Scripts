-- Table: cip_liquidator_adm.nonexist_recovery_idempotency

-- DROP TABLE cip_liquidator_adm.nonexist_recovery_idempotency;

CREATE TABLE cip_liquidator_adm.nonexist_recovery_idempotency
(
    cod_nonexist_recovery_idempotency uuid NOT NULL,
    dat_creation timestamp without time zone NOT NULL DEFAULT now(),
    num_version bigint NOT NULL,
    CONSTRAINT cod_nonexist_recovery_idempotency_pk PRIMARY KEY (cod_nonexist_recovery_idempotency)
        USING INDEX TABLESPACE tsicipliquidator01
)
WITH (
    OIDS = FALSE
)
TABLESPACE tsdcipliquidator01;

ALTER TABLE cip_liquidator_adm.nonexist_recovery_idempotency
    OWNER to cip_liquidator_adm;

GRANT ALL ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency TO cip_liquidator_adm;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency TO cip_liquidatorapiubr;

GRANT INSERT, DELETE, SELECT, UPDATE ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency TO dmlexecubr;

GRANT SELECT ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency TO manut_cip_liquidator_adm;

GRANT SELECT ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency TO r_kafkacipliquidator;

GRANT SELECT ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency TO smoreira;

COMMENT ON TABLE cip_liquidator_adm.nonexist_recovery_idempotency
    IS 'TABELA DE CONTROLE DE IDEMPOTENCIA PARA NAO PROCESSAMENTO DE RECUPERACOES';

COMMENT ON COLUMN cip_liquidator_adm.nonexist_recovery_idempotency.cod_nonexist_recovery_idempotency
    IS '[NOT_SECURITY_APPLY] [PK] Codigo de de idempotencia para processamento recuperacoes';

COMMENT ON COLUMN cip_liquidator_adm.nonexist_recovery_idempotency.dat_creation
    IS '[NOT_SECURITY_APPLY] Data de Criacao';

COMMENT ON COLUMN cip_liquidator_adm.nonexist_recovery_idempotency.num_version
    IS '[NOT_SECURITY_APPLY] Numero de Versao';

-- Index: nonexist_recovery_idempotency_idx01

-- DROP INDEX cip_liquidator_adm.nonexist_recovery_idempotency_idx01;

CREATE INDEX nonexist_recovery_idempotency_idx01
    ON cip_liquidator_adm.nonexist_recovery_idempotency USING btree
    (date_trunc('day'::text, dat_creation) ASC NULLS LAST)
    TABLESPACE tsicipliquidator01;