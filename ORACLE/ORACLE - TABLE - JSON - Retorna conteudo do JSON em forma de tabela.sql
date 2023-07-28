select pi.cod_payment,
       pi.dat_creation,
       p.ind_escrow_type,
       p.num_escrow_value,
       jsn.payment_method,
       jsn.escrow_delay_days
  from receivables_adm.payment_intent pi
       join receivables_adm.payment   p on (pi.cod_payment = p.cod_payment),
       json_table(pi.jsn_payload,
                  '$[*]'
                  columns(payment_method    varchar2(36) path '$.paymentInfo.payment_processor',
                          escrow_delay_days number(4)    path '$.escrow.delay_days')
                 ) jsn
 where pi.num_payload_version = 2
   and trunc(pi.dat_creation) = trunc(sysdate - 1)
   and jsn.payment_method    <> 'PIX'
   and jsn.escrow_delay_days is not null;


--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

select date '2022-02-21' + level - 1 date_purge
from   dual
connect by level <= (
date '2022-02-28' - date  '2022-02-21' + 1);

select re.idt_payment from receivables_adm.receivable_external re;

select re.idt_payment from receivables_adm.receivable_internal ri;

select re.idt_payment from receivables_adm.payment p;

with
    fee_ext as(
        select re.idt_payment       ext_idt_payment,
               fees.fee_type        ext_fee_type,
               sum(fees.fee_amount) ext_fee_amount
          from receivables_adm.receivable_external re,
               json_table(re.jsn_seller_fee, '$[*]'
                              columns(fee_name   varchar2(30)   path '$.name',
                                      fee_type   varchar2(15)   path '$.type',
                                      fee_amount number(38 ,22) path '$.amount')) fees
         where fees.fee_type  = 'INTERMEDIATION'
           and re.idt_payment in (655930, 655991, 655952, 655913, 655914, 655915, 655916, 655947, 655948, 655949, 655950)
         group by re.idt_payment,
                  fees.fee_type
    ),
    fee_int as(
        select ri.idt_payment       int_idt_payment,
               fees.fee_type        int_fee_type,
               sum(fees.fee_amount) int_fee_amount
          from receivables_adm.receivable_internal ri,
               json_table(ri.jsn_seller_fee, '$[*]'
                              columns(fee_name   varchar2(30)   path '$.name',
                                      fee_type   varchar2(15)   path '$.type',
                                      fee_amount number(38 ,22) path '$.amount')) fees
         where fees.fee_type  = 'INTERMEDIATION'
--           and ri.idt_payment in (655930, 655991, 655952, 655913, 655914, 655915, 655916, 655947, 655948, 655949, 655950)
         group by ri.idt_payment,
                  fees.fee_type
    ),
    fee_pay as (
        select p.idt_payment        pay_idt_payment,
               fees.fee_type        pay_fee_type,
               sum(fees.fee_amount) pay_fee_amount
          from receivables_adm.payment p,
               json_table(p.jsn_seller_fee, '$[*]'
                              columns(fee_name   varchar2(30)   path '$.name',
                                      fee_type   varchar2(15)   path '$.type',
                                      fee_amount number(38 ,22) path '$.amount')) fees
            where fees.fee_type = 'INTERMEDIATION'
--              and p.idt_payment in (655930, 655991, 655952, 655913, 655914, 655915, 655916, 655947, 655948, 655949, 655950)
         group by p.idt_payment,
                  fees.fee_type
    )
--------------------------------------------------------------------------------
--EXTERNAL
--select *
--  from fee_ext            fe
--       inner join fee_pay fp on (fe.ext_idt_payment =  fp.pay_idt_payment and
--                                 fe.ext_fee_amount  <> fp.pay_fee_amount);
--------------------------------------------------------------------------------
--INTERNAL
select *
  from fee_int            fi
       inner join fee_pay fp on (fi.int_idt_payment =  fp.pay_idt_payment and
                                 fi.int_fee_amount  <> fp.pay_fee_amount);
--------------------------------------------------------------------------------