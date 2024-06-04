import { startTx } from "./db/startTx.js";

startTx(async (tx, createSavepoint) => {
  await tx.query(
    'INSERT INTO customers (first_name, last_name) VALUES($1, $2)',
    ['José', 'Silva'],
  );

  await tx.query('UPDATE bank_accounts SET balance = balance - 10 WHERE user_id = 1;');

  await createSavepoint('sp_01', async () => {
    await tx.query('UPDATE bank_accounts SET balance = balance + 100 WHERE user_id = 1;');
    await tx.query('UPDATE bank_accounts SET balance = balance - 100 WHERE user_id = 2;');
  });
});
