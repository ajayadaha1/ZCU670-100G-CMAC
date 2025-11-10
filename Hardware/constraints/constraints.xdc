# -- Copyright (C) 2022 - 2024 Advanced Micro Devices,Inc. 
#
###############################################################################
##
## 
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##
###############################################################################

#######################################################
##                                                   ##
## Design Constraints                                ##
#######################################################

#######################################################
set_property PACKAGE_PIN K11 [get_ports SI53340_MUX_GT_SEL]
set_property IOSTANDARD LVCMOS18 [get_ports SI53340_MUX_GT_SEL]

#SFPs two lanes
#SFP's 
set_property PACKAGE_PIN N30 [get_ports gt_rtl0_gtx_p[0]]
set_property PACKAGE_PIN P33 [get_ports gt_rtl0_grx_p[0]]
set_property PACKAGE_PIN L30 [get_ports gt_rtl0_gtx_p[1]]
set_property PACKAGE_PIN M33 [get_ports gt_rtl0_grx_p[1]]


#USER_MGT_SI570_CLOCK2_C_P 
#create_clock -period 6.4 [get_ports GT_REF_CLK_clk_p]
set_property PACKAGE_PIN K28 [get_ports diff_clock_rtl_0_clk_p]
create_clock -period 6.4 [get_ports diff_clock_rtl_0_clk_p]


#LED 2 and 3
# led 0 .. 7 =>
set_property IOSTANDARD LVCMOS18  [get_ports *LED]
set_property PACKAGE_PIN    C9    [get_ports AXI_LITE_RST_LED]
set_property PACKAGE_PIN    D9    [get_ports AXI_LITE_CLK_LED]
#set_property PACKAGE_PIN    A9    [get_ports mgt_clk_led]
set_property PACKAGE_PIN    A10   [get_ports RX_CLK_LED]

set_property PACKAGE_PIN A9 [get_ports PPS_OUT_LED]
set_property IOSTANDARD LVCMOS18 [get_ports PPS_OUT_LED]
set_false_path -to [get_ports PPS_OUT_LED]
