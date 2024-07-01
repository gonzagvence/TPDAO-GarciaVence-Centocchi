// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Member {
    // Variables de estado
    mapping(address => bool) private members;
    address payable DAO;
    uint256 count;

    // Eventos
    event MemberAdded(address member);
    event MemberRemoved(address member);

    constructor(){
        members[msg.sender] = true;
        count = 1;
    }

    function setDAO(address payable dao_) external {
        DAO = dao_;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Solo miembros pueden realizar esta accion");
        _;
    }

    // Función para añadir un nuevo miembro
    //Se asegura que la transferencia de fondos se realiza después de actualizar el estado para evitar ataques de reentrada.
    function addMember(address _member) external payable onlyMember{
        require(!members[_member], "La direccion ingresada ya esta actualmente registrada.");
        require(msg.value > 1, "Se necesita una inversion inicial mayor a 1");
    
        
        members[_member] = true; 
        emit MemberAdded(_member);
        count = count + 1;

        // Transferencia de fondos después de actualizar el estado
        DAO.transfer(msg.value);
    }

    // Función para eliminar un miembro
    function removeMember(address _member) external onlyMember{
        require(members[_member], "No existe este miembro");
        members[_member] = false;
        emit MemberRemoved(_member);
        count = count - 1;
    }
    
    function getCount() external view returns (uint256) {
        return count;
    }

    // Función para verificar si una dirección es miembro
    function isMember(address _address) external view returns (bool) {
        return members[_address];
    }
}
