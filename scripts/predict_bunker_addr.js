const ethers = require("ethers");

// Configuración del Nodo 561
const factoryAddress = "0x..."; // Se llenará tras el deploy
const ownerAddress = "0x..."; // Tu dirección de Javier-ZK-Bunker
const salt = ethers.utils.id("SENTINEL_NODO_561");

function predictAddress() {
    const initCodeHash = ethers.utils.keccak256(
        "0x..." // Bytecode del contrato UniversalAccount
    );
    
    const address = ethers.utils.getCreate2Address(
        factoryAddress,
        salt,
        initCodeHash
    );

    console.log("🛡️ DIRECCIÓN PROYECTADA DEL BÚNKER UNIVERSAL:", address);
    return address;
}
