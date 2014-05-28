#!/usr/bin/env ruby

require "net/http"
require "uri"
require "json"
require "date"

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
        return item
        # returnしないならbreakにしましょう
      end
    }
  end

  def get_wday wday_str
    case wday_str
    when /日曜日/ then
      return 0
    when /月曜日/ then
      return 1
    when /火曜日/ then
      return 2
    when /水曜日/ then
      return 3
    when /木曜日/ then
      return 4
    when /金曜日/ then
      return 5
    when /土曜日/ then
      return 6
    end

    return 0
  end

  # 考え方はよろしいと思いました
  # 強いて言うならDateTimeよりTimeがいいなあ・・・
  def show_next_broadcast anim_item
    hms = anim_item['time']+":00"

    now = DateTime.now
    next_count = get_wday(anim_item['week']) - now.wday
    next_count += 7 if next_count < 0
    puts (now + next_count).strftime("%Y/%m/%d/")+hms
  end

  def show_next_broadcast_of regex=/一週間/
    show_next_broadcast print_and_parse(regex)
  end
end

s = Study.new
# s.show_google
# s.get_anime_plan true
# s.print_and_parse
s.show_next_broadcast_of



# 全体を通して、課題に特化しすぎているので本番はやらないように
# キャメル式でもスネーク式でもまあいいかな
# 省略出来る部分で分かりやすさに影響がないなら省略しましょう
