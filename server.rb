#! /usr/bin/env ruby -Ku

require 'net/http'
require 'uri'
require 'json'
require 'date'


class Server
  def sayHello() #引数無しの場合は()省略可
	print "Hello World\n" 
  # p, print, putsがあるけど動作が違う。putsは1行表示なのでその方が良い
  # indent合わせないと。とても大事ですよ。
  # シングルクオートで文字列を書くくせをつけましょう
  end

  def showGoogle()
    # 引数にgetter以外の関数呼び出しをするときは変数を置く方がいい
    uri = URI.parse('http://www.google.com/')
    contents = Net::HTTP.get uri
    puts contents
  end

  def getAnimate()
    # 関数名・・・
    Net::HTTP.get URI.parse('http://animemap.net/api/table/tokyo.json')
    # Rubyチックな返し方でいいと思います
  end
  def parse()
    # nilチェックはまあいいでしょう
    # ()省(ry
    json = JSON.parse(getAnimate())
    json["response"]["item"].each { |item|  
      if item["title"] == "一週間フレンズ。"
	return item
      end
      # Rubyはif, unlessの後置記法に対応しているので、一行実行はそっちの方がいい
      # 正規表現に使おう(文字列処理に強いんです)
    }
  end

  # 汚い(ブチ切れ
  def getTime()
    # いや、悪くはないと思います。さすがにこれはnilチェックしようね
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



