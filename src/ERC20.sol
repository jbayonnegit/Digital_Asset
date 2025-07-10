// SPDX-Licence-Identifier : MIT

pragma solidity 0.8.30;
import { IERC20 } from "chainlink-brownie-contracts/contracts/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";

contract ERC20 is IERC20{

	string private												SYMBOLE;
	string private												NAME;
	uint256 private												_totalSupply;
	mapping( address => uint256 ) private						_balance;
	mapping( address => mapping( address => uint256 )) private 	_allowance;
	
	constructor( string memory _symbole , string memory _name ){

		_totalSupply = 0;
		SYMBOLE = _symbole;
		NAME = _name;
	}

	function balanceOf( address _wallet ) external view returns ( uint256 success ){
		return ( _balance[ _wallet ] );
	}

	function transfer( address to, uint256 amount ) public returns ( bool success ){

		if ( _balance[ msg.sender ] < amount || msg.sender == to )
			return ( false );
		_balance[ to ] += amount;
		_balance[ msg.sender ] -= amount;
		emit Transfer( msg.sender, to , amount );
		return ( true );
	}

	function transferFrom( address from, address to, uint256 _amount ) public returns ( bool success ){

		if ( allowance( from, msg.sender ) < _amount ){
			return ( false );
		}
		_balance[ from ] -= _amount;
		_allowance[ from ][ msg.sender ] -= _amount;
		_balance[ to ] += _amount;
		emit Transfer( from , to , _amount );
		return ( true );
	}

	function approve( address _sender, uint256 _value ) public returns ( bool success){

		if ( _sender == address(0) || _allowance[ msg.sender ][ _sender ] != 0 )
			return ( false );
		_allowance[ msg.sender ][ _sender ] = _value;
		emit Approval( msg.sender, _sender, _value );
		return ( true );
	}

	function allowance( address _owner, address _sender ) public view returns ( uint256 remaining ){

		return ( _allowance[ _owner ][ _sender ] );
	}

	function totalSupply() public view  returns( uint256 ){

		return ( _totalSupply );
	}

	function mint( address to, uint256 amount ) public returns ( bool success ){

		_balance[ to ] += amount;
		_totalSupply += amount;
		return ( true );
	}
}