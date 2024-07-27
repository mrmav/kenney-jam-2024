const { v4: uuidv4 } = require("uuid");
const {
  uniqueNamesGenerator,
  names,
  adjectives,
  colors,
  animals,
} = require("unique-names-generator");

const CreateNew = () => {
  const randomName = uniqueNamesGenerator({
    dictionaries: [adjectives, names],
  });
  return { name: randomName, uuid: uuidv4() };
};

module.exports = { CreateNew };
