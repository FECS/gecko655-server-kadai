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

  def getAnimate()
    Net::HTTP.get URI.parse('http://animemap.net/api/table/tokyo.json')
  end

end

s = Server.new()
animateJson = s.getAnimate()
puts animateJson
