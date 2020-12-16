-- Set path to schema to save time writting

SET search_path TO ventas;

-- Exercise 3.

BEGIN WORK;

-- Section 1)

-- Part a)
UPDATE tb_product
SET price = price * 1.25
WHERE product_name = 'El Coto';

-- Part b)
UPDATE tb_product
SET price = price * 0.93
FROM tb_subcategory
WHERE 
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.subcategory_name = 'Manzanas y peras';

-- Part c)
UPDATE tb_product
SET price = price * 1.09
FROM tb_category, tb_subcategory
WHERE
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = tb_category.category_code AND
	tb_category.category_name = 'Lácteos';


-- Section 2)

DELETE FROM tb_subcategory 
WHERE subcategory_code IN (
			SELECT tb_subcategory.subcategory_code
			FROM tb_subcategory
			LEFT JOIN tb_product
				ON tb_subcategory.subcategory_code = tb_product.subcategory_code
			WHERE tb_product.product_code IS NULL);


-- Section 3)

-- Part a) & b)
INSERT INTO tb_client (client_code, client_name, address, city, country, contact_email, phone, parent_client_code, created_by_user, created_date) VALUES
	('C0030', 'Lidl', 'Drungüerkanster 38', 'Frankfurt', 'Germany', 'info@lidl.de', NULL, NULL, 'Alumno-UOC', '31-10-2020'),
	('C0031', 'Lidl - Frankfurt', 'Drungüerkanster 128', 'Frankfurt', 'Germany', 'frankfurt@lidl.de', '998 858 896', 'C0031', 'Alumno-UOC', '31-10-2020');


-- Section 4)

-- Part a)
UPDATE tb_subcategory
SET category_code = (SELECT	category_code
					 FROM tb_category
					 WHERE category_name = 'Bebidas')
WHERE subcategory_name = 'Vinos';

--Part b)
UPDATE tb_subcategory
SET category_code = (SELECT	category_code
					 FROM tb_category
					 WHERE category_name = 'Lácteos')
WHERE subcategory_name = 'Yogures';

--Part c)
UPDATE tb_subcategory
SET category_code = (SELECT	category_code
					 FROM tb_category
					 WHERE category_name = 'Carnes')
WHERE subcategory_name = 'Ternera';

-- Part d)
UPDATE tb_subcategory
SET category_code = (SELECT	category_code
					 FROM tb_category
					 WHERE category_name = 'Higiene')
WHERE subcategory_name = 'Papel';

COMMIT WORK;