module lib

import json
import os

pub struct Pchain {
pub mut:
	blocks []Vlok
	length u64
}

pub fn (mut p Pchain) push(v Vlok) bool {
	if v.is_valid_pow(){
		p.blocks << v
		p.length += 1
		return true
	}
	return false
}

pub fn (mut p Pchain) blind_push(v Vlok){
	
	p.blocks << v
	p.length += 1

}

pub fn (mut p Pchain) chain_merge(q Pchain) bool{
	
	if !q.is_valid(){
		eprintln("submitted Chain is invalid!")
		return false
	}

	if !p.is_valid(){ //I don't think it is necessary
		eprintln("Chain of this node seems to be invalid")
		return false
	}

	if p.length >= q.length {
		println("No need to merge the submitted chain!")
		return false
	}


	
	//if we are still in the Function; `q` is the longer chain here; `p` is shorter one
	// and `p` and `q` both are valid (possibly)
	
	for i in 0..p.length-1{ // checking if all the block till P[L] and Q[L] are same; where L is the length of the shortest chain (in this case `p`)
		
		if !p.blocks[i].is_same(q.blocks[i]){
			eprintln("Merge Failed -> While checking if the blocks are same!")
			return false
		}

	}

	// if we are still here; that means it is `probally` okay to merge extra blocks from Q

	for j in p.length-1..q.length-1{
		if !p.push(q.blocks[j]){
			eprintln("Merge Failed -> While pushing blocks!")
			return false
		}
	}
		
	

	
	println("Merge Done!")	
	return true




}

pub fn (p Pchain) lastblock() &Vlok {
	return &p.blocks[p.length - 1]
}

pub fn (p Pchain) is_valid() bool {
	// mut result := false
	if p.length != p.blocks.len {
		return false
	}
	if !p.blocks[0].is_valid_pow() {
		return false
	}
	for index in 1 .. p.length {
		current_block := p.blocks[index]
		prev_block := p.blocks[index - 1]

		if current_block.prev_hash != prev_block.get_hash() {
			return false
		}

		if !current_block.is_valid_pow() {
			return false
		}
	}
	return true
}

pub fn (p Pchain) dumpdata(path string) ? {
	os.write_file(path, json.encode_pretty(p)) ?
}
