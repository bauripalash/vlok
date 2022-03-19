module main

import lib
import time
const (
	chain_path = "chaindata.txt"
)

fn main() {
	mut blockchain := lib.Pchain{blocks: [lib.create_genesis()] , length:1}

	for i in 1..5{
		
		blockchain.push(lib.mine(blockchain.lastblock()))
		time.sleep(1*time.second) //without sleep; all block would have same timestamp

	}

	println(blockchain)
}
