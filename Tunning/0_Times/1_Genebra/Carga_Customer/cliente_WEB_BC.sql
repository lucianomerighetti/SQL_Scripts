select ua.IDT_USER_APPLICATION
from SAFEPAY_ADM.USER_APPLICATION ua
left join SELLPAYM_RELEASE_OPTION sro on 
ua.IDT_USER_APPLICATION = sro.IDT_USER_APPLICATION
where (sro.IND_RELEASE_TYPE = 'U' OR sro.IDT_SELLPAYM_RELEASE_OPTION is null) 
and ua.FLG_DEFAULT = 1;