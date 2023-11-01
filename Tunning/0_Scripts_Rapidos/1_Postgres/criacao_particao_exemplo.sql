CREATE TABLE teste_particao(idt_teste_particao bigserial, dat_teste_particao DATE);
CREATE OR REPLACE FUNCTION create_teste_particao_insert() RETURNS trigger AS
  $BODY$
    DECLARE
      partition_date TEXT;
      partition TEXT;
    BEGIN
      partition_date := to_char(NEW.dat_teste_particao,'YYYY_MM_DD');
      partition := TG_RELNAME || '_' || partition_date;
      IF NOT EXISTS(SELECT relname FROM pg_class WHERE relname=partition) THEN
        RAISE NOTICE 'Particao criada %',partition;
        EXECUTE 'CREATE TABLE ' || partition || ' (check (dat_teste_particao = ''' || NEW.dat_teste_particao || ''')) INHERITS (' || TG_RELNAME || ');';
      END IF;
      EXECUTE 'INSERT INTO ' || partition || ' SELECT(' || TG_RELNAME || ' ' || quote_literal(NEW) || ').* RETURNING idt_teste_particao;';
      RETURN NULL;
    END;
  $BODY$
LANGUAGE plpgsql VOLATILE
COST 100;
CREATE TRIGGER test_partition_insert_trigger
BEFORE INSERT ON teste_particao
FOR EACH ROW EXECUTE PROCEDURE create_teste_particao_insert();
insert into teste_particao (dat_teste_particao)
 select  timestamp '2018-01-01 00:00:00' +
       random() * (timestamp '2018-01-01 00:00:00' -
                   timestamp '2019-12-31 23:59:00')  from generate_series(1,100000) n
                   
SELECT nmsp_parent.nspname AS parent_schema,
       parent.relname AS parent,
       nmsp_child.nspname AS child_schema,
       child.relname AS child
FROM pg_inherits
JOIN pg_class parent ON pg_inherits.inhparent = parent.oid
JOIN pg_class child ON pg_inherits.inhrelid = child.oid
JOIN pg_namespace nmsp_parent ON nmsp_parent.oid = parent.relnamespace
JOIN pg_namespace nmsp_child ON nmsp_child.oid = child.relnamespace
WHERE parent.relname='teste_particao' ;
