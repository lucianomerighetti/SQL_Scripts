select sys_context('USERENV','INSTANCE_NAME') || ' / ' || sys_context('USERENV','SERVER_HOST') || ' / ' || sys_context('USERENV','IP_ADDRESS')
from dual