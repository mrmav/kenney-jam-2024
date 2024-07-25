const express = require('express');
var cors = require('cors')
var bodyParser = require('body-parser')
const fs = require('node:fs');
var cronJob = require("cron").CronJob;
const Color = require('color');
const app = express();
const port = 3000;

app.use(cors())

// create application/json parser
var jsonParser = bodyParser.json()
 
// create application/x-www-form-urlencoded parser
var urlencodedParser = bodyParser.urlencoded({ extended: false })

// TODO: read this from secret file later
var good_recipe = [0, 29, 30, 31, 34, 35, 36, 37, 51, 50, 38, 1, 2, 3, 7, 8, 6, 28, 27, 23, 24, 25, 26, 15, 16, 19, 20]



// TODO: read and save to file later
var node_colors = [];

app.get('/', (req, res) => {
  var date = new Date();
  res.send('Hello World! This is a reply fromn the webserver!\n Request Date: ' + date);
});

app.get('/check', (req, res) => {
  var date = new Date();
  
  var buff = Buffer.from(req.query.recipe, 'base64');  
  var player_array = JSON.parse(buff.toString());  

  console.log(new Date(), "Checking player recipe: " + player_array.toString())

  var response = {
    "result": calculateCorrectPositionPercentile(good_recipe, player_array)
  }

  console.log(new Date(), "Player got: " + response.result.toString())

  res.send(JSON.stringify(response));
});

app.get('/get_colors', (req, res) => {
  
  // open file

  var color_data = []

  for(i = 0; i < node_colors.length; i++)
  {
    const colorhex = node_colors[i].hexa()
    color_data.push(colorhex)
  }

  res.send(JSON.stringify(color_data.slice(0, req.query.count)));

});

app.get('/submit_colors', (req, res) => {
  
  var buff = Buffer.from(req.query.recipe, 'base64');
  var player_array = JSON.parse(buff.toString()); 

  buff = Buffer.from(req.query.color, 'base64');
  var player_color = JSON.parse(buff.toString())

  const color = Color.rgb(player_color.r, player_color.g, player_color.b).alpha(player_color.a / 255.0)

  for(i = 0; i < player_array.length; i++)
  {
    node_colors[player_array[i]] = node_colors[player_array[i]].mix(color)
  }

  res.send(JSON.stringify({"result": "ok"}));
  
});

app.listen(port, () => {

  // init array of nodes
  node_colors = []
  var data = JSON.parse(fs.readFileSync("node_colors.secret", { encoding: 'utf8', flag: 'r' }));
  for(i = 0; i < data.length; i++)
  {
    const c = Color(data[i])
    node_colors.push(c)
  }

  console.log(`Example app listening at http://localhost:${port}`);

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



new cronJob("0 */2 * * * *", function() {
  
  console.log("Runnings cron job....")

  var arr = []
  for(i = 0; i < node_colors.length; i++)
    {
        arr.push(node_colors[i].hexa());
    }

  fs.writeFile('./node_colors.secret', JSON.stringify(arr), err => {
    if (err) {
      console.error(err);
    } else {
      console.log(new Date(), "Saved nodes state")
    }
  });

}, null, true);