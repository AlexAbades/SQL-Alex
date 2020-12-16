-- Create schema
CREATE SCHEMA ventas;

-- Set path to schema name
SET search_path TO ventas;

-- Create tables

BEGIN WORK;

CREATE TABLE tb_client(
	client_code CHAR(5),
	client_name VARCHAR(40) NOT NULL,
	address VARCHAR(140),
	city VARCHAR(25),
	country VARCHAR(60) NOT NULL,
	contact_email VARCHAR(100),
	phone VARCHAR(15),
	parent_client_code CHAR(5),
	created_by_user VARCHAR(10) DEFAULT 'OS_SYSTEM' NOT NULL,
	created_date DATE,
	update_date DATE,
	CONSTRAINT pk_client PRIMARY KEY(client_code),
	CONSTRAINT fk_client FOREIGN KEY (parent_client_code) REFERENCES tb_client
);

CREATE TABLE tb_category(
	category_code CHAR(5),
	category_name VARCHAR(70) NOT NULL,
	created_by_user VARCHAR(10) DEFAULT 'OS_SYSTEM' NOT NULL,
	created_date DATE,
	updated_date DATE,
	CONSTRAINT pk_category PRIMARY KEY (category_code)
);

CREATE TABLE tb_subcategory(
	subcategory_code CHAR(5),
	category_code CHAR(5),
	subcategory_name VARCHAR(55) NOT NULL,
	created_by_user VARCHAR(10) DEFAULT 'OS_SYSTEM' NOT NULL,
	created_date DATE,
	updated_date DATE,
	CONSTRAINT pk_subcategory PRIMARY KEY(subcategory_code),
	CONSTRAINT fk_category FOREIGN KEY(category_code) REFERENCES tb_category(category_code)
);

CREATE TABLE tb_product(
	product_code CHAR(5),
	subcategory_code CHAR(5),
	product_name VARCHAR(60) NOT NULL,
	price DECIMAL(14,2) NOT NULL,
	created_by_user VARCHAR(10) DEFAULT 'OS_SYSTEM' NOT NULL,
	created_date DATE,
	update_date DATE,
	CONSTRAINT pk_product PRIMARY KEY(product_code),
	CONSTRAINT fk_subcategory FOREIGN KEY(subcategory_code) REFERENCES tb_subcategory(subcategory_code)
);

CREATE TABLE tb_order(
	order_number CHAR(10),
	client_code CHAR(10) NOT NULL,
	order_date DATE NOT NULL,
	delivery_date DATE,
	reception_date DATE,
	created_by_user VARCHAR(10) DEFAULT 'OS_SYSTEM' NOT NULL,
	created_date DATE,
	updated_date DATE,
	CONSTRAINT pk_order PRIMARY KEY(order_number),
	CONSTRAINT fk_client FOREIGN KEY(client_code) REFERENCES tb_client(client_code)
);

CREATE TABLE tb_order_line(
	order_number CHAR(10),
	order_line_number INTEGER NOT NULL,
	product_code CHAR(5) NOT NULL,
	quantity INTEGER NOT NULL,
	unit_price DECIMAL(14,2) NOT NULL,
	created_by_user VARCHAR(10) DEFAULT 'OS_SYSTEM' NOT NULL,
	created_date DATE,
	updated_date DATE,
	CONSTRAINT pk_order_line PRIMARY KEY(order_number, order_line_number),
	CONSTRAINT fk_order FOREIGN KEY(order_number) REFERENCES tb_order(order_number),
	CONSTRAINT fk_product FOREIGN KEY(product_code) REFERENCES tb_product(product_code),
	CONSTRAINT ck_order_line_num CHECK(order_line_number >= 1)
);

COMMIT WORK;

