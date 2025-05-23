-- Add colunas de NUM_RECOVERED_AMOUNT para tabelas
--  RECEIVABLE_EXTERNAL
--  RECEIVABLE_INTERNAL

ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_EXTERNAL ADD NUM_RECOVERED_AMOUNT NUMBER(11, 0) DEFAULT 0 NOT NULL;
ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_INTERNAL ADD NUM_RECOVERED_AMOUNT NUMBER(11, 0) DEFAULT 0 NOT NULL;

COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_EXTERNAL.NUM_RECOVERED_AMOUNT IS '[NOT_SECURITY_APPLY] Valor recuperado após liquidação na agenda de débitos.';

COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_INTERNAL.NUM_RECOVERED_AMOUNT IS '[NOT_SECURITY_APPLY] Valor recuperado após liquidação na agenda de débitos.';
