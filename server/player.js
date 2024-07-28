const { v4: uuidv4 } = require("uuid");
const {
  uniqueNamesGenerator,
  names,
  adjectives,
  colors,
  animals,
} = require("unique-names-generator");

const CreateNew = () => {

  // some random operations
  let dicts = [];
  if(Math.random() >= 0.5)
  {
    dicts.push(animals);
  } else
  {
    dicts.push(names);
  }
  if(Math.random() >= 0.7)
    {
      dicts.unshift(colors);
    } 
  if(Math.random() >= 0.2 || dicts.length < 2)
  {
    dicts.unshift(adjectives);
  }

  let randomName = uniqueNamesGenerator({
    dictionaries: dicts,
    separator: "",
    style: "capital"
  });

  return { name: randomName, uuid: uuidv4() };
};

module.exports = { CreateNew };
