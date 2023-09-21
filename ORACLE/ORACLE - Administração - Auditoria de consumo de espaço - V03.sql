--------------------------------------------------------------------------------
-- Tabelas e Sequencias
--------------------------------------------------------------------------------
create sequence ad.log_seq;

create table ad.log(
  id_log      number(10),
  rotina      varchar2(100),
  usuario     varchar2(30) default user,
  inicio      date default sysdate,
  fim         date,
  constraint  log_pk primary key(id_log)
);

create table ad.log_erros (
  id_log      number(10),
  cod_erro    number(10),
  mensagem     varchar2(64),
  data        timestamp default systimestamp
);

create table ad.log_tablespace (
  nome        varchar2(30),
  maximo      number(8) not null,
  alocado     number(8) not null,
  utilizado   number(8) not null,
  livre       number(8) not null,
  data        date default sysdate,
  constraint tablespaces_pk primary key (nome,data)
);

CREATE TABLE ad.log_objeto_qt (
    tipo        varchar2(100),
    esquema     varchar2(30),
    status      varchar2(7),
    qt          number(10) NOT NULL,
    data        date DEFAULT SYSDATE,
    CONSTRAINT objeto_qt_pk PRIMARY KEY (tipo, esquema, status, data)
);

CREATE TABLE ad.log_objeto_invalido (
    tipo        varchar2(19),
    esquema     varchar2(30),
    nome        varchar2(128),
    data        date DEFAULT SYSDATE,
    CONSTRAINT objeto_invalido_pk PRIMARY KEY (tipo, esquema, nome, data)
);

CREATE TABLE ad.log_objeto_tamanho (
    tipo        varchar2(19),
    tablespace  varchar2(30),
    esquema     varchar2(30),
    nome_part   varchar2(112),
    tamanho     number(8),
    extents     number(5),
    num_reg     number(10),
    data        date DEFAULT SYSDATE,
    CONSTRAINT objetos_tamanho_pk PRIMARY KEY (tipo, esquema, nome_part, data)
);

create table ad.log_kill_session (
    nu_sid         number,
    nu_serial      number,
    tx_osuser      varchar2(128 byte),
    tx_username    varchar2(128 byte),
    dt_logon_time  date,
    dt_action_time date,
    tx_script   varchar2(1000 byte)
);

--------------------------------------------------------------------------------
-- Rotinas
--------------------------------------------------------------------------------
create or replace procedure ad.p_tablespace_load as
  v_log_seq number(10);
  v_code    number(10);
  v_errm    varchar2(64);
  begin
    select ad.log_seq.nextval
      into v_log_seq
      from dual;
    
    insert into ad.log(
      id_log,
      rotina
    )
    values(
      v_log_seq,
      'tablespace_load'
    );

    insert into ad.log_tablespace(
      nome,
      maximo,
      alocado,
      utilizado,
      livre
    )
    select u.tablespace_name,
           m.maximo,
           m.alocado,
           u.utilizado,
           l.livre
    from (select tablespace_name,
                 ceil(sum(bytes) / 1048576) utilizado
            from dba_segments
           group by tablespace_name) u,
         (select tablespace_name,
                 ceil(sum(bytes) / 1048576) alocado,
                 ceil(sum(decode(autoextensible, 'NO', bytes, maxbytes)) / 1048576) maximo
            from dba_data_files
           group by tablespace_name) m,
         (select tablespace_name,
                 ceil(sum(bytes) / 1048576) livre
            from dba_free_space
           group by tablespace_name) l
    where l.tablespace_name = u.tablespace_name
      and l.tablespace_name = m.tablespace_name;
    
    update ad.log
       set fim = sysdate
     where id_log = v_log_seq;
    
    commit;

  exception
    when others then
      v_code := sqlcode;
      v_errm := substr(sqlerrm, 1 , 64);
      insert into ad.log_erros(id_log, cod_erro, mensagem) values (v_log_seq, v_code, v_errm);
end;
/

CREATE OR REPLACE PROCEDURE ad.p_objeto_qt_load AS
  v_log_seq number(10);
  v_code number(10);
  v_errm varchar2(64);
