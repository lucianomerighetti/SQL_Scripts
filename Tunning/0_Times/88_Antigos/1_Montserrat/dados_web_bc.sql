WITH TRANSACAO (IDT_SAFEPAY_USER, IDT_USER_APPLICATION, DES_CAPTURE_TYPE, COD_TRANSACTION_COST, DES_PAYMENT_PROCESSOR, FLG_CONFOR_PARC, NUM_MIN_INSTALLMENT, NUM_MAX_INSTALLMENT, DES_COST_TYPE, VAL_RATE,
                DAT_START, DAT_END, IND_CHANNEL, IDT_TRANSACTION_COST_VALUE, FLG_ACTIVE, IND_ORIGIN) AS (
  SELECT DISTINCT
        cost_value.IDT_SAFEPAY_USER,
        cost_value.IDT_USER_APPLICATION,
        'WEB' AS DES_CAPTURE_TYPE,
        CASE
            WHEN cost_value.IDT_TRANSACTION_COST IN (1, 3, 7) THEN 2
            WHEN cost_value.IDT_TRANSACTION_COST IN (4, 8, 14) THEN 3
            WHEN cost_value.IDT_TRANSACTION_COST IN (23) THEN NULL
            WHEN cost_value.IDT_TRANSACTION_COST IN (9, 10) THEN 5
            WHEN cost_value.IDT_TRANSACTION_COST IN (15, 16) THEN 4
            WHEN cost_value.IDT_TRANSACTION_COST IN (18, 19) THEN 7
            WHEN cost_value.IDT_TRANSACTION_COST IN (27, 28) THEN 9
            ELSE NULL
            END
            AS COD_TRANSACTION_COST,
        NULL AS DES_PAYMENT_PROCESSOR,
        NULL AS FLG_CONFOR_PARC,
        cost_value.NUM_INSTALLMENT_QTY AS NUM_MIN_INSTALLMENT,
        cost_value.NUM_INSTALLMENT_QTY AS NUM_MAX_INSTALLMENT,
        transaction_cost.DES_TRANSACTION_COST AS DES_COST_TYPE,
        cost_value.NUM_TRANSACTION_COST AS VAL_RATE,
        cost_value.DAT_START,
        cost_value.DAT_END,
        cost_value.IND_CHANNEL,
        cost_value.IDT_TRANSACTION_COST_VALUE,
        cost_value.FLG_ACTIVE,
        cost_value.IND_ORIGIN
    FROM
        SAFEPAY_ADM.TRANSACTION_COST_VALUE cost_value
        INNER JOIN SAFEPAY_ADM.TRANSACTION_COST transaction_cost
            ON cost_value.IDT_TRANSACTION_COST = transaction_cost.IDT_TRANSACTION_COST
        LEFT JOIN USER_APPLICATION ua
            ON (cost_value.IDT_USER_APPLICATION = ua.IDT_USER_APPLICATION AND ua.FLG_DEFAULT = 1)
    WHERE
       cost_value.IND_CHANNEL = 'W'
       --AND cost_value.FLG_ACTIVE = 1
),

