OPTIONS (SILENT=ALL, DIRECT=TRUE, ERRORS=999999999,PARALLEL=TRUE)
UNRECOVERABLE LOAD DATA 
INFILE 'D:\Users\smoreira\diff_20221109.csv'
APPEND
INTO table SMOREIRA.DIFF_OUTBOX_20221106
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
COD_OUTBOX_EVENT
) 