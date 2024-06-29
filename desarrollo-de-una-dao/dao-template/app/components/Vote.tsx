'use client'
import { useState } from 'react';
import { ethers } from 'ethers';

type Props = {
  contract: ethers.Contract;
};

const Vote = ({ contract }: Props) => {
  const [proposalId, setProposalId] = useState('');
  const [support, setSupport] = useState(true);

  const vote = async () => {
    try {
      const tx = await contract.vote(proposalId, support);
      await tx.wait();
      alert('Voto registrado exitosamente');
    } catch (error) {
      console.error(error);
      alert('Error registrando voto');
    }
  };

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Votar en Propuesta</h2>
      <input
        type="number"
        value={proposalId}
        onChange={(e) => setProposalId(e.target.value)}
        placeholder="ID de la propuesta"
        className="p-2 border border-gray-300 rounded"
      />
      <select
        value={support ? 'yes' : 'no'}
        onChange={(e) => setSupport(e.target.value === 'yes')}
        className="p-2 border border-gray-300 rounded ml-2"
      >
        <option value="yes">A Favor</option>
        <option value="no">En Contra</option>
      </select>
      <button onClick={vote} className="ml-2 p-2 bg-blue-500 text-white rounded">
        Votar
      </button>
    </div>
  );
};

export default Vote;
