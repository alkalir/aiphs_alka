vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/blk_mem_gen_v8_3_6
vlib riviera/axi_bram_ctrl_v4_0_13
vlib riviera/lib_pkg_v1_0_2
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/fifo_generator_v13_2_1
vlib riviera/lib_fifo_v1_0_10
vlib riviera/lib_cdc_v1_0_2
vlib riviera/axi_datamover_v5_1_17
vlib riviera/axi_sg_v4_1_8
vlib riviera/axi_cdma_v4_1_15
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/interrupt_control_v3_1_4
vlib riviera/axi_gpio_v2_0_17
vlib riviera/axi_uartlite_v2_0_19
vlib riviera/blk_mem_gen_v8_4_1
vlib riviera/mdm_v3_2_12
vlib riviera/microblaze_v10_0_5
vlib riviera/caph
vlib riviera/proc_sys_reset_v5_0_12
vlib riviera/xlconcat_v2_1_1
vlib riviera/xlconstant_v1_1_3
vlib riviera/lmb_bram_if_cntlr_v4_0_14
vlib riviera/lmb_v10_v3_0_9
vlib riviera/generic_baseblocks_v2_1_0
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_register_slice_v2_1_15
vlib riviera/axi_data_fifo_v2_1_14
vlib riviera/axi_crossbar_v2_1_16
vlib riviera/axi_protocol_converter_v2_1_15

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap blk_mem_gen_v8_3_6 riviera/blk_mem_gen_v8_3_6
vmap axi_bram_ctrl_v4_0_13 riviera/axi_bram_ctrl_v4_0_13
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap fifo_generator_v13_2_1 riviera/fifo_generator_v13_2_1
vmap lib_fifo_v1_0_10 riviera/lib_fifo_v1_0_10
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap axi_datamover_v5_1_17 riviera/axi_datamover_v5_1_17
vmap axi_sg_v4_1_8 riviera/axi_sg_v4_1_8
vmap axi_cdma_v4_1_15 riviera/axi_cdma_v4_1_15
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_4 riviera/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_17 riviera/axi_gpio_v2_0_17
vmap axi_uartlite_v2_0_19 riviera/axi_uartlite_v2_0_19
vmap blk_mem_gen_v8_4_1 riviera/blk_mem_gen_v8_4_1
vmap mdm_v3_2_12 riviera/mdm_v3_2_12
vmap microblaze_v10_0_5 riviera/microblaze_v10_0_5
vmap caph riviera/caph
vmap proc_sys_reset_v5_0_12 riviera/proc_sys_reset_v5_0_12
vmap xlconcat_v2_1_1 riviera/xlconcat_v2_1_1
vmap xlconstant_v1_1_3 riviera/xlconstant_v1_1_3
vmap lmb_bram_if_cntlr_v4_0_14 riviera/lmb_bram_if_cntlr_v4_0_14
vmap lmb_v10_v3_0_9 riviera/lmb_v10_v3_0_9
vmap generic_baseblocks_v2_1_0 riviera/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_15 riviera/axi_register_slice_v2_1_15
vmap axi_data_fifo_v2_1_14 riviera/axi_data_fifo_v2_1_14
vmap axi_crossbar_v2_1_16 riviera/axi_crossbar_v2_1_16
vmap axi_protocol_converter_v2_1_15 riviera/axi_protocol_converter_v2_1_15

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_3_6  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/2751/simulation/blk_mem_gen_v8_3.v" \

vcom -work axi_bram_ctrl_v4_0_13 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/20fd/hdl/axi_bram_ctrl_v4_0_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_bram_ctrl_0_0/sim/design_1_axi_bram_ctrl_0_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_bram_ctrl_1_0/sim/design_1_axi_bram_ctrl_1_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_bram_ctrl_2_0/sim/design_1_axi_bram_ctrl_2_0.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c35/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_1 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5c35/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_10 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f10a/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_17 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/71f3/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_8 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/5f94/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_cdma_v4_1_15 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f66e/hdl/axi_cdma_v4_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_cdma_0_0/sim/design_1_axi_cdma_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/8e66/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_17 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/c450/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_gpio_0_0/sim/design_1_axi_gpio_0_0.vhd" \

vcom -work axi_uartlite_v2_0_19 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/c778/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_uartlite_0_0/sim/design_1_axi_uartlite_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_1  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/67d8/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_0/sim/design_1_blk_mem_gen_0_0.v" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_1_0/sim/design_1_blk_mem_gen_1_0.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \

vcom -work mdm_v3_2_12 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/8608/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_mdm_1_0/sim/design_1_mdm_1_0.vhd" \

vcom -work microblaze_v10_0_5 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4f30/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_microblaze_0_0/sim/design_1_microblaze_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/axi_full_ipif.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/back_end.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/config_regs.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/configurator.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/counter.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/front_end.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/local_memory.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/multi_dataflow.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/sbox1x2.v" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/sbox2x1.v" \

