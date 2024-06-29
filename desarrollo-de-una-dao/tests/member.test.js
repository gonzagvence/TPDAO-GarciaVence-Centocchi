const Member = artifacts.require("Member");

contract("Member", accounts => {
  let memberInstance;

  before(async () => {
    memberInstance = await Member.deployed();
  });

  it("debería añadir un nuevo miembro", async () => {
    await memberInstance.addMember(accounts[0]);
    const isMember = await memberInstance.isMember(accounts[0]);
    assert(isMember, "La cuenta debería ser miembro");
  });

  it("debería eliminar un miembro", async () => {
    await memberInstance.removeMember(accounts[0]);
    const isMember = await memberInstance.isMember(accounts[0]);
    assert(!isMember, "La cuenta no debería ser miembro");
  });
});
