// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Ojeador.sol";
// Utilizamos El ReentrancyGuard de OpenZeppelin para evitar Reentrancy attacks
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

// Contrato JugadoresAFichar
contract JugadoresAFichar is ReentrancyGuard {
    // Lista de jugadores a fichar
    mapping(address => bool) public jugadores;
    mapping(address => string) public nombrecompleto;
    mapping(address => uint256) public value_jug;
    Ojeador public ojeadorContract_;

    constructor(address ojeadorContract){
        ojeadorContract_ = Ojeador(ojeadorContract);
    }

    modifier onlyOjeador() {
        require(ojeadorContract_.isOjeador(msg.sender), "Solo ojeadores pueden realizar esta accion");
        _;
    }

    // Eventos
    event JugadorAnadido(address jugador, string nombre, uint256 precio);
    event JugadorEliminado(address jugador);

    // Función para añadir un nuevo jugador
    // Solo los ojeadores pueden añadir jugadores. Se utiliza un guardián de reentrada.
    function anadirJugador(address _jugador, string memory nombre, uint256 precio) external onlyOjeador nonReentrant {
        require(!jugadores[_jugador], "Ya esta en la prelista.");
        jugadores[_jugador] = true;
        nombrecompleto[_jugador] = nombre;
        value_jug[_jugador] = precio;
        emit JugadorAnadido(_jugador, nombre, precio);
    }

    // Función para eliminar un jugador
    // Solo los ojeadores pueden eliminar jugadores. Se utiliza un guardián de reentrada.
    function eliminarJugador(address _jugador) external onlyOjeador nonReentrant {
        require(jugadores[_jugador], "No esta en la prelista.");
        delete jugadores[_jugador];
        delete nombrecompleto[_jugador];
        delete value_jug[_jugador];
        emit JugadorEliminado(_jugador);
    }


    // Verifica si un jugador existe en la prelista.
    // bool True si el jugador existe, de lo contrario false.
    function existeJug(address jugador) external view returns (bool) {
        return jugadores[jugador];
    }

    // Función para obtener precio de x jugador
    function obtenerPrecio(address _jugador) external view returns (uint256) {
        return value_jug[_jugador];
    }

    // Función para obtener el nombre de x jugador
    function obtenerNombre(address _jugador) external view returns (string memory) {
        return nombrecompleto[_jugador];
    }
}
