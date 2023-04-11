const admin = artifacts.require("admin");

module.exports = function(deployer) {
  deployer.deploy(admin);
};
