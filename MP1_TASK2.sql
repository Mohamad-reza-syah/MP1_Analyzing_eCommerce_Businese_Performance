--- TASK 2
-- 1
-- Rata-rata Monthly Active User (MAU) per tahun
WITH mau AS(
	SELECT 	
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		DATE_PART('month', o.order_purchase_timestamp) AS month,
		COUNT(DISTINCT cs.customer_unique_id) AS total
	FROM
		orders o
	JOIN
		customers cs
	ON
		o.customer_id = cs.customer_id
	GROUP BY 1,2
)

SELECT 
	mau.year, 
	round(AVG(total),2) AS rata
FROM mau
GROUP BY 1;


-- 2 
-- Jumlah Customer baru pertahun
WITH tcos AS(
	SELECT 	
		MIN(DATE_PART('year', o.order_purchase_timestamp)) AS year,
		cs.customer_unique_id AS total_cus
	FROM
		orders o
	JOIN
		customers cs
	ON
		o.customer_id = cs.customer_id
	GROUP BY 2
)


SELECT
	tcos.year,
	COUNT(DISTINCT tcos.total_cus) AS jumlah_cos
FROM tcos
GROUP BY 1;
	

-- 3 
-- Jumlah Customer yang melakukan repeat order pertahun
WITH tcos AS(
	SELECT 	
		MIN(DATE_PART('year', o.order_purchase_timestamp)) AS year,
		cs.customer_id AS total_cus
	FROM
		orders o
	JOIN
		customers cs
	ON
		o.customer_id = cs.customer_id
	GROUP BY 2
)

SELECT
	tcos.year,
	COUNT(tcos.total_cus) AS customer_repeat
FROM tcos
GROUP BY 1
HAVING COUNT(tcos.total_cus) > 1
ORDER BY 1;

-- 4
-- Rata-rata Frekuensi order per tahun
WITH fre AS(
	SELECT 	
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		COUNT(cs.customer_id) AS total
	FROM
		orders o
	JOIN
		customers cs
	ON
		o.customer_id = cs.customer_id
	GROUP BY 1
)

SELECT 
	fre.year, 
	round(AVG(total),2) AS rata
FROM fre
GROUP BY 1;

-- 5 Gabungan


