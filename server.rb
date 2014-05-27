#! /usr/bin/env ruby -Ku

s = "Hello"
def s.sayHello()
  print "HelloWorld\n"
end
s.sayHello()

#The code below will fail because String::sayHello() is not defined.
#t="Hello"
#t.sayHello()

