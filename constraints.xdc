# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
	
# Switches
set_property PACKAGE_PIN V17 [get_ports {dividend[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dividend[0]}]
set_property PACKAGE_PIN V16 [get_ports {dividend[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dividend[1]}]
set_property PACKAGE_PIN W16 [get_ports {dividend[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dividend[2]}]
set_property PACKAGE_PIN W17 [get_ports {dividend[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dividend[3]}]
set_property PACKAGE_PIN U1 [get_ports {divisor[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {divisor[0]}]
set_property PACKAGE_PIN W15 [get_ports {divisor[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {divisor[1]}]
set_property PACKAGE_PIN R3 [get_ports {divisor[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {divisor[2]}]
set_property PACKAGE_PIN V2 [get_ports {divisor[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {divisor[3]}]
	
	
	
set_property PACKAGE_PIN T1 [get_ports {start}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {start}]
set_property PACKAGE_PIN R2 [get_ports {rst}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {rst}]
 
 
 #7 segment display
set_property PACKAGE_PIN W7 [get_ports {seg[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property PACKAGE_PIN W6 [get_ports {seg[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U8 [get_ports {seg[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V5 [get_ports {seg[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U7 [get_ports {seg[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]




set_property PACKAGE_PIN U2 [get_ports {digit[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digit[0]}]
set_property PACKAGE_PIN U4 [get_ports {digit[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digit[1]}]
set_property PACKAGE_PIN V4 [get_ports {digit[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digit[2]}]
set_property PACKAGE_PIN W4 [get_ports {digit[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {digit[3]}]
	
	
	
# LEDs
set_property PACKAGE_PIN U15 [get_ports {remainder[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {remainder[0]}]
set_property PACKAGE_PIN E19 [get_ports {remainder[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {remainder[4]}]
set_property PACKAGE_PIN U19 [get_ports {remainder[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {remainder[3]}]
set_property PACKAGE_PIN V19 [get_ports {remainder[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {remainder[2]}]
set_property PACKAGE_PIN W18 [get_ports {remainder[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {remainder[1]}]
	
	
	
# set_property PACKAGE_PIN W3 [get_ports {quotient[0]}]					
	# set_property IOSTANDARD LVCMOS33 [get_ports {quotient[0]}]
# set_property PACKAGE_PIN U3 [get_ports {quotient[1]}]					
	# set_property IOSTANDARD LVCMOS33 [get_ports {quotient[1]}]
# set_property PACKAGE_PIN P3 [get_ports {quotient[2]}]					
	# set_property IOSTANDARD LVCMOS33 [get_ports {quotient[2]}]
# set_property PACKAGE_PIN N3 [get_ports {quotient[3]}]					
	# set_property IOSTANDARD LVCMOS33 [get_ports {quotient[3]}]
				
	
	set_property PACKAGE_PIN L1 [get_ports {done}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {done}]
	