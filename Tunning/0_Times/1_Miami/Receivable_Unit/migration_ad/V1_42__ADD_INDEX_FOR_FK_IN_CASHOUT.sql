-- Adiciona índice para IDT_CONTRACTUAL_EFFECT do CASHOUT
--  A FK foi criada mas não foi criado um índice para esta FK.

CREATE INDEX AD.CASHOUT_IDX02 
    ON AD.CASHOUT ( IDT_CONTRACTUAL_EFFECT ) INITRANS 12 TABLESPACE TSIRECEIVABLES01 ONLINE;
