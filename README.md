# TTL Clock
74xx ICs Based Digital Clock

## Introduction
I got a bit tired from soldering SMD components, writing firmware, (and also observing people building vintage-looking Nixie clocks using modern microcontrollers). And recently when cleaning my parts boxes I found several 74LS47 7-segment decoders, some 74LS90 decade counters, and MAN1A 7-segment displays. So I thought, why not to build a nice little clock using these components.

![Assembled Clock Board](images/Clock-Fairchild.jpp)

## Design Overview
Please see the schematic file in the files section below.

The clock uses a 32768 Hz quartz crystal (X1) and 74HC4060 counter/divider IC (U1) to generate 2 Hz signal. This signal is divided further by 2 using a part of 74LS90 counter (U6). The obtained 1 Hz signal is fed to two 74LS90 counters (U11 and U12) that count seconds. The seconds reset circuit implemented using two 74LS00 NAND gates (U4A and U4B). This circuit resets both seconds and tens of seconds counters when they reach "60" or when "SECONDS" switch (SW1) is pressed, allowing seconds adjustment.
The most significant bit of tens of seconds counter is fed to the minutes counter implemented using two 74LS90 counters (U13 and U14) through a multiplexer built from three 74LS00 NAND gates (U2C, U2D, U4D). The multiplexer selects between this "one pulse per minute" signal and the 2 Hz signal allowing setting up minutes. Two additional 74LS00 NAND gates (U2A and U2B) implement an RS flip-flop used to de-bounce "MINUTES" switch (SW2). The tens of the minutes 74LS90 counter (U14) is wired so that it resets itself when it reaches count of "6", so that minutes wrap around at "60".
Similarly to minutes, the most significant bit of tens of minutes is fed to the hours counter implemented using two 74LS90 counters (U15 and U16) through a multiplexer built from three 74LS00 NAND gates (U3C, U3D, U4C). The multiplexer selects between this "one pulse per hour" signal and the 2 Hz signal allowing setting up hours. Two additional 74LS00 NAND gates (U3A and U3B) implement an RS flip-flop used to de-bounce "HOURS" switch (SW3). Both hours counters are wired in such a way that they will reset themselves once they reach the count of "24".
Six 74LS47 7-segment decoders (U5 - U10) and 7-segment displays (DIS1 - DIS6) are used to decode the binary outputs of the counters and display the result in human readable 24-hours time format.

## Schematic

[Schematic - Version 1.0](KiCad/TTL_Clock-Schematic-1.0.pdf)

## Bill of Materials

[74xx Clock project on Mouser.com](https://www.mouser.com/ProjectManager/ProjectDetail.aspx?AccessID=b30799acf1) - View and order all components except of the PCB.

[74xx Clock V1 project on OSH Park](https://oshpark.com/shared_projects/NnJT8T4s) - Order PCBs.

Component type     | Reference | Description                                 | Quantity | Possible sources and notes
------------------ | --------- | ------------------------------------------- | -------- | --------------------------
PCB                |           | 74xx Clock V1.0 Printed Circuit Board       | 1        | Order from [OSH Park](https://oshpark.com/shared_projects/NnJT8T4s) or another PCB manufacturer using provided KiCad or Gerber files
Stand              |           | 3D printed stand for the clock              | 1        | (Optional) Print on a 3D printer using standforclock.stl. Thanks to Michael K. for designing this stand.
Capacitor          | C1 - C16  | 0.1uF, 50V, multilayer ceramic capacitor, axial | 16   | Mouser: 594-A104K15X7RF5UAA
Capacitor          | C17       | 100uF, 25V, electrolytic capacitor, radial, 5 mm diameter | 1 | Mouser: 647-UVY1E101MDD
Capacitor          | C18       | 12pF, 50V, multilayer ceramic capacitor, 5.08 mm lead spacing | 1 | Mouser: 810-FK28C0G1H120J
Trimmer Capacitor  | C19       | 5-20pF, trimmer capacitor, 5 mm lead spacing | 1       | Mouser: 659-GKG20015
LED                | D1 - D4   | 5 mm or 3 mm LED, color matching to DIS1 - DIS6 | 4    | Mouser: 859-LTL-4221 (red, 623 nm, 8.7 mcd) 859-LTL-4211 (red, 697 nm, 2.5 mcd), 859-LTL-4251N (yellow, 585 nm, 8.7 mcd)
LED Display        | DIS1 - DIS6 | 7-segment LED display, 0.4", 14 pin DIP, common anode | 6 | Mouser: 859-LTS-4910AHR (red, 635 nm, 2.2 mcd), 859-LTS-4810AY (yellow, 585 nm, 2.2 mcd); 859-LTS-4710AP (red, 697 nm, 0.8 mcd), SA04-11EWA (red, 625 nm), SA04-11SRWA (red, 640 nm), SA04-11YWA (yellow, 588 nm), SA04-11GWA (green, 568 nm)
Connector          | P1        | DC Power Jack                               | 1        | Mouser: 806-KLDX-0202-A; Jameco 101178
Resistor           | R1 - R5   | 4.7 kOhm, 1/4 W                             | 5        | Mouser: 291-4.7K-RC
Resistor           | R6        | 330 kOhm, 1/4 W                             | 1        | Mouser: 291-330K-RC
Resistor           | R7        | 15 MOhm, 1/4 W                              | 1        | Mouser: 660-CF1/4C156J
Resistor           | R8 - R11  | 470 Ohm, 1/4 W                              | 4        | Mouser 291-470-RC; Jameco 690785
Resistor Array     | RR1 - RR6 | 470 Ohm, 7 isolated resistors, 14 pin DIP   | 6        | Mouser: 652-4114R-1LF-470; Or 42 discrete resistors (e.g. see R8-R11)
Switch             | SW1 - SW3 | SPDT momentary switch, Omron D2F            | 3        | Mouser: 653-D2F-01, 653-D2F-01L, 653-D2F-01F
Integrated Circuit | U1        | 14-stage binary counter with oscillator, 74HC4060 | 1  | Mouser: 595-CD74HCT4060E, 595-SN74HC4060N, 595-CD74HC4060E, 771-HCT4060N652, 771-74HC4060N
Integrated Circuit | U2 - U4   | Quad 4-input NAND gate, 74LS00              | 3        | Mouser: 595-SN74LS00N, 595-SN74LS00NE4, 595-SN74ALS00AN
Integrated Circuit | U5 - U10  | BCD to 7-segment decoder, 74LS47 or 74LS247 | 6        | Mouser: 595-SN74LS47N, 595-SN74LS47NE4, 595-SN74LS247N, 595-SN74LS247NE4
Integrated Circuit | U11 - U16 | Decade counter, 74LS90                      | 6        | Mouser: 595-SN74LS90N, 595-SN74LS90NE4
Crystal Resonator  | X1        | 32768 Hz, 12.5pF load capacitance, tuning fork | 1     | Mouser: 695-CFS206-327KEZB-U, 815-AB26T-32.768KHZ, 815-AB26TRQ-32.7-T
