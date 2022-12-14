// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Pharma {
      address  public logistic;
      address  public pharma;
      address public owner;
      address public device;

      bool pharmaDeposited;

     int32 min_tem = 10;
     int32 min_hum  = 23;

      struct condition {
          int32 temperature;
          int32 humidity; 
      }
    
      constructor(address _pharma, address _logistic, address _device){
        owner = msg.sender;
        pharma = _pharma;
        logistic = _logistic;
        device = _device;
      }

        modifier onlyLogistic{
            require(msg.sender == owner, "Sender is not owner");
            _;
        }

        modifier onlyDevice {
            require(msg.sender == device, "Can be called from device");
            _;
        }


      receive() external payable{}
    //  fallback() external payable {}
      
    function updateCondition(condition memory con) public onlyDevice {
        if(con.temperature < min_tem || con.humidity < min_hum ) {
            require(address(this).balance == 10000, "Not enough balance");
            payable(pharma).transfer(10000);
        }
    } 

      function pharmaDeposit() external payable{
         require(!pharmaDeposited, "Transaction already happened");
          require(msg.sender == pharma);
          require(msg.value == 10000, "Invalid Value "); 
           pharmaDeposited = true;
      }

      function transitComplete() external {
          require(pharmaDeposited, "No money deposited yet");
          require(msg.sender == logistic);
          payable(logistic).transfer(10000);
      }
    
}