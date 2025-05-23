CREATE TABLE RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION (
IDT_RECEIVABLE_ANTICIPATION NUMBER(20) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 1000 NOCYCLE NOORDER NOT NULL,
COD_ANTICIPATION VARCHAR2(36 BYTE) NOT NULL,
COD_SETTLEMENT VARCHAR2(36 BYTE),
DAT_CREATION TIMESTAMP NOT NULL,
DAT_UPDATE TIMESTAMP NOT NULL,
DAT_PARTITION DATE NOT NULL,
DAT_CANCELLED TIMESTAMP,
IND_STATUS VARCHAR2(40 BYTE) NOT NULL,
NUM_TOTAL_GROSS_AMOUNT NUMBER(11) NOT NULL,
NUM_TOTAL_NET_AMOUNT NUMBER(11) NOT NULL,
IND_REASON VARCHAR2(36 BYTE) NOT NULL,
NAM_SYSTEM VARCHAR2(36 BYTE) NOT NULL,
CONSTRAINT RECEIVABLE_ANTICIPATION_PK PRIMARY KEY (IDT_RECEIVABLE_ANTICIPATION) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48
)
PARTITION BY
RANGE(DAT_PARTITION)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P_1 VALUES LESS THAN (TO_DATE('2020-09-26','YYYY-MM-DD'))
) TABLESPACE TSDRECEIVABLES01 INITRANS 32;

COMMENT ON TABLE RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION IS 'Tabela responsável pelo armazenamento do lote de antecipações de recebíveis';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.IDT_RECEIVABLE_ANTICIPATION IS '[NOT_SECURITY_APPLY] [PK] Identificador da tabela RECEIVABLE_ANTICIPATION';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.COD_ANTICIPATION IS '[NOT_SECURITY_APPLY] Código do lote da antecipação';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.COD_SETTLEMENT IS '[NOT_SECURITY_APPLY] Código da liquidição utilizada para identificação do cashout';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.DAT_CREATION IS '[NOT_SECURITY_APPLY] Data/hora de criação do registro';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.DAT_UPDATE IS '[NOT_SECURITY_APPLY] Data/hora de atualização do registro';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.DAT_PARTITION IS '[NOT_SECURITY_APPLY] Data auxiliar para permitir particionamento de registros na tabela';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.DAT_CANCELLED IS '[NOT_SECURITY_APPLY] Data de cancelamento do lote/intenções de antecipação de recebíveis';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.IND_STATUS IS '[NOT_SECURITY_APPLY] Status identificador da situação de antecipação: SCHEDULED, FINISHED, CANCELLED';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.NUM_TOTAL_GROSS_AMOUNT IS '[NOT_SECURITY_APPLY] Valor total original da antecipação. Refere-se à soma de NUM_TOTAL_AMOUNT das tabelas de RU';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.NUM_TOTAL_NET_AMOUNT IS '[NOT_SECURITY_APPLY] Valor total a ser antecipado para o cliente. Refere-se à soma de NUM_TOTAL_AMOUNT das tabelas de RU descontado às respectivas taxas de antecipação';

COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.IND_REASON IS '[NOT_SECURITY_APPLY] Indicador do motivo da antecipação. Ex: SELF_SERVICE';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION.NAM_SYSTEM IS '[NOT_SECURITY_APPLY] Nome do sistema origem da solicitação da antecipação. Ex: CIP';


ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION ADD CONSTRAINT RECEIVABLE_ANTICIPATION_UK01 UNIQUE ( COD_ANTICIPATION ) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48 ENABLE NOVALIDATE;

ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION ADD CONSTRAINT RECEIVABLE_ANTICIPATION_UK02 UNIQUE ( COD_SETTLEMENT ) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48 ENABLE NOVALIDATE;

CREATE INDEX RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION_IDX01 ON RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION ( IND_STATUS ) INITRANS 12 TABLESPACE TSIRECEIVABLES01 ONLINE;

GRANT SELECT,UPDATE,INSERT,DELETE ON RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION TO RECEIVABLESUBR;
GRANT SELECT ON RECEIVABLES_ADM.RECEIVABLE_ANTICIPATION TO MANUT_RECEIVABLES;
