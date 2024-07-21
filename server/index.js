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


var good_recipe = [10, 5, 7]


app.get('/', (req, res) => {
  var date = new Date();
  res.send('Hello World! This is a reply fromn the webserver!\n Request Date: ' + date);
});

app.get('/check', (req, res) => {
  var date = new Date();
  
  var buff = Buffer.from(req.query.recipe, 'base64');  
  var player_array = JSON.parse(buff.toString());  

  console.log("Checking player recipe: " + player_array.toString())

  var response = {
    "result": calculateCorrectPositionPercentile(good_recipe, player_array)
  }
  res.send(JSON.stringify(response));
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

  // console.log(calculateCorrectPositionPercentile(good_recipe, [10,  5,  7]));
  // console.log(calculateCorrectPositionPercentile(good_recipe, [10,  5]));
  // console.log(calculateCorrectPositionPercentile(good_recipe, [10]));
  // console.log(calculateCorrectPositionPercentile(good_recipe, [10,  89,  7]));
  // console.log(calculateCorrectPositionPercentile(good_recipe, [10, 89,  7,  5]));
  // console.log(calculateCorrectPositionPercentile(good_recipe, [10, 89,  7,  5, 10]));
  // console.log(calculateCorrectPositionPercentile(good_recipe, [10, 89,  7,  5, 10, 2, 4,7,7]));

});


// by chatgpt
function calculateCorrectPositionPercentile(goodArray, testArray) {
  // Determine the length of the shorter and longer arrays
  const minLength = Math.min(goodArray.length, testArray.length);
  const maxLength = Math.max(goodArray.length, testArray.length);

  // Count the number of elements that are in the correct index position
  let correctCount = 0;
  for (let i = 0; i < minLength; i++) {
      if (goodArray[i] === testArray[i]) {
          correctCount++;
      }
  }

  // Calculate the total number of comparisons (including the extra elements)
  const totalComparisons = maxLength;

  // Calculate the adjusted percentile
  const percentile = (correctCount / totalComparisons) * 100;
  return percentile;
}