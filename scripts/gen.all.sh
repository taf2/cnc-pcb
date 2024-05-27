# T1 is 1mm bit
# T2 is a vbit 60* 0.1mm tip
# T3 is 2mm bit
# T4 is 2.8mm bit
# T5 is spring bit 2mm Vbit 30&
# T6 is 0.5mm bit
/usr/bin/ruby scripts/post-makera.rb flatcam/step1-iso-top.nc T2

/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step2-pads-top.nc 048 -0.5 0.3 900
/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step2-silk-top.nc 006 -0.5 0.3 600
#/usr/bin/ruby scripts/post-laser-makera.rb flatcam/test-top-pad-clear.nc 015 -0.5 0.3 600
/usr/bin/ruby scripts/post-laser-makera.rb flatcam/test-top-pad-clear.nc 015 -0.5 0.3 1200

/usr/bin/ruby scripts/post-makera.rb flatcam/step3-pads-top.nc T5 0.0000=0.0137

/usr/bin/ruby scripts/post-makera.rb flatcam/step4-align-top.nc T3

/usr/bin/ruby scripts/post-makera.rb flatcam/step5-iso-bot.nc T2

/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step6-pads-bot.nc 033 -0.5 0.3 900
/usr/bin/ruby scripts/post-laser-makera.rb flatcam/step6-silk-bot.nc 003 -0.5 0.3 600

/usr/bin/ruby scripts/post-makera.rb flatcam/step7-pads-bot.nc T5 0.0000=0.0132

/usr/bin/ruby scripts/combine.rb cut/step8-final.nc flatcam/step8-small-holes.nc:T6 flatcam/step9-big-holes.nc:T1 flatcam/step10-cutout-bot.nc:T1
