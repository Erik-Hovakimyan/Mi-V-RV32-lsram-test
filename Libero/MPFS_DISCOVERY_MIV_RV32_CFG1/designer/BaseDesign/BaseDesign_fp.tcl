new_project \
         -name {BaseDesign} \
         -location {C:\polarfire-soc-discovery-kit-reference-design_REPO_N2\MPFS_DISCOVERY_MIV_RV32_CFG1\designer\BaseDesign\BaseDesign_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {MPFS095T} \
         -name {MPFS095T}
enable_device \
         -name {MPFS095T} \
         -enable {TRUE}
save_project
close_project
