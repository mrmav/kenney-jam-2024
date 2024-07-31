const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const fs = require("node:fs");
const cronJob = require("cron").CronJob;
const Color = require("color");
const uuidValidate = require("uuid").validate
const app = express();
const port = 3000;
const {
  CreateItem,
  ReadItems,
  ReadItem,
  UpdateItem,
  DeleteItem,
} = require("./crud");
const createPlayer = require("./player").CreateNew;

// CORS enabled to embed game into Itch.io
app.use(cors());

// These vars were used for post methods.
// Leaving here in case I decide to change to post.
// // create application/json parser
// var jsonParser = bodyParser.json()
// // create application/x-www-form-urlencoded parser
// var urlencodedParser = bodyParser.urlencoded({ extended: false })

// The final recipe, used to check against.
var good_recipe = [];

// other recipes
var other_recipes = null;

var unlocked_by_players = [
  
  // {player_name: name, recipe_name: name, code: id_recipe_name}

];

// The nodes colors state. This will be saved to file by cronjob.
var node_colors = [];

// Default entry point
app.get("/", (req, res) => {
  var date = new Date();
  res.send(
    "Hello World! This is a reply fromn the webserver!\n Request Date: " + date
  );
});

// Checks for a recipe provided in the query params.
app.get("/check", (req, res) => {

  var buff = Buffer.from(req.query.uuid, "base64");
  var player_uuid = buff.toString();

  if (!uuidValidate(player_uuid)) {
    res.status(500).send(JSON.stringify({ code: 1 }));
    return;
  }

  buff = Buffer.from(req.query.recipe, "base64");
  var player_array = JSON.parse(buff.toString());

  console.log(new Date(), "Checking player recipe: " + player_array.toString());

  var data = {
    result: CheckSubmittedArray(good_recipe, player_array),
    code: 0
  };

  console.log(new Date(), "Player got: " + data.result.toString());

  ReadItem(player_uuid, (row) => {

    if (row) {
      // could be undefined
      // player exists
      
      // we now check for any other recipes found:
      if(other_recipes != null)
      {
        for(var i = 0; i < other_recipes.length; i++)
        {
          if(CheckSubmittedArray(other_recipes[i].recipe, player_array) >= 99.0)
          {
            var code = `${row.id}_${other_recipes[i].name}`;

            // check if already unlocked:
            var found = false
            for(var j = 0; j < unlocked_by_players.length; j++)
            {
              if(unlocked_by_players[j].code == code)
              {
                found = true;
                break;
              }
            }

            if(!found)
            {
              unlocked_by_players.push({timestamp: Date.now(), player_name: `${row.name}#${row.id}`, recipe_name: other_recipes[i].name, code: code})
            }            
          }
        }
      }
    } 

  })


  var success = true;
  UpdateItem(player_uuid, data.result, (err) => {
    if (err) {
      console.log(err);
      data.code = 1;
      res.status(500).send(JSON.stringify(data));

      return;
    }
    
    res.status(200).send(JSON.stringify(data));
  });

});

// Used to retrieve the node colors state.
app.get("/get_colors", (req, res) => {
  var color_data = [];
  for (i = 0; i < node_colors.length; i++) {
    const colorhex = node_colors[i].hexa();
    color_data.push(colorhex);
  }

  console.log(new Date(), "Sending colors.");
  res.send(JSON.stringify(color_data.slice(0, req.query.count)));
});

// Path to submit round colors. This should be a POST, but oh well.
app.get("/submit_colors", (req, res) => {

  // decode the player submitted array
  var buff = Buffer.from(req.query.recipe, "base64");
  var player_array = JSON.parse(buff.toString());

  // decode the player submitted color
  buff = Buffer.from(req.query.color, "base64");
  var player_color = JSON.parse(buff.toString());

  // The submitted color will be in the format {r8, g8, b8, a8}.
  // The library we are using here is weird and I can't seem to be able to
  // create colors directly with alpha.
  // This line will create the color.
  const color = Color.rgb(player_color.r, player_color.g, player_color.b).alpha(
    player_color.a / 255.0
  );

  // We would need to check here if the player array makes sense. For that, we would
  // need to create the ingredients graph in the backend and send it to the client.
  // In the gamejam context, this was not possible because it would take a bit more time to setup.
  for (i = 0; i < player_array.length; i++) {
    // Here we mix the existing color with the player submitted color.
    // TODO: Investigate better ways to mix the colors? The resulting color seems a bit too random.
    node_colors[player_array[i]] = node_colors[player_array[i]].mix(color);
  }

  res.send(JSON.stringify({ result: "ok" }));
});

