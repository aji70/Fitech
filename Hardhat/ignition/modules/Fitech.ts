// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const initial_Owner = "0xAb538B8326AD8cacB8Ee25273fa18F813Cb73436";

const Fitech1Module = buildModule("FitechModule1", (m) => {
  const initialOwner = m.getParameter("initialOwner", initial_Owner);

  const fitechh = m.contract("Fitech", [initialOwner]);

  return { fitechh };
});

export default Fitech1Module;

// 9D2E6X9UM39NEUI1T9UPCGZR9CTGNJF5SN
