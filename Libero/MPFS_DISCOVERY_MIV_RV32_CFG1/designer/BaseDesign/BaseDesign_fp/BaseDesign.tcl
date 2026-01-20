open_project -project {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign_fp\BaseDesign.pro}
enable_device -name {MPFS095T} -enable 1
set_programming_file -name {MPFS095T} -file {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign.ppd}
set_programming_action -action {PROGRAM} -name {MPFS095T} 
run_selected_actions
save_project
close_project
