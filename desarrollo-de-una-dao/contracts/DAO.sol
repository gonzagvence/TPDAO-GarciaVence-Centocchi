// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Utilizamos El ReentrancyGuard de OpenZeppelin para evitar Reentrancy attacks
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./Member.sol";
import "./Ojeador.sol";
import "./JugadoresAFichar.sol";

contract DAO is ReentrancyGuard {

    // Struct para una Propuesta
    struct Proposal {
        address jugador; // Jugador a comprar
        uint256 deadline;
        uint256 votesFor;
        uint256 votesAgainst;
        bool executed;
        mapping(address => bool) voted;
    }

    // Variables de estado
    address public chairperson; //Owner del contrato
    mapping(uint256 => Proposal) public proposals; //Mapping de propuestas
    mapping(address => bool) public plantel; //Mapping de jugadores en el plantel
    uint256 public proposalCount; //Cantidad de propuestas
    Member public memberContract_;
    Ojeador public ojeadorContract_;
    JugadoresAFichar public jugadoresContract_;

    // Eventos
    event ProposalCreated(uint256 proposalId, address jugador, uint256 deadline);
    event VoteCast(address voter, uint256 proposalId, bool support);
    event ProposalExecuted(uint256 proposalId);

    // Modificadores
    modifier onlyChairperson() {
        require(msg.sender == chairperson, "Solo el presidente puede realizar esta accion");
        _;
    }

    modifier onlyMember() {
        require(memberContract_.isMember(msg.sender), "Solo miembros pueden realizar esta accion");
        _;
    }

    // Constructor
    constructor(address memberContract, address ojeadorContract, address jugadoresContract) {
        chairperson = msg.sender; //Generamos presidente del club
        memberContract_ = Member(memberContract);
        ojeadorContract_ = Ojeador(ojeadorContract);
        jugadoresContract_ = JugadoresAFichar(jugadoresContract);
        proposalCount = 0; //Cantidad de propuestas seteadas en 0
    }

    // Función para crear una nueva propuesta
    function createProposal(address _jugador, uint256 _duration) external onlyMember {
        require(_duration > 0, "La duracion debe ser mayor a 0.");
        require(jugadoresContract_.existeJug(_jugador), "El jugador tiene que estar en la prelista.");
        require(!plantel[_jugador], "El jugador ya esta en el plantel.");

        Proposal storage prop = proposals[proposalCount]; //Generamos un struct de propuestas
        prop.jugador = _jugador; //Guardamos todos los datos
        prop.deadline = block.timestamp + _duration;
        prop.executed = false;
        prop.votesFor = 0;
        prop.votesAgainst = 0;

        emit ProposalCreated(proposalCount, _jugador, prop.deadline);

        proposalCount = proposalCount + 1; //Sumamos 1 en la cantidad de propuestas
    }

    // Función para votar una propuesta
    function vote(uint256 _proposalId, bool _support) external onlyMember {
        Proposal storage prop = proposals[_proposalId]; //Identificamos la propuesta por id
        require(block.timestamp <= prop.deadline, "La votacion ha terminado.");
        require(!prop.voted[msg.sender], "Ya has votado en esta propuesta.");

        prop.voted[msg.sender] = true; 

        if (_support) { //Asignamos voto positivo o negativo
            prop.votesFor++;
        } else {
            prop.votesAgainst++;
        }

        emit VoteCast(msg.sender, _proposalId, _support);
    }

    // Función para ejecutar una propuesta
    function executeProposal(uint256 _proposalId) external nonReentrant onlyChairperson {
        Proposal storage prop = proposals[_proposalId]; //Identificamos propuesta
        require((prop.votesAgainst + prop.votesFor) >= (memberContract_.getCount() / 2), "La votacion no termino");
        require(!prop.executed, "La propuesta ya se ha ejecutado.");
        require(prop.votesFor > prop.votesAgainst, "La propuesta no fue aprobada.");

        uint256 jugadorPrecio = jugadoresContract_.obtenerPrecio(prop.jugador); //Obtenemos jugador
        require(address(this).balance >= jugadorPrecio, "Fondos insuficientes.");

        (bool success, ) = payable(prop.jugador).call{value: jugadorPrecio}(""); //Pagamos transferencia
        require(success, "Transferencia de fondos fallida.");

        prop.executed = true; //Actualizamos estados
        plantel[prop.jugador] = true; //Agregamos a plantel

        emit ProposalExecuted(_proposalId);
    }

    function getProposal(uint256 num) external view returns (address) {
        Proposal storage prop = proposals[num];
        return prop.jugador;
    }

    // Función para la administración de fondos
    function manageFunds() external onlyChairperson payable {

    }
}