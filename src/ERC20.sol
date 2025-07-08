// SPDX-Licence-Identifier : MIT

pragma solidity ^0.8.18;

contract ERC20{

	string private                              				SYMBOLE;
	string private                              				NAME;
	mapping( address => uint256 ) private						balance;
	mapping( address => mapping( address => uint256 )) private 	s_allowance;

	event Transfert( address from, address to, uint256 amount );
	event e_AskedForBalenceOf( address from, address _wallet );
	event Approval(address indexed _owner, address indexed _spender, uint256 _value);

	constructor( string memory _symbole , string memory _name){

		SYMBOLE = _symbole;
		NAME = _name;
	}

	function balanceOf( address _wallet ) public returns ( uint256 success){

		emit e_AskedForBalenceOf( msg.sender, _wallet);
		return ( balance[ _wallet ] );
	}

	function transfer( address to, uint256 amount ) public returns ( bool success){
		if ( balance[ msg.sender ] < amount || msg.sender == to )
			return ( false );
		balance[ to ] += amount;
		balance[ msg.sender ] -= amount;
		emit Transfert( msg.sender, to , amount );
		return ( true );
	}

	function transferFrom( address from, address to, uint256 _amount ) public returns ( bool success){
		
		if ( allowance( from, msg.sender ) < _amount )
			return ( false );
		balance[ from ] -= _amount;
		s_allowance[ from ][ msg.sender ] -= _amount;
		balance[ to ] += _amount;
		emit Transfert( from , to , _amount );
		return ( true );
	}

	function approve( address _sender, uint256 _value ) public returns ( bool success){
		if ( _sender == address(0) || s_allowance[ msg.sender ][ _sender ] != 0 )
			return ( false );
		s_allowance[ msg.sender ][ _sender ] = _value;
		emit Approval( msg.sender, _sender, _value );
		return ( true );
	}

	function allowance( address _owner, address _sender ) public view returns ( uint256 remaining){
		return ( s_allowance[ _owner ][ _sender ] );
	}
}