ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_UNIT_INTERNAL ADD IND_SETTLEMENT_ACQUIRER VARCHAR2(30 BYTE);
ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_UNIT_EXTERNAL ADD IND_SETTLEMENT_ACQUIRER VARCHAR2(30 BYTE);

COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_UNIT_INTERNAL.IND_SETTLEMENT_ACQUIRER IS '[NOT_SECURITY_APPLY] Indicador de adquirente interno. Ex.: PAGSEGURO ou PAGSEGURO2';
COMMENT ON COLUMN RECEIVABLES_ADM.RECEIVABLE_UNIT_EXTERNAL.IND_SETTLEMENT_ACQUIRER IS '[NOT_SECURITY_APPLY] Indicador de adquirente interno. Ex.: PAGSEGURO ou PAGSEGURO2';
