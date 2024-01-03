#!/usr/bin/env ruby
patterns=/.*from:([+\w]+).*to:([+\d]+).*flags:([-\d:]+).*/

match=ARGV[0].scan(patterns)
if match.any?
  sender, reciver, flags = match[0]
  puts "#{sender},#{reciver},#{flags}"
end
