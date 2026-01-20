set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_adl {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.adl}
read_afl {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.afl}
map_netlist
read_sdc {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\constraint\BaseDesign_derived_constraints.sdc}
read_sdc {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\constraint\io_jtag_constraints.sdc}
check_constraints {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\constraint\timing_sdc_errors.log}
estimate_jitter -report {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\timing_analysis_jitter_report.txt}
write_sdc -mode smarttime {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\timing_analysis.sdc}
