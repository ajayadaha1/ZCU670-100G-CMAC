# ZCU670 100G CAUI-4 v2024.2 with RS-FEC Disabled
---
## **Design Summary**
This project utilizes 100G CMAC. This has been routed to all 4 SFPs on a ZCU670 board. System is configured to use the ZCU670 si570 at 156.25MHz.

- `end0` is configured as GEM3 routed via RGMII to the on-board PHY.
- `eth0` is configured as 100G Ethernet Subsystem routed to 4xSFPs.

---
## **Required Hardware**
- ZCU670
- 4xSFP supporting 100G CAUI-4
- 100G capable link partner with RS-FEC disabled
---
## **Build Instructions**
### **Vivado:**

Enter the `Scripts` directory. From the command line run the following:

`vivado -source *top.tcl`

The Vivado project will be built in the `Hardware` directory.

### **Vitis**:
There is currently no baremetal Vitis support for the 100G IP.

### **PetaLinux**:
Enter the `Software/PetaLinux/` directory. From the command line run the following:
`xsct sdt.tcl ../../Hardware/prebuilt/pl_eth_100g_wrapper.xsa sdt_outdir` 
`petalinux-config --get-hw-description ./sdt_outdir/ --silentconfig`

followed by:
`petalinux-build`

The PetaLinux project will be rebuilt using the configurations in the PetaLinux directory. To reduce repo size, the project is shipped pre-configured, but un-built.

Once the build is complete, the built images can be found in the `PetaLinux/images/linux/`
directory. To package these images for SD boot, run the following from the `PetaLinux` directory:

`petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --fpga images/linux/*.bit --pmufw images/linux/pmufw.elf --u-boot --force`

Once packaged, the `BOOT.bin`, `boot.scr` and `image.ub` files (in the `PetaLinux/images/linux` directory) can be copied to an SD card, and used to boot.

---
## **Validation**
### **Kernel:**
**NOTE:** The interfaces are assigned as follows:
 - `end0` -> 1G
 - `eth0` -> 100G
```
xilinx-zcu670-20242:/home/petalinux# ifconfig eth0 192.168.1.1
xilinx-zcu670-20242:/home/petalinux# ping -A -q -w 3 -I eth0 192.168.1.2
PING 192.168.1.2 (192.168.1.2): 56 data bytes

--- 192.168.1.2 ping statistics ---
52704 packets transmitted, 52704 packets received, 0% packet loss
round-trip min/avg/max = 0.044/0.056/0.537 ms
```

---
### **Performance:**
**NOTE:** These are rough performance numbers - your actual performance may vary based on a variety of factors such as network topology and kernel load.

These performance numbers reflect an MTU of 1500.
```
xilinx-zcu670-20242:/home/petalinux# iperf3 -c 192.168.1.2 -i eth0
Connecting to host 192.168.1.2, port 5201
[  5] local 192.168.1.1 port 44720 connected to 192.168.1.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-10.01  sec  1.62 GBytes  1.39 Gbits/sec    0    259 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.01  sec  1.62 GBytes  1.39 Gbits/sec    0             sender
[  5]   0.00-10.01  sec  1.62 GBytes  1.39 Gbits/sec                  receiver

iperf Done.
xilinx-zcu670-20242:/home/petalinux#

vck190-1x100g-mrmac:/home/petalinux# iperf3 -s

Accepted connection from 192.168.1.1, port 44704
[  5] local 192.168.1.2 port 5201 connected to 192.168.1.1 port 44720
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   164 MBytes  1.37 Gbits/sec
[  5]   1.00-2.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   2.00-3.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   3.00-4.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   4.00-5.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   5.00-6.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   6.00-7.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   7.00-8.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   8.00-9.00   sec   166 MBytes  1.39 Gbits/sec
[  5]   9.00-10.00  sec   166 MBytes  1.39 Gbits/sec
[  5]  10.00-10.01  sec  1.75 MBytes  1.41 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.01  sec  1.62 GBytes  1.39 Gbits/sec                  receiver
```
---
## **Known Issues**

Some link partner might require RS-FEC to be enabled. The provided design has RS-FEC enabled. The driver patch does not have RS-FEC enabled, if needed it can be enabled during runtime by writing to register 0x1000 and 0x107c. Please refer to PG203 Chapter 6 - Register Space for more details. 

---

### Copyright 2025 AMD-Xilinx Inc.
### Copyright &copy; 2025, Advanced Micro Devices, Inc.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0

---
