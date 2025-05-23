create TABLE CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION (
    IDT_CUSTOMER_REPLICATION        NUMBER(20)
    GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCACHE NOCYCLE NOT NULL,
    COD_CUSTOMER                    VARCHAR(50)                 NOT NULL,
    IND_STATUS                      VARCHAR(1)                  NOT NULL,
    DAT_CREATION                    TIMESTAMP DEFAULT SYSDATE   NOT NULL,
    DAT_UPDATE                      TIMESTAMP DEFAULT SYSDATE   NOT NULL,
    CONSTRAINT CUSTOMER_REPLICATION_PK PRIMARY KEY (IDT_CUSTOMER_REPLICATION)
    USING INDEX TABLESPACE TSICONTRACTMANAGER01 INITRANS 10
) TABLESPACE TSDCONTRACTMANAGER01 INITRANS 10;

COMMENT ON TABLE  CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION                                       IS 'Tabela de controle de usuários do PagS registrados na CERC';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION.IDT_CUSTOMER_REPLICATION              IS 'Identificador da tabela';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION.COD_CUSTOMER                          IS 'Código do lojista';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION.IND_STATUS                            IS 'Status do lojista no contexto do PagS';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION.DAT_CREATION                          IS 'Data de inserção do evento na tabela';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION.DAT_UPDATE                            IS 'Data de atualização do evento na tabela';

GRANT SELECT,UPDATE,INSERT,DELETE ON CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION TO CONTRACTMANAGERUBR;
GRANT SELECT ON CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION TO MANUT_CONTRACTMANAGER;

ALTER TABLE CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION ADD CONSTRAINT CUSTOMER_REPLICATION_UK01 UNIQUE ( COD_CUSTOMER ) USING INDEX TABLESPACE TSICONTRACTMANAGER01 INITRANS 12 ENABLE NOVALIDATE;
CREATE INDEX CUSTOMER_REPLICATION_IDX01 ON CONTRACTMANAGER_ADM.CUSTOMER_REPLICATION(IND_STATUS) INITRANS 12 TABLESPACE TSICONTRACTMANAGER01 ONLINE;
