\c live026

-- DROP TABLE IF EXISTS bank_accounts;
-- CREATE TABLE IF NOT EXISTS bank_accounts (
--   id SERIAL PRIMARY KEY,
--   user_id INT,
--   balance NUMERIC(10, 2) CHECK (balance >= 0),
--   updated_by INT
-- );

-- DROP TABLE IF EXISTS bank_accounts_tx_logs;
-- CREATE TABLE IF NOT EXISTS bank_accounts_tx_logs (
--   id SERIAL PRIMARY KEY,
--   bank_account_id INT REFERENCES bank_accounts(id),
--   updated_by INT,
--   previous_balance NUMERIC(10, 2),
--   current_balance NUMERIC(10, 2)
-- );

-- CREATE OR REPLACE FUNCTION log_bank_account_tx_trigger() RETURNS TRIGGER
-- AS $$
--   BEGIN
--     INSERT INTO bank_accounts_tx_logs(
--       bank_account_id,
--       updated_by,
--       current_balance,
--       previous_balance
--     ) VALUES (
--       NEW.id,
--       NEW.updated_by,
--       NEW.balance,
--       OLD.balance
--     );

--     RETURN NEW;
--   END;
-- $$ LANGUAGE plpgsql;


-- CREATE TRIGGER bank_accounts_tx_logs_trigger
-- AFTER UPDATE OR INSERT ON bank_accounts
-- FOR EACH ROW EXECUTE FUNCTION log_bank_account_tx_trigger();

-- INSERT INTO bank_accounts(user_id, balance) VALUES (1, 1000), (2, 2000);

-- SELECT * FROM bank_accounts;

UPDATE bank_accounts SET balance = balance - 100, updated_by = 10 WHERE user_id = 1;
UPDATE bank_accounts SET balance = balance + 100, updated_by = 10 WHERE user_id = 2;

SELECT * FROM bank_accounts_tx_logs;
