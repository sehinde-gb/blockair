pragma solidity ^0.4.21;


contract Flights {
    // data structure that stores a flight
    struct Flight {
        string flight_in;
        string flight_out;
        uint total_price;
        uint price_per_adult;
        address walletAddress;
        uint createdAt;
        uint updatedAt;
    }

    // it maps the flight's wallet address with the flight ID
    mapping (address => uint) public flightsIds;

    // Array of Flight that holds the list of flights and their details
    Flight[] public flights;

    // event fired when a new flight is registered
    event newFlightRegistered(uint id);

    // event fired when the flight is updated
    event flightUpdateEvent(uint id);



    // Modifier: check if the caller of the smart contract is registered
    modifier checkSenderIsRegistered {
    	require(isRegistered());
    	_;
    }



    /**
     * Constructor function
     */
    constructor() public {
        // NOTE: the first flight MUST be empty
        addFlight(0x0, "", "", 0, 0);

        // Some dummy data
        addFlight(0x333333333333, "LHR", "DUB", 590, 210);
        addFlight(0x111111111111, "BOS", "LHR", 590, 323);
        addFlight(0x222222222222, "TOR", "DUB", 590, 434);
    }



    /**
     * Function to register a new flight.
     *
     * @param flight_in         Going flight
     * @param flight_out        Return flight
     * @param total_price       Total Price
     * @param price_per_adult   Price Per Adult
     */
    function registerFlight(string flight_in, string flight_out, uint total_price, uint price_per_adult) public returns(uint)
    {
    	return addFlight(msg.sender, flight_in, flight_out, total_price, price_per_adult);
    }



    /**
     * Add a new flight. This function must be private because a flight
     * cannot insert another flight on behalf of someone else.
     *
     * @param wAddr 		    Address wallet of the flight
     * @param flight_in         Going flight
     * @param flight_out        Return flight
     * @param total_price       Total Price
     * @param price_per_adult   Price Per Adult
    */

    function addFlight(address wAddr, string flight_in, string flight_out, uint total_price, uint price_per_adult) private
    returns(uint)
    {
        // checking if the flight is already registered
        uint flightId = flightsIds[wAddr];
        require (flightId == 0);

        // associating the flight wallet address with the new ID
        flightsIds[wAddr] = flights.length;
        uint newFlightId = flights.length++;

        // storing the new flight details
        flights[newFlightId] = Flight({
            flight_in: flight_in,
            flight_out: flight_out,
            total_price: total_price,
            price_per_adult: price_per_adult,
            walletAddress: wAddr,
            createdAt: now,
            updatedAt: now
        });

        // emitting the event that a new flight has been registered
        emit newFlightRegistered(newFlightId);

        return newFlightId;
    }


    /**
     * Update the flight confirmation of the caller of this method.
     * Note: the flight can modify only his own confirmation.
     *
     * @param newFlightIn	    The new going flight
     * @param newFlightOut 	    The new return flight
     * @param newTotalPrice     The new total price
     * @param newPricePerAdult  The new price per adult
     *
     */
    function updateFlight(string newFlightIn, string newFlightOut, uint newTotalPrice, uint newPricePerAdult) checkSenderIsRegistered public
    returns(uint)
    {
    	// A flight can modify only their own confirmation.
    	uint flightId = flightsIds[msg.sender];

    	Flight storage flight = flights[flightId];

    	flight.flight_in = newFlightIn;
    	flight.flight_out = newFlightOut;
        flight.total_price = newTotalPrice;
        flight.price_per_adult = newPricePerAdult;
    	flight.updatedAt = now;

    	emit flightUpdateEvent(flightId);

    	return flightId;
    }


    /**
     * Get the flight's confirmation information.
     *
     * @param id 	The ID of the flight stored on the blockchain.
     */
    function getFlightById(uint id) public view
    returns(
    	uint,
    	string,
    	string,
        uint,
        uint,
    	address,
    	uint,
    	uint
    ) {
    	// checking if the ID is valid
    	require( (id > 0) || (id <= flights.length) );

    	Flight memory i = flights[id];

    	return (
    		id,
    		i.flight_in,
    		i.flight_out,
            i.total_price,
            i.price_per_adult,
    		i.walletAddress,
    		i.createdAt,
    		i.updatedAt
    	);
    }

    /**
     * Return the confirmation information of the caller.
     */
    function getOwnProfile() checkSenderIsRegistered public view
    returns(
    	uint,
    	string,
    	string,
        uint,
        uint,
    	address,
    	uint,
    	uint
    ) {
    	uint id = flightsIds[msg.sender];

    	return getFlightById(id);
    }




    /**
     * Check if the flight that is calling the smart contract is registered.
     */
    function isRegistered() public view returns (bool)
    {
    	return (flightsIds[msg.sender] != 0);
    }



    /**
     * Return the number of total registered flights.
     */
    function totalFlights() public view returns (uint)
    {
        return flights.length;
    }

}