// Create, Read, Update, Delete file.

const db = require("./database");

// CREATE
const CreateItem = (uuid, name, last_access, callback) => {
  const sql = `INSERT INTO players (uuid, name, last_access) VALUES (?, ?, ?)`;
  db.run(sql, [uuid, name, last_access], function (err) {
    callback(err, { id: this.lastID });
  });
};

// READ
const ReadItems = (count, callback) => {
  const sql = `SELECT id, name, best_score FROM players WHERE best_score IS NOT NULL ORDER BY best_score DESC LIMIT ?`;
  db.all(sql, [count], callback);
};

// READ ITEM
const ReadItem = (uuid, callback) => {
  const sql = `SELECT * FROM players WHERE uuid = (?)`;
  db.get(sql, [uuid], function (err, row) {
    if (err) {
      console.log(err);
      return;
    }

    callback(row);
  });
};

// UPDATE ITEM
const UpdateItem = (
  uuid,
  score,
  callback
) => {
  const sql = `UPDATE players SET best_score = MAX(IFNULL(best_score, 0.0), ?), attempts = IFNULL(attempts, 0) + 1, last_access = ? WHERE uuid = ?`;
  db.run(sql, [score, Date.now(), uuid], callback);
};

// DELETE ITEM
const DeleteItem = (id, uuid, callback) => {
  const sql = `DELETE FROM players WHERE uuid = ?`;
  db.run(sql, uuid, callback);
};

module.exports = { CreateItem, ReadItems, ReadItem, UpdateItem, DeleteItem };