app.listen(port, () => {
  // Init the array of nodes colors.
  node_colors = [];
  var data = JSON.parse(
    fs.readFileSync("node_colors.secret", { encoding: "utf8", flag: "r" })
  );
  for (i = 0; i < data.length; i++) {
    const c = Color(data[i]);
    node_colors.push(c);
  }

  // Load in recipe.
  good_recipe = JSON.parse(
    fs.readFileSync("recipe.secret", { encoding: "utf8", flag: "r" })
  );

  // Load in other recipe.
  other_recipes = JSON.parse(
    fs.readFileSync("other_recipes.json", { encoding: "utf8", flag: "r" })
  );

  // Load in other unlocked recipe.
  unlocked_by_players = JSON.parse(
    fs.readFileSync("unlocked_by_players.secret", { encoding: "utf8", flag: "r" })
  );

  console.log(`Game Server listening at http://localhost:${port}`);
});

// This function takes two arrays and tests how much, the elements of the
// given testArray match the goodArray's elements. It returns a value in the range [0-100]
function CheckSubmittedArray(goodArray, testArray) {
  const minLength = Math.min(goodArray.length, testArray.length);
  const maxLength = Math.max(goodArray.length, testArray.length);

  // Count the number of elements that are in the correct index position.
  let correctCount = 0;
  for (let i = 0; i < minLength; i++) {
    if (goodArray[i] === testArray[i]) {
      correctCount++;
    }
  }

  return (correctCount / maxLength) * 100.0;
}

// Register job to save nodes colors into disk.
new cronJob(
  "0 */2 * * * *",
  function () {
    console.log(new Date(), "Runnings cronjob to save nodes state....");

    var arr = [];
    for (i = 0; i < node_colors.length; i++) {
      arr.push(node_colors[i].hexa());
    }

    fs.writeFile("./node_colors.secret", JSON.stringify(arr), (err) => {
      if (err) {
        console.error(err);
      } else {
        console.log(new Date(), "Saved nodes state");
      }
    });

    fs.writeFile("./unlocked_by_players.secret", JSON.stringify(unlocked_by_players), (err) => {
      if (err) {
        console.error(err);
      } else {
        console.log(new Date(), "Saved unlocked recipes by players");
      }
    });

  },
  null,
  true
);

// TEST DB

app.get("/players", (req, res) => {
  ReadItems(50, (err, rows) => {
    if (err) {
      console.log(err);
      res.status(500).send(err.message);
    } else {
      console.log(err);
      res.status(200).json(rows);
    }
  });
});

// I'll need an endpoint for the player to ping with a uuid
// if no uuid present, reply with a new one and resgister player.
// If there is, ignore.
app.get("/player", (req, res) => {
  if ("uuid" in req.query) {
    // uuid is present, check db
    ReadItem(req.query.uuid, (row) => {
      if (row) {
        // could be undefined
        // player exists
        res.status(200).send(JSON.stringify({ code: 0, uuid: row.uuid, name: row.name, id: row.id }));
        return;
      } else {
        // player does not exist.
        // register new player.
        createAndStoreNewPlayer(res);
      }
    });
  } else {
    createAndStoreNewPlayer(res);
  }
});

function createAndStoreNewPlayer(res) {
  const playerInfo = createPlayer();
  console.log("Create player:", playerInfo);

  CreateItem(playerInfo.uuid, playerInfo.name, Date.now(), (err, data) => {
    if (err) {
      console.log(err);
      res.status(500).send(JSON.stringify({ code: 1 }));
    } else {
      res
        .status(200)
        .send(JSON.stringify({ code: 0, uuid: playerInfo.uuid, name: playerInfo.name, id: data.id }));
    }
  });
}


app.get("/feed", (req, res) => {

  res.status(200).send(JSON.stringify(unlocked_by_players));

})