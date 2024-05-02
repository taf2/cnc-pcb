# T1 is 1mm bit
# T2 is a vbit 60* 0.1mm tip
# T3 is 2mm bit
# T4 is 2.8mm bit
# T5 is spring bit 2mm Vbit 30&
# T6 is 0.5mm bit
/usr/bin/ruby scripts/post-makera.rb flatcam/step1-top-iso.nc T2

/usr/bin/ruby scripts/post-makera.rb flatcam/step2-top-pads.nc T5 0.0000=0.0120

/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step3-top-silk.nc 003 -0.5 0.3

/usr/bin/ruby scripts/combine.rb cut/step4-align.nc flatcam/step4-align.nc:T3 flatcam/step4x-align.nc:T3

/usr/bin/ruby scripts/post-makera.rb flatcam/step5-bot-iso.nc T2

/usr/bin/ruby scripts/post-makera.rb flatcam/step6-bot-pads.nc T5 0.0000=0.0120

/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step7-bot-silk.nc 003 -0.5 0.3

/usr/bin/ruby scripts/combine.rb cut/final.nc flatcam/step9-small-holes.nc:T6 flatcam/step8-oval-cutout.nc:T1 flatcam/step10-big-holes.nc:T1 flatcam/step11-cutout.nc:T1
