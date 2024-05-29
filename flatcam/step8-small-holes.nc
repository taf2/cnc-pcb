(G-CODE GENERATED BY FLATCAM v8.994 - www.flatcam.org - Version Date: 2020/11/7)

(Name: small-holes_cnc)
(Type: G-code from Geometry)
(Units: MM)

(Created on Tuesday, 28 May 2024 at 20:37)

(This preprocessor is the default preprocessor used by FlatCAM.)
(It is made to work with MACH3 compatible motion controllers.)


(TOOLS DIAMETER: )
(Tool: 1 -> Dia: 0.501)

(FEEDRATE Z: )
(Tool: 1 -> Feedrate: 300)

(FEEDRATE RAPIDS: )
(Tool: 1 -> Feedrate Rapids: 1500)

(Z_CUT: )
(Tool: 1 -> Z_Cut: -1.8)

(Tools Offset: )
(Tool: 1 -> Offset Z: 0.0)

(DEPTH_PER_CUT: )
(Tool: 1 -> DeptPerCut: 0.7)

(Z_MOVE: )
(Tool: 1 -> Z_Move: 2)

(Z Toolchange: 15 mm)
(X,Y Toolchange: 0.0000, 0.0000 mm)
(Z Start: None mm)
(Z End: 0.5 mm)
(X,Y End: None mm)
(Steps per circle: 64)
(Preprocessor Excellon: default)

(X range:   35.8435 ...   66.6975  mm)
(Y range:   25.3345 ...   44.2505  mm)

(Spindle Speed: 0 RPM)
G21
G90
G94

G01 F300.00

M5
G00 Z15.0000
T1
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 0.5010 ||| Total drills for tool T1 = 8)
M0
G00 Z15.0000

G01 F300.00
M03
G00 X60.0970 Y27.9980
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X57.9380 Y29.6490
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X45.2380 Y25.5850
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X36.0940 Y27.1090
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X51.4610 Y44.0000
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X65.4310 Y41.5870
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X66.4470 Y30.9190
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
G00 X64.1610 Y29.0140
G01 Z-0.7000
G01 Z0
G00 Z2.0000
G01 Z-1.4000
G01 Z0
G00 Z2.0000
G01 Z-1.8000
G01 Z0
G00 Z2.0000
M05
G00 Z0.50


