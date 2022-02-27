// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "remix_tests.sol"; // this import is automatically injected by Remix.
import "../contracts/3_Ballot.sol";
import "remix_accounts.sol";
import "hardhat/console.sol";

contract BallotTest {
   
    bytes32[] proposalNames;
   
    Ballot ballotToTest;
    Ballot ballotToTest2;
    function beforeAll () public {
        proposalNames.push(bytes32("candidate1"));
        ballotToTest = new Ballot(proposalNames);
        ballotToTest2 = new Ballot(proposalNames);
    }
    
    // function checkWinningProposal () public {
    //     ballotToTest.vote(0);
    //     Assert.equal(ballotToTest.winningProposal(), uint(0), "proposal at index 0 should be the winning proposal");
    //     Assert.equal(ballotToTest.winnerName(), bytes32("candidate1"), "candidate1 should be the winner name");
    // }
    
    // function checkWinninProposalWithReturnValue () public view returns (bool) {
    //     return ballotToTest.winningProposal() == 0;
    // }

    function checkGiveRightToVote () public {
        uint256 startGas = gasleft();
        for(uint256 i = 0; i < 10; i++) {
            ballotToTest.giveRightToVote(TestsAccounts.getAccount(i));
        }

        uint256 gasUsed = startGas - gasleft();
        console.log(gasUsed);
        
        uint256 startGasImproved = gasleft();

        address[] memory voterAddresses = new address[](10);
        for(uint256 i = 0; i < 10; i++) {
            voterAddresses[i] = TestsAccounts.getAccount(i);
        }
        ballotToTest2.giveRightToVoteImproved(voterAddresses);
        uint256 gasUsedImproved = startGasImproved - gasleft();
        console.log(gasUsedImproved);

        Assert.greaterThan(gasUsed, gasUsedImproved, "not improved!");

    }
}
