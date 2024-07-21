const fs = require('node:fs');
const Color = require('color');
const opacity = require('hex-color-opacity');


const TOTAL_POSSIBLE_NODES = 268



function createData() 
{
    var arr = [];
    for(i = 0; i < TOTAL_POSSIBLE_NODES; i++)
    {   
        var color = Color.rgb(255, 255, 255).alpha(0);

        arr.push(color.hexa());

    }

    return JSON.stringify(arr)
}

fs.writeFile('./node_colors.secret', createData(), err => {
  if (err) {
    console.error(err);
  } else {
    
    
  }
});