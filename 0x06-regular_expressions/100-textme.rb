#!/usr/bin/env ruby
puts ARGV[0].scan(/(?<=from:.{1})\d{11}|(?<=to:.{1})\d{11}|flags:-[0-9]:[0-9]:-[0-9]:[0-9]:-[0-9]/).join
