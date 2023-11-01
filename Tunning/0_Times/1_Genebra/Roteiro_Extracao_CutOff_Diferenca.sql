Roteiro Extração CutOff - Diferença Receber BS em 30/09

-- 1. Executar a query no Data-X

-- >>> ENVIRONMENT: prod
-- >>> SCHEDULE_INTERVAL : nulo
-- >>> APPLICATION_USER_NAME: bko-fin-receb-genebra
-- >>> S3_PATH: RECEB-1939
-- >>> SOURCE_QUERY: 
SELECT
    ft.idt_transaction as "Idt transaction",
    t.dat_creation as "Data criacao",
    pr.num_release_value as "Valor transacao",
    ft.num_turnover_value as "Valor taxa",
    t.dat_start_escrow + interval '0.001' second * t.num_millisec_escrow as "Data escrow",
    pr.dat_released  as "Data Liquidada",
    pr.dat_release as "Data a ser liquidada"
from otis.safepay_adm_financial_turnover ft
inner join otis.safepay_adm_financial_account fcc on fcc.idt_financial_account = ft.idt_financial_account_credit
inner join otis.safepay_adm_financial_account fcd on fcd.idt_financial_account = ft.idt_financial_account_debt
inner join otis.safepay_adm_payment_release pr on pr.idT_transaction = ft.idt_transaction
inner join otis.safepay_adm_transaction t on t.idt_Transaction = ft.idt_transaction
where fcc.idt_safepay_user = 118937547
and fcd.idt_safepay_user <> 111946522
and fcc.idt_financial_account_type = 4
and (pr.ind_status = 'O' or pr.dat_released >= to_date('2020-10-01', 'YYYY-MM-DD'))
and  pr.num_installment = 1
and ft.dat_creation > to_date('2020-07-31', 'YYYY-MM-DD')
and ft.dat_creation < to_date('2020-10-01', 'YYYY-MM-DD')

-- >>> UNLOAD_PARAMETERS: parallel off addquotes allowoverwrite encrypted delimiter ','



-- 2. Validar a execução no AWS AirFlow
-- 3. Validar a criação da pasta no S3: pagseguro-data-warehouse-output/bko-fin-receb-genebra/RECEB-1939
-- 4. Baixar o arquivo via AWS Cli:  aws --profile genebra-prod --recursive s3 cp s3://pagseguro-data-warehouse-output/bko-fin-receb-genebra/RECEB-1939/day=2020-11-13 c:\Sammy


