// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

// OpenZeppelin.
import "./openzeppelin-solidity/contracts/Ownable.sol";

// Internal references.
import './VirtualTradingEnvironment.sol';

// Inheritance.
import './interfaces/IVirtualTradingEnvironmentFactory.sol';

contract VirtualTradingEnvironmentFactory is IVirtualTradingEnvironmentFactory, Ownable {
    address public immutable oracle;
    address public virtualTradingEnvironmentRegistry;

    constructor(address _oracle) Ownable() {
        oracle = _oracle;
    }

    /* ========== MUTATIVE FUNCTIONS ========== */

    /**
    * @notice Deploys a VirtualTradingEnvironment contract and returns the contract's address.
    * @dev This function can only be called by the VirtualTradingEnvironmentRegistry contract.
    * @param _owner Address of the user that can trade in the VTE.
    * @param _name Name of the VTE.
    * @return address Address of the deployed VTE contract.
    */
    function createVirtualTradingEnvironment(address _owner, string memory _name) external override onlyVirtualTradingEnvironmentRegistry returns (address) {
        address VTE = address(new VirtualTradingEnvironment(_owner, oracle, virtualTradingEnvironmentRegistry, _name));

        emit CreatedVirtualTradingEnvironment(_owner, VTE, _name);

        return VTE;
    }

    /* ========== RESTRICTED FUNCTIONS ========== */

    /**
    * @notice Sets the address of the VirtualTradingEnvironmentRegistry contract.
    * @dev The address is initialized outside of the constructor to avoid a circular dependency with VirtualTradingEnvironmentRegistry.
    * @dev This function can only be called by the VirtualTradingEnvironmentFactory owner.
    * @param _registry Address of the VirtualTradingEnvironmentRegistry contract.
    */
    function initializeContract(address _registry) external onlyOwner {
        virtualTradingEnvironmentRegistry = _registry;

        emit InitializedContract(_registry);
    }

    /* ========== MODIFIERS ========== */

    modifier onlyVirtualTradingEnvironmentRegistry() {
        require(msg.sender == virtualTradingEnvironmentRegistry,
                "VirtualTradingEnvironmentFactory: Only the VirtualTradingEnvironmentRegistry contract can call this function.");
        _;
    }

    /* ========== EVENTS ========== */

    event CreatedVirtualTradingEnvironment(address owner, address VTE, string name);
    event InitializedContract(address registryAddress);
}