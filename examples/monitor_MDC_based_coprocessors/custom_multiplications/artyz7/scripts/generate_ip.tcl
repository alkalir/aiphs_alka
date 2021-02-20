###########################
# IP Settings
###########################

# paths

# user should properly set root path
set root "."
set iproot $root/mm_accelerator
set ipdir $iproot/project_ip

set hdl_files_path $root/mm_accelerator/hdl

set bd_pkg_dir mm_accelerator/bd
set drivers_dir mm_accelerator/drivers

set constraints_files []

# FPGA device
set partname "xc7z020clg400-1"

# Board part
set boardpart "digilentinc.com:arty-z7-20:part0:1.0"

# Design name
set ip_name "mm_accelerator"
set design $ip_name

###########################
# Create IP
###########################

create_project -force $design $ipdir -part $partname
set_property board_part $boardpart [current_project]
set_property target_language Verilog [current_project]

add_files $hdl_files_path
import_files -force

set files [glob -tails -directory $ipdir/$ip_name.srcs/sources_1/imports/hdl/lib/caph/ *]
foreach f $files {
	set name $f
	set_property library caph [get_files  $ipdir/$ip_name.srcs/sources_1/imports/hdl/lib/caph/$f]
        }

set_property top $ip_name [current_fileset]

ipx::package_project -root_dir $ipdir -vendor user.org -library user -taxonomy AXI_Peripheral

ipx::remove_address_block reg0 [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]
ipx::add_address_block s00_axi_reg [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]
set_property usage register [ipx::get_address_blocks s00_axi_reg -of_objects [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]]
ipx::add_address_block_parameter OFFSET_BASE_PARAM [ipx::get_address_blocks s00_axi_reg -of_objects [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]]
ipx::add_address_block_parameter OFFSET_HIGH_PARAM [ipx::get_address_blocks s00_axi_reg -of_objects [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]]
set_property value C_CFG_BASEADDR [ipx::get_address_block_parameters OFFSET_BASE_PARAM -of_objects [ipx::get_address_blocks s00_axi_reg -of_objects [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]]]
set_property value C_CFG_HIGHADDR [ipx::get_address_block_parameters OFFSET_HIGH_PARAM -of_objects [ipx::get_address_blocks s00_axi_reg -of_objects [ipx::get_memory_maps s00_axi -of_objects [ipx::current_core]]]]
ipx::remove_address_block reg0 [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]
ipx::add_address_block s01_axi_mem [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]
set_property usage memory [ipx::get_address_blocks s01_axi_mem -of_objects [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]]
ipx::add_address_block_parameter OFFSET_BASE_PARAM [ipx::get_address_blocks s01_axi_mem -of_objects [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]]
ipx::add_address_block_parameter OFFSET_HIGH_PARAM [ipx::get_address_blocks s01_axi_mem -of_objects [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]]
set_property value C_MEM_BASEADDR [ipx::get_address_block_parameters OFFSET_BASE_PARAM -of_objects [ipx::get_address_blocks s01_axi_mem -of_objects [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]]]
set_property value C_MEM_HIGHADDR [ipx::get_address_block_parameters OFFSET_HIGH_PARAM -of_objects [ipx::get_address_blocks s01_axi_mem -of_objects [ipx::get_memory_maps s01_axi -of_objects [ipx::current_core]]]]

set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_ID_WIDTH'))>0 [ipx::get_ports s01_axi_awid -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_AWUSER_WIDTH'))>0 [ipx::get_ports s01_axi_awuser -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_WUSER_WIDTH'))>0 [ipx::get_ports s01_axi_wuser -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_ID_WIDTH'))>0 [ipx::get_ports s01_axi_bid -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_BUSER_WIDTH'))>0 [ipx::get_ports s01_axi_buser -of_objects [ipx::current_core]]
set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_ID_WIDTH')) >0} [ipx::get_ports s01_axi_arid -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_ARUSER_WIDTH')) [ipx::get_ports s01_axi_aruser -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_ARUSER_WIDTH'))>0 [ipx::get_ports s01_axi_aruser -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_ID_WIDTH'))>0 [ipx::get_ports s01_axi_rid -of_objects [ipx::current_core]]
set_property enablement_dependency spirit:decode(id('MODELPARAM_VALUE.C_S01_AXI_RUSER_WIDTH'))>0 [ipx::get_ports s01_axi_ruser -of_objects [ipx::current_core]]



file copy -force $iproot/bd $ipdir
set bd_pkg_dir bd
set bd_group [ipx::add_file_group -type xilinx_blockdiagram {} [ipx::current_core]]
ipx::add_file $bd_pkg_dir/bd.tcl $bd_group

file copy -force $iproot/drivers $ipdir
set drivers_dir drivers
ipx::add_file_group -type software_driver {} [ipx::current_core]
ipx::add_file $drivers_dir/src/mm_accelerator.c [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files $drivers_dir/src/mm_accelerator.c -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file $drivers_dir/src/mm_accelerator.h [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type cSource [ipx::get_files $drivers_dir/src/mm_accelerator.h -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file $drivers_dir/src/Makefile [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type unknown [ipx::get_files $drivers_dir/src/Makefile -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file $drivers_dir/data/mm_accelerator.tcl [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type tclSource [ipx::get_files $drivers_dir/data/mm_accelerator.tcl -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]
ipx::add_file $drivers_dir/data/mm_accelerator.mdd [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]
set_property type mdd [ipx::get_files $drivers_dir/data/mm_accelerator.mdd -of_objects [ipx::get_file_groups xilinx_softwaredriver -of_objects [ipx::current_core]]]

set_property core_revision 3 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths $ipdir [current_project]
update_ip_catalog
close_project
