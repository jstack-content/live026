import { client } from './client.js';

export async function startTx(cb) {
  async function createSavepoint(spName, spCb) {
    try {
      await client.query(`SAVEPOINT ${spName}`);

      await spCb();
    } catch (error) {
      await client.query(`ROLLBACK TO SAVEPOINT ${spName}`);
    }
  }

  try {
    await client.query('BEGIN');
  
    await cb(client, createSavepoint);
    
    await client.query('COMMIT');
  } catch (error) {
    console.log(error);
    await client.query('ROLLBACK');
  } finally {
    await client.end();
  }
}