// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ShipmentManagement {
    struct Shipment {
        uint256 shipmentId;
        string product;
        uint256 weight; // in kilograms
        uint256 volume; // in cubic meters
        string source;
        string destination;
        bool isAssigned;
    }

    mapping(uint256 => Shipment) public shipments;
    uint256 public numShipments;

    event ShipmentAdded(uint256 indexed shipmentId, string product, uint256 weight, uint256 volume, string source, string destination);
    event ShipmentAssigned(uint256 indexed shipmentId, address driver);

    function addShipment(string memory _product, uint256 _weight, uint256 _volume, string memory _source, string memory _destination) external {
        require(_weight > 0 && _volume > 0, "Invalid weight or volume");
        require(bytes(_source).length > 0 && bytes(_destination).length > 0, "Invalid source or destination");

        shipments[numShipments] = Shipment({
            shipmentId: numShipments,
            product: _product,
            weight: _weight,
            volume: _volume,
            source: _source,
            destination: _destination,
            isAssigned: false
        });

        emit ShipmentAdded(numShipments, _product, _weight, _volume, _source, _destination);
        numShipments++;
    }

    function assignShipment(uint256 _shipmentId) external {
        require(_shipmentId < numShipments, "Invalid shipment ID");
        require(!shipments[_shipmentId].isAssigned, "Shipment already assigned");

        shipments[_shipmentId].isAssigned = true;

        emit ShipmentAssigned(_shipmentId, msg.sender);
    }
}