
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:062

00:00:102	
472.8202	
175.633Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/utils_1/imports/synth_1/toplevel.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2`
^C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/utils_1/imports/synth_1/toplevel.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
c
Command: %s
53*	vivadotcl22
0synth_design -top toplevel -part xc7a35tcpg236-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
z
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7a35tZ17-347h px� 
j
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7a35tZ17-349h px� 
D
Loading part %s157*device2
xc7a35tcpg236-1Z21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
16604Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:07 ; elapsed = 00:00:08 . Memory (MB): peak = 1309.488 ; gain = 440.609
h px� 
�
synthesizing module '%s'638*oasys2

toplevel2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
288@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Instruction_Fetch2_
]C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Instruction_Fetch.vhd2
122
Instruction_Fetch_12
Instruction_Fetch2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
2098@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Instruction_Fetch2a
]C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Instruction_Fetch.vhd2
258@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Program_Counter2J
HC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Program_Counter.vhd2
132
Program_Counter_12
Program_Counter2a
]C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Instruction_Fetch.vhd2
518@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Program_Counter2L
HC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Program_Counter.vhd2
278@Z8-638h px� 
�
default block is never used226*oasys2L
HC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Program_Counter.vhd2
538@Z8-226h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Program_Counter2
02
12L
HC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Program_Counter.vhd2
278@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

prog_mem2C
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/prog_mem.vhd2
152

prog_mem_12

prog_mem2a
]C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Instruction_Fetch.vhd2
628@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2

prog_mem2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/prog_mem.vhd2
218@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

prog_mem2
02
12E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/prog_mem.vhd2
218@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Instruction_Fetch2
02
12a
]C:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Instruction_Fetch.vhd2
258@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Pipeline_Register_one2P
NC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Pipeline_Register_one.vhd2
122
Pipeline_Register_one_12
Pipeline_Register_one2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
2238@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Pipeline_Register_one2R
NC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Pipeline_Register_one.vhd2
208@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Pipeline_Register_one2
02
12R
NC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Pipeline_Register_one.vhd2
208@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
DEC2>
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/DEC.vhd2
112
DEC_12
DEC2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
2308@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
DEC2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/DEC.vhd2
418@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2	
decoder2B
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/decoder.vhd2
192
	decoder_12	
decoder2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/DEC.vhd2
1288@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2	
decoder2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/decoder.vhd2
498@Z8-638h px� 
�
default block is never used226*oasys2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/decoder.vhd2
2108@Z8-226h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2	
decoder2
02
12D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/decoder.vhd2
498@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
State_Machine2[
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/State_Machine.vhd2
132
STATE_MACHINE_12
State_Machine2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/DEC.vhd2
1568@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
State_Machine2]
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/State_Machine.vhd2
218@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
State_Machine2
02
12]
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/State_Machine.vhd2
218@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

Reg_File2C
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Reg_File.vhd2
122

Reg_File_12

Reg_File2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/DEC.vhd2
1638@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2

Reg_File2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Reg_File.vhd2
268@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

Reg_File2
02
12E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Reg_File.vhd2
268@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
DEC2
02
12@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/DEC.vhd2
418@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Pipeline_Register_two2P
NC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Pipeline_Register_two.vhd2
132
Pipeline_Register_two_12
Pipeline_Register_two2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
2608@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Pipeline_Register_two2R
NC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Pipeline_Register_two.vhd2
448@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Pipeline_Register_two2
02
12R
NC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Pipeline_Register_two.vhd2
448@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2	
Execute2B
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
122
	Execute_12	
Execute2E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
2908@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2	
Execute2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
358@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Stack_Pointer2[
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Stack_Pointer.vhd2
142
Stack_Pointer_12
Stack_Pointer2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
1258@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Stack_Pointer2]
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Stack_Pointer.vhd2
228@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Stack_Pointer2
02
12]
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Stack_Pointer.vhd2
228@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Data_Memory2Y
WC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Data_Memory.vhd2
142
Data_Memory_12
Data_Memory2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
1338@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Data_Memory2[
WC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Data_Memory.vhd2
238@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Data_Memory2
02
12[
WC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Data_Memory.vhd2
238@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Ports2S
QC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports.vhd2
132	
Ports_12
Ports2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
1428@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Ports2U
QC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports.vhd2
278@Z8-638h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
Ports_decoder2[
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports_decoder.vhd2
132
Ports_decoder_12
Ports_decoder2U
QC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports.vhd2
628@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
Ports_decoder2]
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports_decoder.vhd2
208@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Ports_decoder2
02
12]
YC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports_decoder.vhd2
208@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
Ports2
02
12U
QC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/Ports.vhd2
278@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
ALU2>
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/ALU.vhd2
152
ALU_12
ALU2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
1568@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
ALU2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/ALU.vhd2
268@Z8-638h px� 
�
default block is never used226*oasys2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/ALU.vhd2
748@Z8-226h px� 
�
default block is never used226*oasys2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/ALU.vhd2
1078@Z8-226h px� 
�
default block is never used226*oasys2@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/ALU.vhd2
1288@Z8-226h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
ALU2
02
12@
<C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/ALU.vhd2
268@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2
SREG2?
=C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/SREG.vhd2
122
SREG_12
SREG2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
1668@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2
SREG2A
=C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/SREG.vhd2
218@Z8-638h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2
SREG2
02
12A
=C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/SREG.vhd2
218@Z8-256h px� 
�
Hmodule '%s' declared at '%s:%s' bound to instance '%s' of component '%s'3392*oasys2

puls_seg2V
TC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/puls_seg.vhd2
182

puls_seg_12

puls_seg2D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
1738@Z8-3491h px� 
�
synthesizing module '%s'638*oasys2

puls_seg2X
TC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/puls_seg.vhd2
278@Z8-638h px� 
�
default block is never used226*oasys2X
TC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/puls_seg.vhd2
528@Z8-226h px� 
�
default block is never used226*oasys2X
TC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/puls_seg.vhd2
938@Z8-226h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

puls_seg2
02
12X
TC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.srcs/sources_1/new/puls_seg.vhd2
278@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2	
Execute2
02
12D
@C:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Execute.vhd2
358@Z8-256h px� 
�
%done synthesizing module '%s' (%s#%s)256*oasys2

toplevel2
02
12E
AC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/toplevel.vhd2
288@Z8-256h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1430.523 ; gain = 561.645
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1430.523 ; gain = 561.645
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:10 ; elapsed = 00:00:11 . Memory (MB): peak = 1430.523 ; gain = 561.645
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0252

1430.5232
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2J
FC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Basys3_Master.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2J
FC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Basys3_Master.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2H
FC:/Users/Rubsen/Documents/Vivado/Prozessor/hw_beschr/Basys3_Master.xdc2
.Xil/toplevel_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1458.0862
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0072

1458.0862
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1458.086 ; gain = 589.207
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Loading part: xc7a35tcpg236-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:19 ; elapsed = 00:00:21 . Memory (MB): peak = 1458.086 ; gain = 589.207
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1458.086 ; gain = 589.207
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1458.086 ; gain = 589.207
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   18 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   3 Input    8 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit       Adders := 1     
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   2 Input      8 Bit         XORs := 1     
h p
x
� 
H
%s
*synth20
.	   2 Input      1 Bit         XORs := 2     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               18 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               16 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                9 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 52    
h p
x
� 
H
%s
*synth20
.	                7 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 4     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                2 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 18    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   4 Input    9 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    9 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   9 Input    9 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  12 Input    9 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   6 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   9 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  12 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   4 Input    8 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   8 Input    8 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   5 Input    6 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   5 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   9 Input    5 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   3 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  12 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   6 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   9 Input    4 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  12 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  14 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   9 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	  12 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  12 Input    2 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   7 Input    2 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  11 Input    2 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   9 Input    1 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	  12 Input    1 Bit        Muxes := 8     
h p
x
� 
F
%s
*synth2.
,	  11 Input    1 Bit        Muxes := 13    
h p
x
� 
F
%s
*synth2.
,	   6 Input    1 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 33    
h p
x
� 
F
%s
*synth2.
,	  14 Input    1 Bit        Muxes := 1     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
p
%s
*synth2X
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:28 ; elapsed = 00:00:30 . Memory (MB): peak = 1458.086 ; gain = 589.207
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
;
%s*synth2#
!
ROM: Preliminary Mapping Report
h px� 
y
%s*synth2a
_+------------+----------------------------------------------+---------------+----------------+
h px� 
z
%s*synth2b
`|Module Name | RTL Object                                   | Depth x Width | Implemented As | 
h px� 
y
%s*synth2a
_+------------+----------------------------------------------+---------------+----------------+
h px� 
z
%s*synth2b
`|prog_mem    | PROGMEM[0]                                   | 512x16        | LUT            | 
h px� 
z
%s*synth2b
`|toplevel    | Pipeline_Register_one_1/P_Register_instr_reg | 512x16        | Block RAM      | 
h px� 
z
%s*synth2b
`+------------+----------------------------------------------+---------------+----------------+

h px� 
X
%s*synth2@
>
Distributed RAM: Preliminary Mapping Report (see note below)
h px� 
�
%s*synth2h
f+------------+---------------------------------+-----------+----------------------+-----------------+
h px� 
�
%s*synth2i
g|Module Name | RTL Object                      | Inference | Size (Depth x Width) | Primitives      | 
h px� 
�
%s*synth2h
f+------------+---------------------------------+-----------+----------------------+-----------------+
h px� 
�
%s*synth2i
g|toplevel    | Execute_1/Data_Memory_1/RAM_reg | Implied   | 1 K x 8              | RAM256X1S x 32  | 
h px� 
�
%s*synth2i
g+------------+---------------------------------+-----------+----------------------+-----------------+

h px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the Distributed RAMs at the current stage of the synthesis flow. Some Distributed RAMs may be reimplemented as non Distributed RAM primitives later in the synthesis flow. Multiple instantiated RAMs are reported only once.
h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:34 ; elapsed = 00:00:36 . Memory (MB): peak = 1458.086 ; gain = 589.207
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:42 ; elapsed = 00:00:44 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
A
%s
*synth2)
'
Distributed RAM: Final Mapping Report
h p
x
� 
�
%s
*synth2h
f+------------+---------------------------------+-----------+----------------------+-----------------+
h p
x
� 
�
%s
*synth2i
g|Module Name | RTL Object                      | Inference | Size (Depth x Width) | Primitives      | 
h p
x
� 
�
%s
*synth2h
f+------------+---------------------------------+-----------+----------------------+-----------------+
h p
x
� 
�
%s
*synth2i
g|toplevel    | Execute_1/Data_Memory_1/RAM_reg | Implied   | 1 K x 8              | RAM256X1S x 32  | 
h p
x
� 
�
%s
*synth2i
g+------------+---------------------------------+-----------+----------------------+-----------------+

h p
x
� 
�
%s
*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:43 ; elapsed = 00:00:45 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
5
%s*synth2
+------+----------+------+
h px� 
5
%s*synth2
|      |Cell      |Count |
h px� 
5
%s*synth2
+------+----------+------+
h px� 
5
%s*synth2
|1     |BUFG      |     1|
h px� 
5
%s*synth2
|2     |CARRY4    |    18|
h px� 
5
%s*synth2
|3     |LUT1      |     5|
h px� 
5
%s*synth2
|4     |LUT2      |    33|
h px� 
5
%s*synth2
|5     |LUT3      |    49|
h px� 
5
%s*synth2
|6     |LUT4      |    33|
h px� 
5
%s*synth2
|7     |LUT5      |    93|
h px� 
5
%s*synth2
|8     |LUT6      |   491|
h px� 
5
%s*synth2
|9     |MUXF7     |   139|
h px� 
5
%s*synth2
|10    |MUXF8     |    16|
h px� 
5
%s*synth2
|11    |RAM256X1S |    32|
h px� 
5
%s*synth2
|12    |FDRE      |   556|
h px� 
5
%s*synth2
|13    |IBUF      |    22|
h px� 
5
%s*synth2
|14    |OBUF      |    28|
h px� 
5
%s*synth2
+------+----------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:37 ; elapsed = 00:00:48 . Memory (MB): peak = 1531.938 ; gain = 635.496
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:49 ; elapsed = 00:00:51 . Memory (MB): peak = 1531.938 ; gain = 663.059
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0362

1531.9382
0.000Z17-268h px� 
U
-Analyzing %s Unisim elements for replacement
17*netlist2
205Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1533.8162
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2u
s  A total of 32 instances were transformed.
  RAM256X1S => RAM256X1S (MUXF7(x2), MUXF8, RAMS64E(x4)): 32 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

8adf9ba1Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
~
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
812
12
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:552

00:01:062

1533.8162

1058.059Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0072

1533.8162
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2P
NC:/Users/Rubsen/Documents/Vivado/Prozessor/Prozessor.runs/synth_1/toplevel.dcpZ17-1381h px� 
�
%s4*runtcl2h
fExecuting : report_utilization -file toplevel_utilization_synth.rpt -pb toplevel_utilization_synth.pb
h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Tue Jan  2 11:21:27 2024Z17-206h px� 


End Record