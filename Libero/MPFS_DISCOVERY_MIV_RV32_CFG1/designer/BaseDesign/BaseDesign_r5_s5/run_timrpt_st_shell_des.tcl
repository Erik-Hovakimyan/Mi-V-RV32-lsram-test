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
set_def USE_CONSTRAINTS_FLOW 1
set_name BaseDesign
set_workdir {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign}
set_design_state post_layout
set_operating_conditions -name slow_lv_lt
set_operating_conditions -name fast_hv_lt
set_operating_conditions -name slow_lv_ht
