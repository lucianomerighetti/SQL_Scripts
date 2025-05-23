CREATE TABLE RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS (
    IDT_ACCOUNTING_PROCESS            NUMBER(20)                      GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 1000 NOCYCLE NOORDER NOT NULL,
    COD_ACCOUNTING_PROCESS            VARCHAR(50)                     NOT NULL,
    DAT_CREATION                      TIMESTAMP DEFAULT SYSDATE       NOT NULL,  
    COD_TRANSACTION                   VARCHAR(50)                     NOT NULL,
    DAT_PARTITON                      DATE DEFAULT SYSDATE            NOT NULL, 
    CONSTRAINT ACCOUNTING_PROCESS_PK PRIMARY KEY (IDT_ACCOUNTING_PROCESS)
    USING INDEX TABLESPACE TSIRECTRANSITORYMOVEMENT01 INITRANS 48
) PARTITION BY
RANGE(DAT_PARTITON)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P_1 VALUES LESS THAN (TO_DATE('2020-10-27','YYYY-MM-DD'))
) TABLESPACE TSDRECTRANSITORYMOVEMENT01 INITRANS 64 PCTFREE 20;

COMMENT ON TABLE  RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS                                      IS '[NOT_SECURITY_APPLY] Tabela de controle de movimentações enviadas ao Accounting API';
COMMENT ON COLUMN RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS.IDT_ACCOUNTING_PROCESS               IS '[NOT_SECURITY_APPLY] Identificador da movimentação enviada ao Accounting API';
COMMENT ON COLUMN RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS.COD_ACCOUNTING_PROCESS               IS '[NOT_SECURITY_APPLY] Código da movimentação enviada ao Accounting API';
COMMENT ON COLUMN RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS.DAT_CREATION                         IS '[NOT_SECURITY_APPLY] Data de criação do registro de envio da movimentação';
COMMENT ON COLUMN RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS.COD_TRANSACTION                      IS '[NOT_SECURITY_APPLY] Código da transação';
COMMENT ON COLUMN RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS.DAT_PARTITON                         IS '[NOT_SECURITY_APPLY] Data da partição da tabela';

ALTER TABLE RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS ADD CONSTRAINT ACCOUNTING_PROCESS_UK01 UNIQUE (COD_ACCOUNTING_PROCESS)  USING INDEX TABLESPACE TSIRECTRANSITORYMOVEMENT01 INITRANS 48 ENABLE NOVALIDATE;

CREATE INDEX RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS_IDX01 ON RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS ( COD_TRANSACTION ) INITRANS 48 TABLESPACE TSIRECTRANSITORYMOVEMENT01 ONLINE;

GRANT SELECT,UPDATE,INSERT,DELETE ON RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS TO RECTRANSITORYMOVEMENTUBR;
GRANT SELECT ON RECTRANSITORYMOVEMENT_ADM.ACCOUNTING_PROCESS TO MANUT_RECTRANSITORYMOVEMENT;