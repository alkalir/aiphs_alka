###########################
# IP Settings
###########################

# paths

# user should properly set root path
set root "."
set projdir $root/project_top
set ipdir $root/mm_accelerator/project_ip

set constraints_files []

# FPGA device
set partname "xc7z020clg400-1"

# Board part
set boardpart "digilentinc.com:arty-z7-20:part0:1.0"

# Design name
set design system
set bd_design "design_1"

set ip_name "mm_accelerator"
set ip_version "1.0"
set ip_v "v1_0"


###########################
# Create Project
###########################
create_project -force $design $projdir -part $partname
set_property board_part $boardpart [current_project]
set_property target_language Verilog [current_project]
set_property  ip_repo_paths $ipdir [current_project]
update_ip_catalog -rebuild -scan_changes
###########################
#create block design
create_bd_design $bd_design

# Zynq PS
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
connect_bd_net [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/FCLK_CLK0]

# accelerator IP
create_bd_cell -type ip -vlnv user.org:user:$ip_name:$ip_version $ip_name\_0
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" intc_ip "New AXI Interconnect" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins $ip_name\_0/s00_axi]
# CDMA
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_cdma:4.1 axi_cdma_0
set_property -dict [list CONFIG.C_INCLUDE_SG {0}] [get_bd_cells axi_cdma_0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" intc_ip "/ps7_0_axi_periph" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins axi_cdma_0/S_AXI_LITE]
set_property -dict [list CONFIG.PCW_USE_S_AXI_HP0 {1}] [get_bd_cells processing_system7_0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_cdma_0/M_AXI" intc_ip "New AXI Interconnect" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins mm_accelerator_0/s01_axi]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/axi_cdma_0/M_AXI" intc_ip "/axi_mem_intercon" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]

make_wrapper -files [get_files $projdir/$design.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse $projdir/$design.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v

generate_target all [get_files  $projdir/$design.srcs/sources_1/bd/design_1/design_1.bd]
