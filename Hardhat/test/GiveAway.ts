import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("GiveAway", function () {
  async function deployGiveAwayContract() {
    // Hardhat gives us 20 addresses we are removing 2 to use we named the first one owner
    const [owner, otherAccount] = await hre.ethers.getSigners();

    // creating an instance of a contract type
    const GiveAway = await hre.ethers.getContractFactory("GiveAway");

    // deploying the contract instance created above
    const giveAway = await GiveAway.deploy(owner);

    return { owner, otherAccount, giveAway };
  }

  describe("Deployment", function () {
    it("Should set the Correct Name", async function () {
      const { giveAway } = await loadFixture(deployGiveAwayContract);
      const name_from_contract = await giveAway.name();
      expect(name_from_contract).to.equal("Fitech");
    });
    it("Should set the Correct symbol", async function () {
      const { giveAway } = await loadFixture(deployGiveAwayContract);
      const symbol_from_contract = await giveAway.symbol();
      expect(symbol_from_contract).to.equal("FIT");
    });
    it("Should set the Correct Owner", async function () {
      const { giveAway, owner } = await loadFixture(deployGiveAwayContract);
      const owner_from_contract = await giveAway.owner();
      expect(owner_from_contract).to.equal(owner);
    });
  });

  describe("Participate", function () {
    it("Should give the winner his Money", async function () {
      const { giveAway, otherAccount } = await loadFixture(
        deployGiveAwayContract
      );

      const users_balance_from_contract_before = Number(
        await giveAway.balanceOf(otherAccount.address)
      );

      console.log("users balance before: ", users_balance_from_contract_before);
      await giveAway.connect(otherAccount).participate();

      const users_balance_from_contract = Number(
        await giveAway.balanceOf(otherAccount.address)
      );

      console.log("users balance after: ", users_balance_from_contract);
      const reward_amount_from_contract = await giveAway.rewardAmount();

      expect(users_balance_from_contract).to.equal(reward_amount_from_contract);
    });
    it("Should deduct from the price pool", async function () {
      const { giveAway, otherAccount } = await loadFixture(
        deployGiveAwayContract
      );

      const reward_amount = await giveAway.rewardAmount();
      const pricePoolb4 = await giveAway.price_pool();

      console.log("price pool after: ", pricePoolb4);

      await giveAway.connect(otherAccount).participate();

      const pricePoolafter = await giveAway.price_pool();

      console.log("price pool after: ", pricePoolafter);

      expect(pricePoolafter).to.equal(pricePoolb4 - reward_amount);
    });
    it("Should not allow winners participate", async function () {
      const { giveAway, otherAccount } = await loadFixture(
        deployGiveAwayContract
      );
      await giveAway.connect(otherAccount).participate();
      // calling the function again
      await expect(
        giveAway.connect(otherAccount).participate()
      ).to.be.revertedWith("Already won");
    });
  });
});
