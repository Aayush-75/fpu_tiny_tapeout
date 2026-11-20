`include "interface.sv"
`include "pkg.sv"
`include "../rtl/project.v"
`include "../rtl/fpu_core.v"
`include "checker.sv"

module top;

    import uvm_pkg::*;
	import pkg::*;

    bit clk;

    fpu_if DUV_IF(clk);

	bind syn_fifo tt_um_project_fpu fpu_assertions u_assert
	(
	.clk(clk),
    .rst_n(DUV_IF.rst_n),
    .ui_in(DUV_IF.ui_in),
    .uio_in(DUV_IF.uio_in),
    .uio_out(DUV_IF.uio_out),
    .uio_oe(DUV_IF.uio_oe),
    .ena(DUV_IF.ena),
    .uo_out(DUV_IF.uo_out)
	);

    tt_um_project_fpu#(.EXP_W(`EXP_W),.MAN_W(`MAN_W))
    m1 (
    .clk(clk),
    .rst_n(DUV_IF.rst_n),
    .ui_in(DUV_IF.ui_in),
    .uio_in(DUV_IF.uio_in),
    .uio_out(DUV_IF.uio_out),
    .uio_oe(DUV_IF.uio_oe),
    .ena(DUV_IF.ena),
    .uo_out(DUV_IF.uo_out)
    );

    initial
		forever
		   #40 clk=~clk; //40 ns = 25 Mhz

 	initial
	begin
	    uvm_config_db#(virtual fpu_if)::set(null,"*","vif",DUV_IF);
	    run_test("normal_addition_test");
	end
 	initial begin
		    $fsdbDumpfile("wave.fsdb");
		    $fsdbDumpvars(0, top);
	end

endmodule
