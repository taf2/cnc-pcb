# Usage: ruby compute.rb border.gbl stock_width_mm stock_height_mm
input_filename = ARGV[0]
stock_width = ARGV[1].to_f
stock_height = ARGV[2].to_f

def compute_offsets(input_filename, stock_width, stock_height)
  min_x, max_x, min_y, max_y = Float::INFINITY, -Float::INFINITY, Float::INFINITY, -Float::INFINITY
  
  File.foreach(input_filename) do |line|
    if line.match(/X-?\d+Y-?\d+/)
      line.scan(/X(-?\d+)Y(-?\d+)/).each do |x, y|
        x = x.to_i
        y = y.to_i
        min_x = [min_x, x].min
        max_x = [max_x, x].max
        min_y = [min_y, y].min
        max_y = [max_y, y].max
      end
    end
  end

  pcb_width = max_x - min_x
  pcb_height = max_y - min_y
  x_offset = (stock_width - pcb_width / 100000.0) / 2.0 - min_x / 100000.0
  y_offset = (stock_height - pcb_height / 100000.0) / 2.0 - min_y / 100000.0

  puts "Translate X by: #{x_offset.round(3)} mm"
  puts "Translate Y by: #{y_offset.round(3)} mm"
end

compute_offsets(input_filename, stock_width, stock_height)
