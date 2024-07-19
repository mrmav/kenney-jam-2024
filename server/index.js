const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  var date = new Date();
  res.send('Hello World! This is a reply fromn the webserver!\n Request Date: ' + date);
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});