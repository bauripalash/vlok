module lib
import net
import io
// TODO: Blockchain server

pub fn start_server(p &Pchain)?{

	mut server := net.listen_tcp(.ip6 , ':9093')?
	server_addr := server.addr()?
	println("server listening on $server_addr")

	for {

		mut socket := server.accept()?
		go client_handler(mut socket , p)

	}

}

pub fn s(x string) string{
	
	return "$x\r\n"

}

pub fn client_handler(mut sock net.TcpConn , p &Pchain){
	
	defer{
		sock.close() or { panic(err) }
	}

	client_addr := sock.peer_addr() or { return }
	println("new node connected : $client_addr")

	mut reader := io.new_buffered_reader(reader:sock)

	defer{
		reader.free()
	}

	sock.write_string("welcome! new node!\r\n") or { return }

	for {
		
		raw := reader.read_line() or { return }
		if raw == 'qq'{
			//sock.close() or { return }
			return
		}

		if raw == 'length'{
			sock.write_string(s(p.length.str())) or { return }
		}else if raw == 'valid'{
			sock.write_string(s(p.is_valid().str())) or { return }
		}else if raw == 'bal'{
			sock.write_string(s(p.balance_of(miner_addr).str())) or { return }
		}

		else{
			sock.write_string(s("?")) or {return}
		}
		
	}

}
