-- inclui a coluna IDT_LEGACY na PAYMENT
ALTER TABLE RECEIVABLES_ADM.PAYMENT ADD IDT_LEGACY NUMBER(20) NULL;
COMMENT ON COLUMN RECEIVABLES_ADM.PAYMENT.IDT_LEGACY IS '[NOT_SECURITY_APPLY] Identificador da informação legada';

-- atualiza os valores da IDT_LEGACY na PAYMENT
UPDATE RECEIVABLES_ADM.PAYMENT P
SET P.IDT_LEGACY = (SELECT L.IDT_LEGACY FROM RECEIVABLES_ADM.LEGACY L WHERE L.IDT_PAYMENT = P.IDT_PAYMENT);
COMMIT;

-- cria a constraint da LEGACY na PAYMENT
ALTER TABLE RECEIVABLES_ADM.PAYMENT ADD CONSTRAINT PAYMENT_IDT_LEGACY_FK FOREIGN KEY ( IDT_LEGACY )
REFERENCES RECEIVABLES_ADM.LEGACY ( IDT_LEGACY ) ENABLE NOVALIDATE;

-- cria o indice da FK
CREATE INDEX RECEIVABLES_ADM.PAYMENT_IDX02 ON RECEIVABLES_ADM.PAYMENT (IDT_LEGACY) INITRANS 48 TABLESPACE TSDRECEIVABLES01 ONLINE;

-- altera o campo para NOT NULL
ALTER TABLE RECEIVABLES_ADM.PAYMENT MODIFY IDT_LEGACY NUMBER(20);

-- exclui a FK da PAYMENT na LEGACY
ALTER TABLE RECEIVABLES_ADM.LEGACY DROP CONSTRAINT PAYMENT_IDT_PAYMENT_FK;

-- exclui a coluna da IDT_PAYMENT na LEGACY
ALTER TABLE RECEIVABLES_ADM.LEGACY DROP COLUMN IDT_PAYMENT;
