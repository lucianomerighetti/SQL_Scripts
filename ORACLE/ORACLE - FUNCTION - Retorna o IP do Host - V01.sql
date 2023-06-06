drop function retorna_ip;

create or replace function retorna_ip (
    p_hostname in varchar2
) return varchar2 is
    v_ip varchar2(50);
begin
    begin
        v_ip := utl_inaddr.get_host_address(p_hostname);
    exception
        when others then
            v_ip := 'Desconhecido do servidor Oracle!!';
    end;

    return v_ip;
end;


select
    systimestamp                            data_hora,
    sys_context('USERENV', 'SESSION_USER')  session_user,
    sys_context('USERENV', 'INSTANCE_NAME') instance_name,
    sys_context('USERENV', 'SERVICE_NAME')  service_name,
    sys_context('USERENV', 'SERVER_HOST')   server_host,
    retorna_ip(sys_context('USERENV', 'SERVER_HOST'))
from
    dual;