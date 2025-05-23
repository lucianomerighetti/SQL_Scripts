CREATE TABLE AD.CCE_RECEIVABLE_EXTERNAL (
    IDT_CCE_RECEIVABLE NUMBER(20, 0) NOT NULL ,
    IDT_RECEIVABLE NUMBER(20, 0) NOT NULL ,
    IDT_CONTRACTUAL_EFFECT NUMBER(20, 0) NOT NULL ,
    DAT_SETTLE DATE NOT NULL ,
    NUM_RESERVED_AMOUNT NUMBER(11, 0) NOT NULL ,
    FLG_ACTIVE NUMBER(1, 0) NOT NULL ,
    DAT_CREATION TIMESTAMP(6) NOT NULL, 
    DAT_UPDATE TIMESTAMP(6) NOT NULL ,
    IDT_SETTLEMENT NUMBER(20, 0) ,
	DAT_SETTLED TIMESTAMP ,
    CONSTRAINT CCE_RECEIVABLE_EXTERNAL_PK PRIMARY KEY ( IDT_CCE_RECEIVABLE ) USING INDEX TABLESPACE TSIRECEIVABLES01  INITRANS 48
)
PARTITION BY
RANGE(DAT_SETTLE)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P_1 VALUES LESS THAN (TO_DATE('2020-10-10','YYYY-MM-DD'))
) TABLESPACE TSDRECEIVABLES01 INITRANS 32
;

COMMENT ON TABLE AD.CCE_RECEIVABLE_EXTERNAL IS 'Tabela de relacionamento entre os efeitos de contrato e recebível externo';

COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.IDT_CCE_RECEIVABLE IS '[NOT_SECURITY_APPLY] Identificador do efeito de contrato do recebível externo';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.IDT_RECEIVABLE IS '[NOT_SECURITY_APPLY] Identificador do recebível externo';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.IDT_CONTRACTUAL_EFFECT IS '[NOT_SECURITY_APPLY] Identificador do efeito de contrato';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.DAT_SETTLE IS '[NOT_SECURITY_APPLY] Data a ser liquidada da unidade de recebivel';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.NUM_RESERVED_AMOUNT IS '[NOT_SECURITY_APPLY] Valor Reservado pelo contrato';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.FLG_ACTIVE IS '[NOT_SECURITY_APPLY] Flag de Ativo (1 = Ativo / 0 = Inativo)';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.DAT_CREATION IS '[NOT_SECURITY_APPLY] Data de criação';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.DAT_UPDATE IS '[NOT_SECURITY_APPLY] Data de atualização';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.IDT_SETTLEMENT IS '[NOT_SECURITY_APPLY] Identificador da Settlement que liquidou o Contractual Effect.';
COMMENT ON COLUMN AD.CCE_RECEIVABLE_EXTERNAL.DAT_SETTLED IS '[NOT_SECURITY_APPLY] Data que o valor reservado para o Receivable foi liquidado.';

CREATE INDEX AD.CCE_RECEIVABLE_EXTERNAL_IDX01 ON AD.CCE_RECEIVABLE_EXTERNAL ( DAT_SETTLE, IDT_CONTRACTUAL_EFFECT )
 LOCAL INITRANS 48 TABLESPACE TSIRECEIVABLES01 ONLINE;

CREATE INDEX AD.CCE_RECEIVABLE_EXTERNAL_IDX02 ON AD.CCE_RECEIVABLE_EXTERNAL ( DAT_SETTLE, IDT_RECEIVABLE )
LOCAL INITRANS 48 TABLESPACE TSIRECEIVABLES01 ONLINE;

ALTER TABLE AD.CCE_RECEIVABLE_EXTERNAL
    ADD CONSTRAINT CCE_REC_EXTER_IDT_CCE_FK FOREIGN KEY ( IDT_CONTRACTUAL_EFFECT )
        REFERENCES AD.CONTRACTUAL_EFFECT ( IDT_CONTRACTUAL_EFFECT ) ENABLE NOVALIDATE;

ALTER TABLE AD.CCE_RECEIVABLE_EXTERNAL
    ADD CONSTRAINT CCE_REC_EXTER_IDT_REC_EXTER_FK FOREIGN KEY ( IDT_RECEIVABLE )
        REFERENCES AD.RECEIVABLE_EXTERNAL ( IDT_RECEIVABLE ) ENABLE NOVALIDATE;
		
ALTER TABLE AD.CCE_RECEIVABLE_EXTERNAL
    ADD CONSTRAINT CCE_REC_EXTER_IDT_SETT_FK FOREIGN KEY ( IDT_SETTLEMENT )
        REFERENCES AD.SETTLEMENT ( IDT_SETTLEMENT ) ENABLE NOVALIDATE;

CREATE INDEX AD.CCE_RECEIVABLE_EXTERNAL_IDX03 
    ON AD.CCE_RECEIVABLE_EXTERNAL ( DAT_SETTLE, IDT_SETTLEMENT )
        LOCAL INITRANS 48 TABLESPACE TSIRECEIVABLES01 ONLINE;		

GRANT SELECT,UPDATE,INSERT,DELETE ON AD.CCE_RECEIVABLE_EXTERNAL TO RECEIVABLESUBR;
GRANT SELECT ON AD.CCE_RECEIVABLE_EXTERNAL TO MANUT_RECEIVABLES;