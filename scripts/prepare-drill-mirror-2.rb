# Usage: ruby mirror.rb border.GBL input.DRL output.DRL axis

border_filename = ARGV[0]
input_filename = ARGV[1]
output_filename = ARGV[2]

# important to note, if we're flipping on the y axis then we need the center point along the x axis since that is our point of rotation.  Or vice versa we need the y axis center point if we're rotating on the x axis
axis = (ARGV[3] || 'x').downcase  # 'x' or 'y'

# find the min and mx point on the given axis within the given gerber filename
# assuming gerber file is in floating point unit of measure at this point does not matter
def find_range(filename, axis)
  min = Float::INFINITY
  max = -Float::INFINITY

  line_count = 0
  File.foreach(filename) do |line|
    line.strip!
    line_count += 1
    if line.match?(/#{axis.upcase}-?\d+/) && !line.start_with?('%')
      line.scan(/#{axis.upcase}-?\d+/).each do |match|
        value = match[1..-1].to_f
        puts "\tcheck value: #{value} from match: #{match.inspect} #{line_count}"
        min = [min, value].min
        max = [max, value].max
      end
    end
  end

  [min, max]
end

def mirror_file(border_filename, input_filename, output_filename, axis)
  min, max = find_range(border_filename, axis) #axis == 'y' ? 'x' : 'y')
  puts "gerber min: #{min}, max: #{max} along #{axis}"
  center = (min + max) / 2.0 / 100.0
  puts "mirror: #{axis} #{min} #{max} for #{border_filename} and center: #{center}"

  File.open(output_filename, 'w') do |output_file|
    File.foreach(input_filename) do |line|
      regex = /#{axis.upcase}-?\d+/
      if line.match?(regex) && !line.start_with?('%')
        puts "matched: #{line}"
        line.gsub!(/#{axis.upcase}(-?\d+)/) do |match|
          value_str = match[1..-1].gsub(/^0*/, '') # remove leading 0's
          puts "value_str: #{value_str.inspect}"
          value = value_str.to_i# * units_conversion
          mirrored_value = (2.0 * center - value)# / units_conversion
          sign = '-' if mirrored_value < 0
          mirrored_value_str = "#{sign}0#{mirrored_value.to_i.abs}"
          "#{axis.upcase}#{mirrored_value_str}"
        end
      end
      output_file.puts(line)
    end
  end
end

mirror_file(border_filename, input_filename, output_filename, axis)
