-- -----------------------------------------------------
-- Table advance_cost_history
-- -----------------------------------------------------
CREATE TABLE AD.ADVANCE_COST_HISTORY (
	IDT_ADVANCE_COST_HISTORY 	 NUMBER(20)  		         NOT NULL,
    IDT_SAFEPAY_USER             NUMBER(20)                 NULL,
    NUM_ADVANCE_COST             NUMBER(10, 2)              NOT NULL,
    NAM_CHANGE_AGENT             VARCHAR(50)                NOT NULL,
    DAT_CREATION                 TIMESTAMP DEFAULT SYSDATE  NOT NULL,
    DAT_START                    TIMESTAMP                  NULL,
    DAT_END                      TIMESTAMP                  NULL,
    CONSTRAINT ADVANCE_COST_HISTORY_PK PRIMARY KEY (IDT_ADVANCE_COST_HISTORY)
        USING INDEX TABLESPACE TSIRECTRANSITORYMOVEMENT01 INITRANS 10
) TABLESPACE TSDRECTRANSITORYMOVEMENT01 INITRANS 10;

COMMENT ON TABLE AD.ADVANCE_COST_HISTORY                             IS 'Tabela com o historico de taxas de antecipação de intermediadores';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.IDT_ADVANCE_COST_HISTORY   IS 'Chave primária da tabela';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.IDT_SAFEPAY_USER           IS 'IDT do usuário';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.NUM_ADVANCE_COST           IS 'Valor da taxa de antecipação';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.NAM_CHANGE_AGENT           IS 'Agente da alteração';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.DAT_CREATION               IS 'Data de criação do registro';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.DAT_START                  IS 'Data de inicio de vigencia da taxa';
COMMENT ON COLUMN AD.ADVANCE_COST_HISTORY.DAT_END                    IS 'Data de fim de vigencia da taxa';

GRANT SELECT,UPDATE,INSERT,DELETE ON AD.ADVANCE_COST_HISTORY TO RECTRANSITORYMOVEMENTUBR;
GRANT SELECT ON AD.ADVANCE_COST_HISTORY TO MANUT_RECTRANSITORYMOVEMENT;