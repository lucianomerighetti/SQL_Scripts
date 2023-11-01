CREATE TABLE AD.PAYMENT_GROUP (
    IDT_PAYMENT_GROUP                           NUMBER(20)                      NOT NULL,
    IND_PAYMENT_GROUP                           VARCHAR(50)                     NOT NULL,
    DAT_CREATED                                 TIMESTAMP DEFAULT SYSDATE       NOT NULL,
    DAT_UPDATED                                 TIMESTAMP DEFAULT SYSDATE       NOT NULL,
    CONSTRAINT PAYMENT_GROUP_PK PRIMARY KEY (IDT_PAYMENT_GROUP)
    USING INDEX TABLESPACE TSIRECTRANSITORYMOVEMENT01
) TABLESPACE TSDRECTRANSITORYMOVEMENT01;
COMMENT ON TABLE  AD.PAYMENT_GROUP                                      IS 'Tabela com os grupos de pagamento (Indicador de Bandeira + Meio de Pagamento) aceitos na unidade do recebivel';
COMMENT ON COLUMN AD.PAYMENT_GROUP.IDT_PAYMENT_GROUP                    IS 'Identificador do grupo de pagamento';
COMMENT ON COLUMN AD.PAYMENT_GROUP.IND_PAYMENT_GROUP                    IS 'Indicador do grupo de pagamento';
COMMENT ON COLUMN AD.PAYMENT_GROUP.DAT_CREATED                          IS 'Data de criação';
COMMENT ON COLUMN AD.PAYMENT_GROUP.DAT_UPDATED                          IS 'Data da ultima atualização';
GRANT SELECT,UPDATE,INSERT,DELETE ON AD.PAYMENT_GROUP TO RECTRANSITORYMOVEMENTUBR;
GRANT SELECT ON AD.PAYMENT_GROUP TO MANUT_RECTRANSITORYMOVEMENT;
