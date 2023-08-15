select x.owner,
       x.table_name,
       ---------------------
       --x.object_type,
       --x.partition_name,
       --x.partition_position,
       ---------------------
       nvl(x.qtd_linhas, 0)             qtd_linhas,
       nvl(x.qtd_ins_pos_coleta, 0)     qtd_ins_pos_coleta,
       nvl(x.qtd_upd_pos_coleta, 0)     qtd_upd_pos_coleta,
       nvl(x.qtd_del_pos_coleta, 0)     qtd_del_pos_coleta,
       nvl(x.qtd_segmentos_apagados, 0) qtd_segmentos_apagados,
       nvl(x.qtd_total_dml, 0)          qtd_total_dml,
       nvl(x.stale_percent_real, 0)     stale_percent_real,
       x.stale_percent_target,
       x.coleta_desatualizada,
       x.ultima_coleta
  from (
        select s.owner,
               s.table_name,
               ---------------------
               --s.object_type,
               --s.partition_name,
               --s.partition_position 
               ---------------------
               s.num_rows                                                  qtd_linhas,
               nvl(tm.qtd_ins_pos_coleta, 0)                               qtd_ins_pos_coleta,
               nvl(tm.qtd_upd_pos_coleta, 0)                               qtd_upd_pos_coleta,
               nvl(tm.qtd_del_pos_coleta, 0)                               qtd_del_pos_coleta,
               nvl(tm.qtd_segmentos_apagados, 0)                           qtd_segmentos_apagados,
               nvl(tm.total_dml, 0)                                        qtd_total_dml,
               round((((tm.total_dml * 100) / nvl(s.num_rows, 1))), 2)     stale_percent_real,
               dbms_stats.get_prefs('STALE_PERCENT',s.owner, '"' || s.table_name ||'"') stale_percent_target,
               s.stale_stats                                               coleta_desatualizada,
               to_char(s.last_analyzed, 'YYYY-MM-DD HH24:MI:SS')           ultima_coleta
          from dba_tab_statistics s
               left  join (
                           select m.table_owner,
                                  m.table_name,
                                  sum(nvl(m.inserts, 0))                         qtd_ins_pos_coleta,
                                  sum(nvl(m.updates, 0))                         qtd_upd_pos_coleta,
                                  sum(nvl(m.deletes, 0))                         qtd_del_pos_coleta,
                                  sum(nvl(m.drop_segments, 0))                   qtd_segmentos_apagados,
                                  sum(nvl(m.inserts + m.updates + m.deletes, 0)) total_dml
                             from dba_tab_modifications m
                            where m.table_owner = substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM'
                            group by m.table_owner,
                                     m.table_name
                          ) tm on (s.owner      = tm.table_owner and
                                   s.table_name = tm.table_name)
         where s.owner = substr(sys_context('USERENV', 'DB_NAME'), 4, 50) || '_ADM'
           and s.object_type = 'TABLE'
           and s.global_stats = 'YES'
           ---------------------
           --and s.last_analyzed is not null 
           ---------------------
       ) x
 order by 9 desc,
          x.ultima_coleta desc,
          x.coleta_desatualizada desc