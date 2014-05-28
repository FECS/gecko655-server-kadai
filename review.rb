#!/usr/bin/env ruby

require "net/http"
require "uri"
require "json"

class Study
  def sayHello
    puts 'Hello world'
  end

  def show_url url
    return unless url

    uri = URI::parse url
    Net::HTTP::get uri
  end

  # 移植性の観点から分離
  # あと同じコード書くの超めんどくさい

  def show_google
    puts show_url('http://www.google.com/')
  end

  # 引数には与えられないときの初期値代入が出来る
  # メソッド名はもうちょっとアレな感じにしましょう
  def get_anime_plan is_show_only=false
    json = show_url('http://animemap.net/api/table/tokyo.json')
    hash = JSON::parse(json) 
    # ここはjsonにパースするんじゃなくて、jsonをhash tableにしましょうってことだから変数名は・・・
    # hash.to_jsonでjsonになる

    puts hash.inspect if is_show_only
    return hash
  end

  # regex使おう

  def print_and_parse regex=/一週間/
    hash = get_anime_plan
    return unless hash # 一応ね、一応

    hash["response"]["item"].each { |item|
      case item['title']
      when regex then
        puts item.inspect
        break #ここはblock節ですよ
      end
    }
  end
end

s = Study.new
s.show_google
s.get_anime_plan true
s.print_and_parse