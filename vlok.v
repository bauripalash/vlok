module main

import lib

const (
	chain_path = 'chaindata.json'
)

fn main() {
	println("Chain -> P")
	mut blockchain := lib.Pchain{
		blocks: [lib.create_genesis()]
		length: 1
	}

	for _ in 1 .. 5 {
		mined_block := lib.mine(blockchain.lastblock())
		blockchain.push(mined_block)
	}

	println("Chain -> P <- END")
	println("Chain -> Q")
	mut new_chain := blockchain
	//println(new_chain.lastblock())
	new_mine := lib.mine(new_chain.lastblock())
	//println(new_mine)
	new_chain.push(new_mine)
	//println(blockchain)

	println("Chain -> Q <- END")

	blockchain.chain_merge(new_chain)

	//println(blockchain)
	//println(new_chain)

	//println(blockchain.blocks[2].is_same(blockchain.blocks[1]))
	// println("Testing blockchain")
	// println(blockchain.is_valid())
	//blockchain.dumpdata(chain_path) ?
}
