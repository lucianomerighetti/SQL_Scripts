ALTER TABLE AD.CASHOUT
ADD IDT_LEGACY_SAFEPAY_USER NUMBER(20) DEFAULT 0 NOT NULL;

ALTER TABLE AD.CASHOUT
ADD COD_CUSTOMER_RECEIVER VARCHAR2(36 BYTE) DEFAULT ' ' NOT NULL;

COMMENT ON COLUMN AD.CASHOUT.IDT_LEGACY_SAFEPAY_USER IS '[NOT_SECURITY_APPLY] IDT DO RECEBEDOR DO CASHOUT LEGADO';
COMMENT ON COLUMN AD.CASHOUT.COD_CUSTOMER_RECEIVER IS '[NOT_SECURITY_APPLY] COD IDENTIFICADOR DO RECEBEDOR DO CASHOUT';
