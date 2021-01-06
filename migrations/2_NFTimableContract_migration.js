const NFTimableContract = artifacts.require("NFTimableContract");

module.exports = function (deployer) {
  deployer.deploy(NFTimableContract);
};