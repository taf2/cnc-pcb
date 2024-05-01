#!/usr/bin/ruby
# Combine multiple milling operations
# must run after post-makera is run
# ruby scripts/combine.rb cut/combined-file.nc flatcam/vias_cnc.nc:T6 flatcam/holes_cnc.nc:T1 flatcam/oval-holes.nc:T1 flatcam/last-cutout.nc:T1
require 'tmpdir'
require 'pathname'
puts "processing files... #{RUBY_VERSION}"
args = ARGV.to_a
output = args.shift
Dir.mktmpdir {|dir|

  base_dir = Pathname.new(dir)
  i = 0
  files = args.map {|file|
    input, tool = file.split(":")
    puts "file: #{input} with tool: #{tool}"
    ofile = base_dir.join("file_#{i}.nc")
    skip_end = if i == args.size
      0
    else
      1
    end
    skip_start = if i == 0
      0
    else
      1
    end
    cli = "ruby scripts/post-makera.rb #{input} #{tool} x=y #{skip_end} #{skip_start} #{ofile}"
    puts cli
    system(cli)
    i += 1
    ofile
  }
  File.open(output, "wb") {|f|
    files.each_with_index {|file,i|
      f << "\n(start: #{args[i]})\n"
      f << file.read
      f << %(\nG00 Z2.0000 F3000\n)
      f << "\n(end: #{args[i]})\n"
    }
    f << %(G0 Z15 F3000
M5
G28
M30)
  }
}
