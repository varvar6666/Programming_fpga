//Copyright (C)2014-2024 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//Tool Version: V1.9.9.02 
//Created Time: 2024-11-01 18:40:44
create_clock -name input_clk -period 37.037 -waveform {0 18} [get_ports {HCLK_i}]
