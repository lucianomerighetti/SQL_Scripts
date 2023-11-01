CREATE INDEX CONCURRENTLY nonexist_recovery_idempotency_idx01
ON cip_liquidator_adm.nonexist_recovery_idempotency
(date_trunc('day',dat_creation)) tablespace tsicipliquidator01;
