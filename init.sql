DROP DATABASE IF EXISTS live026;
CREATE DATABASE live026;

\c live026

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(256) NOT NULL,
  last_name VARCHAR(256) NOT NULL,
  email VARCHAR(256) UNIQUE
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(id),
  amount NUMERIC(10, 2) NOT NULL CHECK(amount >= 0)
);

-- Seed

DO $$
DECLARE
  customer_id INT;
  i INT := 1;
BEGIN
  WHILE i <= 50 LOOP
    -- Insert customer
    INSERT INTO customers(first_name, last_name, email)
    VALUES ('Customer' || i, 'Doe', 'customer.' || i || '@example.com')
    RETURNING id INTO customer_id;

    -- Insert order for customer
    INSERT INTO orders(customer_id, amount)
    VALUES(customer_id, random() * 1000);

    i := i + 1;
  END LOOP;

  RAISE NOTICE '% customers successfully created!', i - 1;
END $$;
