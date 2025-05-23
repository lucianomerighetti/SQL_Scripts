-- Unable to render TABLE DDL for object SAFEPAY_ADM.PERCENTUAL_RECOVERY with DBMS_METADATA attempting internal generator.
CREATE INDEX SAFEPAY_ADM.PERCENTUAL_RECOVERY_IDX01 ON SAFEPAY_ADM.PERCENTUAL_RECOVERY (IDT_FINANCIAL_ACCOUNT_DEST ASC) 
LOGGING 
TABLESPACE TSISAFEPAY06 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 1048576 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL
CREATE INDEX SAFEPAY_ADM.PERCENTUAL_RECOVERY_IDX02 ON SAFEPAY_ADM.PERCENTUAL_RECOVERY (COD_REFERENCE ASC) 
LOGGING 
TABLESPACE TSISAFEPAY06 
PCTFREE 10 
INITRANS 8 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL
CREATE INDEX SAFEPAY_ADM.PERCENTUAL_RECOVERY_IDX03 ON SAFEPAY_ADM.PERCENTUAL_RECOVERY (COD_DEBT_SCHEDULE ASC) 
LOGGING 
TABLESPACE TSISAFEPAY06 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL
CREATE UNIQUE INDEX SAFEPAY_ADM.PERCRECOVERY_PK ON SAFEPAY_ADM.PERCENTUAL_RECOVERY (IDT_PERCENTUAL_RECOVERY ASC) 
LOGGING 
TABLESPACE TSISAFEPAY06 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 1048576 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLELCREATE TABLE SAFEPAY_ADM.PERCENTUAL_RECOVERY 
(
  IDT_PERCENTUAL_RECOVERY NUMBER(9, 0) NOT NULL 
, DAT_START_RECOVERY DATE NOT NULL 
, DAT_END_RECOVERY DATE NOT NULL 
, NUM_PERCENTAGE NUMBER(9, 0) NOT NULL 
, NUM_TOTAL_AMOUNT NUMBER(10, 2) NOT NULL 
, NUM_RECOVERED_AMOUNT NUMBER(10, 2) NOT NULL 
, DES_RECOVERY VARCHAR2(255 BYTE) NOT NULL 
, IDT_FINANCIAL_ACCOUNT_DEST NUMBER(10, 0) NOT NULL 
, IND_STATUS CHAR(1 BYTE) NOT NULL 
, DAT_CREATION TIMESTAMP(6) DEFAULT SYSTIMESTAMP NOT NULL 
, DAT_UPDATE TIMESTAMP(6) DEFAULT SYSTIMESTAMP NOT NULL 
, IDT_USER_DEST NUMBER(20, 0) 
, IDT_TRANSACTION NUMBER(20, 0) 
, IDT_TRANSACTION_STATUS_HISTORY NUMBER(20, 0) 
, COD_TRANSACTION VARCHAR2(32 BYTE) 
, IDT_TURNOVER_TAG NUMBER(10, 0) 
, COD_REFERENCE VARCHAR2(36 BYTE) 
, IND_REASON CHAR(1 BYTE) 
, COD_DEBT_SCHEDULE VARCHAR2(36 BYTE) 
, COD_CUSTOMER_DESTINATION VARCHAR2(36 BYTE) 
, COD_BALLAST VARCHAR2(36 BYTE) 
, DES_BALLAST VARCHAR2(20 BYTE) 
, IND_RECOVERY_TYPE NUMBER(10, 0) DEFAULT 1 NOT NULL 
) 
LOGGING 
TABLESPACE TSDSAFEPAY01 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 1048576 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  PCTINCREASE 0 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
NOPARALLELALTER TABLE SAFEPAY_ADM.PERCENTUAL_RECOVERY
ADD CONSTRAINT PERREC_IND_REA_CK CHECK 
(IND_REASON IN ('C','R'))
ENABLE
ALTER TABLE SAFEPAY_ADM.PERCENTUAL_RECOVERY
ADD CONSTRAINT PER_REC_IND_REC_TYPE_CK CHECK 
(IND_RECOVERY_TYPE IN (1,2))
ENABLECOMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IDT_PERCENTUAL_RECOVERY IS 'ID incremental gerada pelo BD';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.DAT_START_RECOVERY IS 'Data inicial do contrato da recuperação de credito';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.DAT_END_RECOVERY IS 'Data final do contrato da recuperação de credito';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.NUM_PERCENTAGE IS 'O valor da porcentagem cobrada sobre a recuperação de credito';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.NUM_TOTAL_AMOUNT IS 'Valor total a ser recuperado';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.NUM_RECOVERED_AMOUNT IS 'Valor parcial recuperado';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.DES_RECOVERY IS 'Descricao recuperação do emprestimo que vai no extrato do cliente.';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IDT_FINANCIAL_ACCOUNT_DEST IS 'Conta destino: onde sera depositado o valor recuperado';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IND_STATUS IS 'Possíveis status da recuperacao de credito*: C (Concluido), N (NAO CONCLUIDO), P (PARCIALMENTE CONCLUIDO)*';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.DAT_CREATION IS 'Data de gravação do registro';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.DAT_UPDATE IS 'Data da última atualização do registro';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IDT_USER_DEST IS 'Id do usuário do PagSeguro para o qual deve ser enviado o valor recuperado na liberação do pagamento.';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IDT_TRANSACTION IS 'ID da transação de origem do saldo a recuperar';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IDT_TRANSACTION_STATUS_HISTORY IS 'PK da tabela TRANSACTION_STATUS_HISTORY.';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.COD_TRANSACTION IS 'Codigo da transação da tabela Transaction.';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IDT_TURNOVER_TAG IS 'PK da tabela FINANCIAL_TURNOVER_TAG_DESC.';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.COD_REFERENCE IS 'Codigo de referencia do recuperacao, pode ser utilizado para acompanhamento da recuperacao';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IND_REASON IS 'Razao da criacao do recuperacao';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.COD_DEBT_SCHEDULE IS 'Código gerado no cadastro do recuperacao';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.COD_CUSTOMER_DESTINATION IS 'custormer_cod para qual sera feito a recuperacao';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.COD_BALLAST IS 'Código de identificacao da aplicacao requerente';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.DES_BALLAST IS 'Tipo de criacao da recuperacao';
COMMENT ON COLUMN SAFEPAY_ADM.PERCENTUAL_RECOVERY.IND_RECOVERY_TYPE IS 'Tipo de bloqueio de débito: 1 - ACQUIRER / 2 - LOAN';COMMENT ON TABLE SAFEPAY_ADM.PERCENTUAL_RECOVERY IS 'Registros sobre as informacoes da nova forma de recuperação de crédito'ALTER TABLE SAFEPAY_ADM.PERCENTUAL_RECOVERY
ADD CONSTRAINT PERCRECOVERY_PK PRIMARY KEY 
(
  IDT_PERCENTUAL_RECOVERY 
)
USING INDEX PERCRECOVERY_PK
ENABLE
