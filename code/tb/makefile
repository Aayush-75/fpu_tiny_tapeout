#for easy modification TOP_FILE = top.sv
TOP_FILE = top.sv
TESTNAME = normal_addition_test
COV_FLAGS = -cm line+cond+fsm+tgl+branch+assert

.PHONY: all compile sim cov wave clean git start

.DEFAULT_GOAL := all

# 1. Run the entire flow (Compile, Sim, Coverage)
all: compile sim cov

start:
	/bin/csh -c "source /fetools/synopsys/source/source.sh && exec /bin/csh"

# 2. Compile the design
# Note: Added -kdb for Verdi integration and FSDB dumping support
compile:
	vcs -full64 -sverilog -timescale=1ns/1ps -ntb_opts uvm-1.2 \
	-debug_access+all -kdb $(COV_FLAGS) -l compile.log $(TOP_FILE)

# 3. Run the Simulation
sim:
	./simv -l $(TESTNAME).log $(COV_FLAGS) +UVM_TESTNAME=$(TESTNAME)

#4. Generate the HTML Coverage Report
cov:
	urg -full64 -dir simv.vdb -report covReport

# 5. Open the Waveform in Verdi
wave:
	verdi -ssf wave.fsdb &

# Clean up generated files to start fresh
clean:
	rm -rf simv* csrc* *.log *.vpd *.fsdb *.vdb covReport ucli.key verdiLog novas*

git:
	@echo "Enter your git commit message:"; \
	read msg; \
	git add *.sv; \
	git commit -m "$$msg"; \
	git push
