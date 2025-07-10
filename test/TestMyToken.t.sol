// SPDX-Licence-Identifier : MIT

pragma solidity ^0.8.30;

import { Vm } from "forge-std/Vm.sol";
import { stdError } from "forge-std/StdError.sol";
import { DeployMyToken } from "../script/DeployMyToken.s.sol";
import { MyToken } from "../src/MyToken.sol";
import { Test } from "forge-std/Test.sol";
import { console } from "forge-std/console.sol";

contract MyTokenTest is Test{

	MyToken         _token;
	DeployMyToken   _deploy;
	address         USER;
	address         USER1;

	function setUp() external {

		_deploy = new DeployMyToken();
		_token = _deploy.run();
		USER = address( 1 );
		USER1 = address( 2 );
	}

	function testMint() public{

		_token._mint( USER, 10 );
		console.log( _token._balanceOf( USER ) );
	}

	function testTransfert() public{
		
		_token._mint( USER, 10 );
		vm.startPrank( USER );
		_token._transfer( USER1 , 5 );
		vm.stopPrank();
		assertEq(_token._balanceOf(USER), 5);
		assertEq(_token._balanceOf(USER1), 5);
	}
}