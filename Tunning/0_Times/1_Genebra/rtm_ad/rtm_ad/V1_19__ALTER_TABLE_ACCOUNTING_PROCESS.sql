DROP INDEX AD.ACCOUNTING_PROCESS_IDX01;
ALTER TABLE AD.ACCOUNTING_PROCESS RENAME COLUMN DAT_PARTITON TO DAT_PARTITION;
ALTER TABLE AD.ACCOUNTING_PROCESS RENAME COLUMN COD_TRANSACTION TO COD_PAYMENT;
CREATE INDEX AD.ACCOUNTING_PROCESS_IDX01 ON AD.ACCOUNTING_PROCESS ( COD_PAYMENT ) INITRANS 48 TABLESPACE TSIRECTRANSITORYMOVEMENT01 ONLINE;

COMMENT ON COLUMN AD.ACCOUNTING_PROCESS.COD_PAYMENT                      IS '[NOT_SECURITY_APPLY] Código do pagamento';