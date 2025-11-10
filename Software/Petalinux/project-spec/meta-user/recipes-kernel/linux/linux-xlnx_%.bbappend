FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KERNEL_FEATURES:append = " bsp.cfg"

SRC_URI:append = " file://bsp.cfg \
             file://0001-cmac-100G.patch \
	     file://revert_xilinx_axienet_to_2024_1.patch \
	     file://2024_2_fixes.patch \
         "
