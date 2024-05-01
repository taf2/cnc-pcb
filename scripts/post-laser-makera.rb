#!/usr/bin/ruby
# read as input a nc GCODE file from Flatcam and convert it to use
# Carvera laser gcodes.
# step 1 locate the M03 line we want to remove everything up to that line


output = []
state = 'discard'
input_file = ARGV[0]
power_level = ARGV[1] || 100 # start with 100 to cutout trace and then 10% to cure mask
x_offset = ARGV[2].to_f || 0.0 # X offset
y_offset = ARGV[3].to_f || 0.0 # Y offset

output_file = input_file.gsub(/flatcam/,'cut')
puts "reading #{input_file.inspect}"
File.readlines(input_file).each {|line|
  line.strip!

  # first thing to locate before buffering
  if line.match?(/^M03.*/)
    puts "start capture"
    state = 'capture'
    output += [
      'G01 F3000',
      ';USER START SCRIPT',
      'M323',
      'M324',
      'M321',
      'G0Z0',
      ';USER START SCRIPT',
      '',
      'G00 G17 G40 G21 G54',
      'G90'
    ]
  end

  # Adjust the laser power level
  if line.match?(/G01 Z\-?[0-9]\..*/)
    line = "G01 M325S#{power_level}"
  end

  # instead of a lifting the tool to Z2 we disable the laser since Z2 is the lift height normally
  if line == 'G00 Z2.0000'
    line = 'G01 M325S0'
  end

  if state == 'capture'
    # If we're dealing with a movement command apply our offsets
    if ((x_offset != 0.0) || (y_offset != 0.0)) 
      match_data = line.match(/G0[01].*X([-\d.]+)(.*Y([-\d.]+))?/)
      #match_data = line.match(/G0[01].*X([-\d.]+).*Y([-\d.]+)/)
      if match_data
        x = match_data[1].to_f + x_offset
        y = match_data[3].to_f + y_offset if match_data[3] 
        line.gsub!(/X[-\d.]+/, "X#{format('%.4f', x)}")
        line.gsub!(/Y[-\d.]+/, "Y#{format('%.4f', y)}") if y
      end
    end
    output << line
  end
}
output += [
  'G0 Z15 F3000',
  'M322',
  'G28'
]
File.open(output_file, "wb") {|f|
  f << output.join("\n")
}
