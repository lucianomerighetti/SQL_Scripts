SELECT USERNAME
,SERVICE_NAME
,STATUS
,COUNT(*) QTDE_CONEXAO
,MAX(LAST_CALL_ET) TEMP_CONEXAO_EM_SEG
FROM GV$SESSION
WHERE USERNAME NOT IN ('SYS')
GROUP BY USERNAME
,SERVICE_NAME
,STATUS
ORDER BY SERVICE_NAME
,STATUS 
,USERNAME
