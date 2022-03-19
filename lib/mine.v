module lib

import rand
import math
import time

// Structure of Block Data
pub struct BlockData {
	pow         string      // proof of work of block
	transaction Transaction // json formatter Transaction information
}

const miner_addr = rand.uuid_v4() // a random miner address

pub fn create_new_transaction(from string, to string, amount u64) Transaction {
	output := Transaction{
		from: from
		to: to
		amount: amount
	}
	return output
}

// do the proof of work
// find a integer after the last proof of work which is divisible by 2 and 5
pub fn po_work(last string) u64 {
	l := last.u64()
	mut inc := l + math.abs(rand.u64())
	for {
		if inc % 2 == 0 && inc % 5 == 0 {
			break
		} else {
			inc += 1
		}
	}
	return inc
}

pub fn mine(last_block &Vlok) &Vlok {
	last_block_data := last_block.data

	pow_for_new_block := po_work(last_block_data.pow).str() // proof of work for new block
	block_transcation := create_new_transaction('galaxy', lib.miner_addr, 1) // block reward for the miner from 'galaxy' aka. network

	// Structural data to be converted to json
	raw_data_for_new_block := &BlockData{
		pow: pow_for_new_block
		transaction: block_transcation
	}

	// json data for new block
	time.sleep(time.second)
	return create_block(last_block, raw_data_for_new_block)
}
