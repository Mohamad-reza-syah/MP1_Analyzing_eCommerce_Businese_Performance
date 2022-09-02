--- TASK 3
-- 1
-- Revenue per tahun (orders, customers, & orders_items)
SELECT 
	DATE_PART('year', o.order_purchase_timestamp) AS year,
	SUM(oi.price + oi.freight_value) revenue
FROM orders o
JOIN orders_items oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;


-- 2
-- Menghitung jumlah canceled order pertahunnya 
SELECT 
	DATE_PART('year', o.order_purchase_timestamp) AS year,
	COUNT(o.order_id) canceled
FROM orders o
JOIN orders_items oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'canceled'
GROUP BY 1
ORDER BY 1;



-- 3
-- Nama produk dan diurutkan berdasarkan revenue terbesar
SELECT 
	rev.year,
	MAX(product_category_name) AS nama_product
FROM (
	SELECT 
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		SUM(oi.price + oi.freight_value) revenue,
		oi.product_id AS rev_id
	FROM orders o
	JOIN orders_items oi
	ON o.order_id = oi.order_id
	WHERE o.order_status = 'delivered'
	GROUP BY 1,3
	ORDER BY 2
) AS rev
JOIN product pr
ON rev.rev_id = pr.product_id
GROUP BY 1
ORDER BY 1;


-- 4
-- Nama produk dan diurutkan berdasarkan canceled terbesar
SELECT 
	can.year,
	MAX(product_category_name) AS canceled_product
FROM (
	SELECT 
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		COUNT(o.order_id) canceled,
		oi.product_id AS can_id
	FROM orders o
	JOIN orders_items oi
	ON o.order_id = oi.order_id
	WHERE o.order_status = 'canceled'
	GROUP BY 1,3
	ORDER BY 1
) AS can
JOIN product pr
ON can.can_id = pr.product_id
GROUP BY 1
ORDER BY 1;

