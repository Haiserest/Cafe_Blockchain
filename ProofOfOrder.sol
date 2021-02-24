pragma solidity ^0.5.1;

contract ProofOfOrder {  
    
    struct Ordersdata{
        string name;
        uint timestamp;
        address addr;
    }

    //mapping (bytes32 => bool) private listOrder;
    mapping (uint => string) private listName;
    mapping (uint => uint) private listTimestamp;
    mapping (uint => address) private listAddress;
    mapping (uint => Ordersdata) private listOrder;
  
    //--Event--
    event OrderAdded(
      address from,
      string text,
      uint datetime,
      bytes32 hash
      );
      
    event OrderError(
        address from,
        string text,
        string reason
      );
      
    uint ordercount = 0;

    //store the proof for order in contract state
    function recordNameOrder(string memory name) private{
        listName[ordercount] = name;
    }
  
    function recordTimestampOrder(uint date) private{
        listTimestamp[ordercount] = date;
    }
  
    function recordAddressOrder(address addr) private{
        listAddress[ordercount] = addr;
    }
  
    function recordOrder(Ordersdata memory data_order) private{
        listOrder[ordercount] = data_order;
    }
  
    //record Order
    function GetOrder(string memory name) public payable{
        //Late Coffee
        if (msg.value != 0.011 ether && hashing(name) == hashing("Late Coffee")){
          
            emit OrderError(msg.sender, name,
                "Incorrect amount of ether. 0.011 ether for Order");
          
            msg.sender.transfer(msg.value);
          
        return;
        }
      
        //Thai Tea
        if (msg.value != 0.014 ether && hashing(name) == hashing("Thai tea")){
          
            emit OrderError(msg.sender, name,
                "Incorrect amount of ether. 0.014 ether for Order");
          
            msg.sender.transfer(msg.value);
          
        return;
        }
      
        //Green Tea
        if (msg.value != 0.015 ether && hashing(name) == hashing("Green Tea")){
          
            emit OrderError(msg.sender, name,
                "Incorrect amount of ether. 0.015 ether for Order");
          
            msg.sender.transfer(msg.value);
          
        return;
        }
      
        //Friedrice
        if (msg.value != 0.025 ether && hashing(name) == hashing("Friedrice")){
          
            emit OrderError(msg.sender, name,
                "Incorrect amount of ether. 0.025 ether for Order");
          
            msg.sender.transfer(msg.value);
          
        return;
        }
      
        //Steak
        if (msg.value != 0.03 ether && hashing(name) == hashing("Steak")){
          
            emit OrderError(msg.sender, name,
                "Incorrect amount of ether. 0.03 ether for Order");
          
            msg.sender.transfer(msg.value);
          
        return;
        }
      
        //Noodles
        if (msg.value != 0.028 ether && hashing(name) == hashing("Noodles")){
          
            emit OrderError(msg.sender, name,
                "Incorrect amount of ether. 0.028 ether for Order");
          
            msg.sender.transfer(msg.value);
          
        return;
        }
      
        Ordersdata memory orderdata = Ordersdata(name, block.timestamp, msg.sender);
        recordNameOrder(name);
        recordTimestampOrder(now);
        recordAddressOrder(msg.sender);
        recordOrder(orderdata);
        ordercount++;
      
        emit OrderAdded(msg.sender, name, now,
            hashingOrder(name, now, msg.sender));
    }
  
    //SHA256 for Integrity
    function hashing(string memory name) private
        pure returns (bytes32){
            return sha256(bytes(name));
        }
  
    function hashingOrder(string memory name, uint timestamp, address addr) private
        pure returns (bytes32){
            return sha256(abi.encodePacked(name, timestamp, addr));
        }
      
    //get Name 
    function getName(uint index) public view returns (string memory){
        return listName[index];
    }
    //get timestamp
    function getTimestamp(uint index) public view returns (uint){
        return listTimestamp[index];
    }
    //get address
    function getAddress(uint index) public view returns (address){
        return listAddress[index];
    }
    //get countorder
    function getOrderCount() public view returns (uint){
        return ordercount;
    }
}
