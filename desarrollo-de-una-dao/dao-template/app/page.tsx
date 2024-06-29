'use client'
import { useEffect, useState } from 'react';
import { ethers } from 'ethers';
import AddMember from './components/AddMember';
import CreateProposal from './components/CreateProposal';
import Vote from './components/Vote';

const DAO_ABI = [
  // Aca va el ABI del contrato
];

const CONTRACT_ADDRESS = 'LA_DIRECCIÓN_DEL_CONTRATO';

export default function App() {
  const [provider, setProvider] = useState<ethers.BrowserProvider | null>(null);
  const [signer, setSigner] = useState<ethers.Signer | null>(null);
  const [contract, setContract] = useState<ethers.Contract | null>(null);

  useEffect(() => {
    const init = async () => {
      if (window.ethereum) {
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        const web3Provider = new ethers.BrowserProvider(window.ethereum);
        setProvider(web3Provider);

        const web3Signer = await web3Provider.getSigner();
        setSigner(web3Signer);

        const daoContract = new ethers.Contract(CONTRACT_ADDRESS, DAO_ABI, web3Signer);
        setContract(daoContract);
      } else {
        console.error("Please install MetaMask!");
      }
    };
    init();
  }, []);

  if (!contract) {
    return <div>Loading...</div>;
  }

  return (
    <div className="min-h-screen bg-gray-100 flex flex-col items-center justify-center">
      <h1 className="text-3xl font-bold mb-8">DAO Frontend</h1>
      <AddMember contract={contract} />
      <CreateProposal contract={contract} />
      <Vote contract={contract} />
    </div>
  );
}
