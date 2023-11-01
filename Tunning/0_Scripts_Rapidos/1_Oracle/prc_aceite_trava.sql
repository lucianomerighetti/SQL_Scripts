/*
DROP TABLE SMOREIRA.BKUP_TMP_ACEITE_TRAVAS;
CREATE TABLE SMOREIRA.BKUP_TMP_ACEITE_TRAVAS AS
SELECT * FROM GLTHOMAZ.TMP_ACEITE_TRAVAS;
COMMIT;

GRANT SELECT ON SMOREIRA.BKUP_TMP_ACEITE_TRAVAS TO SETTLEMENTCONTRACT_ADM,SETTLEMENTCONTRACTUBR,SMOREIRA;

DROP TABLE SMOREIRA.TMP_ACEITE_TRAVAS;
CREATE TABLE SMOREIRA.TMP_ACEITE_TRAVAS AS
SELECT * FROM GLTHOMAZ.TMP_ACEITE_TRAVAS;
COMMIT;

GRANT SELECT ON SMOREIRA.TMP_ACEITE_TRAVAS TO SETTLEMENTCONTRACT_ADM,SETTLEMENTCONTRACTUBR,SMOREIRA;

DROP TABLE SMOREIRA.TMP_SC;
CREATE TABLE SMOREIRA.TMP_SC AS
SELECT * FROM GLTHOMAZ.TMP_SC;
COMMIT;


GRANT SELECT ON SMOREIRA.TMP_SC TO SETTLEMENTCONTRACT_ADM,SETTLEMENTCONTRACTUBR,SMOREIRA;
*/

--DELETE TABLE tmp_aceite_travas;
--COMMIT;

create or replace procedure SMOREIRA.PRC_ACEITE_TRAVA as

  v_cabecalho varchar(4000);
  v_COD_RECEIVER_CUSTOMER_DOCUMENT SMOREIRA.TMP_ACEITE_TRAVAS.COD_RECEIVER_CUSTOMER_DOCUMENT%type;
  v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT SMOREIRA.TMP_ACEITE_TRAVAS.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT%type;
  v_NaoEstaNaTempMaior_0 SMOREIRA.TMP_ACEITE_TRAVAS."NaoEstaNaTemp>0"%type;
  v_QtdUrNaoTemEfeitoDoAceite SMOREIRA.TMP_ACEITE_TRAVAS."QtdUrNaoTemEfeitoDoAceite"%type;
  v_QtdEfeitoDoAceiteVencidas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitoDoAceiteVencidas"%type;
  v_QtdEfeitoDoAceiteFuturas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitoDoAceiteFuturas"%type;
  v_QtdEfeitoSemUrTransacionada SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitoSemUrTransacionada"%type;
  v_QtdEfeitosComUrTransacionadaVencidas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosComUrTransacionadaVencidas"%type;
  v_QtdEfeitosComTransacionadaFuturas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosComTransacionadaFuturas"%type;  
  v_QtdEfeitosSyncadosVencidos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosSyncadosVencidos"%type;
  v_QtdEfeitosSyncadosfuturos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosSyncadosfuturos"%type;
  v_QtdEfeitosNaoSyncadosVencidos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosNaoSyncadosVencidos"%type;
  v_QtdEfeitosNaoSyncadosfuturos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosNaoSyncadosfuturos"%type;
  v_QtdEfeitosTravadosPorPAGSEGURO2Futuros SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosPorPAGSEGURO2Futuros"%type;
  v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosPorPAGSEGURO2Vencidos"%type;
  v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos"%type;
  v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos"%type;
  v_QtdEfeitosTravadosMistoFuturo SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosMistoFuturo"%type;
  v_QtdEfeitosTravadosMistoVencido SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosMistoVencido"%type;
  v_QtdEfeitosTravadosFIDCLostPriorityFuturas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosFIDCLostPriorityFuturas"%type;
  v_QtdEfeitosTravadosFIDCLostPriorityVencido SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosFIDCLostPriorityVencido"%type;
  v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosMoreThanOneAntecipationFuturas"%type;
  v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosMoreThanOneAntecipationVencidas"%type;
  v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas"%type;
  v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas SMOREIRA.TMP_ACEITE_TRAVAS."QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas"%type;

  cursor c_cnpj_maior_11 is
  	select  to_char(lpad(customer_document,14,0)) customer_document,
            max(rowid) mrowid
	  from smoreira.tmp_SC
	 where length(customer_document) > 11
     and rownum < 5
	group by customer_document;  

  cursor c_cnpj_menor_11 is
    select customer_document,	       
		   max(rowid) mrowid
	  from smoreira.tmp_SC
	 where length(customer_document) <= 11
     and rownum < 5
	group by customer_document;  

