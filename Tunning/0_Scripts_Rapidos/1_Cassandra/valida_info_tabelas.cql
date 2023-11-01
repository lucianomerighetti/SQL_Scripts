-- verificar informacoes da tabela

select table_name
,default_time_to_live -- TTL em segundos -> tempo que levará para os registros irem para a lixeira, se estiver zero, é que não tem TTL definido, o registro nunca será apagado
,gc_grace_seconds --> tempo que levará para o registro sair da lixeira 
from system_schema.tables
where keyspace_name = <owner>;