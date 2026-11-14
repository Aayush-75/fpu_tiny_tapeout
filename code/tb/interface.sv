interface fpu_if(input clk);

    /////////////input 
    logic rst_n;
    logic ena;

    logic [7:0]ui_in;
    logic [7:0]uio_in;
    ///////////////output 
    logic [7:0]uo_out;
    logic [7:0]uio_out;
    logic [7:0]uio_oe;

    clocking drv_cb@(posedge clk);
        default input #1 output #1;
        output ui_in,uio_in;
    endclocking

    clocking ip_mon_cb@(posedge clk);
        default input #1 output #1;
        input ui_in,uio_in;
    endclocking

    clocking op_mon_cb@(posedge clk);
        default input #1 output #1;
        input uo_out,uio_out,uio_oe;
    endclocking

    modport drv_mod(clocking drv_cb, input clk);
    modport ip_mon_mod(clocking ip_mon_cb, input clk);
    modport op_mon_mod(clocking op_mon_cb, input clk);

endinterface 
