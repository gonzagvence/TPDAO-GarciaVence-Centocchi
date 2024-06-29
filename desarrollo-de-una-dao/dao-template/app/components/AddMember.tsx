'use client'
import { useState } from 'react';
import { ethers } from 'ethers';

type Props = {
  contract: ethers.Contract;
};

const AddMember = ({ contract }: Props) => {
  const [address, setAddress] = useState('');

  const addMember = async () => {
    try {
      const tx = await contract.addMember(address);
      await tx.wait();
      alert('Miembro añadido exitosamente');
    } catch (error) {
      console.error(error);
      alert('Error añadiendo miembro');
    }
  };

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Añadir Miembro</h2>
      <input
        type="text"
        value={address}
        onChange={(e) => setAddress(e.target.value)}
        placeholder="Dirección del miembro"
        className="p-2 border border-gray-300 rounded"
      />
      <button onClick={addMember} className="ml-2 p-2 bg-blue-500 text-white rounded">
        Añadir
      </button>
    </div>
  );
};

export default AddMember;
