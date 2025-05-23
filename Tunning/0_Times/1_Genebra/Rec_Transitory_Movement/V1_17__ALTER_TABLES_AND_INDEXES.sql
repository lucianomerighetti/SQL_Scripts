ALTER TABLE RECTRANSITORYMOVEMENT_ADM.ADVANCE_COST_HISTORY INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.FEE INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.PAYMENT_GROUP INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_STATUS INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_UNIT_STATUS INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.AMOUNT_SUMMARY INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.PAYMENT INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.RECEIVABLE INITRANS 64 PCTFREE 20;
ALTER TABLE RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_UNIT INITRANS 64 PCTFREE 20;

ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_UNIT_UK01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.PAYMENT_UK01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_UK01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.AMOUNT_SUMMARY_UK01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_UNIT_STATUS_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.PAYMENT_GROUP_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_UNIT_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_STATUS_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.PAYMENT_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.RECEIVABLE_IDX01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.AMOUNT_SUMMARY_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.AMOUNT_SUMMARY_IDX01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.FEE_PK INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.FEE_IDX01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.FEE_UK01 INITRANS 48;
ALTER INDEX RECTRANSITORYMOVEMENT_ADM.ADVANCE_COST_HISTORY_PK INITRANS 48;

alter index RECTRANSITORYMOVEMENT_ADM.schema_version_pk move tablespace TSIRECTRANSITORYMOVEMENT01;
alter index RECTRANSITORYMOVEMENT_ADM.schema_version_s_idx move tablespace TSIRECTRANSITORYMOVEMENT01;