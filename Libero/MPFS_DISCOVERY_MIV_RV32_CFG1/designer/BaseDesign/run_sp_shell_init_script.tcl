set_device \
    -family  PolarFireSoC \
    -die     PA5SOC095T \
    -package fcsg325 \
    -speed   -1 \
    -tempr   {EXT} \
    -voltr   {EXT}
set_def {VOLTAGE} {1.0}
set_def {VCCI_1.2_VOLTR} {EXT}
set_def {VCCI_1.5_VOLTR} {EXT}
set_def {VCCI_1.8_VOLTR} {EXT}
set_def {VCCI_2.5_VOLTR} {EXT}
set_def {VCCI_3.3_VOLTR} {EXT}
set_def {PLL_SUPPLY} {}
set_def {VPP_SUPPLY_25_33} {VPP_SUPPLY_33}
set_def {VDDAUX_SUPPLY_25_33} {VDDAUX_SUPPLY_25}
set_def USE_CONSTRAINTS_FLOW 1
set_netlist -afl {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.afl} -adl {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.adl}
set_placement   {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.loc}
set_routing     {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.seg}
set_sdcfilelist -sdc {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\constraint\BaseDesign_derived_constraints.sdc, C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\constraint\io_jtag_constraints.sdc}
