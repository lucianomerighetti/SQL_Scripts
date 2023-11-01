ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET nls_numeric_characters = '.,';
alter session set current_schema = ATM_ADM;

select * 
    FROM ( 
      select 
        wb.idt_atm_withdraw_batch, 
        wb.dat_closing, 
        wb.dat_sending, 
        cwb.num_bank,  
        SUM(DECODE(w.IND_STATUS, 'C', w.num_transaction_total_value, 0)) batch_value, 
        SUM(DECODE(w.IND_STATUS, 'C', 1, 0)) batch_quantity, 
        cwb.flg_automatic_sending, 
        null return_quantity, 
        null last_return_date, 
        SUM(DECODE(w.FLG_AUTO_WITHDRAW, 1, w.num_transaction_total_value, 0)) auto_withdraw_value, 
        SUM(DECODE(w.FLG_AUTO_WITHDRAW, 1, 1, 0)) auto_withdraw_quantity, 
        wb.FLG_FALLBACK_USED, 
        wb.dat_transfering 
      FROM atm_adm.atm_withdraw_batch wb 
      INNER JOIN atm_adm.config_withdraw_batch cwb on wb.idt_config_withdraw_batch = cwb.idt_config_withdraw_batch 
      LEFT JOIN atm_adm.withdraw w on wb.idt_atm_withdraw_batch = w.idt_atm_withdraw_batch 
      WHERE 1=1
      AND flg_closed= 0 
       AND (wb.dat_due is null  
       OR wb.dat_due >= to_date('14/11/2020','dd/MM/yyyy') AND wb.dat_due <= to_date('23/11/2020','dd/MM/yyyy') )
       and cwb.ind_withdraw_batch_type = 'S'
      GROUP BY 
      wb.idt_atm_withdraw_batch, 
      wb.dat_closing, 
      wb.dat_sending, 
      cwb.num_bank, 
      cwb.flg_automatic_sending,
      wb.FLG_FALLBACK_USED, 
      wb.dat_transfering 
    UNION ALL 
      SELECT 
        wb.idt_atm_withdraw_batch, 
        wb.dat_closing, 
        wb.dat_sending, 
        cwb.num_bank, 
        wbs.num_batch_total_value batch_value,
        wbs.num_withdraw_quantity batch_quantity, 
        cwb.flg_automatic_sending, 
        wbs.num_return_quantity return_quantity, 
        wbs.dat_last_return last_return_date, 
        wbs.num_auto_withdraw_value auto_withdraw_value, 
        wbs.num_auto_withdraw_quantity auto_withdraw_quantity, 
        wb.FLG_FALLBACK_USED, 
        wb.dat_transfering 
      FROM atm_adm.atm_withdraw_batch wb 
      INNER JOIN atm_adm.config_withdraw_batch cwb on wb.idt_config_withdraw_batch = cwb.idt_config_withdraw_batch 
      LEFT JOIN atm_adm.atm_withdraw_batch_summary wbs on wbs.idt_atm_withdraw_batch = wb.idt_atm_withdraw_batch 
      WHERE flg_closed = 1 
      and cwb.ind_withdraw_batch_type = 'S' --filtro por saque excluindo verificação de contas
       AND (wb.dat_due is null  
       OR wb.dat_due >= to_date('14/11/2020','dd/MM/yyyy') AND wb.dat_due <= to_date('23/11/2020','dd/MM/yyyy') ) 
      ) AWB
    ORDER BY 
       AWB.dat_closing desc, 
       AWB.dat_sending desc