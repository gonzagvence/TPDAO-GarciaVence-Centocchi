'use client'
import { useState } from 'react';
import { ethers } from 'ethers';

type Props = {
  contract: ethers.Contract;
};

const CreateProposal = ({ contract }: Props) => {
  const [description, setDescription] = useState('');
  const [duration, setDuration] = useState('');

  const createProposal = async () => {
    try {
      const durationInSeconds = parseInt(duration) * 60;
      const tx = await contract.createProposal(description, durationInSeconds);
      await tx.wait();
      alert('Propuesta creada exitosamente');
    } catch (error) {
      console.error(error);
      alert('Error creando propuesta');
    }
  };

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Crear Propuesta</h2>
      <input
        type="text"
        value={description}
        onChange={(e) => setDescription(e.target.value)}
        placeholder="Descripción de la propuesta"
        className="p-2 border border-gray-300 rounded"
      />
      <input
        type="number"
        value={duration}
        onChange={(e) => setDuration(e.target.value)}
        placeholder="Duración en minutos"
        className="p-2 border border-gray-300 rounded ml-2"
      />
      <button onClick={createProposal} className="ml-2 p-2 bg-blue-500 text-white rounded">
        Crear
      </button>
    </div>
  );
};

export default CreateProposal;
