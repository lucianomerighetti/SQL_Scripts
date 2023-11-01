-- Analise de blocos de uma tablespace
SET SERVEROUTPUT ON SIZE 1000000 CREATE OR REPLACE PROCEDURE tablespace_map (tbs_name IN VARCHAR2, mb_separator IN NUMBER DEFAULT 1000)
IS
    USED        CONSTANT    VARCHAR2(1) :=    'X';
    FREE        CONSTANT    VARCHAR2(1) :=    '-';
    DELIMIT        CONSTANT    VARCHAR2(1) :=    '|';     v_block_size        NUMBER(2);
    v_num_data_files    NUMBER;
    v_tam_tablespace    NUMBER;
    v_segmentos_free    NUMBER;
    v_free_space        NUMBER;
    v_ult_ext            NUMBER;
    v_num_div            NUMBER;
BEGIN
    -- tamanho do bloco (em k)
    SELECT    block_size/1024
    INTO    v_block_size
    FROM    dba_tablespaces
    WHERE    tablespace_name = tbs_name;     -- número e tamanho dos datafiles
    SELECT    count(1), trunc(sum(bytes)/1024/1024)
    INTO    v_num_data_files, v_tam_tablespace
    FROM    dba_data_files
    WHERE    tablespace_name = tbs_name;     -- número e tamanho de segmentos livres
    SELECT    count(1), trunc(sum(bytes)/1024/1024)
    INTO    v_segmentos_free, v_free_space
    FROM    dba_free_space
    WHERE    tablespace_name = tbs_name;     DBMS_OUTPUT.PUT (chr(13)||chr(10)||chr(13)||chr(10));
    DBMS_OUTPUT.PUT ('Mapa da tablespace ' || tbs_name || chr(13)||chr(10) || chr(13)||chr(10));
    DBMS_OUTPUT.PUT_LINE ('Datafiles:');     FOR df IN (SELECT file_id, file_name, bytes/1024/1024 mb_datafile FROM dba_data_files WHERE tablespace_name=tbs_name) LOOP         DBMS_OUTPUT.PUT ('ID: '||LPAD(df.file_id,3,' ')||' | '||df.file_name||' | '||df.mb_datafile||' MB ');
        DBMS_OUTPUT.PUT (DELIMIT);         v_ult_ext := 0;
        v_num_div := CEIL(df.mb_datafile/mb_separator);         FOR ext IN (SELECT distinct trunc(block_id*v_block_size/1024/mb_separator)+1 mb_ext_ini,
                                    trunc(((block_id+blocks)*v_block_size-1)/1024/mb_separator)+1 mb_ext_fim
                         FROM dba_extents
                        WHERE tablespace_name=tbs_name AND file_id=df.file_id
                        ORDER BY 1,2) LOOP             IF ext.mb_ext_ini <> v_ult_ext THEN
                FOR i IN v_ult_ext+1 .. ext.mb_ext_ini-1 LOOP
                    DBMS_OUTPUT.PUT (FREE);
                END LOOP;
                DBMS_OUTPUT.PUT (USED);
                v_ult_ext := ext.mb_ext_ini;
            END IF;             IF ext.mb_ext_fim <> ext.mb_ext_ini THEN
                FOR i IN ext.mb_ext_ini+1 .. ext.mb_ext_fim LOOP
                    DBMS_OUTPUT.PUT (USED);
                END LOOP;
                v_ult_ext := ext.mb_ext_fim;
            END IF;         END LOOP;         -- completa os espaços vazios restantes
        FOR i IN v_ult_ext+1 .. v_num_div LOOP
            DBMS_OUTPUT.PUT (FREE);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE (DELIMIT);     END LOOP;     DBMS_OUTPUT.PUT (chr(13)||chr(10)||chr(13)||chr(10));
    DBMS_OUTPUT.PUT_LINE ('Tamanho da tablespace: ' || v_tam_tablespace || ' MB');
    DBMS_OUTPUT.PUT_LINE ('Espaco livre: ' || v_free_space || ' MB em ' || v_segmentos_free || ' segmentos');
    DBMS_OUTPUT.PUT_LINE ('Numero de datafiles: ' || v_num_data_files);
    DBMS_OUTPUT.PUT_LINE ('Tamanho de cada bloco: ' || v_block_size || ' KB');
    DBMS_OUTPUT.PUT ('Divisao de datafile: ' || mb_separator || ' MB');
    DBMS_OUTPUT.PUT_LINE (chr(13)||chr(10)); EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE ('Tablespace nao encontrada.');
END tablespace_map;
/ exec tablespace_map('TBSXXX',100);