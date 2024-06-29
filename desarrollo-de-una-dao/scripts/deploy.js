const DAO = artifacts.require("DAO");
const Member = artifacts.require("Member");

module.exports = async function(deployer) {
  await deployer.deploy(Member);
  const memberInstance = await Member.deployed();
  await deployer.deploy(DAO);
};
