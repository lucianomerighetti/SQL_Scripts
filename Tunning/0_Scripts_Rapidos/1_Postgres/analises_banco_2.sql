############### Verificar as constraints ############### 
SELECT con.*
       FROM pg_catalog.pg_constraint con
            INNER JOIN pg_catalog.pg_class rel
                       ON rel.oid = con.conrelid
            INNER JOIN pg_catalog.pg_namespace nsp
                       ON nsp.oid = connamespace
       WHERE nsp.nspname = 'public'
             AND rel.relname = 'evaluation';
​
​
​
​
###############  Criar usuário nominal ############### 
\c custassociation
​
--conectar com dba
create user s2it_jduque with password 'xxxxxxxx';
​
GRANT CONNECT ON DATABASE custassociation TO s2it_jduque;
​
GRANT USAGE ON SCHEMA custassocition_adm TO s2it_jduque;
​
GRANT PG_READ_ALL_STATS TO s2it_jduque;
​
GRANT PG_READ_ALL_SETTINGS TO s2it_jduque;
​
--conectar com usuario adm
GRANT SELECT ON ALL TABLES IN SCHEMA custassociation TO s2it_jduque;
​
--"ALTER DEFAULT privileges IN SCHEMA cashoutstrategy_adm GRANT SELECT ON TABLES TO s2it_jduque; ---> só funciona para tabelas novas
​
​
############### Verificar os grants ###############
select grantee, table_schema, table_name, privilege_type
from information_schema.role_table_grants
where table_schema  = 'assetbasedloaner_adm';
​
​
​
​
############### Alterar a senha ###############
ALTER USER s2it_jduque PASSWORD 'xxxxxxxxxxxxxx';
​
​
​
​
############### Verificar as conexões ativas ###############
select * from pg_stat_activity;
SELECT pid, wait_event_type, wait_event FROM pg_stat_activity WHERE wait_event is NOT NULL;
​
​
​
​
############### Alter tamanho de coluna ###############
ALTER TABLE evaluation ALTER COLUMN cod_evaluation TYPE varchar(32) USING cod_evaluation::varchar;
​
​
​
​
############### Alter tamanho tipo de coluna ###############
ALTER TABLE CIP_ADM.LIQUIDATION ALTER COLUMN COD_CUSTOMER TYPE uuid USING cod_customer::uuid;
​
​
​
​
############### Adicionar novas colunas ###############
ALTER TABLE CIP_ADM.LIQUIDATION
ADD COLUMN COD_CUSTOMER VARCHAR(36) NULL,
ADD COLUMN COD_PAYMENT_GROUP VARCHAR(36) NULL,
ADD COLUMN COD_SOURCE_ACCOUNT_TYPE INT NULL;
​
​
​
############### Criar indice  ###############
CREATE INDEX ciplqidation_idx01 ON cip_adm.liquidation USING btree (idt_safepay_user);
​
​
​
############### Verificar se o pgcrypto está ativo ###############
select * from pg_catalog.pg_extension (extrelocatable)
​
​
​
############### Ativar a função pgcrypto ###############
create extension pgcrypto;
​
​
​
​
############### Selects da função pgcrypto ###############
select nome, encrypt(nome::bytea, 'xpto', 'aes') c, decrypt(encrypt(nome::bytea, 'xpto', 'aes'), 'xpto', 'aes') d from cliente
select nome, encrypt(nome::bytea, 'xpto', 'aes') c, encode(decrypt(encrypt(nome::bytea, 'xpto', 'aes'), 'xpto', 'aes'), 'escape') d from cliente
select nome, encrypt(nome::bytea, 'xpto', 'aes') c, convert_from (encode(decrypt(encrypt(nome::bytea, 'xpto', 'aes'), 'xpto', 'aes'), 'escape') ::bytea, 'UTF-8') d from cliente
​
update cliente set documento_new = encrypt(documento::bytea, 'xpto', 'aes');
update cliente set nome_new = encrypt(nome::bytea, 'xpto', 'aes');
​
select * from information_schema.columns where table_name = 'cliente';
select convert_from (encode(decrypt(nome::bytea, 'xpto', 'aes'), 'escape') ::bytea, 'UTF-8') from cliente;
select convert_from (encode(decrypt(documento::bytea, 'xpto', 'aes'), 'escape') ::bytea, 'UTF-8') from cliente;
​
​
​
​
############### Verificar os usuários ###############
SELECT u.usename AS "Role name",
  CASE WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create
