set echo on
set serveroutput on

declare

  v_owner varchar(100) := 'AD';

  cursor c_tables is
  
    SELECT T.OWNER
          ,T.TABLE_NAME
          ,T.PARTITIONED
    FROM ALL_TABLES T
    INNER JOIN (-- Tabelas do owner a ser limpo, seguindo a ordem das FKs
     SELECT 1 AS RANK,''||v_owner||'' AS OWNER,'REC_ANTICIPATION_INTENT' AS TABLE_NAME FROM DUAL UNION ALL
     SELECT 2,''||v_owner||'','RECEIVABLE_ANTICIPATION' FROM DUAL UNION ALL
     SELECT 3,''||v_owner||'','RECOVERY' FROM DUAL UNION ALL
     SELECT 4,''||v_owner||'','CASHOUT' FROM DUAL UNION ALL
     SELECT 5,''||v_owner||'','CCE_RECEIVABLE_INTERNAL' FROM DUAL UNION ALL
     SELECT 6,''||v_owner||'','CCE_RECEIVABLE_EXTERNAL' FROM DUAL UNION ALL
     SELECT 7,''||v_owner||'','SETTLEMENT_CONTRACTUAL_EFFECT' FROM DUAL UNION ALL
     SELECT 8,''||v_owner||'','SETTLEMENT' FROM DUAL UNION ALL
     SELECT 9,''||v_owner||'','CCE_STATIC_AMOUNT_SUMMARY' FROM DUAL UNION ALL
     SELECT 10,''||v_owner||'','CONTRACTUAL_EFFECT' FROM DUAL UNION ALL
     SELECT 11,''||v_owner||'','PAYMENT_ADDRESS' FROM DUAL UNION ALL
     SELECT 12,''||v_owner||'','RECEIVABLE_INTERNAL' FROM DUAL UNION ALL
     SELECT 13,''||v_owner||'','RECEIVABLE_EXTERNAL' FROM DUAL UNION ALL
     SELECT 14,''||v_owner||'','RECEIVABLE_UNIT_OUTBOX' FROM DUAL UNION ALL
     SELECT 15,''||v_owner||'','RECEIVABLE_UNIT_ASSOCIATION' FROM DUAL UNION ALL
     SELECT 16,''||v_owner||'','RECEIVABLE_UNIT_INTERNAL' FROM DUAL UNION ALL
     SELECT 17,''||v_owner||'','RECEIVABLE_UNIT_EXTERNAL' FROM DUAL UNION ALL
     SELECT 18,''||v_owner||'','SUSPENSION_OUTBOX' FROM DUAL UNION ALL
     SELECT 19,''||v_owner||'','SUSPENSION_HISTORY' FROM DUAL UNION ALL
     SELECT 20,''||v_owner||'','SUSPENSION' FROM DUAL UNION ALL
     SELECT 21,''||v_owner||'','PAYMENT' FROM DUAL UNION ALL	 
     SELECT 22,''||v_owner||'','LEGACY' FROM DUAL UNION ALL
     SELECT 23,''||v_owner||'','INSTALLMENT' FROM DUAL UNION ALL
     SELECT 24,''||v_owner||'','PAYMENT_SUSPENSION' FROM DUAL UNION ALL
     SELECT 25,''||v_owner||'','RECEIVABLE_INTENT' FROM DUAL UNION ALL
     SELECT 26,''||v_owner||'','CCE_REASSOCIATE_CONTROL' FROM DUAL
     ) OT
ON OT.OWNER = T.OWNER
AND OT.TABLE_NAME = T.TABLE_NAME
    WHERE T.OWNER = v_owner
    ORDER BY OT.RANK;
	
  cursor c_part (p_owner varchar, p_table_name varchar) is	
  
	SELECT TP.TABLE_OWNER
		  ,TP.TABLE_NAME
		  ,TP.PARTITION_NAME
		  ,TP.NUM_ROWS
	FROM DBA_TAB_PARTITIONS TP
	WHERE TP.TABLE_OWNER = p_owner
	AND TP.TABLE_NAME = p_table_name;
	
  cursor c_ind_part (p_owner varchar, p_table_name varchar ,p_part_name varchar) is	
    SELECT IP.INDEX_OWNER
          ,IP.INDEX_NAME
          ,IP.PARTITION_NAME
    FROM DBA_TAB_PARTITIONS TP
    INNER JOIN DBA_IND_PARTITIONS IP
	ON  TP.TABLE_OWNER = IP.INDEX_OWNER
    AND TP.PARTITION_NAME = IP.PARTITION_NAME
    WHERE IP.INDEX_OWNER = p_owner
    AND TP.TABLE_NAME = p_table_name
    AND TP.PARTITION_NAME = p_part_name
    AND IP.INDEX_NAME LIKE '%''||p_table_name||''%';

  cursor c_ind_no_part (p_owner varchar, p_table_name varchar) is
  
    SELECT I.OWNER
          ,I.TABLE_NAME
          ,I.INDEX_NAME
    FROM ALL_INDEXES I
    WHERE OWNER = p_owner
	AND I.TABLE_NAME = p_table_name
	AND I.PARTITIONED = 'NO';
	
  cursor c_constr_part (p_owner varchar, p_table_name varchar) is
    SELECT ACF.OWNER
    ,ACF.CONSTRAINT_NAME
    ,ACF.TABLE_NAME
    FROM ALL_CONSTRAINTS ACF
    INNER JOIN ALL_CONSTRAINTS ACP
    ON ACF.OWNER = ACP.OWNER
    AND ACF.R_CONSTRAINT_NAME = ACP.CONSTRAINT_NAME
    WHERE ACF.OWNER = p_owner
    AND ACF.CONSTRAINT_TYPE = 'R'
    AND ACF.STATUS = 'ENABLED'
    AND ACP.TABLE_NAME = p_table_name;
	
 
