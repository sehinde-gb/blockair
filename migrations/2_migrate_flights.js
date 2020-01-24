var Flights = artifacts.require("./Flights.sol");

module.exports = function(deployer) {
    deployer.deploy(Flights);
};