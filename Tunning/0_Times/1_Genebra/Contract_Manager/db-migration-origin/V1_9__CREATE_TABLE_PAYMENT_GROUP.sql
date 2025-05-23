CREATE TABLE CONTRACTMANAGER_ADM.PAYMENT_GROUP (
    IDT_PAYMENT_GROUP                           NUMBER(20)                      NOT NULL,
    IND_PAYMENT_GROUP                           VARCHAR(50)                     NOT NULL,
    DAT_CREATION                                TIMESTAMP DEFAULT SYSDATE       NOT NULL,
    DAT_UPDATE                                  TIMESTAMP DEFAULT SYSDATE       NOT NULL,
    CONSTRAINT PAYMENT_GROUP_PK PRIMARY KEY (IDT_PAYMENT_GROUP)
    USING INDEX TABLESPACE TSICONTRACTMANAGER01 INITRANS 10
) TABLESPACE TSDCONTRACTMANAGER01 INITRANS 10;

COMMENT ON TABLE  CONTRACTMANAGER_ADM.PAYMENT_GROUP                                      IS 'Tabela com o Indicador da Bandeira + Meio de Pagamento (Apenas para as bandeiras homologadas) ';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.PAYMENT_GROUP.IDT_PAYMENT_GROUP                    IS 'Identificador da bandeira do cartão';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.PAYMENT_GROUP.IND_PAYMENT_GROUP                    IS 'Indicador da bandeira do cartão';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.PAYMENT_GROUP.DAT_CREATION                         IS 'Data de criação';
COMMENT ON COLUMN CONTRACTMANAGER_ADM.PAYMENT_GROUP.DAT_UPDATE                           IS 'Data da ultima atualização';
GRANT SELECT,UPDATE,INSERT,DELETE ON CONTRACTMANAGER_ADM.PAYMENT_GROUP TO CONTRACTMANAGERUBR;
GRANT SELECT ON CONTRACTMANAGER_ADM.PAYMENT_GROUP TO MANUT_CONTRACTMANAGER;

INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(1, 'CREDIT_AMEX');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(2, 'CREDIT_BANESECARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(3, 'CREDIT_CIELO_AMEX');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(4, 'CREDIT_CABAL');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(5, 'CREDIT_CIELO_DINERS');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(6, 'CREDIT_CIELO_ELO');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(7, 'CREDIT_CIELO_HIPERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(8, 'CREDIT_CIELO_MASTERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(9, 'CREDIT_CREDZ');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(10, 'CREDIT_DINERS');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(11, 'CREDIT_ELO');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(12, 'CREDIT_GOODCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(13, 'CREDIT_GLOBALPAYMENTS_DINERS');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(14, 'CREDIT_GLOBALPAYMENTS_MASTERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(15, 'CREDIT_GLOBALPAYMENTS_VISA');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(16, 'CREDIT_HIPERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(17, 'CREDIT_JCB');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(18, 'CREDIT_MAIS');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(19, 'CREDIT_MASTERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(20, 'CREDIT_SOROCRED');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(21, 'CREDIT_VISA');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(22, 'CREDIT_VERDECARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(23, 'CREDIT_INTERNATIONAL_VISA');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(24, 'DEBIT_BANESECARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(25, 'DEBIT_CABAL');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(26, 'DEBIT_CIELO_ELO');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(27, 'DEBIT_CIELO_MASTERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(28, 'DEBIT_ELO');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(29, 'DEBIT_GLOBALPAYMENTS_MASTERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(30, 'DEBIT_MASTERCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(31, 'DEBIT_OUROCARD');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(32, 'DEBIT_SOROCRED');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(33, 'DEBIT_VISA');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(34, 'DEBIT_INTERNATIONAL_VISA');
INSERT INTO CONTRACTMANAGER_ADM.PAYMENT_GROUP (IDT_PAYMENT_GROUP, IND_PAYMENT_GROUP) VALUES(35, 'DEBIT_GLOBALPAYMENTS_VISA');

COMMIT;
