-- Set path to schema to save time writing 

SET search_path TO ventas;

BEGIN WORK; 

-- EXERCISE 4

-- Section 1)

-- Part a)
ALTER TABLE tb_category
ADD COLUMN vat DECIMAL(4,2);

UPDATE tb_category
SET vat = 0.08;

ALTER TABLE tb_category
ALTER COLUMN vat SET NOT NULL;


-- Part b)
-- Create the column
ALTER TABLE tb_order_line
ADD COLUMN total_vat_sum DECIMAL(20,4);


-- Update the column to the total value of the products, so we can get rid of the null values and put the constraint
UPDATE tb_order_line
SET total_vat_sum = (quantity*unit_price);

-- Put constrint of not null values
ALTER TABLE tb_order_line
ALTER COLUMN total_vat_sum SET NOT NULL;

-- Select the vat of the first category, Frutas, and multiply the values of the products in tb_order_line which corresponds to it by its taxes
UPDATE tb_order_line
SET total_vat_sum = total_vat_sum * (1 + (SELECT vat
										 FROM tb_category
										 WHERE category_code = 'CT001'
										))
FROM 
	tb_product,
	tb_subcategory
WHERE 
	tb_order_line.product_code = tb_product.product_code AND
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = 'CT001';


-- Repeat the process with the category: Bebidas
UPDATE tb_order_line
SET total_vat_sum = total_vat_sum * (1 + (SELECT vat
										 FROM tb_category
										 WHERE category_code = 'CT002'
										))
FROM 
	tb_product,
	tb_subcategory
WHERE 
	tb_order_line.product_code = tb_product.product_code AND
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = 'CT002';


-- Repeat the process with the category: Congelados
UPDATE tb_order_line
SET total_vat_sum = total_vat_sum * (1 + (SELECT vat
										 FROM tb_category
										 WHERE category_code = 'CT003'
										))
FROM 
	tb_product,
	tb_subcategory
WHERE 
	tb_order_line.product_code = tb_product.product_code AND
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = 'CT003';


-- Repeat the process with the category: Lácteos
UPDATE tb_order_line
SET total_vat_sum = total_vat_sum * (1 + (SELECT vat
										 FROM tb_category
										 WHERE category_code = 'CT004'
										))
FROM 
	tb_product,
	tb_subcategory
WHERE 
	tb_order_line.product_code = tb_product.product_code AND
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = 'CT004';


-- Repeat the process with the category: Carnes
UPDATE tb_order_line
SET total_vat_sum = total_vat_sum * (1 + (SELECT vat
										 FROM tb_category
										 WHERE category_code = 'CT005'
										))
FROM 
	tb_product,
	tb_subcategory
WHERE 
	tb_order_line.product_code = tb_product.product_code AND
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = 'CT005';


-- Repeat the process with the category: Higiene
UPDATE tb_order_line
SET total_vat_sum = total_vat_sum * (1 + (SELECT vat
										 FROM tb_category
										 WHERE category_code = 'CT006'
										))
FROM 
	tb_product,
	tb_subcategory
WHERE 
	tb_order_line.product_code = tb_product.product_code AND
	tb_product.subcategory_code = tb_subcategory.subcategory_code AND
	tb_subcategory.category_code = 'CT006';


-- Section 2

ALTER TABLE tb_order
DROP COLUMN reception_date;


-- Section 3 
-- As there isn't the command of alter constraint, we have first to drop the constraint and then put a new one
ALTER TABLE tb_order_line 
DROP CONSTRAINT ck_order_line_num;

ALTER TABLE tb_order_line
ADD CONSTRAINT ck_order_line_num CHECK(order_line_number BETWEEN 1 AND 35);


COMMIT WORK;


