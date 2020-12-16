-- we set the search path to the schema name:
SET search_path TO ventas;

BEGIN WORK;

-- Exercise 2: a)

SELECT country, COUNT(*) AS num_clients
FROM tb_client
GROUP BY country
ORDER BY num_clients DESC;

--------------
-- Exercise 2: b)

SELECT COUNT(order_number) AS num_pedidos, country
FROM tb_client
INNER JOIN tb_order
ON tb_client.client_code = tb_order.client_code
GROUP BY country
HAVING COUNT(order_number) > 3
ORDER BY num_pedidos DESC, country DESC;

------------
-- Exercise 2: c)

SELECT 
	sbc.subcategory_code, 
	sbc.category_code,
	tb_category.category_name,
	tb_product.price
FROM 
	tb_subcategory sbc
JOIN tb_category
	ON tb_category.category_code = sbc.category_code
JOIN tb_product
	ON tb_product.subcategory_code = sbc.subcategory_code
WHERE
	category_name = 'Bebidas' AND
	price < 0.80;


-----------
-- Exercise 2: d)

SELECT ct.category_code, ct.category_name
FROM tb_category ct
LEFT JOIN tb_subcategory sct
ON ct.category_code = sct.category_code 
WHERE subcategory_code IS NULL;


------------
-- Exercise 2: e)
SELECT 
	cl.client_name,
	ordl.order_number,
	ord.order_date,
	ord.delivery_date,
	SUM(ordl.quantity * ordl.unit_price) AS total_amout_order
FROM tb_order_line ordl
JOIN tb_order ord
	ON ordl.order_number = ord.order_number
JOIN tb_client cl
	ON ord.client_code = cl.client_code
WHERE ord.order_date > '2016-01-05' 
GROUP BY ordl.order_number, cl.client_name, ord.order_date, ord.delivery_date
HAVING SUM(ordl.quantity * ordl.unit_price) > 100
ORDER BY cl.client_name, ord.order_date, ord.delivery_date;

COMMIT WORK;