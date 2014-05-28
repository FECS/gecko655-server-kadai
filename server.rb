#! /usr/bin/env ruby -Ku

require 'net/http'
require 'uri'
require 'json'


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
  def parse()
    json = JSON.parse(getAnimate())
    json["response"]["item"].each { |item|  
      if item["title"] == "一週間フレンズ。"
	return item
      end
    }
  
  end

end

s = Server.new()
puts s.parse()



