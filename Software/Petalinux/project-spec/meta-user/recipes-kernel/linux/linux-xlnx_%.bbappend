FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KERNEL_FEATURES:append = " bsp.cfg"

SRC_URI:append = " file://bsp.cfg \
         file://0001-100G-CMAC-driver-patch-without-RS-FEC.patch \
         "