vcom -work caph -93 \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/lib/caph/data_types.vhd" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/lib/caph/caph.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/adder_act.vhd" \

vcom -work caph -93 \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/lib/caph/fifo_big.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/forward_act.vhd" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/mac_16_act.vhd" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/mac_8_act.vhd" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/splitter_act.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ipshared/2b48/mm_accelerator.srcs/sources_1/imports/hdl/mm_accelerator.v" \
"../../../bd/design_1/ip/design_1_mm_accelerator_0_0/sim/design_1_mm_accelerator_0_0.v" \

vcom -work proc_sys_reset_v5_0_12 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_rst_clk_wiz_0_100M_0/sim/design_1_rst_clk_wiz_0_100M_0.vhd" \

vlog -work xlconcat_v2_1_1  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/2f66/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_xlconcat_1_0/sim/design_1_xlconcat_1_0.v" \

vlog -work xlconstant_v1_1_3  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/0750/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_xlconstant_1_0/sim/design_1_xlconstant_1_0.v" \

vcom -work lmb_bram_if_cntlr_v4_0_14 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/226d/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_dlmb_bram_if_cntlr_0/sim/design_1_dlmb_bram_if_cntlr_0.vhd" \

vcom -work lmb_v10_v3_0_9 -93 \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_dlmb_v10_0/sim/design_1_dlmb_v10_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_bram_if_cntlr_0/sim/design_1_ilmb_bram_if_cntlr_0.vhd" \
"../../../bd/design_1/ip/design_1_ilmb_v10_0/sim/design_1_ilmb_v10_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_lmb_bram_0/sim/design_1_lmb_bram_0.v" \

vlog -work generic_baseblocks_v2_1_0  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_15  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/3ed1/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_14  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_16  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_xbar_1/sim/design_1_xbar_1.v" \
"../../../bd/design_1/ip/design_1_xbar_0/sim/design_1_xbar_0.v" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/sim/design_1.vhd" \
"../../../bd/design_1/ipshared/a911/config.vhd" \
"../../../bd/design_1/ipshared/a911/common_pack.vhd" \
"../../../bd/design_1/ipshared/a911/acknowledger_AXI.vhd" \
"../../../bd/design_1/ipshared/a911/aggregator_AXI.vhd" \
"../../../bd/design_1/ipshared/a911/aggregator_AXIfull.vhd" \
"../../../bd/design_1/ipshared/a911/aggregator_MBTP.vhd" \
"../../../bd/design_1/ipshared/a911/bram_writer.vhd" \
"../../../bd/design_1/ipshared/a911/catcher.vhd" \
"../../../bd/design_1/ipshared/a911/comp_prog.vhd" \
"../../../bd/design_1/ipshared/a911/dcapf_AXI.vhd" \
"../../../bd/design_1/ipshared/a911/dcapf_axifull.vhd" \
"../../../bd/design_1/ipshared/a911/dcapf_branch_taken.vhd" \
"../../../bd/design_1/ipshared/a911/dci.vhd" \
"../../../bd/design_1/ipshared/a911/dispenser_dcapf.vhd" \
"../../../bd/design_1/ipshared/a911/eig_AXI.vhd" \
"../../../bd/design_1/ipshared/a911/eig_AXIfull.vhd" \
"../../../bd/design_1/ipshared/a911/eig_MBTP.vhd" \
"../../../bd/design_1/ipshared/a911/event_data_manager.vhd" \
"../../../bd/design_1/ipshared/a911/event_monitor.vhd" \
"../../../bd/design_1/ipshared/a911/filter.vhd" \
"../../../bd/design_1/ipshared/a911/init_dcapf.vhd" \
"../../../bd/design_1/ipshared/a911/lmic1.vhd" \
"../../../bd/design_1/ipshared/a911/mux2to1.vhd" \
"../../../bd/design_1/ipshared/a911/pipo_reg.vhd" \
"../../../bd/design_1/ipshared/a911/smart_counter.vhd" \
"../../../bd/design_1/ipshared/a911/smart_demux.vhd" \
"../../../bd/design_1/ipshared/a911/sniffer_AXI.vhd" \
"../../../bd/design_1/ipshared/a911/sniffer_AXIfull.vhd" \
"../../../bd/design_1/ipshared/a911/sniffer_MBTP.vhd" \
"../../../bd/design_1/ipshared/a911/time_monitor.vhd" \
"../../../bd/design_1/ipshared/a911/timing_capturer.vhd" \
"../../../bd/design_1/ipshared/a911/global_mon.vhd" \
"../../../bd/design_1/ip/design_1_global_mon_0_0/sim/design_1_global_mon_0_0.vhd" \

vlog -work axi_protocol_converter_v2_1_15  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ff69/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/4868" "+incdir+../../../../project_1.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" \
"../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

