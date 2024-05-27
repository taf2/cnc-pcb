# Usage: ruby mirror.rb border.GBL input.GBL output.GBL

border_filename = ARGV[0]
input_filename = ARGV[1]
output_filename = ARGV[2]

def find_y_range(filename)
  y_min = Float::INFINITY
  y_max = -Float::INFINITY

  File.foreach(filename) do |line|
    if line.match(/Y-?\d+/)
      line.scan(/Y-?\d+\.\d+/).each do |match|
        puts line.inspect
        y_value = match[1..-1].to_f
        y_min = [y_min, y_value].min
        y_max = [y_max, y_value].max
      end
    end
  end

  [y_min, y_max]
end

def mirror_gerber_file(border_filename, input_filename, output_filename)
  y_min, y_max = find_y_range(border_filename)
  puts "min: #{y_min}, max: #{y_max} for #{border_filename}"
  y_center = (y_min + y_max) / 2.0

  File.open(output_filename, 'w') do |output_file|
    File.foreach(input_filename) do |line|
      if line.match(/Y-?\d+/)
        line.gsub!(/Y(-?\d+\.\d+)/) do |match|
          y_value = match[1..-1].to_f
          mirrored_y = 2.0 * y_center - y_value
          "Y%.5f" % mirrored_y
        end
      end
      output_file.puts(line)
    end
  end
end

mirror_gerber_file(border_filename, input_filename, output_filename)