BEGIN
  SELECT ad.log_seq.nextval INTO v_log_seq FROM dual;
  INSERT INTO ad.log (id_log, rotina) VALUES (v_log_seq,'objeto_qt_load');

  INSERT INTO ad.log_objeto_qt (tipo, esquema, status, qt)
    SELECT b.tipo, b.esquema, b.status, b.qt
      FROM
        (SELECT object_type tipo, owner esquema, status FROM dba_objects
           MINUS
           SELECT tipo, esquema, status FROM ad.log_objeto_qt) a,
        (SELECT object_type tipo, owner esquema, status, count(*) qt
           FROM dba_objects
           GROUP BY owner, object_type, status) b
      WHERE
        a.tipo = b.tipo AND
        a.esquema = b.esquema AND
        a.status = b.status
      ORDER BY esquema, tipo, status;

  INSERT INTO ad.log_objeto_qt (tipo, esquema, status, qt)
    SELECT o.tipo, o.esquema, o.status, o.qt
      FROM
        ad.log_objeto_qt q,
        (SELECT object_type tipo, owner esquema, status, count(*) qt
           FROM dba_objects
           GROUP BY owner, object_type, status) o,
        (SELECT tipo, esquema, status, max(data) data
           FROM ad.log_objeto_qt
           GROUP BY tipo, esquema, status) d
      WHERE
        o.tipo = q.tipo AND
        o.tipo = d.tipo AND
        o.esquema = q.esquema AND
        o.esquema = d.esquema AND
        o.status = q.status AND
        o.status = d.status AND
        q.data = d.data AND
        o.qt != q.qt
        order by o.esquema, o.tipo, o.status;
  UPDATE ad.log SET fim = SYSDATE WHERE id_log = v_log_seq;
  COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      v_code := SQLCODE;
      v_errm := SUBSTR(SQLERRM, 1 , 64);
      INSERT INTO log_erros (id_log, cod_erro, mensagem) VALUES (v_log_seq, v_code, v_errm);
END;
/

CREATE OR REPLACE PROCEDURE ad.p_objeto_invalido_load AS
  v_log_seq number(10);
  v_code number(10);
  v_errm varchar2(64);

BEGIN
  SELECT ad.log_seq.nextval INTO v_log_seq FROM dual;
  INSERT INTO ad.log (id_log, rotina) VALUES (v_log_seq,'objeto_invalido_load');
  INSERT INTO ad.log_objeto_invalido (tipo, esquema, nome)
    SELECT object_type tipo, owner esquema, object_name nome
      FROM dba_objects
      WHERE status != 'VALID'
    MINUS
    SELECT tipo, esquema, nome FROM ad.log_objeto_invalido
  ;
  UPDATE ad.log SET fim = SYSDATE WHERE id_log = v_log_seq;
  COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      v_code := SQLCODE;
      v_errm := SUBSTR(SQLERRM, 1 , 64);
      INSERT INTO ad.log_erros (id_log, cod_erro, mensagem) VALUES (v_log_seq, v_code, v_errm);
END;
/

CREATE OR REPLACE PROCEDURE ad.p_objeto_tamanho_load AS
  v_log_seq number(10);
  v_code number(10);
  v_errm varchar2(64);

