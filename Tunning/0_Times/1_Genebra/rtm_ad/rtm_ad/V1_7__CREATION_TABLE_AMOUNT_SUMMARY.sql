CREATE TABLE AD.AMOUNT_SUMMARY (
    IDT_AMOUNT_SUMMARY                      NUMBER(20)                       NOT NULL,
    IDT_RECEIVABLE                          NUMBER(20)                      NOT NULL,
    NUM_TOTAL                               NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_SETTLE                              NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_SETTLED                             NUMBER(18, 2)  ,
    NUM_SUSPENDED                           NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_CANCELED                            NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_ANTICIPATED                         NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_COMMITTED                           NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_IN_PERSON                           NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_ONLINE                              NUMBER(18, 2)  DEFAULT 0        NOT NULL,
    NUM_VERSION                             NUMBER(5)                       NOT NULL,
    DAT_SETTLE                              DATE                            NOT NULL,
    CONSTRAINT AMOUNT_SUMMARY_PK PRIMARY KEY (IDT_AMOUNT_SUMMARY)
    USING INDEX TABLESPACE TSIRECTRANSITORYMOVEMENT01 INITRANS 10
) PARTITION BY
RANGE(DAT_SETTLE)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P_2020_09_10 VALUES LESS THAN (TO_DATE('2020-09-10','YYYY-MM-DD'))
) TABLESPACE TSDRECTRANSITORYMOVEMENT01 INITRANS 10;


COMMENT ON TABLE  AD.AMOUNT_SUMMARY                                          IS 'Tabela com informações dos valores do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.IDT_AMOUNT_SUMMARY                       IS 'Código do sumario do recebivel, identificador da tabela';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.IDT_RECEIVABLE                           IS 'Código da unidade do recebivel, integração com a tabela de recebiveis';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_TOTAL                                IS 'Valor total do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_SETTLE                               IS 'Valor a liquidar do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_SETTLED                              IS 'Valor liquidado do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_SUSPENDED                            IS 'Valor suspenso do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_CANCELED                             IS 'Valor cancelado do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_ANTICIPATED                          IS 'Valor antecipado do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_COMMITTED                            IS 'Valor intermediado no caso external, valor reservado no caso internal';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_IN_PERSON                            IS 'Valor total da dos recebiveis presencial';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_ONLINE                               IS 'Valor total da dos recebiveis online';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.NUM_VERSION                              IS 'Versao corrente do recebivel';
COMMENT ON COLUMN AD.AMOUNT_SUMMARY.DAT_SETTLE                               IS 'Data de liquidacao do recebivel';
ALTER TABLE AD.AMOUNT_SUMMARY ADD CONSTRAINT AMOUNT_SUMMARY_UK01 UNIQUE (IDT_RECEIVABLE, NUM_VERSION);
ALTER TABLE AD.AMOUNT_SUMMARY ADD CONSTRAINT AMOUNT_SUMMARY_IDT_RECEIVABLE_FK FOREIGN KEY ( IDT_RECEIVABLE )
        REFERENCES AD.RECEIVABLE ( IDT_RECEIVABLE );
CREATE INDEX AD.AMOUNT_SUMMARY_IDX01 ON AMOUNT_SUMMARY(IDT_RECEIVABLE) INITRANS 10 TABLESPACE TSIRECTRANSITORYMOVEMENT01 ONLINE;
GRANT SELECT,UPDATE,INSERT,DELETE ON AD.AMOUNT_SUMMARY TO RECTRANSITORYMOVEMENTUBR;
GRANT SELECT ON AD.AMOUNT_SUMMARY TO MANUT_RECTRANSITORYMOVEMENT;