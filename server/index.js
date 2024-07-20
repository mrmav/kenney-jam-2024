const express = require('express');
var cors = require('cors')
var bodyParser = require('body-parser')
var mysql = require('mysql');
const app = express();
const port = 3000;

app.use(cors())

// create application/json parser
var jsonParser = bodyParser.json()
 
// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false })

app.get('/', (req, res) => {
  var date = new Date();
  res.send('Hello World! This is a reply fromn the webserver!\n Request Date: ' + date);
});

app.post('/post-data', jsonParser, (req, res) => {
  const data = req.body;

  // Save the data of user that was sent by the client
  console.log("Received data:", data)

  // Send a response to client that will show that the request was successfull.
  res.send({
    message: 'Data delivered!',
  });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});