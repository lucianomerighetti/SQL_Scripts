-- rl_dev

CREATE ROLE rl_dev WITH NOINHERIT;

GRANT CONNECT ON DATABASE feedzai TO rl_dev;

GRANT USAGE ON SCHEMA fraud_prevention_adm TO rl_dev;

GRANT SELECT ON TABLE fraud_prevention_adm."FDZ_EVENT_STORAGE_MAPPING" TO rl_dev;

GRANT SELECT ON TABLE fraud_prevention_adm."FDZ_EVENT_STORAGE_SCHEMAS" TO rl_dev;

GRANT USAGE ON SCHEMA pulse_adm TO rl_dev;

ALTER ROLE rl_dev SET statement_timeout TO 30000;

GRANT SELECT ON ALL TABLES IN SCHEMA pulse_adm TO rl_dev;

-- rl_redaction

CREATE ROLE rl_redaction WITH NOINHERIT;

GRANT USAGE ON SCHEMA fraud_prevention_adm TO rl_redaction;

GRANT SELECT ON ALL TABLES IN SCHEMA fraud_prevention_adm TO rl_redaction;

-- rl_critical_access

CREATE ROLE rl_critical_access WITH NOINHERIT;

GRANT CONNECT ON DATABASE feedzai TO rl_critical_access;

GRANT USAGE ON SCHEMA fraud_prevention_adm TO rl_critical_access;

GRANT SELECT ON ALL TABLES IN SCHEMA fraud_prevention_adm TO rl_critical_access;

-- rl_ad

CREATE ROLE rl_ad;

GRANT rl_dev TO rl_ad;

GRANT pg_read_all_settings TO rl_ad;

GRANT pg_read_all_stats TO rl_ad;

GRANT pg_monitor TO rl_ad;

ALTER ROLE rl_ad SET statement_timeout TO 300000;

-- Exemplo AD

CREATE ROLE ameira WITH LOGIN PASSWORD 'XXXXXXXXXXX';
  
GRANT rl_ad TO ameira;


REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA fraud_prevention_adm FROM manut_pulse;
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA fraud_prevention_adm FROM manut_pulse;
REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA fraud_prevention_adm FROM manut_pulse;
REVOKE ALL PRIVILEGES ON SCHEMA fraud_prevention_adm FROM manut_pulse;
REVOKE ALL PRIVILEGES ON TABLESPACE tsdfeedzai_pulse FROM manut_pulse;
REVOKE ALL PRIVILEGES ON TABLESPACE tsifeedzai_pulse FROM manut_pulse;
DROP OWNED BY manut_pulse; -- Remover default privileges
REVOKE ALL ON DATABASE bd_pulse_web FROM manut_pulse;
DROP ROLE manut_pulse;