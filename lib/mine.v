module lib

import rand
import math
import json


// Structure of Block Data 
pub struct BlockData {
	pow         i64 //proof of work of block
	transaction string //json formatter Transaction information
}


const miner_addr = rand.uuid_v4() //a random miner address


pub fn create_new_transaction(from string, to string, amount u64) &Transaction {
	output := &Transaction{
		from: from
		to: to
		amount: amount
	}
	return output
}

//do the proof of work
//find a integer after the last proof of work which is divisible by 2 and 5
pub fn po_work(last i64) i64 {
	mut inc := last + math.abs(rand.i64())
	for {
		if inc % 2 == 0 && inc % 5 == 0{
			return inc
		} else {
			inc += 1
		}
	}
	return 0
}

pub fn mine(last_block &Vlok) &Vlok {
	last_block_data := json.decode(BlockData, last_block.data) or {
		eprintln('No proof of work present in block $last_block.index')
		exit(1)
	}

	pow_for_new_block := po_work(last_block_data.pow) //proof of work for new block
	block_transcation := create_new_transaction('galaxy', lib.miner_addr, 1) //block reward for the miner from 'galaxy' aka. network
	raw_data_for_new_block := &BlockData{
		pow: pow_for_new_block
		transaction: json.encode(block_transcation)
	} // data for new block
	data_fnb := json.encode(raw_data_for_new_block)
	return create_block(last_block, data_fnb)
}

fn init() {
	// println(rand.string(10))
	println(lib.miner_addr)
}
