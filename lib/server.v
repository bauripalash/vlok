module lib

import vweb
import json

const(
	
	port = 8021

)

struct State{

	pub mut:
		tnum int

}


pub struct Server{
	
	vweb.Context
pub mut:
	state shared State

}


pub struct JsonRes{
	
	status i64
	message string

}


pub fn (mut s Server) index() vweb.Result{
	
	res := JsonRes{ status : 20 , message : "welcome to plockchain" }
	

	return s.json_pretty(res)
	

}

[post]
pub fn (mut s Server) send() ?vweb.Result{
	
	
	trans := json.decode(Transaction , s.req.data)?
	if s.req.header.get(.content_type)?.str() == "application/json"{
		return s.json_pretty(JsonRes{status:200, message:"done!"})
	}

	return s.text("poo!")

}



fn init(){
	
	println("Starting blockchain server at http://127.0.0.1:$port")
	vweb.run(&Server{}, port)

}
