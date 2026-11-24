TOP_FILE = top.sv
TESTNAME = addition_8_write_test
SEEDS = 101 202 303 404
TESTS = reset_test \
        normal_addition_test \
        normal_subtraction_test \
        normal_inf_test \
        normal_overflow_test \
        normal_underflow_test \
        normal_zero_test \
        write_en_high_test \
        normal_NAN_test \
        reset_in_between_test \
        subnormal_test \
        operand1_zero_test \
        operand2_zero_test \
        signed_addition_test \
        addition_8_write_test \
        read_delay_test \
        ena_toggle_test \
        read_only_test \
        write_read_11_test \
        normalization_test \
        write_busy_test \
        error_recover_test \
        start_pulse_test \
        multiple_addition_test \
        add_sub_test \
		read_busy_test \
		write_read_busy_test \
		start_busy_test \
		start_before_ready_test \
		incomplete_operand_test \
		six_write_test \
		read_high_try_write_test \
		read_high_write_test \
		write_high_read_test \
		read_before_busy_end_test \
		write_before_busy_end_test \
		start_before_busy_end_test


COV_FLAGS = -cm line+cond+fsm+tgl+branch+assert

.PHONY: all c s all_case regr check cov wave clean git start

.DEFAULT_GOAL := all

# 1. Run the entire single-test flow (Compile, Sim, Coverage)
all: c s cov

start:
	/bin/csh -c "setenv VCS_LIC_WAIT 1; source /fetools/synopsys/source/source.sh && exec /bin/csh"

# 2. Compile the design
c:
	vcs -full64 -sverilog -timescale=1ns/1ps -ntb_opts uvm-1.2 \
	+vcs+lic+wait -debug_access+all -kdb $(COV_FLAGS) -l compile.log $(TOP_FILE)

# 3. Run a Single Simulation (uses TESTNAME)
s:
	./simv -l $(TESTNAME).log $(COV_FLAGS) -cm_name $(TESTNAME) +UVM_TESTNAME=$(TESTNAME)

# 4. Run Full Regression (uses TESTS)
all_case: c
	@for t in $(TESTS); do \
		echo "========================================"; \
		echo "Running test: $$t"; \
		echo "========================================"; \
		./simv -l $$t.log $(COV_FLAGS) -cm_name $$t +UVM_TESTNAME=$$t; \
	done

# 5. Run Multi-Seed Regression (4 seeds per test)
regr: c
	@for t in $(TESTS); do \
		for seed in $(SEEDS); do \
			echo "========================================"; \
			echo "Running test: $$t | Seed: $$seed"; \
			echo "========================================"; \
			./simv -l $${t}_$${seed}.log $(COV_FLAGS) -cm_name $${t}_$${seed} +ntb_random_seed=$$seed +UVM_TESTNAME=$$t; \
		done; \
	done

# 6. Check all .log files for "FAIL" and print matching filenames
check:
	@echo "=== Logs with FAIL ==="
	@grep -lw "FAIL" *.log || echo "No FAIL found in any .log file!"

# 7. Generate the HTML Coverage Report (auto-merges all -cm_name runs in simv.vdb)
cov:
	urg -full64 -dir simv.vdb -report covReport

# 8. Open the Waveform in Verdi
wave:
	verdi -ssf wave.fsdb &

# 9. Clean up generated files to start fresh
clean:
	rm -rf simv* csrc* *.log *.vpd *.fsdb *.vdb covReport ucli.key verdiLog novas*

# 10. git
git:
	@echo "Enter your git commit message:"; \
	read msg; \
	git add *.sv ../rtl/*.v makefile; \
	git commit -m "$$msg"; \
	git push
