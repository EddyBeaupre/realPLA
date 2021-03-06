EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:nmos-logic
EELAYER 27 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 4
Title ""
Date "20 dec 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 5950 2200 3    60   ~ 0
Change to invert output
Text Notes 1650 1250 0    100  ~ 20
Output Stage and Pad Buffer
Wire Wire Line
	6700 1400 6700 1550
Wire Wire Line
	6700 4100 6700 3950
Wire Wire Line
	6700 2450 6700 3050
Connection ~ 5800 3500
Wire Wire Line
	5700 3400 5700 2000
Wire Wire Line
	5700 2000 6100 2000
Wire Wire Line
	5550 2200 5700 2200
Wire Wire Line
	4350 2200 3000 2200
Wire Wire Line
	3400 2850 3400 2900
Wire Wire Line
	3000 3050 3000 3300
Wire Wire Line
	3400 2100 3400 2300
Wire Wire Line
	3400 3700 3600 3700
Connection ~ 1750 3000
Wire Wire Line
	3000 3550 1750 3550
Wire Wire Line
	1750 3550 1750 2450
Wire Wire Line
	3600 4450 3600 4250
Wire Wire Line
	1600 4100 3200 4100
Wire Wire Line
	1600 3000 1750 3000
Wire Wire Line
	2950 2450 3000 2450
Wire Wire Line
	3400 2600 3600 2600
Wire Wire Line
	3600 2600 3600 3950
Connection ~ 3600 3700
Wire Wire Line
	3000 2200 3000 1950
Connection ~ 3400 2200
Wire Wire Line
	3400 3400 3400 3200
Connection ~ 3400 3300
Wire Wire Line
	3400 1750 3400 1800
Wire Wire Line
	3000 3300 4350 3300
Wire Wire Line
	5800 3300 5550 3300
Connection ~ 5800 3300
Connection ~ 5700 2200
Wire Wire Line
	5800 2100 5800 3500
Wire Wire Line
	5800 3500 6100 3500
Connection ~ 5700 2000
Wire Wire Line
	7000 2750 6700 2750
Connection ~ 6700 2750
$Comp
L PAD P18
U 1 1 50BD12EE
P 7400 2750
F 0 "P18" H 7400 2800 60  0000 C CNN
F 1 "F0" H 7400 2700 60  0000 C CNN
F 2 "" H 7400 2750 60  0001 C CNN
F 3 "" H 7400 2750 60  0001 C CNN
	1    7400 2750
	-1   0    0    1   
