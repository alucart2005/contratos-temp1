import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("TestConstructorModule", (m) => {
  const testConstructor = m.contract("TestConstructor");

  return { testConstructor };
});