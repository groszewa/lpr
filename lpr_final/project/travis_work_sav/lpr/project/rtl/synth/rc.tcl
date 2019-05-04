set_attribute hdl_search_path {./} 
set_attribute lib_search_path {./}

set_attribute library [list gscl45nm.lib]

set current_design bm_4b_tb
set myFiles [list bm_tb.v]

read_hdl ${myFiles}
elaborate ${current_design}

check_design -unresolved
report timing -lint

# Synthesize the design to the target library
synthesize -to_mapped

write_hdl -mapped >  ${current_design}_netlist.v
report timing
report power

