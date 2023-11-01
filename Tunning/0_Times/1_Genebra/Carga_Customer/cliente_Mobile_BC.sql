  select
    cc.IDT_CLIENT as IDT_USER_APPLICATION
  from business_condition.contract_client cc
  join business_condition.contract c on c.IDT_CONTRACT = cc.IDT_CONTRACT
  join business_condition.plan_client pc on pc.IDT_CONTRACT_CLIENT = cc.IDT_CONTRACT_CLIENT
  join business_condition.plan p on p.IDT_PLAN = pc.IDT_PLAN
  left join business_condition.escrow e on e.IDT_ESCROW = p.IDT_ESCROW
  where e.IND_RELEASE_TYPE = 1;
  