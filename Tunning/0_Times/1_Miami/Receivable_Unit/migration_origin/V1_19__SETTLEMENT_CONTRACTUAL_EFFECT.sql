CREATE TABLE RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT (
    IDT_CONTRACTUAL_EFFECT      NUMBER(20) NOT NULL,
    IDT_SETTLEMENT              NUMBER(20) NOT NULL,
	DAT_CREATION 				TIMESTAMP NOT NULL,
    CONSTRAINT SETTLEMENT_CONTR_EFFECT_PK PRIMARY KEY ( IDT_CONTRACTUAL_EFFECT, IDT_SETTLEMENT ) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48
) INITRANS 32
TABLESPACE TSDRECEIVABLES01;

COMMENT ON TABLE RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT IS 'Tabela de associação M:N entre SETTLEMENT e CONTRACTUAL_EFFECT';

COMMENT ON COLUMN RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT.IDT_CONTRACTUAL_EFFECT IS '[NOT_SECURITY_APPLY] Identificador do CONTRACTUAL_EFFECT que foi liquidado através das SETTLEMENT';

COMMENT ON COLUMN RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT.IDT_SETTLEMENT IS '[NOT_SECURITY_APPLY] Identificador da SETTLEMENT que liquidou os CONTRACTUAL_EFFECT';

COMMENT ON COLUMN RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT.DAT_CREATION IS '[NOT_SECURITY_APPLY] Data/hora de criação do registro';

-- FK with index
ALTER TABLE RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT ADD CONSTRAINT SET_CON_EFFE_IDT_CON_EFFE_FK FOREIGN KEY ( IDT_CONTRACTUAL_EFFECT )
        REFERENCES RECEIVABLES_ADM.CONTRACTUAL_EFFECT ( IDT_CONTRACTUAL_EFFECT ) ENABLE NOVALIDATE;

CREATE INDEX RECEIVABLES_ADM.SET_CONTRACTUAL_EFFECT_IDX01 
        ON RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT ( IDT_CONTRACTUAL_EFFECT ) INITRANS 12 TABLESPACE TSIRECEIVABLES01 ONLINE;

ALTER TABLE RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT ADD CONSTRAINT SET_CON_EFFE_IDT_SETTLEMENT_FK FOREIGN KEY ( IDT_SETTLEMENT )
        REFERENCES RECEIVABLES_ADM.SETTLEMENT ( IDT_SETTLEMENT ) ENABLE NOVALIDATE;

CREATE INDEX RECEIVABLES_ADM.SET_CONTRACTUAL_EFFECT_IDX02 
        ON RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT ( IDT_SETTLEMENT ) INITRANS 12 TABLESPACE TSIRECEIVABLES01 ONLINE;
        

-- Grants
GRANT SELECT,UPDATE,INSERT,DELETE ON RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT TO RECEIVABLESUBR;
GRANT SELECT ON RECEIVABLES_ADM.SETTLEMENT_CONTRACTUAL_EFFECT TO MANUT_RECEIVABLES;

