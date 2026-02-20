-- Product performance & pricing validation

SELECT
  sku,
  SUM(revenue) AS revenue,
  SUM(cogs) AS cogs,
  SUM(revenue - cogs) AS gross_profit,
  ROUND(1.0*SUM(revenue - cogs)/NULLIF(SUM(revenue),0),4) AS margin_pct
FROM sales_daily_sku
WHERE date >= DATE('now','-30 day')
GROUP BY sku
ORDER BY gross_profit DESC
LIMIT 25;

WITH latest AS (SELECT MAX(week_start) AS w FROM inventory_weekly)
SELECT sku, estimated_lost_sales
FROM inventory_weekly
WHERE week_start=(SELECT w FROM latest)
  AND is_stockout=1
ORDER BY estimated_lost_sales DESC;
