# Makefile to run verilog simulations
#
# Targets:
#    "make compile"             compiles only
#    "make run"                 runs only
#    "make viewer"              starts waveform viewer
#    "make run_interactive"     starts simulation/debugging environment
#    "make run_interactive_2"   starts simulation/debugging environment
#    "make clean"               deletes temporary files and dirs
#
# Notes for ncverilog:
#
# Notes for vcs:
#  -Mdir     Temporary file space; can give a big speedup
#  -Mupdate  Incremental compile
#  -PP       Enables vcs to work with vcd+ files
#  -R        Run executable after compiling and linking
#  -RI       Bring up interactive GUI after compiling and linking
#  -RPP      Run post-processing mode; starts virsim
#
# A few notes on writing a Makefile
#  - Make sure commands are preceded by a "tab"; spaces will not work!
#  - You may also add dependencies so that a command will execute only
#    if the dependency has been updated more recently than the target
#    (name the target with the same name as the output of the command(s)).
#  - Use a "-n" flag to see what make will use without running the
#    command(s).  Ex: "make -n clean"
#
# 2005/02/03  Added verilog (verilog XL) targets
# 2005/01/20  Added ncverilog targets
# 2004/03/09  Added $(NAME_TOP) variable
# 2004/02/03  Added cleanall target
# 2004/01/22  Updated
# 2003/05/27  Added "-l" logfiles
# 2003/05/12  Improved and now works for standalone sims and viewer
# 2003/04/18  Set up for homework 2





NAME_TOP	:= pipe_mul
USERNAME	:= $(shell whoami)
DIR_TMP		:= /tmp/$(USERNAME)verilog

##	@echo 
##	@echo "Make targets:"
##	@echo "  make check                    compile default with Verilog XL"
##	@echo "  make NAME=abc check           compile files in 'abc.vf'"
##	@echo "  make NAME=abc new_compile     make new dc-abc.tcl"
##	@echo "  make compile                  synthesize default module"
##	@echo "  make NAME=abc compile         synthesize module 'abc'"
##	@echo 
##	@echo "Basic synthesis procedure for top-level module 'abc':"
##	@echo "  1) add all submodules to file abc.vf"
##	@echo "  2) 'make NAME=abc check'"
##	@echo "  3) 'make NAME=abc new_compile'"
##	@echo "  4) add appropriate 'analyze' commands to dc-abc.tcl"
##	@echo "  5) 'make NAME=abc compile'"
##	@echo 
##	@echo "  You can also change 'foo' to 'abc' in 'Makefile' to avoid"
##	@echo "      typing 'NAME' variable each time"
##	@echo 
##	@echo "  1) change 'NAME := foo' to 'NAME := abc' in Makefile"
##	@echo "  2) add all submodules to file abc.vf"
##	@echo "  3) 'make check'"
##	@echo "  4) 'make new_compile'"
##	@echo "  5) add appropriate 'analyze' commands to dc-abc.tcl"
##	@echo "  6) 'make compile'"
##	@echo 

#----- Targest, DC Synthesis
# Use this to check for verilog bugs.  Put all files in a ".vf" file.

##check:
##	verilog -c -l $(NAME_TOP).log -f $(NAME_TOP).vf
##
##new_dccomp:
##	sed s/prac/$(NAME_TOP)/ < dc-template.tcl > dc-$(NAME_TOP).tcl
##
##dccomp:
##	dc_shell-t -f dc-$(NAME_TOP).tcl | tee $(NAME_TOP).log
##	grep -v '^Warning:.*Intraassignment delays for nonblocking assignments are ignored. (VER-130)' $(NAME).log > $(NAME).log.clean
##
##dcclean:
##	rm -f  *.mr
##	rm -f  *-verilog.pvl
##	rm -f  *-verilog.syn
##	rm -f  default.svf
##	rm -fr simv.daidir/
##	rm -fr $(DIR_TMP)
##
##dccleanall: clean
##	rm -f $(NAME_TOP).area
##	rm -f $(NAME_TOP).cell
##	rm -f $(NAME_TOP).db
##	rm -f $(NAME_TOP).hier
##	rm -f $(NAME_TOP).log
##	rm -f $(NAME_TOP).log.clean
##	rm -f $(NAME_TOP).net
##	rm -f $(NAME_TOP).pow
##	rm -f $(NAME_TOP).tim
##	rm -f $(NAME_TOP).vg
##	rm -f $(NAME_TOP).dsn
##	rm -f $(NAME_TOP).trn
##	rm -f $(NAME_TOP).vpd
##	rm -f command.log

#----- Targets, ncverilog
# Use this to compile without running simulation
compile:
	vcs -full64 -o $(NAME_TOP) $(NAME_TOP).v $(NAME_TOP)_tb.v


# Run simulation
run:
	./$(NAME_TOP)

# Start viewer
viewer:
	dve -full64 &

# ncverilog help, command line
help:
	vcs -h | less -Mq

#----- Targets, verilog-XL
# Use this to compile without running simulation
compile_xl:
	verilog -c        -l $(NAME_TOP).log -f $(NAME_TOP).vf

# Run simulation
run_xl:
	verilog +access+r -l $(NAME_TOP).log -f $(NAME_TOP).vf

#----- Cleanup
# Delete temporary files
clean:
	rm -f  $(NAME_TOP)
	rm -rf simv.daidir
	rm -rf csrc
	rm -rf DVEfiles
	rm -rf ucli.key
	rm -rf opendatabase.log
	rm -f  $(NAME_TOP)_tb.dump
	rm -f  $(NAME_TOP)_tb.dump.vpd
	rm -rf $(NAME_TOP).daidir
	rm -rf simv

cleanall: clean
	rm -f  $(NAME_TOP).log
	rm -f  $(NAME_TOP).dsn
	rm -f  $(NAME_TOP).trn
	rm -f  $(NAME_TOP).vpd


#----- Targets, vcs  (apparently broken)
# Use this to compile without running simulation
compile_vcs:
	vcs -Mdir=$(DIR_TMP) -Mupdate -PP -C +v2k -f $(NAME_TOP).vf

# Use these two targets to run vcs separately from viewer
run_vcs:
	vcs -Mdir=$(DIR_TMP) -Mupdate -PP -R -f $(NAME_TOP).vf \
	-l $(NAME_TOP).log

viewer_vcs:
	vcs -RPP &

# Use this to run and view waveform in an integrated environment
run_interactive_vcs:
	vcs -RI +v2k -f $(NAME_TOP).vf -l $(NAME_TOP).log &

run_interactive_2_vcs:
	vcs -RI +v2k -Mupdate -f $(NAME_TOP).vf -l $(NAME_TOP).log &

# VCS help
help_vcs:
	vcs -full64 -help | less -Mq