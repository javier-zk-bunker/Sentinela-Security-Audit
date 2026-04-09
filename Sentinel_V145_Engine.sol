// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 * @title Sentinel v145 - Motor de Recaudación ZK-Bunker
 * @author javier-zk-bunker (Nodo 561)
 */
contract SentinelV145Engine {
    address public immutable auditorZk;
    address public bunkerWallet; 
    uint256 public constant CANON_FEE = 15;

    constructor(address _bunkerWallet) {
        auditorZk = msg.sender;
        bunkerWallet = _bunkerWallet;
    }

    function captureFee(uint256 gasUsed) external payable {
        require(msg.sender == auditorZk, "Acceso Denegado: Nodo 561 Requerido");
        uint256 canon = (gasUsed * CANON_FEE) / 100;
        (bool success, ) = bunkerWallet.call{value: canon}("");
        require(success, "Fallo en liquidacion");
    }

    receive() external payable {}
}
