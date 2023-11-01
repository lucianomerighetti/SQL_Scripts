--Prompt => sqlplus AD/rec1adqa@bd-receivables-qa.cugpk8fsjek9.us-east-1.rds.amazonaws.com:1521/REC
-- @C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\carga_contract_manager_ad.sql

@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_0__DROP_TRUNCATE.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_1__CREATE_TABLE_CONTRACT_CUSTOMER.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_2__CREATE_TABLE_CUSTOMER_PLAN.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_3__ALTER_TABLE_CUSTOMER_PLAN_INCLUDE_ACTIVE.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_4__ALTER_TABLE_CUSTOMER_PLAN_ALTER_COLUMN_STATUS.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_5__ALTER_TABLE_CUSTOMER_PLAN_RENAME_COLUMN_PAYMENT_PROCESSOR.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_6__CREATE_INDEX_TABLE_CUSTOMER_PLAN.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_7__REMOVE_CUSTOMER_PLAN_COD_CONTRACT_FK.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_8__CREATE_UNIQUE_CONSTRAINT_CUSTOMER_PLAN.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_9__CREATE_TABLE_PAYMENT_GROUP.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_10__CREATE_TABLE_CONTRACT_CUSTOMER_LEGACY.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_11__CREATE_TABLE_CUSTOMER_REPLICATION.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_12__ALTER_TABLE_CUSTOMER_REPLICATION.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_13__CREATE_TABLE_CUSTOMER_ESCROW.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_14__ALTER_TABLE_CONTRACT_CUSTOMER_LEGACY.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_15__CREATE_TABLE_CUSTOMER.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_16__CREATE_TABLE_CERC_AP007.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_17__ALTER_INITRANS_TABLES_INDEXES.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_97__ALTER_TABLES_FKS_DISABLE.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_98__INSERT_TABLES_AD.sql
@C:\Sammy\queries\0_Times\1_Genebra\Contract_Manager\db-migration-ad\V1_99__ALTER_TABLES_FKS_ENABLE.sql