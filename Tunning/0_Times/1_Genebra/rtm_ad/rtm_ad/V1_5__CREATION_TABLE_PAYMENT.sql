CREATE TABLE AD.PAYMENT (
    IDT_PAYMENT                     NUMBER(20)                       NOT NULL,
    COD_PAYMENT                     VARCHAR(50)                     NOT NULL,
    NUM_TOTAL_AMOUNT                NUMBER(18, 2)                   NOT NULL,
    NUM_NET_AMOUNT                  NUMBER(18, 2)                   NOT NULL,
    DAT_CREATED                     TIMESTAMP DEFAULT SYSDATE       NOT NULL,
    DAT_UPDATED                     TIMESTAMP DEFAULT SYSDATE       NOT NULL,
    IND_ESCROW_TYPE                 VARCHAR(1)                      NOT NULL,
    NUM_ESCROW_VALUE                NUMBER(2)                       NOT NULL,
    COD_CUSTOMER_SELLER             VARCHAR(50)                     NOT NULL,
    COD_CUSTOMER_BUYER              VARCHAR(50)                     NOT NULL,
    CONSTRAINT PAYMENT_PK PRIMARY KEY (IDT_PAYMENT)
    USING INDEX TABLESPACE TSIRECTRANSITORYMOVEMENT01 INITRANS 10
)
PARTITION BY RANGE(IDT_PAYMENT)
INTERVAL (2500000)
(PARTITION P_2500000 VALUES LESS THAN (2500000)
) TABLESPACE TSDRECTRANSITORYMOVEMENT01 INITRANS 10;
COMMENT ON TABLE  AD.PAYMENT                                     IS 'Tabela com informações do pagamento';
COMMENT ON COLUMN AD.PAYMENT.IDT_PAYMENT                         IS 'Identificador do pagamento';
COMMENT ON COLUMN AD.PAYMENT.COD_PAYMENT                         IS 'Código do pagamento';
COMMENT ON COLUMN AD.PAYMENT.NUM_TOTAL_AMOUNT                    IS 'Valor total do pagamento';
COMMENT ON COLUMN AD.PAYMENT.NUM_NET_AMOUNT                      IS 'Valor Liquido do pagamento';
COMMENT ON COLUMN AD.PAYMENT.DAT_CREATED                         IS 'Data de criação do pagamento';
COMMENT ON COLUMN AD.PAYMENT.DAT_UPDATED                         IS 'Data ultima atualização do pagamento';
COMMENT ON COLUMN AD.PAYMENT.IND_ESCROW_TYPE                     IS 'Indicador de condições de pagamento para o cliente. M - MULTIPLE, U - UNIQUE';
COMMENT ON COLUMN AD.PAYMENT.NUM_ESCROW_VALUE                    IS 'Valor de condições de pagamento para o cliente. Range de 1-18 para escrow MULTIPLE e de 1-30 UNIQUE';
COMMENT ON COLUMN AD.PAYMENT.COD_CUSTOMER_SELLER                 IS 'Identificador do usuário vendedor do PagSeguro';
COMMENT ON COLUMN AD.PAYMENT.COD_CUSTOMER_BUYER                  IS 'Identificador do usuário comprador do PagSeguro';
ALTER TABLE AD.PAYMENT ADD CONSTRAINT PAYMENT_UK01 UNIQUE (COD_PAYMENT);
GRANT SELECT,UPDATE,INSERT,DELETE ON AD.PAYMENT TO RECTRANSITORYMOVEMENTUBR;
GRANT SELECT ON AD.PAYMENT TO MANUT_RECTRANSITORYMOVEMENT;