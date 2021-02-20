proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "mm_accelerator" "NUM_INSTANCES" "DEVICE_ID"  "C_CFG_BASEADDR" "C_CFG_HIGHADDR" "C_MEM_BASEADDR" "C_MEM_HIGHADDR"
}
