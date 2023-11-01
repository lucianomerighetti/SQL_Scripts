-- Criação de roles que irão gerenciar os acessos as tabelas com dados sensiveis 

-- Dados deste grupo não são críticos e por default o acesso a esse tipo de dado é permitido com a aprovação da Domain Data Owner.
CREATE ROLE [RL_COMPLIANCE_NSA]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [RL_COMPLIANCE_NSA]
GO

-- Personally identifiable information Campos que podem ser usadas para identificar, contactar ou localizar uma única pessoa

CREATE ROLE [RL_COMPLIANCE_PII]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [RL_COMPLIANCE_PII]
GO
GRANT UNMASK TO [RL_COMPLIANCE_PII]
GO

-- Payment Card Industry - Padrão internacional de segurança de dados da indústria de cartões de pagamentos.
CREATE ROLE [RL_COMPLIANCE_PCI]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [RL_COMPLIANCE_PCI]
GO
GRANT UNMASK TO [RL_COMPLIANCE_PCI]
GO

-- Strategic Operational	Campos identificados como Dado Estratégico Operacional DEO
CREATE ROLE [RL_COMPLIANCE_SO]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [RL_COMPLIANCE_SO]
GO
GRANT UNMASK TO [RL_COMPLIANCE_SO]
GO

-- Banking Secrecy	Campos que encaixam na classificação de sigilo bancário
CREATE ROLE [RL_COMPLIANCE_BS]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [RL_COMPLIANCE_BS]
GO
GRANT UNMASK TO [RL_COMPLIANCE_BS]
GO

-- 	Strategic financial	Campos identificados como Dado Estratégico Financeiro DEF
CREATE ROLE [RL_COMPLIANCE_SF]
GO
ALTER AUTHORIZATION ON SCHEMA::[db_datareader] TO [RL_COMPLIANCE_SF]
GO
GRANT UNMASK TO [RL_COMPLIANCE_SF]
GO