pragma solidity >=0.7.0 <0.9.0;

contract StringComparison {
    string public constant text = "Hello world!";

    function compare(string memory a, string memory b) public pure returns(bool) {
        return (keccak256(abi.encode(a)) == keccak256(abi.encode(b)));
    }
}
