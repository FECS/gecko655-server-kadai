#! /usr/bin/env ruby -Ku

require 'net/http'
require 'uri'
require 'json'
require 'date'


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
  def getTime()
    day = {
      "日曜日" =>0,
      "月曜日" =>1,
      "火曜日" =>2,
      "水曜日" =>3,
      "木曜日" =>4,
      "金曜日" =>5,
      "土曜日" =>6,
    }
    item = parse()
    today = DateTime.now
    fromNextEp = day[item["week"]] - today.wday
    fromNextEp+=7 if (fromNextEp<0)
    nextEp = today+fromNextEp
    nextEp.strftime("%Y/%m/%d")+"/"+ item["time"]+":00"
  end

end

s = Server.new()
puts s.getTime()



