// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;

interface IVirtualTradingEnvironmentFactory {
    /**
    * @notice Deploys a VirtualTradingEnvironment contract and returns the contract's address.
    * @dev This function can only be called by the VirtualTradingEnvironmentRegistry contract.
    * @param _owner Address of the user that can trade in the VTE.
    * @param _name Name of the VTE.
    * @return address Address of the deployed VTE contract.
    */
    function createVirtualTradingEnvironment(address _owner, string memory _name) external returns (address);
}