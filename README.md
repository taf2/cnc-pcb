# CNC PBC Tools

This is a collection of scripts and away of organizing your gerber files with Flatcam to make it fairly easy
to create nice and decently high quality PCB's.

We use the Carvera CNC with it's automatic tool changing to speed up the process and the laser to create nice looking
silkscreen on both the top and bottom layers.


# Process


### Design your circuit board
Asssuming you have finished the design in my case I'm using EasyEDA so this process will work well for the gerber files output from EasyEDA only.  I have not tested with other tools.

    - Download the fabrication files gerber and drill files into the gerber/ folder.
    - unzip the gerber files.

### Compute the center of your part on the copper clad double sided board.

You'll need to know the dimensions of your board width x height in millimeters.
In my example I used 100x70 mm

```bash
ruby script/center-compute.rb gerber/Gerber_BoardOutlineLayer.GKO 100 70
```

The above script will tell you how much to offset the PCB files to be centered on your copper board. 
```bash
sh scripts/prepare-position.sh $x $y   
```

At this point you'll have gerber files in the gerber/ready folder.  These files will be positioned in the center of your copper board and the bottom gerber and drill files will be mirrored such that you can flip the board after machining the top side in over the x axis flipping it from the backside over towards the front of the machine in place. so you can easily machine the bottom side of the board next.


### Tools

* Tool 1. endmill 1mm for drilling holes and cutting out
* Tool 2. vbit 0.1mm 60* for trace isolation (tool diameter 0.2155)
* Tool 3. endmill 2mm for drilling alignment holes for 2mm alignment pegs
* Tool 4. not used
* Tool 5. vbit 0.3mm 30* for pad clearing (tool diameter 0.2268)
* Tool 6. endmill 0.5mmm for drilling via's

### Using flatcam 

We'll be creating individual step gcode files step1, step2, etc... for each gerber and drill files saving them into the flatcam directory.

With our pre-processing steps above the process in flatcam is simplified to the following steps:

1. Using the the 2-sided tool we will generate drill holes select 2 points on the bottom of the design left and right and then generate the holes

2. Top layer
    - isolation routing.
    - overlap to 20%
    - save as step1-top-iso.nc

3. Silkscreen (will use the laser)
    - paint tool
    - tool diameter 0.1 (c1)
    - overlap 20%
    - offset 0.02
    - method lines
    - save as step2-top-silk.nc

4. Clear pads, (we can try laser clearing and cnc clearing)
    - paint tool
    - default for the cnc tool 0.2268
    - overlap 20%
    - n offset
    - method seed
    - save as step2-top-pads.nc
    - for pad clearing with cnc save as step3-top-pads.nc

5. Alignment drills
    - drill tool
    - 6mm deep (ensure enough stock material below)
    - save as step4-top-align.nc

6. Bottom isolation
    - isolation routing.
    - overlap to 20%
    - save as step5-bot-iso.nc

7. Silkscreen (will use the laser)
    - paint tool
    - tool diameter 0.1 (c1)
    - overlap 20%
    - offset 0.02
    - method lines
    - save as step6-top-silk.nc

8. Clear pads, (we can try laser clearing and cnc clearing)
    - paint tool
    - default for the cnc tool 0.2268
    - overlap 20%
    - n offset
    - method seed
    - save as step6-top-pads.nc
    - for pad clearing with cnc save as step7-top-pads.nc

Use the isolation tool on your top layer and bottom layer. (for me 20% overlap) using a 0.1mm v-bit with 60 deg works well.

Use the paint tool for the top silk and bottom silk, using seed and the 0.2mm v-bit 30 deg bit.
