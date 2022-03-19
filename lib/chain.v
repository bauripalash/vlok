module lib

pub struct Pchain {
pub mut:
	blocks []Vlok
	length u64
}

pub fn (mut p Pchain) push(v Vlok) {
	p.blocks << v
	p.length += 1
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
