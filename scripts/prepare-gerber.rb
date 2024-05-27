# Read in a Gerber file and offset/translate the coordinates by a given x and y offset
input_filename = ARGV[0]
output_filename = ARGV[1]
x_offset = ARGV[2].to_f * 100000  # Convert to integer assuming 5 decimal places
y_offset = ARGV[3].to_f * 100000  # Convert to integer assuming 5 decimal places

puts "Translating #{input_filename} via #{x_offset}, #{y_offset} into #{output_filename}"

# Enhanced Gerber Translation Script
def translate_gerber_file(input_filename, output_filename, x_offset, y_offset)
  File.open(output_filename, 'w') do |output_file|
    File.foreach(input_filename) do |line|
      if line.match(/^(X-?\d+Y-?\d+)/) || line.match(/G\d+/)
        # Handling coordinates and any G-code operations
        line.gsub!(/X(-?\d+)/) { |x_val| "X#{x_val[1..-1].to_i + x_offset}" }
        line.gsub!(/Y(-?\d+)/) { |y_val| "Y#{y_val[1..-1].to_i + y_offset}" }
      end
      output_file.puts(line)
    end
  end
end


translate_gerber_file(input_filename, output_filename, x_offset, y_offset)
