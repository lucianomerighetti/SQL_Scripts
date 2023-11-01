ALTER TABLE AD.RECEIVABLE_INTERNAL ADD FLG_FEE_ROUNDED NUMBER(1, 0);
ALTER TABLE AD.RECEIVABLE_EXTERNAL ADD FLG_FEE_ROUNDED NUMBER(1, 0);

COMMENT ON COLUMN AD.RECEIVABLE_INTERNAL.FLG_FEE_ROUNDED IS '[NOT_SECURITY_APPLY] Identificador para verificar se já foi realizado o arredondamento da taxa de antecipação';
COMMENT ON COLUMN AD.RECEIVABLE_EXTERNAL.FLG_FEE_ROUNDED IS '[NOT_SECURITY_APPLY] Identificador para verificar se já foi realizado o arredondamento da taxa de antecipação';