$EndComp
Text Notes 5000 3650 0    60   ~ 0
AND(#F0, OE)
Text Notes 5000 1950 0    60   ~ 0
AND(NOT(#F0), OE)
$Comp
L VCC #PWR?
U 1 1 50BD120B
P 6700 1400
F 0 "#PWR?" H 6700 1500 30  0001 C CNN
F 1 "VCC" H 6700 1500 30  0000 C CNN
F 2 "" H 6700 1400 60  0001 C CNN
F 3 "" H 6700 1400 60  0001 C CNN
	1    6700 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 50BD1207
P 6700 4100
F 0 "#PWR?" H 6700 4100 30  0001 C CNN
F 1 "GND" H 6700 4030 30  0001 C CNN
F 2 "" H 6700 4100 60  0001 C CNN
F 3 "" H 6700 4100 60  0001 C CNN
	1    6700 4100
	1    0    0    -1  
$EndComp
NoConn ~ 5700 3400
NoConn ~ 5800 2100
$Comp
L NMOS-ENH-XL T2320
U 1 1 50B223B9
P 6450 3500
F 0 "T2320" H 6700 3500 60  0000 C CNN
F 1 "NMOS-ENH-XL" H 6450 4025 60  0001 C CNN
F 2 "" H 6450 3500 60  0001 C CNN
F 3 "" H 6450 3500 60  0001 C CNN
	1    6450 3500
	1    0    0    -1  
$EndComp
$Comp
L NMOS-ENH-XL T2319
U 1 1 50B223B1
P 6450 2000
F 0 "T2319" H 6700 2000 60  0000 C CNN
F 1 "NMOS-ENH-XL" H 6450 2525 60  0001 C CNN
F 2 "" H 6450 2000 60  0001 C CNN
F 3 "" H 6450 2000 60  0001 C CNN
	1    6450 2000
	1    0    0    -1  
$EndComp
$Comp
L NMOS-SUPER-INVERTER-L T2315..T2318
U 1 1 50B222A7
P 4950 3300
F 0 "T2315..T2318" H 4950 2775 60  0000 C CNN
F 1 "NMOS-SUPER-INVERTER-L" H 4950 3825 60  0001 C CNN
F 2 "" H 4950 3300 60  0001 C CNN
F 3 "" H 4950 3300 60  0001 C CNN
	1    4950 3300
	1    0    0    -1  
$EndComp
$Comp
L NMOS-SUPER-INVERTER-L T2311..T2314
U 1 1 50B222A0
P 4950 2200
F 0 "T2311..T2314" H 4950 1675 60  0000 C CNN
F 1 "NMOS-SUPER-INVERTER-L" H 4950 2725 60  0001 C CNN
F 2 "" H 4950 2200 60  0001 C CNN
F 3 "" H 4950 2200 60  0001 C CNN
	1    4950 2200
	1    0    0    -1  
$EndComp
Text Notes 3700 3300 0    60   ~ 0
NAND(#F0, OE)
Text Notes 3500 2200 0    60   ~ 0
NAND(NOT(#F0), OE)
$Comp
L VCC #PWR?
U 1 1 50B21F7A
P 3400 2850
F 0 "#PWR?" H 3400 2950 30  0001 C CNN
F 1 "VCC" H 3400 2950 30  0000 C CNN
F 2 "" H 3400 2850 60  0001 C CNN
F 3 "" H 3400 2850 60  0001 C CNN
	1    3400 2850
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR?
U 1 1 50B21F70
P 3400 1750
F 0 "#PWR?" H 3400 1850 30  0001 C CNN
F 1 "VCC" H 3400 1850 30  0000 C CNN
F 2 "" H 3400 1750 60  0001 C CNN
F 3 "" H 3400 1750 60  0001 C CNN
	1    3400 1750
	1    0    0    -1  
$EndComp
$Comp
L NMOS-DEPL-M T2309
U 1 1 50B21E55
P 3250 3050
F 0 "T2309" H 3000 3150 60  0000 C CNN
F 1 "NMOS-DEPL-M" H 3250 3275 60  0001 C CNN
F 2 "" H 3250 3050 60  0001 C CNN
F 3 "" H 3250 3050 60  0001 C CNN
	1    3250 3050
	1    0    0    -1  
$EndComp
$Comp
L NMOS-DEPL-M T2307
U 1 1 50B21E4B
P 3250 1950
F 0 "T2307" H 3000 2050 60  0000 C CNN
F 1 "NMOS-DEPL-M" H 3250 2175 60  0001 C CNN
F 2 "" H 3250 1950 60  0001 C CNN
F 3 "" H 3250 1950 60  0001 C CNN
	1    3250 1950
	1    0    0    -1  
$EndComp
$Comp
L NMOS-ENH-M T2310
U 1 1 50B21E36
P 3250 3550
F 0 "T2310" H 3000 3650 60  0000 C CNN
F 1 "NMOS-ENH-M" H 3250 3775 60  0001 C CNN
F 2 "" H 3250 3550 60  0001 C CNN
F 3 "" H 3250 3550 60  0001 C CNN
	1    3250 3550
	1    0    0    -1  
$EndComp
$Comp
L NMOS-ENH-M T2308
U 1 1 50B21E30
P 3250 2450
F 0 "T2308" H 3000 2550 60  0000 C CNN
F 1 "NMOS-ENH-M" H 3250 2675 60  0001 C CNN
F 2 "" H 3250 2450 60  0001 C CNN
F 3 "" H 3250 2450 60  0001 C CNN
	1    3250 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 50B21D6B
P 3600 4450
F 0 "#PWR?" H 3600 4450 30  0001 C CNN
F 1 "GND" H 3600 4380 30  0001 C CNN
F 2 "" H 3600 4450 60  0001 C CNN
F 3 "" H 3600 4450 60  0001 C CNN
	1    3600 4450
	1    0    0    -1  
$EndComp
Text GLabel 1600 4100 0    60   Input ~ 0
OE
$Comp
L NMOS-ENH-M T2306
U 1 1 50B21D4B
P 3450 4100
F 0 "T2306" H 3350 3850 60  0000 C CNN
F 1 "NMOS-ENH-M" H 3450 4325 60  0001 C CNN
F 2 "" H 3450 4100 60  0001 C CNN
F 3 "" H 3450 4100 60  0001 C CNN
	1    3450 4100
	1    0    0    -1  
$EndComp
$Comp
L NMOS-SUPER-INVERTER-L T2302..T2305
U 1 1 50B21C7D
P 2350 2450
F 0 "T2302..T2305" H 2350 1925 60  0000 C CNN
F 1 "NMOS-SUPER-INVERTER-L" H 2350 2975 60  0001 C CNN
F 2 "" H 2350 2450 60  0001 C CNN
F 3 "" H 2350 2450 60  0001 C CNN
	1    2350 2450
	1    0    0    -1  
$EndComp
Text GLabel 1600 3000 0    60   Input ~ 0
#F0
Text Notes 8000 1300 0    100  ~ 0
F0	T2302..T2320\nF1	T2321..T2339\nF2	T2340..T2358\nF3	T2359..T2377\nF4	T2378..T2396\nF5	T2397..T2415\nF6	T2416..T2434\nF7	T2435..T2453
Text Notes 1650 1500 0    100  ~ 0
For each output F0..F7
$EndSCHEMATC
