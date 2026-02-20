-- Funnel & retention validation

SELECT
  channel, device,
  SUM(sessions) AS sessions,
  SUM(add_to_cart) AS add_to_cart,
  SUM(checkout_start) AS checkout_start,
  SUM(purchases) AS purchases,
  ROUND(1.0*SUM(add_to_cart)/NULLIF(SUM(sessions),0),4) AS add_to_cart_rate,
  ROUND(1.0*SUM(checkout_start)/NULLIF(SUM(add_to_cart),0),4) AS checkout_start_rate,
  ROUND(1.0*SUM(purchases)/NULLIF(SUM(checkout_start),0),4) AS purchase_conversion
FROM sessions_funnel_daily
WHERE date >= DATE('now','-14 day')
GROUP BY channel, device
ORDER BY purchases DESC;

SELECT DATE(order_date) AS d, COUNT(*) AS orders, ROUND(AVG(order_total),2) AS aov
FROM orders
GROUP BY DATE(order_date)
ORDER BY d;
