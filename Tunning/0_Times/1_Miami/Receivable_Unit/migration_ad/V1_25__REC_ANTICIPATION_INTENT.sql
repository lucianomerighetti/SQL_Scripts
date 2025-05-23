CREATE TABLE AD.REC_ANTICIPATION_INTENT (
IDT_RECEIVABLE_ANT_INTENT NUMBER(20)  NOT NULL,
COD_RECEIVABLE_ANT_INTENT VARCHAR2(36 BYTE) NOT NULL,
IDT_RECEIVABLE_ANTICIPATION NUMBER(20) NOT NULL,
IDT_RECEIVABLE_UNIT_INTERNAL NUMBER(20),
IDT_RECEIVABLE_UNIT_EXTERNAL NUMBER(20),
NUM_GROSS_AMOUNT NUMBER(11) NOT NULL,
NUM_NET_AMOUNT NUMBER(11) NOT NULL,
NUM_ANTICIPATION_FEE_AMOUNT NUMBER(11) NOT NULL,
NUM_ANTICIPATION_FEE NUMBER(11) NOT NULL,
JSN_PAYLOAD VARCHAR2(4000 BYTE) NOT NULL,
DAT_CREATION TIMESTAMP NOT NULL,
DAT_PARTITION DATE NOT NULL,
DAT_SETTLE DATE NOT NULL,
CONSTRAINT REC_ANTICIPATION_INTENT_PK PRIMARY KEY (IDT_RECEIVABLE_ANT_INTENT) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48,
CONSTRAINT JSN_PAYLOAD_CK CHECK (JSN_PAYLOAD IS JSON)
)
PARTITION BY
RANGE(DAT_PARTITION)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P_1 VALUES LESS THAN (TO_DATE('2020-09-26','YYYY-MM-DD'))
) TABLESPACE TSDRECEIVABLES01 INITRANS 32;

COMMENT ON TABLE AD.REC_ANTICIPATION_INTENT IS 'Tabela responsável pelo armazenamento das intenções de antecipação de recebíveis';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.IDT_RECEIVABLE_ANT_INTENT IS '[NOT_SECURITY_APPLY] [PK] Identificador da tabela REC_ANTICIPATION_INTENT';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.COD_RECEIVABLE_ANT_INTENT IS '[NOT_SECURITY_APPLY] Código da intenção do recebível';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.IDT_RECEIVABLE_ANTICIPATION IS '[NOT_SECURITY_APPLY] [FK] Identificador da tabela RECEIVABLE_ANTICIPATION';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.IDT_RECEIVABLE_UNIT_INTERNAL IS '[NOT_SECURITY_APPLY] [FK] Identificador da tabela RECEIVABLE_UNIT_INTERNAL';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.IDT_RECEIVABLE_UNIT_EXTERNAL IS '[NOT_SECURITY_APPLY] [FK] Identificador da tabela RECEIVABLE_UNIT_EXTERNAL';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.NUM_GROSS_AMOUNT IS '[NOT_SECURITY_APPLY] Valor original da antecipação';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.NUM_NET_AMOUNT IS '[NOT_SECURITY_APPLY] Valor a ser antecipado para o cliente';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.NUM_ANTICIPATION_FEE_AMOUNT IS '[NOT_SECURITY_APPLY] Valor da antecipação a ser retido pelo PS';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.NUM_ANTICIPATION_FEE IS '[NOT_SECURITY_APPLY] Valor a ser descontado para antecipação';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.JSN_PAYLOAD IS '[NOT_SECURITY_APPLY] JSON com os dados da intenção de antecipação';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.DAT_CREATION IS '[NOT_SECURITY_APPLY] Data/hora de criação do registro';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.DAT_PARTITION IS '[NOT_SECURITY_APPLY] Data auxiliar para permitir particionamento de registros na tabela';
COMMENT ON COLUMN AD.REC_ANTICIPATION_INTENT.DAT_SETTLE IS '[NOT_SECURITY_APPLY] Data original da liquidação da UR';

ALTER TABLE AD.REC_ANTICIPATION_INTENT ADD CONSTRAINT REC_ANTICIPATION_INTENT_UK01 UNIQUE ( COD_RECEIVABLE_ANT_INTENT ) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48 ENABLE NOVALIDATE;

ALTER TABLE AD.REC_ANTICIPATION_INTENT ADD CONSTRAINT REC_ANT_INT_IDT_REC_ANT_FK FOREIGN KEY ( IDT_RECEIVABLE_ANTICIPATION )
REFERENCES AD.RECEIVABLE_ANTICIPATION ( IDT_RECEIVABLE_ANTICIPATION )  ENABLE NOVALIDATE;

CREATE INDEX AD.REC_ANTICIPATION_INTENT_IDX01 ON AD.REC_ANTICIPATION_INTENT (IDT_RECEIVABLE_ANTICIPATION) LOCAL INITRANS 48 TABLESPACE TSIRECEIVABLES01 ONLINE;

ALTER TABLE AD.REC_ANTICIPATION_INTENT ADD CONSTRAINT REC_ANT_INT_REC_UNI_INT_FK FOREIGN KEY ( IDT_RECEIVABLE_UNIT_INTERNAL )
REFERENCES AD.RECEIVABLE_UNIT_INTERNAL ( IDT_RECEIVABLE_UNIT ) ENABLE NOVALIDATE;

CREATE INDEX AD.REC_ANTICIPATION_INTENT_IDX02
        ON AD.REC_ANTICIPATION_INTENT ( IDT_RECEIVABLE_UNIT_INTERNAL ) LOCAL INITRANS 12 TABLESPACE TSIRECEIVABLES01 ONLINE;

ALTER TABLE AD.REC_ANTICIPATION_INTENT ADD CONSTRAINT REC_ANT_INT_REC_UNI_EXT_FK FOREIGN KEY ( IDT_RECEIVABLE_UNIT_EXTERNAL )
REFERENCES AD.RECEIVABLE_UNIT_EXTERNAL ( IDT_RECEIVABLE_UNIT ) ENABLE NOVALIDATE;

CREATE INDEX AD.REC_ANTICIPATION_INTENT_IDX03
        ON AD.REC_ANTICIPATION_INTENT ( IDT_RECEIVABLE_UNIT_EXTERNAL ) LOCAL INITRANS 12 TABLESPACE TSIRECEIVABLES01 ONLINE;

GRANT SELECT,UPDATE,INSERT,DELETE ON AD.REC_ANTICIPATION_INTENT TO RECEIVABLESUBR;
GRANT SELECT ON AD.REC_ANTICIPATION_INTENT TO MANUT_RECEIVABLES;