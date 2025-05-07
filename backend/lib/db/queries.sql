-- CREATE DATABASE rede_confeitarias;

-- CREATE TABLE stores (
--   id SERIAL PRIMARY KEY,
--   store_name VARCHAR(100) NOT NULL,
--   phone VARCHAR(20) NOT NULL,
--   cep VARCHAR(10) NOT NULL,
--   latitude DECIMAL(9,6) NOT NULL,
--   longitude DECIMAL(9,6) NOT NULL,
--   city VARCHAR(50) NOT NULL,
--   uf VARCHAR(2) NOT NULL,
--   address VARCHAR(100) NOT NULL,
-- );

-- CREATE TABLE products (
--   id SERIAL PRIMARY KEY,
--   store_id INTEGER REFERENCES stores(id) ON DELETE CASCADE,
--   product_name VARCHAR(100) NOT NULL,
--   price NUMERIC(10,2) NOT NULL,
--   description TEXT NOT NULL,
--   image_url VARCHAR(255) NOT NULL,
-- );

