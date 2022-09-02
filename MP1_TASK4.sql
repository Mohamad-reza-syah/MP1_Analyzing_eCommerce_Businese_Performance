-- TASK 4
-- Jumlah Pengguna untuk masing-masing tipe pembayaran setiap tahun (orders_payments, orders, customer)
SELECT 
	DATE_PART('year', o.order_purchase_timestamp) AS year,
	op.payment_type,
	COUNT(DISTINCT o.customer_id)
FROM orders o
JOIN orders_payments op
ON o.order_id = op.order_id
GROUP BY 1,2
ORDER BY 3 DESC;


--- Percobaan Pivot
SELECT 
	src.year,
	[voucher],
	[debit_card],
	[credit_card],
	[boleto],
	[not_defined]
FROM(
	SELECT
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		op.payment_type,
		COUNT(DISTINCT o.customer_id) AS total
	FROM orders o
	JOIN orders_payments op
	ON o.order_id = op.order_id
	GROUP BY 1,2
) src
PIVOT(
	SUM(src.total)
	FOR [src.payment_type] 
	IN ([voucher],
	[debit_card,]
	[credit_card],
	[boleto],
	[not_defined])
) Pvt


delivered
shipped
unavailable


SELECT
	*
FROM(
	SELECT 
		DATE_PART('year', o.order_purchase_timestamp) AS year,
		order_status,
		COUNT(order_id) AS total
	FROM orders
	GROUP BY 1
) s
PIVOT (
	SUM(total)
	FOR order_status IN (
		[delivered],
		[shipped],
		[unavailable])
) AS pvt;



-- Kunci 
with 
tmp as (
select 
	date_part('year', o.order_purchase_timestamp) as year,
	op.payment_type,
	count(1) as num_used
from orders_payments op 
join orders o on o.order_id = op.order_id
group by 1, 2
) 

select *,
	case when year_2017 = 0 then NULL
		else round((year_2018 - year_2017) / year_2017, 2)
	end as pct_change_2017_2018
from (
select 
  payment_type,
  sum(case when year = '2016' then num_used else 0 end) as year_2016,
  sum(case when year = '2017' then num_used else 0 end) as year_2017,
  sum(case when year = '2018' then num_used else 0 end) as year_2018
from tmp 
group by 1) subq
order by 5 desc
