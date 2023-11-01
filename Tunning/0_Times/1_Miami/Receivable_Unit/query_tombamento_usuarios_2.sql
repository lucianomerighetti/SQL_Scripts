--1) Filtrar quem é Conforme Parcelas WEB e não tem transação escrow nos ultimos 30 dias (vamos ver se é viavel esse ultimo criterio por conta performance da query *) - Cassol
--* se a query de 'nao tem transação escrow nos ultimos 30 dias' não retornar vamos tirar esse criterio
--2) clientes que não façam antecipação - Cassol
--3) clientes da web que não façam split - Cassol
--4) clientes que não realizem cancelamento pela API de cancelamento - Cassol
--5) clientes com não tem rebate - Cassol

select
    temp.idt_safepay_user,
    temp.cod_customer
from
    jcerqueira.TMP_CUSTOMER_LONGTAIL_NESCROW temp
    inner join sellpaym_release_option sro on sro.idt_user_application = temp.idt_user_application and sro.ind_release_type = 'M'
where
    not exists (
        select 
            1 
        from 
            transaction t 
        where 
            t.idt_safepay_creditor = temp.idt_safepay_user
            and t.ind_channel <> 'W'
            and t.ind_release_type = 'U'
    )
    and not exists (
        select 
            1 
        from 
            transaction t 
        where 
            t.idt_safepay_creditor = temp.idt_safepay_user
            and t.idt_transaction_type = 9
    )
    and not exists (
        select
            1
        from
            advance_receivable aa 
        where
            aa.idt_safepay_user = temp.idt_safepay_user
    )
    and not exists (
        select
            1
        from
            transaction t
            inner join transaction_secondary ts on ts.idt_transaction_parent = t.idt_transaction
        where
            t.idt_safepay_creditor = temp.idt_safepay_user
    )
    and not exists (
        select
            1
        from
            transaction t
            inner join event evt on evt.cod_attribute_value = t.idt_transaction
            inner join event_attribute_value evtv on evtv.idt_event = evt.idt_event
        where
            t.idt_safepay_creditor = temp.idt_safepay_user
            and evtv.des_event_attribute_value = 'R | RESOURCE'
    );