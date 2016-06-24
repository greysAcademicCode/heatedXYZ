M28 mycodes.gcode; begin logging

M999; enable all the things (in case the halt button was pressed)

;program the syringe pump driver registers:
;1: CTRL Register
;2: TORQUE Register
;3: OFF Register
;4: BLANK Register
;5: DECAY Register
;6: STALL Register
;7: DRIVE Register
M911.2 S R1 V3616 ; disable now
M911.2 S R2 V440
M911.2 S R3 V50
M911.2 S R4 V256
M911.2 S R5 V1296
M911.2 S R6 V2592
M911.2 S R7 V0
M911.2 S R1 V3617 ; enable now
; for 1/16 stepping: 0E21,01B8,0032,0100,0510,0A02,0000

M17; motors on
G28 F6000; home XYZ at a rate of 100mm/sec
G90; absolute mode

M92 E4209; sets extruder to steps per mL for a D=22mm syringe

G1 X80 Y210 F12000; send plate to loading position at 200 mm/sec

G1 Z72 F6000; move the nozzle to 72mm above plate at 100 mm/sec

;M190 S100; set bed temperature to 100 deg c and then wait for it

M1910.2 E4 F0.0666; start infusion: 4ml at 4 ml/m (=4/60)
;M1910.2 E40 F0.0666; start infusion: 40ml at 4 ml/m (=4/60)

;stage movements now
G1 X50 Y10 F12000 ;move x = 50, y = 10 at 200 mm/sec
G1 X51 Y200 ;move x=11,y=200 (at 200 mm/sec)
G1 X52 Y10
G1 X53 Y200
G1 X54 Y10
G1 X55 Y200
G1 X56 Y10
G1 X57 Y200
G1 X58 Y10
G1 X59 Y200
G1 X60 Y10
G1 X61 Y200
G1 X62 Y10
G1 X63 Y200
G1 X64 Y10
G1 X65 Y200
G1 X66 Y10
G1 X67 Y200
G1 X68 Y10
G1 X69 Y200
G1 X70 Y10
G1 X71 Y200
G1 X72 Y10
G1 X73 Y200
G1 X74 Y10
G1 X75 Y200
G1 X76 Y10
G1 X77 Y200
G1 X78 Y10
G1 X79 Y200
G1 X80 Y10
G1 X81 Y200
G1 X82 Y10
G1 X83 Y200
G1 X84 Y10
G1 X85 Y200
G1 X86 Y10
G1 X87 Y200
G1 X88 Y10
G1 X89 Y200
G1 X90 Y10
G1 X91 Y200
G1 X92 Y10
G1 X93 Y200
G1 X94 Y10
G1 X95 Y200
G1 X96 Y10
G1 X97 Y200
G1 X98 Y10
G1 X99 Y200
G1 X100 Y10
G1 X99 Y200
G1 X98 Y10
G1 X97 Y200
G1 X96 Y10
G1 X95 Y200
G1 X94 Y10
G1 X93 Y200
G1 X92 Y10
G1 X91 Y200
G1 X90 Y10
G1 X89 Y200
G1 X88 Y10
G1 X87 Y200
G1 X86 Y10
G1 X85 Y200
G1 X84 Y10
G1 X83 Y200
G1 X82 Y10
G1 X81 Y200
G1 X80 Y10
G1 X79 Y200
G1 X78 Y10
G1 X77 Y200
G1 X76 Y10
G1 X75 Y200
G1 X74 Y10
G1 X73 Y200
G1 X72 Y10
G1 X71 Y200
G1 X70 Y10
G1 X69 Y200
G1 X68 Y10
G1 X67 Y200
G1 X66 Y10
G1 X65 Y200
G1 X64 Y10
G1 X63 Y200
G1 X62 Y10
G1 X61 Y200
G1 X60 Y10
G1 X59 Y200
G1 X58 Y10
G1 X57 Y200
G1 X56 Y10
G1 X55 Y200
G1 X54 Y10
G1 X53 Y200
G1 X52 Y10
G1 X51 Y200 ; pass number 1

G1 X80 Y100; send plate to roughgly the middle (testing)
G4 S70; do nothing for 70 seconds (testing)

M1910.1 E0; stop infusion

G1 X80 Y210 F6000; send plate to loading position at 100 mm/sec

M1910.2 E-5.0 F1.0; withdraw: 5ml at 1 ml/s

G4 S6; do nothing for 6 seconds (testing)
M1910.1 E0; stop infusion

;M140 S0; set the bed temperature to 0 deg C

M18; motors off
M112; disable all the things

M29; end logging

;select the file:
;M23 mycodes.gcode

;run it:
;M24
