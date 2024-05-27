# Read in a DRL file and offset/translate the coordinates by a given x and y offset
input_filename = ARGV[0]
output_filename = ARGV[1]
x_offset = ARGV[2].to_f * 1000  # Convert to integer assuming 3 decimal places
y_offset = ARGV[3].to_f * 1000  # Convert to integer assuming 3 decimal places

puts "Translating #{input_filename} via #{x_offset}, #{y_offset} into #{output_filename}"

def translate_drl_file(input_filename, output_filename, x_offset, y_offset)
  File.open(output_filename, 'w') do |output_file|
    File.foreach(input_filename) do |line|
      line.strip!
      if line.match?(/X-?\d+Y-?\d+/)
        # Replace all coordinate occurrences in the line
        updated_line = line.gsub(/X(-?\d+)Y(-?\d+)/) do |match|
          x, y = $1.to_i + x_offset, $2.to_i + y_offset
          "X#{format("%06d", x)}Y#{format("%06d", y)}"
        end
        line = updated_line
      end
      output_file.puts(line)
    end
  end
end

translate_drl_file(input_filename, output_filename, x_offset, y_offset)
