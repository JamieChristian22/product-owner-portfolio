-- Experiment lift + guardrails validation

WITH base AS (
  SELECT experiment_id, variant,
         SUM(purchases) AS purchases,
         SUM(sessions) AS sessions,
         1.0*SUM(purchases)/NULLIF(SUM(sessions),0) AS conversion_rate
  FROM experiment_daily_metrics
  GROUP BY experiment_id, variant
)
SELECT
  experiment_id,
  MAX(CASE WHEN variant='Control' THEN conversion_rate END) AS control_cr,
  MAX(CASE WHEN variant='Treatment' THEN conversion_rate END) AS treatment_cr,
  ROUND((MAX(CASE WHEN variant='Treatment' THEN conversion_rate END) /
        NULLIF(MAX(CASE WHEN variant='Control' THEN conversion_rate END),0)) - 1, 5) AS lift_pct
FROM base
GROUP BY experiment_id;

SELECT experiment_id, variant,
       ROUND(AVG(refund_rate),4) AS avg_refund_rate,
       ROUND(AVG(session_latency_ms),0) AS avg_latency_ms
FROM experiment_daily_metrics
GROUP BY experiment_id, variant;
