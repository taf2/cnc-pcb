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

### Using flatcam 
Use flatcam with the newly positioned gerber files you will only need to use the 2-sided tool to generate alignment holes (future version I want to generate those drill holes as well). Use the mirror X operation since we'll be flipping it vertically.


Use the isolation tool on your top layer and bottom layer. (for me 20% overlap) using a 0.1mm v-bit with 60 deg works well.

Use the paint tool for the top silk and bottom silk, using seed and the 0.2mm v-bit 30 deg bit.
