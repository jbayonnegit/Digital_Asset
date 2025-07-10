// SPDX-Licenser-Identifier : MIT

pragma solidity 0.8.30;

import { ERC20 } from "src/ERC20.sol";

error NotOwner();
error TransferFailed();

contract MyToken { 

	address private _owner;
	ERC20   public Token;

	constructor (){

		Token = new ERC20( );
		_owner = msg.sender;
	}

	function _mint( address to, uint256 _amount )  public {
		Token.mint( to, _amount );
	}

	function _balanceOf( address to ) external view returns ( uint256 ) {
		return ( Token.balanceOf( to ) );
	}

	function _transfer( address to, uint256 amount ) external returns ( bool ) {
	   Token.transfer(to, amount);
	   return (true);
	}

	function _getAddress() external view returns ( address ){
		return ( Token.getAddress() );
	}

	// modifier OnlyOwner {
	//     if ( msg.sender != _owner )
	//         revert NotOwner();
	//     _;
	// }
}