TRANSACAO_CUSTOM (IDT_SAFEPAY_USER, IDT_USER_APPLICATION, DES_CAPTURE_TYPE, COD_TRANSACTION_COST, DES_PAYMENT_PROCESSOR, FLG_CONFOR_PARC, NUM_MIN_INSTALLMENT, NUM_MAX_INSTALLMENT, DES_COST_TYPE, VAL_RATE,
                DAT_START, DAT_END, IND_CHANNEL, IDT_TRANSACTION_COST_VALUE, FLG_ACTIVE, IND_ORIGIN, DAT_LOG) AS (
  SELECT DISTINCT
        cost_value.IDT_SAFEPAY_USER,
        cost_value.IDT_USER_APPLICATION,
        'WEB' AS DES_CAPTURE_TYPE,
        CASE
            WHEN cost_value.IDT_TRANSACTION_COST IN (1, 3, 7) THEN 2
            WHEN cost_value.IDT_TRANSACTION_COST IN (4, 8, 14) THEN 3
            WHEN cost_value.IDT_TRANSACTION_COST IN (23) THEN NULL
            WHEN cost_value.IDT_TRANSACTION_COST IN (9, 10) THEN 5
            WHEN cost_value.IDT_TRANSACTION_COST IN (15, 16) THEN 4
            WHEN cost_value.IDT_TRANSACTION_COST IN (18, 19) THEN 7
            WHEN cost_value.IDT_TRANSACTION_COST IN (27, 28) THEN 9
            ELSE NULL
            END
            AS COD_TRANSACTION_COST,
        NULL AS DES_PAYMENT_PROCESSOR,
        NULL AS FLG_CONFOR_PARC,
        cost_value.NUM_INSTALLMENT_QTY AS NUM_MIN_INSTALLMENT,
        cost_value.NUM_INSTALLMENT_QTY AS NUM_MAX_INSTALLMENT,
        transaction_cost.DES_TRANSACTION_COST AS DES_COST_TYPE,
        cost_value.NUM_TRANSACTION_COST AS VAL_RATE,
        cost_value.DAT_START,
        cost_value.DAT_END,
        cost_value.IND_CHANNEL,
        cost_value.IDT_TRANSACTION_COST_VALUE,
        cost_value.FLG_ACTIVE,
        cost_value.IND_ORIGIN,
        cost_value.DAT_LOG
    FROM
        SAFEPAY_ADM.TRANSACTION_COST_VALUE_LOG cost_value
        INNER JOIN SAFEPAY_ADM.TRANSACTION_COST transaction_cost
            ON cost_value.IDT_TRANSACTION_COST = transaction_cost.IDT_TRANSACTION_COST
    WHERE
       cost_value.IND_CHANNEL = 'W'
       --AND cost_value.FLG_ACTIVE = 1
       AND DAT_START <= to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss')
       AND (DAT_END > to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss') or DAT_END IS NULL)
       AND DAT_LOG = (SELECT MAX(DAT_LOG) FROM SAFEPAY_ADM.TRANSACTION_COST_VALUE_LOG SUB WHERE SUB.DAT_LOG <= to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss') AND SUB.IDT_SAFEPAY_USER = :SAFEPAY_USER AND SUB.IDT_TRANSACTION_COST = cost_value.IDT_TRANSACTION_COST)
)


SELECT *
FROM
    (--APLICAÇÃO
    SELECT DISTINCT
        TCV.IDT_SAFEPAY_USER,
        UA.IDT_USER_APPLICATION,
        NULL AS IDT_PAYMENT_METHOD,
        NULL AS DES_CAPTURE_TYPE,
        NULL AS DES_PAYMENT_METHOD_TYPE,
        NULL AS DES_PAYMENT_PROCESSOR,
        NULL AS VAL_ESCROW,
        NULL AS FLG_CONFOR_PARC,
        NULL AS NUM_MIN_INSTALLMENT,
        NULL AS NUM_MAX_INSTALLMENT,
        TC.DES_TRANSACTION_COST AS DES_COST_TYPE,
        TCV.NUM_TRANSACTION_COST AS VAL_RATE,
        TCV.DAT_START,
        TCV.DAT_END,
        'APPLICATION' AS NAM_CONTRACT,
        'APPLICATION' AS DES_CONTRACT_TYPE
    FROM
        TRANSACTION_COST_VALUE_LOG TCV
        INNER JOIN SAFEPAY_ADM.USER_APPLICATION UA ON TCV.IDT_USER_APPLICATION = UA.IDT_USER_APPLICATION AND TCV.IDT_TRANSACTION_COST IN (17, 20)
        INNER JOIN TRANSACTION_COST TC ON TCV.IDT_TRANSACTION_COST = TC.IDT_TRANSACTION_COST
    WHERE
        UA.IDT_SAFEPAY_USER = :SAFEPAY_USER
        AND TCV.IND_CHANNEL = 'W'
        AND (TCV.DAT_START IS NULL OR TCV.DAT_START <= TO_DATE(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (TCV.DAT_END IS NULL OR TCV.DAT_END > TO_DATE(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND DAT_LOG IN (SELECT DISTINCT MAX(DAT_LOG)
                        FROM SAFEPAY_ADM.TRANSACTION_COST_VALUE_LOG
                        WHERE TO_DATE(DAT_LOG, 'yyyy-mm-dd hh24:mi:ss') <= TO_DATE(:DATA, 'yyyy-mm-dd hh24:mi:ss')
                        AND IDT_SAFEPAY_USER = :SAFEPAY_USER
                        AND IDT_TRANSACTION_COST IN (17, 20)
                        GROUP BY IDT_TRANSACTION_COST)
    ORDER BY UA.IDT_USER_APPLICATION
    )

    UNION ALL

SELECT *
FROM
    (--CAMPANHA
    SELECT DISTINCT
        application.IDT_SAFEPAY_USER,
        application.IDT_USER_APPLICATION,
        pm.IDT_PAYMENT_METHOD,
        'WEB' AS DES_CAPTURE_TYPE,
        pm.DES_PAYMENT_METHOD AS DES_PAYMENT_METHOD_TYPE,
        NULL AS DES_PAYMENT_PROCESSOR,
        (custom_escrow.NUM_MILLISEC_ESCROW/1000/60/60/24) AS VAL_ESCROW,
        NULL AS FLG_CONFOR_PARC,
        transacao.NUM_MIN_INSTALLMENT,
        transacao.NUM_MAX_INSTALLMENT,
        transacao.DES_COST_TYPE,
        transacao.VAL_RATE,
        campaign.DAT_START,
        campaign.DAT_EXPIRATION AS DAT_END,
        campaign.NAM_CAMPAIGN_TRADE_CONDITIONS AS NAM_CONTRACT,
        'AGREEMENT' AS DES_CONTRACT_TYPE
    FROM
        TRANSACAO
        LEFT JOIN SAFEPAY_ADM.PAYMENT_METHOD pm
            ON (transacao.COD_TRANSACTION_COST = pm.IDT_PAYMENT_METHOD)
        INNER JOIN SAFEPAY_ADM.CUST_TRADE_CONDS_COST_VAL custom_cost_value
            ON custom_cost_value.IDT_TRANSACTION_COST_VALUE = transacao.IDT_TRANSACTION_COST_VALUE
        INNER JOIN SAFEPAY_ADM.CUST_TRADE_CONDS_ESCROW conds_escrow
            ON conds_escrow.IDT_CUSTOM_TRADE_CONDITIONS = custom_cost_value.IDT_CUSTOM_TRADE_CONDITIONS
        INNER JOIN SAFEPAY_ADM.CUSTOM_ESCROW custom_escrow
            ON conds_escrow.IDT_CUSTOM_ESCROW = custom_escrow.IDT_CUSTOM_ESCROW
        INNER JOIN SAFEPAY_ADM.ESCROW escrow
            ON (custom_escrow.idt_escrow = escrow.idt_escrow AND pm.idt_payment_method = escrow.idt_payment_method)
        INNER JOIN SAFEPAY_ADM.CUSTOM_TRADE_CONDITIONS custom_conditions
            ON custom_conditions.IDT_CUSTOM_TRADE_CONDITIONS = custom_cost_value.IDT_CUSTOM_TRADE_CONDITIONS
        INNER JOIN SAFEPAY_ADM.CAMPAIGN_TRADE_CONDITIONS campaign
            ON campaign.IDT_CUSTOM_TRADE_CONDITIONS = custom_conditions.IDT_CUSTOM_TRADE_CONDITIONS
        INNER JOIN SAFEPAY_ADM.CAMPAIGN_TRADE_HIST history
            ON campaign.IDT_CAMPAIGN_TRADE_CONDITIONS = history.IDT_CAMPAIGN_TRADE_CONDITIONS
        INNER JOIN SAFEPAY_ADM.SAFEUSER_SELLER seller
            ON history.IDT_SAFEPAY_USER = seller.IDT_SAFEPAY_USER
        INNER JOIN SAFEPAY_ADM.SAFEPAY_USER su
            ON seller.IDT_SAFEPAY_USER = su.IDT_SAFEPAY_USER
        INNER JOIN SAFEPAY_ADM.USER_APPLICATION application
            ON su.IDT_SAFEPAY_USER = application.IDT_SAFEPAY_USER AND application.FLG_DEFAULT = 1
    WHERE
        application.IDT_SAFEPAY_USER = :SAFEPAY_USER
        AND (history.DAT_SUBSCRIPTION < to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (history.DAT_RELEASE IS NULL OR history.DAT_RELEASE > to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (campaign.NAM_CAMPAIGN_TRADE_CONDITIONS NOT IN ('plano-14', 'plano-30', 'plano-14-new', 'plano-30-new')
            OR (campaign.NAM_CAMPAIGN_TRADE_CONDITIONS in ('plano-14', 'plano-30', 'plano-14-new', 'plano-30-new')
            AND 0 = (SELECT COUNT (*)
                    FROM TRANSACAO
                          LEFT JOIN SAFEPAY_ADM.PAYMENT_METHOD pm ON (transacao.COD_TRANSACTION_COST = pm.IDT_PAYMENT_METHOD)
                          INNER JOIN SAFEPAY_ADM.ESCROW e ON (pm.IDT_PAYMENT_METHOD = e.IDT_PAYMENT_METHOD  AND transacao.IND_CHANNEL = e.IND_CHANNEL)
                          LEFT JOIN SAFEPAY_ADM.SAFESELL_ESCROW se ON (e.IDT_ESCROW = se.IDT_ESCROW AND transacao.IDT_USER_APPLICATION = se.IDT_USER_APPLICATION))))
    ORDER BY
        DES_PAYMENT_METHOD_TYPE,
        transacao.DES_COST_TYPE,
        transacao.NUM_MIN_INSTALLMENT
  )

    UNION ALL

SELECT *
FROM
  (--CUSTOMIZADO
    SELECT DISTINCT
        transacao_custom.IDT_SAFEPAY_USER,
        transacao_custom.IDT_USER_APPLICATION,
        pm.IDT_PAYMENT_METHOD,
        transacao_custom.DES_CAPTURE_TYPE,
        pm.DES_PAYMENT_METHOD AS DES_PAYMENT_METHOD_TYPE,
        transacao_custom.DES_PAYMENT_PROCESSOR,
        (se.NUM_MILLISEC_ESCROW/1000/60/60/24) AS VAL_ESCROW,
        transacao_custom.FLG_CONFOR_PARC,
        transacao_custom.NUM_MIN_INSTALLMENT,
        transacao_custom.NUM_MAX_INSTALLMENT,
        transacao_custom.DES_COST_TYPE,
        transacao_custom.VAL_RATE,
        transacao_custom.DAT_START,
        transacao_custom.DAT_END,
        'CUSTOM' AS NAM_CONTRACT,
        'CUSTOM' AS DES_CONTRACT_TYPE

    FROM
        TRANSACAO_CUSTOM
        LEFT JOIN SAFEPAY_ADM.PAYMENT_METHOD pm ON (transacao_custom.COD_TRANSACTION_COST = pm.IDT_PAYMENT_METHOD)
        INNER JOIN SAFEPAY_ADM.ESCROW e ON (pm.IDT_PAYMENT_METHOD = e.IDT_PAYMENT_METHOD  AND transacao_custom.IND_CHANNEL = e.IND_CHANNEL)
        LEFT JOIN SAFEPAY_ADM.SAFESELL_ESCROW se ON (e.IDT_ESCROW = se.IDT_ESCROW AND transacao_custom.IDT_USER_APPLICATION = se.IDT_USER_APPLICATION)
    WHERE
        transacao_custom.IDT_SAFEPAY_USER = :SAFEPAY_USER
        AND (transacao_custom.DAT_START IS NULL OR transacao_custom.DAT_START <= to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (transacao_custom.DAT_END IS NULL OR transacao_custom.DAT_END > to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (transacao_custom.DAT_LOG <= to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        --AND transacao.FLG_ACTIVE = 1
    ORDER BY
        pm.DES_PAYMENT_METHOD,
        transacao_custom.DES_COST_TYPE,
        transacao_custom.NUM_MIN_INSTALLMENT
  )

  UNION ALL

SELECT *
FROM
  (--DEFAULT
    SELECT DISTINCT
        NULL AS IDT_SAFEPAY_USER,
        NULL AS IDT_USER_APPLICATION,
        pm.IDT_PAYMENT_METHOD,
        transacao.DES_CAPTURE_TYPE,
        pm.DES_PAYMENT_METHOD AS DES_PAYMENT_METHOD_TYPE,
        transacao.DES_PAYMENT_PROCESSOR,
        (ed.NUM_MILLISEC_ESCROW/1000/60/60/24) AS VAL_ESCROW,
        transacao.FLG_CONFOR_PARC,
        transacao.NUM_MIN_INSTALLMENT,
        transacao.NUM_MAX_INSTALLMENT,
        transacao.DES_COST_TYPE,
        transacao.VAL_RATE,
        transacao.DAT_START,
        transacao.DAT_END,
        'DEFAULT' AS NAM_CONTRACT,
        'SYSTEM' AS DES_CONTRACT_TYPE
    FROM
        TRANSACAO
        LEFT JOIN SAFEPAY_ADM.PAYMENT_METHOD pm ON (transacao.COD_TRANSACTION_COST = pm.IDT_PAYMENT_METHOD)
        INNER JOIN SAFEPAY_ADM.ESCROW e ON (pm.IDT_PAYMENT_METHOD = e.IDT_PAYMENT_METHOD  AND transacao.IND_CHANNEL = e.IND_CHANNEL)
        INNER JOIN SAFEPAY_ADM.ESCROW_DEFAULT ed ON (e.IDT_ESCROW = ed.IDT_ESCROW)
    WHERE
        transacao.IDT_USER_APPLICATION IS NULL
        AND transacao.IDT_SAFEPAY_USER IS NULL
        AND (transacao.DAT_START IS NULL OR transacao.DAT_START < to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (transacao.DAT_END IS NULL OR transacao.DAT_END > to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND transacao.FLG_ACTIVE = 1
        AND (ed.DAT_START IS NULL OR ed.DAT_START < to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND (ed.DAT_END IS NULL OR ed.DAT_END > to_date(:DATA, 'yyyy-mm-dd hh24:mi:ss'))
        AND transacao.IND_ORIGIN = 'A'
    ORDER BY
        pm.DES_PAYMENT_METHOD,
        transacao.DES_COST_TYPE,
        transacao.NUM_MIN_INSTALLMENT
  )
;




