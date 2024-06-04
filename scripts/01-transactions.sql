\c live026

-- DROP TABLE bank_accounts;
-- CREATE TABLE bank_accounts (
--   id SERIAL PRIMARY KEY,
--   user_id INT,
--   balance NUMERIC(10, 2) CHECK (balance >= 0)
-- );

-- INSERT INTO bank_accounts(user_id, balance) VALUES(1, 500), (2, 100);

-- UPDATE bank_accounts SET balance = balance - 50 WHERE user_id = 1;
-- UPDATE bank_accounts SET balance = balance + 50 WHERE user_id = 2;

-- BEGIN;
--   UPDATE bank_accounts SET balance = balance + 10 WHERE user_id = 1;
--   UPDATE bank_accounts SET balance = balance - 10 WHERE user_id = 2;
-- COMMIT;

SELECT user_id, balance FROM bank_accounts;
