module lib


pub struct Pchain{
pub mut:
	blocks []Vlok
	length u64

}

pub fn (mut p Pchain) push(v Vlok){
	p.blocks << v
	p.length += 1
	
}



pub fn (p Pchain) lastblock() &Vlok{
	
	return &p.blocks[p.length - 1]
	
}
