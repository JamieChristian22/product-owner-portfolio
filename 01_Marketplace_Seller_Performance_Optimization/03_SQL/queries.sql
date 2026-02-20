-- Marketplace KPI validation (SQLite-ish)

WITH o AS (
  SELECT sku,
         SUM(gross_revenue) AS gross_revenue,
         SUM(marketplace_fees) AS fees,
         SUM(cogs) AS cogs,
         SUM(shipping_cost) AS shipping
  FROM orders_daily
  WHERE order_date >= DATE('now','-30 day')
  GROUP BY sku
)
SELECT
  sku,
  gross_revenue,
  (gross_revenue - fees) AS net_revenue,
  (gross_revenue - fees - cogs - shipping) AS contribution_margin
FROM o
ORDER BY contribution_margin DESC;

SELECT
  campaign_type,
  SUM(ad_spend) AS spend,
  SUM(ad_revenue) AS revenue,
  ROUND(SUM(ad_spend)/NULLIF(SUM(ad_revenue),0),4) AS acos,
  ROUND(SUM(ad_revenue)/NULLIF(SUM(ad_spend),0),4) AS roas
FROM ads_performance
GROUP BY campaign_type;
