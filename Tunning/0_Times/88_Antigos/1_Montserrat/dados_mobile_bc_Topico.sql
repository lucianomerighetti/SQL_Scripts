select x.PLAN_CLIENT_ID,
       x.CLIENT_ID,
       x.CONTRACT_ID,
       x.CONTRACT_NAME,    
	   x.CONTRACT_CHANNEL,    
       x.CONTRACT_TYPE,
       x.PLAN_ID,
       x.PLAN_DAT_START,
       x.PLAN_DAT_END,
	   x.PLAN_CAPTURE,    
       x.PLAN_PAYMENT_METHOD,    
       x.PLAN_TYPE,    
       x.PLAN_INSTL_TYPE,    
	   x.PLAN_PAYMENT_PROCESSOR,    
       x.PLAN_ESCROW_TYPE,
       x.PLAN_ESCROW_VALUE,
     
case when max(x.COST_INTM_FEE_1) not in (-2,-1) then max(x.COST_INTM_FEE_1) else 'null' end AS COST_INTM_FEE_1,
case when max(x.COST_INTM_FEE_2) not in (-2,-1) then max(x.COST_INTM_FEE_2) else 'null' end AS COST_INTM_FEE_2,
case when max(x.COST_INTM_FEE_3) not in (-2,-1) then max(x.COST_INTM_FEE_3) else 'null' end AS COST_INTM_FEE_3,
case when max(x.COST_INTM_FEE_4) not in (-2,-1) then max(x.COST_INTM_FEE_4) else 'null' end AS COST_INTM_FEE_4,
case when max(x.COST_INTM_FEE_5) not in (-2,-1) then max(x.COST_INTM_FEE_5) else 'null' end AS COST_INTM_FEE_5,
case when max(x.COST_INTM_FEE_6) not in (-2,-1) then max(x.COST_INTM_FEE_6) else 'null' end AS COST_INTM_FEE_6,
case when max(x.COST_INTM_FEE_7) not in (-2,-1) then max(x.COST_INTM_FEE_7) else 'null' end AS COST_INTM_FEE_7,
case when max(x.COST_INTM_FEE_8) not in (-2,-1) then max(x.COST_INTM_FEE_8) else 'null' end AS COST_INTM_FEE_8,
case when max(x.COST_INTM_FEE_9) not in (-2,-1) then max(x.COST_INTM_FEE_9) else 'null' end AS COST_INTM_FEE_9,
case when max(x.COST_INTM_FEE_10) not in (-2,-1) then max(x.COST_INTM_FEE_10) else 'null' end AS COST_INTM_FEE_10,
case when max(x.COST_INTM_FEE_11) not in (-2,-1) then max(x.COST_INTM_FEE_11) else 'null' end AS COST_INTM_FEE_11,
case when max(x.COST_INTM_FEE_12) not in (-2,-1) then max(x.COST_INTM_FEE_12) else 'null' end AS COST_INTM_FEE_12,
case when max(x.COST_INTM_FEE_13) not in (-2,-1) then max(x.COST_INTM_FEE_13) else 'null' end AS COST_INTM_FEE_13,
case when max(x.COST_INTM_FEE_14) not in (-2,-1) then max(x.COST_INTM_FEE_14) else 'null' end AS COST_INTM_FEE_14,
case when max(x.COST_INTM_FEE_15) not in (-2,-1) then max(x.COST_INTM_FEE_15) else 'null' end AS COST_INTM_FEE_15,
case when max(x.COST_INTM_FEE_16) not in (-2,-1) then max(x.COST_INTM_FEE_16) else 'null' end AS COST_INTM_FEE_16,
case when max(x.COST_INTM_FEE_17) not in (-2,-1) then max(x.COST_INTM_FEE_17) else 'null' end AS COST_INTM_FEE_17,
case when max(x.COST_INTM_FEE_18) not in (-2,-1) then max(x.COST_INTM_FEE_18) else 'null' end AS COST_INTM_FEE_18,
case when max(x.COST_INTM_RATE_1) not in (-2,-1) then max(x.COST_INTM_RATE_1) else 'null' end AS COST_INTM_RATE_1,
case when max(x.COST_INTM_RATE_2) not in (-2,-1) then max(x.COST_INTM_RATE_2) else 'null' end AS COST_INTM_RATE_2,
case when max(x.COST_INTM_RATE_3) not in (-2,-1) then max(x.COST_INTM_RATE_3) else 'null' end AS COST_INTM_RATE_3,
case when max(x.COST_INTM_RATE_4) not in (-2,-1) then max(x.COST_INTM_RATE_4) else 'null' end AS COST_INTM_RATE_4,
case when max(x.COST_INTM_RATE_5) not in (-2,-1) then max(x.COST_INTM_RATE_5) else 'null' end AS COST_INTM_RATE_5,
case when max(x.COST_INTM_RATE_6) not in (-2,-1) then max(x.COST_INTM_RATE_6) else 'null' end AS COST_INTM_RATE_6,
case when max(x.COST_INTM_RATE_7) not in (-2,-1) then max(x.COST_INTM_RATE_7) else 'null' end AS COST_INTM_RATE_7,
case when max(x.COST_INTM_RATE_8) not in (-2,-1) then max(x.COST_INTM_RATE_8) else 'null' end AS COST_INTM_RATE_8,
case when max(x.COST_INTM_RATE_9) not in (-2,-1) then max(x.COST_INTM_RATE_9) else 'null' end AS COST_INTM_RATE_9,
case when max(x.COST_INTM_RATE_10) not in (-2,-1) then max(x.COST_INTM_RATE_10) else 'null' end AS COST_INTM_RATE_10,
case when max(x.COST_INTM_RATE_11) not in (-2,-1) then max(x.COST_INTM_RATE_11) else 'null' end AS COST_INTM_RATE_11,
case when max(x.COST_INTM_RATE_12) not in (-2,-1) then max(x.COST_INTM_RATE_12) else 'null' end AS COST_INTM_RATE_12,
case when max(x.COST_INTM_RATE_13) not in (-2,-1) then max(x.COST_INTM_RATE_13) else 'null' end AS COST_INTM_RATE_13,
case when max(x.COST_INTM_RATE_14) not in (-2,-1) then max(x.COST_INTM_RATE_14) else 'null' end AS COST_INTM_RATE_14,
case when max(x.COST_INTM_RATE_15) not in (-2,-1) then max(x.COST_INTM_RATE_15) else 'null' end AS COST_INTM_RATE_15,
case when max(x.COST_INTM_RATE_16) not in (-2,-1) then max(x.COST_INTM_RATE_16) else 'null' end AS COST_INTM_RATE_16,
case when max(x.COST_INTM_RATE_17) not in (-2,-1) then max(x.COST_INTM_RATE_17) else 'null' end AS COST_INTM_RATE_17,
case when max(x.COST_INTM_RATE_18) not in (-2,-1) then max(x.COST_INTM_RATE_18) else 'null' end AS COST_INTM_RATE_18,
case when max(x.COST_INSTL_RATE_DEBT_1) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_1) else 'null' end AS COST_INSTL_RATE_DEBT_1,
case when max(x.COST_INSTL_RATE_DEBT_2) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_2) else 'null' end AS COST_INSTL_RATE_DEBT_2,
case when max(x.COST_INSTL_RATE_DEBT_3) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_3) else 'null' end AS COST_INSTL_RATE_DEBT_3,
case when max(x.COST_INSTL_RATE_DEBT_4) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_4) else 'null' end AS COST_INSTL_RATE_DEBT_4,
case when max(x.COST_INSTL_RATE_DEBT_5) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_5) else 'null' end AS COST_INSTL_RATE_DEBT_5,
case when max(x.COST_INSTL_RATE_DEBT_6) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_6) else 'null' end AS COST_INSTL_RATE_DEBT_6,
case when max(x.COST_INSTL_RATE_DEBT_7) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_7) else 'null' end AS COST_INSTL_RATE_DEBT_7,
case when max(x.COST_INSTL_RATE_DEBT_8) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_8) else 'null' end AS COST_INSTL_RATE_DEBT_8,
case when max(x.COST_INSTL_RATE_DEBT_9) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_9) else 'null' end AS COST_INSTL_RATE_DEBT_9,
case when max(x.COST_INSTL_RATE_DEBT_10) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_10) else 'null' end AS COST_INSTL_RATE_DEBT_10,
case when max(x.COST_INSTL_RATE_DEBT_11) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_11) else 'null' end AS COST_INSTL_RATE_DEBT_11,
case when max(x.COST_INSTL_RATE_DEBT_12) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_12) else 'null' end AS COST_INSTL_RATE_DEBT_12,
case when max(x.COST_INSTL_RATE_DEBT_13) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_13) else 'null' end AS COST_INSTL_RATE_DEBT_13,
case when max(x.COST_INSTL_RATE_DEBT_14) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_14) else 'null' end AS COST_INSTL_RATE_DEBT_14,
case when max(x.COST_INSTL_RATE_DEBT_15) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_15) else 'null' end AS COST_INSTL_RATE_DEBT_15,
case when max(x.COST_INSTL_RATE_DEBT_16) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_16) else 'null' end AS COST_INSTL_RATE_DEBT_16,
case when max(x.COST_INSTL_RATE_DEBT_17) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_17) else 'null' end AS COST_INSTL_RATE_DEBT_17,
case when max(x.COST_INSTL_RATE_DEBT_18) not in (-2,-1) then max(x.COST_INSTL_RATE_DEBT_18) else 'null' end AS COST_INSTL_RATE_DEBT_18,
case when max(x.COST_INSTL_RATE_CREDI_1) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_1) else 'null' end AS COST_INSTL_RATE_CREDI_1,
case when max(x.COST_INSTL_RATE_CREDI_2) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_2) else 'null' end AS COST_INSTL_RATE_CREDI_2,
case when max(x.COST_INSTL_RATE_CREDI_3) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_3) else 'null' end AS COST_INSTL_RATE_CREDI_3,
case when max(x.COST_INSTL_RATE_CREDI_4) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_4) else 'null' end AS COST_INSTL_RATE_CREDI_4,
case when max(x.COST_INSTL_RATE_CREDI_5) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_5) else 'null' end AS COST_INSTL_RATE_CREDI_5,
case when max(x.COST_INSTL_RATE_CREDI_6) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_6) else 'null' end AS COST_INSTL_RATE_CREDI_6,
case when max(x.COST_INSTL_RATE_CREDI_7) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_7) else 'null' end AS COST_INSTL_RATE_CREDI_7,
case when max(x.COST_INSTL_RATE_CREDI_8) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_8) else 'null' end AS COST_INSTL_RATE_CREDI_8,
case when max(x.COST_INSTL_RATE_CREDI_9) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_9) else 'null' end AS COST_INSTL_RATE_CREDI_9,
case when max(x.COST_INSTL_RATE_CREDI_10) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_10) else 'null' end AS COST_INSTL_RATE_CREDI_10,
case when max(x.COST_INSTL_RATE_CREDI_11) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_11) else 'null' end AS COST_INSTL_RATE_CREDI_11,
case when max(x.COST_INSTL_RATE_CREDI_12) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_12) else 'null' end AS COST_INSTL_RATE_CREDI_12,
case when max(x.COST_INSTL_RATE_CREDI_13) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_13) else 'null' end AS COST_INSTL_RATE_CREDI_13,
case when max(x.COST_INSTL_RATE_CREDI_14) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_14) else 'null' end AS COST_INSTL_RATE_CREDI_14,
case when max(x.COST_INSTL_RATE_CREDI_15) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_15) else 'null' end AS COST_INSTL_RATE_CREDI_15,
case when max(x.COST_INSTL_RATE_CREDI_16) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_16) else 'null' end AS COST_INSTL_RATE_CREDI_16,
case when max(x.COST_INSTL_RATE_CREDI_17) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_17) else 'null' end AS COST_INSTL_RATE_CREDI_17,
case when max(x.COST_INSTL_RATE_CREDI_18) not in (-2,-1) then max(x.COST_INSTL_RATE_CREDI_18) else 'null' end AS COST_INSTL_RATE_CREDI_18




