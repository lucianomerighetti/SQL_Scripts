CREATE BIGFILE TABLESPACE TSLOBSETTLEMENTCONTRACT01 DATAFILE SIZE 500M AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED BLOCKSIZE 32K;

ALTER USER SETTLEMENTCONTRACTUBR QUOTA UNLIMITED ON TSLOBSETTLEMENTCONTRACT01;