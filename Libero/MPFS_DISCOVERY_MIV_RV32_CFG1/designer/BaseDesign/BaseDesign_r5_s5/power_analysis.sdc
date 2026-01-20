# Microchip Technology Inc.
# Date: 2026-Jan-07 11:26:00
# This file was generated based on the following SDC source files:
#   C:/polarfire-soc-discovery-kit-reference-design_REPO_N2/MPFS_DISCOVERY_MIV_RV32_CFG1/component/work/PF_CCC_C0/PF_CCC_C0_0/PF_CCC_C0_PF_CCC_C0_0_PF_CCC.sdc
# *** Any modifications to this file will be lost if derived constraints is re-run. ***
#

create_clock -name {REF_CLK} -period 20 [ get_ports { REF_CLK } ]
create_generated_clock -name {PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT0} -divide_by 1 -source [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT0 } ]

create_clock -name { TCK } \
-period 166.67 \
-waveform { 0 83.33 } \
[ get_ports { TCK } ]

# JTAG and Mi-V clocks are independent - adding asynchronous clock group
set_clock_groups -name {async1} -asynchronous -group [ get_clocks { PF_CCC_C0_0/PF_CCC_C0_0/pll_inst_0/OUT0 } ] -group [ get_clocks { TCK } ]
