// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Member.sol";

// Contrato Ojeador que hereda de Member
contract Ojeador is Member {
    // Referencia al contrato JugadoresAFichar
    mapping(address => bool) public ojeadores;

    constructor(){
        ojeadores[msg.sender] = true;
    }

    event OjeadorAdded(address ojeador);
    event OjeadorRemoved(address ojeador);

    modifier onlyOjeador() {
        require(ojeadores[msg.sender], "Solo ojeadores pueden realizar esta accion");
        _;
    }

    // Función para añadir un nuevo Ojeador
    function addOjeador(address _ojeador) external onlyOjeador {
        require(!ojeadores[_ojeador], "La direccion ingresada ya esta actualmente registrada.");
        ojeadores[_ojeador] = true;
        emit OjeadorAdded(_ojeador);
    } 

    // Función para eliminar un Ojeador
    function removeOjeador(address _ojeador) external onlyOjeador {
        require(ojeadores[_ojeador], "No existe este Ojeador");
        ojeadores[_ojeador] = false;
        emit OjeadorRemoved(_ojeador);
    }

    // Función para verificar si una dirección es Ojeador
    function isOjeador(address _address) external view returns (bool) {
        return ojeadores[_address];
    }
}
