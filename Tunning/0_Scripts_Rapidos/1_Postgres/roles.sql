-- ######## QA ########

DROP ROLE IF EXISTS rl_ad;
CREATE ROLE rl_ad WITH NOINHERIT SUPERUSER CONNECTION LIMIT 4;
ALTER ROLE rl_ad SET statement_timeout TO 1800000;
ALTER ROLE rl_ad SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_ad SET search_path TO bd_adm;

GRANT pg_read_all_settings TO rl_ad;
GRANT pg_read_all_stats TO rl_ad;
GRANT pg_monitor TO rl_ad;

GRANT CONNECT ON DATABASE bd TO rl_ad;
GRANT CREATE, USAGE ON SCHEMA bd_adm TO rl_ad;
GRANT SELECT, INSERT, DELETE, UPDATE, TRUNCATE, REFERENCES ON ALL TABLES IN SCHEMA bd_adm TO rl_ad;
GRANT ALL PRIVILEGES ON TABLESPACE tsdbd01 TO rl_ad;
GRANT ALL PRIVILEGES ON TABLESPACE tsibd01 TO rl_ad;

ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT, INSERT, DELETE,UPDATE,TRUNCATE,REFERENCES ON TABLES TO rl_ad;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT,USAGE ON SEQUENCES TO rl_ad;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT EXECUTE ON FUNCTIONS TO rl_ad;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT,USAGE ON TYPES TO rl_ad;

GRANT rl_ad TO ad;

-- ######## PROD ########

-- rl_ad

DROP ROLE IF EXISTS rl_ad;
CREATE ROLE rl_ad WITH NOINHERIT SUPERUSER CONNECTION LIMIT 4;
ALTER ROLE rl_ad SET statement_timeout TO 1800000;
ALTER ROLE rl_ad SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_ad SET search_path TO bd_adm;

GRANT pg_read_all_settings TO rl_ad;
GRANT pg_read_all_stats TO rl_ad;
GRANT pg_monitor TO rl_ad;

GRANT CONNECT ON DATABASE bd TO rl_ad;
GRANT USAGE ON SCHEMA bd_adm TO rl_ad;
GRANT SELECT ON ALL TABLES IN SCHEMA bd_adm TO rl_ad;

ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT ON TABLES TO rl_ad;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT,USAGE ON SEQUENCES TO rl_ad;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT EXECUTE ON FUNCTIONS TO rl_ad;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT,USAGE ON TYPES TO rl_ad;

CREATE ROLE <user> WITH LOGIN PASSWORD 'XXXXXXXXXXX';
  
GRANT rl_ad TO <user>;

-- rl_dev

ALTER ROLE rl_dev CONNECTION LIMIT 2;
ALTER ROLE rl_dev SET statement_timeout TO 1800000;
ALTER ROLE rl_dev SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_dev SET search_path TO bd_adm;

GRANT SELECT ON ALL TABLES IN SCHEMA bd_adm TO rl_dev;

ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT ON TABLES TO rl_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm GRANT SELECT,USAGE ON SEQUENCES TO rl_dev;

DROP ROLE IF EXISTS rl_dev_recebiveis;

CREATE ROLE <user> WITH LOGIN PASSWORD 'XXXXXXXXXXX';
  
GRANT rl_dev TO <user>;

-- Roles de compliance

ALTER ROLE redash_nsa_ubr SET statement_timeout TO 1800000;
ALTER ROLE redash_bs_ubr SET statement_timeout TO 1800000;
ALTER ROLE redash_nsapii_ubr SET statement_timeout TO 1800000;
ALTER ROLE redash_pci_ubr SET statement_timeout TO 1800000;
ALTER ROLE redash_pii_ubr SET statement_timeout TO 1800000;
ALTER ROLE redash_sf_ubr SET statement_timeout TO 1800000;
ALTER ROLE redash_so_ubr SET statement_timeout TO 1800000;
ALTER ROLE rl_compliance_bs SET statement_timeout TO 1800000;
ALTER ROLE rl_compliance_nsa SET statement_timeout TO 1800000;
ALTER ROLE rl_compliance_pci SET statement_timeout TO 1800000;
ALTER ROLE rl_compliance_pii SET statement_timeout TO 1800000;
ALTER ROLE rl_compliance_sf SET statement_timeout TO 1800000;
ALTER ROLE rl_compliance_so SET statement_timeout TO 1800000;

ALTER ROLE redash_nsa_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE redash_bs_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE redash_nsapii_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE redash_pci_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE redash_pii_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE redash_sf_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE redash_so_ubr SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_compliance_bs SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_compliance_nsa SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_compliance_pci SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_compliance_pii SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_compliance_sf SET idle_in_transaction_session_timeout TO 1800000;
ALTER ROLE rl_compliance_so SET idle_in_transaction_session_timeout TO 1800000;

--######## REVOKE ########

REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA bd_adm FROM <user>;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA bd_adm FROM <user>;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA bd_adm FROM <user>;
REVOKE ALL PRIVILEGES ON SCHEMA bd_adm FROM <user>;
REVOKE ALL PRIVILEGES ON TABLESPACE tsdbd01 FROM <user>;
REVOKE ALL PRIVILEGES ON TABLESPACE tsibd01 FROM <user>;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm REVOKE ALL ON SEQUENCES FROM <user>;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm REVOKE ALL ON TABLES FROM <user>;
ALTER DEFAULT PRIVILEGES IN SCHEMA bd_adm REVOKE ALL ON FUNCTIONS FROM <user>;
REVOKE USAGE ON SCHEMA bd_adm FROM  <user>;
ALTER DEFAULT PRIVILEGES FOR ROLE bd_adm IN SCHEMA bd_adm revoke all privileges on tables from <user>;
ALTER DEFAULT PRIVILEGES FOR ROLE bd_adm IN SCHEMA bd_adm revoke all privileges on sequences from <user>;
ALTER DEFAULT PRIVILEGES FOR ROLE bd_adm IN SCHEMA bd_adm revoke all privileges on functions from <user>;
REVOKE ALL PRIVILEGES ON database bd FROM <user>;
REVOKE ALL ON DATABASE bd FROM <user>;
DROP OWNED BY <user>; 
DROP USER <user>;
DROP ROLE <user>;
