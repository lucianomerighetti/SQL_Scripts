select
    cc.IDT_CLIENT,
	cht.DES_CHANNEL_TYPE,
    c.NAM_CONTRACT,
    cot.DES_CONTRACT_TYPE,
    pc.DAT_START,
	pc.DAT_END,
    pc.FLG_ACTIVE,
	ct.DES_CAPTURE_TYPE,
    pmt.DES_PAYMENT_METHOD_TYPE,
	p.DES_PAYMENT_PROCESSOR,
    pt.DES_PLAN_TYPE,
    e.NUM_VALUE as 'VAL_ESCROW',
    case when e.IND_RELEASE_TYPE = 2 then 1 else 0 end as 'FLG_CONFOR_PARC',
	pc.DAT_UPDATE,
	pc.NAM_CHANGE_AGENT, 
    --
    pc.idt_plan,
    i.COD_INSTALLMENT,
    i.NUM_MIN_INSTALLMENT as 'RANGE_MIN_INSTALLMENT',
    i.NUM_MAX_INSTALLMENT as 'RANGE_MAX_INSTALLMENT',
    ctt.DES_COST_TYPE,
    case when co.IND_COST_TYPE = 1 then i.NUM_VALUE end as 'VAL_FEE',
    case when co.IND_COST_TYPE <> 1 then i.NUM_VALUE end as 'VAL_RATE'
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
  -- 
  left join business_condition.cost co on co.idt_plan = pc.idt_plan
  join business_condition.cost_type ctt on ctt.IND_COST_TYPE = co.IND_COST_TYPE
  join business_condition.installment i on i.IDT_COST = co.IDT_COST
 where cc.IDT_CLIENT = 11150461