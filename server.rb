#! /usr/bin/env ruby -Ku

require 'net/http'
require 'uri'


class Server
  def sayHello()
	print "Hello World\n"
  end

  def showGoogle()
    contents = Net::HTTP.get URI.parse('http://www.google.com/')
    puts contents
  end

end

s = Server.new()
s.showGoogle()
