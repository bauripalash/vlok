module main

import time
import crypto.sha256

struct Vlok{

mut:
	index int [required]
	timestamp i64
	data string [required]
	prev_hash string [required]
	self_hash string

}

fn (mut v Vlok) set_hash(){
	
	v.self_hash = sha256.hexhash(v.to_string())

}

fn (v Vlok) to_string() string{

	return "VLOK[i->$v.index| t->$v.timestamp| d->$v.data| ph->$v.prev_hash| sh->$v.self_hash]"

}


// Create a new block on the heap
fn new_vlok(index int , data string , prev_hash string) &Vlok{
	
	
	mut vlok_ := &Vlok{index: index, timestamp: time.utc().unix, data: data, prev_hash: prev_hash}
	
	vlok_.set_hash()

	println("Block #$index => [$vlok_.to_string()]")
	return vlok_

}

//genesis block creation
fn create_genesis() &Vlok{
	
	return new_vlok(0 , "0" , "0")

}


// takes the previous block and returns new block;
// this function creates a new block; previous block is necessary here
fn create_block(prev &Vlok , data string) &Vlok{
	
	nv := new_vlok(prev.index + 1 , data , prev.self_hash )
	return nv

}


fn main() {
	genesis := new_vlok(0, "0" , "0")
	st := time.Duration(1000000000) //1 second
	mut chain := [genesis]
	for i:=1; i<=10; i+=1{
		
		chain << create_block( chain[i-1] , "block number $i" )
		
		time.sleep(st) //If it doesn't sleep; most of the blocks will have the same time-stamp

	}
}
