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

	mut new_chain := blockchain
	println(new_chain.lastblock())
	new_chain.blind_push(lib.mine(new_chain.lastblock()))
	println(new_chain.is_valid())

	blockchain.chain_merge(new_chain)

	println(new_chain)
	//println(new_chain)

	//println(blockchain.blocks[2].is_same(blockchain.blocks[1]))
	// println("Testing blockchain")
	// println(blockchain.is_valid())
	//blockchain.dumpdata(chain_path) ?
}
