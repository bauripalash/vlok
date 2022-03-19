module lib

import time
import crypto.sha256

pub struct Vlok {
mut:
	index     int    [required]
	timestamp i64
	data      string [required]
	prev_hash string [required]
	self_hash string
}

fn (mut v Vlok) set_hash() {
	v.self_hash = sha256.hexhash(v.to_string())
}

pub fn (v Vlok) to_string() string {
	return 'VLOK[index: $v.index; timestamp: $v.timestamp; data: $v.data; prev_hash: $v.prev_hash; self: $v.self_hash]'
}

// Create a new block on the heap
pub fn new_vlok(index int, data string, prev_hash string) &Vlok {
	mut vlok_ := &Vlok{
		index: index
		timestamp: time.utc().unix
		data: data
		prev_hash: prev_hash
	}

	vlok_.set_hash()

	println('Block #$index =>\n$vlok_.to_string()')
	return vlok_
}

// genesis block creation
pub fn create_genesis() Vlok {
	return *new_vlok(0, '0', '0')
}

// takes the previous block and returns new block;
// this function creates a new block; previous block is necessary here
pub fn create_block(prev &Vlok, data string) &Vlok {
	nv := new_vlok(prev.index + 1, data, prev.self_hash)
	return nv
}
