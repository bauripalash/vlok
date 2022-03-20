module main

import lib

const (
	chain_path = 'chaindata.json'
)

fn start_server(p &lib.Pchain)?{
	
	lib.start_server(p)?

}

fn main() {
		
	println("Chain -> P")
	mut blockchain := lib.Pchain{
		blocks: [lib.create_genesis()]
		length: 1
	}

	sh := go start_server(&blockchain)
	for _ in 1 .. 5 {
		mined_block := lib.mine(blockchain.lastblock())
		blockchain.push(mined_block)
	}

	println("Chain -> P <- END")
	println("Chain -> Q")
	mut new_chain := blockchain
	new_mine := lib.mine(new_chain.lastblock())
	new_chain.push(new_mine)

	println("Chain -> Q <- END")

	blockchain.chain_merge(new_chain)

	sh.wait()?
}