BEGIN

  SELECT ad.log_seq.nextval INTO v_log_seq FROM dual;
  INSERT INTO ad.log (id_log, rotina) VALUES (v_log_seq,'objeto_tamanho_load');

  INSERT INTO ad.log_objeto_tamanho 
    (tipo, tablespace, esquema, nome_part, tamanho, extents, num_reg)
    SELECT b.tipo, b.tablespace, b.esquema, b.nome_part, b.tamanho, b.extents, b.num_reg
    FROM
      (SELECT
         segment_type tipo,
         owner esquema,
         NVL2(partition_name, segment_name || '/' || partition_name, segment_name) nome_part
         FROM dba_segments
      MINUS
      SELECT tipo, esquema, nome_part FROM ad.log_objeto_tamanho) a,
      (SELECT
        s.segment_type tipo,
        s.tablespace_name tablespace,
        s.owner esquema,
        NVL2(s.partition_name, s.segment_name || '/' || s.partition_name, s.segment_name) nome_part,
        CEIL(s.bytes/1048576) tamanho,
        s.extents,
        t.num_rows num_reg
        FROM
          dba_segments s,
          dba_tables t
       WHERE
         (s.bytes > 67108864 OR s.extents > 50 OR t.num_rows > 1000000) AND
          s.owner = t.owner (+)AND
          s.segment_name = t.table_name (+)) b
    WHERE
      a.tipo = b.tipo AND
      a.esquema = b.esquema AND
      a.nome_part = b.nome_part
  ;    

  INSERT INTO ad.log_objeto_tamanho 
    (tipo, tablespace, esquema, nome_part, tamanho, extents, num_reg)
    SELECT o.tipo, o.tablespace, o.esquema, o.nome_part, o.tamanho, o.extents, o.num_reg
      FROM
        ad.log_objeto_tamanho l,
        (SELECT tipo, esquema, nome_part, max(data) data
          FROM ad.log_objeto_tamanho
          GROUP BY tipo, esquema, nome_part) d,
        (SELECT
          s.segment_type tipo,
          s.tablespace_name tablespace,
          s.owner esquema,
          NVL2(s.partition_name, s.segment_name || '/' || s.partition_name, s.segment_name) nome_part,
          CEIL(s.bytes/1048576) tamanho,
          s.extents,
          t.num_rows num_reg
          FROM
            dba_segments s,
            dba_tables t
          WHERE
            (s.bytes > 67108864 OR s.extents > 50 OR t.num_rows > 1000000) AND
            s.owner = t.owner (+)AND
            s.segment_name = t.table_name (+)) o
      WHERE
        l.tipo = d.tipo AND
        l.tipo = o.tipo AND
        l.esquema = d.esquema AND
        l.esquema = o.esquema AND
        l.nome_part = d.nome_part AND
        l.nome_part = o.nome_part AND
        l.data = d.data AND
        (o.tamanho != CEIL(l.tamanho) OR l.extents != o.extents OR l.num_reg != o.num_reg)
      ORDER BY o.esquema, o.tablespace, o.tipo desc
  ;
  UPDATE ad.log SET fim = SYSDATE WHERE id_log = v_log_seq;
  COMMIT;

  EXCEPTION
    WHEN OTHERS THEN
      v_code := SQLCODE;
      v_errm := SUBSTR(SQLERRM, 1 , 64);
      INSERT INTO ad.log_erros (id_log, cod_erro, mensagem) VALUES (v_log_seq, v_code, v_errm);
END;
/

create or replace PROCEDURE    P_KILL_SESSION_INATIVE 
IS

      V1_SID NUMBER;
      V1_SERIAL NUMBER;
      V1_OSUSER VARCHAR2(128);
      V1_USERNAME VARCHAR2(128);
      V1_LOGON_TIME DATE;
      V1_SQLERRM VARCHAR2(2000);
      CURSOR C1 IS
         SELECT S.SID,
                S.SERIAL#,
                S.OSUSER,
                S.USERNAME,
                S.LOGON_TIME
           FROM V$SESSION S -- GV por ser RAC, se for PDB pode ser V
          WHERE S.STATUS = 'INACTIVE'
            AND S.LAST_CALL_ET > 1800
            AND S.USERNAME not in ('%UBR');
   BEGIN
      OPEN C1;
      LOOP
         FETCH C1 INTO V1_SID, V1_SERIAL, V1_OSUSER, V1_USERNAME, V1_LOGON_TIME;
      EXIT WHEN C1%NOTFOUND;
         BEGIN

            INSERT INTO AD.LOG_KILL_SESSION (
              nu_SID,
              nu_SERIAL,
              tx_OSUSER, 
              tx_USERNAME,
              dt_LOGON_TIME,
              dt_ACTION_TIME,
              tx_script
            ) VALUES (
              V1_SID,
              V1_SERIAL,
              V1_OSUSER,
              V1_USERNAME,
              V1_LOGON_TIME,
              SYSDATE,
              'ALTER SYSTEM KILL SESSION ' || '''' || V1_SID || ',' || V1_SERIAL || '''' || ' IMMEDIATE'
            );
            COMMIT;

         EXCEPTION
            WHEN OTHERS THEN
                V1_SQLERRM := SQLERRM;

                INSERT INTO AD.LOG_KILL_SESSION (
                  nu_SID,
                  nu_SERIAL,
                  tx_OSUSER, 
                  tx_USERNAME,
                  dt_LOGON_TIME,
                  dt_ACTION_TIME,
                  tx_script
                ) VALUES (
                  V1_SID,
                  V1_SERIAL,
                  V1_OSUSER,
                  V1_USERNAME,
                  V1_LOGON_TIME,
                  SYSDATE,
                  V1_SQLERRM
                );
                COMMIT;

         END;
      END LOOP;
      CLOSE C1;
   END;
/