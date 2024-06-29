const DAO = artifacts.require("DAO");
const Member = artifacts.require("Member");

contract("DAO", accounts => {
  let daoInstance;
  let memberInstance;

  before(async () => {
    memberInstance = await Member.deployed();
    daoInstance = await DAO.deployed();
  });

  it("debería añadir un nuevo miembro", async () => {
    await memberInstance.addMember(accounts[0]);
    const isMember = await memberInstance.isMember(accounts[0]);
    assert(isMember, "La cuenta debería ser miembro");
  });

  it("debería crear una nueva propuesta", async () => {
    await daoInstance.createProposal("Propuesta de prueba", 3600, { from: accounts[0] });
    const proposal = await daoInstance.proposals(1);
    assert.equal(proposal.description, "Propuesta de prueba", "La descripción de la propuesta debería coincidir");
  });

  it("debería permitir a los miembros votar", async () => {
    await daoInstance.vote(1, true, { from: accounts[0] });
    const proposal = await daoInstance.proposals(1);
    assert.equal(proposal.votesFor, 1, "La propuesta debería tener un voto a favor");
  });

  it("debería ejecutar una propuesta", async () => {
    await daoInstance.executeProposal(1, { from: accounts[0] });
    const proposal = await daoInstance.proposals(1);
    assert(proposal.executed, "La propuesta debería ser ejecutada");
  });
});
