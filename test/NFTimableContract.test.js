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

    it("Je teste la creation d'une collection", async () => {

        //Given
        let id = new BN(1);
        let amount = new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let NFTimableContractInstance = await NFTimableContract.new({ from: user1 });

        //when                                                     //uint256 id, uint256 amount, uint256 nftPriceUnit                                                          
        let result = await NFTimableContractInstance.createCollectible(id, amount, nftPriceUnit, { from: user1 });

        //Then
        assert.equal(result.receipt.status, true, "createCollectible fail");
        assert.equal(result.logs[1].event, "EventCreatingCollectible", "ne lance pas d\'event EventCreatingCollectible");
    });

    it("Je que l'utilisateur ne peut pas transferer de carte avec l'interface 1155 d'origine", async () => {

        //Given
        let id = new BN(1);
        let amount = new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let NFTimableContractInstance = await NFTimableContract.new({ from: user1 });
        let NFTimableContractInstanceAddress = NFTimableContractInstance.address;

        await NFTimableContractInstance.createCollectible(id, amount, nftPriceUnit, { from: user1 });

        //when 
        let result = await await truffleAssert.reverts(
            NFTimableContractInstance.safeTransferFrom(NFTimableContractInstanceAddress, user2, id, amount, [], { from: user2 }),
            "ERC1155: transfert locked");
    });

    it("Je teste l'achat d'une carte", async () => {

        //Given
        let id = new BN(1);
        let amount = new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let ethPrice = web3.utils.toWei('2', "ether");
        let NFTimableContractInstance = await NFTimableContract.new({ from: user1 });
        await NFTimableContractInstance.createCollectible(id, amount, nftPriceUnit, { from: user1 });

        //when 
        let result = await NFTimableContractInstance.buy(id, new BN(2), { from: user2, to: NFTimableContractInstance.address, value: ethPrice, gas: 0 })

        //Then
        assert.equal(result.receipt.status, true, "EventBuyingCollectible fail");
        assert.equal(result.logs[1].event, "EventBuyingCollectible", "ne lance pas d\'event EventBuyingCollectible");

        await NFTimableContractInstance.transferTo(user2, await web3.eth.getBalance(NFTimableContractInstance.address),{ from: user1, gas: 0 })
    });

    it("Je teste une revente et un reachat", async () => {

        //Given
        let id = new BN(1);
        let amount = new BN(1);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let ethPrice = web3.utils.toWei('1', "ether");
        let NFTimableContractInstance = await NFTimableContract.new({ from: user1 });
        await NFTimableContractInstance.createCollectible(id, amount, nftPriceUnit, { from: user1 });
        await NFTimableContractInstance.buy(id, amount, { from: user2, to: NFTimableContractInstance.address, value: ethPrice, gas: 0 })
        await NFTimableContractInstance.activateResellID(id, true);

        //when 
        let result = await NFTimableContractInstance.reSell(id, amount, { from: user2 });

        //Then
        assert.equal(result.receipt.status, true, "reSell fail");



        //When 
        // console.log("contract balance before buy:"+await web3.utils.fromWei(await web3.eth.getBalance(NFTimableContractInstance.address), 'ether'));
        result = await NFTimableContractInstance.buy(id, amount, { from: user3, to: NFTimableContractInstance.address, value: ethPrice, gas: 0 })
        // console.log("contract balance apres buy:"+await web3.utils.fromWei(await web3.eth.getBalance(NFTimableContractInstance.address), 'ether'));

        //then
        assert.equal(result.receipt.status, true, "buy fail");
        assert.equal(result.logs[1].event, "EventBuyingCollectible", "ne lance pas d\'event EventBuyingCollectible");


        //when 
        result = await NFTimableContractInstance.withdraw({ from: user2, gas: 0 });
        assert.equal(result.receipt.status, true, "withdraw fail");
    });

    it("Je le transfert d ETH vers une adresse avec transfertTo", async () => {

        //Given
        let id = new BN(1);
        let amount = new BN(10);
        let nftPriceUnit = web3.utils.toWei('1', "ether");
        let ethPrice = web3.utils.toWei('2', "ether");
        let NFTimableContractInstance = await NFTimableContract.new({ from: user1 });
        await NFTimableContractInstance.createCollectible(id, amount, nftPriceUnit, { from: user1 });
        await NFTimableContractInstance.buy(id, new BN(2), { from: user2, to: NFTimableContractInstance.address, value: ethPrice, gas: 0 })

        //when 
        let balanceBeforeTransfer=await web3.utils.fromWei(await web3.eth.getBalance(NFTimableContractInstance.address), 'ether');
        // console.log("balanceBeforeTransfer="+balanceBeforeTransfer);
        let result = await NFTimableContractInstance.transferTo(user2, ethPrice, { from: user1, gas: 0 })

        //Then
        let balanceAfterTransfer=await web3.utils.fromWei(await web3.eth.getBalance(NFTimableContractInstance.address), 'ether');
        // console.log("balanceAfterTransfer="+balanceAfterTransfer);
        assert.equal(result.receipt.status, true, "transferTo fail");
        assert.equal(result.logs[0].event, "EventTransferTo", "ne lance pas d\'event EventTransferTo");
        assert.equal(balanceAfterTransfer, 0, "balance error [balanceBeforeTransfer:"+balanceBeforeTransfer+"] [balanceAfterTransfer:"+balanceAfterTransfer+"]");

    });

});

