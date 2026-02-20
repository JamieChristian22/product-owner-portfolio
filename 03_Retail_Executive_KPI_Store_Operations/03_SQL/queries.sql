-- Retail KPI validation

SELECT
  s.store_id,
  SUM(s.net_sales) AS net_sales,
  SUM(l.labor_hours) AS labor_hours,
  ROUND(SUM(s.net_sales)/NULLIF(SUM(l.labor_hours),0),2) AS sales_per_labor_hour
FROM store_sales_daily s
JOIN labor_daily l ON s.date=l.date AND s.store_id=l.store_id
WHERE s.date >= DATE('now','-7 day')
GROUP BY s.store_id
ORDER BY sales_per_labor_hour DESC;

SELECT week_end, ROUND(AVG(nps_score),1) AS avg_nps
FROM nps_weekly
GROUP BY week_end
ORDER BY week_end;
