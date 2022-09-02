CREATE TABLE product (
	product_ind INT,
	product_id VARCHAR,
	product_category_name VARCHAR,
	product_name_lenght REAL,
	product_description_lenght REAL,
	product_photos_qty REAL,
	product_weight_g REAL,
	product_length_cm REAL,
	product_height_cm REAL,
	product_width_cm REAL
);

ALTER TABLE product
ADD PRIMARY KEY (product_id);

COPY product (
	product_ind,
	product_id,
	product_category_name,
	product_name_lenght,
	product_description_lenght,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\product_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE geolocation (
	geolocation_zip_code_prefix INT,
	geolocation_lat DECIMAL,
	geolocation_lng DECIMAL,
	geolocation_city VARCHAR,
	geolocation_state VARCHAR
);


COPY geolocation (
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng,
	geolocation_city,
	geolocation_state
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE customers (
	customer_id VARCHAR,
	customer_unique_id VARCHAR,
	customer_zip_code_prefix INT,
	customer_city VARCHAR,
	customer_state VARCHAR
);

ALTER TABLE customers
ADD PRIMARY KEY (customer_id);

COPY customers (
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\customers_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE orders (
	order_id VARCHAR,
	customer_id VARCHAR,
	order_status VARCHAR,
	order_purchase_timestamp TIMESTAMP,
	order_approved_at TIMESTAMP,
	order_delivered_carrier_date TIMESTAMP,
	order_delivered_customer_date TIMESTAMP,
	order_estimated_delivery_date TIMESTAMP
);

ALTER TABLE orders
ADD PRIMARY KEY (order_id);

ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

COPY orders (
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\orders_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE orders_payments (
	order_id VARCHAR,
	payment_sequential INT,
	payment_type VARCHAR,
	payment_installments INT,
	payment_value REAL
);

ALTER TABLE orders_payments
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

COPY orders_payments (
	order_id,
	payment_sequential,
	payment_type,
	payment_installments,
	payment_value
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE orders_review (
	review_id VARCHAR,
	order_id VARCHAR,
	review_score INT,
	review_comment_title VARCHAR,
	review_comment_message VARCHAR,
	review_creation_date TIMESTAMP,
	review_answer_timestamp TIMESTAMP
);

ALTER TABLE orders_review
ADD PRIMARY KEY (review_id);

ALTER TABLE orders
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

COPY orders_review (
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE seller (
	seller_id VARCHAR,
	seller_zip_code_prefix INT,
	seller_city VARCHAR,
	seller_state VARCHAR
);

ALTER TABLE seller
ADD PRIMARY KEY (seller_id);

COPY seller (
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\sellers_dataset.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE orders_items (
	order_id VARCHAR,
	order_item_id INT,
	product_id VARCHAR REFERENCES product(product_id),
	seller_id VARCHAR REFERENCES seller(seller_id),
	shipping_limit_date TIMESTAMP,
	price REAL,
	freight_value REAL
);

ALTER TABLE orders_items
ADD PRIMARY KEY (order_id, order_item_id);

ALTER TABLE orders
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id)
ADD FOREIGN KEY (product_id) REFERENCES product(product_id)
ADD FOREIGN KEY (seller_id) REFERENCES seller(seller_id);

COPY orders_items (
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value
)
FROM 'E:\Rakamin\JAP\Mini Project\Analyzing eCommerce Businese Performance (SQL) Mini Project_1\Data Preparation\Dataset\Dataset\order_items_dataset.csv'
DELIMITER ','
CSV HEADER;


