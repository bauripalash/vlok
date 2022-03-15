module main

import lib
import time

fn main() {
	genesis := lib.new_vlok(0, '0', '0')
	mut chain := [genesis]
	for i := 1; i <= 10; i += 1 {
		chain << lib.mine(chain[chain.len - 1])

		time.sleep(i * time.second) // If it doesn't sleep; most of the blocks will have the same time-stamp
	}
}
