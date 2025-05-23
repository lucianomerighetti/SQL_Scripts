CREATE TABLE AD.SUSPENSION (
IDT_SUSPENSION NUMBER(20)  NOT NULL,
DES_REASON VARCHAR2(60) NOT NULL,
NUM_ORDER NUMBER(2) NOT NULL,
NUM_CANCELED_AMOUNT NUMBER(11) NOT NULL,
NUM_SUSPENDED_AMOUNT NUMBER(11) NOT NULL,
DAT_CREATION TIMESTAMP NOT NULL,
DAT_UPDATE TIMESTAMP NOT NULL,
JSN_PAYLOAD VARCHAR2(4000) NOT NULL,
IDT_PAYMENT_SUSPENSION NUMBER(20) NOT NULL,
FLG_ACTIVE NUMBER(1) NOT NULL,
CONSTRAINT SUSPENSION_PK PRIMARY KEY (IDT_SUSPENSION ) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48,
CONSTRAINT JSN_PAYLOAD_SUSPENSION_CK CHECK ( JSN_PAYLOAD IS JSON )
) INITRANS 32 TABLESPACE TSDRECEIVABLES01
;

COMMENT ON TABLE AD.SUSPENSION IS 'Tabela relacionada a valores de suspensões de pagamento';
COMMENT ON COLUMN AD.SUSPENSION.IDT_SUSPENSION IS '[NOT_SECURITY_APPLY] Identificador da suspensão';
COMMENT ON COLUMN AD.SUSPENSION.DES_REASON IS '[NOT_SECURITY_APPLY] Campo para identificar a razão da suspensão do pagamento';
COMMENT ON COLUMN AD.SUSPENSION.NUM_ORDER IS '[NOT_SECURITY_APPLY] Ordem das suspensões';
COMMENT ON COLUMN AD.SUSPENSION.NUM_CANCELED_AMOUNT IS '[NOT_SECURITY_APPLY] Campo para identificar o valor cancelado';
COMMENT ON COLUMN AD.SUSPENSION.NUM_SUSPENDED_AMOUNT IS '[NOT_SECURITY_APPLY] Campo para identificar o valor suspenso';
COMMENT ON COLUMN AD.SUSPENSION.DAT_CREATION IS '[NOT_SECURITY_APPLY] Data de criação';
COMMENT ON COLUMN AD.SUSPENSION.DAT_UPDATE IS '[NOT_SECURITY_APPLY] Data de atualização';
COMMENT ON COLUMN AD.SUSPENSION.JSN_PAYLOAD IS '[NOT_SECURITY_APPLY] Payload enviado em formato json';
COMMENT ON COLUMN AD.SUSPENSION.IDT_PAYMENT_SUSPENSION IS '[NOT_SECURITY_APPLY] Identificador para relacionamento com a tabela PAYMENT_SUSPENSION';
COMMENT ON COLUMN AD.SUSPENSION.FLG_ACTIVE IS '[NOT_SECURITY_APPLY] Identificar se o registro está ativo';

CREATE INDEX AD.SUSPENSION_IDX01 ON AD.SUSPENSION ( IDT_PAYMENT_SUSPENSION ) INITRANS 48 TABLESPACE TSIRECEIVABLES01 ONLINE;

ALTER TABLE AD.SUSPENSION ADD CONSTRAINT SUSP_IDT_PAYMENT_SUSPENSION_FK FOREIGN KEY ( IDT_PAYMENT_SUSPENSION )
        REFERENCES AD.PAYMENT_SUSPENSION ( IDT_PAYMENT_SUSPENSION ) ENABLE NOVALIDATE;
		
GRANT SELECT,UPDATE,INSERT,DELETE ON AD.SUSPENSION TO RECEIVABLESUBR;
GRANT SELECT ON AD.SUSPENSION TO MANUT_RECEIVABLES;