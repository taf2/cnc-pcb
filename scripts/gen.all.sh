/usr/bin/ruby scripts/post-makera.rb flatcam/step1-top-iso.nc T2

/usr/bin/ruby scripts/post-makera.rb flatcam/step2-top-pads.nc T5 0.0000=0.012

# we know 003 works well, going to test 002
/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step3-top-silk.nc 003


/usr/bin/ruby scripts/combine.rb cut/step4-final.nc flatcam/step4-small-holes.nc:T6 flatcam/step4-big-holes.nc:T1 flatcam/step4-cutout.nc:T1


# generate the last step combined drill holes and cut out
#/usr/bin/ruby scripts/combine.rb cut/combined-last.nc flatcam/vias_cnc.nc:T6 flatcam/holes_cnc.nc:T1 flatcam/oval-holes.nc:T1 flatcam/last-cutout.nc:T1
