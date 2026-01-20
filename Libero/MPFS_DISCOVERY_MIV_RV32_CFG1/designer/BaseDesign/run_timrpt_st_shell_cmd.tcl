read_sdc -scenario "timing_analysis" -netlist "optimized" -pin_separator "/" -ignore_errors {C:/polarfire-soc-discovery-kit-reference-design_REPO_N2/MPFS_DISCOVERY_MIV_RV32_CFG1/designer/BaseDesign/timing_analysis.sdc}
set_options -analysis_scenario "timing_analysis" 
save
source {BaseDesign_run_timrpt_st_shell_txt.tcl}
