#!/usr/bin/ruby
tool=ARGV[1] || 'T1'
# you can pass a depth argument with a replacement rule e.g. 0.1366=0.01 will replace all G01 Z0.1366 with G01 Z0.01
depth=ARGV[2] # 0.1366=0.01
skip_end=(ARGV[3].to_i == 1)
skip_start=(ARGV[4].to_i == 1)
ofile=ARGV[5]

if depth == 'x=y'
  depth = nil
end

if skip_start
start_codes = %(
#{tool} M6
M3 S16000
).split("\n").map {|line| line.strip }
else
start_codes = %(
(Machine)
(  vendor: Makera)
(  model: Carvera 3-axis)
(  description: Makera Carvera 3-axis)
G01 F3000
G90 G94
G17
G21

#{tool} M6
G00 X32.1227 Y38.9615 Z5.0000 F900
M3 S12000
).split("\n").map {|line| line.strip }
end

if skip_end
  end_codes = %(M5).split("\n").map {|line| line.strip }
else
  end_codes = %(G0 Z15 F3000
M5
G28
M30).split("\n").map {|line| line.strip }
end

if depth
  # prepare the depth argument
  depths = depth.split(";").map {|d|
    locate, replace = d.split("=") 
    {locate: locate, replace: replace}
  }
else
  depths = []
end

output = []
state = 'discard'
input_file = ARGV[0]
output_file = input_file.gsub(/flatcam/,'cut')
puts "reading #{input_file.inspect} for tool: #{tool}"
lines = File.readlines(input_file)
puts "reading #{lines.size} for tool: #{tool}"

lines.each {|line|
  line.strip!
  if state == 'discard'
    if line == 'M03'
      state = 'capture'
      output = start_codes 
    end
  elsif state == 'capture'
    if line == 'M05'
      state = 'discard'
      output += end_codes 
    elsif depths.any? && line.match?(/^G01 Z/)
      depths.each {|d|
        line.gsub!(d[:locate], d[:replace])
      }
      output << line
    else
      output << line
    end
  end
}

if ofile
  output_file = ofile
end
File.open(output_file, "wb") {|f|
  f << output.join("\n")
}
puts "writing to #{output_file.inspect} with #{output.size} lines"
