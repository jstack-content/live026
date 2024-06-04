import { startTx } from "./db/startTx.js";

startTx(async (tx) => {
  await tx.query('SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;');
  const { rows } = await tx.query('SHOW TRANSACTION ISOLATION LEVEL');
  console.log(rows);

  console.log('Antes do select');
  const { rows: [row] } = await tx.query('SELECT quantity FROM products WHERE id = 1');
  console.log('Depois do select');

  if (row.quantity < 1) {
    throw new Error('Not enough products');
  }

  console.log('Antes do update');
  await tx.query('UPDATE products SET quantity = quantity - 1 WHERE id = 1');
  console.log('Finalizou o update');
});
