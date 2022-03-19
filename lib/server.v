module lib

import vweb
import json

const (
	port = 8021
)

struct State {
pub mut:
	tnum int
}

pub struct Server {
	vweb.Context
pub mut:
	state shared State
}

pub struct JsonRes {
	status  i64
	message string
}

pub fn (mut s Server) index() vweb.Result {
	res := JsonRes{
		status: 20
		message: 'welcome to plockchain'
	}

	return s.json_pretty(res)
}

[post]
pub fn (mut s Server) send() ?vweb.Result {
	println(s.req.data)
	trans := json.decode(Transaction, s.req.data) or {
		eprintln('invalid json request')
		return s.json('invalid request')
	}
	// println(trans)
	// if s.req.header.get(.content_type)?.str() == "application/json"{
	//	return s.text("done")
	//}

	return s.json(trans)
}

/*
fn init(){
	
	println("Starting blockchain server at http://127.0.0.1:$port")
	vweb.run(&Server{}, port)

}
*/
