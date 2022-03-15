module main

import time
import crypto.sha256

struct Vlok{

mut:
	index int [required]
	timestamp string [required]
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

fn new_vlok(index int , data string , prev_hash string) &Vlok{
	
	t := time.utc()
	timestamp := "$t.unix"
	mut vlok_ := &Vlok{index: index, timestamp: timestamp, data: data, prev_hash: prev_hash}
	vlok_.set_hash()
	return vlok_
}


fn main() {
	genesis := new_vlok(0, "0" , "0")
	v1 := new_vlok(1,"1", genesis.self_hash )
	println('$genesis.to_string() \n $v1.to_string()')
}
