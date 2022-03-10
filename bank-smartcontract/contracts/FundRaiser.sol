// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Bank {
    address public companeyAddress;
    string public companeyName;
    mapping(address => uint256) public TotalDonation;

    constructor() {
        companeyAddress = msg.sender;
    }

    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some amount of money!");
        TotalDonation[msg.sender] += msg.value;
    }

    function setcompaneyName(string memory _name) external {
        require(
            msg.sender == companeyAddress,
            "You must be the owner to set the name of the bank"
        );
        companeyName = _name;
    }

    function withdrawMoney(address payable _to, uint256 _total) public {
        require(
            _total <= TotalDonation[msg.sender],
            "You have insuffient funds to withdraw"
        );

        TotalDonation[msg.sender] -= _total;
        _to.transfer(_total);
    }

    function getTotalDonation() external view returns (uint256) {
        return TotalDonation[msg.sender];
    }

    function getBankBalance() public view returns (uint256) {
        require(
            msg.sender == companeyAddress,
            "You must be the owner of the bank to see all balances."
        );
        return address(this).balance;
    }
}
