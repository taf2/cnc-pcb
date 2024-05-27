# Usage: ruby mirror.rb border.GBL input.DRL output.DRL

border_filename = ARGV[0]
input_filename = ARGV[1]
output_filename = ARGV[2]

def parse_units(line)
  if line.include?('MOIN') or line.include?('INCH')
    return 25400.0  # 1 inch = 25400 microns
  elsif line.include?('MOMM') or line.include?('METRIC')
    return 1000.0  # 1 mm = 1000 microns
  else
    return 1.0  # Default to microns if units are not specified
  end
end

def find_y_range(filename)
  y_min = Float::INFINITY
  y_max = -Float::INFINITY
  units_conversion = 1.0

  File.foreach(filename) do |line|
    if line.match(/%MO/) or line.match(/INCH|METRIC/)
      units_conversion = parse_units(line)
    end
    if line.match(/Y-?\d+/)
      line.scan(/Y-?\d+/).each do |match|
        y_value = match[1..-1].to_f * units_conversion
        y_min = [y_min, y_value].min
        y_max = [y_max, y_value].max
      end
    end
  end

  [y_min, y_max, units_conversion]
end

def mirror_gerber_or_drill_file(border_filename, input_filename, output_filename)
  y_min, y_max, border_units_conversion = find_y_range(border_filename)
  y_center = (y_min + y_max) / 2.0

  input_units_conversion = 1.0
  File.foreach(input_filename) do |line|
    if line.match(/%MO/) or line.match(/INCH|METRIC/)
      input_units_conversion = parse_units(line)
      break
    end
  end

  File.open(output_filename, 'w') do |output_file|
    File.foreach(input_filename) do |line|
      if line.match(/Y-?\d+/)
        line.gsub!(/Y(-?\d+)/) do |match|
          puts match.inspect
          y_value_str = match[1..-1]
          y_value = y_value_str.to_f * input_units_conversion
          mirrored_y = (2.0 * y_center - y_value) / input_units_conversion
          mirrored_y_str = if input_units_conversion == 25400.0 
            sprintf("%.4f", mirrored_y)
          else
            sprintf("%.3f", mirrored_y)
          end
          "Y#{mirrored_y_str}"
        end
      end
      output_file.puts(line)
    end
  end
end

mirror_gerber_or_drill_file(border_filename, input_filename, output_filename)
