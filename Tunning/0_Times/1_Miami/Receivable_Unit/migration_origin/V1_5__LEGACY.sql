CREATE TABLE RECEIVABLES_ADM.LEGACY (
    IDT_LEGACY               NUMBER(20) GENERATED ALWAYS AS IDENTITY INCREMENT BY 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 CACHE 1000 NOCYCLE NOORDER NOT NULL,
    IDT_PAYMENT              NUMBER(20) NOT NULL,
    IDT_TRANSACTION          NUMBER(20) NOT NULL,
    IDT_SELLER_SAFEPAY_USER  NUMBER(20) NOT NULL,
    CONSTRAINT LEGACY_PK PRIMARY KEY ( IDT_LEGACY ) USING INDEX TABLESPACE TSIRECEIVABLES01 INITRANS 48
) TABLESPACE TSDRECEIVABLES01 INITRANS 32;

COMMENT ON TABLE RECEIVABLES_ADM.LEGACY IS 'Tabela de informações legadas do PagSeguro';

COMMENT ON COLUMN RECEIVABLES_ADM.LEGACY.idt_LEGACY IS '[NOT_SECURITY_APPLY] Identificador da informação legada';

COMMENT ON COLUMN RECEIVABLES_ADM.LEGACY.idt_payment IS '[NOT_SECURITY_APPLY] Identificador do pagamento';

COMMENT ON COLUMN RECEIVABLES_ADM.LEGACY.idt_transaction IS '[NOT_SECURITY_APPLY] Identificador da transação';

COMMENT ON COLUMN RECEIVABLES_ADM.LEGACY.idt_seller_safepay_user IS '[NOT_SECURITY_APPLY] Identificador do usuário vendedor do Pagseguro';

CREATE INDEX RECEIVABLES_ADM.LEGACY_IDX01 ON RECEIVABLES_ADM.LEGACY (IDT_PAYMENT) INITRANS 48 TABLESPACE TSIRECEIVABLES01 ONLINE;

ALTER TABLE RECEIVABLES_ADM.LEGACY ADD CONSTRAINT PAYMENT_IDT_PAYMENT_FK FOREIGN KEY ( IDT_PAYMENT )
        REFERENCES RECEIVABLES_ADM.PAYMENT ( IDT_PAYMENT ) ENABLE NOVALIDATE;		
		
GRANT SELECT,UPDATE,INSERT,DELETE ON RECEIVABLES_ADM.LEGACY TO RECEIVABLESUBR;
GRANT SELECT ON RECEIVABLES_ADM.LEGACY TO MANUT_RECEIVABLES;		