from 
(select

    coalesce(pc.IDT_PLAN_CLIENT,'null') AS PLAN_CLIENT_ID,
    coalesce(cc.IDT_CLIENT,'null') AS CLIENT_ID,
    coalesce(c.IDT_CONTRACT,'null') AS CONTRACT_ID,
    coalesce(c.NAM_CONTRACT,'null') AS CONTRACT_NAME,    
	coalesce(cht.DES_CHANNEL_TYPE,'null') AS CONTRACT_CHANNEL,    
    coalesce(cot.DES_CONTRACT_TYPE,'null') AS CONTRACT_TYPE,
    coalesce(p.IDT_PLAN,'null') AS PLAN_ID,
    coalesce((DATE_FORMAT(pc.DAT_START, '%Y-%m-%dT%T.000Z')),'null') AS PLAN_DAT_START,
	coalesce((DATE_FORMAT(pc.DAT_END, '%Y-%m-%dT%T.000Z')),'null') AS PLAN_DAT_END,
	coalesce(ct.DES_CAPTURE_TYPE,'null') AS PLAN_CAPTURE,    
    coalesce(pmt.DES_PAYMENT_METHOD_TYPE,'null') AS PLAN_PAYMENT_METHOD,    
    coalesce(pt.DES_PLAN_TYPE,'null') AS PLAN_TYPE,    
    coalesce(it.DES_INSTALLMENT_TYPE,'null') AS PLAN_INSTL_TYPE,    
	coalesce(p.DES_PAYMENT_PROCESSOR,'null') AS PLAN_PAYMENT_PROCESSOR,    
    coalesce(rt.DES_RELEASE_TYPE,'null') AS PLAN_ESCROW_TYPE,
    coalesce(FLOOR(e.NUM_VALUE),'null') AS PLAN_ESCROW_VALUE,
    
    --
   
    co.IND_COST_TYPE,
    i.NUM_MIN_INSTALLMENT,
    i.NUM_MAX_INSTALLMENT,
    i.NUM_VALUE,
    --
    
    CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 1 AND i.NUM_MAX_INSTALLMENT >= 1 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END
    ELSE
      -1
    END AS COST_INTM_FEE_1, 
	CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 2 AND i.NUM_MAX_INSTALLMENT >= 2 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_2,
	CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 3 AND i.NUM_MAX_INSTALLMENT >= 3 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_3,
	CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 4 AND i.NUM_MAX_INSTALLMENT >= 4 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_4,
	CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 5 AND i.NUM_MAX_INSTALLMENT >= 5 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END
    ELSE
      -1
    END AS COST_INTM_FEE_5,
	CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 6 AND i.NUM_MAX_INSTALLMENT >= 6 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_6,
    CASE WHEN co.IND_COST_TYPE = 1 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 7 AND i.NUM_MAX_INSTALLMENT >= 7 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_7,
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 8 AND i.NUM_MAX_INSTALLMENT >= 8 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
          -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_8,
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 9 AND i.NUM_MAX_INSTALLMENT >= 9 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_9,
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 10 AND i.NUM_MAX_INSTALLMENT >= 10 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
          -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_10,    
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 11 AND i.NUM_MAX_INSTALLMENT >= 11 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
          -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_11,      
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 12 AND i.NUM_MAX_INSTALLMENT >= 12 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_12,      
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 13 AND i.NUM_MAX_INSTALLMENT >= 13 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_13,     
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 14 AND i.NUM_MAX_INSTALLMENT >= 14 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_14,   
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 15 AND i.NUM_MAX_INSTALLMENT >= 15 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_15,   
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 16 AND i.NUM_MAX_INSTALLMENT >= 16 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_16,   
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 17 AND i.NUM_MAX_INSTALLMENT >= 17 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_FEE_17,     
    CASE WHEN co.IND_COST_TYPE = 1 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 18 AND i.NUM_MAX_INSTALLMENT >= 18 THEN
          coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END
    ELSE
      -1
    END AS COST_INTM_FEE_18,
	CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 1 AND i.NUM_MAX_INSTALLMENT >= 1 THEN
          coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_1, 
	CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 2 AND i.NUM_MAX_INSTALLMENT >= 2 THEN
          coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_2,
	CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 3 AND i.NUM_MAX_INSTALLMENT >= 3 THEN
          coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_3,
	CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 4 AND i.NUM_MAX_INSTALLMENT >= 4 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_4,
	CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 5 AND i.NUM_MAX_INSTALLMENT >= 5 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_5,
	CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 6 AND i.NUM_MAX_INSTALLMENT >= 6 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_6,
    CASE WHEN co.IND_COST_TYPE = 2 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 7 AND i.NUM_MAX_INSTALLMENT >= 7 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_7,
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 8 AND i.NUM_MAX_INSTALLMENT >= 8 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_8,
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 9 AND i.NUM_MAX_INSTALLMENT >= 9 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_9,
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 10 AND i.NUM_MAX_INSTALLMENT >= 10 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_10,    
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 11 AND i.NUM_MAX_INSTALLMENT >= 11 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_11,      
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 12 AND i.NUM_MAX_INSTALLMENT >= 12 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_12,      
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 13 AND i.NUM_MAX_INSTALLMENT >= 13 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_13,     
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 14 AND i.NUM_MAX_INSTALLMENT >= 14 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_14,   
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 15 AND i.NUM_MAX_INSTALLMENT >= 15 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_15,   
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 16 AND i.NUM_MAX_INSTALLMENT >= 16 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
     -1
    END AS COST_INTM_RATE_16,   
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 17 AND i.NUM_MAX_INSTALLMENT >= 17 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_17,     
    CASE WHEN co.IND_COST_TYPE = 2 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 18 AND i.NUM_MAX_INSTALLMENT >= 18 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INTM_RATE_18,
	CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 1 AND i.NUM_MAX_INSTALLMENT >= 1 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_1, 
	CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 2 AND i.NUM_MAX_INSTALLMENT >= 2 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_2,
	CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 3 AND i.NUM_MAX_INSTALLMENT >= 3 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_3,
	CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 4 AND i.NUM_MAX_INSTALLMENT >= 4 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_4,
	CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 5 AND i.NUM_MAX_INSTALLMENT >= 5 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_5,
	CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 6 AND i.NUM_MAX_INSTALLMENT >= 6 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_6,
    CASE WHEN co.IND_COST_TYPE = 3 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 7 AND i.NUM_MAX_INSTALLMENT >= 7 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_7,
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 8 AND i.NUM_MAX_INSTALLMENT >= 8 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_8,
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 9 AND i.NUM_MAX_INSTALLMENT >= 9 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_9,
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 10 AND i.NUM_MAX_INSTALLMENT >= 10 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_10,    
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 11 AND i.NUM_MAX_INSTALLMENT >= 11 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_11,      
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 12 AND i.NUM_MAX_INSTALLMENT >= 12 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_12,      
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 13 AND i.NUM_MAX_INSTALLMENT >= 13 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_13,     
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 14 AND i.NUM_MAX_INSTALLMENT >= 14 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_14,   
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 15 AND i.NUM_MAX_INSTALLMENT >= 15 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_15,   
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 16 AND i.NUM_MAX_INSTALLMENT >= 16 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_16,   
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 17 AND i.NUM_MAX_INSTALLMENT >= 17 THEN
          coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_17,     
    CASE WHEN co.IND_COST_TYPE = 3 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 18 AND i.NUM_MAX_INSTALLMENT >= 18 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_DEBT_18,     
	CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 1 AND i.NUM_MAX_INSTALLMENT >= 1 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_1, 
	CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 2 AND i.NUM_MAX_INSTALLMENT >= 2 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_2,
	CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 3 AND i.NUM_MAX_INSTALLMENT >= 3 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_3,
	CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 4 AND i.NUM_MAX_INSTALLMENT >= 4 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_4,
	CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 5 AND i.NUM_MAX_INSTALLMENT >= 5 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_5,
	CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 6 AND i.NUM_MAX_INSTALLMENT >= 6 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_6,
    CASE WHEN co.IND_COST_TYPE = 4 THEN
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 7 AND i.NUM_MAX_INSTALLMENT >= 7 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_7,
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 8 AND i.NUM_MAX_INSTALLMENT >= 8 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_8,
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 9 AND i.NUM_MAX_INSTALLMENT >= 9 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_9,
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 10 AND i.NUM_MAX_INSTALLMENT >= 10 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_10,    
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 11 AND i.NUM_MAX_INSTALLMENT >= 11 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_11,      
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 12 AND i.NUM_MAX_INSTALLMENT >= 12 THEN
         coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
         -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_12,      
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 13 AND i.NUM_MAX_INSTALLMENT >= 13 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_13,     
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 14 AND i.NUM_MAX_INSTALLMENT >= 14 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_14,   
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 15 AND i.NUM_MAX_INSTALLMENT >= 15 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_15,   
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 16 AND i.NUM_MAX_INSTALLMENT >= 16 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_16,   
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 17 AND i.NUM_MAX_INSTALLMENT >= 17 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_17,     
    CASE WHEN co.IND_COST_TYPE = 4 THEN    
      CASE WHEN i.NUM_MIN_INSTALLMENT <= 18 AND i.NUM_MAX_INSTALLMENT >= 18 THEN
        coalesce(FLOOR(i.NUM_VALUE * 100),0)
	  ELSE
        -2
      END  
    ELSE
      -1
    END AS COST_INSTL_RATE_CREDI_18  
  
  from business_condition.contract_client cc
  join business_condition.contract c on c.IDT_CONTRACT = cc.IDT_CONTRACT
  join business_condition.contract_type cot on cot.IND_CONTRACT_TYPE = c.IND_CONTRACT_TYPE
  join business_condition.channel_type cht on cht.IND_CHANNEL_TYPE = c.IND_CHANNEL_TYPE
  join business_condition.plan_client pc on pc.IDT_CONTRACT_CLIENT = cc.IDT_CONTRACT_CLIENT
  join business_condition.plan p on p.IDT_PLAN = pc.IDT_PLAN
  left join business_condition.plan_type pt on pt.IND_PLAN_TYPE = p.IND_PLAN_TYPE
  left join business_condition.escrow e on e.IDT_ESCROW = p.IDT_ESCROW
  left join business_condition.capture_type ct on ct.IND_CAPTURE_TYPE = p.IND_CAPTURE_TYPE
  left join business_condition.payment_method_type pmt on pmt.IND_PAYMENT_METHOD_TYPE = p.IND_PAYMENT_METHOD_TYPE
  left join business_condition.cost co on co.idt_plan = pc.idt_plan
  join business_condition.cost_type ctt on ctt.IND_COST_TYPE = co.IND_COST_TYPE
  left join business_condition.installment i on i.IDT_COST = co.IDT_COST
  left join business_condition.release_type rt on rt.IND_RELEASE_TYPE = e.IND_RELEASE_TYPE
  left join business_condition.installment_type it on it.IND_INSTALLMENT_TYPE = p.IND_INSTALLMENT_TYPE
-- novos
where  1 = 1 

--  and pc.dat_creation = pc.dat_update
  
--  and pc.dat_update >= '2019-01-10 00:00:00'
--  and pc.dat_update <= '2019-01-10 23:59:59' 
  
  and cc.idt_client = 9999998
  and cht.DES_CHANNEL_TYPE = 'MOBILE'

) x

  GROUP BY x.PLAN_CLIENT_ID,
       x.CLIENT_ID,
       x.CONTRACT_ID,
       x.CONTRACT_NAME,    
	   x.CONTRACT_CHANNEL,    
       x.CONTRACT_TYPE,
       x.PLAN_ID,
       x.PLAN_DAT_START,
	   x.PLAN_DAT_END,
	   x.PLAN_CAPTURE,    
       x.PLAN_PAYMENT_METHOD,    
       x.PLAN_TYPE,    
       x.PLAN_INSTL_TYPE,    
	   x.PLAN_PAYMENT_PROCESSOR,    
       x.PLAN_ESCROW_TYPE,
       x.PLAN_ESCROW_VALUE
       
       