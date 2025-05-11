select distinct
       ccf.constraint_name name,
       cfk.constraint_type type,
       cfk.status          status_fk,
       cpk.status          status_pk,
       -----
       cfk.owner           owner_fk,
       cfk.table_name      table_name_fk,
       ccf.column_name     column_fk,
       -----
       cpk.owner           owner_pk,
       cpk.table_name      table_name_pk,
       ccp.column_name     column_pk
       -----
  from sys.all_constraints  cfk,
       sys.all_cons_columns ccf,
       sys.all_constraints  cpk,
       sys.all_cons_columns ccp
 where ccp.position          = ccf.position
   and ccp.owner             = cpk.owner
   and ccp.constraint_name   = cpk.constraint_name
   and ccp.table_name        = cpk.table_name
   and cpk.constraint_name   = cfk.r_constraint_name
   and ccf.constraint_name   = cfk.constraint_name
   and ccf.table_name        = cfk.table_name
   and ccf.owner             = cfk.owner
   and cfk.constraint_type   = 'R'
   and cfk.owner             = cpk.owner
   and cpk.owner             = upper('&Owner')
   and (cfk.table_name       = upper('&Tabela') or
        cpk.table_name       = upper('&Tabela'))
 order by cpk.owner,
          cpk.table_name,
          --ccf.constraint_name,
          --cfk.constraint_type,
          cfk.owner,
          cfk.table_name;
