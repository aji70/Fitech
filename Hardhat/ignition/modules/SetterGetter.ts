// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SetterGetterModule = buildModule("SetterGetterModule", (m) => {
  const seterGetter = m.contract("SetterGetter");

  return { seterGetter };
});

export default SetterGetterModule;