begin


  v_cabecalho := 'cod_receiver_customer_document;cod_contract_owner_participant_document;NaoEstaNaTemp>0;QtdUrNaoTemEfeitoDoAceite;QtdEfeitoDoAceiteVencidas;QtdEfeitoDoAceiteFuturas;QtdEfeitoSemUrTransacionada;QtdEfeitosComUrTransacionadaVencidas;QtdEfeitosComTransacionadaFuturas;QtdEfeitosSyncadosVencidos;QtdEfeitosSyncadosfuturos;QtdEfeitosNaoSyncadosVencidos;QtdEfeitosNaoSyncadosfuturos;QtdEfeitosTravadosPorPAGSEGURO2Futuros;QtdEfeitosTravadosPorPAGSEGURO2Vencidos;QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos;QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos;QtdEfeitosTravadosMistoFuturo;QtdEfeitosTravadosMistoVencido;QtdEfeitosTravadosFIDCLostPriorityFuturas;QtdEfeitosTravadosFIDCLostPriorityVencido;QtdEfeitosTravadosMoreThanOneAntecipationFuturas;QtdEfeitosTravadosMoreThanOneAntecipationVencidas;QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas;QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas';
  dbms_output.put_line(v_cabecalho); 

  for r_cnpj_maior_11 in c_cnpj_maior_11 loop
  
    v_COD_RECEIVER_CUSTOMER_DOCUMENT := null;
    v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT := null;
    v_NaoEstaNaTempMaior_0 := null;
    v_QtdUrNaoTemEfeitoDoAceite := null;
    v_QtdEfeitoDoAceiteVencidas := null;
    v_QtdEfeitoDoAceiteFuturas := null;
    v_QtdEfeitoSemUrTransacionada := null;
    v_QtdEfeitosComUrTransacionadaVencidas := null;
    v_QtdEfeitosComTransacionadaFuturas := null;
    v_QtdEfeitosSyncadosVencidos := null;
    v_QtdEfeitosSyncadosfuturos := null;
    v_QtdEfeitosNaoSyncadosVencidos := null;
    v_QtdEfeitosNaoSyncadosfuturos := null;
    v_QtdEfeitosTravadosPorPAGSEGURO2Futuros := null;
    v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos := null;
    v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos := null;
    v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos := null;
    v_QtdEfeitosTravadosMistoFuturo := null;
    v_QtdEfeitosTravadosMistoVencido := null;
    v_QtdEfeitosTravadosFIDCLostPriorityFuturas := null;
    v_QtdEfeitosTravadosFIDCLostPriorityVencido := null;
    v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas := null;
    v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas := null;
    v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas := null;
    v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas := null;

    select e.cod_receiver_customer_document, e.cod_contract_owner_participant_document,
    sum(case when tmp.customer_document is null then 1 else 0 end) as "NaoEstaNaTemp>0",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is null then 1 else 0 end) as "QtdUrNaoTemEfeitoDoAceite",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND rce.dat_partition < sysdate then 1 else 0 end) as "QtdEfeitoDoAceiteVencidas",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND rce.dat_partition > sysdate then 1 else 0 end) as "QtdEfeitoDoAceiteFuturas",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND ru.IDT_RECEIVABLE_UNIT is null then 1 else 0 end) as "QtdEfeitoSemUrTransacionada",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND ru.IDT_RECEIVABLE_UNIT is not null AND rce.dat_partition < sysdate then 1 else 0 end)
    as "QtdEfeitosComUrTransacionadaVencidas",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND ru.IDT_RECEIVABLE_UNIT is not null AND rce.dat_partition > sysdate then 1 else 0 end)
    as "QtdEfeitosComTransacionadaFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    AND ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT
    then 1 else 0 end) as "QtdEfeitosSyncadosVencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    AND ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT
    then 1 else 0 end) as "QtdEfeitosSyncadosfuturos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosNaoSyncadosVencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosNaoSyncadosfuturos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and ru.ind_acquirer = 'PAGSEGURO2'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosPorPAGSEGURO2Futuros",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and ru.ind_acquirer = 'PAGSEGURO2'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosPorPAGSEGURO2Vencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.dat_disabled is null
            and rce2.num_committed_amount > 0
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.dat_disabled is null
            and rce2.num_committed_amount > 0
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and rce.IND_DIVISION_RULE = 'STATIC_AMOUNT'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.IND_DIVISION_RULE = 'PERCENTAGE'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMistoFuturo",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and rce.IND_DIVISION_RULE = 'STATIC_AMOUNT'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.IND_DIVISION_RULE = 'PERCENTAGE'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMistoVencido",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and rce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.num_order < rce.num_order
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosFIDCLostPriorityFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and rce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.num_order < rce.num_order
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosFIDCLostPriorityVencido",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT' 
            having count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMoreThanOneAntecipationFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT' 
            having count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMoreThanOneAntecipationVencidas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT'
            having count(*) > 0
    )
    and exists (
        select count(*) from SMOREIRA.TMP_SC tmp2
            where tmp2.customer_document = s.cod_receiver_customer_document
            group by tmp2.customer_document
            HAVING count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT'
            having count(*) > 0
    )
    and exists (
        select count(*) from SMOREIRA.TMP_SC tmp2
            where tmp2.customer_document = s.cod_receiver_customer_document
            group by tmp2.customer_document
            HAVING count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas"
	into   v_COD_RECEIVER_CUSTOMER_DOCUMENT,
           v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT,
           v_NaoEstaNaTempMaior_0,
           v_QtdUrNaoTemEfeitoDoAceite,
           v_QtdEfeitoDoAceiteVencidas,
           v_QtdEfeitoDoAceiteFuturas,
           v_QtdEfeitoSemUrTransacionada,
           v_QtdEfeitosComUrTransacionadaVencidas,
           v_QtdEfeitosComTransacionadaFuturas,
           v_QtdEfeitosSyncadosVencidos,
           v_QtdEfeitosSyncadosfuturos,
           v_QtdEfeitosNaoSyncadosVencidos,
           v_QtdEfeitosNaoSyncadosfuturos,
           v_QtdEfeitosTravadosPorPAGSEGURO2Futuros,
           v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos,
           v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos,
           v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos,
           v_QtdEfeitosTravadosMistoFuturo,
           v_QtdEfeitosTravadosMistoVencido,
           v_QtdEfeitosTravadosFIDCLostPriorityFuturas,
           v_QtdEfeitosTravadosFIDCLostPriorityVencido,
           v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas,
           v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas,
           v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas,
           v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas		
    from SETTLEMENTCONTRACT_ADM.CUSTOMER_CONTRACTUAL_EFFECT_SYNC_TOGGLE s
    join SETTLEMENTCONTRACT_ADM.EXTERNAL_CONTRACT_PERMISSION e on s.cod_receiver_customer_document = e.cod_receiver_customer_document
    left join SMOREIRA.TMP_SC  tmp on e.COD_RECEIVER_CUSTOMER_DOCUMENT = tmp.customer_document
    join SETTLEMENTCONTRACT_ADM.REG_RECEIVABLE_UNIT rru on (e.cod_receiver_customer_document = rru.cod_receiver_customer_document AND rru.dat_partition > e.dat_creation)
    left join SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce on 
    (rru.idt_reg_receivable_unit = rce.idt_reg_receivable_unit 
    and rru.dat_partition = rce.dat_partition 
    and rce.cod_contract_owner_participant_document = e.cod_contract_owner_participant_document)
    left join SETTLEMENTCONTRACT_ADM.RECEIVABLE_UNIT ru on (
        rru.dat_settle = ru.dat_settle 
        AND rru.ind_payment_group = ru.ind_payment_group
        AND rru.ind_acquirer = ru.ind_acquirer
        and rru.dat_partition = ru.dat_partition
        and rru.cod_owner_customer_document = ru.cod_owner_customer_document
        and tmp.cod_costumer = ru.COD_RECEIVER_CUSTOMER
    )
    left join SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce on (
    ru.idt_receivable_unit = ce.idt_receivable_unit and ru.dat_partition = ce.dat_partition AND ce.flg_registered = 1)
    where s.dat_disabled is null
    and rce.dat_disabled is null
    and rce.num_committed_amount > 0
    and s.cod_receiver_customer_document =  r_cnpj_maior_11.customer_document
    group by e.cod_receiver_customer_document, e.cod_contract_owner_participant_document; 
	
    dbms_output.put_line(to_char(v_COD_RECEIVER_CUSTOMER_DOCUMENT)||';'||to_char(v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT)||';'||to_char(v_NaoEstaNaTempMaior_0)||';'||to_char(v_QtdUrNaoTemEfeitoDoAceite)||';'||to_char(v_QtdEfeitoDoAceiteVencidas)||';'||to_char(v_QtdEfeitoDoAceiteFuturas)||';'||to_char(v_QtdEfeitoSemUrTransacionada)||';'||to_char(v_QtdEfeitosComUrTransacionadaVencidas)||';'||to_char(v_QtdEfeitosComTransacionadaFuturas)||';'||to_char(v_QtdEfeitosSyncadosVencidos)||';'||to_char(v_QtdEfeitosSyncadosfuturos)||';'||to_char(v_QtdEfeitosNaoSyncadosVencidos)||';'||to_char(v_QtdEfeitosNaoSyncadosfuturos)||';'||to_char(v_QtdEfeitosTravadosPorPAGSEGURO2Futuros)||';'||to_char(v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos)||';'||to_char(v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos)||';'||to_char(v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos)||';'||to_char(v_QtdEfeitosTravadosMistoFuturo)||';'||to_char(v_QtdEfeitosTravadosMistoVencido)||';'||to_char(v_QtdEfeitosTravadosFIDCLostPriorityFuturas)||';'||to_char(v_QtdEfeitosTravadosFIDCLostPriorityVencido)||';'||to_char(v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas)||';'||to_char(v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas)||';'||to_char(v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas)||';'||to_char(v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas)); 
  end loop;


  dbms_output.put_line(' '); 
  dbms_output.put_line(' ');   

  for r_cnpj_menor_11 in c_cnpj_menor_11 loop
  
    v_COD_RECEIVER_CUSTOMER_DOCUMENT := null;
    v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT := null;
    v_NaoEstaNaTempMaior_0 := null;
    v_QtdUrNaoTemEfeitoDoAceite := null;
    v_QtdEfeitoDoAceiteVencidas := null;
    v_QtdEfeitoDoAceiteFuturas := null;
    v_QtdEfeitoSemUrTransacionada := null;
    v_QtdEfeitosComUrTransacionadaVencidas := null;
    v_QtdEfeitosComTransacionadaFuturas := null;
    v_QtdEfeitosSyncadosVencidos := null;
    v_QtdEfeitosSyncadosfuturos := null;
    v_QtdEfeitosNaoSyncadosVencidos := null;
    v_QtdEfeitosNaoSyncadosfuturos := null;
    v_QtdEfeitosTravadosPorPAGSEGURO2Futuros := null;
    v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos := null;
    v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos := null;
    v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos := null;
    v_QtdEfeitosTravadosMistoFuturo := null;
    v_QtdEfeitosTravadosMistoVencido := null;
    v_QtdEfeitosTravadosFIDCLostPriorityFuturas := null;
    v_QtdEfeitosTravadosFIDCLostPriorityVencido := null;
    v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas := null;
    v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas := null;
    v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas := null;
    v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas := null;

    select e.cod_receiver_customer_document, e.cod_contract_owner_participant_document,
    sum(case when tmp.customer_document is null then 1 else 0 end) as "NaoEstaNaTemp>0",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is null then 1 else 0 end) as "QtdUrNaoTemEfeitoDoAceite",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND rce.dat_partition < sysdate then 1 else 0 end) as "QtdEfeitoDoAceiteVencidas",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND rce.dat_partition > sysdate then 1 else 0 end) as "QtdEfeitoDoAceiteFuturas",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND ru.IDT_RECEIVABLE_UNIT is null then 1 else 0 end) as "QtdEfeitoSemUrTransacionada",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND ru.IDT_RECEIVABLE_UNIT is not null AND rce.dat_partition < sysdate then 1 else 0 end)
    as "QtdEfeitosComUrTransacionadaVencidas",
    sum(case when rce.IDT_REG_CONTRACTUAL_EFFECT is not null AND ru.IDT_RECEIVABLE_UNIT is not null AND rce.dat_partition > sysdate then 1 else 0 end)
    as "QtdEfeitosComTransacionadaFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    AND ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT
    then 1 else 0 end) as "QtdEfeitosSyncadosVencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    AND ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT
    then 1 else 0 end) as "QtdEfeitosSyncadosfuturos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosNaoSyncadosVencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosNaoSyncadosfuturos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and ru.ind_acquirer = 'PAGSEGURO2'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosPorPAGSEGURO2Futuros",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and ru.ind_acquirer = 'PAGSEGURO2'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosPorPAGSEGURO2Vencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.dat_disabled is null
            and rce2.num_committed_amount > 0
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and ce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.dat_disabled is null
            and rce2.num_committed_amount > 0
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and rce.IND_DIVISION_RULE = 'STATIC_AMOUNT'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.IND_DIVISION_RULE = 'PERCENTAGE'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMistoFuturo",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and rce.IND_DIVISION_RULE = 'STATIC_AMOUNT'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.IND_DIVISION_RULE = 'PERCENTAGE'
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMistoVencido",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and rce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.num_order < rce.num_order
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosFIDCLostPriorityFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and rce.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
    and exists (
        select * from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.num_order < rce.num_order
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosFIDCLostPriorityVencido",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT' 
            having count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMoreThanOneAntecipationFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT' 
            having count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosMoreThanOneAntecipationVencidas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition > sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT'
            having count(*) > 0
    )
    and exists (
        select count(*) from SMOREIRA.TMP_SC tmp2
            where tmp2.customer_document = s.cod_receiver_customer_document
            group by tmp2.customer_document
            HAVING count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas",
    sum(case when
    rce.IDT_REG_CONTRACTUAL_EFFECT is not null 
    AND ru.IDT_RECEIVABLE_UNIT is not null
    AND rce.dat_partition < sysdate 
    and exists (
        select count(*) from SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce2
            where rce2.idt_reg_receivable_unit = rce.idt_reg_receivable_unit
            and rce2.dat_partition = rce.dat_partition
            and rce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = '28169275000172'
            and rce2.IND_DIVISION_RULE = 'STATIC_AMOUNT'
            having count(*) > 0
    )
    and exists (
        select count(*) from SMOREIRA.TMP_SC tmp2
            where tmp2.customer_document = s.cod_receiver_customer_document
            group by tmp2.customer_document
            HAVING count(*) > 1
    )
    and not exists (
        select * from SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce2
            where ce2.idt_receivable_unit = ce.idt_receivable_unit
            and ce2.dat_partition = ce.dat_partition
            and ce2.dat_disabled is null
            and ce2.num_committed_amount > 0
            and ce2.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT = e.COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT )
    then 1 else 0 end) as "QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas"
	into   v_COD_RECEIVER_CUSTOMER_DOCUMENT,
           v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT,
           v_NaoEstaNaTempMaior_0,
           v_QtdUrNaoTemEfeitoDoAceite,
           v_QtdEfeitoDoAceiteVencidas,
           v_QtdEfeitoDoAceiteFuturas,
           v_QtdEfeitoSemUrTransacionada,
           v_QtdEfeitosComUrTransacionadaVencidas,
           v_QtdEfeitosComTransacionadaFuturas,
           v_QtdEfeitosSyncadosVencidos,
           v_QtdEfeitosSyncadosfuturos,
           v_QtdEfeitosNaoSyncadosVencidos,
           v_QtdEfeitosNaoSyncadosfuturos,
           v_QtdEfeitosTravadosPorPAGSEGURO2Futuros,
           v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos,
           v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos,
           v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos,
           v_QtdEfeitosTravadosMistoFuturo,
           v_QtdEfeitosTravadosMistoVencido,
           v_QtdEfeitosTravadosFIDCLostPriorityFuturas,
           v_QtdEfeitosTravadosFIDCLostPriorityVencido,
           v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas,
           v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas,
           v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas,
           v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas		
    from SETTLEMENTCONTRACT_ADM.CUSTOMER_CONTRACTUAL_EFFECT_SYNC_TOGGLE s
    join SETTLEMENTCONTRACT_ADM.EXTERNAL_CONTRACT_PERMISSION e on s.cod_receiver_customer_document = e.cod_receiver_customer_document
    left join SMOREIRA.TMP_SC  tmp on e.COD_RECEIVER_CUSTOMER_DOCUMENT = tmp.customer_document
    join SETTLEMENTCONTRACT_ADM.REG_RECEIVABLE_UNIT rru on (e.cod_receiver_customer_document = rru.cod_receiver_customer_document AND rru.dat_partition > e.dat_creation)
    left join SETTLEMENTCONTRACT_ADM.REG_CONTRACTUAL_EFFECT rce on 
    (rru.idt_reg_receivable_unit = rce.idt_reg_receivable_unit 
    and rru.dat_partition = rce.dat_partition 
    and rce.cod_contract_owner_participant_document = e.cod_contract_owner_participant_document)
    left join SETTLEMENTCONTRACT_ADM.RECEIVABLE_UNIT ru on (
        rru.dat_settle = ru.dat_settle 
        AND rru.ind_payment_group = ru.ind_payment_group
        AND rru.ind_acquirer = ru.ind_acquirer
        and rru.dat_partition = ru.dat_partition
        and rru.cod_owner_customer_document = ru.cod_owner_customer_document
        and tmp.cod_costumer = ru.COD_RECEIVER_CUSTOMER
    )
    left join SETTLEMENTCONTRACT_ADM.CONTRACTUAL_EFFECT ce on (
    ru.idt_receivable_unit = ce.idt_receivable_unit and ru.dat_partition = ce.dat_partition AND ce.flg_registered = 1)
    where s.dat_disabled is null
    and rce.dat_disabled is null
    and rce.num_committed_amount > 0
    and s.cod_receiver_customer_document =  r_cnpj_menor_11.customer_document
    group by e.cod_receiver_customer_document, e.cod_contract_owner_participant_document; 
   
    dbms_output.put_line(to_char(v_COD_RECEIVER_CUSTOMER_DOCUMENT)||';'||to_char(v_COD_CONTRACT_OWNER_PARTICIPANT_DOCUMENT)||';'||to_char(v_NaoEstaNaTempMaior_0)||';'||to_char(v_QtdUrNaoTemEfeitoDoAceite)||';'||to_char(v_QtdEfeitoDoAceiteVencidas)||';'||to_char(v_QtdEfeitoDoAceiteFuturas)||';'||to_char(v_QtdEfeitoSemUrTransacionada)||';'||to_char(v_QtdEfeitosComUrTransacionadaVencidas)||';'||to_char(v_QtdEfeitosComTransacionadaFuturas)||';'||to_char(v_QtdEfeitosSyncadosVencidos)||';'||to_char(v_QtdEfeitosSyncadosfuturos)||';'||to_char(v_QtdEfeitosNaoSyncadosVencidos)||';'||to_char(v_QtdEfeitosNaoSyncadosfuturos)||';'||to_char(v_QtdEfeitosTravadosPorPAGSEGURO2Futuros)||';'||to_char(v_QtdEfeitosTravadosPorPAGSEGURO2Vencidos)||';'||to_char(v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercFuturos)||';'||to_char(v_QtdEfeitosTravadosEfeitoDeAntecipacaoNaoRetornadoPelaCercVencidos)||';'||to_char(v_QtdEfeitosTravadosMistoFuturo)||';'||to_char(v_QtdEfeitosTravadosMistoVencido)||';'||to_char(v_QtdEfeitosTravadosFIDCLostPriorityFuturas)||';'||to_char(v_QtdEfeitosTravadosFIDCLostPriorityVencido)||';'||to_char(v_QtdEfeitosTravadosMoreThanOneAntecipationFuturas)||';'||to_char(v_QtdEfeitosTravadosMoreThanOneAntecipationVencidas)||';'||to_char(v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationFuturas)||';'||to_char(v_QtdEfeitosTravadosHasMultipleCustomerAndAnyAntecipationVencidas)); 
   
  end loop;
end;
/
show errors


set serveroutput on;
spool D:\Users\smoreira\aceite_trava.csv
EXEC SMOREIRA.PRC_ACEITE_TRAVA;