begin 

  for r1 in c_tables loop
  
    -- se a tabela for particionada, verifica se tem particoes vazias, se tiver, exclui, se não, recria os indices locais e por fim recria os indices globais
	
	if r1.PARTITIONED = 'YES' then
	
	  -- desabilita as constraints das tabelas 
		
	  for r3 in c_constr_part (r1.OWNER, r1.TABLE_NAME) loop
		
		dbms_output.put_line( 'ALTER TABLE '||r3.OWNER||'.'||r3.TABLE_NAME||' DISABLE CONSTRAINT ' || r3.CONSTRAINT_NAME||';');
		
  	  end loop;

  	  for r2 in c_part (r1.OWNER, r1.TABLE_NAME) loop
	  
	    if r2.PARTITION_NAME = 'P_1' then
		
		  dbms_output.put_line( 'ALTER TABLE '||r2.TABLE_OWNER||'.'||r2.TABLE_NAME||' TRUNCATE PARTITION '||r2.PARTITION_NAME||';');

 	      for r4 in c_ind_part (r2.TABLE_OWNER, r2.TABLE_NAME, r2.PARTITION_NAME) loop
		  
	       dbms_output.put_line( 'ALTER INDEX '||r4.INDEX_OWNER||'.'||r4.INDEX_NAME||' REBUILD PARTITION '|| r2.PARTITION_NAME ||';');	  
		  
          end loop;		
		  
		else  
	  
          dbms_output.put_line( 'ALTER TABLE '||r2.TABLE_OWNER||'.'||r2.TABLE_NAME||' DROP PARTITION '||r2.PARTITION_NAME||';');
		    
		end if;  

	  end loop;
	  
      -- habilita as constraints das tabelas 
		
	  for r3 in c_constr_part (r1.OWNER, r1.TABLE_NAME) loop
	
	    dbms_output.put_line( 'ALTER TABLE '||r3.OWNER||'.'||r3.TABLE_NAME||' ENABLE CONSTRAINT ' || r3.CONSTRAINT_NAME||';');
		
	  end loop;
	  
	  -- recriacao do indice global em tabela particionada (eh feito nesse ponto pois pode ter havido exclusao de particoes)
	  
      for r5 in c_ind_no_part (r1.OWNER, r1.TABLE_NAME) loop

	    dbms_output.put_line( 'ALTER INDEX '||r5.OWNER||'.'||r5.INDEX_NAME||' REBUILD ONLINE PARALLEL 60;');	  
	  
	  	dbms_output.put_line( 'ALTER INDEX '||r5.OWNER||'.'||r5.INDEX_NAME||' NOPARALLEL;');
	  
      end loop;	  

	else

	 dbms_output.put_line( 'TRUNCATE TABLE '|| r1.OWNER ||'.'|| r1.TABLE_NAME ||';');
		
	  for r6 in c_ind_no_part (r1.OWNER, r1.TABLE_NAME) loop

	    dbms_output.put_line( 'ALTER INDEX '||r6.OWNER||'.'||r6.INDEX_NAME||' REBUILD ONLINE PARALLEL 60;');	  
	  
	  	dbms_output.put_line( 'ALTER INDEX '||r6.OWNER||'.'||r6.INDEX_NAME||' NOPARALLEL;');
	  
      end loop;	  
	
	end if;  
	
    -- coleta as estatisticas de todas as tabelas  
  
    dbms_output.put_line ('BEGIN DBMS_STATS.GATHER_TABLE_STATS ( ownname => '''|| r1.OWNER ||''', tabname => '''|| r1.TABLE_NAME ||''', cascade => true, degree  => 16); END;'||CHR(10)||'/'||CHR(10));
  
  end loop;
	
end;
/
