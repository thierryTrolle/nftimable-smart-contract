// const { expectEvent, expectRevert, BN } = require('@openzeppelin/test-helpers');
const NFTimableContract = artifacts.require('NFTimableContract');
const truffleAssert = require('truffle-assertions');
const {
    BN,           // Big Number support
    constants,    // Common constants, like the zero address and largest integers
    expectEvent,  // Assertions for emitted events
    expectRevert, // Assertions for transactions that should fail
  } = require('@openzeppelin/test-helpers');


contract("NFTimableContract", function (accounts) {

    let [user1, user2, user3] = accounts;

    // let NFTimableContractInstance;

    // beforeEach(async function () {
    //     // this.NFTimableContractInstance = NFTimableContract;
    // });

    it("Je teste la creation d'une collection", async () => {

        //Given
        let id=new BN(1);
        let amount=new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let NFTimableContractInstance=await NFTimableContract.new({ from: user1 });

        //when                                                     //uint256 id, uint256 amount, uint256 nftPriceUnit                                                          
        let result = await NFTimableContractInstance.createCollectible(id,amount,nftPriceUnit,{ from: user1 });

        //Then
        assert.equal(result.receipt.status, true, "createCollectible fail");
        assert.equal(result.logs[1].event, "EventCreatingCollectible", "ne lance pas d\'event EventCreatingCollectible");
    });

    it("Je que l'utilisateur ne peut pas transferer de carte avec l'interface 1155 d'origine", async () => {

        //Given
        let id=new BN(1);
        let amount=new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let NFTimableContractInstance=await NFTimableContract.new({ from: user1 });
        let NFTimableContractInstanceAddress=NFTimableContractInstance.address;

        await NFTimableContractInstance.createCollectible(id,amount,nftPriceUnit,{ from: user1 });

        //when 
        let result = await await truffleAssert.reverts(
            NFTimableContractInstance.safeTransferFrom( NFTimableContractInstanceAddress, user2, id, amount,[],{ from: user2}),
            "ERC1155: transfert locked");
    });

    it("Je teste l'achat d'une carte", async () => {

        //Given
        let id=new BN(1);
        let amount=new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let ethPrice = web3.utils.toWei('2', "ether");
        let NFTimableContractInstance=await NFTimableContract.new({ from: user1 });
        await NFTimableContractInstance.createCollectible(id,amount,nftPriceUnit,{ from: user1 });

        //when 
        let result = await NFTimableContractInstance.buy( id, 2,{ from: user2, to: NFTimableContractInstance.address, value: ethPrice, gas:0  })

        // //Then
        assert.equal(result.receipt.status, true, "EventBuyingCollectible fail");
        assert.equal(result.logs[1].event, "EventBuyingCollectible", "ne lance pas d\'event EventBuyingCollectible");
    });
});