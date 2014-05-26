#! /usr/bin/ruby -Ku


class Server
  def sayHello()
	print "Hello World\n"
  end

end

s = Server.new()
s.sayHello()
