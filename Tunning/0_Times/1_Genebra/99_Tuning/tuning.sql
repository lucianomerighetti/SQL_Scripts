SELECT JOB_INSTANCE_ID, JOB_NAME 
FROM FIDC_ADM.BATCH_JOB_INSTANCE 
WHERE JOB_NAME LIKE ? /* NÃO TEM INDICE POR JOB_NAME, SERIA VALIDO CRIAR */
ORDER by JOB_INSTANCE_ID desc ;

update transaction_installment
set dat_update=current_timestamp
, ind_settlement_status= 3
where dat_settlement= '2019-05-06'
and ind_settlement_status=4
and cod_safepay_installment='06DAF398D6D24750870EABC95E644547'
/*particionada por dat_settlement, mas não tem nenhum indice composto com esses três campos*/


update payment_release_event
set flg_processed='TRUE', dat_update= current_timestamp
where idt_payment_release_event= 72225408 and dat_update_ps='2019-05-14 17:00:17-03';

/*particionada por dat_update_ps, idt_payment_release_event é PK na partição

fidc.postgres.rds.bd.intranet fidc_adm@fidc=> explain analyze
> update payment_release_event
> set flg_processed='TRUE', dat_update= current_timestamp
> where idt_payment_release_event= 72225408 and dat_update_ps='2019-05-14 17:00:17-03';
                                                                                      QUERY PLAN
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Update on payment_release_event  (cost=0.42..8.44 rows=1 width=115) (actual time=0.072..0.072 rows=0 loops=1)
   Update on payment_release_event_y2019_m05_d14
   ->  Index Scan using payment_release_event_y2019_m05_d14_pkey on payment_release_event_y2019_m05_d14  (cost=0.42..8.44 rows=1 width=115) (actual time=0.016..0.017 rows=1 loops=1)
         Index Cond: (idt_payment_release_event = 72225408)
         Filter: (dat_update_ps = '2019-05-14 17:00:17-03'::timestamp with time zone)
 Planning time: 2312.947 ms
 Execution time: 0.154 ms
(7 rows)

*/


select coalesce(sum(settlement0_.num_value), ?) AS col_0_0_
     , coalesce(count(distinct settlement0_.dat_settlement), ?) AS col_1_0_ 
FROM settlement_installment settlement0_ 
WHERE settlement0_.dat_settlement>=? 
  AND settlement0_.dat_settlement<=? 
  AND settlement0_.flg_active=? 
  AND (settlement0_.flg_escrow_zero=? OR 
       settlement0_.flg_escrow_zero=? AND 
	   settlement0_.dat_creation<?) 
  AND  NOT (exists (select prepayment1_.idt_transaction_installment 
                    FROM prepayment_installment prepayment1_ 
					WHERE prepayment1_.idt_transaction_installment=settlement0_.idt_transaction_installment 
					AND prepayment1_.dat_partition>=? 
					AND prepayment1_.dat_partition<=?))
					
					
select transactio0_.idt_transaction AS idt_tran1_3_0_, 
       transactio0_.dat_creation AS dat_crea2_3_0_, 
	   transactio0_.dat_creation_ps AS dat_crea3_3_0_, 
	   transactio0_.cod_credit_card_brand AS cod_cred4_3_0_, 
	   transactio0_.dat_escrow AS dat_escr5_3_0_, 
	   transactio0_.num_total_installments AS num_tota6_3_0_, 
	   transactio0_.num_negotiation_version AS num_nego7_3_0_, 
	   transactio0_.num_net_value AS num_net_8_3_0_, 
	   transactio0_.cod_nsu AS cod_nsu9_3_0_, 
	   transactio0_.num_original_value AS num_ori10_3_0_, 
	   transactio0_.ind_status AS ind_sta11_3_0_, 
	   transactio0_.num_total_cost_value AS num_tot12_3_0_, 
	   transactio0_.cod_safepay_transaction AS cod_saf13_3_0_, 
	   transactio0_.dat_update AS dat_upd14_3_0_, 
	   transactio0_.idt_safepay_user AS idt_saf15_3_0_, 
	   transactio0_.num_value AS num_val16_3_0_ 
FROM "transaction" transactio0_ 
WHERE transactio0_.idt_transaction=?

SELECT * 
FROM transaction_installment_history th  
WHERE th.dat_update >= ? 
AND th.dat_update < ?  
AND not EXISTS (SELECT cc.idt_transaction_installment_history                    
                FROM cnab_content cc                   
				WHERE cc.idt_transaction_installment_history = th.idt_transaction_installment_history 
				AND cc.dat_reference >= ? 
				AND cc.dat_reference < ? ) 
LIMIT ? 