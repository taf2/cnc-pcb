/usr/bin/ruby scripts/post-makera.rb flatcam/step1-top-iso.nc T2

/usr/bin/ruby scripts/post-makera.rb flatcam/step2-top-pads.nc T5 0.1366=0.012

/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step3-top-silk.nc 003

/usr/bin/ruby scripts/post-makera.rb flatcam/step4-align.nc T3
/usr/bin/ruby scripts/post-makera.rb flatcam/manual-align.nc T3

/usr/bin/ruby scripts/post-makera.rb flatcam/step5-bot-iso.nc T2

/usr/bin/ruby scripts/post-makera.rb flatcam/step6-bot-pads.nc T5 0.1366=0.012

/usr/bin/ruby scripts/post-makera.rb flatcam/step7a-small-holes.nc T6
/usr/bin/ruby scripts/post-makera.rb flatcam/step7b-small-holes.nc T6

/usr/bin/ruby scripts/combine.rb cut/step8-final.nc flatcam/step7a-small-holes.nc:T6 flatcam/step7b-big-holes.nc:T1 flatcam/step7c-cutout.nc:T1


# generate the last step combined drill holes and cut out
#/usr/bin/ruby scripts/combine.rb cut/combined-last.nc flatcam/vias_cnc.nc:T6 flatcam/holes_cnc.nc:T1 flatcam/oval-holes.nc:T1 flatcam/last-cutout.nc:T1
