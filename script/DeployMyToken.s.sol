// SPDX-License-Identifier : MIT

pragma solidity ^0.8.30;

import { Script } from "forge-std/Script.sol";
import { MyToken } from "../src/MyToken.sol";

contract DeployMyToken is Script {

	MyToken	_token;

	function run() external returns ( MyToken ) {

		vm.startBroadcast();
		_token = new MyToken();
		vm.stopBroadcast();

		return ( _token );
	}
}