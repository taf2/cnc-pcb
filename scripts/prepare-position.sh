# position the pcb center to our 100x70 board
# in the x axis we want to offset by 15 and in the y we want it centered
#
mkdir -p gerber/prepared
ruby scripts/prepare-drill.rb  gerber/Drill_PTH_Through.DRL gerber/prepared/Drill_PTH_Through.DRL 5 35
ruby scripts/prepare-drill.rb  gerber/Drill_PTH_Through_Via.DRL gerber/prepared/Drill_PTH_Through_Via.DRL 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_BoardOutlineLayer.GKO gerber/prepared/Gerber_BoardOutlineLayer.GKO 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_BottomLayer.GBL gerber/prepared/Gerber_BottomLayer.GBL 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_BottomPasteMaskLayer.GBP gerber/prepared/Gerber_BottomPasteMaskLayer.GBP 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_BottomSilkscreenLayer.GBO gerber/prepared/Gerber_BottomSilkscreenLayer.GBO 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_BottomSolderMaskLayer.GBS gerber/prepared/Gerber_BottomSolderMaskLayer.GBS 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_TopLayer.GTL           gerber/prepared/Gerber_TopLayer.GTL           5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_TopPasteMaskLayer.GTP  gerber/prepared/Gerber_TopPasteMaskLayer.GTP  5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_TopSilkscreenLayer.GTO gerber/prepared/Gerber_TopSilkscreenLayer.GTO 5 35
ruby scripts/prepare-gerber.rb  gerber/Gerber_TopSolderMaskLayer.GTS gerber/prepared/Gerber_TopSolderMaskLayer.GTS 5 35

# mirror the bottom and drill's
mkdir -p gerber/ready
# copy all other files into the ready folder
cp gerber/prepared/Gerber_BoardOutlineLayer.GKO  gerber/ready/
cp gerber/prepared/Gerber_TopLayer.GTL           gerber/ready/
cp gerber/prepared/Gerber_TopPasteMaskLayer.GTP  gerber/ready/
cp gerber/prepared/Gerber_TopSilkscreenLayer.GTO gerber/ready/
cp gerber/prepared/Gerber_TopSolderMaskLayer.GTS gerber/ready/


ruby scripts/prepare-mirror.rb  gerber/prepared/Gerber_BoardOutlineLayer.GKO gerber/prepared/Gerber_BottomLayer.GBL  gerber/ready/Gerber_BottomLayer.GBL
ruby scripts/prepare-mirror.rb  gerber/prepared/Gerber_BoardOutlineLayer.GKO gerber/prepared/Gerber_BottomSolderMaskLayer.GBS gerber/ready/Gerber_BottomSolderMaskLayer.GBS
ruby scripts/prepare-mirror.rb  gerber/prepared/Gerber_BoardOutlineLayer.GKO gerber/prepared/Gerber_BottomSilkscreenLayer.GBO gerber/ready/Gerber_BottomSilkscreenLayer.GBO
ruby scripts/prepare-drill-mirror-2.rb gerber/prepared/Gerber_BoardOutlineLayer.GKO gerber/prepared/Drill_PTH_Through.DRL gerber/ready/Drill_PTH_Through.DRL y
