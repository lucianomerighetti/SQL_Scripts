DROP INDEX RECEIVABLES_ADM.RECEIVABLE_INTENT_IDX01;

ALTER TABLE RECEIVABLES_ADM.RECEIVABLE_INTENT MODIFY
PARTITION BY
RANGE(DAT_CREATION)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P1 VALUES LESS THAN (TO_DATE('2020-01-10' ,'YYYY-MM-DD'))
)
ONLINE;

DROP INDEX RECEIVABLES_ADM.PAYMENT_IDX04;

ALTER TABLE RECEIVABLES_ADM.PAYMENT MODIFY
PARTITION BY
RANGE(DAT_CREATION)
INTERVAL (NUMTODSINTERVAL(1,'DAY'))
(PARTITION P1 VALUES LESS THAN (TO_DATE('2020-01-10' ,'YYYY-MM-DD'))
)
ONLINE;

