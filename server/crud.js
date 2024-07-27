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
const ReadItems = (callback) => {
  const sql = `SELECT * FROM players`;
  db.all(sql, [], callback);
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
  id,
  uuid,
  name,
  best_score,
  attempts,
  last_access,
  callback
) => {
  const sql = `UPDATE players SET uuid = ?, name = ?, best_score = ?, attempts = ?, last_access = ? WHERE id = ?`;
  db.run(sql, [uuid, name, best_score, attempts, last_access], callback);
};

// DELETE ITEM
const DeleteItem = (id, uuid, callback) => {
  const sql = `DELETE FROM players WHERE uuid = ?`;
  db.run(sql, uuid, callback);
};

module.exports = { CreateItem, ReadItems, ReadItem, UpdateItem, DeleteItem };
