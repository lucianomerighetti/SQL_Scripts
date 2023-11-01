CREATE OR REPLACE TRIGGER TR_BLOQUEIA_ACESSO_CLIE
AFTER LOGON
ON DATABASE
DECLARE

p_profile varchar2(100) :='';

BEGIN


     for REC in (SELECT sys_CONTEXT('USERENV','DATABASE_ROLE') DATABASE_ROLE, SYS_CONTEXT('USERENV','INSTANCE') instance, nvl(OSUSER,'unknow') osuser, USERNAME, MACHINE, PROGRAM, CLIENT_IDENTIFIER, SYS_CONTEXT('USERENV','IP_ADDRESS') IP_ADDRESS, SERIAL# SERIAL   FROM V$SESSION   WHERE AUDSID = SYS_CONTEXT('USERENV','SESSIONID')) loop


         if lower(rec.osuser) not in ('zzzzz','yyyy') then 
             
		   select profile into p_profile from dba_users where lower(username) = lower(rec.osuser);
			 
            if ((rec.database_role in ('PRIMARY') and p_profile in ('PR_DEV','PR_AD')))  then 
             
                     raise_application_error(-20001, SYS_CONTEXT('USERENV','HOST') || ' Voce nao pode acessar a base de Primary com este usuario!');
              
            end if;
         end if;
        
    end loop;

END;
/