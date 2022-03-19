module main

import lib

const (
	chain_path = 'chaindata.json'
)

fn main() {
	mut blockchain := lib.Pchain{
		blocks: [lib.create_genesis()]
		length: 1
	}

	for _ in 1 .. 5 {
		mined_block := lib.mine(blockchain.lastblock())
		blockchain.push(mined_block)
	}
	// println("Testing blockchain")
	// println(blockchain.is_valid())
	blockchain.dumpdata(chain_path) ?
}
