
set max_timing_multi_corner [report \
    -type     timing \
    -analysis max \
    -multi_corner yes \
    -format   text \
    {BaseDesign_timing_r45_s61.rpt}]
set max_timing_violations_multi_corner [report \
    -type     timing_violations \
    -analysis max \
    -multi_corner yes \
    -format   text \
    -use_slack_threshold no \
    -max_paths 100 \
    {BaseDesign_timing_violations_max_r45_s61.rpt}]
set min_timing_violations_multi_corner [report \
    -type     timing_violations \
    -analysis min \
    -multi_corner yes \
    -format   text \
    -use_slack_threshold no \
    -max_paths 100 \
    {BaseDesign_timing_violations_min_r45_s61.rpt}]
set has_violations {BaseDesign_has_violations}
set fp [open $has_violations w]
puts $fp "_max_timing_violations_multi_corner $max_timing_violations_multi_corner"
puts $fp "_max_timing_multi_corner $max_timing_multi_corner"
puts $fp "_min_timing_violations_multi_corner $min_timing_violations_multi_corner"
close $fp
