// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./V145_Engine.sol";

/**
 * @title Universal Account Factory - Nodo 561
 * @dev Generador de identidades soberanas para el ecosistema Sentinela.
 */
contract UniversalAccountFactory {
    // El motor v145 que audita y cobra el canon
    SentinelV145Engine public immutable paymaster;

    event AccountCreated(address indexed account, address indexed owner, bytes32 salt);

    constructor(address _paymaster) {
        paymaster = SentinelV145Engine(payable(_paymaster));
    }

    /**
     * @dev Genera una cuenta universal con la misma dirección en cualquier red.
     * @param owner El dueño de la cuenta (Javier/Socio).
     * @param salt Un número único para la generación determinista.
     */
    function createUniversalAccount(address owner, bytes32 salt) external returns (address) {
        // Cálculo de dirección determinista (CREATE2)
        address addr = address(new UniversalAccount{salt: salt}(owner));
        
        emit AccountCreated(addr, owner, salt);
        return addr;
    }

    /**
     * @dev Predice la dirección antes de desplegar (útil para el Smart Money).
     */
    function getAddress(address owner, bytes32 salt) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), salt, keccak256(type(UniversalAccount).creationCode))
        );
        return address(uint160(uint256(hash)));
    }
}

contract UniversalAccount {
    address public owner;
    constructor(address _owner) { owner = _owner; }
    receive() external payable {}
}