database' AS pg_catalog.text)
       WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
       WHEN u.usecreatedb THEN CAST('create database' AS
pg_catalog.text)
       ELSE CAST('' AS pg_catalog.text)
  END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;
​
​
​
############### Verificar os índices ###############
SELECT 
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'cliente'
ORDER BY
    tablename,
    indexname;
​
​
​
############### Dropar coluna ###############
alter table cliente drop column documento_old;
​
​
​
​
############### Renomear coluna ###############
alter table cliente rename column documento_new to documento;
​
​
​
​
############### Verificar as colunas ###############
select * from information_schema.columns where table_name = 'cliente';
​
​
​
​
############### Inserir dados ###############
insert into evaluation values ('666',1,'y','w', 2, 3, now(),now(),'aa', 'qqq', '666', now(), now(), 2);
​
​
​
​
############### Verificar tamanho da tabela em bytes ###############
select pg_relation_size('cip_batch');
​
​
​
​
############### Verificar tamanho da tabela humanalmente visível ###############
SELECT pg_size_pretty (pg_relation_size('cip_batch'));
​
​
​
​
############### Verificar as 5 maiores tabelas ###############
SELECT
    relname AS "relation",
    pg_size_pretty (
        pg_total_relation_size (C .oid)
    ) AS "total_size"
FROM
    pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C .relnamespace)
WHERE
    nspname NOT IN (
        'pg_catalog',
        'information_schema'
    )
AND C .relkind <> 'i'
AND nspname !~ '^pg_toast'
ORDER BY
    pg_total_relation_size (C .oid) DESC
LIMIT 5;
​
​
​
​
############### Verificar o tamanho da base  ###############
SELECT
    pg_size_pretty (
        pg_database_size ('cip')
    );
​
​
​
​
############### Verificar o tamanho de todas as bases ###############
SELECT
    pg_database.datname,
    pg_size_pretty(pg_database_size(pg_database.datname)) AS size
    FROM pg_database;
​
​
​
​
​
############### Verificar o tamanho do índice ##############
SELECT
    pg_size_pretty (pg_indexes_size('batch_file_liquidation_idx1'));
​
​
​
​
############## Verificar o tamanho da tablespace ##############
SELECT
    pg_size_pretty (
        pg_tablespace_size ('tsdcip01')
    );
​
​
​
​
############### Verifica o qual é o tamanho que precisa armazenar para cada tipo de dado ###############
select pg_column_size(5::smallint);
select pg_column_size(5::int);
select pg_column_size(5::bigint);
​
​
​
​
############### Verificar as estatítiscas de I/O das tabelas ###############
select * from pg_statio_all_tables;
​
​
​
​
############### Verificar a estatítisca das tabelas ###############
select * from pg_stat_all_tables;
select * from pg_stat_sys_tables;
select * from pg_stat_user_tables;
​
​
​
​
############### Verificar a estatísica dos índices ###############
select * from pg_stat_all_indexes;
select * from pg_stat_sys_indexes;
select * from pg_stat_user_indexes;
​
​
​
​
############### Verificar a estatístca das sequences ###############
select * from pg_statio_all_sequences;
select * from pg_statio_sys_sequences;
select * from pg_statio_user_sequences;
​
​
​
​
############### Verificar o status da replicação (slave) ###############
select * from pg_stat_replication;
