const sqlite3 = require("sqlite3").verbose();
const dbName = "game_database.db";

let db = new sqlite3.Database(dbName, (err) => {
  if (err) {
    console.log(err);
    return;
  }

  // all good
  console.log("Connected to database.");
  db.run(
    "CREATE TABLE IF NOT EXISTS players (id INTEGER PRIMARY KEY AUTOINCREMENT, uuid TEXT, name TEXT, best_score REAL, attempts INTEGER, last_access INTEGER)",
    (err) => {
      if (err) {
        console.log(err);
        return;
      }

      // all good
      console.log("Table created or existed.");
    }
  );
});

module.exports = db;
