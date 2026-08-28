# =============================================================================
# Makefile for SPI Controller UVM Testbench
#
# Supported Simulators:
#   Questa - Siemens Questa / Mentor QuestaSim
#   VCS    - Synopsys VCS
# =============================================================================

SIMULATOR = Questa

# -----------------------------------------------------------------------------
# Environment / Paths
# -----------------------------------------------------------------------------

RTL       = ../rtl/*
SVTB1     = ../tb/top.sv
SVTB2     = ../test/pkg.sv

INC       = +incdir+../tb \
            +incdir+../test \
            +incdir+../spi_agent \
            +incdir+../apb_agent

WORK      = work

FSDB_PATH = /home/cad/eda/SYNOPSYS/verdi_vX-2025.06/verdi/X-2025.06/share/PLI/VCS/LINUX64


# -----------------------------------------------------------------------------
# Questa Options
# -----------------------------------------------------------------------------

VSIMOPT    = -vopt -voptargs=+acc
VSIMCOV    = -coverage -sva
VSIMBATCH  = -c -do "log -r /* ; coverage save -onexit %s ; run -all ; exit"


# -----------------------------------------------------------------------------
# Test Names
# -----------------------------------------------------------------------------

TEST1  = cpol0_cpha0_lsbfe0_test
TEST2  = cpol0_cpha1_lsbfe0_test
TEST3  = cpol1_cpha0_lsbfe0_test
TEST4  = cpol1_cpha1_lsbfe0_test
TEST5  = cpol0_cpha0_lsbfe1_test
TEST6  = cpol0_cpha1_lsbfe1_test
TEST7  = cpol1_cpha0_lsbfe1_test
TEST8  = cpol1_cpha1_lsbfe1_test
TEST9  = low_power_test

TEST10 = cpol0_cpha0_lsbfe0_vtest
TEST11 = cpol0_cpha1_lsbfe0_vtest
TEST12 = cpol1_cpha0_lsbfe0_vtest
TEST13 = cpol1_cpha1_lsbfe0_vtest
TEST14 = cpol0_cpha0_lsbfe1_vtest
TEST15 = cpol0_cpha1_lsbfe1_vtest
TEST16 = cpol1_cpha0_lsbfe1_vtest
TEST17 = cpol1_cpha1_lsbfe1_vtest
TEST18 = low_power_vtest


# -----------------------------------------------------------------------------
# Fixed Seeds
#
# Same seeds are used for both Questa and VCS.
# -----------------------------------------------------------------------------

SEED1  = 2472023074
SEED2  = 2969046076
SEED3  = 3981970915
SEED4  = 4017622352
SEED5  = 3092813256
SEED6  = 1482201544
SEED7  = 3981970915
SEED8  = 4017622352
SEED9  = 4017622352

SEED10 = 2472023074
SEED11 = 2969046076
SEED12 = 3981970915
SEED13 = 4017622352
SEED14 = 3092813256
SEED15 = 1482201544
SEED16 = 3981970915
SEED17 = 4017622352
SEED18 = 4017622352


# =============================================================================
# Generic Targets
# =============================================================================

help:
	@echo "======================================================================"
	@echo " SPI Controller UVM Testbench"
	@echo "======================================================================"
	@echo " Usage:"
	@echo "   make sv_cmp       Compile the testbench"
	@echo "   make run_test     Run test 1"
	@echo "   make run_test1    Run test 2"
	@echo "   ..."
	@echo "   make run_test17   Run test 18"
	@echo "   make regress      Run all 18 tests"
	@echo "   make report       Merge coverage reports"
	@echo "   make cov          Open merged coverage report"
	@echo "   make view_wave1   View waveform for test 1"
	@echo "   ..."
	@echo "   make view_wave18  View waveform for test 18"
	@echo "   make clean        Clean generated files"
	@echo "======================================================================"

clean:
	$(MAKE) clean_$(SIMULATOR)

sv_cmp:
	$(MAKE) sv_cmp_$(SIMULATOR)

run_test:
	$(MAKE) run_test_$(SIMULATOR)

run_test1:
	$(MAKE) run_test1_$(SIMULATOR)

run_test2:
	$(MAKE) run_test2_$(SIMULATOR)

run_test3:
	$(MAKE) run_test3_$(SIMULATOR)

run_test4:
	$(MAKE) run_test4_$(SIMULATOR)

run_test5:
	$(MAKE) run_test5_$(SIMULATOR)

run_test6:
	$(MAKE) run_test6_$(SIMULATOR)

run_test7:
	$(MAKE) run_test7_$(SIMULATOR)

run_test8:
	$(MAKE) run_test8_$(SIMULATOR)

run_test9:
	$(MAKE) run_test9_$(SIMULATOR)

run_test10:
	$(MAKE) run_test10_$(SIMULATOR)

run_test11:
	$(MAKE) run_test11_$(SIMULATOR)

run_test12:
	$(MAKE) run_test12_$(SIMULATOR)

run_test13:
	$(MAKE) run_test13_$(SIMULATOR)

run_test14:
	$(MAKE) run_test14_$(SIMULATOR)

run_test15:
	$(MAKE) run_test15_$(SIMULATOR)

run_test16:
	$(MAKE) run_test16_$(SIMULATOR)

run_test17:
	$(MAKE) run_test17_$(SIMULATOR)

view_wave1:
	$(MAKE) view_wave1_$(SIMULATOR)

view_wave2:
	$(MAKE) view_wave2_$(SIMULATOR)

view_wave3:
	$(MAKE) view_wave3_$(SIMULATOR)

view_wave4:
	$(MAKE) view_wave4_$(SIMULATOR)

view_wave5:
	$(MAKE) view_wave5_$(SIMULATOR)

view_wave6:
	$(MAKE) view_wave6_$(SIMULATOR)

view_wave7:
	$(MAKE) view_wave7_$(SIMULATOR)

view_wave8:
	$(MAKE) view_wave8_$(SIMULATOR)

view_wave9:
	$(MAKE) view_wave9_$(SIMULATOR)

view_wave10:
	$(MAKE) view_wave10_$(SIMULATOR)

view_wave11:
	$(MAKE) view_wave11_$(SIMULATOR)

view_wave12:
	$(MAKE) view_wave12_$(SIMULATOR)

view_wave13:
	$(MAKE) view_wave13_$(SIMULATOR)

view_wave14:
	$(MAKE) view_wave14_$(SIMULATOR)

view_wave15:
	$(MAKE) view_wave15_$(SIMULATOR)

view_wave16:
	$(MAKE) view_wave16_$(SIMULATOR)

view_wave17:
	$(MAKE) view_wave17_$(SIMULATOR)

view_wave18:
	$(MAKE) view_wave18_$(SIMULATOR)

regress:
	$(MAKE) regress_$(SIMULATOR)

report:
	$(MAKE) report_$(SIMULATOR)

cov:
	$(MAKE) cov_$(SIMULATOR)


# =============================================================================
# QuestaSim
# =============================================================================

sv_cmp_Questa:
	vlib $(WORK)
	vmap work $(WORK)
	vlog -work $(WORK) $(RTL) $(INC) $(SVTB2) $(SVTB1)


# -----------------------------------------------------------------------------
# Questa Test Execution
# -----------------------------------------------------------------------------

run_test_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov1 ; run -all ; exit" \
		-wlf wave_file1.wlf -l test1.log \
		-sv_seed $(SEED1) \
		work.top +UVM_TESTNAME=$(TEST1)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov1

run_test1_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov2 ; run -all ; exit" \
		-wlf wave_file2.wlf -l test2.log \
		-sv_seed $(SEED2) \
		work.top +UVM_TESTNAME=$(TEST2)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov2

run_test2_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov3 ; run -all ; exit" \
		-wlf wave_file3.wlf -l test3.log \
		-sv_seed $(SEED3) \
		work.top +UVM_TESTNAME=$(TEST3)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov3

run_test3_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov4 ; run -all ; exit" \
		-wlf wave_file4.wlf -l test4.log \
		-sv_seed $(SEED4) \
		work.top +UVM_TESTNAME=$(TEST4)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov4

run_test4_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov5 ; run -all ; exit" \
		-wlf wave_file5.wlf -l test5.log \
		-sv_seed $(SEED5) \
		work.top +UVM_TESTNAME=$(TEST5)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov5

run_test5_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov6 ; run -all ; exit" \
		-wlf wave_file6.wlf -l test6.log \
		-sv_seed $(SEED6) \
		work.top +UVM_TESTNAME=$(TEST6)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov6

run_test6_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov7 ; run -all ; exit" \
		-wlf wave_file7.wlf -l test7.log \
		-sv_seed $(SEED7) \
		work.top +UVM_TESTNAME=$(TEST7)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov7

run_test7_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov8 ; run -all ; exit" \
		-wlf wave_file8.wlf -l test8.log \
		-sv_seed $(SEED8) \
		work.top +UVM_TESTNAME=$(TEST8)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov8

run_test8_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov9 ; run -all ; exit" \
		-wlf wave_file9.wlf -l test9.log \
		-sv_seed $(SEED9) \
		work.top +UVM_TESTNAME=$(TEST9)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov9

run_test9_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov10 ; run -all ; exit" \
		-wlf wave_file10.wlf -l test10.log \
		-sv_seed $(SEED10) \
		work.top +UVM_TESTNAME=$(TEST10)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov10

run_test10_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov11 ; run -all ; exit" \
		-wlf wave_file11.wlf -l test11.log \
		-sv_seed $(SEED11) \
		work.top +UVM_TESTNAME=$(TEST11)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov11

run_test11_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov12 ; run -all ; exit" \
		-wlf wave_file12.wlf -l test12.log \
		-sv_seed $(SEED12) \
		work.top +UVM_TESTNAME=$(TEST12)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov12

run_test12_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov13 ; run -all ; exit" \
		-wlf wave_file13.wlf -l test13.log \
		-sv_seed $(SEED13) \
		work.top +UVM_TESTNAME=$(TEST13)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov13

run_test13_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov14 ; run -all ; exit" \
		-wlf wave_file14.wlf -l test14.log \
		-sv_seed $(SEED14) \
		work.top +UVM_TESTNAME=$(TEST14)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov14

run_test14_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov15 ; run -all ; exit" \
		-wlf wave_file15.wlf -l test15.log \
		-sv_seed $(SEED15) \
		work.top +UVM_TESTNAME=$(TEST15)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov15

run_test15_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov16 ; run -all ; exit" \
		-wlf wave_file16.wlf -l test16.log \
		-sv_seed $(SEED16) \
		work.top +UVM_TESTNAME=$(TEST16)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov16

run_test16_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov17 ; run -all ; exit" \
		-wlf wave_file17.wlf -l test17.log \
		-sv_seed $(SEED17) \
		work.top +UVM_TESTNAME=$(TEST17)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov17

run_test17_Questa: sv_cmp_Questa
	vsim -cvgperinstance $(VSIMOPT) $(VSIMCOV) \
		-c -do "log -r /* ; coverage save -onexit mem_cov18 ; run -all ; exit" \
		-wlf wave_file18.wlf -l test18.log \
		-sv_seed $(SEED18) \
		work.top +UVM_TESTNAME=$(TEST18)
	vcover report -cvg -details -nocompactcrossbins -codeAll -assert -directive -html mem_cov18


# -----------------------------------------------------------------------------
# Questa Waveform Viewing
# -----------------------------------------------------------------------------

view_wave1_Questa:
	vsim -view wave_file1.wlf

view_wave2_Questa:
	vsim -view wave_file2.wlf

view_wave3_Questa:
	vsim -view wave_file3.wlf

view_wave4_Questa:
	vsim -view wave_file4.wlf

view_wave5_Questa:
	vsim -view wave_file5.wlf

view_wave6_Questa:
	vsim -view wave_file6.wlf

view_wave7_Questa:
	vsim -view wave_file7.wlf

view_wave8_Questa:
	vsim -view wave_file8.wlf

view_wave9_Questa:
	vsim -view wave_file9.wlf

view_wave10_Questa:
	vsim -view wave_file10.wlf

view_wave11_Questa:
	vsim -view wave_file11.wlf

view_wave12_Questa:
	vsim -view wave_file12.wlf

view_wave13_Questa:
	vsim -view wave_file13.wlf

view_wave14_Questa:
	vsim -view wave_file14.wlf

view_wave15_Questa:
	vsim -view wave_file15.wlf

view_wave16_Questa:
	vsim -view wave_file16.wlf

view_wave17_Questa:
	vsim -view wave_file17.wlf

view_wave18_Questa:
	vsim -view wave_file18.wlf


# -----------------------------------------------------------------------------
# Questa Regression / Coverage
# -----------------------------------------------------------------------------

regress_Questa: clean_Questa sv_cmp_Questa \
	run_test_Questa run_test1_Questa run_test2_Questa run_test3_Questa \
	run_test4_Questa run_test5_Questa run_test6_Questa run_test7_Questa \
	run_test8_Questa run_test9_Questa run_test10_Questa run_test11_Questa \
	run_test12_Questa run_test13_Questa run_test14_Questa run_test15_Questa \
	run_test16_Questa run_test17_Questa report_Questa

report_Questa:
	vcover merge mem_cov \
		mem_cov1 mem_cov2 mem_cov3 mem_cov4 mem_cov5 mem_cov6 \
		mem_cov7 mem_cov8 mem_cov9 mem_cov10 mem_cov11 mem_cov12 \
		mem_cov13 mem_cov14 mem_cov15 mem_cov16 mem_cov17 mem_cov18
	vcover report -cvg -details -nocompactcrossbins \
		-codeAll -assert -directive -html mem_cov

cov_Questa:
	firefox covhtmlreport/index.html &

clean_Questa:
	rm -rf transcript* *.log fcover* covhtml* mem_cov* \
		*.wlf modelsim.ini work wlf* *.vstf
	clear


# =============================================================================
# VCS
# =============================================================================

sv_cmp_VCS:
	vcs -l vcs.log \
		-timescale=1ns/1ps \
		-sverilog \
		-ntb_opts uvm \
		-debug_access+all \
		-full64 \
		-kdb \
		-lca \
		-P $(FSDB_PATH)/novas.tab \
		   $(FSDB_PATH)/pli.a \
		$(RTL) $(INC) $(SVTB2) $(SVTB1)


# -----------------------------------------------------------------------------
# VCS Test Execution
# -----------------------------------------------------------------------------

run_test_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave1.fsdb \
		-cm_dir ./mem_cov1 \
		+ntb_random_seed=$(SEED1) \
		+UVM_TESTNAME=$(TEST1)
	urg -dir mem_cov1.vdb -format both -report urgReport1

run_test1_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave2.fsdb \
		-cm_dir ./mem_cov2 \
		+ntb_random_seed=$(SEED2) \
		+UVM_TESTNAME=$(TEST2)
	urg -dir mem_cov2.vdb -format both -report urgReport2

run_test2_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave3.fsdb \
		-cm_dir ./mem_cov3 \
		+ntb_random_seed=$(SEED3) \
		+UVM_TESTNAME=$(TEST3)
	urg -dir mem_cov3.vdb -format both -report urgReport3

run_test3_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave4.fsdb \
		-cm_dir ./mem_cov4 \
		+ntb_random_seed=$(SEED4) \
		+UVM_TESTNAME=$(TEST4)
	urg -dir mem_cov4.vdb -format both -report urgReport4

run_test4_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave5.fsdb \
		-cm_dir ./mem_cov5 \
		+ntb_random_seed=$(SEED5) \
		+UVM_TESTNAME=$(TEST5)
	urg -dir mem_cov5.vdb -format both -report urgReport5

run_test5_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave6.fsdb \
		-cm_dir ./mem_cov6 \
		+ntb_random_seed=$(SEED6) \
		+UVM_TESTNAME=$(TEST6)
	urg -dir mem_cov6.vdb -format both -report urgReport6

run_test6_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave7.fsdb \
		-cm_dir ./mem_cov7 \
		+ntb_random_seed=$(SEED7) \
		+UVM_TESTNAME=$(TEST7)
	urg -dir mem_cov7.vdb -format both -report urgReport7

run_test7_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave8.fsdb \
		-cm_dir ./mem_cov8 \
		+ntb_random_seed=$(SEED8) \
		+UVM_TESTNAME=$(TEST8)
	urg -dir mem_cov8.vdb -format both -report urgReport8

run_test8_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave9.fsdb \
		-cm_dir ./mem_cov9 \
		+ntb_random_seed=$(SEED9) \
		+UVM_TESTNAME=$(TEST9)
	urg -dir mem_cov9.vdb -format both -report urgReport9

run_test9_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave10.fsdb \
		-cm_dir ./mem_cov10 \
		+ntb_random_seed=$(SEED10) \
		+UVM_TESTNAME=$(TEST10)
	urg -dir mem_cov10.vdb -format both -report urgReport10

run_test10_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave11.fsdb \
		-cm_dir ./mem_cov11 \
		+ntb_random_seed=$(SEED11) \
		+UVM_TESTNAME=$(TEST11)
	urg -dir mem_cov11.vdb -format both -report urgReport11

run_test11_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave12.fsdb \
		-cm_dir ./mem_cov12 \
		+ntb_random_seed=$(SEED12) \
		+UVM_TESTNAME=$(TEST12)
	urg -dir mem_cov12.vdb -format both -report urgReport12

run_test12_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave13.fsdb \
		-cm_dir ./mem_cov13 \
		+ntb_random_seed=$(SEED13) \
		+UVM_TESTNAME=$(TEST13)
	urg -dir mem_cov13.vdb -format both -report urgReport13

run_test13_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave14.fsdb \
		-cm_dir ./mem_cov14 \
		+ntb_random_seed=$(SEED14) \
		+UVM_TESTNAME=$(TEST14)
	urg -dir mem_cov14.vdb -format both -report urgReport14

run_test14_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave15.fsdb \
		-cm_dir ./mem_cov15 \
		+ntb_random_seed=$(SEED15) \
		+UVM_TESTNAME=$(TEST15)
	urg -dir mem_cov15.vdb -format both -report urgReport15

run_test15_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave16.fsdb \
		-cm_dir ./mem_cov16 \
		+ntb_random_seed=$(SEED16) \
		+UVM_TESTNAME=$(TEST16)
	urg -dir mem_cov16.vdb -format both -report urgReport16

run_test16_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave17.fsdb \
		-cm_dir ./mem_cov17 \
		+ntb_random_seed=$(SEED17) \
		+UVM_TESTNAME=$(TEST17)
	urg -dir mem_cov17.vdb -format both -report urgReport17

run_test17_VCS: sv_cmp_VCS
	./simv -a vcs.log \
		+fsdbfile+wave18.fsdb \
		-cm_dir ./mem_cov18 \
		+ntb_random_seed=$(SEED18) \
		+UVM_TESTNAME=$(TEST18)
	urg -dir mem_cov18.vdb -format both -report urgReport18


# -----------------------------------------------------------------------------
# VCS Waveform Viewing
# -----------------------------------------------------------------------------

view_wave1_VCS:
	verdi -ssf wave1.fsdb

view_wave2_VCS:
	verdi -ssf wave2.fsdb

view_wave3_VCS:
	verdi -ssf wave3.fsdb

view_wave4_VCS:
	verdi -ssf wave4.fsdb

view_wave5_VCS:
	verdi -ssf wave5.fsdb

view_wave6_VCS:
	verdi -ssf wave6.fsdb

view_wave7_VCS:
	verdi -ssf wave7.fsdb

view_wave8_VCS:
	verdi -ssf wave8.fsdb

view_wave9_VCS:
	verdi -ssf wave9.fsdb

view_wave10_VCS:
	verdi -ssf wave10.fsdb

view_wave11_VCS:
	verdi -ssf wave11.fsdb

view_wave12_VCS:
	verdi -ssf wave12.fsdb

view_wave13_VCS:
	verdi -ssf wave13.fsdb

view_wave14_VCS:
	verdi -ssf wave14.fsdb

view_wave15_VCS:
	verdi -ssf wave15.fsdb

view_wave16_VCS:
	verdi -ssf wave16.fsdb

view_wave17_VCS:
	verdi -ssf wave17.fsdb

view_wave18_VCS:
	verdi -ssf wave18.fsdb


# -----------------------------------------------------------------------------
# VCS Regression / Coverage
# -----------------------------------------------------------------------------

regress_VCS: clean_VCS sv_cmp_VCS \
	run_test_VCS run_test1_VCS run_test2_VCS run_test3_VCS \
	run_test4_VCS run_test5_VCS run_test6_VCS run_test7_VCS \
	run_test8_VCS run_test9_VCS run_test10_VCS run_test11_VCS \
	run_test12_VCS run_test13_VCS run_test14_VCS run_test15_VCS \
	run_test16_VCS run_test17_VCS report_VCS

report_VCS:
	urg -dir \
		mem_cov1.vdb mem_cov2.vdb mem_cov3.vdb mem_cov4.vdb \
		mem_cov5.vdb mem_cov6.vdb mem_cov7.vdb mem_cov8.vdb \
		mem_cov9.vdb mem_cov10.vdb mem_cov11.vdb mem_cov12.vdb \
		mem_cov13.vdb mem_cov14.vdb mem_cov15.vdb mem_cov16.vdb \
		mem_cov17.vdb mem_cov18.vdb \
		-dbname merged_dir/merged_test \
		-format both \
		-report urgReport

cov_VCS:
	verdi -cov -covdir merged_dir.vdb

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log \
		*hdrs.h urgReport* *.fsdb novas* verdi* \
		*report *.ini *.wlf *.vstf work mem_cov* merged_dir
	clear


# =============================================================================
# End of Makefile
# =============================================================================
